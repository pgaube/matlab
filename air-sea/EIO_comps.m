clear all
%{

load /matlab/matlab/domains/air-sea_eio_lat_lon
load /matlab/data/eddy/V4/air-sea_eio_lat_lon_tracks
%[EIO_na_crlg_a,EIO_na_crlg_c]=mcomps('/matlab/data/eddy/V4/air-sea_eio_lat_lon_tracks','nrna_crlg_sample','n');
%[EIO_crlg_a,EIO_crlg_c]=mcomps('/matlab/data/eddy/V4/air-sea_eio_lat_lon_tracks','nrbp26_crlg_sample','n');
%[EIO_crl_a,EIO_crl_c]=mcomps('/matlab/data/eddy/V4/air-sea_eio_lat_lon_tracks','nrbp26_crl_sample','n');
%[EIO_wek_a,EIO_wek_c]=mcomps('/matlab/data/eddy/V4/air-sea_eio_lat_lon_tracks','nrw_ek_sample','n');
%[EIO_sst_a,EIO_sst_c]=mcomps('/matlab/data/eddy/V4/air-sea_eio_lat_lon_tracks','nrbp26_sst_sample','n');
%[EIO_ssh_a,EIO_ssh_c]=mcomps('/matlab/data/eddy/V4/air-sea_eio_lat_lon_tracks','nrssh_sample','n');
%[EIO_raw_a,EIO_raw_c]=mcomps('/matlab/data/eddy/V4/air-sea_eio_lat_lon_tracks','nrraw_hp66_chl_sample','n');
[EIO_wek_crlg_a,EIO_wek_crlg_c]=mcomps('/matlab/data/eddy/V4/air-sea_eio_lat_lon_tracks','nrhp_wek_crlg_week_sample','n');
%[EIO_wek_sst_a,EIO_wek_sst_c]=mcomps('/matlab/data/eddy/V4/air-sea_eio_lat_lon_tracks','nrhp_wek_sst_week_dtdn_sample','n');
%[EIO_wek_sst_max_a,EIO_wek_sst_max_c]=mcomps('/matlab/data/eddy/V4/air-sea_eio_lat_lon_tracks','nrhp_wek_sst_week_max_sample','n');%[EIO_crlg_a,EIO_crlg_c]=mcomps('/matlab/data/eddy/V4/air-sea_eio_lat_lon_tracks','nrbp26_crlg_sample','n');
%[EIO_wek_drift_a,EIO_wek_drift_c]=mcomps('/matlab/data/eddy/V4/air-sea_eio_lat_lon_tracks','nrhp_wek_drift_week_sample','n');
%[EIO_wek_all_a,EIO_wek_all_c]=mcomps('/matlab/data/eddy/V4/air-sea_eio_lat_lon_tracks','nrhp_wek_total_week_sample','n');
%[EIO_gradt_a,EIO_gradt_c]=mcomps('/matlab/data/eddy/V4/air-sea_eio_lat_lon_tracks','nrgradt_sample','n');
save -append EIO_comps
return


%}
load EIO_comps
r=9:41;
c=9:41;

%{
flc='EIO_gradt_c_with_ssh';
tmp = double(interp2(EIO_gradt_c.median(r,c),2));
tmp2 = double(interp2(EIO_ssh_c.median(r,c),2));
cplot_comps_cont_pos_scale_2_2(tmp,tmp2,.3,1,.5,-100,100,'magnitude of grad T Cyclones',...
	['~/Documents/OSU/figures/air-sea/EIO_comps/',flc]) 
 
flc='EIO_gradt_a_with_ssh';
tmp = double(interp2(EIO_gradt_a.median(r,c),2));
tmp2 = double(interp2(EIO_ssh_a.median(r,c),2));
cplot_comps_cont_pos_scale_2_2(tmp,tmp2,.3,1,.5,-100,100,'magnitude of grad T Anticyclones',...
	['~/Documents/OSU/figures/air-sea/EIO_comps/',flc]) 
	

flc='EIO_wek_all_c_with_wek_all';
tmp = double(interp2(EIO_wek_all_c.median(r,c),2));
tmp2 = double(interp2(EIO_wek_all_c.median(r,c),2));
cplot_comps_cont_2_2_bwr(tmp,tmp2,-5,5,.5,-100,100,'combined Ekman Downwelling',...
	['~/Documents/OSU/figures/air-sea/EIO_comps/',flc]) 


fla='EIO_wek_all_a_with_wek_all';
tmp = double(interp2(EIO_wek_all_a.median(r,c),2));
tmp2 = double(interp2(EIO_wek_all_a.median(r,c),2));
cplot_comps_cont_2_2_bwr(tmp,tmp2,-5,5,.5,-100,100,'combined Ekman Upwelling',...
	['~/Documents/OSU/figures/air-sea/EIO_comps/',fla]) 
%}	
flc='EIO_crlg_c_with_ssh';
tmp = double(interp2(EIO_crlg_c.median(r,c),2));
tmp2 = double(interp2(EIO_ssh_c.median(r,c),2));
cplot_comps_cont_2_2(1e5*tmp,tmp2,-.4,.4,2,-100,100,'AVISO @MAiD@ u_g^ Cyclones',...
	['~/Documents/OSU/figures/air-sea/EIO_comps/',flc]) 
 
