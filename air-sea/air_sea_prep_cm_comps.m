clear all

%4_6_cm
load comps/comps_4_6_oi_cm

mask_maj=nan*north_4_6_oi_cm_c.N(r,c);
mask_min=nan*north_4_6_oi_cm_c.N(r,c);
mask_maj((north_4_6_oi_cm_c.N(r,c)./north_4_6_oi_cm_c.n_max_sample)>=.1)=1;
mask_min(north_4_6_oi_cm_c.N(r,c)>=10)=1;
tmp = double(north_4_6_oi_cm_c.mean(r,c).*mask_min);
N=north_4_6_oi_cm_c.N(r,c);
N_n_4_6_c=max(N(:))

%[t_noc,t_nsc,l_noc]=transect2(tmp,tmp2,100,-.6,.6);

cplot_comps(tmp,-.5,.5, ...
	'~/Documents/OSU/figures/air-sea/cm_comps/north_comp_oi_4_6_cm_c_bg')

tmp = double(north_4_6_oi_cm_c.mean(r,c).*mask_maj);

cplot_comps(tmp,-.5,.5, ...
	'~/Documents/OSU/figures/air-sea/cm_comps/north_comp_oi_4_6_cm_c')


mask_maj=nan*north_4_6_oi_cm_a.N(r,c);
mask_min=nan*north_4_6_oi_cm_a.N(r,c);
mask_maj((north_4_6_oi_cm_a.N(r,c)./north_4_6_oi_cm_a.n_max_sample)>=.1)=1;
mask_min(north_4_6_oi_cm_a.N(r,c)>=10)=1;
tmp = double(north_4_6_oi_cm_a.mean(r,c).*mask_min);
N=north_4_6_oi_cm_a.N(r,c);
N_n_4_6_a=max(N(:))

%[t_noa,t_nsa,l_noa]=transect2(tmp,tmp2,100,-.6,.6);

cplot_comps(tmp,-.5,.5, ...
	'~/Documents/OSU/figures/air-sea/cm_comps/north_comp_oi_4_6_cm_a_bg')

tmp = double(north_4_6_oi_cm_a.mean(r,c).*mask_maj);

cplot_comps(tmp,-.5,.5, ...
	'~/Documents/OSU/figures/air-sea/cm_comps/north_comp_oi_4_6_cm_a')
	
%6_8_cm
load comps/comps_6_8_oi_cm

mask_maj=nan*north_6_8_oi_cm_c.N(r,c);
mask_min=nan*north_6_8_oi_cm_c.N(r,c);
mask_maj((north_6_8_oi_cm_c.N(r,c)./north_6_8_oi_cm_c.n_max_sample)>=.1)=1;
mask_min(north_6_8_oi_cm_c.N(r,c)>=10)=1;
tmp = double(north_6_8_oi_cm_c.mean(r,c).*mask_min);
N=north_6_8_oi_cm_c.N(r,c);
N_n_6_8_c=max(N(:))

%[t_noc,t_nsc,l_noc]=transect2(tmp,tmp2,100,-.6,.6);

cplot_comps(tmp,-.5,.5, ...
	'~/Documents/OSU/figures/air-sea/cm_comps/north_comp_oi_6_8_cm_c_bg')

tmp = double(north_6_8_oi_cm_c.mean(r,c).*mask_maj);

cplot_comps(tmp,-.5,.5, ...
	'~/Documents/OSU/figures/air-sea/cm_comps/north_comp_oi_6_8_cm_c')


mask_maj=nan*north_6_8_oi_cm_a.N(r,c);
mask_min=nan*north_6_8_oi_cm_a.N(r,c);
mask_maj((north_6_8_oi_cm_a.N(r,c)./north_6_8_oi_cm_a.n_max_sample)>=.1)=1;
mask_min(north_6_8_oi_cm_a.N(r,c)>=10)=1;
tmp = double(north_6_8_oi_cm_a.mean(r,c).*mask_min);
N=north_6_8_oi_cm_a.N(r,c);
N_n_6_8_a=max(N(:))

%[t_noa,t_nsa,l_noa]=transect2(tmp,tmp2,100,-.6,.6);

cplot_comps(tmp,-.5,.5, ...
	'~/Documents/OSU/figures/air-sea/cm_comps/north_comp_oi_6_8_cm_a_bg')

tmp = double(north_6_8_oi_cm_a.mean(r,c).*mask_maj);

