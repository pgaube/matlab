
clear all
%{
load /matlab/data/eddy/V4/global_tracks_V4_12_weeks.mat
load /matlab/matlab/masks/mask_cor_natl.mat
cd /matlab/matlab/eddy/
subset_eddies_mask_orgin
save /matlab/matlab/hovmuller/tracks/natl_cor_masked_orgin_tracks
return

save /matlab/matlab/hovmuller/tracks/haw_cor_masked_orgin_tracks
load /matlab/data/eddy/V4/global_tracks_V4_12_weeks.mat
save /matlab/matlab/hovmuller/tracks/glb_cor_masked_orgin_tracks

load /matlab/data/eddy/V4/global_tracks_V4_12_weeks.mat
load /matlab/matlab/masks/mask_cor_haw.mat
cd /matlab/matlab/eddy/
subset_eddies_mask_orgin
save /matlab/matlab/hovmuller/tracks/haw_cor_masked_orgin_tracks

load /matlab/data/eddy/V4/global_tracks_V4_12_weeks.mat
load /matlab/matlab/masks/mask_cor_opac.mat
cd /matlab/matlab/eddy/
subset_eddies_mask_orgin
save /matlab/matlab/hovmuller/tracks/opac_cor_masked_orgin_tracks

load /matlab/data/eddy/V4/global_tracks_V4_12_weeks.mat
load /matlab/matlab/masks/mask_cor_agu.mat
cd /matlab/matlab/eddy/
subset_eddies_mask_orgin
save /matlab/matlab/hovmuller/tracks/agu_cor_masked_orgin_tracks

clear all
load /matlab/data/eddy/V4/global_tracks_V4_12_weeks.mat
load /matlab/matlab/masks/mask_cor_bmc.mat
cd /matlab/matlab/eddy/
subset_eddies_mask_orgin
save /matlab/matlab/hovmuller/tracks/bmc_cor_masked_orgin_tracks

clear all
load /matlab/data/eddy/V4/global_tracks_V4_12_weeks.mat
load /matlab/matlab/masks/mask_cor_gs.mat
cd /matlab/matlab/eddy/
subset_eddies_mask_orgin
save /matlab/matlab/hovmuller/tracks/gs_cor_masked_orgin_tracks

clear all
load /matlab/data/eddy/V4/global_tracks_V4_12_weeks.mat
load /matlab/matlab/masks/mask_cor_eac.mat
cd /matlab/matlab/eddy/
subset_eddies_mask_orgin
save /matlab/matlab/hovmuller/tracks/eac_cor_masked_orgin_tracks

clear all
load /matlab/data/eddy/V4/global_tracks_V4_12_weeks.mat
load /matlab/matlab/masks/mask_cor_lw.mat
cd /matlab/matlab/eddy/
subset_eddies_mask_orgin
save /matlab/matlab/hovmuller/tracks/lw_cor_masked_orgin_tracks

cd /matlab/matlab/hovmuller

%}
load /matlab/data/gsm/cor_chl_ssh_out.mat lat lon
load /matlab/matlab/hovmuller/tracks/opac_cor_masked_orgin_tracks x y id
xp=x;
yp=y;
ip=id;
load /matlab/matlab/hovmuller/tracks/haw_cor_masked_orgin_tracks x y id
xp=cat(1,xp,x);
yp=cat(1,yp,y);
ip=cat(1,ip,id);
load /matlab/matlab/hovmuller/tracks/natl_cor_masked_orgin_tracks x y id
xp=cat(1,xp,x);
yp=cat(1,yp,y);
ip=cat(1,ip,id);
load /matlab/matlab/hovmuller/tracks/agu_cor_masked_orgin_tracks x y id
xp=cat(1,xp,x);
yp=cat(1,yp,y);
ip=cat(1,ip,id);
load /matlab/matlab/hovmuller/tracks/bmc_cor_masked_orgin_tracks x y id
xp=cat(1,xp,x);
yp=cat(1,yp,y);
ip=cat(1,ip,id);
load /matlab/matlab/hovmuller/tracks/gs_cor_masked_orgin_tracks x y id
xp=cat(1,xp,x);
yp=cat(1,yp,y);
ip=cat(1,ip,id);
load /matlab/matlab/hovmuller/tracks/eac_cor_masked_orgin_tracks x y id
xp=cat(1,xp,x);
yp=cat(1,yp,y);
ip=cat(1,ip,id);
load /matlab/matlab/hovmuller/tracks/lw_cor_masked_orgin_tracks x y id
xp=cat(1,xp,x);
yp=cat(1,yp,y);
ip=cat(1,ip,id);
figure(1)
clf
pmap(lon,lat,[xp yp ip],'tracks_dots')
print -dpng -r300 figs/global_cor_tracks
return
load /matlab/matlab/hovmuller/tracks/opac_cor_masked_orgin_tracks x y id
figure(9)
clf
pmap(min(x)-10:max(x)+10,min(y)-3:max(y)+3,[x y id],'tracks')
print -dpng -r300 figs/opac_tracks

