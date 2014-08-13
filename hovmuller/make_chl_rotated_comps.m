
clear all
%{
load mgrad_combo_tracks
startjd=2451395;
endjd=2454461;
f1=find(track_jday>=startjd & track_jday<=endjd);
id=id(f1);
y=y(f1);
track_jday=track_jday(f1);

ni=find(y>0);
si=find(y<0);
%
[NH_raw_chl_N_a,NH_raw_chl_N_c]=dir_clock_comps(id(ni),track_jday(ni),y(ni),'nrraw_bp26_chl_sample','N','g');
[NH_raw_chl_S_a,NH_raw_chl_S_c]=dir_clock_comps(id(ni),track_jday(ni),y(ni),'nrraw_bp26_chl_sample','S','g');
[NH_log_chl_N_a,NH_log_chl_N_c]=dir_clock_comps(id(ni),track_jday(ni),y(ni),'nrbp26_chl_sample','N','g');
[NH_log_chl_S_a,NH_log_chl_S_c]=dir_clock_comps(id(ni),track_jday(ni),y(ni),'nrbp26_chl_sample','S','g');

[SH_raw_chl_N_c,SH_raw_chl_N_a]=dir_clock_comps(id(si),track_jday(si),y(si),'nrraw_bp26_chl_sample','N','g');
[SH_raw_chl_S_c,SH_raw_chl_S_a]=dir_clock_comps(id(si),track_jday(si),y(si),'nrraw_bp26_chl_sample','S','g');
[SH_log_chl_N_c,SH_log_chl_N_a]=dir_clock_comps(id(si),track_jday(si),y(si),'nrbp26_chl_sample','N','g');
[SH_log_chl_S_c,SH_log_chl_S_a]=dir_clock_comps(id(si),track_jday(si),y(si),'nrbp26_chl_sample','S','g');
%


[log_chl_N_c,log_chl_N_cc]=dir_clock_comps(id,track_jday,y,'nrbp26_chl_sample','N','g');
[log_chl_S_c,log_chl_S_cc]=dir_clock_comps(id,track_jday,y,'nrbp26_chl_sample','S','g');
%
[raw_chl_N_c,raw_chl_N_cc]=dir_clock_comps(id,track_jday,y,'nrraw_bp26_chl_sample','N','g');
[raw_chl_S_c,raw_chl_S_cc]=dir_clock_comps(id,track_jday,y,'nrraw_bp26_chl_sample','S','g');
%
save -append chl_rot_comps
return
%}
load chl_rot_comps

