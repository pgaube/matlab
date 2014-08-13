clear all
%{

load /matlab/matlab/domains/NORTH_lat_lon
load /matlab/data/eddy/V4/NORTH_lat_lon_tracks

%[NORTH_wek_a,NORTH_wek_c]=mcomps('/matlab/data/eddy/V4/NORTH_lat_lon_tracks','nrw_ek_sample','n');
%[NORTH_sst_a,NORTH_sst_c]=mcomps('/matlab/data/eddy/V4/NORTH_lat_lon_tracks','nrbp26_sst_sample','n');
[NORTH_ssh_a,NORTH_ssh_c]=mcomps('/matlab/data/eddy/V4/NORTH_lat_lon_tracks','nrssh_sample','n');
%[NORTH_raw_a,NORTH_raw_c]=mcomps('/matlab/data/eddy/V4/NORTH_lat_lon_tracks','nrraw_hp66_chl_sample','n');
%[NORTH_wek_crlg_a,NORTH_wek_crlg_c]=mcomps('/matlab/data/eddy/V4/NORTH_lat_lon_tracks','nrhp_wek_crlg_week_sample','n');
%[NORTH_wek_sst_a,NORTH_wek_sst_c]=mcomps('/matlab/data/eddy/V4/NORTH_lat_lon_tracks','nrhp_wek_sst_week_sample','n');
%[NORTH_wek_drift_a,NORTH_wek_drift_c]=mcomps('/matlab/data/eddy/V4/NORTH_lat_lon_tracks','nrhp_wek_drift_week_sample','n');
%[NORTH_wek_all_a,NORTH_wek_all_c]=mcomps('/matlab/data/eddy/V4/NORTH_lat_lon_tracks','nrhp_wek_total_week_sample','n');
%[NORTH_gradt_a,NORTH_gradt_c]=mcomps('/matlab/data/eddy/V4/NORTH_lat_lon_tracks','nrgradt_sample','n');

save -append NORTH_comps 

return
%}
load NORTH_comps
r=9:41;
c=9:41;

flc='NORTH_gradt_c_with_ssh';
tmp = double(interp2(NORTH_gradt_c.median(r,c),2));
tmp2 = double(interp2(NORTH_ssh_c.median(r,c),2));
cplot_comps_cont_pos_scale_2_2(tmp,tmp2,.35,.8,1,-100,100,'magnitude of grad T Cyclones',...
	['~/Documents/OSU/figures/air-sea/NORTH_comps/',flc]) 
 
flc='NORTH_gradt_a_with_ssh';
tmp = double(interp2(NORTH_gradt_a.median(r,c),2));
tmp2 = double(interp2(NORTH_ssh_a.median(r,c),2));
cplot_comps_cont_pos_scale_2_2(tmp,tmp2,.35,.8,1,-100,100,'magnitude of grad T Anticyclones',...
	['~/Documents/OSU/figures/air-sea/NORTH_comps/',flc]) 
	
return
flc='NORTH_wek_all_c_with_wek_all';
tmp = double(interp2(NORTH_wek_all_c.median(r,c),2));
tmp2 = double(interp2(NORTH_wek_all_c.median(r,c),2));
cplot_comps_cont_2_2_bwr(tmp,tmp2,-7,7,1,-100,100,'combined Ekman Downwelling',...
	['~/Documents/OSU/figures/air-sea/NORTH_comps/',flc]) 


fla='NORTH_wek_all_a_with_wek_all';
tmp = double(interp2(NORTH_wek_all_a.median(r,c),2));
tmp2 = double(interp2(NORTH_wek_all_a.median(r,c),2));
cplot_comps_cont_2_2_bwr(tmp,tmp2,-7,7,1,-100,100,'combined Ekman Upwelling',...
	['~/Documents/OSU/figures/air-sea/NORTH_comps/',fla]) 
	
flc='NORTH_wek_crlg_c_with_wek_crlg';
tmp = double(interp2(NORTH_wek_crlg_c.median(r,c),2));
tmp2 = double(interp2(NORTH_wek_crlg_c.median(r,c),2));
cplot_comps_cont_2_2_bwr(tmp,tmp2,-7,7,1,-100,100,'AVISO Ekman Downwelling',...
	['~/Documents/OSU/figures/air-sea/NORTH_comps/',flc]) 


fla='NORTH_wek_crlg_a_with_wek_crlg';
tmp = double(interp2(NORTH_wek_crlg_a.median(r,c),2));
tmp2 = double(interp2(NORTH_wek_crlg_a.median(r,c),2));
cplot_comps_cont_2_2_bwr(tmp,tmp2,-7,7,1,-100,100,'AVISO Ekman Upwelling',...
	['~/Documents/OSU/figures/air-sea/NORTH_comps/',fla]) 

