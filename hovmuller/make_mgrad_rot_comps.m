
clear all
%{
load /matlab/data/eddy/V4/global_tracks_v4_12_weeks

f1=find(abs(gy)>=15 & abs(gy)<=45);
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
save mgrad_combo_tracks	

%
load mgrad_combo_tracks
startjd=2451395;
endjd=2454461;
f1=find(track_jday>=startjd & track_jday<=endjd & amp<5);
id=id(f1);
y=y(f1);
track_jday=track_jday(f1);

[rot_small_ssh_c,rot_small_ssh_cc]=clock_comps(id,track_jday,y,'nrssh_sample','n');
[rot_small_bp21_chl_c,rot_small_bp21_chl_cc]=clock_comps(id,track_jday,y,'nrbp26_chl_sample','t');

load mgrad_combo_tracks
startjd=2451395;
endjd=2454461;
f1=find(track_jday>=startjd & track_jday<=endjd & amp>=5);
id=id(f1);
y=y(f1);
track_jday=track_jday(f1);

[rot_large_ssh_c,rot_large_ssh_cc]=clock_comps(id,track_jday,y,'nrssh_sample','n');
[rot_large_bp21_chl_c,rot_large_bp21_chl_cc]=clock_comps(id,track_jday,y,'nrbp26_chl_sample','t');
%
load mgrad_combo_tracks
startjd=2451395;
endjd=2454461;
f1=find(track_jday>=startjd & track_jday<=endjd);
id=id(f1);
y=y(f1);
track_jday=track_jday(f1);

%[rot_all_ssh_c,rot_all_ssh_cc]=clock_comps(id,track_jday,y,'nrssh_sample','n');
%[rot_all_bp21_chl_N_c,rot_all_bp21_chl_N_cc]=dir_clock_comps(id,track_jday,y,'nrbp26_chl_sample','N','t');
%[rot_all_bp21_chl_S_c,rot_all_bp21_chl_S_cc]=dir_clock_comps(id,track_jday,y,'nrbp26_chl_sample','S','t');
%[rot_all_bp21_chl_N_c,rot_all_bp21_chl_N_cc]=dir_clock_comps(id,track_jday,y,'nrbp26_chl_sample','N','t');
%[rot_all_bp21_chl_S_c,rot_all_bp21_chl_S_cc]=dir_clock_comps(id,track_jday,y,'nrbp26_chl_sample','S','t');
[rot_raw_bp21_chl_N_c,rot_raw_bp21_chl_N_cc]=dir_clock_comps(id,track_jday,y,'nrraw_bp21_chl_sample','N','t');
[rot_raw_bp21_chl_S_c,rot_raw_bp21_chl_S_cc]=dir_clock_comps(id,track_jday,y,'nrraw_bp21_chl_sample','S','t');
%[rot_all_bp26_sst_N_c,rot_all_bp26_sst_N_cc]=dir_clock_comps(id,track_jday,y,'nrbp26_sst_sample','N','t');
%[rot_all_bp26_sst_S_c,rot_all_bp26_sst_S_cc]=dir_clock_comps(id,track_jday,y,'nrbp26_sst_sample','S','t');
%[rot_all_ssh_N_c,rot_all_ssh_N_cc]=dir_clock_comps(id,track_jday,y,'nrssh_sample','N','n');
%[rot_all_ssh_S_c,rot_all_ssh_S_cc]=dir_clock_comps(id,track_jday,y,'nrssh_sample','S','n');
%[rot_tgrad_bp26_sst_c,rot_tgrad_bp26_sst_cc]=clock_comps('mgrad_combo_tracks',...
%'nrbp26_sst_sample','t');
%[rot_mgrad_bp26_chl_c,rot_mgrad_bp26_chl_cc]=clock_comps('/Volumes/matlab/data/eddy/V4/global_tracks_V4_16_weeks',...
%'nrnbp21_chl_sample','t');
save  -append new_mgrad_rot_comps
return
%


%fix ssh to be same size as chl
%load mgrad_rot_comps rot_*
zgrid_grid
r_comp=25:57;%17:65;
c_comp=25:57;%17:65;
x1=xi(r_comp,c_comp);
y1=yi(r_comp,c_comp);

wgrid_grid
r_comp=49:113;%33:129;
c_comp=49:113;%33:129;
x2=xi(r_comp,c_comp);
y2=yi(r_comp,c_comp);

interp_rot_small_ssh_c.median=griddata(x1,y1,double(rot_small_ssh_c.median),x2,y2,'linear');
interp_rot_small_ssh_cc.median=griddata(x1,y1,double(rot_small_ssh_cc.median),x2,y2,'linear');

interp_rot_large_ssh_c.median=griddata(x1,y1,double(rot_large_ssh_c.median),x2,y2,'linear');
interp_rot_large_ssh_cc.median=griddata(x1,y1,double(rot_large_ssh_cc.median),x2,y2,'linear');

interp_rot_all_ssh_c.median=griddata(x1,y1,double(rot_all_ssh_c.median),x2,y2,'linear');
interp_rot_all_ssh_cc.median=griddata(x1,y1,double(rot_all_ssh_cc.median),x2,y2,'linear');


save new_mgrad_rot_comps
return
%

load new_mgrad_rot_comps
%{
fnc=['rot_tgrad_bp26_sst_c.N'];
fmc=['rot_tgrad_bp26_sst_c.n_max_sample'];
fbc=['rot_tgrad_bp26_sst_c.median'];
flc=['rot_15_35_bp26_sst_c'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp,tmp,-.25,.25,.01,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',flc])

fna=['rot_tgrad_bp26_sst_cc.N'];
fma=['rot_tgrad_bp26_sst_cc.n_max_sample'];
fba=['rot_tgrad_bp26_sst_cc.median'];
fla=['rot_15_35_bp26_sst_cc'];
eval(['lab=num2str(', fma,');'])
eval(['tmp = double(interp2(',fba,',2));'])
cplot_comps_cont_3_3(tmp,tmp,-.25,.25,.01,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',fla])
%}

g=abs(min(rot_all_bp21_chl_N_c.mean(:))/max(rot_all_bp21_chl_N_c.mean(:)))
r=round(g*100)/100;
fnc=['rot_raw_bp21_chl_N_c.N'];
fmc=['rot_raw_bp21_chl_N_c.n_max_sample'];
fbc=['rot_raw_bp21_chl_N_c.mean'];
flc=['rot_raw_bp21_chl_N_c'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(tmp,tmp,-.007,.007,.001,-1,1,['CW northward @MAi@ CHL'],...
	['~/Documents/OSU/figures/hovmuller/comps/',flc])

g=abs(max(rot_raw_bp21_chl_N_cc.mean(:))/min(rot_raw_bp21_chl_N_cc.mean(:)))
r=round(g*100)/100;
fnc=['rot_raw_bp21_chl_N_cc.N'];
fmc=['rot_raw_bp21_chl_N_cc.n_max_sample'];
fbc=['rot_raw_bp21_chl_N_cc.mean'];
flc=['rot_raw_bp21_chl_N_cc'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(tmp,tmp,-.007,.007,.001,-1,1,['CCW northward @MAi@ CHL'],...
	['~/Documents/OSU/figures/hovmuller/comps/',flc])
	
g=abs(min(rot_all_bp21_chl_S_c.mean(:))/max(rot_all_bp21_chl_S_c.mean(:)))
r=round(g*100)/100;
fnc=['rot_raw_bp21_chl_S_c.N'];
fmc=['rot_raw_bp21_chl_S_c.n_max_sample'];
fbc=['rot_raw_bp21_chl_S_c.mean'];
flc=['rot_raw_bp21_chl_S_c'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(tmp,tmp,-.007,.007,.001,-1,1,['CW southward @MAi@ CHL'],...
	['~/Documents/OSU/figures/hovmuller/comps/',flc])

g=abs(max(rot_raw_bp21_chl_S_cc.mean(:))/min(rot_raw_bp21_chl_S_cc.mean(:)))
r=round(g*100)/100;
fnc=['rot_raw_bp21_chl_S_cc.N'];
fmc=['rot_raw_bp21_chl_S_cc.n_max_sample'];
fbc=['rot_raw_bp21_chl_S_cc.mean'];
flc=['rot_raw_bp21_chl_S_cc'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(tmp,tmp,-.007,.007,.001,-1,1,['CCW southward @MAi@ CHL'],...
	['~/Documents/OSU/figures/hovmuller/comps/',flc])
	
g=abs(min(rot_all_bp21_chl_N_c.mean(:))/max(rot_all_bp21_chl_N_c.mean(:)))
r=round(g*100)/100;
fnc=['rot_all_bp21_chl_N_c.N'];
fmc=['rot_all_bp21_chl_N_c.n_max_sample'];
fbc=['rot_all_bp21_chl_N_c.mean'];
flc=['rot_all_bp21_chl_N_c'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(tmp,tmp,-.007,.007,.001,-1,1,['CW northward @MAi@ CHL'],...
	['~/Documents/OSU/figures/hovmuller/comps/',flc])

g=abs(max(rot_all_bp21_chl_N_cc.mean(:))/min(rot_all_bp21_chl_N_cc.mean(:)))
r=round(g*100)/100;
fnc=['rot_all_bp21_chl_N_cc.N'];
fmc=['rot_all_bp21_chl_N_cc.n_max_sample'];
fbc=['rot_all_bp21_chl_N_cc.mean'];
flc=['rot_all_bp21_chl_N_cc'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(tmp,tmp,-.007,.007,.001,-1,1,['CCW northward @MAi@ CHL'],...
	['~/Documents/OSU/figures/hovmuller/comps/',flc])
	
g=abs(min(rot_all_bp21_chl_S_c.mean(:))/max(rot_all_bp21_chl_S_c.mean(:)))
r=round(g*100)/100;
fnc=['rot_all_bp21_chl_S_c.N'];
fmc=['rot_all_bp21_chl_S_c.n_max_sample'];
fbc=['rot_all_bp21_chl_S_c.mean'];
flc=['rot_all_bp21_chl_S_c'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(tmp,tmp,-.007,.007,.001,-1,1,['CW southward @MAi@ CHL'],...
	['~/Documents/OSU/figures/hovmuller/comps/',flc])

g=abs(max(rot_all_bp21_chl_S_cc.mean(:))/min(rot_all_bp21_chl_S_cc.mean(:)))
r=round(g*100)/100;
fnc=['rot_all_bp21_chl_S_cc.N'];
fmc=['rot_all_bp21_chl_S_cc.n_max_sample'];
fbc=['rot_all_bp21_chl_S_cc.mean'];
flc=['rot_all_bp21_chl_S_cc'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(tmp,tmp,-.007,.007,.001,-1,1,['CCW southward @MAi@ CHL'],...
	['~/Documents/OSU/figures/hovmuller/comps/',flc])
	
return
	
fnc=['rot_all_bp21_chl_N_c.N'];
fmc=['rot_all_bp21_chl_N_c.n_max_sample'];
fbc=['rot_all_bp21_chl_N_c.mean'];
flc=['rot_all_15_45_bp26_chl_mean_N_c'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(tmp,tmp,-.007,.007,.001,-1,1,'clockwise',...
	['~/Documents/OSU/figures/hovmuller/comps/',flc])

fna=['rot_all_bp21_chl_N_cc.N'];
fma=['rot_all_bp21_chl_N_cc.n_max_sample'];
fba=['rot_all_bp21_chl_N_cc.mean'];
fla=['rot_all_15_45_bp26_chl_mean_N_cc'];
eval(['lab=num2str(', fma,');'])
eval(['tmp = double(interp2(',fba,',2));'])
cplot_comps_cont_2_2(tmp,tmp,-.007,.007,.001,-1,1,'counterclockwise',...
	['~/Documents/OSU/figures/hovmuller/comps/',fla])
	
fnc=['rot_all_bp21_chl_S_c.N'];
fmc=['rot_all_bp21_chl_S_c.n_max_sample'];
fbc=['rot_all_bp21_chl_S_c.mean'];
flc=['rot_all_15_45_bp26_chl_mean_S_c'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(tmp,tmp,-.007,.007,.001,-1,1,'clockwise',...
	['~/Documents/OSU/figures/hovmuller/comps/',flc])

fna=['rot_all_bp21_chl_S_cc.N'];
fma=['rot_all_bp21_chl_S_cc.n_max_sample'];
fba=['rot_all_bp21_chl_S_cc.mean'];
fla=['rot_all_15_45_bp26_chl_mean_S_cc'];
eval(['lab=num2str(', fma,');'])
eval(['tmp = double(interp2(',fba,',2));'])
cplot_comps_cont_2_2(tmp,tmp,-.007,.007,.001,-1,1,'counterclockwise',...
	['~/Documents/OSU/figures/hovmuller/comps/',fla])
	
	
return	
%}
load /matlab/matlab/air-sea/midlat_comps

g=abs(min(bp26_sst_N_c.mean(:))/max(bp26_sst_N_c.mean(:)))
r=round(g*100)/100;
fnc=['bp26_sst_N_c.N'];
fmc=['bp26_sst_N_c.n_max_sample'];
fbc=['bp26_sst_N_c.mean'];
flc=['bp26_sst_N_c'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(tmp,tmp,-.3,.3,.05,-1,1,['CW northward @MAi@ T'],...
	['~/Documents/OSU/figures/hovmuller/comps/',flc])

g=abs(max(bp26_sst_N_cc.mean(:))/min(bp26_sst_N_cc.mean(:)))
r=round(g*100)/100;
fnc=['bp26_sst_N_cc.N'];
fmc=['bp26_sst_N_cc.n_max_sample'];
fbc=['bp26_sst_N_cc.mean'];
flc=['bp26_sst_N_cc'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(tmp,tmp,-.3,.3,.05,-1,1,['CCW northward @MAi@ T'],...
	['~/Documents/OSU/figures/hovmuller/comps/',flc])	
	
	return
	
fnc=['rot_all_bp21_chl_N_c.N'];
fmc=['rot_all_bp21_chl_N_c.n_max_sample'];
fbc=['rot_all_bp21_chl_N_c.mean'];
flc=['rot_all_15_45_bp26_chl_mean_N_c'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(tmp,tmp,-.007,.007,.001,-1,1,'clockwise',...
	['~/Documents/OSU/figures/hovmuller/comps/',flc])

fna=['rot_all_bp21_chl_N_cc.N'];
fma=['rot_all_bp21_chl_N_cc.n_max_sample'];
fba=['rot_all_bp21_chl_N_cc.mean'];
fla=['rot_all_15_45_bp26_chl_mean_N_cc'];
eval(['lab=num2str(', fma,');'])
eval(['tmp = double(interp2(',fba,',2));'])
cplot_comps_cont_2_2(tmp,tmp,-.007,.007,.001,-1,1,'counterclockwise',...
	['~/Documents/OSU/figures/hovmuller/comps/',fla])
	
fnc=['rot_all_bp21_chl_S_c.N'];
fmc=['rot_all_bp21_chl_S_c.n_max_sample'];
fbc=['rot_all_bp21_chl_S_c.mean'];
flc=['rot_all_15_45_bp26_chl_mean_S_c'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(tmp,tmp,-.007,.007,.001,-1,1,'clockwise',...
	['~/Documents/OSU/figures/hovmuller/comps/',flc])

fna=['rot_all_bp21_chl_S_cc.N'];
fma=['rot_all_bp21_chl_S_cc.n_max_sample'];
fba=['rot_all_bp21_chl_S_cc.mean'];
fla=['rot_all_15_45_bp26_chl_mean_S_cc'];
eval(['lab=num2str(', fma,');'])
eval(['tmp = double(interp2(',fba,',2));'])
cplot_comps_cont_2_2(tmp,tmp,-.007,.007,.001,-1,1,'counterclockwise',...
	['~/Documents/OSU/figures/hovmuller/comps/',fla])
	
return	
	
fnc=['rot_small_bp21_chl_c.N'];
fmc=['rot_small_bp21_chl_c.n_max_sample'];
fbc=['rot_small_bp21_chl_c.mean'];
flc=['rot_small_15_45_bp26_chl_mean_c'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(tmp,tmp,-.007,.007,.001,-1,1,'clockwise amp <5cm',...
	['~/Documents/OSU/figures/hovmuller/comps/',flc])

fna=['rot_small_bp21_chl_cc.N'];
fma=['rot_small_bp21_chl_cc.n_max_sample'];
fba=['rot_small_bp21_chl_cc.mean'];
fla=['rot_small_15_45_bp26_chl_mean_cc'];
eval(['lab=num2str(', fma,');'])
eval(['tmp = double(interp2(',fba,',2));'])
cplot_comps_cont_2_2(tmp,tmp,-.007,.007,.001,-1,1,'counterclockwise amp <5cm',...
	['~/Documents/OSU/figures/hovmuller/comps/',fla])	

fnc=['rot_large_bp21_chl_c.N'];
fmc=['rot_large_bp21_chl_c.n_max_sample'];
fbc=['rot_large_bp21_chl_c.mean'];
flc=['rot_large_15_45_bp26_chl_mean_c'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(tmp,tmp,-.007,.007,.001,-1,1,'clockwise amp >=5cm',...
	['~/Documents/OSU/figures/hovmuller/comps/',flc])

fna=['rot_large_bp21_chl_cc.N'];
fma=['rot_large_bp21_chl_cc.n_max_sample'];
fba=['rot_large_bp21_chl_cc.mean'];
fla=['rot_large_15_45_bp26_chl_mean_cc'];
eval(['lab=num2str(', fma,');'])
eval(['tmp = double(interp2(',fba,',2));'])
cplot_comps_cont_2_2(tmp,tmp,-.007,.007,.001,-1,1,'counterclockwiseamp >=5cm',...
	['~/Documents/OSU/figures/hovmuller/comps/',fla])		
	