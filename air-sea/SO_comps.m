clear all
%{

load /matlab/matlab/domains/SO_lat_lon
load /matlab/data/eddy/V4/SO_lat_lon_tracks

%[SO_wek_a,SO_wek_c]=mcomps('/matlab/data/eddy/V4/SO_lat_lon_tracks','nrw_ek_sample','n');
%[SO_sst_a,SO_sst_c]=mcomps('/matlab/data/eddy/V4/SO_lat_lon_tracks','nrbp26_sst_sample','n');
%[SO_ssh_a,SO_ssh_c]=mcomps('/matlab/data/eddy/V4/SO_lat_lon_tracks','nrssh_sample','n');
%[SO_raw_a,SO_raw_c]=mcomps('/matlab/data/eddy/V4/SO_lat_lon_tracks','nrraw_hp66_chl_sample','n');
[SO_wek_crlg_a,SO_wek_crlg_c]=mcomps('/matlab/data/eddy/V4/SO_lat_lon_tracks','nrhp_wek_crlg_week_sample','n');
%[SO_wek_sst_a,SO_wek_sst_c]=mcomps('/matlab/data/eddy/V4/SO_lat_lon_tracks','nrhp_wek_sst_week_sample','n');
%[SO_wek_drift_a,SO_wek_drift_c]=mcomps('/matlab/data/eddy/V4/SO_lat_lon_tracks','nrhp_wek_drift_week_sample','n');
%[SO_wek_all_a,SO_wek_all_c]=mcomps('/matlab/data/eddy/V4/SO_lat_lon_tracks','nrhp_wek_total_week_sample','n');
save -append SO_comps 
return
%}

load SO_comps
r=9:41;
c=9:41;



flc='SO_wek_crlg_c_with_wek_crlg';
tmp = double(interp2(SO_wek_crlg_c.median(r,c),2));
tmp2 = double(interp2(SO_wek_crlg_c.median(r,c),2));
cplot_comps_cont_2_2_bwr(tmp,tmp2,-7,7,1,-100,100,'AVISO Ekman Downwelling',...
	['~/Documents/OSU/figures/air-sea/SO_comps/',flc]) 


fla='SO_wek_crlg_a_with_wek_crlg';
tmp = double(interp2(SO_wek_crlg_a.median(r,c),2));
tmp2 = double(interp2(SO_wek_crlg_a.median(r,c),2));
cplot_comps_cont_2_2_bwr(tmp,tmp2,-7,7,1,-100,100,'AVISO Ekman Upwelling',...
	['~/Documents/OSU/figures/air-sea/SO_comps/',fla]) 
	
flc='SO_wek_all_c_with_wek_all';
tmp = double(interp2(SO_wek_all_c.median(r,c),2));
tmp2 = double(interp2(SO_wek_all_c.median(r,c),2));
cplot_comps_cont_2_2_bwr(tmp,tmp2,-7,7,1,-100,100,'combined Ekman Downwelling',...
	['~/Documents/OSU/figures/air-sea/SO_comps/',flc]) 


fla='SO_wek_all_a_with_wek_all';
tmp = double(interp2(SO_wek_all_a.median(r,c),2));
tmp2 = double(interp2(SO_wek_all_a.median(r,c),2));
cplot_comps_cont_2_2_bwr(tmp,tmp2,-7,7,1,-100,100,'combined Ekman Upwelling',...
	['~/Documents/OSU/figures/air-sea/SO_comps/',fla]) 
	

flc='SO_wek_sst_c_with_wek_sst';
tmp = double(interp2(SO_wek_sst_c.median(r,c),2));
tmp2 = double(interp2(SO_wek_sst_c.median(r,c),2));
cplot_comps_cont_2_2_bwr(tmp,tmp2,-7,7,1,-10,10,'SST-induced Ekman Downwelling',...
	['~/Documents/OSU/figures/air-sea/SO_comps/',flc]) 


