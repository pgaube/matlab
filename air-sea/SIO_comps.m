clear all
%{

load /matlab/matlab/domains/air-sea_sio_lat_lon
load /matlab/data/eddy/V4/air-sea_sio_lat_lon_tracks

[sio_wek_a,sio_wek_c]=mcomps('/matlab/data/eddy/V4/air-sea_sio_lat_lon_tracks','nrw_ek_sample','n');
[sio_sst_a,sio_sst_c]=mcomps('/matlab/data/eddy/V4/air-sea_sio_lat_lon_tracks','nrbp26_sst_sample','n');
[sio_ssh_a,sio_ssh_c]=mcomps('/matlab/data/eddy/V4/air-sea_sio_lat_lon_tracks','nrssh_sample','n');
%[sio_raw_a,sio_raw_c]=mcomps('/matlab/data/eddy/V4/air-sea_sio_lat_lon_tracks','nrraw_hp66_chl_sample','n');
[sio_wek_crlg_a,sio_wek_crlg_c]=mcomps('/matlab/data/eddy/V4/air-sea_sio_lat_lon_tracks','nrhp_wek_crlg_week_sample','n');
[sio_wek_sst_a,sio_wek_sst_c]=mcomps('/matlab/data/eddy/V4/air-sea_sio_lat_lon_tracks','nrhp_wek_sst_week_dtdn_sample','n');
[sio_crlg_a,sio_crlg_c]=mcomps('/matlab/data/eddy/V4/air-sea_sio_lat_lon_tracks','nrbp26_crlg_sample','n');
%[sio_wek_drift_a,sio_wek_drift_c]=mcomps('/matlab/data/eddy/V4/air-sea_sio_lat_lon_tracks','nrhp_wek_drift_week_sample','n');
%[sio_wek_all_a,sio_wek_all_c]=mcomps('/matlab/data/eddy/V4/air-sea_sio_lat_lon_tracks','nrhp_wek_total_week_sample','n');
%[sio_gradt_a,sio_gradt_c]=mcomps('/matlab/data/eddy/V4/air-sea_sio_lat_lon_tracks','nrgradt_sample','n');
save -append sio_comps

return

%}
load sio_comps
r=9:41;
c=9:41;

%{
flc='sio_gradt_c_with_ssh';
tmp = double(interp2(sio_gradt_c.median(r,c),2));
tmp2 = double(interp2(sio_ssh_c.median(r,c),2));
cplot_comps_cont_pos_scale_2_2(tmp,tmp2,.3,1,.5,-100,100,'magnitude of grad T Cyclones',...
	['~/Documents/OSU/figures/air-sea/sio_comps/',flc]) 
 
flc='sio_gradt_a_with_ssh';
tmp = double(interp2(sio_gradt_a.median(r,c),2));
tmp2 = double(interp2(sio_ssh_a.median(r,c),2));
cplot_comps_cont_pos_scale_2_2(tmp,tmp2,.3,1,.5,-100,100,'magnitude of grad T Anticyclones',...
	['~/Documents/OSU/figures/air-sea/sio_comps/',flc]) 
	

flc='sio_wek_all_c_with_wek_all';
tmp = double(interp2(sio_wek_all_c.median(r,c),2));
tmp2 = double(interp2(sio_wek_all_c.median(r,c),2));
cplot_comps_cont_2_2_bwr(tmp,tmp2,-5,5,.5,-100,100,'combined Ekman Downwelling',...
	['~/Documents/OSU/figures/air-sea/sio_comps/',flc]) 


fla='sio_wek_all_a_with_wek_all';
tmp = double(interp2(sio_wek_all_a.median(r,c),2));
tmp2 = double(interp2(sio_wek_all_a.median(r,c),2));
cplot_comps_cont_2_2_bwr(tmp,tmp2,-5,5,.5,-100,100,'combined Ekman Upwelling',...
	['~/Documents/OSU/figures/air-sea/sio_comps/',fla]) 
%}	
flc='sio_crlg_c_with_ssh';
tmp = double(interp2(sio_crlg_c.median(r,c),2));
tmp2 = double(interp2(sio_ssh_c.median(r,c),2));
cplot_comps_cont_2_2(1e5*tmp,tmp2,-.5,.5,2,-100,100,'AVISO @MAiD@ u_g^ Cyclones',...
	['~/Documents/OSU/figures/air-sea/sio_comps/',flc]) 
 
