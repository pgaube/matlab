clear all

%{
load /matlab/matlab/air-sea/tracks/midlat_tracks	
%load /matlab/matlab/regions/tracks/tight/lw_tracks.mat
%{
slope_crls = comps_slope(x,y,track_jday,scale,'hp66_crlg','/matlab/data/eddy/V5/mat/AVISO_25_W_','bp26_crl','/matlab/data/QuickScat/mat/QSCAT_30_25km_');
slope_off = comps_slope(x,y,track_jday,scale,'hp66_crlg','/matlab/data/eddy/V5/mat/AVISO_25_W_','off_crlg','/matlab/data/rand/RAND_W_');
%}

%
[bp26_crl_cc,bp26_crl_c]=comps_dir(x,y,cyc,id,track_jday,scale,'bp26_crl','/matlab/data/QuickScat/mat/QSCAT_30_25km_','n');
[bp26_crlg_cc,bp26_crlg_c]=comps_dir(x,y,cyc,id,track_jday,scale,'hp66_crlg','/matlab/data/eddy/V5/mat/AVISO_25_W_','n');
[off_crlg_cc,off_crlg_c]=comps_dir(x,y,cyc,id,track_jday,scale,'off_crlg','/matlab/data/rand/RAND_W_','n');
%
save -append crl_comps
return
%}
load crl_comps
%{
fnc=['bp26_crlg_c.N'];
fmc=['bp26_crlg_c.n_max_sample'];
fbc=['bp26_crlg_c.mean'];
flc=['bp26_crlg_c'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp2 = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(-1e6*tmp2,-1e6*tmp2,-6,6,.6,-10,10,['clockwise -@MAiD@ u_g^'],...
	['~/Documents/OSU/figures/air-sea/comps/',flc])
	
fnc=['bp26_crl_c.N'];
fmc=['bp26_crl_c.n_max_sample'];
fbc=['bp26_crl_c.mean'];
flc=['bp26_crl_c'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(1e6*tmp,1e6*tmp,-2,2,.2,-10,10,['clockwise @MAiD@ u_w^'],...
	['~/Documents/OSU/figures/air-sea/comps/',flc])
	
fnc=['off_crlg_c.N'];
fmc=['off_crlg_c.n_max_sample'];
fbc=['off_crlg_c.mean'];
flc=['off_crlg_c'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(-1e6*tmp,-1e6*tmp,-2,2,.2,-10,10,['clockwise @MAiD@ u_sim^'],...
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
	
fnc=['off_crlg_cc.N'];
fmc=['off_crlg_cc.n_max_sample'];
fbc=['off_crlg_cc.mean'];
flc=['off_crlg_cc'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(-1e6*tmp,-1e6*tmp,-2,2,.2,-10,10,['counterclockwise @MAiD@ u_sim^'],...
	['~/Documents/OSU/figures/air-sea/comps/',flc])
%}
xx=-interp2(slope_crls.beta_ols,2);
cplot_comps_cont_pos_scale_2_2(xx,xx,.3,.8,.05,0,1,['@SGa@ _ols^ of @MAiD@ u_w^'],...
	['~/Documents/OSU/figures/air-sea/comps/beta_ols_clrs'])
xx=interp2(slope_off.beta_ols,2);
cplot_comps_cont_pos_scale_2_2(xx,xx,.3,2,.05,0,1,['@SGa@ _ols^ of @MAiD@ u_sim^'],...
	['~/Documents/OSU/figures/air-sea/comps/beta_ols_sim'])