cplot_comps(tmp,-.5,.5, ...
	'~/Documents/OSU/figures/air-sea/cm_comps/north_comp_oi_6_8_cm_a')	
	
	
%8_10_cm
load comps/comps_8_10_oi_cm

mask_maj=nan*north_8_10_oi_cm_c.N(r,c);
mask_min=nan*north_8_10_oi_cm_c.N(r,c);
mask_maj((north_8_10_oi_cm_c.N(r,c)./north_8_10_oi_cm_c.n_max_sample)>=.1)=1;
mask_min(north_8_10_oi_cm_c.N(r,c)>=10)=1;
tmp = double(north_8_10_oi_cm_c.mean(r,c).*mask_min);
N=north_8_10_oi_cm_c.N(r,c);
N_n_8_10_c=max(N(:))

%[t_noc,t_nsc,l_noc]=transect2(tmp,tmp2,100,-.6,.6);

cplot_comps(tmp,-.5,.5, ...
	'~/Documents/OSU/figures/air-sea/cm_comps/north_comp_oi_8_10_cm_c_bg')

tmp = double(north_8_10_oi_cm_c.mean(r,c).*mask_maj);

cplot_comps(tmp,-.5,.5, ...
	'~/Documents/OSU/figures/air-sea/cm_comps/north_comp_oi_8_10_cm_c')


mask_maj=nan*north_8_10_oi_cm_a.N(r,c);
mask_min=nan*north_8_10_oi_cm_a.N(r,c);
mask_maj((north_8_10_oi_cm_a.N(r,c)./north_8_10_oi_cm_a.n_max_sample)>=.1)=1;
mask_min(north_8_10_oi_cm_a.N(r,c)>=10)=1;
tmp = double(north_8_10_oi_cm_a.mean(r,c).*mask_min);
N=north_8_10_oi_cm_a.N(r,c);
N_n_8_10_a=max(N(:))

%[t_noa,t_nsa,l_noa]=transect2(tmp,tmp2,100,-.6,.6);

cplot_comps(tmp,-.5,.5, ...
	'~/Documents/OSU/figures/air-sea/cm_comps/north_comp_oi_8_10_cm_a_bg')

tmp = double(north_8_10_oi_cm_a.mean(r,c).*mask_maj);

cplot_comps(tmp,-.5,.5, ...
	'~/Documents/OSU/figures/air-sea/cm_comps/north_comp_oi_8_10_cm_a')
	
%10_12_cm
load comps/comps_10_12_oi_cm

mask_maj=nan*north_10_12_oi_cm_c.N(r,c);
mask_min=nan*north_10_12_oi_cm_c.N(r,c);
mask_maj((north_10_12_oi_cm_c.N(r,c)./north_10_12_oi_cm_c.n_max_sample)>=.1)=1;
mask_min(north_10_12_oi_cm_c.N(r,c)>=10)=1;
tmp = double(north_10_12_oi_cm_c.mean(r,c).*mask_min);
N=north_10_12_oi_cm_c.N(r,c);
N_n_10_12_c=max(N(:))

%[t_noc,t_nsc,l_noc]=transect2(tmp,tmp2,100,-.6,.6);

cplot_comps(tmp,-.5,.5, ...
	'~/Documents/OSU/figures/air-sea/cm_comps/north_comp_oi_10_12_cm_c_bg')

tmp = double(north_10_12_oi_cm_c.mean(r,c).*mask_maj);

cplot_comps(tmp,-.5,.5, ...
	'~/Documents/OSU/figures/air-sea/cm_comps/north_comp_oi_10_12_cm_c')


mask_maj=nan*north_10_12_oi_cm_a.N(r,c);
mask_min=nan*north_10_12_oi_cm_a.N(r,c);
mask_maj((north_10_12_oi_cm_a.N(r,c)./north_10_12_oi_cm_a.n_max_sample)>=.1)=1;
mask_min(north_10_12_oi_cm_a.N(r,c)>=10)=1;
tmp = double(north_10_12_oi_cm_a.mean(r,c).*mask_min);
N=north_10_12_oi_cm_a.N(r,c);
N_n_10_12_a=max(N(:))

%[t_noa,t_nsa,l_noa]=transect2(tmp,tmp2,100,-.6,.6);

cplot_comps(tmp,-.5,.5, ...
	'~/Documents/OSU/figures/air-sea/cm_comps/north_comp_oi_10_12_cm_a_bg')

tmp = double(north_10_12_oi_cm_a.mean(r,c).*mask_maj);

