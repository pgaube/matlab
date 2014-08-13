global M
global N

N=4
M=4

%Set range of dates
startyear = 1992;
startmonth = 10;
startday = 14;
endyear = 2008;
endmonth = 01;
endday = 23;


%construct date vector
startjd=date2jd(startyear,startmonth,startday)+.5;
endjd=date2jd(endyear,endmonth,endday)+.5;
mid_week_jdays=[startjd:7:endjd];
[year,month,day]=jd2jdate(mid_week_jdays);
for m=1:length(mid_week_jdays)
	yearday(m)=year(m)*1000+julian(month(m),day(m),year(m));
	dates(m)=(year(m)*10000)+(month(m)*100)+day(m);
end



load_path = '/Volumes/matlab/data/eddy/V3/ssh/'
[ssh,lon,lat]=read_ssh([load_path,'aviso_20080102.20x10_hp']);
lat=lat'*ones(1,length(lon));
lon=ones(length(lat(:,1)),1)*lon;

split_domain
rs=1:length(r1);
cs=1:length(c1);



beta=single(nan(length(lat),length(lon),5));
subset_ssh=single(nan(length(rs),length(cs),length(mid_week_jdays)));
S=single(nan(length(lat),length(lon)));
NumCov=S;
whos


for pp=1:M*N
    fprintf('\r|  Quadrant # %01u of %01u | \r',pp,M*N)
    fprintf('\n')
    
    eval(['r=r' num2str(pp) ';']);
    eval(['c=c' num2str(pp) ';']);
    for m=1:length(mid_week_jdays)
        fname = [load_path 'aviso_' num2str(dates(m)) '.20x10_hp'];
        fprintf('\r     io file %03u of %03u \r',m,length(mid_week_jdays))
        [ssh]=read_ssh(fname);
        subset_ssh(rs,cs,m)=single(ssh(r,c));
    end
    nump=length(rs)*length(cs);
    plac=1;
    for mm=1:length(rs)
        for nn=1:length(cs)
            rr=r(mm);
            rrs=rs(mm);
            cc=c(nn);
            ccs=cs(nn);
            fprintf('\r     Regressing Point %07u of %07u \r',plac,nump)
            plac=plac+1;
            [ny,beta(rr,cc,:),S(rr,cc),theta] = ...
                    harm_reg(mid_week_jdays,...
                             squeeze(subset_ssh(rrs,ccs,:)),...
                             2,...
                             2*pi/365.25);
            NumCov(rr,cc) = single(length(find(~isnan(squeeze(subset_ssh(rrs,ccs,:))))));
        end
    end  
    
    %{
    rands = cat(1,abs(round(randn(10,1)*100)),abs(round(randn(10,1)*1000)))
    for n = 1:length(rands)
    	plot(mid_week_jdays,squeeze(subset_lt_chl(rands(n),rands(n),:))));
    	hold on
    	plot(mid_week_jdays,squeeze((rands(n),rands(n),:))));
    %}
    
    fprintf('\n')
    save([load_path,'filtered_ssh_stuff'],'beta','S','NumCov','lat','lon',...
         'r*','c*','load_path','mid_week_jdays','subset_ssh')
    subset_ssh=single(nan(length(rs),length(cs), ...
                      length(mid_week_jdays)));

end

%{


%
% now that we have all the betas lets load each data file,
% again,
% and remove the seasonal cycle and append tth anomoly and
% day of seasonal cycle to each file
%

f=2*pi/365.25;



for m=1:length(mid_week_jdays)
    fprintf('\r     io file %03u of %03u \r',m,length(mid_week_jdays))
    fname = [load_path 'aviso_20080102' num2str(mid_week_jdays(m)) 'aviso_20080102.20x10_hp'];
    load(fname,'chl_week')
    SS = (beta(:,:,1)...
          +beta(:,:,2)*cos(f*mid_week_jdays(m))...
          +beta(:,:,4)*sin(f*mid_week_jdays(m))...
          +beta(:,:,3)*cos(2*f*mid_week_jdays(m))...
          +beta(:,:,5)*sin(2*f*mid_week_jdays(m)));
    chl_anom = log10(chl_week)-SS;
    flag = find(isnan(chl_week));
    chl_filled = log10(chl_week);
    chl_filled(flag) = SS(flag);
    eval(['save ', fname, ' -append chl_filled SS chl_anom']);
end
%}
