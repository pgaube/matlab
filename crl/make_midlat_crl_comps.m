
clear all
%
load /matlab/matlab/air-sea/tracks/midlat_tracks	
[bp26_crl_c,bp26_crl_cc]=ccomps(x,y,cyc,id,track_jday,scale,'bp26_crl','/matlab/data/QuickScat/mat/QSCAT_30_25km_','n');
[bp26_crlg_c,bp26_crlg_cc]=comps(x,y,cyc,id,track_jday,scale,'hp66_crl','/matlab/data/eddy/V5/mat/AVISO_25_W_','n');

save  midlat_crl_comps


return
%
load midlat_crl_comps

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
%}
clear
xi=[-5:.125:5];
r=find(abs(xi)<=2); 
load nrbp26_crlg_sample_nrbp26_crl_sample_coupcoef_reg_out
xx=interp2(beta_ols(r,r));
cplot_comps_cont_pos_scale_2_2(xx,xx,.4,1,.2,0,10,['@SGa@ _ols'],...
	['~/Documents/OSU/figures/air-sea/comps/beta_ols'])