
clear all

load ~/data/eddy/V6/global_tracks_ext_V6

f1=find(abs(ext_y)>=15 & abs(ext_y)<=45 & track_jdays>=2452427);
	id=id(f1);
	eid=eid(f1);
	x=ext_x(f1);
	y=ext_y(f1);
	amp=amp(f1);
	axial_speed=axial_speed(f1);
	scale=scale(f1);
	track_jday=track_jdays(f1);
	cyc=cyc(f1);
	k=k(f1);
save tracks/midlat_tracks k cyc track_jday scale axial_speed amp y x eid id	
return

% % 
load tracks/midlat_tracks	
ii=find(track_jday>=2452427 & track_jday<=2455159);
x=x(ii);
y=y(ii);
k=k(ii);
id=id(ii);
track_jday=track_jday(ii);
cyc=cyc(ii);
scale=scale(ii);

num_a=length(find(cyc==1))
num_c=length(find(cyc==-1))

% [rot_u_a,rot_u_c]=comps(x,y,cyc,k,id,track_jday,scale,'sm_u_week','~/data/QuickScat/new_mat/QSCAT_30_25km_','w');
% save -append FIANL_wind_midlat_rot_comps rot_*
% 
% [rot_v_a,rot_v_c]=comps(x,y,cyc,k,id,track_jday,scale,'sm_v_week','~/data/QuickScat/new_mat/QSCAT_30_25km_','w');
% save -append FIANL_wind_midlat_rot_comps rot_*
% return
% % 
% [rot_wspd_a,rot_wspd_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp66_wspd','~/data/QuickScat/ULTI_mat/QSCAT_30_25km_','w');
% save -append FIANL_wind_midlat_rot_comps rot_*
% 
% [rot_sst_a,rot_sst_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp66_sst','~/data/ReynoldsSST/mat/OI_25_30_','w');
% save -append FIANL_wind_midlat_rot_comps rot_*

[wspd_a,wspd_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp66_wspd','~/data/QuickScat/ULTI_mat/QSCAT_30_25km_','n');
save -append FIANL_wind_midlat_rot_comps wspd_*

[sst_a,sst_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp66_sst','~/data/ReynoldsSST/mat/OI_25_30_','n');
save -append FIANL_wind_midlat_rot_comps sst_*
% % 
% % _*
% % % % % 
% % % % 
% % % % % 
% % % % % [rot_sim_wek_a,rot_sim_wek_c]=comps(x,y,cyc,k,id,track_jday,scale,'sim_wek','~/data/QuickScat/new_mat/QSCAT_30_25km_','w');
% % % % % save -append FIANL_wind_midlat_rot_comps rot_sim_*
% % % % % [sim_wek_a,sim_wek_c]=comps(x,y,cyc,k,id,track_jday,scale,'sim_wek','~/data/QuickScat/new_mat/QSCAT_30_25km_','n');
% % % % % save -append FIANL_wind_midlat_rot_comps sim_*
% % % 
% [clean_wek_a,clean_wek_c]=comps(x,y,cyc,k,id,track_jday,scale,'wek','~/data/QuickScat/FINAL_mat/QSCAT_30_25km_','n');
% save -append FIANL_wind_midlat_rot_comps clean_wek_c clean_wek_a
[wek_a,wek_c]=comps(x,y,cyc,k,id,track_jday,scale,'wek','~/data/QuickScat/ULTI_mat2/QSCAT_30_25km_','n');
save -append FIANL_wind_midlat_rot_comps wek_c wek_a
[rot_wek_a,rot_wek_c]=comps(x,y,cyc,k,id,track_jday,scale,'wek','~/data/QuickScat/ULTI_mat2/QSCAT_30_25km_','w');
save -append FIANL_wind_midlat_rot_comps rot_wek_a rot_wek_c
% return
% % % % [rot_raw_wek_a,rot_raw_wek_c]=comps(x,y,cyc,k,id,track_jday,scale,'wek','~/data/QuickScat/new_mat/QSCAT_30_25km_','w');
% % % % save -append FIANL_wind_midlat_rot_comps rot_raw_wek_a rot_raw_wek_c
% % % 
% % % % % 
[rot_w_ek_crlg_a,rot_w_ek_crlg_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp_wek_crlg_week','~/data/QuickScat/ULTI_mat2/QSCAT_30_25km_','w');
save -append FIANL_wind_midlat_rot_comps rot_*
% return
[wek_crlg_a,wek_crlg_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp_wek_crlg_week','~/data/QuickScat/ULTI_mat2/QSCAT_30_25km_','n');
save -append FIANL_wind_midlat_rot_comps wek_*

[wek_crlg_a,wek_crlg_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp_wek_crlg_week','~/data/QuickScat/ULTI_mat2/QSCAT_30_25km_','n');
save -append FIANL_wind_midlat_rot_comps wek_*
% % % % % 
[rot_w_ek_sst_a,rot_w_ek_sst_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp_wek_sst_week_dtdn','~/data/QuickScat/ULTI_mat2/QSCAT_30_25km_','w');
save -append FIANL_wind_midlat_rot_comps rot_*

[rot_w_ek_sst_fixed_a,rot_w_ek_fixed_sst_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp_wek_sst_week_fixed','~/data/QuickScat/ULTI_mat2/QSCAT_30_25km_','w');
save -append FIANL_wind_midlat_rot_comps rot_*

[wek_sst_a,wek_sst_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp_wek_sst_week_dtdn','~/data/QuickScat/ULTI_mat2/QSCAT_30_25km_','n');
save -append FIANL_wind_midlat_rot_comps wek_*

[wek_sst_fixed_a,wek_sst_fixed_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp_wek_sst_week_fixed','~/data/QuickScat/ULTI_mat2/QSCAT_30_25km_','n');
save -append FIANL_wind_midlat_rot_comps wek_*
% % % % % % 
% % % % % 
% % % % % % %save -append new_midlat_comps
% % % % save -append FIANL_wind_midlat_rot_comps
% % % % % 


% %}
load FIANL_wind_midlat_rot_comps
% %	
% dir_c=rad2deg(cart2pol(rot_u_c.mean,rot_v_c.mean));
% dir_a=rad2deg(cart2pol(rot_u_a.mean,rot_v_a.mean));
% dir_c(17,17)
% dir_a(17,17)
% return
% pcomps_raw(dir_c,dir_c,[-5 5],-180,10,180,['Direction of SM Wind'],1,30)
% pcomps_raw(dir_a,dir_a,[-5 5],-180,10,180,['Direction of SM Wind'],1,30)

% return

pcomps_raw(smoothn(rot_wspd_c.mean,2),smoothn(rot_wspd_c.mean,3),[-.1 .1],-1,.02,1,['QuikSCAT WSPD'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/rot_wspd_c'])

pcomps_raw(smoothn(rot_wspd_a.mean,2),smoothn(rot_wspd_a.mean,3),[-.1 .1],-1,.02,1,['QuikSCAT WSPD'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/rot_wspd_a'])

pcomps_raw(rot_sst_c.mean,rot_sst_c.mean,[-.5 .5],-1,.05,1,['NOAA SST'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/rot_sst_c'])

pcomps_raw(rot_sst_a.mean,rot_sst_a.mean,[-.5 .5],-1,.05,1,['NOAA SST'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/rot_sst_a'])

pcomps_raw(smoothn(wspd_c.mean,2),smoothn(wspd_c.mean,3),[-.1 .1],-1,.02,1,['QuikSCAT WSPD'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/wspd_c'])

pcomps_raw(smoothn(wspd_a.mean,2),smoothn(wspd_a.mean,3),[-.1 .1],-1,.02,1,['QuikSCAT WSPD'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/wspd_a'])

pcomps_raw(sst_c.mean,sst_c.mean,[-.5 .5],-1,.05,1,['NOAA SST'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/sst_c'])

pcomps_raw(sst_a.mean,sst_a.mean,[-.5 .5],-1,.05,1,['NOAA SST'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/sst_a'])

return
% pcomps_raw2(wek_crlg_c.mean-(wek_sst_c.mean),wek_crlg_c.mean-(wek_sst_c.mean),[-10 10],-100,1,100,['current+SST Ekman pumping'],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/w_ek_tot_c_mean'])
% 
% pcomps_raw2(wek_crlg_a.mean-(wek_sst_a.mean),wek_crlg_a.mean-(wek_sst_a.mean),[-10 10],-100,1,100,['current+SST Ekman pumping'],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/w_ek_tot_a_mean'])
% return
% 


% pcomps_raw2(wek_crlg_c.mean,(wek_crlg_c.mean),[-6 6],-100,.5,100,['current-induced Ekman pumping'],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/w_ek_crlg_c_mean_mike'])
% 
% pcomps_raw2(wek_crlg_a.mean,(wek_crlg_a.mean),[-6 6],-100,.5,100,['current-induced Ekman pumping'],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/w_ek_crlg_a_mean_mike'])
% 

% pcomps_raw2(100*rot_raw_wek_c.mean,(100*rot_raw_wek_c.mean),[-.1 .1],-1,.01,1,['QuikSCAT Ekman pumping'],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/rot_w_ek_c_mean'])
% 
% pcomps_raw2(100*rot_raw_wek_a.mean,(100*rot_raw_wek_a.mean),[-.1 .1],-1,.01,1,['QuikSCAT Ekman pumping'],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/rot_w_ek_a_mean'])
% return
% % 
% pcomps_raw2(wek_c.mean,(wek_c.mean),[-10 10],-100,1,100,['QuikSCAT Ekman pumping'],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/w_ek_c_mean'])
% 
% pcomps_raw2(wek_a.mean,(wek_a.mean),[-10 10],-100,1,100,['QuikSCAT Ekman pumping'],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/w_ek_a_mean'])
% return
% pcomps_raw(rot_sst_c.mean,rot_sst_c.mean,[-.1 .1],-1,.01,1,['SST clockwise N=',num2str(rot_sst_c.n_max_sample)],1,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/rot_sst_cw'])
% 
% pcomps_raw(rot_sst_a.mean,rot_sst_a.mean,[-.1 .1],-1,.01,1,['SST counterclockwise N=',num2str(rot_sst_a.n_max_sample)],1,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/rot_sst_cc'])
% 
% 
% pcomps_raw(rot_wspd_c.mean,rot_wspd_c.mean,[-.1 .1],-1,.01,1,['WSPD clockwise N=',num2str(rot_wspd_c.n_max_sample)],1,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/rot_wspd_cw'])
% 
% pcomps_raw(rot_wspd_a.mean,rot_wspd_a.mean,[-.1 .1],-1,.01,1,['WSPD counterclockwise N=',num2str(rot_wspd_a.n_max_sample)],1,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/rot_wspd_cc'])
% return
% return
% pcomps_raw(sim_wek_c.mean,sim_wek_c.mean,[-6 6],-100,1,100,['Simulated Ekman Pumping cyclones N=',num2str(sim_wek_c.n_max_sample)],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/sim_w_ek_c'])
% 
% pcomps_raw(sim_wek_a.mean,sim_wek_a.mean,[-6 6],-100,1,100,['Simulated Ekman Pumping anticyclones N=',num2str(sim_wek_a.n_max_sample)],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/sim_w_ek_a'])

% pcomps_raw(rot_sim_wek_c.mean,rot_sim_wek_c.mean,[-10 10],-100,1,100,['Simulated Ekman Pumping cyclones N=',num2str(sim_wek_c.n_max_sample)],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/rot_sim_w_ek_c'])
% 
% pcomps_raw(rot_sim_wek_a.mean,rot_sim_wek_a.mean,[-10 10],-100,1,100,['Simulated Ekman Pumping anticyclones N=',num2str(sim_wek_a.n_max_sample)],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/rot_sim_w_ek_a'])

% pcomps_raw2(wek_crlg_c.mean,smoothn(wek_crlg_c.mean,2),[-10 10],-100,1,100,['current-induced Ekman pumping'],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/w_ek_crlg_c_mean'])
% 
% pcomps_raw2(wek_crlg_a.mean,smoothn(wek_crlg_a.mean,2),[-10 10],-100,1,100,['current-induced Ekman pumping'],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/w_ek_crlg_a_mean'])
% % % 
% pcomps_raw2(rot_w_ek_crlg_c.mean,smoothn(rot_w_ek_crlg_c.mean,2),[-10 10],-100,1,100,['current-induced Ekman pumping'],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/rot_w_ek_crlg_c_mean'])
% 
% pcomps_raw2(rot_w_ek_crlg_a.mean,smoothn(rot_w_ek_crlg_a.mean,2),[-10 10],-100,1,100,['current-induced Ekman pumping'],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/rot_w_ek_crlg_a_mean'])

% pcomps_raw2(wek_c.mean,smoothn(wek_c.mean,1),[-.1 .1],-1,.01,1,['QuikSCAT Ekman pumping'],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/w_ek_c_mean'])
% 
% pcomps_raw2(wek_a.mean,smoothn(wek_a.mean,1),[-.1 .1],-1,.01,1,['QuikSCAT Ekman pumping'],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/w_ek_a_mean'])
% 
% pcomps_raw2((rot_wek_c.mean),(rot_wek_c.mean),[-10 10],-100,1,100,['QuikSCAT Ekman pumping'],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/rot_w_ek_c_mean'])
% 
% pcomps_raw2((rot_wek_a.mean),(rot_wek_a.mean),[-10 10],-100,1,100,['QuikSCAT Ekman pumping'],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/rot_w_ek_a_mean'])

% % 
% pcomps_raw2(rot_wek_c.mean,smoothn(rot_wek_c.mean,1),[-.1 .1],-1,.01,1,['QuikSCAT Ekman pumping'],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/rot_w_ek_c_mean'])
% 
% pcomps_raw2(rot_wek_a.mean,smoothn(rot_wek_a.mean,1),[-.1 .1],-1,.01,1,['QuikSCAT Ekman pumping'],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/rot_w_ek_a_mean'])
% % 
pcomps_raw2(-(wek_sst_c.mean),-(wek_sst_c.mean),[-1 1],-100,.1,100,['SST-induced Ekman pumping'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/w_ek_sst_c_mean'])

pcomps_raw2(-(wek_sst_a.mean),-(wek_sst_a.mean),[-1 1],-100,.1,100,['SST-induced Ekman pumping'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/w_ek_sst_a_mean'])

pcomps_raw2(-(rot_w_ek_sst_c.mean),-(rot_w_ek_sst_c.mean),[-1 1],-100,.1,100,['SST-induced Ekman pumping'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/rot_w_ek_sst_c_mean'])

pcomps_raw2(-(rot_w_ek_sst_a.mean),-(rot_w_ek_sst_a.mean),[-1 1],-100,.1,100,['SST-induced Ekman pumping'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/rot_w_ek_sst_a_mean'])

% pcomps_raw2(rot_w_ek_crlg_c.mean-(rot_w_ek_sst_c.mean),rot_w_ek_crlg_c.mean-smoothn(rot_w_ek_sst_c.mean,2),[-10 10],-100,1,100,['current+SST Ekman pumping'],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/rot_w_ek_tot_c_mean'])
% 
% pcomps_raw2(rot_w_ek_crlg_a.mean-1.2*(rot_w_ek_sst_a.mean),rot_w_ek_crlg_a.mean-1.2*smoothn(rot_w_ek_sst_a.mean,2),[-10 10],-100,1,100,['current+SST Ekman pumping'],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/rot_w_ek_tot_a_mean'])

% pcomps_raw2(-(rot_w_ek_fixed_c.mean),-(rot_w_ek_fixed_c.mean),[-1 1],-100,.1,100,['SST-induced Ekman pumping'],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/rot_w_ek_fixed_c_mean'])
% 
% pcomps_raw2(-(rot_w_ek_fixed_a.mean),-(rot_w_ek_fixed_a.mean),[-1 1],-100,.1,100,['SST-induced Ekman pumping'],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/rot_w_ek_fixed_a_mean'])

pcomps_raw2(-(wek_sst_fixed_c.mean),-(wek_sst_fixed_c.mean),[-1 1],-100,.1,100,['SST-induced Ekman pumping'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/w_ek_fixed_c_mean'])

pcomps_raw2(-(wek_sst_fixed_a.mean),-(wek_sst_fixed_a.mean),[-1 1],-100,.1,100,['SST-induced Ekman pumping'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/w_ek_fixed_a_mean'])
% 
% 
% 
% pcomps_raw2(wek_crlg_c.mean-(wek_sst_fixed_c.mean),wek_crlg_c.mean-(wek_sst_fixed_c.mean),[-10 10],-100,1,100,['current+SST Ekman pumping'],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/w_ek_tot_fixed_c_mean'])
% 
% pcomps_raw2(wek_crlg_a.mean-(wek_sst_fixed_a.mean),wek_crlg_a.mean-(wek_sst_fixed_a.mean),[-10 10],-100,1,100,['current+SST Ekman pumping'],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/w_ek_tot_fixed_a_mean'])


% pcomps_raw2(rot_w_ek_crlg_c.mean-(rot_w_ek_fixed_c.mean),rot_w_ek_crlg_c.mean-smoothn(rot_w_ek_fixed_c.mean,2),[-10 10],-100,1,100,['current+SST Ekman pumping'],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/rot_w_ek_tot_fixed_c_mean'])
% 
% pcomps_raw2(rot_w_ek_crlg_a.mean-(rot_w_ek_fixed_a.mean),rot_w_ek_crlg_a.mean-smoothn(rot_w_ek_fixed_a.mean,2),[-10 10],-100,1,100,['current+SST Ekman pumping'],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/rot_w_ek_tot_fixed_a_mean'])

% pcomps_raw2(rot_w_ek_crlg_c.mean-2*smoothn(rot_w_ek_sst_c.mean,2),rot_w_ek_crlg_c.mean-2*smoothn(rot_w_ek_sst_c.mean,2),[-10 10],-100,1,100,['current+SST Ekman pumping'],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/rot_w_ek_tot_c_mean_test'])
% % 
% pcomps_raw2(rot_w_ek_crlg_a.mean-2*smoothn(rot_w_ek_sst_a.mean,2),rot_w_ek_crlg_a.mean-2*smoothn(rot_w_ek_sst_a.mean,2),[-10 10],-100,1,100,['current+SST Ekman pumping'],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/rot_w_ek_tot_a_mean_test'])
% 
