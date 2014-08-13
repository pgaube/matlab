
clear all
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
%%
% %MIDLAT
%%%
load tracks/midlat_tracks k x y id cyc track_jday age scale
ii=find(track_jday>=2452466 & track_jday<=2455126 & age>=12);

x=x(ii);
y=y(ii);
k=k(ii);
id=id(ii);
track_jday=track_jday(ii);
cyc=cyc(ii);
scale=scale(ii);

num_a=length(find(cyc==1))
num_c=length(find(cyc==-1))


[w_ek_sst_fixed_a,w_ek_sst_fixed_c]=schlax_comps(x,y,cyc,k,id,track_jday,scale,'hp_wek_sst_week_fixed','~/data/QuickScat/schlax/mat/schlax_','w');
save -append SCHLAX_wind_midlat_rot_comps w_ek_*

[w_ek_total_qscat_a,w_ek_total_qscat_c]=schlax_comps(x,y,cyc,k,id,track_jday,scale,'hp_total_wek_qscat','~/data/QuickScat/schlax/mat/schlax_','w');
save -append SCHLAX_wind_midlat_rot_comps w_ek_*

[w_ek_total_a,w_ek_total_c]=schlax_comps(x,y,cyc,k,id,track_jday,scale,'hp_total_wek_est','~/data/QuickScat/schlax/mat/schlax_','w');
save -append SCHLAX_wind_midlat_rot_comps w_ek_*
return

% 
% 
%%%%%
% % % % Southern Hemi
% %%%%%
clear
load tracks/midlat_tracks k x y id cyc track_jday age scale
ii=find(track_jday>=2452466 & track_jday<=2455126 & age>=12 & y<=-15);
x=x(ii);
y=y(ii);
k=k(ii);
id=id(ii);
track_jday=track_jday(ii);
cyc=cyc(ii);
scale=scale(ii);

num_a=length(find(cyc==1))
num_c=length(find(cyc==-1))

[w_ek_sst_fixed_a,w_ek_sst_fixed_c]=schlax_comps(x,y,cyc,k,id,track_jday,scale,'hp_wek_sst_week_fixed','~/data/QuickScat/schlax/mat/schlax_','w');
save -append SCHLAX_wind_SH_comps *

[w_ek_total_qscat_a,w_ek_total_qscat_c]=schlax_comps(x,y,cyc,k,id,track_jday,scale,'hp_total_wek_qscat','~/data/QuickScat/schlax/mat/schlax_','w');
save -append SCHLAX_wind_SH_comps *

[w_ek_total_a,w_ek_total_c]=schlax_comps(x,y,cyc,k,id,track_jday,scale,'hp_total_wek_est','~/data/QuickScat/schlax/mat/schlax_','w');
save -append SCHLAX_wind_SH_comps *
% % return

% % %%%%%
% % Northern Hemi
% % %%%%%%%
clear
load tracks/midlat_tracks k x y id cyc track_jday age scale
ii=find(track_jday>=2452466 & track_jday<=2455126 & age>=12 & y>=15);
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

[w_ek_sst_fixed_a,w_ek_sst_fixed_c]=schlax_comps(x,y,cyc,k,id,track_jday,scale,'hp_wek_sst_week_fixed','~/data/QuickScat/schlax/mat/schlax_','w');
save -append SCHLAX_wind_NH_comps *

[w_ek_total_qscat_a,w_ek_total_qscat_c]=schlax_comps(x,y,cyc,k,id,track_jday,scale,'hp_total_wek_qscat','~/data/QuickScat/schlax/mat/schlax_','w');
save -append SCHLAX_wind_NH_comps *
% 
[w_ek_total_a,w_ek_total_c]=schlax_comps(x,y,cyc,k,id,track_jday,scale,'hp_total_wek_est','~/data/QuickScat/schlax/mat/schlax_','w');
save -append SCHLAX_wind_NH_comps *
return
% 
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%NOW plot

% %
clear
load SCHLAX_wind_SH_comps

