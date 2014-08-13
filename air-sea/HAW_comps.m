clear all
%{

load /matlab/matlab/domains/HAW_lat_lon
load /matlab/data/eddy/V4/HAW_lat_lon_tracks

%[HAW_wek_a,HAW_wek_c]=mcomps('/matlab/data/eddy/V4/HAW_lat_lon_tracks','nrw_ek_sample','n');
%[HAW_sst_a,HAW_sst_c]=mcomps('/matlab/data/eddy/V4/HAW_lat_lon_tracks','nrbp26_sst_sample','n');
%[HAW_ssh_a,HAW_ssh_c]=mcomps('/matlab/data/eddy/V4/HAW_lat_lon_tracks','nrssh_sample','n');
%[HAW_raw_a,HAW_raw_c]=mcomps('/matlab/data/eddy/V4/HAW_lat_lon_tracks','nrraw_hp66_chl_sample','n');
[HAW_wek_crlg_a,HAW_wek_crlg_c]=mcomps('/matlab/data/eddy/V4/HAW_lat_lon_tracks','nrhp_wek_crlg_week_sample','n');
%[HAW_wek_sst_a,HAW_wek_sst_c]=mcomps('/matlab/data/eddy/V4/HAW_lat_lon_tracks','nrhp_wek_sst_week_dtdn_sample','n');
%[HAW_crlg_a,HAW_crlg_c]=mcomps('/matlab/data/eddy/V4/HAW_lat_lon_tracks','nrbp26_crlg_sample','n');
%[HAW_wek_drift_a,HAW_wek_drift_c]=mcomps('/matlab/data/eddy/V4/HAW_lat_lon_tracks','nrhp_wek_drift_week_sample','n');
%[HAW_wek_all_a,HAW_wek_all_c]=mcomps('/matlab/data/eddy/V4/HAW_lat_lon_tracks','nrhp_wek_total_week_sample','n');
%[HAW_gradt_a,HAW_gradt_c]=mcomps('/matlab/data/eddy/V4/HAW_lat_lon_tracks','nrgradt_sample','n');

save -append HAW_comps 

return
%}
load HAW_comps
r=9:41;
c=9:41;

flc='HAW_crlg_c_with_ssh';
tmp = double(interp2(HAW_crlg_c.median(r,c),2));
tmp2 = double(interp2(HAW_ssh_c.median(r,c),2));
cplot_comps_cont_2_2(1e5*tmp,tmp2,-.4,.4,2,-100,100,'AVISO @MAiD@ u_g^ Cyclones',...
	['~/Documents/OSU/figures/air-sea/HAW_comps/',flc]) 
 
flc='HAW_crlg_a_with_ssh';
tmp = double(interp2(HAW_crlg_a.median(r,c),2));
tmp2 = double(interp2(HAW_ssh_a.median(r,c),2));
cplot_comps_cont_2_2(1e5*tmp,tmp2,-.4,.4,2,-100,100,'AVISO @MAiD@ u_g^ Anticyclones',...
	['~/Documents/OSU/figures/air-sea/HAW_comps/',flc]) 
%{
flc='HAW_gradt_c_with_ssh';
tmp = double(interp2(HAW_gradt_c.median(r,c),2));
tmp2 = double(interp2(HAW_ssh_c.median(r,c),2));
cplot_comps_cont_pos_scale_2_2(tmp,tmp2,.2,.4,.5,-100,100,'magnitude of grad T Cyclones',...
	['~/Documents/OSU/figures/air-sea/HAW_comps/',flc]) 
 
flc='HAW_gradt_a_with_ssh';
tmp = double(interp2(HAW_gradt_a.median(r,c),2));
tmp2 = double(interp2(HAW_ssh_a.median(r,c),2));
cplot_comps_cont_pos_scale_2_2(tmp,tmp2,.2,.4,.5,-100,100,'magnitude of grad T Anticyclones',...
	['~/Documents/OSU/figures/air-sea/HAW_comps/',flc]) 
	
%}
flc='HAW_wek_all_c_with_wek_all';
tmp = double(interp2(HAW_wek_all_c.median(r,c),2));
tmp2 = double(interp2(HAW_wek_all_c.median(r,c),2));
cplot_comps_cont_2_2_bwr(tmp,tmp2,-5,5,.5,-100,100,'combined Ekman Downwelling',...
	['~/Documents/OSU/figures/air-sea/HAW_comps/',flc]) 


fla='HAW_wek_all_a_with_wek_all';
tmp = double(interp2(HAW_wek_all_a.median(r,c),2));
tmp2 = double(interp2(HAW_wek_all_a.median(r,c),2));
cplot_comps_cont_2_2_bwr(tmp,tmp2,-5,5,.5,-100,100,'combined Ekman Upwelling',...
	['~/Documents/OSU/figures/air-sea/HAW_comps/',fla]) 

flc='HAW_wek_crlg_c_with_wek_crlg';
tmp = double(interp2(HAW_wek_crlg_c.median(r,c),2));
tmp2 = double(interp2(HAW_wek_crlg_c.median(r,c),2));
cplot_comps_cont_2_2_bwr(tmp,tmp2,-5,5,.5,-100,100,'AVISO Ekman Downwelling',...
	['~/Documents/OSU/figures/air-sea/HAW_comps/',flc]) 


