
clear all
%{
load /Volumes/matlab/data/eddy/V4/global_tracks_v4_12_weeks

f1=find(abs(gy)>=15 & abs(gy)<=35 & amp>=10);
	id=id(f1);
	eid=eid(f1);
	x=x(f1);
	y=y(f1);
	gx=gx(f1);
	gy=gy(f1);
	amp=amp(f1);
	axial_speed=axial_speed(f1);
	efold=efold(f1);
	radius=radius(f1);
	track_jday=track_jday(f1);
	prop_speed=prop_speed(f1);
	k=k(f1);
save tracks/midlat_tracks

load /Volumes/matlab/data/eddy/V4/global_tracks_v4_12_weeks

f1=find(gy>=15 & gy<=35 & amp>=10);
	id=id(f1);
	eid=eid(f1);
	x=x(f1);
	y=y(f1);
	gx=gx(f1);
	gy=gy(f1);
	amp=amp(f1);
	axial_speed=axial_speed(f1);
	efold=efold(f1);
	radius=radius(f1);
	track_jday=track_jday(f1);
	prop_speed=prop_speed(f1);
	k=k(f1);
save tracks/north_midlat_tracks

load /Volumes/matlab/data/eddy/V4/global_tracks_v4_12_weeks

f1=find(gy<=-15 & gy>=-35 & amp>=10);
	id=id(f1);
	eid=eid(f1);
	x=x(f1);
	y=y(f1);
	gx=gx(f1);
	gy=gy(f1);
	amp=amp(f1);
	axial_speed=axial_speed(f1);
	efold=efold(f1);
	radius=radius(f1);
	track_jday=track_jday(f1);
	prop_speed=prop_speed(f1);
	k=k(f1);
save tracks/south_midlat_tracks	


[north_crl_a,midlat_crl_c]=mcomps('tracks/north_midlat_tracks','nrbp26_crl_sample','n');
[north_crlg_a,midlat_crlg_c]=mcomps('tracks/north_midlat_tracks','nrbp26_crlg_sample','n');
[south_crl_a,midlat_crl_c]=mcomps('tracks/south_midlat_tracks','nrbp26_crl_sample','n');
[south_crlg_a,midlat_crlg_c]=mcomps('tracks/south_midlat_tracks','nrbp26_crlg_sample','n');
[foi_c,foi_cc]=clock_comps('tracks/midlat_tracks','nrbp26_sst_sample','n');


[south_foi_a,midlat_foi_c]=mcomps('tracks/south_midlat_tracks','nrbp26_sst_sample','n');
[north_foi_a,midlat_foi_c]=mcomps('tracks/south_midlat_tracks','nrbp26_sst_sample','n');
[south_wspd_a,midlat_wspd_c]=mcomps('tracks/north_midlat_tracks','nrbp26_wspd_sample','n');
[north_wspd_a,midlat_wspd_c]=mcomps('tracks/north_midlat_tracks','nrbp26_wspd_sample','n');


[crlg_c,crlg_cc]=clock_comps('tracks/midlat_tracks','nrbp26_crlg_sample','n');
[crl_c,crl_cc]=clock_comps('tracks/midlat_tracks','nrbp26_crl_sample','n');
[sst_crl_c,sst_crl_cc]=clock_comps('tracks/midlat_tracks','nrbp26_sst_ind_crl_sample','n');

[rot_mgrad_bp26_chl_c,rot_mgrad_bp26_chl_cc]=clock_comps('tracks/midlat_tracks',...
'nrnbp21_chl_sample','t');
[midlat_chl_a,midlat_chl_c]=mcomps('tracks/midlat_tracks','nrnbp21_chl_sample','n');
[midlat_car_a,midlat_car_c]=mcomps('tracks/midlat_tracks','nrbp26_car_sample','n');
[midlat_wek_a,midlat_wek_c]=mcomps('tracks/midlat_tracks','nrw_ek_sample','n');
[midlat_a_a,midlat_a_c]=mcomps('tracks/midlat_tracks','nrbp26_a_sample','n');
[midlat_foi_a,midlat_foi_c]=mcomps('tracks/midlat_tracks','nrfiltered_sst_oi_sample','n');
[midlat_wspd_a,midlat_wspd_c]=mcomps('tracks/midlat_tracks','nrbp26_wspd_sample','n');
%}
[midlat_ssh_a,midlat_ssh_c]=mcomps('tracks/midlat_tracks','nrssh_sample','n');
[midlat_ssh_nomask_a,midlat_ssh_nomask_c]=mcomps('tracks/midlat_tracks','nrssh_sample','no_mask');

