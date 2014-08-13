
clear all
% 
load ~/data/eddy/V6/global_tracks_ext_V6

f1=find(abs(ext_y)>=15 & abs(ext_y)<=45 & track_jdays>=2452427);
	id=id(f1);
	x=ext_x(f1);
	y=ext_y(f1);
	scale=l(f1);
	track_jday=track_jdays(f1);
	cyc=cyc(f1);
	k=k(f1);
    age=age(f1);
    axial_speed=u(f1);
    amp=a(f1);
save tracks/midlat_tracks k cyc track_jday scale y x id	age axial_speed amp
return


% % 
load tracks/midlat_tracks k x y id cyc track_jday age scale
ii=find(track_jday>=2452427 & track_jday<=2455159 & age>=12);
x=x(ii);
y=y(ii);
k=k(ii);
id=id(ii);
track_jday=track_jday(ii);
cyc=cyc(ii);
scale=scale(ii);

num_a=length(find(cyc==1))
num_c=length(find(cyc==-1))
return
% 
% [rot_wek_a,rot_wek_c]=comps(x,y,cyc,k,id,track_jday,scale,'wek','~/data/QuickScat/ULTI_mat2/QSCAT_30_25km_','w');
% save -append FIANL_wind_midlat_rot_comps_sept_20 rot_wek_a rot_wek_c
% 
% [rot_w_ek_crlg_a,rot_w_ek_crlg_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp_wek_crlg_week','~/data/QuickScat/ULTI_mat2/QSCAT_30_25km_','w');
% save -append FIANL_wind_midlat_rot_comps rot_*
% 
% [rot_w_ek_sst_a,rot_w_ek_sst_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp_wek_sst_week_dtdn','~/data/QuickScat/ULTI_mat2/QSCAT_30_25km_','w');
% save -append FIANL_wind_midlat_rot_comps rot_*
% 
% 
% 
load FIANL_wind_midlat_rot_comps

pcomps_raw2(rot_wek_c.mean,rot_wek_c.mean,[-10 10],-100,1,100,['QuikSCAT Ekman pumping'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/rot_w_ek_c_mean'])

pcomps_raw2(rot_wek_a.mean,rot_wek_a.mean,[-10 10],-100,1,100,['QuikSCAT Ekman pumping'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/rot_w_ek_a_mean'])

pcomps_raw2(-rot_w_ek_sst_c.mean,-rot_w_ek_sst_c.mean,[-1 1],-100,.1,100,['SST-induced Ekman pumping'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/rot_w_ek_sst_c_mean'])

pcomps_raw2(-rot_w_ek_sst_a.mean,-rot_w_ek_sst_a.mean,[-1 1],-100,.1,100,['SST-induced Ekman pumping'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/rot_w_ek_sst_a_mean'])

pcomps_raw2(rot_w_ek_crlg_c.mean,rot_w_ek_crlg_c.mean,[-10 10],-100,1,100,['current-induced Ekman pumping'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/rot_w_ek_crlg_c_mean'])

pcomps_raw2(rot_w_ek_crlg_a.mean,rot_w_ek_crlg_a.mean,[-10 10],-100,1,100,['current-induced Ekman pumping'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/rot_w_ek_crlg_a_mean'])

pcomps_raw2(rot_w_ek_crlg_c.mean-rot_w_ek_sst_c.mean,rot_w_ek_crlg_c.mean-rot_w_ek_sst_c.mean,[-10 10],-100,1,100,['current+SST Ekman pumping'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/rot_w_ek_tot_c_mean'])

pcomps_raw2(rot_w_ek_crlg_a.mean-rot_w_ek_sst_a.mean,rot_w_ek_crlg_a.mean-rot_w_ek_sst_a.mean,[-10 10],-100,1,100,['current+SST Ekman pumping'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/rot_w_ek_tot_a_mean'])

