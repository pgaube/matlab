%clear all

load new_north_south_comps

mask_maj=nan*north_33crl_c.N(r,c);
mask_min=nan*north_33crl_c.N(r,c);
mask_maj((north_33crl_c.N(r,c)./north_33crl_c.n_max_sample)>=.1)=1;
mask_min(north_33crl_c.N(r,c)>=100)=1;
tmp = double(north_33crl_c.mean(r,c).*mask_min.*1e5);

mask_maj2=nan*north_crlg_c.N(r,c);
mask_min2=nan*north_crlg_c.N(r,c);
mask_maj2((north_crlg_c.N(r,c)./north_crlg_c.n_max_sample)>=.1)=1;
mask_min2(north_crlg_c.N(r,c)>=100)=1;
tmp2 = double(-north_crlg_c.mean(r,c).*mask_min2.*1e5.*.36);

%[t_nwc,t_ngc,l_nwc]=transect2(tmp,tmp2,100,-1,1);

cplot_comps_cont(tmp,tmp.*mask_maj,-.3,.3,.01,-1,1, ...
	'~/Documents/OSU/figures/north/crl/north_comp_cont_crl33_c')
cplot_comps_cont(tmp2,tmp2.*mask_maj,-.3,.3,.01,-1,1, ...
	'~/Documents/OSU/figures/north/crl/north_comp_cont_crlg_c')	

mask_maj=nan*north_33crl_a.N(r,c);
mask_min=nan*north_33crl_a.N(r,c);
mask_maj((north_33crl_a.N(r,c)./north_33crl_a.n_max_sample)>=.1)=1;
mask_min(north_33crl_a.N(r,c)>=100)=1;
tmp = double(north_33crl_a.mean(r,c).*mask_min.*1e5);

mask_maj2=nan*north_crlg_a.N(r,c);
mask_min2=nan*north_crlg_a.N(r,c);
mask_maj2((north_crlg_a.N(r,c)./north_crlg_a.n_max_sample)>=.1)=1;
mask_min2(north_crlg_a.N(r,c)>=100)=1;
tmp2 = double(-north_crlg_a.mean(r,c).*mask_min2.*1e5*.36);

%[t_nwc,t_ngc,l_nwc]=transect2(tmp,tmp2,100,-1,1);

cplot_comps_cont(tmp,tmp.*mask_maj,-.3,.3,.01,-1,1, ...
	'~/Documents/OSU/figures/north/crl/north_comp_cont_crl33_a')
cplot_comps_cont(tmp2,tmp2.*mask_maj,-.3,.3,.01,-1,1, ...
	'~/Documents/OSU/figures/north/crl/north_comp_cont_crlg_a')		


mask_maj=nan*south_33crl_c.N(r,c);
mask_min=nan*south_33crl_c.N(r,c);
mask_maj((south_33crl_c.N(r,c)./south_33crl_c.n_max_sample)>=.1)=1;
mask_min(south_33crl_c.N(r,c)>=100)=1;
tmp = double(south_33crl_c.mean(r,c).*mask_min.*1e5);

mask_maj2=nan*south_crlg_c.N(r,c);
mask_min2=nan*south_crlg_c.N(r,c);
mask_maj2((south_crlg_c.N(r,c)./south_crlg_c.n_max_sample)>=.1)=1;
mask_min2(south_crlg_c.N(r,c)>=100)=1;
tmp2 = double(-south_crlg_c.mean(r,c).*mask_min2.*1e5.*.44);

%[t_nwc,t_ngc,l_nwc]=transect2(tmp,tmp2,100,-1,1);

cplot_comps_cont(tmp,tmp.*mask_maj,-.3,.3,.01,-1,1, ...
	'~/Documents/OSU/figures/south/crl/south_comp_cont_crl33_c')
cplot_comps_cont(tmp2,tmp2.*mask_maj,-.3,.3,.01,-1,1, ...
	'~/Documents/OSU/figures/south/crl/south_comp_cont_crlg_c')	

mask_maj=nan*south_33crl_a.N(r,c);
mask_min=nan*south_33crl_a.N(r,c);
mask_maj((south_33crl_a.N(r,c)./south_33crl_a.n_max_sample)>=.1)=1;
mask_min(south_33crl_a.N(r,c)>=100)=1;
tmp = double(south_33crl_a.mean(r,c).*mask_min.*1e5);

mask_maj2=nan*south_crlg_a.N(r,c);
mask_min2=nan*south_crlg_a.N(r,c);
mask_maj2((south_crlg_a.N(r,c)./south_crlg_a.n_max_sample)>=.1)=1;
mask_min2(south_crlg_a.N(r,c)>=100)=1;
tmp2 = double(-south_crlg_a.mean(r,c).*mask_min2.*1e5*.44);

%[t_nwc,t_ngc,l_nwc]=transect2(tmp,tmp2,100,-1,1);

cplot_comps_cont(tmp,tmp.*mask_maj,-.3,.3,.01,-1,1, ...
	'~/Documents/OSU/figures/south/crl/south_comp_cont_crl33_a')
cplot_comps_cont(tmp2,tmp2.*mask_maj,-.3,.3,.01,-1,1, ...
	'~/Documents/OSU/figures/south/crl/south_comp_cont_crlg_a')	