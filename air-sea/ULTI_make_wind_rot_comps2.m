
clear all
% 
% % load ~/data/eddy/V6/global_tracks_ext_V6
% 
% % f1=find(abs(ext_y)>=15 & abs(ext_y)<=45 & track_jdays>=2452427);
% % 	id=id(f1);
% % 	x=ext_x(f1);
% % 	y=ext_y(f1);
% % 	scale=l(f1);
% % 	track_jday=track_jdays(f1);
% % 	cyc=cyc(f1);
% % 	k=k(f1);
% %     age=age(f1);
% %     axial_speed=u(f1);
% %     amp=a(f1);
% % save tracks/midlat_tracks k cyc track_jday scale y x id	age axial_speed amp
% % return

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
%MIDLAT
%%%%
% load tracks/midlat_tracks k x y id cyc track_jday age scale
% ii=find(track_jday>=2452427 & track_jday<=2455159 & age>=12);
% 
% x=x(ii);
% y=y(ii);
% k=k(ii);
% id=id(ii);
% track_jday=track_jday(ii);
% cyc=cyc(ii);
% scale=scale(ii);
% 
% num_a=length(find(cyc==1))
% num_c=length(find(cyc==-1))
% 
% 
% %From SST
% % [w_ek_sst_fixed_a,w_ek_sst_fixed_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp_wek_sst_week_fixed','~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_','w');
% % save -append ULTI_wind_midlat_rot_comps w_ek_*
% [dtdn_a,dtdn_c]=comps(x,y,cyc,k,id,track_jday,scale,'norm_hp66_dtdn','~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_','w');
% save -append ULTI_wind_midlat_rot_comps dtdn*
% return
% % % [w_ek_sst_a,w_ek_sst_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp_wek_sst_week_cross','~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_','w');
% % % save -append ULTI_wind_midlat_rot_comps w_ek_*
% % % [noro_w_ek_sst_a,noro_w_ek_sst_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp_wek_sst_week_cross','~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_','n');
% % % save -append ULTI_wind_midlat_rot_comps noro_*
% % % [noro_w_ek_sst_fixed_a,noro_w_ek_sst_fixed_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp_wek_sst_week_fixed','~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_','n');
% % % save -append ULTI_wind_midlat_rot_comps noro_*
% % 
% % % %%%From QSCAT
% % % [w_ek_zeta_qscat_a,w_ek_zeta_qscat_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp_zeta_wek_qscat','~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_','w');
% % % save -append ULTI_wind_midlat_rot_comps w_ek_*
% % % 
% % % [w_ek_crlg_qscat_a,w_ek_crlg_qscat_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp_crl_wek_qscat','~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_','w');
% % % save -append ULTI_wind_midlat_rot_comps w_ek_*
% % % % 
% % % [w_ek_total_qscat_a,w_ek_total_qscat_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp_total_wek_qscat','~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_','w');
% % % save -append ULTI_wind_midlat_rot_comps w_ek_*
% % % [noro_w_ek_total_qscat_a,noro_w_ek_total_qscat_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp_total_wek_qscat','~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_','n');
% % % save -append ULTI_wind_midlat_rot_comps noro_*
% % 
% % % 
% % %%%Estimated
% % [w_ek_zeta_a,w_ek_zeta_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp_zeta_wek','~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_','w');
% % save -append ULTI_wind_midlat_rot_comps w_ek_*
% % 
% % [w_ek_crlg_a,w_ek_crlg_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp_crl_wek','~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_','w');
% % save -append ULTI_wind_midlat_rot_comps w_ek_*
% % 
% % [w_ek_total_a,w_ek_total_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp_total_wek','~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_','w');
% % save -append ULTI_wind_midlat_rot_comps w_ek_*
% % [noro_w_ek_total_a,noro_w_ek_total_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp_total_wek','~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_','n');
% % save -append ULTI_wind_midlat_rot_comps noro_*
% % % 


% 
% 
%%%%%%
% % Southern Hemi
% % %%%%%
% % load tracks/midlat_tracks k x y id cyc track_jday age scale
% % ii=find(track_jday>=2452427 & track_jday<=2455159 & age>=12 & y<=-15);
% % x=x(ii);
% % y=y(ii);
% % k=k(ii);
% % id=id(ii);
% % track_jday=track_jday(ii);
% % cyc=cyc(ii);
% % scale=scale(ii);
% % 
% % num_a=length(find(cyc==1))
% % num_c=length(find(cyc==-1))
% % 
% % 
% % %From SST
% % [dtdn_a,dtdn_c]=comps(x,y,cyc,k,id,track_jday,scale,'norm_hp66_dtdn','~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_','w');
% % save -append ULTI_wind_SH_comps *
% % [w_ek_sst_fixed_a,w_ek_sst_fixed_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp_wek_sst_week_fixed','~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_','w');
% % save -append ULTI_wind_SH_comps *
% % [w_ek_sst_a,w_ek_sst_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp_wek_sst_week_cross','~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_','w');
% % save -append ULTI_wind_SH_comps *
% % [noro_w_ek_sst_a,noro_w_ek_sst_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp_wek_sst_week_cross','~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_','n');
% % save -append ULTI_wind_SH_comps *
% % [noro_w_ek_sst_fixed_a,noro_w_ek_sst_fixed_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp_wek_sst_week_fixed','~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_','n');
% % save -append ULTI_wind_SH_comps *
% % 
% % %From QSCAT
% % [w_ek_zeta_qscat_a,w_ek_zeta_qscat_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp_zeta_wek_qscat','~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_','w');
% % save -append ULTI_wind_SH_comps *
% % [noro_w_ek_total_qscat_a,noro_w_ek_total_qscat_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp_total_wek_qscat','~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_','n');
% % save -append ULTI_wind_SH_comps *
% % 
% % [w_ek_crlg_qscat_a,w_ek_crlg_qscat_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp_crl_wek_qscat','~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_','w');
% % save -append ULTI_wind_SH_comps *
% % 
% % [w_ek_total_qscat_a,w_ek_total_qscat_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp_total_wek_qscat','~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_','w');
% % save -append ULTI_wind_SH_comps *
% % 
% % %Estimated
% % [w_ek_zeta_a,w_ek_zeta_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp_zeta_wek','~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_','w');
% % save -append ULTI_wind_SH_comps *
% % 
% % [w_ek_crlg_a,w_ek_crlg_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp_crl_wek','~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_','w');
% % save -append ULTI_wind_SH_comps *
% % 
% % [w_ek_total_a,w_ek_total_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp_total_wek','~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_','w');
% % save -append ULTI_wind_SH_comps *
% % [noro_w_ek_total_a,noro_w_ek_total_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp_total_wek','~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_','n');
% % save -append ULTI_wind_SH_comps *
% % 
% % % return
% % 
% % %%%%%
% % Northern Hemi
% % %%%%%%%
% % load tracks/midlat_tracks k x y id cyc track_jday age scale
% % ii=find(track_jday>=2452427 & track_jday<=2455159 & age>=12 & y>=15);
% % x=x(ii);
% % y=y(ii);
% % k=k(ii);
% % id=id(ii);
% % track_jday=track_jday(ii);
% % cyc=cyc(ii);
% % scale=scale(ii);
% % 
% % num_a=length(find(cyc==1))
% % num_c=length(find(cyc==-1))
% % 
% % 
% % %%From SST
% % [dtdn_a,dtdn_c]=comps(x,y,cyc,k,id,track_jday,scale,'norm_hp66_dtdn','~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_','w');
% % save -append ULTI_wind_NH_comps *
% % [w_ek_sst_fixed_a,w_ek_sst_fixed_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp_wek_sst_week_fixed','~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_','w');
% % save -append ULTI_wind_NH_comps *
% % 
% % [w_ek_sst_a,w_ek_sst_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp_wek_sst_week_cross','~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_','w');
% % save -append ULTI_wind_NH_comps *
% % [noro_w_ek_sst_a,noro_w_ek_sst_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp_wek_sst_week_cross','~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_','n');
% % save -append ULTI_wind_NH_comps *
% % [noro_w_ek_sst_fixed_a,noro_w_ek_sst_fixed_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp_wek_sst_week_fixed','~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_','n');
% % save -append ULTI_wind_NH_comps *
% % %From QSCAT
% % [w_ek_zeta_qscat_a,w_ek_zeta_qscat_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp_zeta_wek_qscat','~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_','w');
% % save -append ULTI_wind_NH_comps *
% % 
% % [w_ek_crlg_qscat_a,w_ek_crlg_qscat_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp_crl_wek_qscat','~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_','w');
% % save -append ULTI_wind_NH_comps *
% % 
% % [w_ek_total_qscat_a,w_ek_total_qscat_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp_total_wek_qscat','~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_','w');
% % save -append ULTI_wind_NH_comps *
% % [noro_w_ek_total_qscat_a,noro_w_ek_total_qscat_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp_total_wek_qscat','~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_','n');
% % save -append ULTI_wind_NH_comps *
% % %Estimated
% % [w_ek_zeta_a,w_ek_zeta_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp_zeta_wek','~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_','w');
% % save -append ULTI_wind_NH_comps *
% % 
% % 
% % [w_ek_crlg_a,w_ek_crlg_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp_crl_wek','~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_','w');
% % save -append ULTI_wind_NH_comps *
% % 
% % [w_ek_total_a,w_ek_total_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp_total_wek','~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_','w');
% % save -append ULTI_wind_NH_comps *
% % [noro_w_ek_total_a,noro_w_ek_total_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp_total_wek','~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_','n');
% % save -append ULTI_wind_NH_comps *
% % 

% % 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%NOW plot

% %%%test
% load ULTI_wind_NH_comps
% nh_c=w_ek_total_qscat_c.mean;
% nh_a=w_ek_total_qscat_a.mean;
% N_nh_c=w_ek_total_qscat_c.n_max_sample;
% N_nh_a=w_ek_total_qscat_a.n_max_sample;
% 
% load ULTI_wind_SH_comps
% sh_c=w_ek_total_qscat_c.mean;
% sh_a=w_ek_total_qscat_a.mean;
% N_sh_c=w_ek_total_qscat_c.n_max_sample;
% N_sh_a=w_ek_total_qscat_a.n_max_sample;
% 
% a=((nh_a.*N_nh_a)+(sh_a.*N_sh_a))./(N_nh_a+N_sh_a);
% c=((nh_c.*N_nh_c)+(sh_c.*N_sh_c))./(N_nh_c+N_sh_c);
% 
% pcomps_raw2(c,c,[-10 10],-100,1,100,['test c'],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/test_c'])
% 
% pcomps_raw2(a,a,[-10 10],-100,1,100,['test a'],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/test_a'])
% 
% 
% 
% 
% 
% return
load region_crlstr_dtdn_coupling_coeff alpha_n
alpha_n_round=-round(10000*alpha_n(9))/10000
% 
load ULTI_wind_SH_comps


tt=w_ek_total_qscat_c.mean;
pp=max(tt(:)); ps=min(tt(:)); if abs(pp)>abs(ps)     r=pp./-ps; else     r=-ps./pp; end
pcomps_raw2(w_ek_total_qscat_c.mean,w_ek_total_qscat_c.mean,[-10 10],-100,1,100,['W_{tot}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/sh_wek_total_qscat_c'])

tt=w_ek_total_qscat_a.mean;
pp=max(tt(:)); ps=min(tt(:)); if abs(pp)>abs(ps)     r=pp./-ps; else     r=-ps./pp; end
pcomps_raw2(w_ek_total_qscat_a.mean,w_ek_total_qscat_a.mean,[-10 10],-100,1,100,['W_{tot}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/sh_wek_total_qscat_a'])

tt=w_ek_total_c.mean;
pp=max(tt(:)); ps=min(tt(:)); if abs(pp)>abs(ps)     r=pp./-ps; else     r=-ps./pp; end
pcomps_raw2(w_ek_total_c.mean,w_ek_total_c.mean,[-10 10],-100,1,100,['W_{cur}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/sh_wek_total_c'])

tt=w_ek_total_a.mean;
pp=max(tt(:)); ps=min(tt(:)); if abs(pp)>abs(ps)     r=pp./-ps; else     r=-ps./pp; end
pcomps_raw2(w_ek_total_a.mean,w_ek_total_a.mean,[-10 10],-100,1,100,['W_{cur}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/sh_wek_total_a'])

tt=w_ek_total_c.mean+w_ek_sst_fixed_c.mean;
pp=max(tt(:)); ps=min(tt(:)); if abs(pp)>abs(ps)     r=pp./-ps; else     r=-ps./pp; end
pcomps_raw2(w_ek_total_c.mean+w_ek_sst_fixed_c.mean,w_ek_total_c.mean+w_ek_sst_fixed_c.mean,[-10 10],-100,2,100,['W_{cur}+W_{SST}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/sh_wek_add_fixed_c'])


tt=w_ek_total_a.mean+w_ek_sst_fixed_a.mean;
pp=max(tt(:)); ps=min(tt(:)); if abs(pp)>abs(ps)     r=pp./-ps; else     r=-ps./pp; end
pcomps_raw2(w_ek_total_a.mean+w_ek_sst_fixed_a.mean,w_ek_total_a.mean+w_ek_sst_fixed_a.mean,[-10 10],-100,1,100,['W_{cur}+W_{SST}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/sh_wek_add_fixed_a'])

tt=w_ek_sst_fixed_c.mean;
pp=max(tt(:)); ps=min(tt(:)); if abs(pp)>abs(ps)     r=pp./-ps; else     r=-ps./pp; end
pcomps_raw2(w_ek_sst_fixed_c.mean,w_ek_sst_fixed_c.mean,[-2 2],-100,.2,100,['W_{SST}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/sh_wek_sst_ixed_c'])

tt=w_ek_sst_fixed_a.mean;
pp=max(tt(:)); ps=min(tt(:)); if abs(pp)>abs(ps)     r=pp./-ps; else     r=-ps./pp; end
pcomps_raw2(w_ek_sst_fixed_a.mean,w_ek_sst_fixed_a.mean,[-2 2],-100,.2,100,['W_{SST}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/sh_wek_sst_fixed_a'])

tt=alpha_n_round.*dtdn_c.mean;
pp=max(tt(:)); ps=min(tt(:)); if abs(pp)>abs(ps)     r=pp./-ps; else     r=-ps./pp; end
pcomps_raw2(alpha_n_round.*dtdn_c.mean,alpha_n_round.*dtdn_c.mean,[-2 2],-100,.2,100,['W_{SST}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/sh_dtdn_wek_c'])

tt=alpha_n_round.*dtdn_a.mean;
pp=max(tt(:)); ps=min(tt(:)); if abs(pp)>abs(ps)     r=pp./-ps; else     r=-ps./pp; end
pcomps_raw2(alpha_n_round.*dtdn_a.mean,alpha_n_round.*dtdn_a.mean,[-2 2],-100,.2,100,['W_{SST}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/sh_dtdn_wek_a'])

tt=w_ek_total_c.mean+(alpha_n_round.*dtdn_c.mean);
pp=max(tt(:)); ps=min(tt(:)); if abs(pp)>abs(ps)     r=pp./-ps; else     r=-ps./pp; end
pcomps_raw2(w_ek_total_c.mean+(alpha_n_round.*dtdn_c.mean),w_ek_total_c.mean+(alpha_n_round.*dtdn_c.mean),[-10 10],-100,1,100,['W_{cur}+W_{SST}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/sh_dtdn_wek_add_c'])

tt=w_ek_total_a.mean+(alpha_n_round.*dtdn_a.mean);
pp=max(tt(:)); ps=min(tt(:)); if abs(pp)>abs(ps)     r=pp./-ps; else     r=-ps./pp; end
pcomps_raw2(w_ek_total_a.mean+(alpha_n_round.*dtdn_a.mean),w_ek_total_a.mean+(alpha_n_round.*dtdn_a.mean),[-10 10],-100,1,100,['W_{cur}+W_{SST}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/sh_dtdn_wek_add_a'])
% 


load ULTI_wind_NH_comps


tt=w_ek_total_qscat_c.mean;
pp=max(tt(:)); ps=min(tt(:)); if abs(pp)>abs(ps)     r=pp./-ps; else     r=-ps./pp; end
pcomps_raw2(w_ek_total_qscat_c.mean,w_ek_total_qscat_c.mean,[-10 10],-100,1,100,['W_{tot}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/nh_wek_total_qscat_c'])

tt=w_ek_total_qscat_a.mean;
pp=max(tt(:)); ps=min(tt(:)); if abs(pp)>abs(ps)     r=pp./-ps; else     r=-ps./pp; end
pcomps_raw2(w_ek_total_qscat_a.mean,w_ek_total_qscat_a.mean,[-10 10],-100,1,100,['W_{tot}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/nh_wek_total_qscat_a'])

tt=w_ek_total_c.mean;
pp=max(tt(:)); ps=min(tt(:)); if abs(pp)>abs(ps)     r=pp./-ps; else     r=-ps./pp; end
pcomps_raw2(w_ek_total_c.mean,w_ek_total_c.mean,[-10 10],-100,1,100,['W_{cur}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/nh_wek_total_c'])

tt=w_ek_total_a.mean;
pp=max(tt(:)); ps=min(tt(:)); if abs(pp)>abs(ps)     r=pp./-ps; else     r=-ps./pp; end
pcomps_raw2(w_ek_total_a.mean,w_ek_total_a.mean,[-10 10],-100,1,100,['W_{cur}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/nh_wek_total_a'])

tt=w_ek_total_c.mean+w_ek_sst_fixed_c.mean;
pp=max(tt(:)); ps=min(tt(:)); if abs(pp)>abs(ps)     r=pp./-ps; else     r=-ps./pp; end
pcomps_raw2(w_ek_total_c.mean+w_ek_sst_fixed_c.mean,w_ek_total_c.mean+w_ek_sst_fixed_c.mean,[-10 10],-100,1,100,['W_{cur}+W_{SST}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/nh_wek_add_fixed_c'])

tt=w_ek_total_a.mean+w_ek_sst_fixed_a.mean;
pp=max(tt(:)); ps=min(tt(:)); if abs(pp)>abs(ps)     r=pp./-ps; else     r=-ps./pp; end
pcomps_raw2(w_ek_total_a.mean+w_ek_sst_fixed_a.mean,w_ek_total_a.mean+w_ek_sst_fixed_a.mean,[-10 10],-100,1,100,['W_{cur}+W_{SST}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/nh_wek_add_fixed_a'])

tt=w_ek_sst_fixed_c.mean;
pp=max(tt(:)); ps=min(tt(:)); if abs(pp)>abs(ps)     r=pp./-ps; else     r=-ps./pp; end
pcomps_raw2(w_ek_sst_fixed_c.mean,w_ek_sst_fixed_c.mean,[-2 2],-100,.2,100,['W_{SST}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/nh_wek_sst_ixed_c'])

tt=w_ek_sst_fixed_a.mean;
pp=max(tt(:)); ps=min(tt(:)); if abs(pp)>abs(ps)     r=pp./-ps; else     r=-ps./pp; end
pcomps_raw2(w_ek_sst_fixed_a.mean,w_ek_sst_fixed_a.mean,[-2 2],-100,.2,100,['W_{SST}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/nh_wek_sst_fixed_a'])

tt=alpha_n_round.*dtdn_c.mean;
pp=max(tt(:)); ps=min(tt(:)); if abs(pp)>abs(ps)     r=pp./-ps; else     r=-ps./pp; end
pcomps_raw2(alpha_n_round.*dtdn_c.mean,alpha_n_round.*dtdn_c.mean,[-2 2],-100,.2,100,['W_{SST}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/nh_dtdn_wek_c'])

tt=alpha_n_round.*dtdn_a.mean;
pp=max(tt(:)); ps=min(tt(:)); if abs(pp)>abs(ps)     r=pp./-ps; else     r=-ps./pp; end
pcomps_raw2(alpha_n_round.*dtdn_a.mean,alpha_n_round.*dtdn_a.mean,[-2 2],-100,.2,100,['W_{SST}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/nh_dtdn_wek_a'])

tt=w_ek_total_c.mean+(alpha_n_round.*dtdn_c.mean);
pp=max(tt(:)); ps=min(tt(:)); if abs(pp)>abs(ps)     r=pp./-ps; else     r=-ps./pp; end
pcomps_raw2(w_ek_total_c.mean+(alpha_n_round.*dtdn_c.mean),w_ek_total_c.mean+(alpha_n_round.*dtdn_c.mean),[-10 10],-100,1,100,['W_{cur}+W_{SST}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/nh_dtdn_wek_add_c'])

tt=w_ek_total_a.mean+(alpha_n_round.*dtdn_a.mean);
pp=max(tt(:)); ps=min(tt(:)); if abs(pp)>abs(ps)     r=pp./-ps; else     r=-ps./pp; end
pcomps_raw2(w_ek_total_a.mean+(alpha_n_round.*dtdn_a.mean),w_ek_total_a.mean+(alpha_n_round.*dtdn_a.mean),[-10 10],-100,1,100,['W_{cur}+W_{SST}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/nh_dtdn_wek_add_a'])
% 


%NOW plot midlat
load ULTI_wind_midlat_rot_comps
tt=w_ek_total_qscat_c.mean;
pp=max(tt(:));
ps=min(tt(:));
if abs(pp)>abs(ps)
    r=pp./-ps;
else
    r=-ps./pp;
end
pcomps_raw2(w_ek_total_qscat_c.mean,w_ek_total_qscat_c.mean,[-10 10],-100,1,100,['W_{tot}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/wek_total_qscat_c'])

tt=w_ek_total_qscat_a.mean;
pp=max(tt(:)); ps=min(tt(:)); if abs(pp)>abs(ps)     r=pp./-ps; else     r=-ps./pp; end
pcomps_raw2(w_ek_total_qscat_a.mean,w_ek_total_qscat_a.mean,[-10 10],-100,1,100,['W_{tot}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/wek_total_qscat_a'])

tt=w_ek_total_c.mean;
pp=max(tt(:)); ps=min(tt(:)); if abs(pp)>abs(ps)     r=pp./-ps; else     r=-ps./pp; end
pcomps_raw2(w_ek_total_c.mean,w_ek_total_c.mean,[-10 10],-100,1,100,['W_{cur}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/wek_total_c'])

tt=w_ek_total_a.mean;
pp=max(tt(:)); ps=min(tt(:)); if abs(pp)>abs(ps)     r=pp./-ps; else     r=-ps./pp; end
pcomps_raw2(w_ek_total_a.mean,w_ek_total_a.mean,[-10 10],-100,1,100,['W_{cur}'],2,30)
% % % % % pcomps_raw2(w_ek_total_a.mean,w_ek_total_a.mean,[-10 10],-100,1,100,['W_{cur}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/wek_total_a'])

tt=w_ek_total_c.mean+w_ek_sst_fixed_c.mean;
pp=max(tt(:)); ps=min(tt(:)); if abs(pp)>abs(ps)     r=pp./-ps; else     r=-ps./pp; end
pcomps_raw2(w_ek_total_c.mean+w_ek_sst_fixed_c.mean,w_ek_total_c.mean+w_ek_sst_fixed_c.mean,[-10 10],-100,1,100,['W_{cur}+W_{SST}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/wek_add_fixed_c'])

tt=w_ek_total_a.mean+w_ek_sst_fixed_a.mean;
pp=max(tt(:)); ps=min(tt(:)); if abs(pp)>abs(ps)     r=pp./-ps; else     r=-ps./pp; end
pcomps_raw2(w_ek_total_a.mean+w_ek_sst_fixed_a.mean,w_ek_total_a.mean+w_ek_sst_fixed_a.mean,[-10 10],-100,1,100,['W_{cur}+W_{SST}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/wek_add_fixed_a'])

tt=w_ek_sst_fixed_c.mean;
pp=max(tt(:)); ps=min(tt(:)); if abs(pp)>abs(ps)     r=pp./-ps; else     r=-ps./pp; end
pcomps_raw2(w_ek_sst_fixed_c.mean,w_ek_sst_fixed_c.mean,[-1 1],-100,.1,100,['W_{SST}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/wek_sst_ixed_c'])

tt=w_ek_sst_fixed_a.mean;
pp=max(tt(:)); ps=min(tt(:)); if abs(pp)>abs(ps)     r=pp./-ps; else     r=-ps./pp; end
pcomps_raw2(w_ek_sst_fixed_a.mean,w_ek_sst_fixed_a.mean,[-1 1],-100,.1,100,['W_{SST}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/wek_sst_fixed_a'])


tt=1.3.*w_ek_sst_fixed_c.mean;
pp=max(tt(:)); ps=min(tt(:)); if abs(pp)>abs(ps)     r=pp./-ps; else     r=-ps./pp; end
pcomps_raw2(1.3.*w_ek_sst_fixed_c.mean,1.3.*w_ek_sst_fixed_c.mean,[-1 1],-100,.1,100,['W_{SST}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/dtdn_wek_c'])

tt=1.3.*w_ek_sst_fixed_a.mean;
pp=max(tt(:)); ps=min(tt(:)); if abs(pp)>abs(ps)     r=pp./-ps; else     r=-ps./pp; end
pcomps_raw2(1.3.*w_ek_sst_fixed_a.mean,1.3.*w_ek_sst_fixed_a.mean,[-1 1],-100,.1,100,['W_{SST}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/dtdn_wek_a'])

tt=w_ek_total_c.mean+(1.3.*w_ek_sst_fixed_c.mean);
pp=max(tt(:)); ps=min(tt(:)); if abs(pp)>abs(ps)     r=pp./-ps; else     r=-ps./pp; end
pcomps_raw2(w_ek_total_c.mean+(1.3.*w_ek_sst_fixed_c.mean),w_ek_total_c.mean+(1.3.*w_ek_sst_fixed_c.mean),[-10 10],-100,1,100,['W_{cur}+W_{SST}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/dtdn_wek_add_c'])

tt=w_ek_total_a.mean+(1.3.*w_ek_sst_fixed_a.mean);
pp=max(tt(:)); ps=min(tt(:)); if abs(pp)>abs(ps)     r=pp./-ps; else     r=-ps./pp; end
pcomps_raw2(w_ek_total_a.mean+(1.3.*w_ek_sst_fixed_a.mean),w_ek_total_a.mean+(1.3.*w_ek_sst_fixed_a.mean),[-10 10],-100,1,100,['W_{cur}+W_{SST}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/dtdn_wek_add_a'])

tt=alpha_n_round.*dtdn_c.mean;
pp=max(tt(:)); ps=min(tt(:)); if abs(pp)>abs(ps)     r=pp./-ps; else     r=-ps./pp; end
pcomps_raw2(alpha_n_round.*dtdn_c.mean,alpha_n_round.*dtdn_c.mean,[-1 1],-100,.1,100,['W_{SST}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/dtdn_wek_c'])

tt=alpha_n_round.*dtdn_a.mean;
pp=max(tt(:)); ps=min(tt(:)); if abs(pp)>abs(ps)     r=pp./-ps; else     r=-ps./pp; end
pcomps_raw2(alpha_n_round.*dtdn_a.mean,alpha_n_round.*dtdn_a.mean,[-1 1],-100,.1,100,['W_{SST}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/dtdn_wek_a'])

tt=w_ek_total_c.mean+(alpha_n_round.*dtdn_c.mean);
pp=max(tt(:)); ps=min(tt(:)); if abs(pp)>abs(ps)     r=pp./-ps; else     r=-ps./pp; end
pcomps_raw2(w_ek_total_c.mean+(alpha_n_round.*dtdn_c.mean),w_ek_total_c.mean+(alpha_n_round.*dtdn_c.mean),[-10 10],-100,1,100,['W_{cur}+W_{SST}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/dtdn_wek_add_c'])

tt=w_ek_total_a.mean+(alpha_n_round.*dtdn_a.mean);
pp=max(tt(:)); ps=min(tt(:)); if abs(pp)>abs(ps)     r=pp./-ps; else     r=-ps./pp; end
pcomps_raw2(w_ek_total_a.mean+(alpha_n_round.*dtdn_a.mean),w_ek_total_a.mean+(alpha_n_round.*dtdn_a.mean),[-10 10],-100,1,100,['W_{cur}+W_{SST}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/dtdn_wek_add_a'])