flc='sio_crlg_a_with_ssh';
tmp = double(interp2(sio_crlg_a.median(r,c),2));
tmp2 = double(interp2(sio_ssh_a.median(r,c),2));
cplot_comps_cont_2_2(1e5*tmp,tmp2,-.5,.5,2,-100,100,'AVISO @MAiD@ u_g^ Anticyclones',...
	['~/Documents/OSU/figures/air-sea/sio_comps/',flc]) 
	
flc='sio_wek_crlg_c_with_wek_crlg';
tmp = double(interp2(sio_wek_crlg_c.median(r,c),2));
tmp2 = double(interp2(sio_wek_crlg_c.median(r,c),2));
cplot_comps_cont_2_2_bwr(tmp,tmp2,-5,5,.5,-100,100,'AVISO Ekman Downwelling',...
	['~/Documents/OSU/figures/air-sea/sio_comps/',flc]) 


fla='sio_wek_crlg_a_with_wek_crlg';
tmp = double(interp2(sio_wek_crlg_a.median(r,c),2));
tmp2 = double(interp2(sio_wek_crlg_a.median(r,c),2));
cplot_comps_cont_2_2_bwr(tmp,tmp2,-5,5,.5,-100,100,'AVISO Ekman Upwelling',...
	['~/Documents/OSU/figures/air-sea/sio_comps/',fla]) 

flc='sio_wek_sst_c_with_wek_sst';
tmp = double(interp2(sio_wek_sst_c.median(r,c),2));
tmp2 = double(interp2(sio_wek_sst_c.median(r,c),2));
cplot_comps_cont_2_2_bwr(tmp,tmp2,-5,5,.5,-100,100,'SST-induced Ekman Downwelling',...
	['~/Documents/OSU/figures/air-sea/sio_comps/',flc]) 


fla='sio_wek_sst_a_with_wek_sst';
tmp = double(interp2(sio_wek_sst_a.median(r,c),2));
tmp2 = double(interp2(sio_wek_sst_a.median(r,c),2));
cplot_comps_cont_2_2_bwr(tmp,tmp2,-5,5,.5,-100,100,'SST-induced Ekman Upwelling',...
	['~/Documents/OSU/figures/air-sea/sio_comps/',fla]) 
	

flc='sio_wek_c_with_wek';
tmp = double(interp2(sio_wek_c.median(r,c),2));
tmp2 = double(interp2(sio_wek_c.median(r,c),2));
cplot_comps_cont_2_2_bwr(tmp,tmp2,-.05,.05,.005,-1,1,'QuikSCAT Ekman Downwelling',...
	['~/Documents/OSU/figures/air-sea/sio_comps/',flc]) 


fla='sio_wek_a_with_wek';
tmp = double(interp2(sio_wek_a.median(r,c),2));
tmp2 = double(interp2(sio_wek_a.median(r,c),2));
cplot_comps_cont_2_2_bwr(tmp,tmp2,-.05,.05,.005,-1,1,'QuikSCAT Ekman Upwelling',...
	['~/Documents/OSU/figures/air-sea/sio_comps/',fla]) 
	
flc='sio_ssh_c_with_ssh';
tmp = double(interp2(sio_ssh_c.median(r,c),2));
tmp2 = double(interp2(sio_ssh_c.median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,-10,10,2,-100,100,'AVISO SSH Cyclones',...
	['~/Documents/OSU/figures/air-sea/sio_comps/',flc]) 
 
flc='sio_ssh_a_with_ssh';
tmp = double(interp2(sio_ssh_a.median(r,c),2));
tmp2 = double(interp2(sio_ssh_a.median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,-10,10,2,-100,100,'AVISO SSH Anticyclones',...
	['~/Documents/OSU/figures/air-sea/sio_comps/',flc]) 
	
flc='sio_sst_c_with_ssh';
tmp = double(interp2(sio_sst_c.median(r,c),2));
tmp2 = double(interp2(sio_ssh_c.median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,-.5,.5,2,-100,100,'NOAA SST Cyclones',...
	['~/Documents/OSU/figures/air-sea/sio_comps/',flc]) 
 
flc='sio_sst_a_with_ssh';
tmp = double(interp2(sio_sst_a.median(r,c),2));
tmp2 = double(interp2(sio_ssh_a.median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,-.5,.5,2,-100,100,'NOAA SST Anticyclones',...
	['~/Documents/OSU/figures/air-sea/sio_comps/',flc]) 	
	