cplot_comps(tmp,-.5,.5, ...
	'~/Documents/OSU/figures/air-sea/cm_comps/north_comp_oi_10_12_cm_a')
	
%12_14_cm
load comps/comps_12_14_oi_cm

mask_maj=nan*north_12_14_oi_cm_c.N(r,c);
mask_min=nan*north_12_14_oi_cm_c.N(r,c);
mask_maj((north_12_14_oi_cm_c.N(r,c)./north_12_14_oi_cm_c.n_max_sample)>=.1)=1;
mask_min(north_12_14_oi_cm_c.N(r,c)>=10)=1;
tmp = double(north_12_14_oi_cm_c.mean(r,c).*mask_min);
N=north_12_14_oi_cm_c.N(r,c);
N_n_12_14_c=max(N(:))

%[t_noc,t_nsc,l_noc]=transect2(tmp,tmp2,100,-.6,.6);

cplot_comps(tmp,-.5,.5, ...
	'~/Documents/OSU/figures/air-sea/cm_comps/north_comp_oi_12_14_cm_c_bg')

tmp = double(north_12_14_oi_cm_c.mean(r,c).*mask_maj);

cplot_comps(tmp,-.5,.5, ...
	'~/Documents/OSU/figures/air-sea/cm_comps/north_comp_oi_12_14_cm_c')


mask_maj=nan*north_12_14_oi_cm_a.N(r,c);
mask_min=nan*north_12_14_oi_cm_a.N(r,c);
mask_maj((north_12_14_oi_cm_a.N(r,c)./north_12_14_oi_cm_a.n_max_sample)>=.1)=1;
mask_min(north_12_14_oi_cm_a.N(r,c)>=10)=1;
tmp = double(north_12_14_oi_cm_a.mean(r,c).*mask_min);
N=north_12_14_oi_cm_a.N(r,c);
N_n_12_14_a=max(N(:))

%[t_noa,t_nsa,l_noa]=transect2(tmp,tmp2,100,-.6,.6);

cplot_comps(tmp,-.5,.5, ...
	'~/Documents/OSU/figures/air-sea/cm_comps/north_comp_oi_12_14_cm_a_bg')

tmp = double(north_12_14_oi_cm_a.mean(r,c).*mask_maj);

cplot_comps(tmp,-.5,.5, ...
	'~/Documents/OSU/figures/air-sea/cm_comps/north_comp_oi_12_14_cm_a')	
	
%14_16_cm
load comps/comps_14_16_oi_cm

mask_maj=nan*north_14_16_oi_cm_c.N(r,c);
mask_min=nan*north_14_16_oi_cm_c.N(r,c);
mask_maj((north_14_16_oi_cm_c.N(r,c)./north_14_16_oi_cm_c.n_max_sample)>=.1)=1;
mask_min(north_14_16_oi_cm_c.N(r,c)>=10)=1;
tmp = double(north_14_16_oi_cm_c.mean(r,c).*mask_min);
N=north_14_16_oi_cm_c.N(r,c);
N_n_14_16_c=max(N(:))

%[t_noc,t_nsc,l_noc]=transect2(tmp,tmp2,100,-.6,.6);

cplot_comps(tmp,-.5,.5, ...
	'~/Documents/OSU/figures/air-sea/cm_comps/north_comp_oi_14_16_cm_c_bg')

tmp = double(north_14_16_oi_cm_c.mean(r,c).*mask_maj);

cplot_comps(tmp,-.5,.5, ...
	'~/Documents/OSU/figures/air-sea/cm_comps/north_comp_oi_14_16_cm_c')


mask_maj=nan*north_14_16_oi_cm_a.N(r,c);
mask_min=nan*north_14_16_oi_cm_a.N(r,c);
mask_maj((north_14_16_oi_cm_a.N(r,c)./north_14_16_oi_cm_a.n_max_sample)>=.1)=1;
mask_min(north_14_16_oi_cm_a.N(r,c)>=10)=1;
tmp = double(north_14_16_oi_cm_a.mean(r,c).*mask_min);
N=north_14_16_oi_cm_a.N(r,c);
N_n_14_16_a=max(N(:))

%[t_noa,t_nsa,l_noa]=transect2(tmp,tmp2,100,-.6,.6);

cplot_comps(tmp,-.5,.5, ...
	'~/Documents/OSU/figures/air-sea/cm_comps/north_comp_oi_14_16_cm_a_bg')

tmp = double(north_14_16_oi_cm_a.mean(r,c).*mask_maj);

