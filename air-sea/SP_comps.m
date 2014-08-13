clear all
%{

load /matlab/matlab/domains/oPC_lat_lon
load /matlab/data/eddy/V4/oPC_lat_lon_tracks

%oPC_wek_a,oPC_wek_c]=mcomps('/matlab/data/eddy/V4/oPC_lat_lon_tracks','nrw_ek_sample','n');
%[oPC_sst_a,oPC_sst_c]=mcomps('/matlab/data/eddy/V4/oPC_lat_lon_tracks','nrbp26_sst_sample','n');
%[oPC_ssh_a,oPC_ssh_c]=mcomps('/matlab/data/eddy/V4/oPC_lat_lon_tracks','nrssh_sample','n');
%[oPC_raw_a,oPC_raw_c]=mcomps('/matlab/data/eddy/V4/oPC_lat_lon_tracks','nrraw_hp66_chl_sample','n');
[oPC_wek_crlg_a,oPC_wek_crlg_c]=mcomps('/matlab/data/eddy/V4/oPC_lat_lon_tracks','nrhp_wek_crlg_week_sample','n');
%[oPC_crlg_a,oPC_crlg_c]=mcomps('/matlab/data/eddy/V4/cPC_lat_lon_tracks','nrbp26_crlg_sample','n');
%[oPC_wek_sst_a,oPC_wek_sst_c]=mcomps('/matlab/data/eddy/V4/oPC_lat_lon_tracks','nrhp_wek_sst_week_dtdn_sample','n');
%[oPC_wek_drift_a,oPC_wek_drift_c]=mcomps('/matlab/data/eddy/V4/oPC_lat_lon_tracks','nrhp_wek_drift_week_sample','n');
%[oPC_wek_all_a,oPC_wek_all_c]=mcomps('/matlab/data/eddy/V4/oPC_lat_lon_tracks','nrhp_wek_total_week_sample','n');
save -append SP_comps
return

%}
load SP_comps
r=9:41;
c=9:41;

flc='oPC_crlg_c_with_ssh';
tmp = double(interp2(oPC_crlg_c.median(r,c),2));
tmp2 = double(interp2(oPC_ssh_c.median(r,c),2));
cplot_comps_cont_2_2(1e5*tmp,tmp2,-.3,.3,2,-100,100,'AVISO @MAiD@ u_g^ Cyclones',...
	['~/Documents/OSU/figures/air-sea/oPC_comps/',flc]) 
 
flc='oPC_crlg_a_with_ssh';
tmp = double(interp2(oPC_crlg_a.median(r,c),2));
tmp2 = double(interp2(oPC_ssh_a.median(r,c),2));
cplot_comps_cont_2_2(1e5*tmp,tmp2,-.3,.3,2,-100,100,'AVISO @MAiD@ u_g^ Anticyclones',...
	['~/Documents/OSU/figures/air-sea/oPC_comps/',flc]) 
	
%{
flc='oPC_gradt_c_with_ssh';
tmp = double(interp2(oPC_gradt_c.median(r,c),2));
tmp2 = double(interp2(oPC_ssh_c.median(r,c),2));
cplot_comps_cont_pos_scale_2_2(tmp,tmp2,.3,1,.5,-100,100,'magnitude of grad T Cyclones',...
	['~/Documents/OSU/figures/air-sea/oPC_comps/',flc]) 
 
flc='oPC_gradt_a_with_ssh';
tmp = double(interp2(oPC_gradt_a.median(r,c),2));
tmp2 = double(interp2(oPC_ssh_a.median(r,c),2));
cplot_comps_cont_pos_scale_2_2(tmp,tmp2,.3,1,.5,-100,100,'magnitude of grad T Anticyclones',...
	['~/Documents/OSU/figures/air-sea/oPC_comps/',flc]) 
	

flc='oPC_wek_all_c_with_wek_all';
tmp = double(interp2(oPC_wek_all_c.median(r,c),2));
tmp2 = double(interp2(oPC_wek_all_c.median(r,c),2));
cplot_comps_cont_2_2_bwr(tmp,tmp2,-7,7,.5,-100,100,'combined Ekman Downwelling',...
	['~/Documents/OSU/figures/air-sea/oPC_comps/',flc]) 


fla='oPC_wek_all_a_with_wek_all';
tmp = double(interp2(oPC_wek_all_a.median(r,c),2));
tmp2 = double(interp2(oPC_wek_all_a.median(r,c),2));
cplot_comps_cont_2_2_bwr(tmp,tmp2,-7,7,.5,-100,100,'combined Ekman Upwelling',...
	['~/Documents/OSU/figures/air-sea/oPC_comps/',fla]) 
%}	
flc='oPC_wek_crlg_c_with_wek_crlg';
tmp = double(interp2(oPC_wek_crlg_c.median(r,c),2));
tmp2 = double(interp2(oPC_wek_crlg_c.median(r,c),2));
cplot_comps_cont_2_2_bwr(tmp,tmp2,-1,1,.5,-100,100,'AVISO Ekman Downwelling',...
	['~/Documents/OSU/figures/air-sea/oPC_comps/',flc]) 


