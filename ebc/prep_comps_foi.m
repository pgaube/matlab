clear all

load dCCNS_foi_comps.mat


mask_maj=nan*dccns_foi_c.N(r,c);
mask_min=nan*dccns_foi_c.N(r,c);
mask_maj((dccns_foi_c.N(r,c)./dccns_foi_c.n_max_sample)>=.1)=1;
mask_min(dccns_foi_c.N(r,c)>=100)=1;
tmp = double(dccns_foi_c.mean(r,c).*mask_min);

%[t_noc,l_noc]=transect(tmp,100,-.6,.6);

cplot_comps(tmp,-.5,.5, ...
	'~/Documents/OSU/figures/Dudley/dccns_foi_c_transect_bg')
	

tmp = double(dccns_foi_c.mean(r,c).*mask_maj);

cplot_comps_cont_w(tmp,tmp,-.5,.5,.35,-.7,-.35, ...
	'~/Documents/OSU/figures/Dudley/dccns_foi_c_transect')
	


mask_maj=nan*dccns_foi_a.N(r,c);
mask_min=nan*dccns_foi_a.N(r,c);
mask_maj((dccns_foi_a.N(r,c)./dccns_foi_a.n_max_sample)>=.1)=1;
mask_min(dccns_foi_a.N(r,c)>=100)=1;
tmp = double(dccns_foi_a.mean(r,c).*mask_min);

%[t_noa,l_noa]=transect(tmp,100,-.6,.6);

cplot_comps(tmp,-.5,.5, ...
	'~/Documents/OSU/figures/Dudley/dccns_foi_a_transect_bg')

tmp = double(dccns_foi_a.mean(r,c).*mask_maj);

cplot_comps_cont_w(tmp,tmp,-.5,.5,.35,.35,.7, ...
	'~/Documents/OSU/figures/Dudley/dccns_foi_a_transect')