cplot_comps(tmp,-.5,.5, ...
	'~/Documents/OSU/figures/air-sea/cm_comps/north_comp_oi_14_16_cm_a')	
	
%16_18_cm
load comps/comps_16_18_oi_cm

mask_maj=nan*north_16_18_oi_cm_c.N(r,c);
mask_min=nan*north_16_18_oi_cm_c.N(r,c);
mask_maj((north_16_18_oi_cm_c.N(r,c)./north_16_18_oi_cm_c.n_max_sample)>=.1)=1;
mask_min(north_16_18_oi_cm_c.N(r,c)>=10)=1;
tmp = double(north_16_18_oi_cm_c.mean(r,c).*mask_min);
N=north_16_18_oi_cm_a.N(r,c);
N_n_16_18_c=max(N(:))

%[t_noc,t_nsc,l_noc]=transect2(tmp,tmp2,100,-.6,.6);

cplot_comps(tmp,-.5,.5, ...
	'~/Documents/OSU/figures/air-sea/cm_comps/north_comp_oi_16_18_cm_c_bg')

tmp = double(north_16_18_oi_cm_c.mean(r,c).*mask_maj);

cplot_comps(tmp,-.5,.5, ...
	'~/Documents/OSU/figures/air-sea/cm_comps/north_comp_oi_16_18_cm_c')


mask_maj=nan*north_16_18_oi_cm_a.N(r,c);
mask_min=nan*north_16_18_oi_cm_a.N(r,c);
mask_maj((north_16_18_oi_cm_a.N(r,c)./north_16_18_oi_cm_a.n_max_sample)>=.1)=1;
mask_min(north_16_18_oi_cm_a.N(r,c)>=10)=1;
tmp = double(north_16_18_oi_cm_a.mean(r,c).*mask_min);
N=north_16_18_oi_cm_a.N(r,c);
N_n_16_18_a=max(N(:))

%[t_noa,t_nsa,l_noa]=transect2(tmp,tmp2,100,-.6,.6);

cplot_comps(tmp,-.5,.5, ...
	'~/Documents/OSU/figures/air-sea/cm_comps/north_comp_oi_16_18_cm_a_bg')

tmp = double(north_16_18_oi_cm_a.mean(r,c).*mask_maj);

cplot_comps(tmp,-.5,.5, ...
	'~/Documents/OSU/figures/air-sea/cm_comps/north_comp_oi_16_18_cm_a')	
	
%18_20_cm
load comps/comps_18_20_oi_cm

mask_maj=nan*north_18_20_oi_cm_c.N(r,c);
mask_min=nan*north_18_20_oi_cm_c.N(r,c);
mask_maj((north_18_20_oi_cm_c.N(r,c)./north_18_20_oi_cm_c.n_max_sample)>=.1)=1;
mask_min(north_18_20_oi_cm_c.N(r,c)>=10)=1;
tmp = double(north_18_20_oi_cm_c.mean(r,c).*mask_min);

%[t_noc,t_nsc,l_noc]=transect2(tmp,tmp2,100,-.6,.6);

cplot_comps(tmp,-.5,.5, ...
	'~/Documents/OSU/figures/air-sea/cm_comps/north_comp_oi_18_20_cm_c_bg')

tmp = double(north_18_20_oi_cm_c.mean(r,c).*mask_maj);

cplot_comps(tmp,-.5,.5, ...
	'~/Documents/OSU/figures/air-sea/cm_comps/north_comp_oi_18_20_cm_c')


mask_maj=nan*north_18_20_oi_cm_a.N(r,c);
mask_min=nan*north_18_20_oi_cm_a.N(r,c);
mask_maj((north_18_20_oi_cm_a.N(r,c)./north_18_20_oi_cm_a.n_max_sample)>=.1)=1;
mask_min(north_18_20_oi_cm_a.N(r,c)>=10)=1;
tmp = double(north_18_20_oi_cm_a.mean(r,c).*mask_min);

%[t_noa,t_nsa,l_noa]=transect2(tmp,tmp2,100,-.6,.6);

cplot_comps(tmp,-.5,.5, ...
	'~/Documents/OSU/figures/air-sea/cm_comps/north_comp_oi_18_20_cm_a_bg')

tmp = double(north_18_20_oi_cm_a.mean(r,c).*mask_maj);

cplot_comps(tmp,-.5,.5, ...
	'~/Documents/OSU/figures/air-sea/cm_comps/north_comp_oi_18_20_cm_a')	
	
