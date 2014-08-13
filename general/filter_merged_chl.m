global M
global N

N=3
M=3
%load last data record prior to running script

startyear = 2002;
startmonth = 07;
startday = 03; 
endyear = 2008;
endmonth = 01;
endday = 23;

%{
startyear = 2002;
startmonth = 06;
startday = 05;
endyear = 2008;
endmonth = 06;
endday = 11;
%}

%construct date vector
startjd=date2jd(startyear,startmonth,startday)-2.5;
endjd=date2jd(endyear,endmonth,endday)+3.5;
jdays=[startjd:endjd];

%construct date vector for mid-week day
mid_week_jdays=[startjd+6:7:endjd];



lat=single(lat);
lon=single(lon);

split_domain
rs=1:length(r1);
cs=1:length(c1);

load_path = '/Volumes/matlab/matlab/timor/merged_chl_mat/'


beta=single(nan(length(lat(:,1)),length(lat(1,:)),5));
subset_lt_chl=single(nan(length(rs),length(cs),length(mid_week_jdays)));
S=single(nan(length(lat(:,1)),length(lat(1,:))));
NumCov=S;


for pp=1:M*N
    fprintf('\r|  Quadrant # %01u of %01u | \r',pp,M*N)
    fprintf('\n')
    
    eval(['r=r' num2str(pp) ';']);
    eval(['c=c' num2str(pp) ';']);
    for m=1:length(mid_week_jdays)
        fname = [load_path 'CHL_X_W_' num2str(mid_week_jdays(m)-3) '.mat'];
        fprintf('\r     io file %03u of %03u \r',m,length(mid_week_jdays))
        load(fname, 'merged_chl_week')
        subset_lt_chl(rs,cs,m)=single(log10(merged_chl_week(r,c)));
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
                             squeeze(subset_lt_chl(rrs,ccs,:)),...
                             2,...
                             2*pi/365.25);
            NumCov(rr,cc) = single(length(find(~isnan(squeeze(subset_lt_chl(rrs,ccs,:))))));
        end
    end    
    fprintf('\n')
    save([load_path,'filtered_chl_stuff'],'beta','S','NumCov','lat','lon',...
         'r*','c*','load_path','mid_week_jdays','jdays','subset_lt_chl')
    subset_lt_chl=single(nan(length(rs),length(cs), ...
                      length(mid_week_jdays)));

end



%
% now that we have all the betas lets load each data file,
% again,
% and remove the seasonal cycle and append tth anomoly and
% day of seasonal cycle to each file
%

f=2*pi/365.25;



for m=1:length(mid_week_jdays)
    fprintf('\r     io file %03u of %03u \r',m,length(mid_week_jdays))
    fname = [load_path 'CHL_X_W_' num2str(mid_week_jdays(m)-3) '.mat'];
    load(fname,'merged_chl_week')
    SS = (beta(:,:,1)...
          +beta(:,:,2)*cos(f*mid_week_jdays(m))...
          +beta(:,:,4)*sin(f*mid_week_jdays(m))...
          +beta(:,:,3)*cos(2*f*mid_week_jdays(m))...
          +beta(:,:,5)*sin(2*f*mid_week_jdays(m)));
    chl_anom = log10(merged_chl_week)-SS;
    flag = find(isnan(merged_chl_week));
    chl_filled = loag10(merged_chl_week);
    chl_filled(flag) = SS(flag);
    eval(['save ', fname, ' -append chl_filled SS chl_anom']);
end


