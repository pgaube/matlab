clear all

load vocals_rnfoi_comps

mask_maj=nan*vocals_rnfoi_c.N(r,c);
mask_min=nan*vocals_rnfoi_c.N(r,c);
mask_maj((vocals_rnfoi_c.N(r,c)./vocals_rnfoi_c.n_max_sample)>=.1)=1;
mask_min(vocals_rnfoi_c.N(r,c)>=100)=1;
tmp = double(vocals_rnfoi_c.mean(r,c).*mask_min);

[t_noc,l_noc]=transect(tmp,100,-.6,.6);

save -ascii /Volumes/matlab/calcomp/data/t_voc.txt t_voc
save -ascii /Volumes/matlab/calcomp/data/l_voc.txt l_voc

cplot_comps(tmp,-.5,.5, ...
	'~/Documents/OSU/figures/vocals/vocals_comp_rnfoi_c_transect_bg')

tmp = double(vocals_rnfoi_c.mean(r,c).*mask_maj);

cplot_comps_line(tmp,l_voc(1,:),l_voc(2,:),-.5,.5, ...
	'~/Documents/OSU/figures/vocals/vocals_comp_rnfoi_c_transect')
	
mask_maj=nan*vocals_rnfoi_a.N(r,c);
mask_min=nan*vocals_rnfoi_a.N(r,c);
mask_maj((vocals_rnfoi_a.N(r,c)./vocals_rnfoi_a.n_max_sample)>=.1)=1;
mask_min(vocals_rnfoi_a.N(r,c)>=100)=1;
tmp = double(vocals_rnfoi_a.mean(r,c).*mask_min);

[t_voa,l_voa]=transect(tmp,,100,-.6,.6);

save -ascii /Volumes/matlab/calcomp/data/t_voa.txt t_voa
save -ascii /Volumes/matlab/calcomp/data/l_voa.txt l_voa

cplot_comps(tmp,-.5,.5, ...
	'~/Documents/OSU/figures/vocals/vocals_comp_rnfoi_a_transect_bg')


tmp = double(vocals_rnfoi_a.mean(r,c).*mask_maj);

cplot_comps_line(tmp,l_noa(1,:),l_noa(2,:),-.5,.5, ...
	'~/Documents/OSU/figures/north/north_comp_rnfoi_a_transect')

cplot_xy_r_b(t_voc,t_voa,'~/Documents/OSU/figures/vocals/rnfoi_transect')