fla='oPC_wek_crlg_a_with_wek_crlg';
tmp = double(interp2(oPC_wek_crlg_a.median(r,c),2));
tmp2 = double(interp2(oPC_wek_crlg_a.median(r,c),2));
cplot_comps_cont_2_2_bwr(tmp,tmp2,-1,1,.5,-100,100,'AVISO Ekman Upwelling',...
	['~/Documents/OSU/figures/air-sea/oPC_comps/',fla]) 

flc='oPC_wek_sst_c_with_wek_sst';
tmp = double(interp2(oPC_wek_sst_c.median(r,c),2));
tmp2 = double(interp2(oPC_wek_sst_c.median(r,c),2));
cplot_comps_cont_2_2_bwr(tmp,tmp2,-.08,.08,.02,-100,100,'SST-induced Ekman Downwelling',...
	['~/Documents/OSU/figures/air-sea/oPC_comps/',flc]) 


fla='oPC_wek_sst_a_with_wek_sst';
tmp = double(interp2(oPC_wek_sst_a.median(r,c),2));
tmp2 = double(interp2(oPC_wek_sst_a.median(r,c),2));
cplot_comps_cont_2_2_bwr(tmp,tmp2,-.08,.08,.02,-100,100,'SST-induced Ekman Upwelling',...
	['~/Documents/OSU/figures/air-sea/oPC_comps/',fla]) 
	
%{	
flc='oPC_wek_drift_c_with_wek_drift';
tmp = double(interp2(oPC_wek_drift_c.median(r,c),2));
tmp2 = double(interp2(oPC_wek_drift_c.median(r,c),2));
cplot_comps_cont_2_2_bwr(tmp,tmp2,-.1,.1,.01,-1,1,'Drift-induced Ekman Downwelling',...
	['~/Documents/OSU/figures/air-sea/oPC_comps/',flc]) 


fla='oPC_wek_drift_a_with_wek_drift';
tmp = double(interp2(oPC_wek_drift_a.median(r,c),2));
tmp2 = double(interp2(oPC_wek_drift_a.median(r,c),2));
cplot_comps_cont_2_2_bwr(tmp,tmp2,-.1,.1,.01,-1,1,'Drift-induced Ekman Upwelling',...
	['~/Documents/OSU/figures/air-sea/oPC_comps/',fla]) 	
%}
	
flc='oPC_wek_c_with_wek';
tmp = double(interp2(oPC_wek_c.median(r,c),2));
tmp2 = double(interp2(oPC_wek_c.median(r,c),2));
cplot_comps_cont_2_2_bwr(tmp,tmp2,-.01,.01,.005,-1,1,'QuikSCAT Ekman Downwelling',...
	['~/Documents/OSU/figures/air-sea/oPC_comps/',flc]) 


fla='oPC_wek_a_with_wek';
tmp = double(interp2(oPC_wek_a.median(r,c),2));
tmp2 = double(interp2(oPC_wek_a.median(r,c),2));
cplot_comps_cont_2_2_bwr(tmp,tmp2,-.01,.01,.005,-1,1,'QuikSCAT Ekman Upwelling',...
	['~/Documents/OSU/figures/air-sea/oPC_comps/',fla]) 
	
flc='oPC_ssh_c_with_ssh';
tmp = double(interp2(oPC_ssh_c.median(r,c),2));
tmp2 = double(interp2(oPC_ssh_c.median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,-10,10,2,-100,100,'AVISO SSH Cyclones',...
	['~/Documents/OSU/figures/air-sea/oPC_comps/',flc]) 
 
flc='oPC_ssh_a_with_ssh';
tmp = double(interp2(oPC_ssh_a.median(r,c),2));
tmp2 = double(interp2(oPC_ssh_a.median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,-10,10,2,-100,100,'AVISO SSH Anticyclones',...
	['~/Documents/OSU/figures/air-sea/oPC_comps/',flc]) 
	
flc='oPC_sst_c_with_ssh';
tmp = double(interp2(oPC_sst_c.median(r,c),2));
tmp2 = double(interp2(oPC_ssh_c.median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,-.3,.3,2,-100,100,'NOAA SST Cyclones',...
	['~/Documents/OSU/figures/air-sea/oPC_comps/',flc]) 
 
flc='oPC_sst_a_with_ssh';
tmp = double(interp2(oPC_sst_a.median(r,c),2));
tmp2 = double(interp2(oPC_ssh_a.median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,-.3,.3,2,-100,100,'NOAA SST Anticyclones',...
	['~/Documents/OSU/figures/air-sea/oPC_comps/',flc]) 	

return
flc='oPC_raw_c_with_wek';
tmp = double(interp2(oPC_raw_c.median(r,c),2));
tmp2 = double(interp2(oPC_wek_c.median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,-.03,.03,.01,-1,1,'GSM CHL Cyclones',...
	['~/Documents/OSU/figures/air-sea/oPC_comps/',flc]) 
 
flc='oPC_raw_a_with_ssh';
tmp = double(interp2(oPC_raw_a.median(r,c),2));
tmp2 = double(interp2(oPC_wek_a.median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,-.03,.03,.01,-1,1,'GSM CHL Anticyclones',...
	['~/Documents/OSU/figures/air-sea/oPC_comps/',flc]) 		