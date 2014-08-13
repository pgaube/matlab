clear all

load mgrad_combo sm_median_mgrad_schl mask
load chelle.pal
load(['/Volumes/matlab/data/SeaWiFS/mat/SCHL_9_21_2450821'],'glon','glat')

load /Volumes/matlab/data/eddy/V4/global_tracks_v4

f1=find(abs(gy)>=15 & abs(gy)<=35 & axial_speed./prop_speed >=1.5);
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


f1=find(y>=-40 & y<=0 & x>=55 & x<=120);
id(f1)=[];
eid(f1)=[];
x(f1)=[];
y(f1)=[];
gx(f1)=[];
gy(f1)=[];
amp(f1)=[];
axial_speed(f1)=[];
efold(f1)=[];
radius(f1)=[];
track_jday(f1)=[];
prop_speed(f1)=[];
k(f1)=[];
i_grid=nan*k;
i_speed=nan*k;
grads=nan*sm_median_mgrad_schl;
i_grads=nan*grads;


grads=sm_median_mgrad_schl.*mask;

ii=find(grads>=.02);
i_grads(ii)=1;
ii=find(grads<=-.02);
i_grads(ii)=-1;
ii=find(grads>-.02 & grads<.02);
i_grads(ii)=0;

for pp=1:length(id)
	[r,c]=imap(gy(pp),gy(pp),gx(pp),gx(pp),glat,glon);
	i_grid(pp)=i_grads(r,c);
	if axial_speed(pp) >= 10.4 & axial_speed(pp) < 14.7
		i_speed(pp)=-1;
	elseif	axial_speed(pp) >= 14.7 & axial_speed(pp) < 21.1
		i_speed(pp)=0;
	elseif	axial_speed(pp) >= 21.1
		i_speed(pp)=1;
	end	
end	


save mgrad_combo_speed_tracks i_speed nneg id eid x y gx gy amp i_grid axial_speed efold radius track_jday prop_speed k i_grads glon glat




iii=[-1 0 1];
for m=1:3
	clearallbut iii m 
	load mgrad_combo_speed_tracks
	
	f1=find(i_grid==iii(m) & i_speed==-1);
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
	
	eval(['save mgrad_combo_slow_' num2str(iii(m)) '_tracks nneg id eid x y amp axial_speed efold radius track_jday prop_speed k'])

	clearallbut iii m 
	load mgrad_combo_speed_tracks
	
	f1=find(i_grid==iii(m) & i_speed==1);
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
	
	eval(['save mgrad_combo_fast_' num2str(iii(m)) '_tracks nneg id eid x y amp axial_speed efold radius track_jday prop_speed k'])
	
	clearallbut iii m 
	load mgrad_combo_speed_tracks
	
	f1=find(i_grid==iii(m) & i_speed==0);
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
	
	eval(['save mgrad_combo_med_' num2str(iii(m)) '_tracks nneg id eid x y amp axial_speed efold radius track_jday prop_speed k'])
end