load /matlab/matlab/hovmuller/tracks/haw_cor_masked_orgin_tracks x y id
figure(9)
clf
pmap(min(x)-10:max(x)+10,min(y)-3:max(y)+3,[x y id],'tracks')
print -dpng -r300 figs/haw_tracks

load /matlab/matlab/hovmuller/tracks/natl_cor_masked_orgin_tracks x y id
figure(9)
clf
pmap(min(x)-10:max(x)+10,min(y)-3:max(y)+3,[x y id],'tracks')
print -dpng -r300 figs/natl_tracks

load /matlab/matlab/hovmuller/tracks/opac_cor_masked_orgin_tracks x y id
figure(9)
clf
pmap(min(x)-10:max(x)+10,min(y)-3:max(y)+3,[x y id],'tracks')
print -dpng -r300 figs/opac_tracks
%title('AGU')

load /matlab/matlab/hovmuller/tracks/agu_cor_masked_orgin_tracks x y id
figure(10)
clf
pmap(min(x)-10:max(x)+10,min(y)-3:max(y)+3,[x y id],'tracks_dots')
%title('AGU')
print -dpng -r300 figs/agu_tracks


load /matlab/matlab/hovmuller/tracks/bmc_cor_masked_orgin_tracks x y id
figure(11)
clf
pmap(min(x)-10:max(x)+10,min(y)-3:max(y)+3,[x y id],'tracks')
%title('BMC')
print -dpng -r300 figs/bmc_tracks

load /matlab/matlab/hovmuller/tracks/gs_cor_masked_orgin_tracks x y id
figure(12)
clf
pmap(min(x)-10:max(x)+10,min(y)-3:max(y)+3,[x y id],'tracks')
%title('GS')
print -dpng -r300 figs/gs_tracks

load /matlab/matlab/hovmuller/tracks/eac_cor_masked_orgin_tracks x y id
figure(13)
clf
pmap(min(x)-10:max(x)+10,min(y)-3:max(y)+3,[x y id],'tracks')
%title('EAC')
print -dpng -r300 figs/eac_tracks

load /matlab/matlab/hovmuller/tracks/lw_cor_masked_orgin_tracks x y id
figure(14)
clf
pmap(min(x)-10:max(x)+10,min(y)-3:max(y)+3,[x y id],'tracks')
%title('LW')
print -dpng -r300 figs/lw_tracks

return
[agu_car_a,agu_car_c]=mcomps('tracks/agu_cor_masked_orgin_tracks','nrbp21_car_sample','n');
[agu_car_a,agu_car_c]=mcomps('tracks/agu_cor_masked_orgin_tracks','nrbp21_car_sample','n');
[bmc_car_a,bmc_car_c]=mcomps('tracks/bmc_cor_masked_orgin_tracks','nrbp21_car_sample','n');
[eac_car_a,eac_car_c]=mcomps('tracks/eac_cor_masked_orgin_tracks','nrbp21_car_sample','n');
[gs_car_a,gs_car_c]=mcomps('tracks/gs_cor_masked_orgin_tracks','nrbp21_car_sample','n');
[lw_car_a,lw_car_c]=mcomps('tracks/lw_cor_masked_orgin_tracks','nrbp21_car_sample','n');
[haw_car_a,haw_car_c]=mcomps('tracks/haw_cor_masked_orgin_tracks','nrbp21_car_sample','n');


