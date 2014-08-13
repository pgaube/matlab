
clear all

load mgrad_combo median_dfdy_gchl mask
load chelle.pal
load_path = '/home/wallaby/data/pgaube/data/seawifs/mat/';
load(['/Volumes/matlab/data/SeaWiFS/mat/SCHL_9_21_2450821'],'glon','glat')
interp_jdays=[2450821:7:2454832];
load /Volumes/matlab/data/eddy/V4/global_tracks_v4_16_weeks

f1=find(abs(gy)>=15 & abs(gy)<=35 & amp>=15);
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
	i_grid=nan*k;
	
grads=nan*median_dfdy_gchl;
i_grads=nan*grads;


grads=median_dfdy_gchl.*mask;

ii=find(grads>=.02);
i_grads(ii)=1;
ii=find(grads<=-.02);
i_grads(ii)=-1;
ii=find(grads>-.02 & grads<.02);
i_grads(ii)=0;

for pp=1:length(id)
	[r,c]=imap(gy(pp),gy(pp),gx(pp),gx(pp),glat,glon);
	i_grid(pp)=i_grads(r,c);
end	
%{

for m=13:length(interp_jdays)-13
    	fprintf('\r     writing to file %03u of %03u \r',m,length(interp_jdays))
    	fname = ['/Volumes/matlab/data/SeaWiFS/mat/SCHL_9_21_' num2str(interp_jdays(m)) '.mat'];
        load(fname,'ba_gchl_week')
		grads=-1e5*dfdy(ba_gchl_week,.25).*mask;
		ii=find(grads>=.03);
		i_grads(ii)=1;
		ii=find(grads<=-.03);
		i_grads(ii)=-1;
		ii=find(grads>-.03 & grads<.03);
		i_grads(ii)=0;
		
		%{
		figure(11)
		clf
		pmap(glon,glat,i_grads);
		colormap(chelle)
		caxis([-.08 .08])
		drawnow
		%}
		
		%find eddies
		mt=find(track_jday==interp_jdays(m));
		for pp=1:length(mt)
			[r,c]=imap(gy(mt(pp)),gy(mt(pp)),gx(mt(pp)),gx(mt(pp)),glat,glon);
			i_grid(mt(pp))=i_grads(r,c);
		end	
		
		grads=nan*grads;
		i_grads=nan*grads;
end
%}

save mgrad_combo_tracks nneg id eid x y gx gy amp i_grid axial_speed efold radius track_jday prop_speed k i_grads glon glat

iii=[-1 0 1];
for m=1:3
	clearallbut iii m 
	load mgrad_combo_tracks
	
	f1=find(i_grid==iii(m));
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
	
	eval(['save mgrad_combo_' num2str(iii(m)) '_tracks nneg id eid x y amp axial_speed efold radius track_jday prop_speed k'])
end

load mgrad_combo_1_tracks
[north_bp26_chl_c,north_bp26_chl_a]=clock_comps('/Volumes/matlab/matlab/hovmuller/mgrad_combo_1_tracks','nrnbp26_chl_sample','n');
%[north_ssh_c,north_ssh_a]=clock_comps('/Volumes/matlab/matlab/hovmuller/mgrad_combo_1_tracks','nrssh_sample','n');
load mgrad_combo_0_tracks
[none_bp26_chl_c,none_bp26_chl_a]=clock_comps('/Volumes/matlab/matlab/hovmuller/mgrad_combo_0_tracks','nrnbp26_chl_sample','n');
%[none_ssh_c,none_ssh_a]=clock_comps('/Volumes/matlab/matlab/hovmuller/mgrad_combo_0_tracks','nrssh_sample','n');
load mgrad_combo_-1_tracks
[south_bp26_chl_c,south_bp26_chl_a]=clock_comps('/Volumes/matlab/matlab/hovmuller/mgrad_combo_-1_tracks','nrnbp26_chl_sample','n');
%[south_ssh_c,south_ssh_a]=clock_comps('/Volumes/matlab/matlab/hovmuller/mgrad_combo_-1_tracks','nrssh_sample','n');
save -append mgrad_combo_comps
clear
return
%}


load mgrad_combo_comps
zgrid_grid
[r,c]=imap(-3,3,-3,3,yi,xi);
xi=xi(r,c);
yi=yi(r,c);
dist=sqrt(xi.^2+yi.^2);
dist=interp2(dist,2);
ii=find(dist<=1.5);



fnc=['north_bp26_chl_c.N(r,c)'];
fmc=['north_bp26_chl_c.n_max_sample'];
fbc=['north_bp26_chl_c.median(r,c)'];
flc=['north_bp26_chl_c'];
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

fna=['north_bp26_chl_a.N(r,c)'];
fma=['north_bp26_chl_a.n_max_sample'];
fba=['north_bp26_chl_a.median(r,c)'];
fla=['north_bp26_chl_cc'];
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
	
