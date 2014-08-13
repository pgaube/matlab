clear all
%{

load /matlab/matlab/domains/air-sea_car_lat_lon
load /matlab/data/eddy/V4/air-sea_car_lat_lon_tracks

%[CAR_wek_a,CAR_wek_c]=mcomps('/matlab/data/eddy/V4/air-sea_car_lat_lon_tracks','nrw_ek_sample','n');
%[CAR_sst_a,CAR_sst_c]=mcomps('/matlab/data/eddy/V4/air-sea_car_lat_lon_tracks','nrbp26_sst_sample','n');
%[CAR_ssh_a,CAR_ssh_c]=mcomps('/matlab/data/eddy/V4/air-sea_car_lat_lon_tracks','nrssh_sample','n');
%[CAR_raw_a,CAR_raw_c]=mcomps('/matlab/data/eddy/V4/air-sea_car_lat_lon_tracks','nrraw_hp66_chl_sample','n');
[CAR_wek_crlg_a,CAR_wek_crlg_c]=mcomps('/matlab/data/eddy/V4/air-sea_car_lat_lon_tracks','nrhp_wek_crlg_week_sample','n');
%[CAR_crlg_a,CAR_crlg_c]=mcomps('/matlab/data/eddy/V4/air-sea_car_lat_lon_tracks','nrbp26_crlg_sample','n');
%[CAR_wek_sst_a,CAR_wek_sst_c]=mcomps('/matlab/data/eddy/V4/air-sea_car_lat_lon_tracks','nrhp_wek_sst_week_dtdn_sample','n');
%[CAR_wek_drift_a,CAR_wek_drift_c]=mcomps('/matlab/data/eddy/V4/air-sea_car_lat_lon_tracks','nrhp_wek_drift_week_sample','n');
%[CAR_wek_all_a,CAR_wek_all_c]=mcomps('/matlab/data/eddy/V4/air-sea_car_lat_lon_tracks','nrhp_wek_total_week_sample','n');
save -append CAR_comps 
return

%}
load CAR_comps
r=9:41;
c=9:41;



flc='CAR_crlg_c_with_ssh';
tmp = double(interp2(CAR_crlg_c.median(r,c),2));
tmp2 = double(interp2(CAR_ssh_c.median(r,c),2));
cplot_comps_cont_2_2(1e5*tmp,tmp2,-.5,.5,2,-100,100,'AVISO @MAiD@ u_g^ Cyclones',...
	['~/Documents/OSU/figures/air-sea/CAR_comps/',flc]) 
 
flc='CAR_crlg_a_with_ssh';
tmp = double(interp2(CAR_crlg_a.median(r,c),2));
tmp2 = double(interp2(CAR_ssh_a.median(r,c),2));
cplot_comps_cont_2_2(1e5*tmp,tmp2,-.5,.5,2,-100,100,'AVISO @MAiD@ u_g^ Anticyclones',...
	['~/Documents/OSU/figures/air-sea/CAR_comps/',flc]) 
	
flc='CAR_wek_crlg_c_with_wek_crlg';
tmp = double(interp2(CAR_wek_crlg_c.median(r,c),2));
tmp2 = double(interp2(CAR_wek_crlg_c.median(r,c),2));
cplot_comps_cont_2_2_bwr(tmp,tmp2,-5,5,1,-100,100,'AVISO Ekman Downwelling',...
	['~/Documents/OSU/figures/air-sea/CAR_comps/',flc]) 


fla='CAR_wek_crlg_a_with_wek_crlg';
tmp = double(interp2(CAR_wek_crlg_a.median(r,c),2));
tmp2 = double(interp2(CAR_wek_crlg_a.median(r,c),2));
cplot_comps_cont_2_2_bwr(tmp,tmp2,-5,5,1,-100,100,'AVISO Ekman Upwelling',...
	['~/Documents/OSU/figures/air-sea/CAR_comps/',fla]) 
	
%{
flc='CAR_wek_all_c_with_wek_all';
tmp = double(interp2(CAR_wek_all_c.median(r,c),2));
tmp2 = double(interp2(CAR_wek_all_c.median(r,c),2));
cplot_comps_cont_2_2_bwr(tmp,tmp2,-7,7,.5,-100,100,'combined Ekman Downwelling',...
	['~/Documents/OSU/figures/air-sea/CAR_comps/',flc]) 


fla='CAR_wek_all_a_with_wek_all';
tmp = double(interp2(CAR_wek_all_a.median(r,c),2));
tmp2 = double(interp2(CAR_wek_all_a.median(r,c),2));
cplot_comps_cont_2_2_bwr(tmp,tmp2,-7,7,.5,-100,100,'combined Ekman Upwelling',...
	['~/Documents/OSU/figures/air-sea/CAR_comps/',fla]) 	
%}
flc='CAR_wek_sst_c_with_wek_sst';
tmp = double(interp2(CAR_wek_sst_c.median(r,c),2));
tmp2 = double(interp2(CAR_wek_sst_c.median(r,c),2));
cplot_comps_cont_2_2_bwr(tmp,tmp2,-.1,.1,.01,-10,10,'SST-induced Ekman Downwelling',...
	['~/Documents/OSU/figures/air-sea/CAR_comps/',flc]) 