flc='EIO_crlg_a_with_ssh';
tmp = double(interp2(EIO_crlg_a.median(r,c),2));
tmp2 = double(interp2(EIO_ssh_a.median(r,c),2));
cplot_comps_cont_2_2(1e5*tmp,tmp2,-.4,.4,2,-100,100,'AVISO @MAiD@ u_g^ Anticyclones',...
	['~/Documents/OSU/figures/air-sea/EIO_comps/',flc]) 
	
flc='EIO_na_crlg_c_with_ssh';
tmp = double(interp2(EIO_na_crlg_c.median(r,c),2));
tmp2 = double(interp2(EIO_ssh_c.median(r,c),2));
cplot_comps_cont_2_2(1e5*tmp,tmp2,-.4,.4,2,-100,100,'offset AVISO @MAiD@ u_g^ Cyclones',...
	['~/Documents/OSU/figures/air-sea/EIO_comps/',flc]) 
 
flc='EIO_na_crlg_a_with_ssh';
tmp = double(interp2(EIO_na_crlg_a.median(r,c),2));
tmp2 = double(interp2(EIO_ssh_a.median(r,c),2));
cplot_comps_cont_2_2(1e5*tmp,tmp2,-.4,.4,2,-100,100,'offset AVISO @MAiD@ u_g^ Anti',...
	['~/Documents/OSU/figures/air-sea/EIO_comps/',flc]) 
	
flc='EIO_crl_c_with_ssh';
tmp = double(interp2(EIO_crl_c.median(r,c),2));
tmp2 = double(interp2(EIO_ssh_c.median(r,c),2));
cplot_comps_cont_2_2(-1e5*tmp,tmp2,-.4,.4,2,-100,100,'QSCAT -@MAiD@ u_r^ Cyclones',...
	['~/Documents/OSU/figures/air-sea/EIO_comps/',flc]) 
 
flc='EIO_crl_a_with_ssh';
tmp = double(interp2(EIO_crl_a.median(r,c),2));
tmp2 = double(interp2(EIO_ssh_a.median(r,c),2));
cplot_comps_cont_2_2(-1e5*tmp,tmp2,-.4,.4,2,-100,100,'QSCAT -@MAiD@ u_r^ Anticyclones',...
	['~/Documents/OSU/figures/air-sea/EIO_comps/',flc]) 
	
flc='EIO_wek_crlg_c_with_wek_crlg';
tmp = double(interp2(EIO_wek_crlg_c.median(r,c),2));
tmp2 = double(interp2(EIO_wek_crlg_c.median(r,c),2));
cplot_comps_cont_2_2_bwr(tmp,tmp2,-5,5,.5,-100,100,'AVISO Ekman Downwelling',...
	['~/Documents/OSU/figures/air-sea/EIO_comps/',flc]) 


fla='EIO_wek_crlg_a_with_wek_crlg';
tmp = double(interp2(EIO_wek_crlg_a.median(r,c),2));
tmp2 = double(interp2(EIO_wek_crlg_a.median(r,c),2));
cplot_comps_cont_2_2_bwr(tmp,tmp2,-5,5,.5,-100,100,'AVISO Ekman Upwelling',...
	['~/Documents/OSU/figures/air-sea/EIO_comps/',fla]) 

flc='EIO_wek_sst_c_with_wek_sst';
tmp = double(interp2(EIO_wek_sst_c.median(r,c),2));
tmp2 = double(interp2(EIO_wek_sst_c.median(r,c),2));
cplot_comps_cont_2_2_bwr(tmp,tmp2,-1,1,.1,-100,100,'SST-induced Ekman Downwelling',...
	['~/Documents/OSU/figures/air-sea/EIO_comps/',flc]) 


