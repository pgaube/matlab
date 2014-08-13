% 
% clear all
% 
% 
% % 
load tracks/midlat_tracks	
ii=find(track_jday>=2452427 & track_jday<=2455159 & y>0);
x=x(ii);
y=y(ii);
k=k(ii);
id=id(ii);
track_jday=track_jday(ii);
cyc=cyc(ii);
scale=scale(ii);


[NH_w_ek_sst_fixed_a,NH_w_ek_fixed_sst_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp_wek_sst_week_fixed','~/data/QuickScat/ULTI_mat2/QSCAT_30_25km_','n');
% [NH_rot_w_ek_sst_fixed_a,NH_rot_w_ek_fixed_sst_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp_wek_sst_week_fixed','~/data/QuickScat/ULTI_mat2/QSCAT_30_25km_','w');
% [NH_rot_sst_a,NH_rot_sst_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp66_sst','~/data/ReynoldsSST/mat/OI_25_30_','w');

save -append FIANL_wind_midlat_rot_comps NH_*

clear all
% 

% % 
% load tracks/midlat_tracks	
% ii=find(track_jday>=2452427 & track_jday<=2455159 & y<0 & y>-30);
% x=x(ii);
% y=y(ii);
% k=k(ii);
% id=id(ii);
% track_jday=track_jday(ii);
% cyc=cyc(ii);
% scale=scale(ii);
% 
% 
% [SH_rot_w_ek_sst_fixed_a,SH_rot_w_ek_fixed_sst_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp_wek_sst_week_fixed','~/data/QuickScat/ULTI_mat2/QSCAT_30_25km_','w');
% % [SH_w_ek_sst_fixed_a,SH_w_ek_fixed_sst_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp_wek_sst_week_fixed','~/data/QuickScat/ULTI_mat2/QSCAT_30_25km_','n');
% % % [SH_rot_sst_a,SH_rot_sst_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp66_sst','~/data/ReynoldsSST/mat/OI_25_30_','w');
% % save -append FIANL_wind_midlat_rot_comps SH_*
% % 
% % 
% return
% %}
load FIANL_wind_midlat_rot_comps

% pcomps_raw2(-(NH_rot_w_ek_fixed_sst_c.mean),-(NH_rot_w_ek_fixed_sst_c.mean),[-1 1],-100,.1,100,['NH SST-induced Ekman pumping'],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/NH_rot_w_ek_sst_c_mean'])
% 
% pcomps_raw2(-(NH_rot_w_ek_sst_fixed_a.mean),-(NH_rot_w_ek_sst_fixed_a.mean),[-1 1],-100,.1,100,['NH SST-induced Ekman pumping'],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/NH_rot_w_ek_sst_a_mean'])
% 
% pcomps_raw2(-(SH_rot_w_ek_fixed_sst_c.mean),-(SH_rot_w_ek_fixed_sst_c.mean),[-1 1],-100,.1,100,['SH SST-induced Ekman pumping'],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/SH_rot_w_ek_sst_c_mean'])
% 
% pcomps_raw2(-(SH_rot_w_ek_sst_fixed_a.mean),-(SH_rot_w_ek_sst_fixed_a.mean),[-1 1],-100,.1,100,['SH SST-induced Ekman pumping'],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/SH_rot_w_ek_sst_a_mean'])
% % 
% pcomps_raw2(-(rot_w_ek_fixed_c.mean),-(rot_w_ek_fixed_c.mean),[-1 1],-100,.1,100,['SST-induced Ekman pumping'],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/rot_w_ek_fixed_c_mean'])
% 
% pcomps_raw2(-(rot_w_ek_fixed_a.mean),-(rot_w_ek_fixed_a.mean),[-1 1],-100,.1,100,['SST-induced Ekman pumping'],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/rot_w_ek_fixed_a_mean'])


% pcomps_raw2(-(NH_rot_w_ek_fixed_sst_c.mean),-(NH_rot_w_ek_fixed_sst_c.mean),[-1 1],-100,.1,100,['NH SST-induced Ekman pumping'],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/NH_rot_w_ek_sst_c_mean'])
% 
% pcomps_raw2(-(NH_rot_w_ek_sst_fixed_a.mean),-(NH_rot_w_ek_sst_fixed_a.mean),[-1 1],-100,.1,100,['NH SST-induced Ekman pumping'],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/NH_rot_w_ek_sst_a_mean'])
% 
pcomps_raw2(-(SH_w_ek_fixed_sst_c.mean),-(SH_w_ek_fixed_sst_c.mean),[-1 1],-100,.1,100,['SH SST-induced Ekman pumping'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/SH_w_ek_sst_c_mean'])

pcomps_raw2(-(SH_w_ek_sst_fixed_a.mean),-(SH_w_ek_sst_fixed_a.mean),[-1 1],-100,.1,100,['SH SST-induced Ekman pumping'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/SH_w_ek_sst_a_mean'])

pcomps_raw2(-(NH_w_ek_fixed_sst_c.mean),-(NHt_w_ek_fixed_sst_c.mean),[-1 1],-100,.1,100,['NH SST-induced Ekman pumping'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/NH_w_ek_sst_c_mean'])

pcomps_raw2(-(NH_w_ek_sst_fixed_a.mean),-(NH_w_ek_sst_fixed_a.mean),[-1 1],-100,.1,100,['NH SST-induced Ekman pumping'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/NH_w_ek_sst_a_mean'])


% 
return


pcomps_raw2(-(NH_rot_w_ek_fixed_sst_c.mean+SH_rot_w_ek_fixed_sst_c.mean)./2,-(NH_rot_w_ek_fixed_sst_c.mean+SH_rot_w_ek_fixed_sst_c.mean)./2,[-1 1],-100,.1,100,['SH SST-induced Ekman pumping'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/SN_rot_w_ek_sst_c_mean'])

pcomps_raw2(-(NH_rot_w_ek_sst_fixed_a.mean+SH_rot_w_ek_sst_fixed_a.mean)./2,-(NH_rot_w_ek_sst_fixed_a.mean+SH_rot_w_ek_sst_fixed_a.mean)./2,[-1 1],-100,.1,100,['SH SST-induced Ekman pumping'],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/SN_rot_w_ek_sst_a_mean'])




% pcomps_raw(NH_rot_sst_c.mean,NH_rot_sst_c.mean,[-.5 .5],-1,.05,1,['NH SST'],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/NH_rot_sst_c'])
% 
% pcomps_raw(NH_rot_sst_a.mean,NH_rot_sst_a.mean,[-.5 .5],-1,.05,1,['NH SST'],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/NH_rot_sst_a'])
% 
% pcomps_raw(SH_rot_sst_c.mean,SH_rot_sst_c.mean,[-.5 .5],-1,.05,1,['SH SST'],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/SH_rot_sst_c'])
% 
% pcomps_raw(SH_rot_sst_a.mean,SH_rot_sst_a.mean,[-.5 .5],-1,.05,1,['SH SST'],2,30)
% eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/SH_rot_sst_a'])
