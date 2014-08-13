
clear all
%{
load /matlab/data/eddy/V5/global_tracks_v5_12_weeks

f1=find(abs(y)>=15 & abs(y)<=45);
	id=id(f1);
	eid=eid(f1);
	x=x(f1);
	y=y(f1);
	amp=amp(f1);
	axial_speed=axial_speed(f1);
	scale=scale(f1);
	track_jday=track_jday(f1);
	k=k(f1);
	cyc=cyc(f1);
save tracks/midlat_tracks	

load /matlab/data/eddy/V5/global_tracks_v5_12_weeks

f1=find(y>=15 & y<=45);
	id=id(f1);
	eid=eid(f1);
	x=x(f1);
	y=y(f1);
	amp=amp(f1);
	axial_speed=axial_speed(f1);
	scale=scale(f1);
	track_jday=track_jday(f1);
	k=k(f1);
	cyc=cyc(f1);
save tracks/north_midlat_tracks	

load /matlab/data/eddy/V5/global_tracks_v5_12_weeks

f1=find(y>=-45 & y<=-15);
	id=id(f1);
	eid=eid(f1);
	x=x(f1);
	y=y(f1);
	amp=amp(f1);
	axial_speed=axial_speed(f1);
	scale=scale(f1);
	track_jday=track_jday(f1);
	k=k(f1);
	cyc=cyc(f1);
save tracks/south_midlat_tracks	


%
%}
load tracks/midlat_tracks
%{
[chl_pol_a,chl_pol_c] = comps(x,y,cyc,k,id,track_jday,scale,'sp66_chl','/matlab/data/gsm/mat/GSM_9_21_','n');
[car_pol_a,car_pol_c] = comps(x,y,cyc,k,id,track_jday,scale,'sp66_car','/matlab/data/gsm/mat/GSM_9_21_','n');
[sst_cc,sst_c] = comps_dir_grad(x,y,cyc,id,track_jday,scale,'bp26_sst','/matlab/data/ReynoldsSST/mat/OI_25_30_','t');
[car_cc,car_c] = comps_dir_grad(x,y,cyc,id,track_jday,scale,'sp66_car','/matlab/data/gsm/mat/GSM_9_21_','c');
[chl_cc,chl_c] = comps_dir_grad(x,y,cyc,id,track_jday,scale,'sp66_chl','/matlab/data/gsm/mat/GSM_9_21_','g');
%}
[wspd_cc,wspd_c] = comps_dir_grad(x,y,cyc,id,track_jday,scale,'bp26_wspd','/matlab/data/QuickScat/mat/QSCAT_30_25km_','t');
%{
[sst_cc,sst_c] = comps_dir_grad(x,y,cyc,id,track_jday,scale,'bp26_sst','/matlab/data/ReynoldsSST/mat/OI_25_30_','t');
[mask_t_cc,mask_t_c] = comps_dir_grad(x,y,cyc,id,track_jday,scale,'flag_good','/matlab/data/gsm/mat/GSM_9_21_','t');
[mask_g_cc,mask_g_c] = comps_dir_grad(x,y,cyc,id,track_jday,scale,'flag_good','/matlab/data/gsm/mat/GSM_9_21_','g');
[wspd_cc,wspd_c] = comps_dir_grad(x,y,cyc,id,track_jday,scale,'bp26_wspd','/matlab/data/QuickScat/mat/QSCAT_30_25km_','t');
[t_log_cc,t_log_c] = comps_dir_grad(x,y,cyc,id,track_jday,scale,'bp21_chl','/matlab/data/gsm/mat/GSM_9_21_','t');
[sst_cc,sst_c] = comps_dir_grad(x,y,cyc,id,track_jday,scale,'bp26_sst','/matlab/data/ReynoldsSST/mat/OI_25_30_','t');
[t_chl_cc,t_chl_c] = comps_dir_grad(x,y,cyc,id,track_jday,scale,'sp66_chl','/matlab/data/gsm/mat/GSM_9_21_','t');
[t_car_cc,t_car_c] = comps_dir_grad(x,y,cyc,id,track_jday,scale,'sp66_car','/matlab/data/gsm/mat/GSM_9_21_','t');
%}
save -append new_midlat_comps wspd*


