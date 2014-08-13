global M
global N

N=3
M=3

load_path = '/home/wallaby/data/pgaube/matlab/matlab/timor/modis_chl_4km/'
load([load_path,'CHL_4_W_2454321'])
lat=single(lat);
lon=single(lon);

split_domain
rs=1:length(r1);
cs=1:length(c1);



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
        fname = [load_path 'CHL_4_W_' num2str(mid_week_jdays(m)) '.mat'];
        fprintf('\r     io file %03u of %03u \r',m,length(mid_week_jdays))
        load(fname, 'chl_week')
        subset_lt_chl(rs,cs,m)=single(log10(chl_week(r,c)));
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
    
    %{
    rands = cat(1,abs(round(randn(10,1)*100)),abs(round(randn(10,1)*1000)))
    for n = 1:length(rands)
    	plot(mid_week_jdays,squeeze(subset_lt_chl(rands(n),rands(n),:))));
    	hold on
    	plot(mid_week_jdays,squeeze((rands(n),rands(n),:))));
    %}
    
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
    fname = [load_path 'CHL_4_W_' num2str(mid_week_jdays(m)) '.mat'];
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

