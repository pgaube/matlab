
clear all

load /matlab/data/eddy/V5/global_tracks_v5_12_weeks

f1=find(abs(y)>=15 & abs(y)<=45 & track_jday>=2452459);
	id=id(f1);
	eid=eid(f1);
	x=ext_x(f1);
	y=ext_y(f1);
	amp=amp(f1);
	axial_speed=axial_speed(f1);
	scale=scale(f1);
	track_jday=track_jday(f1);
	cyc=cyc(f1);
	k=k(f1);
save tracks/midlat_tracks k cyc track_jday scale axial_speed amp y x eid id	


% %
load tracks/midlat_tracks	
ii=find(track_jday>=2452459 & track_jday<=2454489);
x=x(ii);
y=y(ii);
k=k(ii);
id=id(ii);
track_jday=track_jday(ii);
cyc=cyc(ii);
scale=scale(ii);
% 
[rot_sim_wek_a,rot_sim_wek_c]=comps(x,y,cyc,k,id,track_jday,scale,'sim_wek','~/data/QuickScat/new_mat/QSCAT_30_25km_','w');
save -append new_wind_midlat_rot_comps rot_sim_*
[sim_wek_a,sim_wek_c]=comps(x,y,cyc,k,id,track_jday,scale,'sim_wek','~/data/QuickScat/new_mat/QSCAT_30_25km_','n');
save -append new_wind_midlat_rot_comps sim_*

[wek_a,wek_c]=comps(x,y,cyc,k,id,track_jday,scale,'wek','~/data/QuickScat/new_mat/QSCAT_30_25km_','n');
save -append new_wind_midlat_rot_comps wek_c wek_a
[rot_w_ek_a,rot_w_ek_c]=comps(x,y,cyc,k,id,track_jday,scale,'wek','~/data/QuickScat/new_mat/QSCAT_30_25km_','w');
save -append new_wind_midlat_rot_comps rot_*