fla='HAW_wek_crlg_a_with_wek_crlg';
tmp = double(interp2(HAW_wek_crlg_a.median(r,c),2));
tmp2 = double(interp2(HAW_wek_crlg_a.median(r,c),2));
cplot_comps_cont_2_2_bwr(tmp,tmp2,-5,5,.5,-100,100,'AVISO Ekman Upwelling',...
	['~/Documents/OSU/figures/air-sea/HAW_comps/',fla]) 

flc='HAW_wek_sst_c_with_wek_sst';
tmp = double(interp2(HAW_wek_sst_c.median(r,c),2));
tmp2 = double(interp2(HAW_wek_sst_c.median(r,c),2));
cplot_comps_cont_2_2_bwr(tmp,tmp2,-2,2,.1,-100,100,'SST-induced Ekman Downwelling',...
	['~/Documents/OSU/figures/air-sea/HAW_comps/',flc]) 


fla='HAW_wek_sst_a_with_wek_sst';
tmp = double(interp2(HAW_wek_sst_a.median(r,c),2));
tmp2 = double(interp2(HAW_wek_sst_a.median(r,c),2));
cplot_comps_cont_2_2_bwr(tmp,tmp2,-2,2,.1,-100,100,'SST-induced Ekman Upwelling',...
	['~/Documents/OSU/figures/air-sea/HAW_comps/',fla]) 

flc='HAW_wek_drift_c_with_wek_drift';
tmp = double(interp2(HAW_wek_drift_c.median(r,c),2));
tmp2 = double(interp2(HAW_wek_drift_c.median(r,c),2));
cplot_comps_cont_2_2_bwr(tmp,tmp2,-.1,.1,.01,-10,10,'Drift-induced Ekman Downwelling',...
	['~/Documents/OSU/figures/air-sea/HAW_comps/',flc]) 


fla='HAW_wek_drift_a_with_wek_drift';
tmp = double(interp2(HAW_wek_drift_a.median(r,c),2));
tmp2 = double(interp2(HAW_wek_drift_a.median(r,c),2));
cplot_comps_cont_2_2_bwr(tmp,tmp2,-.1,.1,.01,-10,10,'Drift-induced Ekman Upwelling',...
	['~/Documents/OSU/figures/air-sea/HAW_comps/',fla]) 
	

flc='HAW_wek_c_with_wek';
tmp = double(interp2(HAW_wek_c.median(r,c),2));
tmp2 = double(interp2(HAW_wek_c.median(r,c),2));
cplot_comps_cont_2_2_bwr(tmp,tmp2,-.05,.05,.005,-1,1,'QuikSCAT Ekman Downwelling',...
	['~/Documents/OSU/figures/air-sea/HAW_comps/',flc]) 
	
flc='adj_HAW_wek_c_with_wek';
tmp = double(interp2(HAW_wek_c.median(r,c),2));
tmp2 = double(interp2(HAW_wek_c.median(r,c),2));
cplot_comps_cont_2_2_bwr(1.3*tmp,1.3*tmp2,-.05,.05,.005,-1,1,'QuikSCAT Ekman Downwelling',...
	['~/Documents/OSU/figures/air-sea/HAW_comps/',flc]) 


fla='HAW_wek_a_with_wek';
tmp = double(interp2(HAW_wek_a.median(r,c),2));
tmp2 = double(interp2(HAW_wek_a.median(r,c),2));
cplot_comps_cont_2_2_bwr(tmp,tmp2,-.05,.05,.005,-1,1,'QuikSCAT Ekman Upwelling',...
	['~/Documents/OSU/figures/air-sea/HAW_comps/',fla]) 
	
flc='HAW_ssh_c_with_ssh';
tmp = double(interp2(HAW_ssh_c.median(r,c),2));
tmp2 = double(interp2(HAW_ssh_c.median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,-10,10,2,-100,100,'AVIHAW SSH Cyclones',...
	['~/Documents/OSU/figures/air-sea/HAW_comps/',flc]) 
 
flc='HAW_ssh_a_with_ssh';
tmp = double(interp2(HAW_ssh_a.median(r,c),2));
tmp2 = double(interp2(HAW_ssh_a.median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,-10,10,2,-100,100,'AVIHAW SSH Anticyclones',...
	['~/Documents/OSU/figures/air-sea/HAW_comps/',flc]) 
	
flc='HAW_sst_c_with_ssh';
tmp = double(interp2(HAW_sst_c.median(r,c),2));
tmp2 = double(interp2(HAW_ssh_c.median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,-.2,.2,2,-100,100,'NOAA SST Cyclones',...
	['~/Documents/OSU/figures/air-sea/HAW_comps/',flc]) 
 
flc='HAW_sst_a_with_ssh';
tmp = double(interp2(HAW_sst_a.median(r,c),2));
tmp2 = double(interp2(HAW_ssh_a.median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,-.2,.2,2,-100,100,'NOAA SST Anticyclones',...
	['~/Documents/OSU/figures/air-sea/HAW_comps/',flc]) 	
	
flc='HAW_raw_c_with_wek';
tmp = double(interp2(HAW_raw_c.median(r,c),2));
tmp2 = double(interp2(HAW_wek_c.median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,-.03,.03,.05,-1,1,'GSM CHL Cyclones',...
	['~/Documents/OSU/figures/air-sea/HAW_comps/',flc]) 
 
flc='HAW_raw_a_with_ssh';
tmp = double(interp2(HAW_raw_a.median(r,c),2));
tmp2 = double(interp2(HAW_wek_a.median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,-.03,.03,.05,-1,1,'GSM CHL Anticyclones',...
	['~/Documents/OSU/figures/air-sea/HAW_comps/',flc]) 		