%4_6_cm
load comps/comps_4_6_oi_cm

mask_maj=nan*south_4_6_oi_cm_c.N(r,c);
mask_min=nan*south_4_6_oi_cm_c.N(r,c);
mask_maj((south_4_6_oi_cm_c.N(r,c)./south_4_6_oi_cm_c.n_max_sample)>=.1)=1;
mask_min(south_4_6_oi_cm_c.N(r,c)>=10)=1;
tmp = double(south_4_6_oi_cm_c.mean(r,c).*mask_min);
N=south_4_6_oi_cm_c.N(r,c);
N_s_4_6_c=max(N(:))

%[t_noc,t_nsc,l_noc]=transect2(tmp,tmp2,100,-.6,.6);

cplot_comps(tmp,-.5,.5, ...
	'~/Documents/OSU/figures/air-sea/cm_comps/south_comp_oi_4_6_cm_c_bg')

tmp = double(south_4_6_oi_cm_c.mean(r,c).*mask_maj);

cplot_comps(tmp,-.5,.5, ...
	'~/Documents/OSU/figures/air-sea/cm_comps/south_comp_oi_4_6_cm_c')


mask_maj=nan*south_4_6_oi_cm_a.N(r,c);
mask_min=nan*south_4_6_oi_cm_a.N(r,c);
mask_maj((south_4_6_oi_cm_a.N(r,c)./south_4_6_oi_cm_a.n_max_sample)>=.1)=1;
mask_min(south_4_6_oi_cm_a.N(r,c)>=10)=1;
tmp = double(south_4_6_oi_cm_a.mean(r,c).*mask_min);
N=south_4_6_oi_cm_a.N(r,c);
N_s_4_6_a=max(N(:))

%[t_noa,t_nsa,l_noa]=transect2(tmp,tmp2,100,-.6,.6);

cplot_comps(tmp,-.5,.5, ...
	'~/Documents/OSU/figures/air-sea/cm_comps/south_comp_oi_4_6_cm_a_bg')

tmp = double(south_4_6_oi_cm_a.mean(r,c).*mask_maj);

cplot_comps(tmp,-.5,.5, ...
	'~/Documents/OSU/figures/air-sea/cm_comps/south_comp_oi_4_6_cm_a')
	
%6_8_cm
load comps/comps_6_8_oi_cm

mask_maj=nan*south_6_8_oi_cm_c.N(r,c);
mask_min=nan*south_6_8_oi_cm_c.N(r,c);
mask_maj((south_6_8_oi_cm_c.N(r,c)./south_6_8_oi_cm_c.n_max_sample)>=.1)=1;
mask_min(south_6_8_oi_cm_c.N(r,c)>=10)=1;
tmp = double(south_6_8_oi_cm_c.mean(r,c).*mask_min);
N=south_6_8_oi_cm_c.N(r,c);
N_s_6_8_c=max(N(:))

%[t_noc,t_nsc,l_noc]=transect2(tmp,tmp2,100,-.6,.6);

cplot_comps(tmp,-.5,.5, ...
	'~/Documents/OSU/figures/air-sea/cm_comps/south_comp_oi_6_8_cm_c_bg')

tmp = double(south_6_8_oi_cm_c.mean(r,c).*mask_maj);

cplot_comps(tmp,-.5,.5, ...
	'~/Documents/OSU/figures/air-sea/cm_comps/south_comp_oi_6_8_cm_c')


mask_maj=nan*south_6_8_oi_cm_a.N(r,c);
mask_min=nan*south_6_8_oi_cm_a.N(r,c);
mask_maj((south_6_8_oi_cm_a.N(r,c)./south_6_8_oi_cm_a.n_max_sample)>=.1)=1;
mask_min(south_6_8_oi_cm_a.N(r,c)>=10)=1;
tmp = double(south_6_8_oi_cm_a.mean(r,c).*mask_min);
N=south_6_8_oi_cm_a.N(r,c);
N_s_6_8_a=max(N(:))

%[t_noa,t_nsa,l_noa]=transect2(tmp,tmp2,100,-.6,.6);

cplot_comps(tmp,-.5,.5, ...
	'~/Documents/OSU/figures/air-sea/cm_comps/south_comp_oi_6_8_cm_a_bg')

tmp = double(south_6_8_oi_cm_a.mean(r,c).*mask_maj);

cplot_comps(tmp,-.5,.5, ...
	'~/Documents/OSU/figures/air-sea/cm_comps/south_comp_oi_6_8_cm_a')	
	
	
