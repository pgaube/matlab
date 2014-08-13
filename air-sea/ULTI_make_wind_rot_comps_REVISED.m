



% 
% 
%%%%%
% Southern Hemi
% %%%%%
clear
load tracks/midlat_tracks k x y id cyc track_jday age scale
ii=find(track_jday>=2452427 & track_jday<=2455159 & age>=12 & y<=-15);
x=x(ii);
y=y(ii);
k=k(ii);
id=id(ii);
track_jday=track_jday(ii);
cyc=cyc(ii);
scale=scale(ii);

num_a=length(find(cyc==1))
num_c=length(find(cyc==-1))

% % 
% % %From SST
% % [dtdn_a,dtdn_c]=comps(x,y,cyc,k,id,track_jday,scale,'norm_hp66_dtdn','~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_','w');
% % save -append ULTI_wind_SH_comps *
% [w_ek_sst_fixed_a,w_ek_sst_fixed_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp_wek_sst_week_fixed','~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_','w');
% save -append ULTI_wind_SH_comps *
% % [w_ek_sst_a,w_ek_sst_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp_wek_sst_week_cross','~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_','w');
% % save -append ULTI_wind_SH_comps *
% % [noro_w_ek_sst_a,noro_w_ek_sst_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp_wek_sst_week_cross','~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_','n');
% % save -append ULTI_wind_SH_comps *
% [noro_w_ek_sst_fixed_a,noro_w_ek_sst_fixed_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp_wek_sst_week_fixed','~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_','n');
% save -append ULTI_wind_SH_comps *
% % 
% % %From QSCAT
% % [w_ek_zeta_qscat_a,w_ek_zeta_qscat_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp_zeta_wek_qscat','~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_','w');
% % save -append ULTI_wind_SH_comps *
% [noro_w_ek_total_qscat_a,noro_w_ek_total_qscat_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp_total_wek_qscat2','~/data/QuickScat/ULTI_mat5/QSCAT_30_25km_','n');
% save -append ULTI_wind_SH_comps *
% 
% % % [w_ek_crlg_qscat_a,w_ek_crlg_qscat_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp_crl_wek_qscat','~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_','w');
% % % save -append ULTI_wind_SH_comps *
% % % 
% [w_ek_total_qscat_a,w_ek_total_qscat_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp_total_wek_qscat2','~/data/QuickScat/ULTI_mat5/QSCAT_30_25km_','w');
% save -append ULTI_wind_SH_comps *
% % % 
% % % %Estimated
% % % [w_ek_zeta_a,w_ek_zeta_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp_zeta_wek','~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_','w');
% % % save -append ULTI_wind_SH_comps *
% % % 
% % % [w_ek_crlg_a,w_ek_crlg_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp_crl_wek','~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_','w');
% % % save -append ULTI_wind_SH_comps *
% % % 
% [w_ek_total_a,w_ek_total_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp_total_wek_est2','~/data/QuickScat/ULTI_mat5/QSCAT_30_25km_','w');
% save -append ULTI_wind_SH_comps *
[noro_w_ek_total_a,noro_w_ek_total_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp_total_wek_est2','~/data/QuickScat/ULTI_mat5/QSCAT_30_25km_','n');
save -append ULTI_wind_SH_comps *
% return
% % 
% % % return
% % 
% %%%%%
% Northern Hemi
% %%%%%%%
clear
load tracks/midlat_tracks k x y id cyc track_jday age scale
ii=find(track_jday>=2452427 & track_jday<=2455159 & age>=12 & y>=15);
x=x(ii);
y=y(ii);
k=k(ii);
id=id(ii);
track_jday=track_jday(ii);
cyc=cyc(ii);
scale=scale(ii);

num_a=length(find(cyc==1))
num_c=length(find(cyc==-1))
% % 
% % 
% % %%From SST
% % [dtdn_a,dtdn_c]=comps(x,y,cyc,k,id,track_jday,scale,'norm_hp66_dtdn','~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_','w');
% % save -append ULTI_wind_NH_comps *
% [w_ek_sst_fixed_a,w_ek_sst_fixed_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp_wek_sst_week_fixed','~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_','w');
% save -append ULTI_wind_NH_comps *
% % 
% % [w_ek_sst_a,w_ek_sst_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp_wek_sst_week_cross','~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_','w');
% % save -append ULTI_wind_NH_comps *
% % [noro_w_ek_sst_a,noro_w_ek_sst_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp_wek_sst_week_cross','~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_','n');
% % save -append ULTI_wind_NH_comps *
% [noro_w_ek_sst_fixed_a,noro_w_ek_sst_fixed_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp_wek_sst_week_fixed','~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_','n');
% save -append ULTI_wind_NH_comps *
% % %From QSCAT
% % [w_ek_zeta_qscat_a,w_ek_zeta_qscat_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp_zeta_wek_qscat','~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_','w');
% % save -append ULTI_wind_NH_comps *
% % 
% % [w_ek_crlg_qscat_a,w_ek_crlg_qscat_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp_crl_wek_qscat','~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_','w');
% % save -append ULTI_wind_NH_comps *
% % 
[w_ek_total_qscat_a,w_ek_total_qscat_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp_total_wek_qscat2','~/data/QuickScat/ULTI_mat5/QSCAT_30_25km_','w');
save -append ULTI_wind_NH_comps *
[noro_w_ek_total_qscat_a,noro_w_ek_total_qscat_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp_total_wek_qscat2','~/data/QuickScat/ULTI_mat5/QSCAT_30_25km_','n');
save -append ULTI_wind_NH_comps *
% % %Estimated
% % [w_ek_zeta_a,w_ek_zeta_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp_zeta_wek','~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_','w');
% % save -append ULTI_wind_NH_comps *
% % 
% % 
% % [w_ek_crlg_a,w_ek_crlg_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp_crl_wek','~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_','w');
% % save -append ULTI_wind_NH_comps *
% % 
[w_ek_total_a,w_ek_total_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp_total_wek_est2','~/data/QuickScat/ULTI_mat5/QSCAT_30_25km_','w');
save -append ULTI_wind_NH_comps *
[noro_w_ek_total_a,noro_w_ek_total_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp_total_wek_est2','~/data/QuickScat/ULTI_mat5/QSCAT_30_25km_','n');
save -append ULTI_wind_NH_comps *
% return
% % 

% 