fla='SO_wek_sst_a_with_wek_sst';
tmp = double(interp2(SO_wek_sst_a.median(r,c),2));
tmp2 = double(interp2(SO_wek_sst_a.median(r,c),2));
cplot_comps_cont_2_2_bwr(tmp,tmp2,-7,7,1,-10,10,'SST-induced Ekman Upwelling',...
	['~/Documents/OSU/figures/air-sea/SO_comps/',fla]) 
return	
flc='SO_wek_drift_c_with_wek_drift';
tmp = double(interp2(SO_wek_drift_c.median(r,c),2));
tmp2 = double(interp2(SO_wek_drift_c.median(r,c),2));
cplot_comps_cont_2_2_bwr(tmp,tmp2,-.1,.1,.01,-10,10,'Drift-induced Ekman Downwelling',...
	['~/Documents/OSU/figures/air-sea/SO_comps/',flc]) 


fla='SO_wek_drift_a_with_wek_drift';
tmp = double(interp2(SO_wek_drift_a.median(r,c),2));
tmp2 = double(interp2(SO_wek_drift_a.median(r,c),2));
cplot_comps_cont_2_2_bwr(tmp,tmp2,-.1,.1,.01,-10,10,'Drift-induced Ekman Upwelling',...
	['~/Documents/OSU/figures/air-sea/SO_comps/',fla]) 
return
flc='SO_wek_c_with_wek';
tmp = double(interp2(SO_wek_c.median(r,c),2));
tmp2 = double(interp2(SO_wek_c.median(r,c),2));
cplot_comps_cont_2_2_bwr(tmp,tmp2,-.07,.07,.01,-1,1,'QuikSCAT Ekman Downwelling',...
	['~/Documents/OSU/figures/air-sea/SO_comps/',flc]) 


fla='SO_wek_a_with_wek';
tmp = double(interp2(SO_wek_a.median(r,c),2));
tmp2 = double(interp2(SO_wek_a.median(r,c),2));
cplot_comps_cont_2_2_bwr(tmp,tmp2,-.07,.07,.01,-1,1,'QuikSCAT Ekman Upwelling',...
	['~/Documents/OSU/figures/air-sea/SO_comps/',fla]) 
	
flc='SO_ssh_c_with_ssh';
tmp = double(interp2(SO_ssh_c.median(r,c),2));
tmp2 = double(interp2(SO_ssh_c.median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,-10,10,1,-100,100,'AVISO SSH Cyclones',...
	['~/Documents/OSU/figures/air-sea/SO_comps/',flc]) 
 
flc='SO_ssh_a_with_ssh';
tmp = double(interp2(SO_ssh_a.median(r,c),2));
tmp2 = double(interp2(SO_ssh_a.median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,-10,10,1,-100,100,'AVISO SSH Anticyclones',...
	['~/Documents/OSU/figures/air-sea/SO_comps/',flc]) 
	
flc='SO_sst_c_with_ssh';
tmp = double(interp2(SO_sst_c.median(r,c),2));
tmp2 = double(interp2(SO_ssh_c.median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,-.3,.3,1,-100,100,'NOAA SST Cyclones',...
	['~/Documents/OSU/figures/air-sea/SO_comps/',flc]) 
 
flc='SO_sst_a_with_ssh';
tmp = double(interp2(SO_sst_a.median(r,c),2));
tmp2 = double(interp2(SO_ssh_a.median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,-.3,.3,1,-100,100,'NOAA SST Anticyclones',...
	['~/Documents/OSU/figures/air-sea/SO_comps/',flc]) 	
	
flc='SO_raw_c_with_wek';
tmp = double(interp2(SO_raw_c.median(r,c),2));
tmp2 = double(interp2(SO_wek_c.median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,-.03,.03,.01,-1,1,'GSM CHL Cyclones',...
	['~/Documents/OSU/figures/air-sea/SO_comps/',flc]) 
 
flc='SO_raw_a_with_ssh';
tmp = double(interp2(SO_raw_a.median(r,c),2));
tmp2 = double(interp2(SO_wek_a.median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,-.03,.03,.01,-1,1,'GSM CHL Anticyclones',...
	['~/Documents/OSU/figures/air-sea/SO_comps/',flc]) 		