%{
fnc=['raw_chl_N_c.N'];
fmc=['raw_chl_N_c.n_max_sample'];
fbc=['raw_chl_N_c.mean'];
flc=['raw_chl_N_c'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(tmp,tmp,-.0021,.0021,.0003,-1,1,['CW N  n=',lab],...
	['~/Documents/OSU/figures/hovmuller/comps/',flc])

fnc=['raw_chl_N_cc.N'];
fmc=['raw_chl_N_cc.n_max_sample'];
fbc=['raw_chl_N_cc.mean'];
flc=['raw_chl_N_cc'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(tmp,tmp,-.0021,.0021,.0003,-1,1,['CC N  n=',lab],...
	['~/Documents/OSU/figures/hovmuller/comps/',flc])
	
fnc=['raw_chl_S_c.N'];
fmc=['raw_chl_S_c.n_max_sample'];
fbc=['raw_chl_S_c.mean'];
flc=['raw_chl_S_c'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(tmp,tmp,-.0021,.0021,.0003,-1,1,['CW S  n=',lab],...
	['~/Documents/OSU/figures/hovmuller/comps/',flc])

fnc=['raw_chl_S_cc.N'];
fmc=['raw_chl_S_cc.n_max_sample'];
fbc=['raw_chl_S_cc.mean'];
flc=['raw_chl_S_cc'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(tmp,tmp,-.0021,.0021,.0003,-1,1,['CC S  n=',lab],...
	['~/Documents/OSU/figures/hovmuller/comps/',flc])
%}
wgrid_grid
cw=find(xi(1,:)<=0.2);
ce=find(xi(1,:)>0.2);

wchl=log_chl_N_c.mean(:,cw);
echl=log_chl_N_c.mean(:,ce);
g=max(abs(wchl(:)))/max(abs(echl(:)))
r=num2str(round(g*100)/100);
fnc=['log_chl_N_c.N'];
fmc=['log_chl_N_c.n_max_sample'];
fbc=['log_chl_N_c.mean'];
flc=['log_chl_N_c'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(tmp,tmp,-.008,.008,.002,-1,1,['r=',r],...
	['~/Documents/OSU/figures/hovmuller/comps/',flc])

wchl=log_chl_N_cc.mean(:,cw);
echl=log_chl_N_cc.mean(:,ce);
g=max(abs(wchl(:)))/max(abs(echl(:)))
r=num2str(round(g*100)/100);
fnc=['log_chl_N_cc.N'];
fmc=['log_chl_N_cc.n_max_sample'];
fbc=['log_chl_N_cc.mean'];
flc=['log_chl_N_cc'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(tmp,tmp,-.008,.008,.002,-1,1,['r=',r],...
	['~/Documents/OSU/figures/hovmuller/comps/',flc])
	
wchl=log_chl_S_c.mean(:,cw);
echl=log_chl_S_c.mean(:,ce);
g=max(abs(wchl(:)))/max(abs(echl(:)))
r=num2str(round(g*100)/100);	
fnc=['log_chl_S_c.N'];
fmc=['log_chl_S_c.n_max_sample'];
fbc=['log_chl_S_c.mean'];
flc=['log_chl_S_c'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(tmp,tmp,-.008,.008,.002,-1,1,['r=',r],...
	['~/Documents/OSU/figures/hovmuller/comps/',flc])

wchl=log_chl_S_cc.mean(:,cw);
echl=log_chl_S_cc.mean(:,ce);
g=max(abs(wchl(:)))/max(abs(echl(:)))
r=num2str(round(g*100)/100);	
fnc=['log_chl_S_cc.N'];
fmc=['log_chl_S_cc.n_max_sample'];
fbc=['log_chl_S_cc.mean'];
flc=['log_chl_S_cc'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(tmp,tmp,-.008,.008,.002,-1,1,['r=',r],...
	['~/Documents/OSU/figures/hovmuller/comps/',flc])

return
fnc=['NH_raw_chl_N_c.N'];
fmc=['NH_raw_chl_N_c.n_max_sample'];
fbc=['NH_raw_chl_N_c.mean'];
flc=['NH_raw_chl_N_c'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(tmp,tmp,-.003,.003,.001,-1,1,['AC NH N  n=',lab],...
	['~/Documents/OSU/figures/hovmuller/comps/',flc])

fnc=['NH_raw_chl_N_cc.N'];
fmc=['NH_raw_chl_N_cc.n_max_sample'];
fbc=['NH_raw_chl_N_cc.mean'];
flc=['NH_raw_chl_N_cc'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(tmp,tmp,-.003,.003,.001,-1,1,['CC NH N  n=',lab],...
	['~/Documents/OSU/figures/hovmuller/comps/',flc])
	
fnc=['NH_raw_chl_S_c.N'];
fmc=['NH_raw_chl_S_c.n_max_sample'];
fbc=['NH_raw_chl_S_c.mean'];
flc=['NH_raw_chl_S_c'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(tmp,tmp,-.003,.003,.001,-1,1,['AC NH S  n=',lab],...
	['~/Documents/OSU/figures/hovmuller/comps/',flc])

fnc=['NH_raw_chl_S_cc.N'];
fmc=['NH_raw_chl_S_cc.n_max_sample'];
fbc=['NH_raw_chl_S_cc.mean'];
flc=['NH_raw_chl_S_cc'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(tmp,tmp,-.003,.003,.001,-1,1,['CC NH S  n=',lab],...
	['~/Documents/OSU/figures/hovmuller/comps/',flc])

fnc=['SH_raw_chl_N_c.N'];
fmc=['SH_raw_chl_N_c.n_max_sample'];
fbc=['SH_raw_chl_N_c.mean'];
flc=['SH_raw_chl_N_c'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(tmp,tmp,-.003,.003,.001,-1,1,['CC SH N  n=',lab],...
	['~/Documents/OSU/figures/hovmuller/comps/',flc])

fnc=['SH_raw_chl_N_cc.N'];
fmc=['SH_raw_chl_N_cc.n_max_sample'];
fbc=['SH_raw_chl_N_cc.mean'];
flc=['SH_raw_chl_N_cc'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(tmp,tmp,-.003,.003,.001,-1,1,['AC SH N  n=',lab],...
	['~/Documents/OSU/figures/hovmuller/comps/',flc])
	
fnc=['SH_raw_chl_S_c.N'];
fmc=['SH_raw_chl_S_c.n_max_sample'];
fbc=['SH_raw_chl_S_c.mean'];
flc=['SH_raw_chl_S_c'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(tmp,tmp,-.003,.003,.001,-1,1,['CC SH S  n=',lab],...
	['~/Documents/OSU/figures/hovmuller/comps/',flc])

fnc=['SH_raw_chl_S_cc.N'];
fmc=['SH_raw_chl_S_cc.n_max_sample'];
fbc=['SH_raw_chl_S_cc.mean'];
flc=['SH_raw_chl_S_cc'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(tmp,tmp,-.003,.003,.001,-1,1,['AC SH S  n=',lab],...
	['~/Documents/OSU/figures/hovmuller/comps/',flc])
	
fnc=['NH_log_chl_N_c.N'];
fmc=['NH_log_chl_N_c.n_max_sample'];
fbc=['NH_log_chl_N_c.mean'];
flc=['NH_log_chl_N_c'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(tmp,tmp,-.008,.008,.002,-1,1,['AC NH N  n=',lab],...
	['~/Documents/OSU/figures/hovmuller/comps/',flc])

fnc=['NH_log_chl_N_cc.N'];
fmc=['NH_log_chl_N_cc.n_max_sample'];
fbc=['NH_log_chl_N_cc.mean'];
flc=['NH_log_chl_N_cc'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(tmp,tmp,-.008,.008,.002,-1,1,['CC NH N  n=',lab],...
	['~/Documents/OSU/figures/hovmuller/comps/',flc])
	
fnc=['NH_log_chl_S_c.N'];
fmc=['NH_log_chl_S_c.n_max_sample'];
fbc=['NH_log_chl_S_c.mean'];
flc=['NH_log_chl_S_c'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(tmp,tmp,-.008,.008,.002,-1,1,['AC NH S  n=',lab],...
	['~/Documents/OSU/figures/hovmuller/comps/',flc])

fnc=['NH_log_chl_S_cc.N'];
fmc=['NH_log_chl_S_cc.n_max_sample'];
fbc=['NH_log_chl_S_cc.mean'];
flc=['NH_log_chl_S_cc'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(tmp,tmp,-.008,.008,.002,-1,1,['CC NH S  n=',lab],...
	['~/Documents/OSU/figures/hovmuller/comps/',flc])

fnc=['SH_log_chl_N_c.N'];
fmc=['SH_log_chl_N_c.n_max_sample'];
fbc=['SH_log_chl_N_c.mean'];
flc=['SH_log_chl_N_c'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(tmp,tmp,-.008,.008,.002,-1,1,['CC SH N  n=',lab],...
	['~/Documents/OSU/figures/hovmuller/comps/',flc])

fnc=['SH_log_chl_N_cc.N'];
fmc=['SH_log_chl_N_cc.n_max_sample'];
fbc=['SH_log_chl_N_cc.mean'];
flc=['SH_log_chl_N_cc'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(tmp,tmp,-.008,.008,.002,-1,1,['AC SH N  n=',lab],...
	['~/Documents/OSU/figures/hovmuller/comps/',flc])
	
fnc=['SH_log_chl_S_c.N'];
fmc=['SH_log_chl_S_c.n_max_sample'];
fbc=['SH_log_chl_S_c.mean'];
flc=['SH_log_chl_S_c'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(tmp,tmp,-.008,.008,.002,-1,1,['CC SH S  n=',lab],...
	['~/Documents/OSU/figures/hovmuller/comps/',flc])

fnc=['SH_log_chl_S_cc.N'];
fmc=['SH_log_chl_S_cc.n_max_sample'];
fbc=['SH_log_chl_S_cc.mean'];
flc=['SH_log_chl_S_cc'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(tmp,tmp,-.008,.008,.002,-1,1,['AC SH S  n=',lab],...
	['~/Documents/OSU/figures/hovmuller/comps/',flc])	