fla='CAR_wek_sst_a_with_wek_sst';
tmp = double(interp2(CAR_wek_sst_a.median(r,c),2));
tmp2 = double(interp2(CAR_wek_sst_a.median(r,c),2));
cplot_comps_cont_2_2_bwr(tmp,tmp2,-.1,.1,.01,-10,10,'SST-induced Ekman Upwelling',...
	['~/Documents/OSU/figures/air-sea/CAR_comps/',fla]) 

%{	
flc='CAR_wek_drift_c_with_wek_drift';
tmp = double(interp2(CAR_wek_drift_c.median(r,c),2));
tmp2 = double(interp2(CAR_wek_drift_c.median(r,c),2));
cplot_comps_cont_2_2_bwr(tmp,tmp2,-.1,.1,.01,-10,10,'Drift-induced Ekman Downwelling',...
	['~/Documents/OSU/figures/air-sea/CAR_comps/',flc]) 


fla='CAR_wek_drift_a_with_wek_drift';
tmp = double(interp2(CAR_wek_drift_a.median(r,c),2));
tmp2 = double(interp2(CAR_wek_drift_a.median(r,c),2));
cplot_comps_cont_2_2_bwr(tmp,tmp2,-.1,.1,.01,-10,10,'Drift-induced Ekman Upwelling',...
	['~/Documents/OSU/figures/air-sea/CAR_comps/',fla]) 

%}
flc='CAR_wek_c_with_wek';
tmp = double(interp2(CAR_wek_c.median(r,c),2));
tmp2 = double(interp2(CAR_wek_c.median(r,c),2));
cplot_comps_cont_2_2_bwr(tmp,tmp2,-.05,.05,.01,-1,1,'QuikSCAT Ekman Downwelling',...
	['~/Documents/OSU/figures/air-sea/CAR_comps/',flc]) 


fla='CAR_wek_a_with_wek';
tmp = double(interp2(CAR_wek_a.median(r,c),2));
tmp2 = double(interp2(CAR_wek_a.median(r,c),2));
cplot_comps_cont_2_2_bwr(tmp,tmp2,-.05,.05,.01,-1,1,'QuikSCAT Ekman Upwelling',...
	['~/Documents/OSU/figures/air-sea/CAR_comps/',fla]) 
	
flc='CAR_ssh_c_with_ssh';
tmp = double(interp2(CAR_ssh_c.median(r,c),2));
tmp2 = double(interp2(CAR_ssh_c.median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,-15,15,2,-100,100,'AVIGS SSH Cyclones',...
	['~/Documents/OSU/figures/air-sea/CAR_comps/',flc]) 
 
flc='CAR_ssh_a_with_ssh';
tmp = double(interp2(CAR_ssh_a.median(r,c),2));
tmp2 = double(interp2(CAR_ssh_a.median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,-15,15,2,-100,100,'AVIGS SSH Anticyclones',...
	['~/Documents/OSU/figures/air-sea/CAR_comps/',flc]) 
	
flc='CAR_sst_c_with_ssh';
tmp = double(interp2(CAR_sst_c.median(r,c),2));
tmp2 = double(interp2(CAR_ssh_c.median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,-.06,.06,2,-100,100,'NOAA SST Cyclones',...
	['~/Documents/OSU/figures/air-sea/CAR_comps/',flc]) 
 
flc='CAR_sst_a_with_ssh';
tmp = double(interp2(CAR_sst_a.median(r,c),2));
tmp2 = double(interp2(CAR_ssh_a.median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,-.06,.06,2,-100,100,'NOAA SST Anticyclones',...
	['~/Documents/OSU/figures/air-sea/CAR_comps/',flc]) 	
	
	return
flc='CAR_raw_c_with_wek';
tmp = double(interp2(CAR_raw_c.median(r,c),2));
tmp2 = double(interp2(CAR_wek_c.median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,-.03,.03,.05,-1,1,'GSM CHL Cyclones',...
	['~/Documents/OSU/figures/air-sea/CAR_comps/',flc]) 
 
flc='CAR_raw_a_with_ssh';
tmp = double(interp2(CAR_raw_a.median(r,c),2));
tmp2 = double(interp2(CAR_wek_a.median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,-.03,.03,.05,-1,1,'GSM CHL Anticyclones',...
	['~/Documents/OSU/figures/air-sea/CAR_comps/',flc]) 		