flc='NORTH_wek_sst_c_with_wek_sst';
tmp = double(interp2(NORTH_wek_sst_c.median(r,c),2));
tmp2 = double(interp2(NORTH_wek_sst_c.median(r,c),2));
cplot_comps_cont_2_2_bwr(tmp,tmp2,-7,7,1,-100,100,'SST-induced Ekman Downwelling',...
	['~/Documents/OSU/figures/air-sea/NORTH_comps/',flc]) 


fla='NORTH_wek_sst_a_with_wek_sst';
tmp = double(interp2(NORTH_wek_sst_a.median(r,c),2));
tmp2 = double(interp2(NORTH_wek_sst_a.median(r,c),2));
cplot_comps_cont_2_2_bwr(tmp,tmp2,-7,7,1,-100,100,'SST-induced Ekman Upwelling',...
	['~/Documents/OSU/figures/air-sea/NORTH_comps/',fla]) 

flc='NORTH_wek_drift_c_with_wek_drift';
tmp = double(interp2(NORTH_wek_drift_c.median(r,c),2));
tmp2 = double(interp2(NORTH_wek_drift_c.median(r,c),2));
cplot_comps_cont_2_2_bwr(tmp,tmp2,-.1,.1,.01,-10,10,'Drift-induced Ekman Downwelling',...
	['~/Documents/OSU/figures/air-sea/NORTH_comps/',flc]) 


fla='NORTH_wek_drift_a_with_wek_drift';
tmp = double(interp2(NORTH_wek_drift_a.median(r,c),2));
tmp2 = double(interp2(NORTH_wek_drift_a.median(r,c),2));
cplot_comps_cont_2_2_bwr(tmp,tmp2,-.1,.1,.01,-10,10,'Drift-induced Ekman Upwelling',...
	['~/Documents/OSU/figures/air-sea/NORTH_comps/',fla]) 
	
	return
flc='NORTH_wek_c_with_wek';
tmp = double(interp2(NORTH_wek_c.median(r,c),2));
tmp2 = double(interp2(NORTH_wek_c.median(r,c),2));
cplot_comps_cont_2_2_bwr(tmp,tmp2,-.07,.07,.01,-1,1,'QuikSCAT Ekman Downwelling',...
	['~/Documents/OSU/figures/air-sea/NORTH_comps/',flc]) 


fla='NORTH_wek_a_with_wek';
tmp = double(interp2(NORTH_wek_a.median(r,c),2));
tmp2 = double(interp2(NORTH_wek_a.median(r,c),2));
cplot_comps_cont_2_2_bwr(tmp,tmp2,-.07,.07,.01,-1,1,'QuikSCAT Ekman Upwelling',...
	['~/Documents/OSU/figures/air-sea/NORTH_comps/',fla]) 
	
flc='NORTH_ssh_c_with_ssh';
tmp = double(interp2(NORTH_ssh_c.median(r,c),2));
tmp2 = double(interp2(NORTH_ssh_c.median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,-10,10,1,-100,100,'AVINORTH SSH Cyclones',...
	['~/Documents/OSU/figures/air-sea/NORTH_comps/',flc]) 
 
flc='NORTH_ssh_a_with_ssh';
tmp = double(interp2(NORTH_ssh_a.median(r,c),2));
tmp2 = double(interp2(NORTH_ssh_a.median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,-10,10,1,-100,100,'AVINORTH SSH Anticyclones',...
	['~/Documents/OSU/figures/air-sea/NORTH_comps/',flc]) 
	
flc='NORTH_sst_c_with_ssh';
tmp = double(interp2(NORTH_sst_c.median(r,c),2));
tmp2 = double(interp2(NORTH_ssh_c.median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,-.3,.3,1,-100,100,'NOAA SST Cyclones',...
	['~/Documents/OSU/figures/air-sea/NORTH_comps/',flc]) 
 
flc='NORTH_sst_a_with_ssh';
tmp = double(interp2(NORTH_sst_a.median(r,c),2));
tmp2 = double(interp2(NORTH_ssh_a.median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,-.3,.3,1,-100,100,'NOAA SST Anticyclones',...
	['~/Documents/OSU/figures/air-sea/NORTH_comps/',flc]) 	
	
flc='NORTH_raw_c_with_wek';
tmp = double(interp2(NORTH_raw_c.median(r,c),2));
tmp2 = double(interp2(NORTH_wek_c.median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,-.03,.03,.01,-1,1,'GSM CHL Cyclones',...
	['~/Documents/OSU/figures/air-sea/NORTH_comps/',flc]) 
 
flc='NORTH_raw_a_with_ssh';
tmp = double(interp2(NORTH_raw_a.median(r,c),2));
tmp2 = double(interp2(NORTH_wek_a.median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,-.03,.03,.01,-1,1,'GSM CHL Anticyclones',...
	['~/Documents/OSU/figures/air-sea/NORTH_comps/',flc]) 		