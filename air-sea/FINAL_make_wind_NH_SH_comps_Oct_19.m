clear all

load tracks/midlat_tracks	
ii=find(track_jday>=2452427 & track_jday<=2455159 & y>0 & age>=12);
x=x(ii);
y=y(ii);
k=k(ii);
id=id(ii);
track_jday=track_jday(ii);
cyc=cyc(ii);
scale=scale(ii);


[NH_zeta_w_ek_a,NH_zeta_w_ek_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp_zeta_wek','~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_','n');
[NH_w_ek_a,NH_w_ek_c]=comps(x,y,cyc,k,id,track_jday,scale,'wek','~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_','n');
% [NH_crlg_w_ek_a,NH_crlg_w_ek_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp_wek_crlg_week','~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_','n');
% [NH_vort_a,NH_vort_c]=comps(x,y,cyc,k,id,track_jday,scale,'sm_wind_crl','~/data/QuickScat/new_mat/QSCAT_30_25km_','n');

save -append FIANL_midlat_comps_Oct_19 NH_*

clear all
return

% 
load tracks/midlat_tracks	
ii=find(track_jday>=2452427 & track_jday<=2455159 & y<0 & age>=12);
x=x(ii);
y=y(ii);
k=k(ii);
id=id(ii);
track_jday=track_jday(ii);
cyc=cyc(ii);
scale=scale(ii);


[SH_w_ek_a,SH_w_ek_c]=comps(x,y,cyc,k,id,track_jday,scale,'wek','~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_','n');
% [SH_crlg_w_ek_a,SH_crlg_w_ek_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp_wek_crlg_week','~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_','n');
% [SH_vort_a,SH_vort_c]=comps(x,y,cyc,k,id,track_jday,scale,'sm_wind_crl','~/data/QuickScat/new_mat/QSCAT_30_25km_','n');
save -append FIANL_midlat_comps_Oct_19 SH_*
% return

load FIANL_midlat_comps_Oct_19

pcomps_raw2(NH_vort_c.mean,NH_vort_c.mean,[-10 10],-100,1,100,['Cyclones                N=',num2str(NH_vort_c.n_max_sample)],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/NH_vort_c_mean'])
pcomps_raw2(NH_vort_a.mean,NH_vort_a.mean,[-10 10],-100,1,100,['Anticyclones            N=',num2str(NH_vort_a.n_max_sample)],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/NH_vort_a_mean'])

pcomps_raw2(SH_vort_c.mean,SH_vort_c.mean,[-10 10],-100,1,100,['Cyclones                N=',num2str(SH_vort_c.n_max_sample)],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/SH_vort_c_mean'])
pcomps_raw2(SH_vort_a.mean,SH_vort_a.mean,[-10 10],-100,1,100,['Anticyclones            N=',num2str(SH_vort_a.n_max_sample)],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/SH_vort_a_mean'])

pcomps_raw2(NH_vort_c.mean,NH_vort_c.mean,[-10 10],-100,1,100,['Cyclones                N=',num2str(NH_vort_c.n_max_sample)],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/NH_vort_c_mean'])
pcomps_raw2(NH_vort_a.mean,NH_vort_a.mean,[-10 10],-100,1,100,['Anticyclones            N=',num2str(NH_vort_a.n_max_sample)],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/NH_vort_a_mean'])

pcomps_raw2(SH_vort_c.mean,SH_vort_c.mean,[-10 10],-100,1,100,['Cyclones                N=',num2str(SH_vort_c.n_max_sample)],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/SH_vort_c_mean'])
pcomps_raw2(SH_vort_a.mean,SH_vort_a.mean,[-10 10],-100,1,100,['Anticyclones            N=',num2str(SH_vort_a.n_max_sample)],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/SH_vort_a_mean'])

% pcomps_raw2(NH_w_ek_c.mean,NH_w_ek_c.mean,[-10 10],-100,1,100,['Cyclones                N=',num2str(NH_w_ek_c.n_max_sample)],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/NH_w_ek_c_mean'])
% pcomps_raw2(NH_w_ek_a.mean,NH_w_ek_a.mean,[-10 10],-100,1,100,['Anticyclones            N=',num2str(NH_w_ek_a.n_max_sample)],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/NH_w_ek_a_mean'])
% 
% pcomps_raw2(SH_w_ek_c.mean,SH_w_ek_c.mean,[-10 10],-100,1,100,['Cyclones                N=',num2str(SH_w_ek_c.n_max_sample)],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/SH_w_ek_c_mean'])
% pcomps_raw2(SH_w_ek_a.mean,SH_w_ek_a.mean,[-10 10],-100,1,100,['Anticyclones            N=',num2str(SH_w_ek_a.n_max_sample)],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/SH_w_ek_a_mean'])
% 
% pcomps_raw2(NH_crlg_w_ek_c.mean,NH_crlg_w_ek_c.mean,[-10 10],-100,1,100,['Cyclones                N=',num2str(NH_w_ek_c.n_max_sample)],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/NH_crlg_w_ek_c_mean'])
% pcomps_raw2(NH_crlg_w_ek_a.mean,NH_crlg_w_ek_a.mean,[-10 10],-100,1,100,['Anticyclones            N=',num2str(NH_w_ek_a.n_max_sample)],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/NH_crlg_w_ek_a_mean'])
% 
% pcomps_raw2(SH_crlg_w_ek_c.mean,SH_crlg_w_ek_c.mean,[-10 10],-100,1,100,['Cyclones                N=',num2str(SH_w_ek_c.n_max_sample)],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/SH_crlg_w_ek_c_mean'])
% pcomps_raw2(SH_crlg_w_ek_a.mean,SH_crlg_w_ek_a.mean,[-10 10],-100,1,100,['Anticyclones            N=',num2str(SH_w_ek_a.n_max_sample)],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/SH_crlg_w_ek_a_mean'])
