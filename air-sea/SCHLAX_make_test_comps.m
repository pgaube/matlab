
clear all
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%
% %MIDLAT
% %%%
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
% [w_ek_sst_fixed_a,w_ek_sst_fixed_c]=schlax_comps_test(x,y,cyc,k,id,track_jday,scale,'hp_wek_sst_week_fixed','~/data/QuickScat/schlax/mat/schlax_','t');
% save -append SCHLAX_wind_midlat_comps_test w_ek_*

% [w_ek_total_qscat_a,w_ek_total_qscat_c]=schlax_comps_test(x,y,cyc,k,id,track_jday,scale,'hp_total_wek_qscat','~/data/QuickScat/schlax/mat/schlax_','t');
% save -append SCHLAX_wind_midlat_comps_test w_ek_*
% 
% [w_ek_total_a,w_ek_total_c]=schlax_comps_test(x,y,cyc,k,id,track_jday,scale,'hp_total_wek_est','~/data/QuickScat/schlax/mat/schlax_','t');
% save -append SCHLAX_wind_midlat_comps_test w_ek_*


% 
% 
%%%%%%
% % Southern Hemi
% % % %%%%%
% clear
% load tracks/midlat_tracks k x y id cyc track_jday age scale
% ii=find(track_jday>=2452427 & track_jday<=2455159 & age>=12 & y<=-15);
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
% [w_ek_sst_fixed_a,w_ek_sst_fixed_c]=schlax_comps_test(x,y,cyc,k,id,track_jday,scale,'hp_wek_sst_week_fixed','~/data/QuickScat/schlax/mat/schlax_','t');
% save -append SCHLAX_wind_SH_comps_test *
% 
% % [w_ek_total_qscat_a,w_ek_total_qscat_c]=schlax_comps_test(x,y,cyc,k,id,track_jday,scale,'hp_total_wek_qscat','~/data/QuickScat/schlax/mat/schlax_','t');
% % save -append SCHLAX_wind_SH_comps_test *
% % 
% % [w_ek_total_a,w_ek_total_c]=schlax_comps_test(x,y,cyc,k,id,track_jday,scale,'hp_total_wek_est','~/data/QuickScat/schlax/mat/schlax_','t');
% % save -append SCHLAX_wind_SH_comps_test *
% 
% return
% %%%%%
% % Northern Hemi
%%%%%%%
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

% [w_ek_sst_fixed_a,w_ek_sst_fixed_c]=schlax_comps_test(x,y,cyc,k,id,track_jday,scale,'hp_wek_sst_week_fixed','~/data/QuickScat/schlax/mat/schlax_','t');
% save -append SCHLAX_wind_NH_comps_test *

[w_ek_total_qscat_a,w_ek_total_qscat_c]=schlax_comps_test(x,y,cyc,k,id,track_jday,scale,'hp_total_wek_qscat','~/data/QuickScat/schlax/mat/schlax_','t');
save -append SCHLAX_wind_NH_comps_test *
% [w_ek_total_a,w_ek_total_c]=schlax_comps_test(x,y,cyc,k,id,track_jday,scale,'hp_total_wek_est','~/data/QuickScat/schlax/mat/schlax_','t');
% save -append SCHLAX_wind_NH_comps_test *


% return
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%NOW plot

% %
% load SCHLAX_wind_SH_comps_test
% 
% pcomps_raw2(w_ek_sst_fixed_a.mean,w_ek_sst_fixed_a.mean,[-1 1],-100,.1,100,['SH TEST N=',num2str(w_ek_sst_fixed_a.n_max_sample)],1,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/schlax_test_SH_ac'])
% 
% pcomps_raw2(w_ek_sst_fixed_c.mean,w_ek_sst_fixed_c.mean,[-1 1],-100,.1,100,['SH TEST N=',num2str(w_ek_sst_fixed_c.n_max_sample)],1,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/schlax_test_SH_cc'])
% clear
load SCHLAX_wind_NH_comps_test

pcomps_raw2(w_ek_total_qscat_a.mean,w_ek_total_qscat_a.mean,[-1 1],-100,.1,100,['NH TEST N=',num2str(w_ek_sst_fixed_a.n_max_sample)],1,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/schlax_test_NH_ac'])

pcomps_raw2(w_ek_total_qscat_c.mean,w_ek_total_qscat_c.mean,[-1 1],-100,.1,100,['NH TEST N=',num2str(w_ek_sst_fixed_c.n_max_sample)],1,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/schlax_test_NH_cc'])
clear
% load SCHLAX_wind_midlat_comps_test
% 
% pcomps_raw2(w_ek_sst_fixed_a.mean,w_ek_sst_fixed_a.mean,[-1 1],-100,.1,100,['GLOB TEST N=',num2str(w_ek_sst_fixed_a.n_max_sample)],1,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/schlax_test_ac'])
% 
% pcomps_raw2(w_ek_sst_fixed_c.mean,w_ek_sst_fixed_c.mean,[-1 1],-100,.1,100,['GLOB TEST N=',num2str(w_ek_sst_fixed_c.n_max_sample)],1,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/schlax_test_cc'])