%8_10_cm
load comps/comps_8_10_oi_cm

mask_maj=nan*south_8_10_oi_cm_c.N(r,c);
mask_min=nan*south_8_10_oi_cm_c.N(r,c);
mask_maj((south_8_10_oi_cm_c.N(r,c)./south_8_10_oi_cm_c.n_max_sample)>=.1)=1;
mask_min(south_8_10_oi_cm_c.N(r,c)>=10)=1;
tmp = double(south_8_10_oi_cm_c.mean(r,c).*mask_min);
N=south_8_10_oi_cm_c.N(r,c);
N_s_8_10_c=max(N(:))

%[t_noc,t_nsc,l_noc]=transect2(tmp,tmp2,100,-.6,.6);

cplot_comps(tmp,-.5,.5, ...
	'~/Documents/OSU/figures/air-sea/cm_comps/south_comp_oi_8_10_cm_c_bg')

tmp = double(south_8_10_oi_cm_c.mean(r,c).*mask_maj);

cplot_comps(tmp,-.5,.5, ...
	'~/Documents/OSU/figures/air-sea/cm_comps/south_comp_oi_8_10_cm_c')


mask_maj=nan*south_8_10_oi_cm_a.N(r,c);
mask_min=nan*south_8_10_oi_cm_a.N(r,c);
mask_maj((south_8_10_oi_cm_a.N(r,c)./south_8_10_oi_cm_a.n_max_sample)>=.1)=1;
mask_min(south_8_10_oi_cm_a.N(r,c)>=10)=1;
tmp = double(south_8_10_oi_cm_a.mean(r,c).*mask_min);
N=south_8_10_oi_cm_a.N(r,c);
N_s_8_10_a=max(N(:))

%[t_noa,t_nsa,l_noa]=transect2(tmp,tmp2,100,-.6,.6);

cplot_comps(tmp,-.5,.5, ...
	'~/Documents/OSU/figures/air-sea/cm_comps/south_comp_oi_8_10_cm_a_bg')

tmp = double(south_8_10_oi_cm_a.mean(r,c).*mask_maj);

cplot_comps(tmp,-.5,.5, ...
	'~/Documents/OSU/figures/air-sea/cm_comps/south_comp_oi_8_10_cm_a')
	
%10_12_cm
load comps/comps_10_12_oi_cm

mask_maj=nan*south_10_12_oi_cm_c.N(r,c);
mask_min=nan*south_10_12_oi_cm_c.N(r,c);
mask_maj((south_10_12_oi_cm_c.N(r,c)./south_10_12_oi_cm_c.n_max_sample)>=.1)=1;
mask_min(south_10_12_oi_cm_c.N(r,c)>=10)=1;
tmp = double(south_10_12_oi_cm_c.mean(r,c).*mask_min);
N=south_10_12_oi_cm_c.N(r,c);
N_s_10_12_c=max(N(:))

%[t_noc,t_nsc,l_noc]=transect2(tmp,tmp2,100,-.6,.6);

cplot_comps(tmp,-.5,.5, ...
	'~/Documents/OSU/figures/air-sea/cm_comps/south_comp_oi_10_12_cm_c_bg')

tmp = double(south_10_12_oi_cm_c.mean(r,c).*mask_maj);

cplot_comps(tmp,-.5,.5, ...
	'~/Documents/OSU/figures/air-sea/cm_comps/south_comp_oi_10_12_cm_c')


mask_maj=nan*south_10_12_oi_cm_a.N(r,c);
mask_min=nan*south_10_12_oi_cm_a.N(r,c);
mask_maj((south_10_12_oi_cm_a.N(r,c)./south_10_12_oi_cm_a.n_max_sample)>=.1)=1;
mask_min(south_10_12_oi_cm_a.N(r,c)>=10)=1;
tmp = double(south_10_12_oi_cm_a.mean(r,c).*mask_min);
N=south_10_12_oi_cm_a.N(r,c);
N_s_10_12_a=max(N(:))

%[t_noa,t_nsa,l_noa]=transect2(tmp,tmp2,100,-.6,.6);

cplot_comps(tmp,-.5,.5, ...
	'~/Documents/OSU/figures/air-sea/cm_comps/south_comp_oi_10_12_cm_a_bg')

tmp = double(south_10_12_oi_cm_a.mean(r,c).*mask_maj);

