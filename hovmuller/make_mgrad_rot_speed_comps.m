
clear all
%{
load /Volumes/matlab/data/eddy/V4/global_tracks_v4_16_weeks

f1=find(abs(gy)>=10 & abs(gy)<=45 & axial_speed<=9.6);
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
save mgrad_combo_10_cms_tracks	

clear all
load /Volumes/matlab/data/eddy/V4/global_tracks_v4_16_weeks

f1=find(abs(gy)>=10 & abs(gy)<=45 & axial_speed>9.6 & axial_speed<=13.9);
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
save mgrad_combo_10_20_cms_tracks

clear all
load /Volumes/matlab/data/eddy/V4/global_tracks_v4_16_weeks

f1=find(abs(gy)>=10 & abs(gy)<=45 & axial_speed>13.9 & axial_speed<=21.1);
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
save mgrad_combo_20_30_cms_tracks

clear all
load /Volumes/matlab/data/eddy/V4/global_tracks_v4_16_weeks

f1=find(abs(gy)>=10 & abs(gy)<=45 & axial_speed>21.1);
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
save mgrad_combo_30_cms_tracks
	
	
[rot_10_cms_chl_c,rot_10_cms_chl_cc]=clock_comps('mgrad_combo_10_cms_tracks',...
'nrnbp21_chl_sample','t');
[rot_10_20_cms_chl_c,rot_10_20_cms_chl_cc]=clock_comps('mgrad_combo_10_20_cms_tracks',...
'nrnbp21_chl_sample','t');
[rot_20_30_cms_chl_c,rot_20_30_cms_chl_cc]=clock_comps('mgrad_combo_20_30_cms_tracks',...
'nrnbp21_chl_sample','t');
[rot_30_cms_chl_c,rot_30_cms_chl_cc]=clock_comps('mgrad_combo_30_cms_tracks',...
'nrnbp21_chl_sample','t');
%[rot_mgrad_bp26_chl_c,rot_mgrad_bp26_chl_cc]=clock_comps('/Volumes/matlab/data/eddy/V4/global_tracks_V4_16_weeks',...
%'nrnbp21_chl_sample','t');
save mgrad_rot_speed_comps
return
%}


load mgrad_rot_speed_comps


fbc=['rot_10_cms_chl_c.median'];
flc=['rot_10_cms_chl_c'];
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp,tmp,-.02,.02,.0015,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',flc])

fba=['rot_10_cms_chl_cc.median'];
fla=['rot_10_cms_chl_cc'];
eval(['tmp = double(interp2(',fba,',2));'])
cplot_comps_cont_3_3(tmp,tmp,-.02,.02,.0015,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',fla])

fbc=['rot_10_20_cms_chl_c.median'];
flc=['rot_10_20_cms_chl_c'];
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp,tmp,-.02,.02,.0015,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',flc])

fba=['rot_10_20_cms_chl_cc.median'];
fla=['rot_10_20_cms_chl_cc'];
eval(['tmp = double(interp2(',fba,',2));'])
cplot_comps_cont_3_3(tmp,tmp,-.02,.02,.0015,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',fla])
	
fbc=['rot_20_30_cms_chl_c.median'];
flc=['rot_20_30_cms_chl_c'];
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp,tmp,-.02,.02,.0015,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',flc])

fba=['rot_20_30_cms_chl_cc.median'];
fla=['rot_20_30_cms_chl_cc'];
eval(['tmp = double(interp2(',fba,',2));'])
cplot_comps_cont_3_3(tmp,tmp,-.02,.02,.0015,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',fla])
	
fbc=['rot_30_cms_chl_c.median'];
flc=['rot_30_cms_chl_c'];
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp,tmp,-.02,.02,.0015,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',flc])

fba=['rot_30_cms_chl_cc.median'];
fla=['rot_30_cms_chl_cc'];
eval(['tmp = double(interp2(',fba,',2));'])
cplot_comps_cont_3_3(tmp,tmp,-.02,.02,.0015,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',fla])
	
	
	