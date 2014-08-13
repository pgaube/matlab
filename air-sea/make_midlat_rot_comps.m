
clear all
%{
load /matlab/data/eddy/V4/global_tracks_v4_12_weeks

f1=find(abs(y)>=15 & abs(y)<=45);
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

load /matlab/data/eddy/V4/global_tracks_v4_12_weeks

f1=find(y>=15 & y<=45);
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

load /matlab/data/eddy/V4/global_tracks_v4_12_weeks

f1=find(y>=-45 & y<=-15);
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


%
%}
load tracks/midlat_tracks	
%[ssh_a,ssh_c]=mcomps('/matlab/matlab/eddy-wind/tracks/midlat_tracks','nrssh_sample','n');
%[rot_w_ek_a,rot_w_ek_c]=mcomps('/matlab/matlab/eddy-wind/tracks/midlat_tracks','nrw_ek_sample','w');
[rot_w_ek_crlg_a,rot_w_ek_crlg_c]=mcomps('/matlab/matlab/eddy-wind/tracks/midlat_tracks','nrhp_wek_crlg_week_sample','w');
%[w_ek_a,w_ek_c]=mcomps('/matlab/matlab/eddy-wind/tracks/midlat_tracks','nrw_ek_sample','n');
%[w_ek_crlg_a,w_ek_crlg_c]=mcomps('/matlab/matlab/eddy-wind/tracks/midlat_tracks','nrhp_wek_crlg_week_sample','n');
%[bp26_crl_c,bp26_crl_cc]=clock_comps(id,track_jday,y,'nrbp26_crl_sample','n');
%[na_crlg_c,na_crlg_cc]=clock_comps(id,track_jday,y,'nrna_crlg_sample','n');
%[bp26_crlg_c,bp26_crlg_cc]=clock_comps(id,track_jday,y,'nrbp26_crlg_sample','n');
%[bp26_crlgs_c,bp26_crlgs_cc]=clock_comps(id,track_jday,y,'nrbp_crl_gs_sample','n');

%[eof_ssh_a,eof_ssh_c]=eofcomps('tracks/midlat_tracks','nrssh_sample','n');
%[eof_crlg_S_a,eof_crlg_S_c]=eofcomps('tracks/south_midlat_tracks','nrbp26_crlg_sample','n');
%[eof_crlg_N_a,eof_crlg_N_c]=eofcomps('tracks/north_midlat_tracks','nrbp26_crlg_sample','n')
%[eof_crl_S_a,eof_crl_S_c]=eofcomps('tracks/south_midlat_tracks','nrbp26_crl_sample','n');
%[eof_crl_N_a,eof_crl_N_c]=eofcomps('tracks/north_midlat_tracks','nrbp26_crl_sample','n')
%[bp26_sst_N_c,bp26_sst_N_cc]=dir_clock_comps(id,track_jday,y,'nrbp26_sst_sample','N','t');
%[bp26_sst_S_c,bp26_sst_S_cc]=dir_clock_comps(id,track_jday,y,'nrbp26_sst_sample','S','t');
%[bp26_wspd_N_c,bp26_wspd_N_cc]=dir_clock_comps(id,track_jday,y,'nrbp26_wspd_sample','N','t');
%[bp26_wspd_S_c,bp26_wspd_S_cc]=dir_clock_comps(id,track_jday,y,'nrbp26_wspd_sample','S','t');

save -append midlat_comps