[agu_mu_a,agu_mu_c]=mcomps('tracks/agu_cor_masked_orgin_tracks','nrbp26_mu_sample','n');
[bmc_mu_a,bmc_mu_c]=mcomps('tracks/bmc_cor_masked_orgin_tracks','nrbp26_mu_sample','n');
[eac_mu_a,eac_mu_c]=mcomps('tracks/eac_cor_masked_orgin_tracks','nrbp26_mu_sample','n');
[gs_mu_a,gs_mu_c]=mcomps('tracks/gs_cor_masked_orgin_tracks','nrbp26_mu_sample','n');
[lw_mu_a,lw_mu_c]=mcomps('tracks/lw_cor_masked_orgin_tracks','nrbp26_mu_sample','n');
[haw_mu_a,haw_mu_c]=mcomps('tracks/haw_cor_masked_orgin_tracks','nrbp26_mu_sample','n');

[opac_a,opac_c]=mcomps('tracks/opac_cor_masked_orgin_tracks','nrnbp21_chl_sample','n');
[agu_a,agu_c]=mcomps('tracks/agu_cor_masked_orgin_tracks','nrnbp21_chl_sample','n');
[bmc_a,bmc_c]=mcomps('tracks/bmc_cor_masked_orgin_tracks','nrnbp21_chl_sample','n');
[eac_a,eac_c]=mcomps('tracks/eac_cor_masked_orgin_tracks','nrnbp21_chl_sample','n');
[gs_a,gs_c]=mcomps('tracks/gs_cor_masked_orgin_tracks','nrnbp21_chl_sample','n');
[lw_a,lw_c]=mcomps('tracks/lw_cor_masked_orgin_tracks','nrnbp21_chl_sample','n');
[haw_a,haw_c]=mcomps('tracks/haw_cor_masked_orgin_tracks','nrnbp21_chl_sample','n');
save -append current_cor_comps
return
%}


load current_cor_comps
zgrid_grid
r=17:65;
c=17:65;
dist=dist(r,c);
dist=interp2(dist,2);
mask=nan*dist;
ii=find(dist<=1.7);
mask(ii)=1;

