
%construct date vector for mid-week day
mid_week_jdays=[2452459:7:2454489];


%Set path and region
save_path = '/Volumes/matlab/data/ReynoldsSST/mat/'
load([save_path 'OI_25_30_' num2str(mid_week_jdays(1))],'sst_week','lon')

for m=1:length(mid_week_jdays)
	load([save_path 'OI_25_30_' num2str(mid_week_jdays(m))],'sst_week')
    lp=linx_smooth2d_f(sst_week,6,6);
    sm=linx_smooth2d_f(sst_week,2,2);
    bp26_sst=sm-lp;
    %gradt=sqrt(dfdx(lon,sst_week,.25).^2+dfdy(sst_week,.25).^2).*1e5;
    eval(['save -append ' save_path 'OI_25_30_' num2str(mid_week_jdays(m)) ...
	      ' bp*']);
	clear sst_week   gradt bp* lp   
end