load mgrad_combo_fast_1_tracks
[north_fast_bp26_chl_c,north_fast_bp26_chl_a]=clock_comps('/Volumes/matlab/matlab/hovmuller/mgrad_combo_fast_1_tracks','nrnbp26_chl_sample','n');
[north_fast_ssh_c,north_fast_ssh_a]=clock_comps('/Volumes/matlab/matlab/hovmuller/mgrad_combo_fast_1_tracks','nrssh_sample','n');
load mgrad_combo_fast_-1_tracks
[south_fast_bp26_chl_c,south_fast_bp26_chl_a]=clock_comps('/Volumes/matlab/matlab/hovmuller/mgrad_combo_fast_-1_tracks','nrnbp26_chl_sample','n');
[south_fast_ssh_c,south_fast_ssh_a]=clock_comps('/Volumes/matlab/matlab/hovmuller/mgrad_combo_fast_-1_tracks','nrssh_sample','n');
load mgrad_combo_slow_1_tracks
[north_slow_bp26_chl_c,north_slow_bp26_chl_a]=clock_comps('/Volumes/matlab/matlab/hovmuller/mgrad_combo_slow_1_tracks','nrnbp26_chl_sample','n');
[north_slow_ssh_c,north_slow_ssh_a]=clock_comps('/Volumes/matlab/matlab/hovmuller/mgrad_combo_slow_1_tracks','nrssh_sample','n');
load mgrad_combo_slow_-1_tracks
[south_slow_bp26_chl_c,south_slow_bp26_chl_a]=clock_comps('/Volumes/matlab/matlab/hovmuller/mgrad_combo_slow_-1_tracks','nrnbp26_chl_sample','n');
[south_slow_ssh_c,south_slow_ssh_a]=clock_comps('/Volumes/matlab/matlab/hovmuller/mgrad_combo_slow_-1_tracks','nrssh_sample','n');
load mgrad_combo_med_1_tracks
[north_med_bp26_chl_c,north_med_bp26_chl_a]=clock_comps('/Volumes/matlab/matlab/hovmuller/mgrad_combo_med_1_tracks','nrnbp26_chl_sample','n');
[north_med_ssh_c,north_med_ssh_a]=clock_comps('/Volumes/matlab/matlab/hovmuller/mgrad_combo_med_1_tracks','nrssh_sample','n');
load mgrad_combo_med_-1_tracks
[south_med_bp26_chl_c,south_med_bp26_chl_a]=clock_comps('/Volumes/matlab/matlab/hovmuller/mgrad_combo_med_-1_tracks','nrnbp26_chl_sample','n');
[south_med_ssh_c,south_med_ssh_a]=clock_comps('/Volumes/matlab/matlab/hovmuller/mgrad_combo_med_-1_tracks','nrssh_sample','n');


save -append mgrad_speed_combo_comps
clear
return
%}


load mgrad_speed_combo_comps
zgrid_grid
[r,c]=imap(-3,3,-3,3,yi,xi);
xi=xi(r,c);
yi=yi(r,c);
dist=sqrt(xi.^2+yi.^2);
dist=interp2(dist,2);
ii=find(dist<=1.5);