cplot_comps(tmp,-.5,.5, ...
	'~/Documents/OSU/figures/air-sea/cm_comps/south_comp_oi_10_12_cm_a')
	
%12_14_cm
load comps/comps_12_14_oi_cm

mask_maj=nan*south_12_14_oi_cm_c.N(r,c);
mask_min=nan*south_12_14_oi_cm_c.N(r,c);
mask_maj((south_12_14_oi_cm_c.N(r,c)./south_12_14_oi_cm_c.n_max_sample)>=.1)=1;
mask_min(south_12_14_oi_cm_c.N(r,c)>=10)=1;
tmp = double(south_12_14_oi_cm_c.mean(r,c).*mask_min);
N=south_12_14_oi_cm_c.N(r,c);
N_s_12_14_c=max(N(:))

%[t_noc,t_nsc,l_noc]=transect2(tmp,tmp2,100,-.6,.6);

cplot_comps(tmp,-.5,.5, ...
	'~/Documents/OSU/figures/air-sea/cm_comps/south_comp_oi_12_14_cm_c_bg')

tmp = double(south_12_14_oi_cm_c.mean(r,c).*mask_maj);

cplot_comps(tmp,-.5,.5, ...
	'~/Documents/OSU/figures/air-sea/cm_comps/south_comp_oi_12_14_cm_c')


mask_maj=nan*south_12_14_oi_cm_a.N(r,c);
mask_min=nan*south_12_14_oi_cm_a.N(r,c);
mask_maj((south_12_14_oi_cm_a.N(r,c)./south_12_14_oi_cm_a.n_max_sample)>=.1)=1;
mask_min(south_12_14_oi_cm_a.N(r,c)>=10)=1;
tmp = double(south_12_14_oi_cm_a.mean(r,c).*mask_min);
N=south_12_14_oi_cm_a.N(r,c);
N_s_12_14_a=max(N(:))

%[t_noa,t_nsa,l_noa]=transect2(tmp,tmp2,100,-.6,.6);

cplot_comps(tmp,-.5,.5, ...
	'~/Documents/OSU/figures/air-sea/cm_comps/south_comp_oi_12_14_cm_a_bg')

tmp = double(south_12_14_oi_cm_a.mean(r,c).*mask_maj);

cplot_comps(tmp,-.5,.5, ...
	'~/Documents/OSU/figures/air-sea/cm_comps/south_comp_oi_12_14_cm_a')	
	
%14_16_cm
load comps/comps_14_16_oi_cm

mask_maj=nan*south_14_16_oi_cm_c.N(r,c);
mask_min=nan*south_14_16_oi_cm_c.N(r,c);
mask_maj((south_14_16_oi_cm_c.N(r,c)./south_14_16_oi_cm_c.n_max_sample)>=.1)=1;
mask_min(south_14_16_oi_cm_c.N(r,c)>=10)=1;
tmp = double(south_14_16_oi_cm_c.mean(r,c).*mask_min);
N=south_14_16_oi_cm_c.N(r,c);
N_s_14_16_c=max(N(:))

%[t_noc,t_nsc,l_noc]=transect2(tmp,tmp2,100,-.6,.6);

cplot_comps(tmp,-.5,.5, ...
	'~/Documents/OSU/figures/air-sea/cm_comps/south_comp_oi_14_16_cm_c_bg')

tmp = double(south_14_16_oi_cm_c.mean(r,c).*mask_maj);

cplot_comps(tmp,-.5,.5, ...
	'~/Documents/OSU/figures/air-sea/cm_comps/south_comp_oi_14_16_cm_c')


mask_maj=nan*south_14_16_oi_cm_a.N(r,c);
mask_min=nan*south_14_16_oi_cm_a.N(r,c);
mask_maj((south_14_16_oi_cm_a.N(r,c)./south_14_16_oi_cm_a.n_max_sample)>=.1)=1;
mask_min(south_14_16_oi_cm_a.N(r,c)>=10)=1;
tmp = double(south_14_16_oi_cm_a.mean(r,c).*mask_min);
N=south_14_16_oi_cm_a.N(r,c);
N_s_14_16_a=max(N(:))

%[t_noa,t_nsa,l_noa]=transect2(tmp,tmp2,100,-.6,.6);

cplot_comps(tmp,-.5,.5, ...
	'~/Documents/OSU/figures/air-sea/cm_comps/south_comp_oi_14_16_cm_a_bg')

tmp = double(south_14_16_oi_cm_a.mean(r,c).*mask_maj);