fla='EIO_wek_sst_a_with_wek_sst';
tmp = double(interp2(EIO_wek_sst_a.median(r,c),2));
tmp2 = double(interp2(EIO_wek_sst_a.median(r,c),2));
cplot_comps_cont_2_2_bwr(tmp,tmp2,-1,1,.1,-100,100,'SST-induced Ekman Upwelling',...
	['~/Documents/OSU/figures/air-sea/EIO_comps/',fla]) 
	
flc='EIO_wek_drift_c_with_wek_drift';
tmp = double(interp2(EIO_wek_drift_c.median(r,c),2));
tmp2 = double(interp2(EIO_wek_drift_c.median(r,c),2));
cplot_comps_cont_2_2_bwr(tmp,tmp2,-.1,.1,.05,-1,1,'Drift-induced Ekman Downwelling',...
	['~/Documents/OSU/figures/air-sea/EIO_comps/',flc]) 


fla='EIO_wek_drift_a_with_wek_drift';
tmp = double(interp2(EIO_wek_drift_a.median(r,c),2));
tmp2 = double(interp2(EIO_wek_drift_a.median(r,c),2));
cplot_comps_cont_2_2_bwr(tmp,tmp2,-.1,.1,.005,-1,1,'Drift-induced Ekman Upwelling',...
	['~/Documents/OSU/figures/air-sea/EIO_comps/',fla]) 	
	
	
flc='EIO_wek_c_with_wek';
tmp = 1.2*double(interp2(EIO_wek_c.median(r,c),2));
tmp2 = 1.2*double(interp2(EIO_wek_c.median(r,c),2));
cplot_comps_cont_2_2_bwr(tmp,tmp2,-.05,.05,.005,-1,1,'QuikSCAT Ekman Downwelling',...
	['~/Documents/OSU/figures/air-sea/EIO_comps/',flc]) 


fla='EIO_wek_a_with_wek';
tmp = 1.2*double(interp2(EIO_wek_a.median(r,c),2));
tmp2 = 1.2*double(interp2(EIO_wek_a.median(r,c),2));
cplot_comps_cont_2_2_bwr(tmp,tmp2,-.05,.05,.005,-1,1,'QuikSCAT Ekman Upwelling',...
	['~/Documents/OSU/figures/air-sea/EIO_comps/',fla]) 
	
flc='EIO_ssh_c_with_ssh';
tmp = double(interp2(EIO_ssh_c.median(r,c),2));
tmp2 = double(interp2(EIO_ssh_c.median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,-10,10,2,-100,100,'AVISO SSH Cyclones',...
	['~/Documents/OSU/figures/air-sea/EIO_comps/',flc]) 
 
flc='EIO_ssh_a_with_ssh';
tmp = double(interp2(EIO_ssh_a.median(r,c),2));
tmp2 = double(interp2(EIO_ssh_a.median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,-10,10,2,-100,100,'AVISO SSH Anticyclones',...
	['~/Documents/OSU/figures/air-sea/EIO_comps/',flc]) 
	
flc='EIO_sst_c_with_ssh';
tmp = double(interp2(EIO_sst_c.median(r,c),2));
tmp2 = double(interp2(EIO_ssh_c.median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,-.3,.3,2,-100,100,'NOAA SST Cyclones',...
	['~/Documents/OSU/figures/air-sea/EIO_comps/',flc]) 
 
flc='EIO_sst_a_with_ssh';
tmp = double(interp2(EIO_sst_a.median(r,c),2));
tmp2 = double(interp2(EIO_ssh_a.median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,-.3,.3,2,-100,100,'NOAA SST Anticyclones',...
	['~/Documents/OSU/figures/air-sea/EIO_comps/',flc]) 	
	
flc='EIO_raw_c_with_wek';
tmp = double(interp2(EIO_raw_c.median(r,c),2));
tmp2 = double(interp2(EIO_wek_c.median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,-.03,.03,.05,-1,1,'GSM CHL Cyclones',...
	['~/Documents/OSU/figures/air-sea/EIO_comps/',flc]) 
 
flc='EIO_raw_a_with_ssh';
tmp = double(interp2(EIO_raw_a.median(r,c),2));
tmp2 = double(interp2(EIO_wek_a.median(r,c),2));
cplot_comps_cont_2_2(tmp,tmp2,-.03,.03,.05,-1,1,'GSM CHL Anticyclones',...
	['~/Documents/OSU/figures/air-sea/EIO_comps/',flc]) 		