return
%}
load new_midlat_comps
%{
sst_percent_ac=[sst_cc.N_count_c/(sst_cc.N_count_a+sst_cc.N_count_c)	sst_cc.S_count_c/(sst_cc.S_count_a+sst_cc.S_count_c)
				sst_c.N_count_c/(sst_c.N_count_a+sst_c.N_count_c)	sst_c.S_count_c/(sst_c.S_count_a+sst_c.S_count_c)]
chl_percent_ac=[chl_cc.N_count_c/(chl_cc.N_count_a+chl_cc.N_count_c)	chl_cc.S_count_c/(chl_cc.S_count_a+chl_cc.S_count_c)
				chl_c.N_count_c/(chl_c.N_count_a+chl_c.N_count_c)	chl_c.S_count_c/(chl_c.S_count_a+chl_c.S_count_c)]
car_percent_ac=[car_cc.N_count_c/(car_cc.N_count_a+car_cc.N_count_c)	car_cc.S_count_c/(car_cc.S_count_a+car_cc.S_count_c)
				car_c.N_count_c/(car_c.N_count_a+car_c.N_count_c)	car_c.S_count_c/(car_c.S_count_a+car_c.S_count_c)]
%{


fbc=['chl_pol_c.median'];
flc='chl_pol_c';
eval(['lab=num2str(chl_pol_c.n_max_sample);'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(tmp,tmp,-.002,.002,.0003,-1,1,['N=',lab],...
	['~/Documents/OSU/figures/regions/midlat_comps/',flc])

fbc=['chl_pol_a.median'];
flc='chl_pol_a';
eval(['lab=num2str(chl_pol_a.n_max_sample);'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(tmp,tmp,-.002,.002,.0003,-1,1,['N=',lab],...
	['~/Documents/OSU/figures/regions/midlat_comps/',flc])	
	
fbc=['car_pol_c.median'];
flc='car_pol_c';
eval(['lab=num2str(car_pol_c.n_max_sample);'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(tmp,tmp,-.15,.15,.01,-1,1,['N=',lab],...
	['~/Documents/OSU/figures/regions/midlat_comps/',flc])

fbc=['car_pol_a.median'];
flc='car_pol_a';
eval(['lab=num2str(car_pol_a.n_max_sample);'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(tmp,tmp,-.15,.15,.01,-1,1,['N=',lab],...
	['~/Documents/OSU/figures/regions/midlat_comps/',flc])		

fbc=['sst_c.N_median'];
flc='sst_c_N';
eval(['lab=num2str(sst_c.N_n_max_sample);'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(tmp,tmp,-.2,.2,.05,-1,1,['CW N  n=',lab],...
	['~/Documents/OSU/figures/regions/midlat_comps/',flc])

fbc=['sst_cc.N_median'];
flc='sst_cc_N';
eval(['lab=num2str(sst_cc.N_n_max_sample);'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(tmp,tmp,-.2,.2,.05,-1,1,['CC N  n=',lab],...
	['~/Documents/OSU/figures/regions/midlat_comps/',flc])
	
fbc=['sst_c.S_median'];
flc='sst_c_S';
eval(['lab=num2str(sst_c.S_n_max_sample);'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(tmp,tmp,-.2,.2,.05,-1,1,['CW S  n=',lab],...
	['~/Documents/OSU/figures/regions/midlat_comps/',flc])

fbc=['sst_cc.S_median'];
flc='sst_cc_S';
eval(['lab=num2str(sst_cc.S_n_max_sample);'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(tmp,tmp,-.2,.2,.05,-1,1,['CC S  n=',lab],...
	['~/Documents/OSU/figures/regions/midlat_comps/',flc])
%}
%}
zgrid_grid
cw=find(xi(1,:)<=0.2);
ce=find(xi(1,:)>0.2);

wchl=chl_c.N_median(:,cw);
echl=chl_c.N_median(:,ce);
g=max(abs(wchl(:)))/max(abs(echl(:)))
r=num2str(round(g*100)/100);	
fbc=['chl_c.N_median'];
flc='chl_c_N';
eval(['lab=num2str(chl_c.N_n_max_sample);'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(tmp,tmp,-.002,.002,.0003,-1,1,['r=',r],...
	['~/Documents/OSU/figures/regions/midlat_comps/',flc])

wchl=chl_cc.N_median(:,cw);
echl=chl_cc.N_median(:,ce);
g=max(abs(wchl(:)))/max(abs(echl(:)))
r=num2str(round(g*100)/100);	
fbc=['chl_cc.N_median'];
flc='chl_cc_N';
eval(['lab=num2str(chl_cc.N_n_max_sample);'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(tmp,tmp,-.002,.002,.0003,-1,1,['r=',r],...
	['~/Documents/OSU/figures/regions/midlat_comps/',flc])
	
wchl=chl_c.S_median(:,cw);
echl=chl_c.S_median(:,ce);
g=max(abs(wchl(:)))/max(abs(echl(:)))
r=num2str(round(g*100)/100);	
fbc=['chl_c.S_median'];
flc='chl_c_S';
eval(['lab=num2str(chl_c.S_n_max_sample);'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(tmp,tmp,-.002,.002,.0003,-1,1,['r=',r],...
	['~/Documents/OSU/figures/regions/midlat_comps/',flc])

wchl=chl_cc.S_median(:,cw);
echl=chl_cc.S_median(:,ce);
g=max(abs(wchl(:)))/max(abs(echl(:)))
r=num2str(round(g*100)/100);	
fbc=['chl_cc.S_median'];
flc='chl_cc_S';
eval(['lab=num2str(chl_cc.S_n_max_sample);'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(tmp,tmp,-.002,.002,.0003,-1,1,['r=',r],...
	['~/Documents/OSU/figures/regions/midlat_comps/',flc])	
	