save -append midlat_comps
return
%}


load midlat_comps

fnc=['crlg_c.N'];
fmc=['crlg_c.n_max_sample'];
fbc=['crlg_c.median'];
flc=['crlg_c'];
eval(['ttt=interp2(',fnc,',2);'])
mask_min=nan*ttt;
eval(['mask_min((ttt./',fmc,')>=.1)=1;'])
eval(['tmp = 1e5*double(interp2(',fbc,',2).*mask_min);'])
cplot_comps_cont_3_3(tmp,tmp,-.45,.45,.05,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/comps/',flc])
eval(['tmp = 1e5*double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp,tmp,-.45,.45,.05,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/comps/',flc,'_bg'])

fnc=['crlg_cc.N'];
fmc=['crlg_cc.n_max_sample'];
fbc=['crlg_cc.median'];
flc=['crlg_cc'];
eval(['ttt=interp2(',fnc,',2);'])
mask_min=nan*ttt;
eval(['mask_min((ttt./',fmc,')>=.1)=1;'])
eval(['tmp = 1e5*double(interp2(',fbc,',2).*mask_min);'])
cplot_comps_cont_3_3(tmp,tmp,-.45,.45,.05,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/comps/',flc])
eval(['tmp = 1e5*double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp,tmp,-.45,.45,.05,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/comps/',flc,'_bg'])
	
fnc=['crl_c.N'];
fmc=['crl_c.n_max_sample'];
fbc=['crl_c.median'];
flc=['crl_c'];
eval(['ttt=interp2(',fnc,',2);'])
mask_min=nan*ttt;
eval(['mask_min((ttt./',fmc,')>=.1)=1;'])
eval(['tmp = -1e5*double(interp2(',fbc,',2).*mask_min);'])
cplot_comps_cont_3_3(tmp,tmp,-.35,.35,.05,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/comps/',flc])
eval(['tmp = -1e5*double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp,tmp,-.35,.35,.05,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/comps/',flc,'_bg'])

fnc=['crl_cc.N'];
fmc=['crl_cc.n_max_sample'];
fbc=['crl_cc.median'];
flc=['crl_cc'];
eval(['ttt=interp2(',fnc,',2);'])
mask_min=nan*ttt;
eval(['mask_min((ttt./',fmc,')>=.1)=1;'])
eval(['tmp = -1e5*double(interp2(',fbc,',2).*mask_min);'])
cplot_comps_cont_3_3(tmp,tmp,-.35,.35,.05,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/comps/',flc])
eval(['tmp = -1e5*double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp,tmp,-.35,.35,.05,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/comps/',flc,'_bg'])	
	
	
%{
fnc=['rot_mgrad_bp26_chl_c.N'];
fmc=['rot_mgrad_bp26_chl_c.n_max_sample'];
fbc=['rot_mgrad_bp26_chl_c.median'];
flc=['rot_15_35_bp21_chl_c'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp,tmp,-.015,.015,.001,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/comps/',flc])

fna=['rot_mgrad_bp26_chl_cc.N'];
fma=['rot_mgrad_bp26_chl_cc.n_max_sample'];
fba=['rot_mgrad_bp26_chl_cc.median'];
fla=['rot_15_35_bp21_chl_cc'];
eval(['lab=num2str(', fma,');'])
eval(['tmp = double(interp2(',fba,',2));'])
cplot_comps_cont_3_3(tmp,tmp,-.015,.015,.001,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/comps/',fla])
	
return
fnc=['midlat_chl_c.N'];
fmc=['midlat_chl_c.n_max_sample'];
fbc=['midlat_chl_c.median'];
flc=['midlat_chl_c'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp,tmp,-.01,.01,.0005,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/comps/',flc])

fna=['midlat_chl_a.N'];
fma=['midlat_chl_a.n_max_sample'];
fba=['midlat_chl_a.median'];
fla=['midlat_chl_a'];
eval(['lab=num2str(', fma,');'])
eval(['tmp = double(interp2(',fba,',2));'])
cplot_comps_cont_3_3(tmp,tmp,-.01,.01,.0005,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/comps/',fla])

fnc=['midlat_wek_c.N'];
fmc=['midlat_wek_c.n_max_sample'];
fbc=['midlat_wek_c.median'];
flc=['midlat_wek_c'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp,tmp,-.12,.12,.005,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/comps/',flc])

fna=['midlat_wek_a.N'];
fma=['midlat_wek_a.n_max_sample'];
fba=['midlat_wek_a.median'];
fla=['midlat_wek_a'];
eval(['lab=num2str(', fma,');'])
eval(['tmp = double(interp2(',fba,',2));'])
cplot_comps_cont_3_3(tmp,tmp,-.12,.12,.005,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/comps/',fla])

fnc=['midlat_foi_c.N'];
fmc=['midlat_foi_c.n_max_sample'];
fbc=['midlat_foi_c.median'];
flc=['midlat_foi_c'];
eval(['ttt=interp2(',fnc,',2);'])
mask_min=nan*ttt;
eval(['mask_min((ttt./',fmc,')>=.1)=1;'])
eval(['tmp = double(interp2(',fbc,',2).*mask_min);'])
cplot_comps_cont_3_3(tmp,tmp,-.25,.25,.02,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/comps/',flc])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp,tmp,-.25,.25,.02,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/comps/',flc,'_bg'])

fna=['midlat_foi_a.N'];
fma=['midlat_foi_a.n_max_sample'];
fba=['midlat_foi_a.median'];
fla=['midlat_foi_a'];
eval(['ttt=interp2(',fna,',2);'])
mask_min=nan*ttt;
eval(['mask_min((ttt./',fma,')>=.1)=1;'])
eval(['tmp = double(interp2(',fba,',2).*mask_min);'])
cplot_comps_cont_3_3(tmp,tmp,-.25,.25,.02,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/comps/',fla])
eval(['tmp = double(interp2(',fba,',2));'])
cplot_comps_cont_3_3(tmp,tmp,-.25,.25,.02,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/comps/',fla,'_bg'])
	
	
fnc=['midlat_wspd_c.N'];
fmc=['midlat_wspd_c.n_max_sample'];
fbc=['midlat_wspd_c.median'];
flc=['midlat_wspd_c'];
eval(['ttt=interp2(',fnc,',2);'])
mask_min=nan*ttt;
eval(['mask_min((ttt./',fmc,')>=.1)=1;'])
eval(['tmp = double(interp2(',fbc,',2).*mask_min);'])
cplot_comps_cont_3_3(tmp,tmp,-.25,.25,.02,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/comps/',flc])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp,tmp,-.25,.25,.02,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/comps/',flc,'_bg'])

fna=['midlat_wspd_a.N'];
fma=['midlat_wspd_a.n_max_sample'];
fba=['midlat_wspd_a.median'];
fla=['midlat_wspd_a'];
eval(['ttt=interp2(',fna,',2);'])
mask_min=nan*ttt;
eval(['mask_min((ttt./',fma,')>=.1)=1;'])
eval(['tmp = double(interp2(',fba,',2).*mask_min);'])
cplot_comps_cont_3_3(tmp,tmp,-.25,.25,.02,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/comps/',fla])
eval(['tmp = double(interp2(',fba,',2));'])
cplot_comps_cont_3_3(tmp,tmp,-.25,.25,.02,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/comps/',fla,'_bg'])
	
	

%}	
	