return
%}
load midlat_comps
%{
fnc=['w_ek_c.N'];
fmc=['w_ek_c.n_max_sample'];
fbc=['w_ek_c.mean'];
flc=['w_ek_c'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2_bwr(tmp,tmp,-.07,.07,.01,-1,1,['QSCAT W_E^ cyclones'],...
	['~/Documents/OSU/figures/air-sea/comps/',flc])

fnc=['w_ek_a.N'];
fmc=['w_ek_a.n_max_sample'];
fbc=['w_ek_a.mean'];
flc=['w_ek_a'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2_bwr(tmp,tmp,-.07,.07,.01,-1,1,['QSCAT W_E^ cantiyclones'],...
	['~/Documents/OSU/figures/air-sea/comps/',flc])
	
fnc=['w_ek_c.N'];
fmc=['w_ek_crlg_c.n_max_sample'];
fbc=['w_ek_crlg_c.mean'];
flc=['w_ek_crlg_c'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2_bwr(tmp,tmp,-7,7,1,-100,100,['Current-induced W_E^ cyclones'],...
	['~/Documents/OSU/figures/air-sea/comps/',flc])

fnc=['w_ek_a.N'];
fmc=['w_ek_crlg_a.n_max_sample'];
fbc=['w_ek_crlg_a.mean'];
flc=['w_ek_crlg_a'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2_bwr(tmp,tmp,-7,7,1,-100,100,['Current-induced W_E^ anticyclones'],...
	['~/Documents/OSU/figures/air-sea/comps/',flc])	
	
return	
%}
fnc=['rot_w_ek_crlg_c.N'];
fmc=['rot_w_ek_crlg_c.n_max_sample'];
fbc=['rot_w_ek_crlg_c.median'];
flc=['rot_w_ek_crlg_c'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2_bwr(tmp./100,tmp./100,-.07,.07,.005,-1,1,['AVISO cyclones N = ',num2str(w_ek_c.n_max_sample)],...
	['~/Documents/OSU/figures/air-sea/comps/',flc])

fnc=['rot_w_ek_crlg_a.N'];
fmc=['rot_w_ek_crlg_a.n_max_sample'];
fbc=['rot_w_ek_crlg_a.median'];
flc=['rot_w_ek_crlg_a'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2_bwr(tmp./100,tmp./100,-.07,.07,.005,-1,1,['AVISO anticyclones N = ',num2str(w_ek_a.n_max_sample)],...
	['~/Documents/OSU/figures/air-sea/comps/',flc])
%

fnc=['rot_w_ek_c.N'];
fmc=['rot_w_ek_c.n_max_sample'];
fbc=['rot_w_ek_c.median'];
flc=['rot_w_ek_c'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2_bwr(tmp,tmp,-.07,.07,.005,-1,1,['QSCAT cyclones N = ',num2str(w_ek_c.n_max_sample)],...
	['~/Documents/OSU/figures/air-sea/comps/',flc])

fnc=['rot_w_ek_a.N'];
fmc=['rot_w_ek_a.n_max_sample'];
fbc=['rot_w_ek_a.median'];
flc=['rot_w_ek_a'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2_bwr(tmp,tmp,-.07,.07,.005,-1,1,['QSCAT anticyclones N = ',num2str(w_ek_a.n_max_sample)],...
	['~/Documents/OSU/figures/air-sea/comps/',flc])
return
load midlat_comps
fnc=['bp26_wspd_N_c.N'];
fmc=['bp26_wspd_N_c.n_max_sample'];
fbc=['bp26_wspd_N_c.mean'];
flc=['bp26_wspd_N_c'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(tmp,tmp,-.1,.1,.025,-1,1,['cc N = ',num2str(bp26_wspd_N_c.n_max_sample)],...
	['~/Documents/OSU/figures/air-sea/comps/',flc])

fnc=['bp26_wspd_N_cc.N'];
fmc=['bp26_wspd_N_cc.n_max_sample'];
fbc=['bp26_wspd_N_cc.mean'];
flc=['bp26_wspd_N_cc'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(tmp,tmp,-.1,.1,.025,-1,1,['countercc N = ',num2str(bp26_wspd_N_cc.n_max_sample)],...
	['~/Documents/OSU/figures/air-sea/comps/',flc])
	
%
fnc=['bp26_crlg_c.N'];
fmc=['bp26_crlg_c.n_max_sample'];
fbc=['bp26_crlg_c.mean'];
flc=['bp26_crlg_c'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp2 = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(-1e6*tmp2,-1e6*tmp2,-6,6,.6,-10,10,['counterclockwise -@MAiD@ u_g^'],...
	['~/Documents/OSU/figures/air-sea/comps/',flc])
	
fnc=['bp26_crl_c.N'];
fmc=['bp26_crl_c.n_max_sample'];
fbc=['bp26_crl_c.mean'];
flc=['bp26_crl_c'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(1e6*tmp,1e6*tmp,-2,2,.2,-10,10,['counterclockwise @MAiD@ u_w^'],...
	['~/Documents/OSU/figures/air-sea/comps/',flc])

fnc=['na_crlg_c.N'];
fmc=['na_crlg_c.n_max_sample'];
fbc=['na_crlg_c.mean'];
flc=['na_crlg_c'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(-1e6*tmp,-1e6*tmp,-2,2,.2,-10,10,['counterclockwise @MAiD@ u_na^'],...
	['~/Documents/OSU/figures/air-sea/comps/',flc])
	
fnc=['bp26_crlg_cc.N'];
fmc=['bp26_crlg_cc.n_max_sample'];
fbc=['bp26_crlg_cc.mean'];
flc=['bp26_crlg_cc'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp2 = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(-1e6*tmp2,-1e6*tmp2,-6,6,.6,-10,10,['counterclockwise -@MAiD@ u_g^'],...
	['~/Documents/OSU/figures/air-sea/comps/',flc])
	

fnc=['bp26_crl_cc.N'];
fmc=['bp26_crl_cc.n_max_sample'];
fbc=['bp26_crl_cc.mean'];
flc=['bp26_crl_cc'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(1e6*tmp,1e6*tmp,-2,2,.2,-10,10,['counterclockwise @MAiD@ u_w^'],...
	['~/Documents/OSU/figures/air-sea/comps/',flc])
	
fnc=['na_crlg_cc.N'];
fmc=['na_crlg_cc.n_max_sample'];
fbc=['na_crlg_cc.mean'];
flc=['na_crlg_cc'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(-1e6*tmp,-1e6*tmp,-2,2,.2,-10,10,['counterclockwise @MAiD@ u_na^'],...
	['~/Documents/OSU/figures/air-sea/comps/',flc])
return
%
fnc=['rot_w_ek_c.N'];
fmc=['rot_w_ek_c.n_max_sample'];
fbc=['rot_w_ek_c.mean'];
flc=['rot_w_ek_c'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2_bwr(tmp,tmp,-.08,.08,.01,-1,-.01,['cyclones N = ',num2str(w_ek_c.n_max_sample)],...
	['~/Documents/OSU/figures/air-sea/comps/',flc])

fnc=['rot_w_ek_a.N'];
fmc=['rot_w_ek_a.n_max_sample'];
fbc=['rot_w_ek_a.mean'];
flc=['rot_w_ek_a'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2_bwr(tmp,tmp,-.08,.08,.01,.1,1,['anticyclones N = ',num2str(w_ek_a.n_max_sample)],...
	['~/Documents/OSU/figures/air-sea/comps/',flc])
	
fnc=['w_ek_c.N'];
fmc=['w_ek_c.n_max_sample'];
fbc=['w_ek_c.mean'];
flc=['w_ek_c'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2_bwr(tmp,tmp,-.08,.08,.01,-1,-.01,['cyclones N = ',num2str(w_ek_c.n_max_sample)],...
	['~/Documents/OSU/figures/air-sea/comps/',flc])

fnc=['w_ek_a.N'];
fmc=['w_ek_a.n_max_sample'];
fbc=['w_ek_a.median'];
flc=['w_ek_a'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2_bwr(tmp,tmp,-.08,.08,.01,.1,1,['anticyclones N = ',num2str(w_ek_a.n_max_sample)],...
	['~/Documents/OSU/figures/air-sea/comps/',flc])
	
%}
load midlat_comps
g=abs(min(bp26_wspd_N_c.mean(:))/max(bp26_wspd_N_c.mean(:)))
r=round(g*100)/100;
fnc=['bp26_wspd_N_c.N'];
fmc=['bp26_wspd_N_c.n_max_sample'];
fbc=['bp26_wspd_N_c.mean'];
flc=['bp26_wspd_N_c'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(tmp,tmp,-.1,.1,.025,-1,1,['WSPD northward @MAi@ T cc r=',num2str(r)],...
	['~/Documents/OSU/figures/air-sea/comps/',flc])

g=abs(max(bp26_wspd_N_cc.mean(:))/min(bp26_wspd_N_cc.mean(:)))
r=round(g*100)/100;
fnc=['bp26_wspd_N_cc.N'];
fmc=['bp26_wspd_N_cc.n_max_sample'];
fbc=['bp26_wspd_N_cc.mean'];
flc=['bp26_wspd_N_cc'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(tmp,tmp,-.1,.1,.025,-1,1,['WSPD northward @MAi@ T ccw r=',num2str(r)],...
	['~/Documents/OSU/figures/air-sea/comps/',flc])
	
g=abs(max(bp26_wspd_S_c.mean(:))/min(bp26_wspd_S_c.mean(:)))
r=round(g*100)/100;	
fnc=['bp26_wspd_S_c.N'];
fmc=['bp26_wspd_S_c.n_max_sample'];
fbc=['bp26_wspd_S_c.mean'];
flc=['bp26_wspd_S_c'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(tmp,tmp,-.1,.1,.025,-1,1,['WSPD southward @MAi@ T cc r=',num2str(r)],...
	['~/Documents/OSU/figures/air-sea/comps/',flc])

g=abs(min(bp26_wspd_S_cc.mean(:))/max(bp26_wspd_S_cc.mean(:)))
r=round(g*100)/100;
fnc=['bp26_wspd_S_cc.N'];
fmc=['bp26_wspd_S_cc.n_max_sample'];
fbc=['bp26_wspd_S_cc.mean'];
flc=['bp26_wspd_S_cc'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(tmp,tmp,-.1,.1,.025,-1,1,['WSPD southward @MAi@ T ccw r=',num2str(r)],...
	['~/Documents/OSU/figures/air-sea/comps/',flc])
	
g=abs(min(bp26_sst_N_c.mean(:))/max(bp26_sst_N_c.mean(:)))
r=round(g*100)/100;
fnc=['bp26_sst_N_c.N'];
fmc=['bp26_sst_N_c.n_max_sample'];
fbc=['bp26_sst_N_c.mean'];
flc=['bp26_sst_N_c'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(tmp,tmp,-.3,.3,.05,-1,1,['SST northward @MAi@ T cc r=',num2str(r)],...
	['~/Documents/OSU/figures/air-sea/comps/',flc])

g=abs(max(bp26_sst_N_cc.mean(:))/min(bp26_sst_N_cc.mean(:)))
r=round(g*100)/100;
fnc=['bp26_sst_N_cc.N'];
fmc=['bp26_sst_N_cc.n_max_sample'];
fbc=['bp26_sst_N_cc.mean'];
flc=['bp26_sst_N_cc'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(tmp,tmp,-.3,.3,.05,-1,1,['SST northward @MAi@ T ccw r=',num2str(r)],...
	['~/Documents/OSU/figures/air-sea/comps/',flc])
	
g=abs(max(bp26_sst_S_c.mean(:))/min(bp26_sst_S_c.mean(:)))
r=round(g*100)/100;	
fnc=['bp26_sst_S_c.N'];
fmc=['bp26_sst_S_c.n_max_sample'];
fbc=['bp26_sst_S_c.mean'];
flc=['bp26_sst_S_c'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(tmp,tmp,-.3,.3,.05,-1,1,['SST southward @MAi@ T cc r=',num2str(r)],...
	['~/Documents/OSU/figures/air-sea/comps/',flc])

g=abs(min(bp26_sst_S_cc.mean(:))/max(bp26_sst_S_cc.mean(:)))
r=round(g*100)/100;
fnc=['bp26_sst_S_cc.N'];
fmc=['bp26_sst_S_cc.n_max_sample'];
fbc=['bp26_sst_S_cc.mean'];
flc=['bp26_sst_S_cc'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(tmp,tmp,-.3,.3,.05,-1,1,['SST southward @MAi@ T ccw r=',num2str(r)],...
	['~/Documents/OSU/figures/air-sea/comps/',flc])
	
	%}