fnc=['none_bp26_chl_c.N(r,c)'];
fmc=['none_bp26_chl_c.n_max_sample'];
fbc=['none_bp26_chl_c.median(r,c)'];
flc=['none_bp26_chl_c'];
eval(['lab=num2str(', fmc,');'])
eval(['ttt=interp2(',fnc,',2);'])
mask_min=nan*ttt;
eval(['mask_min((ttt./',fmc,')>=.1)=1;'])
mask_maj=ones(size(ttt));
mask_maj(ii)=1;
eval(['tmp = double(interp2(',fbc,',2).*mask_min);'])
cplot_comps_cont_3_3(tmp,tmp,-.01,.01,.0005,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',flc])
eval(['tmp = double(interp2(',fbc,',2).*mask_maj);'])
cplot_comps_cont_3_3(tmp,tmp,-.01,.01,.0005,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',flc,'_bg'])	

fna=['none_bp26_chl_a.N(r,c)'];
fma=['none_bp26_chl_a.n_max_sample'];
fba=['none_bp26_chl_a.median(r,c)'];
fla=['none_bp26_chl_cc'];
eval(['lab=num2str(', fma,');'])
eval(['ttt=interp2(',fna,',2);'])
mask_min=nan*ttt;
eval(['mask_min((ttt./',fma,')>=.1)=1;'])
mask_maj=ones(size(ttt));
mask_maj(ii)=1;
eval(['tmp = double(interp2(',fba,',2).*mask_min);'])
cplot_comps_cont_3_3(tmp,tmp,-.01,.01,.0005,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',fla])
eval(['tmp = double(interp2(',fba,',2).*mask_maj);'])
cplot_comps_cont_3_3(tmp,tmp,-.01,.01,.0005,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',fla,'_bg'])	
	
fnc=['south_bp26_chl_c.N(r,c)'];
fmc=['south_bp26_chl_c.n_max_sample'];
fbc=['south_bp26_chl_c.median(r,c)'];
flc=['south_bp26_chl_c'];
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

fna=['south_bp26_chl_a.N(r,c)'];
fma=['south_bp26_chl_a.n_max_sample'];
fba=['south_bp26_chl_a.median(r,c)'];
fla=['south_bp26_chl_cc'];
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


return
fnc=['north_ssh_c.N(r,c)'];
fmc=['north_ssh_c.n_max_sample'];
fbc=['north_ssh_c.median(r,c)'];
flc=['north_ssh_c'];
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

fna=['north_ssh_a.N(r,c)'];
fma=['north_ssh_a.n_max_sample'];
fba=['north_ssh_a.median(r,c)'];
fla=['north_ssh_cc'];
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
	

%{
fnc=['none_ssh_c.N(r,c)'];
fmc=['none_ssh_c.n_max_sample'];
fbc=['none_ssh_c.median(r,c)'];
flc=['none_ssh_c'];
eval(['lab=num2str(', fmc,');'])
eval(['ttt=interp2(',fnc,',2);'])
mask_min=nan*ttt;
eval(['mask_min((ttt./',fmc,')>=.1)=1;'])
mask_maj=ones(size(ttt));
mask_maj(ii)=1;
eval(['tmp = double(interp2(',fbc,',2).*mask_min);'])
cplot_comps_cont_3_3(tmp,tmp,-.01,.01,.0005,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',flc])
eval(['tmp = double(interp2(',fbc,',2).*mask_maj);'])
cplot_comps_cont_3_3(tmp,tmp,-.01,.01,.0005,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',flc,'_bg'])	

fna=['none_ssh_a.N(r,c)'];
fma=['none_ssh_a.n_max_sample'];
fba=['none_ssh_a.median(r,c)'];
fla=['none_ssh_cc'];
eval(['lab=num2str(', fma,');'])
eval(['ttt=interp2(',fna,',2);'])
mask_min=nan*ttt;
eval(['mask_min((ttt./',fma,')>=.1)=1;'])
mask_maj=ones(size(ttt));
mask_maj(ii)=1;
eval(['tmp = double(interp2(',fba,',2).*mask_min);'])
cplot_comps_cont_3_3(tmp,tmp,-.01,.01,.0005,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',fla])
eval(['tmp = double(interp2(',fba,',2).*mask_maj);'])
cplot_comps_cont_3_3(tmp,tmp,-.01,.01,.0005,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',fla,'_bg'])	
%}	
fnc=['south_ssh_c.N(r,c)'];
fmc=['south_ssh_c.n_max_sample'];
fbc=['south_ssh_c.median(r,c)'];
flc=['south_ssh_c'];
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

fna=['south_ssh_a.N(r,c)'];
fma=['south_ssh_a.n_max_sample'];
fba=['south_ssh_a.median(r,c)'];
fla=['south_ssh_cc'];
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