[rot_w_ek_crlg_a,rot_w_ek_crlg_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp_wek_crlg_week','~/data/QuickScat/mat/QSCAT_30_25km_','w');
save -append new_wind_midlat_rot_comps rot_*

[wek_crlg_a,wek_crlg_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp_wek_crlg_week','~/data/QuickScat/mat/QSCAT_30_25km_','n');
save -append new_wind_midlat_rot_comps wek_*

return

return
[rot_t_ek_a,rot_t_ek_c]=comps_dir_grad(x,y,cyc,id,track_jday,scale,'w_ek','~/data/QuickScat/mat/QSCAT_30_25km_','t');
save -append new_wind_midlat_rot_comps rot_*
[rot_t_ek_crlg_a,rot_t_ek_crlg_c]=comps_dir_grad(x,y,cyc,id,track_jday,scale,'hp_wek_crlg_week','~/data/QuickScat/mat/QSCAT_30_25km_','t');
save -append new_wind_midlat_rot_comps rot_*
[wek_crlg_a,wek_crlg_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp_wek_crlg_week','~/data/QuickScat/mat/QSCAT_30_25km_','n');
save -append new_wind_midlat_rot_comps wek_*
[rot_w_ek_crlg_a,rot_w_ek_crlg_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp_wek_crlg_week','~/data/QuickScat/mat/QSCAT_30_25km_','w');
save -append new_wind_midlat_rot_comps rot_*
[rot_w_ek_a,rot_w_ek_c]=comps(x,y,cyc,k,id,track_jday,scale,'w_ek','~/data/QuickScat/mat/QSCAT_30_25km_','w');
save -append new_wind_midlat_rot_comps rot_*
[u_a,u_c]=comps(x,y,cyc,k,id,track_jday,scale,'u_week','/matlab/data/QuickScat/mat/QSCAT_30_25km_','n');
save -append new_wind_midlat_rot_comps u_*
[v_a,v_c]=comps(x,y,cyc,k,id,track_jday,scale,'v_week','/matlab/data/QuickScat/mat/QSCAT_30_25km_','n');
save -append new_wind_midlat_rot_comps u_*
[rot_w_ek_sst_a,rot_w_ek_sst_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp_wek_sst_week_dtdn','~/data/QuickScat/mat/QSCAT_30_25km_','w');


[rot_t_ek_sst_a,rot_t_ek_sst_c]=comps_dir_grad(x,y,cyc,id,track_jday,scale,'hp_wek_sst_week_dtdn','~/data/QuickScat/mat/QSCAT_30_25km_','t');
save -append new_wind_midlat_rot_comps rot_*
[rot_t_ek_a,rot_t_ek_c]=comps_dir_grad(x,y,cyc,id,track_jday,scale,'w_ek','~/data/QuickScat/mat/QSCAT_30_25km_','t');
save -append new_wind_midlat_rot_comps rot_*
[rot_t_u_a,rot_t_u_c]=comps_dir_grad(x,y,cyc,id,track_jday,scale,'u_week','/matlab/data/QuickScat/mat/QSCAT_30_25km_','t');
save -append new_wind_midlat_rot_comps rot_*
[rot_t_v_a,rot_t_v_c]=comps_dir_grad(x,y,cyc,id,track_jday,scale,'v_week','/matlab/data/QuickScat/mat/QSCAT_30_25km_','t');
save -append new_wind_midlat_rot_comps rot_*


%save -append new_midlat_comps
save -append new_wind_midlat_rot_comps
% 
% 
% return
% %}
load new_wind_midlat_rot_comps
%	

pcomps_raw(sim_wek_c.median,sim_wek_c.median,[-4 4],-100,.5,100,['Simulated Ekman Pumping cyclones N=',num2str(sim_wek_c.n_max_sample)],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/sim_w_ek_c'])

pcomps_raw(sim_wek_a.median,sim_wek_a.median,[-4 4],-100,.5,100,['Simulated Ekman Pumping anticyclones N=',num2str(sim_wek_a.n_max_sample)],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/sim_w_ek_a'])

pcomps_raw(rot_sim_wek_c.median,rot_sim_wek_c.median,[-4 4],-100,.5,100,['Simulated Ekman Pumping cyclones N=',num2str(sim_wek_c.n_max_sample)],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/rot_sim_w_ek_c'])

pcomps_raw(rot_sim_wek_a.median,rot_sim_wek_a.median,[-4 4],-100,.5,100,['Simulated Ekman Pumping anticyclones N=',num2str(sim_wek_a.n_max_sample)],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/rot_sim_w_ek_a'])

pcomps_raw(wek_crlg_c.median,wek_crlg_c.median,[-4 4],-100,.5,100,['AVISO cyclones N=',num2str(wek_crlg_c.n_max_sample)],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/w_ek_crlg_c'])

pcomps_raw(wek_crlg_a.median,wek_crlg_a.median,[-4 4],-100,.5,100,['AVISO anticyclones N=',num2str(wek_crlg_a.n_max_sample)],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/w_ek_crlg_a'])

pcomps_raw(rot_w_ek_crlg_c.median,rot_w_ek_crlg_c.median,[-4 4],-100,.5,100,['AVISO cyclones N=',num2str(rot_w_ek_crlg_c.n_max_sample)],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/rot_w_ek_crlg_c'])

pcomps_raw(rot_w_ek_crlg_a.median,rot_w_ek_crlg_a.median,[-4 4],-100,.5,100,['AVISO anticyclones N=',num2str(rot_w_ek_crlg_a.n_max_sample)],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/rot_w_ek_crlg_a'])

pcomps_raw(wek_c.median,wek_c.median,[-.04 .04],-1,.005,1,['QuikSCAT cyclones N=',num2str(wek_c.n_max_sample)],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/w_ek_c'])

pcomps_raw(wek_a.median,wek_a.median,[-.04 .04],-1,.005,1,['QuikSCAT anticyclones N=',num2str(wek_a.n_max_sample)],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/w_ek_a'])

pcomps_raw(rot_w_ek_c.median,rot_w_ek_c.median,[-.04 .04],-1,.005,1,['QuikSCAT cyclones N=',num2str(rot_w_ek_c.n_max_sample)],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/rot_w_ek_c'])

pcomps_raw(rot_w_ek_a.median,rot_w_ek_a.median,[-.04 .04],-1,.005,1,['QuikSCAT anticyclones N=',num2str(rot_w_ek_a.n_max_sample)],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/rot_w_ek_a'])
return
    
    
fnc=['rot_w_ek_sst_a.N'];
fmc=['rot_w_ek_sst_a.n_max_sample'];
fbc=['rot_w_ek_sst_a.median'];
flc=['rot_w_ek_sst_a'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2_bwr(tmp./100,tmp./100,-.01,.01,.001,-1,1,['SST anticyclones N = ',num2str(rot_w_ek_sst_a.n_max_sample)],...
	['~/Documents/OSU/figures/air-sea/comps/',flc])
	
fmc=['rot_t_ek_crlg_c.S_n_max_sample'];
fbc=['rot_t_ek_crlg_c.S_median'];
flc=['rot_t_ek_crlg_c_S'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2_bwr(tmp./100,tmp./100,-.04,.04,.005,-1,1,['AVISO cyclones N = ',num2str(rot_t_ek_crlg_c.S_n_max_sample)],...
	['~/Documents/OSU/figures/air-sea/comps/',flc])

fmc=['rot_t_ek_crlg_a.S_n_max_sample'];
fbc=['rot_t_ek_crlg_a.S_median'];
flc=['rot_t_ek_crlg_a_S'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2_bwr(tmp./100,tmp./100,-.04,.04,.005,-1,1,['AVISO anticyclones N = ',num2str(rot_t_ek_crlg_a.S_n_max_sample)],...
	['~/Documents/OSU/figures/air-sea/comps/',flc])
	

fmc=['rot_t_ek_crlg_c.N_n_max_sample'];
fbc=['rot_t_ek_crlg_c.N_median'];
flc=['rot_t_ek_crlg_c_N'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2_bwr(tmp./100,tmp./100,-.04,.04,.005,-1,1,['AVISO cyclones N = ',num2str(rot_t_ek_crlg_c.N_n_max_sample)],...
	['~/Documents/OSU/figures/air-sea/comps/',flc])

fmc=['rot_t_ek_crlg_a.N_n_max_sample'];
fbc=['rot_t_ek_crlg_a.N_median'];
flc=['rot_t_ek_crlg_a_N'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2_bwr(tmp./100,tmp./100,-.04,.04,.005,-1,1,['AVISO anticyclones N = ',num2str(rot_t_ek_crlg_a.N_n_max_sample)],...
	['~/Documents/OSU/figures/air-sea/comps/',flc])
	
fmc=['rot_t_ek_c.S_n_max_sample'];
fbc=['rot_t_ek_c.S_median'];
flc=['rot_t_ek_c_S'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2_bwr(tmp,tmp,-.04,.04,.005,-1,1,['QSCAT cyclones N = ',num2str(rot_t_ek_c.S_n_max_sample)],...
	['~/Documents/OSU/figures/air-sea/comps/',flc])

fmc=['rot_t_ek_a.S_n_max_sample'];
fbc=['rot_t_ek_a.S_median'];
flc=['rot_t_ek_a_S'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2_bwr(tmp,tmp,-.04,.04,.005,-1,1,['QSCAT anticyclones N = ',num2str(rot_t_ek_a.S_n_max_sample)],...
	['~/Documents/OSU/figures/air-sea/comps/',flc])
	
fmc=['rot_t_ek_c.N_n_max_sample'];
fbc=['rot_t_ek_c.N_median'];
flc=['rot_t_ek_c_N'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2_bwr(tmp,tmp,-.04,.04,.005,-1,1,['QSCAT cyclones N = ',num2str(rot_t_ek_c.N_n_max_sample)],...
	['~/Documents/OSU/figures/air-sea/comps/',flc])

fmc=['rot_t_ek_a.N_n_max_sample'];
fbc=['rot_t_ek_a.N_median'];
flc=['rot_t_ek_a_N'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2_bwr(tmp,tmp,-.04,.04,.005,-1,1,['QSCAT anticyclones N = ',num2str(rot_t_ek_a.N_n_max_sample)],...
	['~/Documents/OSU/figures/air-sea/comps/',flc])

fnc=['wek_crlg_c.N'];
fmc=['wek_crlg_c.n_max_sample'];
fbc=['wek_crlg_c.median'];
flc=['wek_crlg_c'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2_bwr(tmp./100,tmp./100,-.04,.04,.005,-1,1,['AVISO cyclones N = ',num2str(wek_crlg_c.n_max_sample)],...
	['~/Documents/OSU/figures/air-sea/comps/',flc])

fnc=['wek_crlg_a.N'];
fmc=['wek_crlg_a.n_max_sample'];
fbc=['wek_crlg_a.median'];
flc=['wek_crlg_a'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2_bwr(tmp./100,tmp./100,-.04,.04,.005,-1,1,['AVISO anticyclones N = ',num2str(wek_crlg_a.n_max_sample)],...
	['~/Documents/OSU/figures/air-sea/comps/',flc])
	
fnc=['wek_c.N'];
fmc=['wek_c.n_max_sample'];
fbc=['wek_c.median'];
flc=['wek_c'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2_bwr(tmp,tmp,-.04,.04,.005,-1,1,['QSCAT cyclones N = ',num2str(wek_c.n_max_sample)],...
	['~/Documents/OSU/figures/air-sea/comps/',flc])

fnc=['wek_a.N'];
fmc=['wek_a.n_max_sample'];
fbc=['wek_a.median'];
flc=['wek_a'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2_bwr(tmp,tmp,-.04,.04,.005,-1,1,['QSCAT anticyclones N = ',num2str(wek_a.n_max_sample)],...
	['~/Documents/OSU/figures/air-sea/comps/',flc])
	
	
fnc=['rot_w_ek_crlg_c.N'];
fmc=['rot_w_ek_crlg_c.n_max_sample'];
fbc=['rot_w_ek_crlg_c.median'];
flc=['rot_w_ek_crlg_c'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2_bwr(tmp./100,tmp./100,-.04,.04,.005,-1,1,['AVISO cyclones N = ',num2str(rot_w_ek_crlg_c.n_max_sample)],...
	['~/Documents/OSU/figures/air-sea/comps/',flc])

fnc=['rot_w_ek_crlg_a.N'];
fmc=['rot_w_ek_crlg_a.n_max_sample'];
fbc=['rot_w_ek_crlg_a.median'];
flc=['rot_w_ek_crlg_a'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2_bwr(tmp./100,tmp./100,-.04,.04,.005,-1,1,['AVISO anticyclones N = ',num2str(rot_w_ek_crlg_a.n_max_sample)],...
	['~/Documents/OSU/figures/air-sea/comps/',flc])

fnc=['rot_w_ek_c.N'];
fmc=['rot_w_ek_c.n_max_sample'];
fbc=['rot_w_ek_c.median'];
flc=['rot_w_ek_c'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2_bwr(tmp,tmp,-.04,.04,.005,-1,1,['QSCAT cyclones N = ',num2str(rot_w_ek_c.n_max_sample)],...
	['~/Documents/OSU/figures/air-sea/comps/',flc])

fnc=['rot_w_ek_a.N'];
fmc=['rot_w_ek_a.n_max_sample'];
fbc=['rot_w_ek_a.median'];
flc=['rot_w_ek_a'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2_bwr(tmp,tmp,-.04,.04,.005,-1,1,['QSCAT anticyclones N = ',num2str(rot_w_ek_a.n_max_sample)],...
	['~/Documents/OSU/figures/air-sea/comps/',flc])