cplot_comps(tmp,-.5,.5, ...
	'~/Documents/OSU/figures/air-sea/cm_comps/south_comp_oi_14_16_cm_a')	
	
%16_18_cm
load comps/comps_16_18_oi_cm

mask_maj=nan*south_16_18_oi_cm_c.N(r,c);
mask_min=nan*south_16_18_oi_cm_c.N(r,c);
mask_maj((south_16_18_oi_cm_c.N(r,c)./south_16_18_oi_cm_c.n_max_sample)>=.1)=1;
mask_min(south_16_18_oi_cm_c.N(r,c)>=10)=1;
tmp = double(south_16_18_oi_cm_c.mean(r,c).*mask_min);
N=south_16_18_oi_cm_c.N(r,c);
N_s_16_18_c=max(N(:))

%[t_noc,t_nsc,l_noc]=transect2(tmp,tmp2,100,-.6,.6);

cplot_comps(tmp,-.5,.5, ...
	'~/Documents/OSU/figures/air-sea/cm_comps/south_comp_oi_16_18_cm_c_bg')

tmp = double(south_16_18_oi_cm_c.mean(r,c).*mask_maj);

cplot_comps(tmp,-.5,.5, ...
	'~/Documents/OSU/figures/air-sea/cm_comps/south_comp_oi_16_18_cm_c')


mask_maj=nan*south_16_18_oi_cm_a.N(r,c);
mask_min=nan*south_16_18_oi_cm_a.N(r,c);
mask_maj((south_16_18_oi_cm_a.N(r,c)./south_16_18_oi_cm_a.n_max_sample)>=.1)=1;
mask_min(south_16_18_oi_cm_a.N(r,c)>=10)=1;
tmp = double(south_16_18_oi_cm_a.mean(r,c).*mask_min);
N=south_16_18_oi_cm_a.N(r,c);
N_s_16_18_a=max(N(:))

%[t_noa,t_nsa,l_noa]=transect2(tmp,tmp2,100,-.6,.6);

cplot_comps(tmp,-.5,.5, ...
	'~/Documents/OSU/figures/air-sea/cm_comps/south_comp_oi_16_18_cm_a_bg')

tmp = double(south_16_18_oi_cm_a.mean(r,c).*mask_maj);

cplot_comps(tmp,-.5,.5, ...
	'~/Documents/OSU/figures/air-sea/cm_comps/south_comp_oi_16_18_cm_a')	
	
%18_20_cm
load comps/comps_18_20_oi_cm

mask_maj=nan*south_18_20_oi_cm_c.N(r,c);
mask_min=nan*south_18_20_oi_cm_c.N(r,c);
mask_maj((south_18_20_oi_cm_c.N(r,c)./south_18_20_oi_cm_c.n_max_sample)>=.1)=1;
mask_min(south_18_20_oi_cm_c.N(r,c)>=10)=1;
tmp = double(south_18_20_oi_cm_c.mean(r,c).*mask_min);

%[t_noc,t_nsc,l_noc]=transect2(tmp,tmp2,100,-.6,.6);

cplot_comps(tmp,-.5,.5, ...
	'~/Documents/OSU/figures/air-sea/cm_comps/south_comp_oi_18_20_cm_c_bg')

tmp = double(south_18_20_oi_cm_c.mean(r,c).*mask_maj);

cplot_comps(tmp,-.5,.5, ...
	'~/Documents/OSU/figures/air-sea/cm_comps/south_comp_oi_18_20_cm_c')


mask_maj=nan*south_18_20_oi_cm_a.N(r,c);
mask_min=nan*south_18_20_oi_cm_a.N(r,c);
mask_maj((south_18_20_oi_cm_a.N(r,c)./south_18_20_oi_cm_a.n_max_sample)>=.1)=1;
mask_min(south_18_20_oi_cm_a.N(r,c)>=10)=1;
tmp = double(south_18_20_oi_cm_a.mean(r,c).*mask_min);

%[t_noa,t_nsa,l_noa]=transect2(tmp,tmp2,100,-.6,.6);

cplot_comps(tmp,-.5,.5, ...
	'~/Documents/OSU/figures/air-sea/cm_comps/south_comp_oi_18_20_cm_a_bg')

tmp = double(south_18_20_oi_cm_a.mean(r,c).*mask_maj);

cplot_comps(tmp,-.5,.5, ...
	'~/Documents/OSU/figures/air-sea/cm_comps/south_comp_oi_18_20_cm_a')		