clear all

load new_north_south_comps.mat


mask_maj=nan*north_rnfoi_c.N(r,c);
mask_min=nan*north_rnfoi_c.N(r,c);
mask_maj((north_rnfoi_c.N(r,c)./north_rnfoi_c.n_max_sample)>=.1)=1;
mask_min(north_rnfoi_c.N(r,c)>=100)=1;
tmp = double(north_rnfoi_c.mean(r,c).*mask_min);

mask_maj2=nan*north_rnhoi_c.N(r,c);
mask_min2=nan*north_rnhoi_c.N(r,c);
mask_maj2((north_rnhoi_c.N(r,c)./north_rnhoi_c.n_max_sample)>=.1)=1;
mask_min2(north_rnhoi_c.N(r,c)>=100)=1;
tmp2 = double(north_rnhoi_c.mean(r,c).*mask_min2);

%[t_noc,t_nsc,l_noc]=transect2(tmp,tmp2,100,-.6,.6);


cplot_comps(tmp,-.5,.5, ...
	'~/Documents/OSU/figures/north/harm_f/north_comp_rnfoi_c_bg')
cplot_comps(tmp2,-.5,.5, ...
	'~/Documents/OSU/figures/north/harm_f/north_comp_rnhoi_c_bg')	
	

tmp = double(north_rnfoi_c.mean(r,c).*mask_maj);
tmp2 = double(north_spd_c.mean(r,c).*mask_maj2);

cplot_comps(tmp,-.5,.5, ...
	'~/Documents/OSU/figures/north/harm_f/north_comp_rnfoi_c')
cplot_comps(tmp2,-.5,.5, ...
	'~/Documents/OSU/figures/north/harm_f/north_comp_rnhoi_c')


mask_maj=nan*north_rnfoi_a.N(r,c);
mask_min=nan*north_rnfoi_a.N(r,c);
mask_maj((north_rnfoi_a.N(r,c)./north_rnfoi_a.n_max_sample)>=.1)=1;
mask_min(north_rnfoi_a.N(r,c)>=100)=1;
tmp = double(north_rnfoi_a.mean(r,c).*mask_min);

mask_maj2=nan*north_rnhoi_a.N(r,c);
mask_min2=nan*north_rnhoi_a.N(r,c);
mask_maj2((north_rnhoi_a.N(r,c)./north_rnhoi_a.n_max_sample)>=.1)=1;
mask_min2(north_rnhoi_a.N(r,c)>=100)=1;
tmp2 = double(north_rnhoi_a.mean(r,c).*mask_min2);

%[t_noa,t_nsa,l_noa]=transect2(tmp,tmp2,100,-.6,.6);

cplot_comps(tmp,-.5,.5, ...
	'~/Documents/OSU/figures/north/harm_f/north_comp_rnfoi_a_bg')
cplot_comps(tmp2,-.5,.5, ...
	'~/Documents/OSU/figures/north/harm_f/north_comp_rnhoi_a_bg')		

tmp = double(north_rnfoi_a.mean(r,c).*mask_maj);
tmp2 = double(north_spd_a.mean(r,c).*mask_maj2);

cplot_comps(tmp,-.5,.5, ...
	'~/Documents/OSU/figures/north/harm_f/north_comp_rnfoi_a')
cplot_comps(tmp2,-.5,.5, ...
	'~/Documents/OSU/figures/north/harm_f/north_comp_rnhoi_a')

	
mask_maj=nan*south_rnfoi_c.N(r,c);
mask_min=nan*south_rnfoi_c.N(r,c);
mask_maj((south_rnfoi_c.N(r,c)./south_rnfoi_c.n_max_sample)>=.1)=1;
mask_min(south_rnfoi_c.N(r,c)>=100)=1;
tmp = double(south_rnfoi_c.mean(r,c).*mask_min);

mask_maj2=nan*south_rnhoi_c.N(r,c);
mask_min2=nan*south_rnhoi_c.N(r,c);
mask_maj2((south_rnhoi_c.N(r,c)./south_rnhoi_c.n_max_sample)>=.1)=1;
mask_min2(south_rnhoi_c.N(r,c)>=100)=1;
tmp2 = double(south_rnhoi_c.mean(r,c).*mask_min2);

%[t_noc,t_nsc,l_noc]=transect2(tmp,tmp2,100,-.6,.6);


cplot_comps(tmp,-.5,.5, ...
	'~/Documents/OSU/figures/north/harm_f/south_comp_rnfoi_c_bg')
cplot_comps(tmp2,-.5,.5, ...
	'~/Documents/OSU/figures/north/harm_f/south_comp_rnhoi_c_bg')	
	

tmp = double(south_rnfoi_c.mean(r,c).*mask_maj);
tmp2 = double(south_spd_c.mean(r,c).*mask_maj2);

cplot_comps(tmp,-.5,.5, ...
	'~/Documents/OSU/figures/north/harm_f/south_comp_rnfoi_c')
cplot_comps(tmp2,-.5,.5, ...
	'~/Documents/OSU/figures/north/harm_f/south_comp_rnhoi_c')


mask_maj=nan*south_rnfoi_a.N(r,c);
mask_min=nan*south_rnfoi_a.N(r,c);
mask_maj((south_rnfoi_a.N(r,c)./south_rnfoi_a.n_max_sample)>=.1)=1;
mask_min(south_rnfoi_a.N(r,c)>=100)=1;
tmp = double(south_rnfoi_a.mean(r,c).*mask_min);

mask_maj2=nan*south_rnhoi_a.N(r,c);
mask_min2=nan*south_rnhoi_a.N(r,c);
mask_maj2((south_rnhoi_a.N(r,c)./south_rnhoi_a.n_max_sample)>=.1)=1;
mask_min2(south_rnhoi_a.N(r,c)>=100)=1;
tmp2 = double(south_rnhoi_a.mean(r,c).*mask_min2);

%[t_noa,t_nsa,l_noa]=transect2(tmp,tmp2,100,-.6,.6);

cplot_comps(tmp,-.5,.5, ...
	'~/Documents/OSU/figures/north/harm_f/south_comp_rnfoi_a_bg')
cplot_comps(tmp2,-.5,.5, ...
	'~/Documents/OSU/figures/north/harm_f/south_comp_rnhoi_a_bg')		

tmp = double(south_rnfoi_a.mean(r,c).*mask_maj);
tmp2 = double(south_spd_a.mean(r,c).*mask_maj2);

cplot_comps(tmp,-.5,.5, ...
	'~/Documents/OSU/figures/north/harm_f/south_comp_rnfoi_a')
cplot_comps(tmp2,-.5,.5, ...
	'~/Documents/OSU/figures/north/harm_f/south_comp_rnhoi_a')
	
%cplot_yy_r_b(t_noc,t_noa,t_nsc,t_nsa,'~/Documents/OSU/figures/north/transects/north')
%cplot_yy_r_b(t_soc,t_soa,t_ssc,t_ssa,'~/Documents/OSU/figures/north/transects/south')