fnc=['north_fast_bp26_chl_c.N(r,c)'];
fmc=['north_fast_bp26_chl_c.n_max_sample'];
fbc=['north_fast_bp26_chl_c.median(r,c)'];
flc=['north_fast_bp26_chl_c'];
eval(['lab=num2str(', fmc,');'])
eval(['ttt=interp2(',fnc,',2);'])
mask_min=nan*ttt;
eval(['mask_min((ttt./',fmc,')>=.1)=1;'])
mask_maj=ones(size(ttt));
mask_maj(ii)=1;
eval(['tmp = double(interp2(',fbc,',2).*mask_min);'])
cplot_comps_cont_3_3(tmp,tmp,-.02,.02,.0016,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',flc])
eval(['tmp = double(interp2(',fbc,',2).*mask_maj);'])
cplot_comps_cont_3_3(tmp,tmp,-.02,.02,.0016,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',flc,'_bg'])	

fna=['north_fast_bp26_chl_a.N(r,c)'];
fma=['north_fast_bp26_chl_a.n_max_sample'];
fba=['north_fast_bp26_chl_a.median(r,c)'];
fla=['north_fast_bp26_chl_cc'];
eval(['lab=num2str(', fma,');'])
eval(['ttt=interp2(',fna,',2);'])
mask_min=nan*ttt;
eval(['mask_min((ttt./',fma,')>=.1)=1;'])
mask_maj=ones(size(ttt));
mask_maj(ii)=1;
eval(['tmp = double(interp2(',fba,',2).*mask_min);'])
cplot_comps_cont_3_3(tmp,tmp,-.02,.02,.0016,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',fla])
eval(['tmp = double(interp2(',fba,',2).*mask_maj);'])
cplot_comps_cont_3_3(tmp,tmp,-.02,.02,.0016,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',fla,'_bg'])	
	
fnc=['south_fast_bp26_chl_c.N(r,c)'];
fmc=['south_fast_bp26_chl_c.n_max_sample'];
fbc=['south_fast_bp26_chl_c.median(r,c)'];
flc=['south_fast_bp26_chl_c'];
eval(['lab=num2str(', fmc,');'])
eval(['ttt=interp2(',fnc,',2);'])
mask_min=nan*ttt;
eval(['mask_min((ttt./',fmc,')>=.1)=1;'])
mask_maj=ones(size(ttt));
mask_maj(ii)=1;
eval(['tmp = double(interp2(',fbc,',2).*mask_min);'])
cplot_comps_cont_3_3(tmp,tmp,-.02,.02,.0016,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',flc])
eval(['tmp = double(interp2(',fbc,',2).*mask_maj);'])
cplot_comps_cont_3_3(tmp,tmp,-.02,.02,.0016,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',flc,'_bg'])	

fna=['south_fast_bp26_chl_a.N(r,c)'];
fma=['south_fast_bp26_chl_a.n_max_sample'];
fba=['south_fast_bp26_chl_a.median(r,c)'];
fla=['south_fast_bp26_chl_cc'];
eval(['lab=num2str(', fma,');'])
eval(['ttt=interp2(',fna,',2);'])
mask_min=nan*ttt;
eval(['mask_min((ttt./',fma,')>=.1)=1;'])
mask_maj=ones(size(ttt));
mask_maj(ii)=1;
eval(['tmp = double(interp2(',fba,',2).*mask_min);'])
cplot_comps_cont_3_3(tmp,tmp,-.02,.02,.0016,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',fla])
eval(['tmp = double(interp2(',fba,',2).*mask_maj);'])
cplot_comps_cont_3_3(tmp,tmp,-.02,.02,.0016,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',fla,'_bg'])	


fnc=['north_fast_ssh_c.N(r,c)'];
fmc=['north_fast_ssh_c.n_max_sample'];
fbc=['north_fast_ssh_c.median(r,c)'];
flc=['north_fast_ssh_c'];
eval(['lab=num2str(', fmc,');'])
eval(['ttt=interp2(',fnc,',2);'])
mask_min=nan*ttt;
eval(['mask_min((ttt./',fmc,')>=.1)=1;'])
mask_maj=ones(size(ttt));
mask_maj(ii)=1;
eval(['tmp = double(interp2(',fbc,',2).*mask_min);'])
cplot_comps_cont_3_3(tmp,tmp,-15,15,1,0,50,...
	['~/Documents/OSU/figures/hovmuller/comps/',flc])
eval(['tmp = double(interp2(',fbc,',2).*mask_maj);'])
cplot_comps_cont_3_3(tmp,tmp,-15,15,1,0,50,...
	['~/Documents/OSU/figures/hovmuller/comps/',flc,'_bg'])	

fna=['north_fast_ssh_a.N(r,c)'];
fma=['north_fast_ssh_a.n_max_sample'];
fba=['north_fast_ssh_a.median(r,c)'];
fla=['north_fast_ssh_cc'];
eval(['lab=num2str(', fma,');'])
eval(['ttt=interp2(',fna,',2);'])
mask_min=nan*ttt;
eval(['mask_min((ttt./',fma,')>=.1)=1;'])
mask_maj=ones(size(ttt));
mask_maj(ii)=1;
eval(['tmp = double(interp2(',fba,',2).*mask_min);'])
cplot_comps_cont_3_3(tmp,tmp,-15,15,1,0,50,...
	['~/Documents/OSU/figures/hovmuller/comps/',fla])
eval(['tmp = double(interp2(',fba,',2).*mask_maj);'])
cplot_comps_cont_3_3(tmp,tmp,-15,15,1,0,50,...
	['~/Documents/OSU/figures/hovmuller/comps/',fla,'_bg'])	
		
fnc=['south_fast_ssh_c.N(r,c)'];
fmc=['south_fast_ssh_c.n_max_sample'];
fbc=['south_fast_ssh_c.median(r,c)'];
flc=['south_fast_ssh_c'];
eval(['lab=num2str(', fmc,');'])
eval(['ttt=interp2(',fnc,',2);'])
mask_min=nan*ttt;
eval(['mask_min((ttt./',fmc,')>=.1)=1;'])
mask_maj=ones(size(ttt));
mask_maj(ii)=1;
eval(['tmp = double(interp2(',fbc,',2).*mask_min);'])
cplot_comps_cont_3_3(tmp,tmp,-15,15,1,0,50,...
	['~/Documents/OSU/figures/hovmuller/comps/',flc])
eval(['tmp = double(interp2(',fbc,',2).*mask_maj);'])
cplot_comps_cont_3_3(tmp,tmp,-15,15,1,0,50,...
	['~/Documents/OSU/figures/hovmuller/comps/',flc,'_bg'])	

fna=['south_fast_ssh_a.N(r,c)'];
fma=['south_fast_ssh_a.n_max_sample'];
fba=['south_fast_ssh_a.median(r,c)'];
fla=['south_fast_ssh_cc'];
eval(['lab=num2str(', fma,');'])
eval(['ttt=interp2(',fna,',2);'])
mask_min=nan*ttt;
eval(['mask_min((ttt./',fma,')>=.1)=1;'])
mask_maj=ones(size(ttt));
mask_maj(ii)=1;
eval(['tmp = double(interp2(',fba,',2).*mask_min);'])
cplot_comps_cont_3_3(tmp,tmp,-15,15,1,0,50,...
	['~/Documents/OSU/figures/hovmuller/comps/',fla])
eval(['tmp = double(interp2(',fba,',2).*mask_maj);'])
cplot_comps_cont_3_3(tmp,tmp,-15,15,1,0,50,...
	['~/Documents/OSU/figures/hovmuller/comps/',fla,'_bg'])		
	
fnc=['north_med_bp26_chl_c.N(r,c)'];
fmc=['north_med_bp26_chl_c.n_max_sample'];
fbc=['north_med_bp26_chl_c.median(r,c)'];
flc=['north_med_bp26_chl_c'];
eval(['lab=num2str(', fmc,');'])
eval(['ttt=interp2(',fnc,',2);'])
mask_min=nan*ttt;
eval(['mask_min((ttt./',fmc,')>=.1)=1;'])
mask_maj=ones(size(ttt));
mask_maj(ii)=1;
eval(['tmp = double(interp2(',fbc,',2).*mask_min);'])
cplot_comps_cont_3_3(tmp,tmp,-.02,.02,.0016,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',flc])
eval(['tmp = double(interp2(',fbc,',2).*mask_maj);'])
cplot_comps_cont_3_3(tmp,tmp,-.02,.02,.0016,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',flc,'_bg'])	

fna=['north_med_bp26_chl_a.N(r,c)'];
fma=['north_med_bp26_chl_a.n_max_sample'];
fba=['north_med_bp26_chl_a.median(r,c)'];
fla=['north_med_bp26_chl_cc'];
eval(['lab=num2str(', fma,');'])
eval(['ttt=interp2(',fna,',2);'])
mask_min=nan*ttt;
eval(['mask_min((ttt./',fma,')>=.1)=1;'])
mask_maj=ones(size(ttt));
mask_maj(ii)=1;
eval(['tmp = double(interp2(',fba,',2).*mask_min);'])
cplot_comps_cont_3_3(tmp,tmp,-.02,.02,.0016,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',fla])
eval(['tmp = double(interp2(',fba,',2).*mask_maj);'])
cplot_comps_cont_3_3(tmp,tmp,-.02,.02,.0016,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',fla,'_bg'])	
	
fnc=['south_med_bp26_chl_c.N(r,c)'];
fmc=['south_med_bp26_chl_c.n_max_sample'];
fbc=['south_med_bp26_chl_c.median(r,c)'];
flc=['south_med_bp26_chl_c'];
eval(['lab=num2str(', fmc,');'])
eval(['ttt=interp2(',fnc,',2);'])
mask_min=nan*ttt;
eval(['mask_min((ttt./',fmc,')>=.1)=1;'])
mask_maj=ones(size(ttt));
mask_maj(ii)=1;
eval(['tmp = double(interp2(',fbc,',2).*mask_min);'])
cplot_comps_cont_3_3(tmp,tmp,-.02,.02,.0016,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',flc])
eval(['tmp = double(interp2(',fbc,',2).*mask_maj);'])
cplot_comps_cont_3_3(tmp,tmp,-.02,.02,.0016,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',flc,'_bg'])	

fna=['south_med_bp26_chl_a.N(r,c)'];
fma=['south_med_bp26_chl_a.n_max_sample'];
fba=['south_med_bp26_chl_a.median(r,c)'];
fla=['south_med_bp26_chl_cc'];
eval(['lab=num2str(', fma,');'])
eval(['ttt=interp2(',fna,',2);'])
mask_min=nan*ttt;
eval(['mask_min((ttt./',fma,')>=.1)=1;'])
mask_maj=ones(size(ttt));
mask_maj(ii)=1;
eval(['tmp = double(interp2(',fba,',2).*mask_min);'])
cplot_comps_cont_3_3(tmp,tmp,-.02,.02,.0016,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',fla])
eval(['tmp = double(interp2(',fba,',2).*mask_maj);'])
cplot_comps_cont_3_3(tmp,tmp,-.02,.02,.0016,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',fla,'_bg'])	


fnc=['north_med_ssh_c.N(r,c)'];
fmc=['north_med_ssh_c.n_max_sample'];
fbc=['north_med_ssh_c.median(r,c)'];
flc=['north_med_ssh_c'];
eval(['lab=num2str(', fmc,');'])
eval(['ttt=interp2(',fnc,',2);'])
mask_min=nan*ttt;
eval(['mask_min((ttt./',fmc,')>=.1)=1;'])
mask_maj=ones(size(ttt));
mask_maj(ii)=1;
eval(['tmp = double(interp2(',fbc,',2).*mask_min);'])
cplot_comps_cont_3_3(tmp,tmp,-15,15,1,0,50,...
	['~/Documents/OSU/figures/hovmuller/comps/',flc])
eval(['tmp = double(interp2(',fbc,',2).*mask_maj);'])
cplot_comps_cont_3_3(tmp,tmp,-15,15,1,0,50,...
	['~/Documents/OSU/figures/hovmuller/comps/',flc,'_bg'])	

fna=['north_med_ssh_a.N(r,c)'];
fma=['north_med_ssh_a.n_max_sample'];
fba=['north_med_ssh_a.median(r,c)'];
fla=['north_med_ssh_cc'];
eval(['lab=num2str(', fma,');'])
eval(['ttt=interp2(',fna,',2);'])
mask_min=nan*ttt;
eval(['mask_min((ttt./',fma,')>=.1)=1;'])
mask_maj=ones(size(ttt));
mask_maj(ii)=1;
eval(['tmp = double(interp2(',fba,',2).*mask_min);'])
cplot_comps_cont_3_3(tmp,tmp,-15,15,1,0,50,...
	['~/Documents/OSU/figures/hovmuller/comps/',fla])
eval(['tmp = double(interp2(',fba,',2).*mask_maj);'])
cplot_comps_cont_3_3(tmp,tmp,-15,15,1,0,50,...
	['~/Documents/OSU/figures/hovmuller/comps/',fla,'_bg'])	
		
fnc=['south_med_ssh_c.N(r,c)'];
fmc=['south_med_ssh_c.n_max_sample'];
fbc=['south_med_ssh_c.median(r,c)'];
flc=['south_med_ssh_c'];
eval(['lab=num2str(', fmc,');'])
eval(['ttt=interp2(',fnc,',2);'])
mask_min=nan*ttt;
eval(['mask_min((ttt./',fmc,')>=.1)=1;'])
mask_maj=ones(size(ttt));
mask_maj(ii)=1;
eval(['tmp = double(interp2(',fbc,',2).*mask_min);'])
cplot_comps_cont_3_3(tmp,tmp,-15,15,1,0,50,...
	['~/Documents/OSU/figures/hovmuller/comps/',flc])
eval(['tmp = double(interp2(',fbc,',2).*mask_maj);'])
cplot_comps_cont_3_3(tmp,tmp,-15,15,1,0,50,...
	['~/Documents/OSU/figures/hovmuller/comps/',flc,'_bg'])	

fna=['south_med_ssh_a.N(r,c)'];
fma=['south_med_ssh_a.n_max_sample'];
fba=['south_med_ssh_a.median(r,c)'];
fla=['south_med_ssh_cc'];
eval(['lab=num2str(', fma,');'])
eval(['ttt=interp2(',fna,',2);'])
mask_min=nan*ttt;
eval(['mask_min((ttt./',fma,')>=.1)=1;'])
mask_maj=ones(size(ttt));
mask_maj(ii)=1;
eval(['tmp = double(interp2(',fba,',2).*mask_min);'])
cplot_comps_cont_3_3(tmp,tmp,-15,15,1,0,50,...
	['~/Documents/OSU/figures/hovmuller/comps/',fla])
eval(['tmp = double(interp2(',fba,',2).*mask_maj);'])
cplot_comps_cont_3_3(tmp,tmp,-15,15,1,0,50,...
	['~/Documents/OSU/figures/hovmuller/comps/',fla,'_bg'])			
	
fnc=['north_slow_bp26_chl_c.N(r,c)'];
fmc=['north_slow_bp26_chl_c.n_max_sample'];
fbc=['north_slow_bp26_chl_c.median(r,c)'];
flc=['north_slow_bp26_chl_c'];
eval(['lab=num2str(', fmc,');'])
eval(['ttt=interp2(',fnc,',2);'])
mask_min=nan*ttt;
eval(['mask_min((ttt./',fmc,')>=.1)=1;'])
mask_maj=ones(size(ttt));
mask_maj(ii)=1;
eval(['tmp = double(interp2(',fbc,',2).*mask_min);'])
cplot_comps_cont_3_3(tmp,tmp,-.02,.02,.0016,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',flc])
eval(['tmp = double(interp2(',fbc,',2).*mask_maj);'])
cplot_comps_cont_3_3(tmp,tmp,-.02,.02,.0016,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',flc,'_bg'])	

fna=['north_slow_bp26_chl_a.N(r,c)'];
fma=['north_slow_bp26_chl_a.n_max_sample'];
fba=['north_slow_bp26_chl_a.median(r,c)'];
fla=['north_slow_bp26_chl_cc'];
eval(['lab=num2str(', fma,');'])
eval(['ttt=interp2(',fna,',2);'])
mask_min=nan*ttt;
eval(['mask_min((ttt./',fma,')>=.1)=1;'])
mask_maj=ones(size(ttt));
mask_maj(ii)=1;
eval(['tmp = double(interp2(',fba,',2).*mask_min);'])
cplot_comps_cont_3_3(tmp,tmp,-.02,.02,.0016,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',fla])
eval(['tmp = double(interp2(',fba,',2).*mask_maj);'])
cplot_comps_cont_3_3(tmp,tmp,-.02,.02,.0016,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',fla,'_bg'])	
	
fnc=['south_slow_bp26_chl_c.N(r,c)'];
fmc=['south_slow_bp26_chl_c.n_max_sample'];
fbc=['south_slow_bp26_chl_c.median(r,c)'];
flc=['south_slow_bp26_chl_c'];
eval(['lab=num2str(', fmc,');'])
eval(['ttt=interp2(',fnc,',2);'])
mask_min=nan*ttt;
eval(['mask_min((ttt./',fmc,')>=.1)=1;'])
mask_maj=ones(size(ttt));
mask_maj(ii)=1;
eval(['tmp = double(interp2(',fbc,',2).*mask_min);'])
cplot_comps_cont_3_3(tmp,tmp,-.02,.02,.0016,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',flc])
eval(['tmp = double(interp2(',fbc,',2).*mask_maj);'])
cplot_comps_cont_3_3(tmp,tmp,-.02,.02,.0016,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',flc,'_bg'])	

fna=['south_slow_bp26_chl_a.N(r,c)'];
fma=['south_slow_bp26_chl_a.n_max_sample'];
fba=['south_slow_bp26_chl_a.median(r,c)'];
fla=['south_slow_bp26_chl_cc'];
eval(['lab=num2str(', fma,');'])
eval(['ttt=interp2(',fna,',2);'])
mask_min=nan*ttt;
eval(['mask_min((ttt./',fma,')>=.1)=1;'])
mask_maj=ones(size(ttt));
mask_maj(ii)=1;
eval(['tmp = double(interp2(',fba,',2).*mask_min);'])
cplot_comps_cont_3_3(tmp,tmp,-.02,.02,.0016,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',fla])
eval(['tmp = double(interp2(',fba,',2).*mask_maj);'])
cplot_comps_cont_3_3(tmp,tmp,-.02,.02,.0016,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',fla,'_bg'])	


fnc=['north_slow_ssh_c.N(r,c)'];
fmc=['north_slow_ssh_c.n_max_sample'];
fbc=['north_slow_ssh_c.median(r,c)'];
flc=['north_slow_ssh_c'];
eval(['lab=num2str(', fmc,');'])
eval(['ttt=interp2(',fnc,',2);'])
mask_min=nan*ttt;
eval(['mask_min((ttt./',fmc,')>=.1)=1;'])
mask_maj=ones(size(ttt));
mask_maj(ii)=1;
eval(['tmp = double(interp2(',fbc,',2).*mask_min);'])
cplot_comps_cont_3_3(tmp,tmp,-15,15,1,0,50,...
	['~/Documents/OSU/figures/hovmuller/comps/',flc])
eval(['tmp = double(interp2(',fbc,',2).*mask_maj);'])
cplot_comps_cont_3_3(tmp,tmp,-15,15,1,0,50,...
	['~/Documents/OSU/figures/hovmuller/comps/',flc,'_bg'])	

fna=['north_slow_ssh_a.N(r,c)'];
fma=['north_slow_ssh_a.n_max_sample'];
fba=['north_slow_ssh_a.median(r,c)'];
fla=['north_slow_ssh_cc'];
eval(['lab=num2str(', fma,');'])
eval(['ttt=interp2(',fna,',2);'])
mask_min=nan*ttt;
eval(['mask_min((ttt./',fma,')>=.1)=1;'])
mask_maj=ones(size(ttt));
mask_maj(ii)=1;
eval(['tmp = double(interp2(',fba,',2).*mask_min);'])
cplot_comps_cont_3_3(tmp,tmp,-15,15,1,0,50,...
	['~/Documents/OSU/figures/hovmuller/comps/',fla])
eval(['tmp = double(interp2(',fba,',2).*mask_maj);'])
cplot_comps_cont_3_3(tmp,tmp,-15,15,1,0,50,...
	['~/Documents/OSU/figures/hovmuller/comps/',fla,'_bg'])	
		
fnc=['south_slow_ssh_c.N(r,c)'];
fmc=['south_slow_ssh_c.n_max_sample'];
fbc=['south_slow_ssh_c.median(r,c)'];
flc=['south_slow_ssh_c'];
eval(['lab=num2str(', fmc,');'])
eval(['ttt=interp2(',fnc,',2);'])
mask_min=nan*ttt;
eval(['mask_min((ttt./',fmc,')>=.1)=1;'])
mask_maj=ones(size(ttt));
mask_maj(ii)=1;
eval(['tmp = double(interp2(',fbc,',2).*mask_min);'])
cplot_comps_cont_3_3(tmp,tmp,-15,15,1,0,50,...
	['~/Documents/OSU/figures/hovmuller/comps/',flc])
eval(['tmp = double(interp2(',fbc,',2).*mask_maj);'])
cplot_comps_cont_3_3(tmp,tmp,-15,15,1,0,50,...
	['~/Documents/OSU/figures/hovmuller/comps/',flc,'_bg'])	

fna=['south_slow_ssh_a.N(r,c)'];
fma=['south_slow_ssh_a.n_max_sample'];
fba=['south_slow_ssh_a.median(r,c)'];
fla=['south_slow_ssh_cc'];
eval(['lab=num2str(', fma,');'])
eval(['ttt=interp2(',fna,',2);'])
mask_min=nan*ttt;
eval(['mask_min((ttt./',fma,')>=.1)=1;'])
mask_maj=ones(size(ttt));
mask_maj(ii)=1;
eval(['tmp = double(interp2(',fba,',2).*mask_min);'])
cplot_comps_cont_3_3(tmp,tmp,-15,15,1,0,50,...
	['~/Documents/OSU/figures/hovmuller/comps/',fla])
eval(['tmp = double(interp2(',fba,',2).*mask_maj);'])
cplot_comps_cont_3_3(tmp,tmp,-15,15,1,0,50,...
	['~/Documents/OSU/figures/hovmuller/comps/',fla,'_bg'])		