%%From QSCAT

pcomps_raw2(w_ek_total_qscat_c.mean,w_ek_total_qscat_c.mean,[-10 10],-100,1,100,['W_{tot}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/schlax_sh_wek_total_qscat_c'])

pcomps_raw2(w_ek_total_qscat_a.mean,w_ek_total_qscat_a.mean,[-10 10],-100,1,100,['W_{tot}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/schlax_sh_wek_total_qscat_a'])

pcomps_raw2(w_ek_total_c.mean,w_ek_total_c.mean,[-10 10],-100,1,100,['W_{cur}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/schlax_sh_wek_total_c'])

pcomps_raw2(w_ek_total_a.mean,w_ek_total_a.mean,[-10 10],-100,1,100,['W_{cur}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/schlax_sh_wek_total_a'])

pcomps_raw2(w_ek_total_c.mean+(.013/.01)*w_ek_sst_fixed_c.mean,w_ek_total_c.mean+(.013/.01)*w_ek_sst_fixed_c.mean,[-10 10],-100,2,100,['W_{cur}+W_{SST}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/schlax_sh_wek_add_fixed_c'])

pcomps_raw2(w_ek_total_a.mean+(.013/.01)*w_ek_sst_fixed_a.mean,w_ek_total_a.mean+(.013/.01)*w_ek_sst_fixed_a.mean,[-10 10],-100,1,100,['W_{cur}+W_{SST}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/schlax_sh_wek_add_fixed_a'])

pcomps_raw2((.013/.01)*w_ek_sst_fixed_c.mean,(.013/.01)*w_ek_sst_fixed_c.mean,[-2 2],-100,.2,100,['W_{SST}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/schlax_sh_wek_sst_ixed_c'])

pcomps_raw2((.013/.01)*w_ek_sst_fixed_a.mean,(.013/.01)*w_ek_sst_fixed_a.mean,[-2 2],-100,.2,100,['W_{SST}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/schlax_sh_wek_sst_fixed_a'])