%{
fnc=['haw_car_c.N'];
fmc=['haw_car_c.n_max_sample'];
fbc=['haw_car_c.median'];
flc=['haw_car_c'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.035,.035,.005,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',flc])

fna=['haw_car_a.N'];
fma=['haw_car_a.n_max_sample'];
fba=['haw_car_a.median'];
fla=['haw_car_a'];
eval(['lab=num2str(', fma,');'])
eval(['tmp = double(interp2(',fba,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.035,.035,.005,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',fla])
%}	
fnc=['agu_car_c.N'];
fmc=['agu_car_c.n_max_sample'];
fbc=['agu_car_c.median'];
flc=['agu_car_c'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.035,.035,.005,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',flc])

fna=['agu_car_a.N'];
fma=['agu_car_a.n_max_sample'];
fba=['agu_car_a.median'];
fla=['agu_car_a'];
eval(['lab=num2str(', fma,');'])
eval(['tmp = double(interp2(',fba,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.035,.035,.005,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',fla])
%{
	
fnc=['bmc_car_c.N'];
fmc=['bmc_car_c.n_max_sample'];
fbc=['bmc_car_c.median'];
flc=['bmc_car_c'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.05,.05,.005,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',flc])

fna=['bmc_car_a.N'];
fma=['bmc_car_a.n_max_sample'];
fba=['bmc_car_a.median'];
fla=['bmc_car_a'];
eval(['lab=num2str(', fma,');'])
eval(['tmp = double(interp2(',fba,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.05,.05,.005,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',fla])

fnc=['eac_car_c.N'];
fmc=['eac_car_c.n_max_sample'];
fbc=['eac_car_c.median'];
flc=['eac_car_c'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.04,.04,.005,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',flc])

fna=['eac_car_a.N'];
fma=['eac_car_a.n_max_sample'];
fba=['eac_car_a.median'];
fla=['eac_car_a'];
eval(['lab=num2str(', fma,');'])
eval(['tmp = double(interp2(',fba,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.04,.04,.005,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',fla])
	
fnc=['gs_car_c.N'];
fmc=['gs_car_c.n_max_sample'];
fbc=['gs_car_c.median'];
flc=['gs_car_c'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.04,.04,.005,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',flc])

fna=['gs_car_a.N'];
fma=['gs_car_a.n_max_sample'];
fba=['gs_car_a.median'];
fla=['gs_car_a'];
eval(['lab=num2str(', fma,');'])
eval(['tmp = double(interp2(',fba,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.04,.04,.005,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',fla])	

fnc=['lw_car_c.N'];
fmc=['lw_car_c.n_max_sample'];
fbc=['lw_car_c.median'];
flc=['lw_car_c'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.02,.02,.003,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',flc])

fna=['lw_car_a.N'];
fma=['lw_car_a.n_max_sample'];
fba=['lw_car_a.median'];
fla=['lw_car_a'];
eval(['lab=num2str(', fma,');'])
eval(['tmp = double(interp2(',fba,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.02,.02,.003,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',fla])	

fnc=['haw_mu_c.N'];
fmc=['haw_mu_c.n_max_sample'];
fbc=['haw_mu_c.median'];
flc=['haw_mu_c'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.035,.035,.008,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',flc])

fna=['haw_mu_a.N'];
fma=['haw_mu_a.n_max_sample'];
fba=['haw_mu_a.median'];
fla=['haw_mu_a'];
eval(['lab=num2str(', fma,');'])
eval(['tmp = double(interp2(',fba,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.035,.035,.008,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',fla])
%}
fnc=['agu_mu_c.N'];
fmc=['agu_mu_c.n_max_sample'];
fbc=['agu_mu_c.median'];
flc=['agu_mu_c'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.035,.035,.008,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',flc])

fna=['agu_mu_a.N'];
fma=['agu_mu_a.n_max_sample'];
fba=['agu_mu_a.median'];
fla=['agu_mu_a'];
eval(['lab=num2str(', fma,');'])
eval(['tmp = double(interp2(',fba,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.035,.035,.008,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',fla])

%{	
fnc=['bmc_mu_c.N'];
fmc=['bmc_mu_c.n_max_sample'];
fbc=['bmc_mu_c.median'];
flc=['bmc_mu_c'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.045,.045,.008,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',flc])

fna=['bmc_mu_a.N'];
fma=['bmc_mu_a.n_max_sample'];
fba=['bmc_mu_a.median'];
fla=['bmc_mu_a'];
eval(['lab=num2str(', fma,');'])
eval(['tmp = double(interp2(',fba,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.045,.045,.008,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',fla])

fnc=['eac_mu_c.N'];
fmc=['eac_mu_c.n_max_sample'];
fbc=['eac_mu_c.median'];
flc=['eac_mu_c'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.06,.06,.008,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',flc])

fna=['eac_mu_a.N'];
fma=['eac_mu_a.n_max_sample'];
fba=['eac_mu_a.median'];
fla=['eac_mu_a'];
eval(['lab=num2str(', fma,');'])
eval(['tmp = double(interp2(',fba,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.06,.06,.008,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',fla])
	
fnc=['gs_mu_c.N'];
fmc=['gs_mu_c.n_max_sample'];
fbc=['gs_mu_c.median'];
flc=['gs_mu_c'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.06,.06,.008,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',flc])

fna=['gs_mu_a.N'];
fma=['gs_mu_a.n_max_sample'];
fba=['gs_mu_a.median'];
fla=['gs_mu_a'];
eval(['lab=num2str(', fma,');'])
eval(['tmp = double(interp2(',fba,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.06,.06,.008,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',fla])	

fnc=['lw_mu_c.N'];
fmc=['lw_mu_c.n_max_sample'];
fbc=['lw_mu_c.median'];
flc=['lw_mu_c'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.02,.02,.002,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',flc])

fna=['lw_mu_a.N'];
fma=['lw_mu_a.n_max_sample'];
fba=['lw_mu_a.median'];
fla=['lw_mu_a'];
eval(['lab=num2str(', fma,');'])
eval(['tmp = double(interp2(',fba,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.016,.016,.002,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',fla])	
	
fnc=['lw_mu_c.N'];
fmc=['lw_mu_c.n_max_sample'];
fbc=['lw_mu_c.median'];
flc=['lw_mu_c'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.02,.02,.002,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',flc])

fna=['lw_mu_a.N'];
fma=['lw_mu_a.n_max_sample'];
fba=['lw_mu_a.median'];
fla=['lw_mu_a'];
eval(['lab=num2str(', fma,');'])
eval(['tmp = double(interp2(',fba,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.016,.016,.002,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',fla])	

fnc=['haw_c.N'];
fmc=['haw_c.n_max_sample'];
fbc=['haw_c.median'];
flc=['haw_c'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.03,.03,.005,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',flc])

fna=['haw_a.N'];
fma=['haw_a.n_max_sample'];
fba=['haw_a.median'];
fla=['haw_a'];
eval(['lab=num2str(', fma,');'])
eval(['tmp = double(interp2(',fba,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.03,.03,.005,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',fla])
	
	
fnc=['opac_c.N'];
fmc=['opac_c.n_max_sample'];
fbc=['opac_c.median'];
flc=['opac_c'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.05,.05,.005,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',flc])

fna=['opac_a.N'];
fma=['opac_a.n_max_sample'];
fba=['opac_a.median'];
fla=['opac_a'];
eval(['lab=num2str(', fma,');'])
eval(['tmp = double(interp2(',fba,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.05,.05,.005,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',fla])
	
%}
fnc=['agu_c.N'];
fmc=['agu_c.n_max_sample'];
fbc=['agu_c.median'];
flc=['agu_c'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.05,.05,.005,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',flc])

fna=['agu_a.N'];
fma=['agu_a.n_max_sample'];
fba=['agu_a.median'];
fla=['agu_a'];
eval(['lab=num2str(', fma,');'])
eval(['tmp = double(interp2(',fba,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.05,.05,.005,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',fla])

%{	
fnc=['bmc_c.N'];
fmc=['bmc_c.n_max_sample'];
fbc=['bmc_c.median'];
flc=['bmc_c'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.1,.1,.005,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',flc])

fna=['bmc_a.N'];
fma=['bmc_a.n_max_sample'];
fba=['bmc_a.median'];
fla=['bmc_a'];
eval(['lab=num2str(', fma,');'])
eval(['tmp = double(interp2(',fba,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.1,.1,.005,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',fla])

fnc=['eac_c.N'];
fmc=['eac_c.n_max_sample'];
fbc=['eac_c.median'];
flc=['eac_c'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.05,.05,.003,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',flc])

fna=['eac_a.N'];
fma=['eac_a.n_max_sample'];
fba=['eac_a.median'];
fla=['eac_a'];
eval(['lab=num2str(', fma,');'])
eval(['tmp = double(interp2(',fba,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.05,.05,.003,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',fla])
	
fnc=['gs_c.N'];
fmc=['gs_c.n_max_sample'];
fbc=['gs_c.median'];
flc=['gs_c'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.05,.05,.003,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',flc])

fna=['gs_a.N'];
fma=['gs_a.n_max_sample'];
fba=['gs_a.median'];
fla=['gs_a'];
eval(['lab=num2str(', fma,');'])
eval(['tmp = double(interp2(',fba,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.05,.05,.003,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',fla])	

fnc=['lw_c.N'];
fmc=['lw_c.n_max_sample'];
fbc=['lw_c.median'];
flc=['lw_c'];
eval(['lab=num2str(', fmc,');'])
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.03,.03,.002,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',flc])

fna=['lw_a.N'];
fma=['lw_a.n_max_sample'];
fba=['lw_a.median'];
fla=['lw_a'];
eval(['lab=num2str(', fma,');'])
eval(['tmp = double(interp2(',fba,',2));'])
cplot_comps_cont_3_3(tmp.*mask,tmp.*mask,-.03,.03,.002,-1,1,...
	['~/Documents/OSU/figures/hovmuller/comps/',fla])		

%}