
clear all

%{
load tracks/midlat_tracks	

%{
[w_ek_zonal_a,w_ek_zonal_c]=angle_comps(id,track_jday,180-5,180+5,-5,5,'nrhp_wek_crlg_week_sample');
[w_ek_merid_a,w_ek_merid_c]=angle_comps(id,track_jday,90,90+5,90-5,90,'nrhp_wek_crlg_week_sample');
[w_ek_oblq_a,w_ek_oblq_c]=angle_comps(id,track_jday,45-5,45+5,135-5,135+5,'nrhp_wek_crlg_week_sample');
%}

[w_ek_zonal_a,w_ek_zonal_c]=angle_comps(id,track_jday,180-5,180+5,-5,5,'nrw_ek_sample');
[w_ek_merid_a,w_ek_merid_c]=angle_comps(id,track_jday,90-5,90+5,90-5,90+5,'nrw_ek_sample');
[w_ek_oblq_a,w_ek_oblq_c]=angle_comps(id,track_jday,45-5,45+5,135-5,135+5,'nrw_ek_sample');

[w_ek_crlg_zonal_a,w_ek_crlg_zonal_c]=angle_comps(id,track_jday,180-5,180+5,-5,5,'nrhp_wek_crlg_week_sample');
[w_ek_crlg_merid_a,w_ek_crlg_merid_c]=angle_comps(id,track_jday,90-5,90+5,90-5,90+5,'nrhp_wek_crlg_week_sample');
[w_ek_crlg_oblq_a,w_ek_crlg_oblq_c]=angle_comps(id,track_jday,45-5,45+5,135-5,135+5,'nrhp_wek_crlg_week_sample');
%
save -append midlat_wek_wind_dir
return
%}
load midlat_wek_wind_dir

fnc=['w_ek_crlg_zonal_c.N'];
fmc=['w_ek_crlg_zonal_c.n_max_sample'];
fbc=['w_ek_crlg_zonal_c.median'];
flc=['w_ek_crlg_zonal_c'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2_bwr(tmp./100,tmp./100,-.03,.03,.005,-1,1,['W_E^ anticyclones AVISO N = ',num2str(w_ek_crlg_zonal_c.n_max_sample)],...
	['~/Documents/OSU/figures/air-sea/comps/',flc])

fnc=['w_ek_crlg_zonal_a.N'];
fmc=['w_ek_crlg_zonal_a.n_max_sample'];
fbc=['w_ek_crlg_zonal_a.median'];
flc=['w_ek_crlg_zonal_a'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2_bwr(tmp./100,tmp./100,-.03,.03,.005,-1,1,['W_E^ cyclones AVISO N = ',num2str(w_ek_crlg_zonal_a.n_max_sample)],...
	['~/Documents/OSU/figures/air-sea/comps/',flc])

fnc=['w_ek_crlg_merid_c.N'];
fmc=['w_ek_crlg_merid_c.n_max_sample'];
fbc=['w_ek_crlg_merid_c.median'];
flc=['w_ek_crlg_merid_c'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2_bwr(tmp./100,tmp./100,-.03,.03,.005,-1,1,['W_E^ anticyclones AVISO N = ',num2str(w_ek_crlg_merid_c.n_max_sample)],...
	['~/Documents/OSU/figures/air-sea/comps/',flc])

fnc=['w_ek_crlg_merid_a.N'];
fmc=['w_ek_crlg_merid_a.n_max_sample'];
fbc=['w_ek_crlg_merid_a.median'];
flc=['w_ek_crlg_merid_a'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2_bwr(tmp./100,tmp./100,-.03,.03,.005,-1,1,['W_E^ cyclones AVISO N = ',num2str(w_ek_crlg_merid_a.n_max_sample)],...
	['~/Documents/OSU/figures/air-sea/comps/',flc])
	
fnc=['w_ek_crlg_oblq_c.N'];
fmc=['w_ek_crlg_oblq_c.n_max_sample'];
fbc=['w_ek_crlg_oblq_c.median'];
flc=['w_ek_crlg_oblq_c'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2_bwr(tmp./100,tmp./100,-.03,.03,.005,-1,1,['W_E^ anticyclones AVISO N = ',num2str(w_ek_crlg_oblq_c.n_max_sample)],...
	['~/Documents/OSU/figures/air-sea/comps/',flc])

fnc=['w_ek_crlg_oblq_a.N'];
fmc=['w_ek_crlg_oblq_a.n_max_sample'];
fbc=['w_ek_crlg_oblq_a.median'];
flc=['w_ek_crlg_oblq_a'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2_bwr(tmp./100,tmp./100,-.03,.03,.005,-1,1,['W_E^ cyclones AVISO N = ',num2str(w_ek_crlg_oblq_a.n_max_sample)],...
	['~/Documents/OSU/figures/air-sea/comps/',flc])