% df=w_ek_total_qscat_c.mean-(w_ek_total_c.mean+(.013/.01)*w_ek_sst_fixed_c.mean);
% pcomps_raw2(df,df,[-10 10],-2,.1,2,['w_{tot}-(W_{cur}+W_{SST})'],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/schlax_sh_diff_c'])
% 
% df=w_ek_total_qscat_a.mean-(w_ek_total_a.mean+(.013/.01)*w_ek_sst_fixed_a.mean);
% pcomps_raw2(df,df,[-10 10],-2,.1,2,['w_{tot}-(W_{cur}+W_{SST})'],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/schlax_sh_diff_a'])

clear
load SCHLAX_wind_NH_comps
%%From QSCAT

pcomps_raw2(w_ek_total_qscat_c.mean,w_ek_total_qscat_c.mean,[-10 10],-100,1,100,['W_{tot}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/schlax_nh_wek_total_qscat_c'])

pcomps_raw2(w_ek_total_qscat_a.mean,w_ek_total_qscat_a.mean,[-10 10],-100,1,100,['W_{tot}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/schlax_nh_wek_total_qscat_a'])

pcomps_raw2(w_ek_total_c.mean,w_ek_total_c.mean,[-10 10],-100,1,100,['W_{cur}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/schlax_nh_wek_total_c'])

pcomps_raw2(w_ek_total_a.mean,w_ek_total_a.mean,[-10 10],-100,1,100,['W_{cur}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/schlax_nh_wek_total_a'])

pcomps_raw2(w_ek_total_c.mean+(.013/.01)*w_ek_sst_fixed_c.mean,w_ek_total_c.mean+(.013/.01)*w_ek_sst_fixed_c.mean,[-10 10],-100,2,100,['W_{cur}+W_{SST}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/schlax_nh_wek_add_fixed_c'])

pcomps_raw2(w_ek_total_a.mean+(.013/.01)*w_ek_sst_fixed_a.mean,w_ek_total_a.mean+(.013/.01)*w_ek_sst_fixed_a.mean,[-10 10],-100,1,100,['W_{cur}+W_{SST}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/schlax_nh_wek_add_fixed_a'])

pcomps_raw2((.013/.01)*w_ek_sst_fixed_c.mean,(.013/.01)*w_ek_sst_fixed_c.mean,[-2 2],-100,.2,100,['W_{SST}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/schlax_nh_wek_sst_ixed_c'])

pcomps_raw2((.013/.01)*w_ek_sst_fixed_a.mean,(.013/.01)*w_ek_sst_fixed_a.mean,[-2 2],-100,.2,100,['W_{SST}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/schlax_nh_wek_sst_fixed_a'])

% df=w_ek_total_qscat_c.mean-(w_ek_total_c.mean+(.013/.01)*w_ek_sst_fixed_c.mean);
% pcomps_raw2(df,df,[-10 10],-2,.1,2,['w_{tot}-(W_{cur}+W_{SST})'],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/schlax_nh_diff_c'])
% 
% df=w_ek_total_qscat_a.mean-(w_ek_total_a.mean+(.013/.01)*w_ek_sst_fixed_a.mean);
% pcomps_raw2(df,df,[-10 10],-2,.1,2,['w_{tot}-(W_{cur}+W_{SST})'],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/schlax_nh_diff_a'])

%%NOW plot midlat
clear
load SCHLAX_wind_midlat_rot_comps

pcomps_raw2(w_ek_total_qscat_c.mean,w_ek_total_qscat_c.mean,[-10 10],-100,1,100,['W_{tot}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/schlax_wek_total_qscat_c'])

pcomps_raw2(w_ek_total_qscat_a.mean,w_ek_total_qscat_a.mean,[-10 10],-100,1,100,['W_{tot}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/schlax_wek_total_qscat_a'])

pcomps_raw2(w_ek_total_c.mean,w_ek_total_c.mean,[-10 10],-100,1,100,['W_{cur}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/schlax_wek_total_c'])

pcomps_raw2(w_ek_total_a.mean,w_ek_total_a.mean,[-10 10],-100,1,100,['W_{cur}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/schlax_wek_total_a'])

pcomps_raw2(w_ek_total_c.mean+(.013/.01)*w_ek_sst_fixed_c.mean,w_ek_total_c.mean+(.013/.01)*w_ek_sst_fixed_c.mean,[-10 10],-100,2,100,['W_{cur}+W_{SST}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/schlax_wek_add_fixed_c'])

pcomps_raw2(w_ek_total_a.mean+(.013/.01)*w_ek_sst_fixed_a.mean,w_ek_total_a.mean+(.013/.01)*w_ek_sst_fixed_a.mean,[-10 10],-100,1,100,['W_{cur}+W_{SST}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/schlax_wek_add_fixed_a'])

pcomps_raw2((.013/.01)*w_ek_sst_fixed_c.mean,(.013/.01)*w_ek_sst_fixed_c.mean,[-2 2],-100,.2,100,['W_{SST}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/schlax_wek_sst_ixed_c'])

pcomps_raw2((.013/.01)*w_ek_sst_fixed_a.mean,(.013/.01)*w_ek_sst_fixed_a.mean,[-2 2],-100,.2,100,['W_{SST}'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/schlax_wek_sst_fixed_a'])

% df=w_ek_total_qscat_c.mean-(w_ek_total_c.mean+(.013/.01)*w_ek_sst_fixed_c.mean);
% pcomps_raw2(df,df,[-10 10],-2,.1,2,['w_{tot}-(W_{cur}+W_{SST})'],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/schlax_diff_c'])
% 
% df=w_ek_total_qscat_a.mean-(w_ek_total_a.mean+(.013/.01)*w_ek_sst_fixed_a.mean);
% pcomps_raw2(df,df,[-10 10],-2,.1,2,['w_{tot}-(W_{cur}+W_{SST})'],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/schlax_diff_a'])
