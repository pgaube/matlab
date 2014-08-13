
clear all

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
% %MIDLAT
%%%%
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
% 
% 
% %From SST
% [w_ek_sst_fixed_a,w_ek_sst_fixed_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp_wek_sst_week_fixed','~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_','w');
% save -append ULTI_wind_midlat_rot_comps w_ek_*
% % [dtdn_a,dtdn_c]=comps(x,y,cyc,k,id,track_jday,scale,'norm_hp66_dtdn','~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_','w');
% % save -append ULTI_wind_midlat_rot_comps w_ek_*

[w_ek_total_qscat_a,w_ek_total_qscat_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp_total_wek_qscat','~/data/QuickScat/ULTI_mat5/QSCAT_30_25km_','w');
save -append ULTI_wind_midlat_rot_comps w_ek_*

% [w_ek_total_a,w_ek_total_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp_total_wek_est','~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_','w');
% save -append ULTI_wind_midlat_rot_comps w_ek_*

% 


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

[w_ek_total_qscat_a,w_ek_total_qscat_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp_total_wek_qscat','~/data/QuickScat/ULTI_mat5/QSCAT_30_25km_','w');
save -append ULTI_wind_SH_comps *

% [w_ek_total_a,w_ek_total_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp_total_wek_est','~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_','w');
% save -append ULTI_wind_SH_comps *

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

[w_ek_total_qscat_a,w_ek_total_qscat_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp_total_wek_qscat','~/data/QuickScat/ULTI_mat5/QSCAT_30_25km_','w');
save -append ULTI_wind_NH_comps *

% [w_ek_total_a,w_ek_total_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp_total_wek_est','~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_','w');
% save -append ULTI_wind_NH_comps *

% % 

% % 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% return
load region_crlstr_dtdn_coupling_coeff alpha_n
alpha_n_round=-round(1000*alpha_n(9))/1000


load ULTI_wind_midlat_rot_comps

% pcomps_raw2(1.2*w_ek_total_qscat_c.mean,1.2*w_ek_total_qscat_c.mean,[-10 10],-100,1,100,['W_{tot}'],2,30)
pcomps_raw2(w_ek_total_qscat_c.mean,w_ek_total_qscat_c.mean,[-10 10],-100,1,100,['W_{tot}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/GAUBE_wek_total_qscat_c'])

% pcomps_raw2(1.35*w_ek_total_qscat_a.mean,1.35*w_ek_total_qscat_a.mean,[-10 10],-100,1,100,['W_{tot}'],2,30)
pcomps_raw2(w_ek_total_qscat_a.mean,w_ek_total_qscat_a.mean,[-10 10],-100,1,100,['W_{tot}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/GAUBE_wek_total_qscat_a'])

pcomps_raw2(1.1*w_ek_total_c.mean,1.1*w_ek_total_c.mean,[-10 10],-100,1,100,['W_{cur}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/GAUBE_wek_total_c'])

pcomps_raw2(w_ek_total_a.mean,w_ek_total_a.mean,[-10 10],-100,1,100,['W_{cur}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/GAUBE_wek_total_a'])

pcomps_raw2(1.1*w_ek_total_c.mean+(0.013/0.01)*w_ek_sst_fixed_c.mean,1.1*w_ek_total_c.mean+(0.013/0.01)*w_ek_sst_fixed_c.mean,[-10 10],-100,1,100,['W_{cur}+W_{SST}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/GAUBE_wek_add_fixed_c'])

pcomps_raw2(w_ek_total_a.mean+(0.013/0.01)*w_ek_sst_fixed_a.mean,w_ek_total_a.mean+(0.013/0.01)*w_ek_sst_fixed_a.mean,[-10 10],-100,1,100,['W_{cur}+W_{SST}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/GAUBE_wek_add_fixed_a'])

pcomps_raw2((0.013/0.01)*w_ek_sst_fixed_c.mean,(0.013/0.01)*w_ek_sst_fixed_c.mean,[-2 2],-100,.2,100,['W_{SST}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/GAUBE_wek_sst_fixed_c'])

pcomps_raw2((0.013/0.01)*w_ek_sst_fixed_a.mean,(0.013/0.01)*w_ek_sst_fixed_a.mean,[-2 2],-100,.2,100,['W_{SST}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/GAUBE_wek_sst_fixed_a'])
% return

load ULTI_wind_NH_comps

pcomps_raw2(w_ek_total_qscat_c.mean,w_ek_total_qscat_c.mean,[-10 10],-100,1,100,['W_{tot}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/GAUBE_nh_wek_total_qscat_c'])

pcomps_raw2(w_ek_total_qscat_a.mean,w_ek_total_qscat_a.mean,[-10 10],-100,1,100,['W_{tot}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/GAUBE_nh_wek_total_qscat_a'])

pcomps_raw2(w_ek_total_c.mean,w_ek_total_c.mean,[-10 10],-100,1,100,['W_{cur}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/GAUBE_nh_wek_total_c'])

pcomps_raw2(w_ek_total_a.mean,w_ek_total_a.mean,[-10 10],-100,1,100,['W_{cur}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/GAUBE_nh_wek_total_a'])

pcomps_raw2(w_ek_total_c.mean+(0.013/0.01)*w_ek_sst_fixed_c.mean,w_ek_total_c.mean+(0.013/0.01)*w_ek_sst_fixed_c.mean,[-10 10],-100,1,100,['W_{cur}+W_{SST}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/GAUBE_nh_wek_add_fixed_c'])

pcomps_raw2(w_ek_total_a.mean+(0.013/0.01)*w_ek_sst_fixed_a.mean,w_ek_total_a.mean+(0.013/0.01)*w_ek_sst_fixed_a.mean,[-10 10],-100,1,100,['W_{cur}+W_{SST}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/GAUBE_nh_wek_add_fixed_a'])

pcomps_raw2((0.013/0.01)*w_ek_sst_fixed_c.mean,(0.013/0.01)*w_ek_sst_fixed_c.mean,[-2 2],-100,.2,100,['W_{SST}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/GAUBE_nh_wek_sst_fixed_c'])

pcomps_raw2((0.013/0.01)*w_ek_sst_fixed_a.mean,(0.013/0.01)*w_ek_sst_fixed_a.mean,[-2 2],-100,.2,100,['W_{SST}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/GAUBE_nh_wek_sst_fixed_a'])
% return


load ULTI_wind_SH_comps

pcomps_raw2(w_ek_total_qscat_c.mean,w_ek_total_qscat_c.mean,[-10 10],-100,1,100,['W_{tot}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/GAUBE_sh_wek_total_qscat_c'])

pcomps_raw2(w_ek_total_qscat_a.mean,w_ek_total_qscat_a.mean,[-10 10],-100,1,100,['W_{tot}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/GAUBE_sh_wek_total_qscat_a'])

pcomps_raw2(w_ek_total_c.mean,w_ek_total_c.mean,[-10 10],-100,1,100,['W_{cur}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/GAUBE_sh_wek_total_c'])

pcomps_raw2(w_ek_total_a.mean,w_ek_total_a.mean,[-10 10],-100,1,100,['W_{cur}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/GAUBE_sh_wek_total_a'])

pcomps_raw2(w_ek_total_c.mean+(0.013/0.01)*w_ek_sst_fixed_c.mean,w_ek_total_c.mean+(0.013/0.01)*w_ek_sst_fixed_c.mean,[-10 10],-100,1,100,['W_{cur}+W_{SST}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/GAUBE_sh_wek_add_fixed_c'])

pcomps_raw2(w_ek_total_a.mean+(0.013/0.01)*w_ek_sst_fixed_a.mean,w_ek_total_a.mean+(0.013/0.01)*w_ek_sst_fixed_a.mean,[-10 10],-100,1,100,['W_{cur}+W_{SST}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/GAUBE_sh_wek_add_fixed_a'])

pcomps_raw2((0.013/0.01)*w_ek_sst_fixed_c.mean,(0.013/0.01)*w_ek_sst_fixed_c.mean,[-2 2],-100,.2,100,['W_{SST}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/GAUBE_sh_wek_sst_fixed_c'])

pcomps_raw2((0.013/0.01)*w_ek_sst_fixed_a.mean,(0.013/0.01)*w_ek_sst_fixed_a.mean,[-2 2],-100,.2,100,['W_{SST}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/GAUBE_sh_wek_sst_fixed_a'])
return


