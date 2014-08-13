clear all

load comps/norm_comps_16_weeks.mat
zgrid_grid
[r,c]=imap(-3,3,-3,3,yi,xi);
xi=xi(r,c);
yi=yi(r,c);
dist=sqrt(xi.^2+yi.^2);
ii=find(dist<=1.6);

trap=north_trap_c.per_cov(r,c).*100;
mask_maj=nan*north_foi_c.N(r,c);
mask_min=nan*north_foi_c.N(r,c);
mask_maj(ii)=1;
mask_min((north_foi_c.N(r,c)./north_foi_c.n_max_sample)>=.1)=1;
tmp = double(north_foi_c.mean(r,c).*mask_min);

%[t_noc,t_nsc,l_noc]=transect2(tmp,tmp2,100,-.6,.6);

cplot_comps_3_3(tmp,-.3,.3, ...
	'~/Documents/OSU/figures/air-sea/comps/north_norm_comp_foi_c_bg')

tmp = double(north_foi_c.mean(r,c).*mask_maj);

cplot_comps_3_3(tmp,-.3,.3, ...
	'~/Documents/OSU/figures/air-sea/comps/north_norm_comp_foi_c')
	
mask_min=nan*north_spd_c.N(r,c);
mask_min((north_spd_c.N(r,c)./north_spd_c.n_max_sample)>=.1)=1;
tmp = double(north_spd_c.mean(r,c).*mask_min);


%[t_noc,t_nsc,l_noc]=transect2(tmp,tmp2,100,-.6,.6);

cplot_comps_3_3(tmp,-.3,.3, ...
	'~/Documents/OSU/figures/air-sea/comps/north_norm_comp_spd_c_bg')

tmp = double(north_spd_c.mean(r,c).*mask_maj);

cplot_comps_3_3(tmp,-.3,.3, ...
	'~/Documents/OSU/figures/air-sea/comps/north_norm_comp_spd_c')
	
mask_min=nan*north_spd_21_c.N(r,c);
mask_min((north_spd_21_c.N(r,c)./north_spd_21_c.n_max_sample)>=.1)=1;
tmp = double(north_spd_21_c.mean(r,c).*mask_min);

%[t_noc,t_nsc,l_noc]=transect2(tmp,tmp2,100,-.6,.6);

cplot_comps_3_3(tmp,-.3,.3, ...
	'~/Documents/OSU/figures/air-sea/comps/north_norm_comp_spd_21_c_bg')

tmp = double(north_spd_21_c.mean(r,c).*mask_maj);

cplot_comps_3_3(tmp,-.3,.3, ...
	'~/Documents/OSU/figures/air-sea/comps/north_norm_comp_spd_21_c')

mask_min=nan*north_oi_c.N(r,c);
mask_min((north_oi_c.N(r,c)./north_oi_c.n_max_sample)>=.1)=1;
tmp = double(north_oi_c.mean(r,c).*mask_min);


%[t_noc,t_nsc,l_noc]=transect2(tmp,tmp2,100,-.6,.6);

cplot_comps_3_3_pos_scale(tmp,21.5,22.5, ...
	'~/Documents/OSU/figures/air-sea/comps/north_norm_comp_oi_c_bg')

tmp = double(north_oi_c.mean(r,c).*mask_maj);

cplot_comps_3_3_pos_scale(tmp,21.5,22.5, ...
	'~/Documents/OSU/figures/air-sea/comps/north_norm_comp_oi_c')	
	
mask_min=nan*north_crl_c.N(r,c);
mask_min((north_crl_c.N(r,c)./north_crl_c.n_max_sample)>=.1)=1;
tmp = double(north_crl_c.mean(r,c).*mask_min);
tmp =interp2(tmp,2);

%[t_noc,t_nsc,l_noc]=transect2(tmp,tmp2,100,-.6,.6);

cplot_comps_3_3(tmp.*1e5,-.25,.25, ...
	'~/Documents/OSU/figures/air-sea/comps/north_norm_comp_crl_c_bg')

tmp = double(north_crl_c.mean(r,c).*mask_maj);
tmp =interp2(tmp,2);
cplot_comps_3_3(tmp.*1e5,-.25,.25, ...
	'~/Documents/OSU/figures/air-sea/comps/north_norm_comp_crl_c')	
	
mask_min=nan*north_crlg_c.N(r,c);
mask_min((north_crlg_c.N(r,c)./north_crlg_c.n_max_sample)>=.1)=1;
tmp = double(north_crlg_c.mean(r,c).*mask_min);
tmp =interp2(tmp,2);

%[t_noc,t_nsc,l_noc]=transect2(tmp,tmp2,100,-.6,.6);

cplot_comps_3_3(tmp.*1e5,-.5,.5, ...
	'~/Documents/OSU/figures/air-sea/comps/north_norm_comp_crlg_c_bg')

tmp = double(north_crlg_c.mean(r,c).*mask_maj);
tmp =interp2(tmp,2);
cplot_comps_3_3(tmp.*1e5,-.5,.5, ...
	'~/Documents/OSU/figures/air-sea/comps/north_norm_comp_crlg_c')		
	
%{
mask_min=nan*north_gradt_c.N(r,c);
mask_min((north_gradt_c.N(r,c)./north_gradt_c.n_max_sample)>=.1)=1;
tmp = double(north_gradt_c.mean(r,c).*mask_min);

%[t_noc,t_nsc,l_noc]=transect2(tmp,tmp2,100,-.6,.6);

cplot_comps_cont_pos_scale_chelle_3_3(tmp,trap,0.5,1,5,75,100, ...
	'~/Documents/OSU/figures/air-sea/comps/north_norm_comp_gradt_c_bg')

tmp = double(north_gradt_c.mean(r,c).*mask_maj);

cplot_comps_cont_pos_scale_chelle_3_3(tmp,trap,0.5,1,5,75,100, ...
	'~/Documents/OSU/figures/air-sea/comps/north_norm_comp_gradt_c')
%}

trap=north_trap_a.per_cov(r,c).*100;
mask_min=nan*north_foi_a.N(r,c);
mask_min((north_foi_a.N(r,c)./north_foi_a.n_max_sample)>=.1)=1;
tmp = double(north_foi_a.mean(r,c).*mask_min);

%[t_noa,t_nsa,l_noa]=transect2(tmp,tmp2,100,-.6,.6);

cplot_comps_3_3(tmp,-.3,.3, ...
	'~/Documents/OSU/figures/air-sea/comps/north_norm_comp_foi_a_bg')

tmp = double(north_foi_a.mean(r,c).*mask_maj);

cplot_comps_3_3(tmp,-.3,.3, ...
	'~/Documents/OSU/figures/air-sea/comps/north_norm_comp_foi_a')
	
mask_min=nan*north_spd_a.N(r,c);
mask_min((north_spd_a.N(r,c)./north_spd_a.n_max_sample)>=.1)=1;
tmp = double(north_spd_a.mean(r,c).*mask_min);

%[t_noa,t_nsa,l_noa]=transect2(tmp,tmp2,100,-.6,.6);

cplot_comps_3_3(tmp,-.3,.3, ...
	'~/Documents/OSU/figures/air-sea/comps/north_norm_comp_spd_a_bg')

tmp = double(north_spd_a.mean(r,c).*mask_maj);

cplot_comps_3_3(tmp,-.3,.3, ...
	'~/Documents/OSU/figures/air-sea/comps/north_norm_comp_spd_a')	
	
mask_min=nan*north_spd_21_a.N(r,c);
mask_min((north_spd_21_a.N(r,c)./north_spd_21_a.n_max_sample)>=.1)=1;
tmp = double(north_spd_21_a.mean(r,c).*mask_min);

%[t_noa,t_nsa,l_noa]=transect2(tmp,tmp2,100,-.6,.6);

cplot_comps_3_3(tmp,-.3,.3, ...
	'~/Documents/OSU/figures/air-sea/comps/north_norm_comp_spd_21_a_bg')

tmp = double(north_spd_21_a.mean(r,c).*mask_maj);

cplot_comps_3_3(tmp,-.3,.3, ...
	'~/Documents/OSU/figures/air-sea/comps/north_norm_comp_21_spd_a')		
	
mask_min=nan*north_oi_a.N(r,c);
mask_min((north_oi_a.N(r,c)./north_oi_a.n_max_sample)>=.1)=1;
tmp = double(north_oi_a.mean(r,c).*mask_min);

%[t_noc,t_nsc,l_noc]=transect2(tmp,tmp2,100,-.6,.6);

cplot_comps_3_3_pos_scale(tmp,21.5,22.5, ...
	'~/Documents/OSU/figures/air-sea/comps/north_norm_comp_oi_a_bg')

tmp = double(north_oi_a.mean(r,c).*mask_maj);

cplot_comps_3_3_pos_scale(tmp,21.5,22.5, ...
	'~/Documents/OSU/figures/air-sea/comps/north_norm_comp_oi_a')	
	
mask_min=nan*north_crl_a.N(r,c);
mask_min((north_crl_a.N(r,c)./north_crl_a.n_max_sample)>=.1)=1;
tmp = double(north_crl_a.mean(r,c).*mask_min);
tmp =interp2(tmp,2);

%[t_noc,t_nsc,l_noc]=transect2(tmp,tmp2,100,-.6,.6);

cplot_comps_3_3(tmp.*1e5,-.25,.25, ...
	'~/Documents/OSU/figures/air-sea/comps/north_norm_comp_crl_a_bg')

tmp = double(north_crl_a.mean(r,c).*mask_maj);
tmp =interp2(tmp,2);
cplot_comps_3_3(tmp.*1e5,-.25,.25, ...
	'~/Documents/OSU/figures/air-sea/comps/north_norm_comp_crl_a')	
	
mask_min=nan*north_crlg_a.N(r,c);
mask_min((north_crlg_a.N(r,c)./north_crlg_a.n_max_sample)>=.1)=1;
tmp = double(north_crlg_a.mean(r,c).*mask_min);
tmp =interp2(tmp,2);

%[t_noc,t_nsc,l_noc]=transect2(tmp,tmp2,100,-.6,.6);

cplot_comps_3_3(tmp.*1e5,-.5,.5, ...
	'~/Documents/OSU/figures/air-sea/comps/north_norm_comp_crlg_a_bg')

tmp = double(north_crlg_a.mean(r,c).*mask_maj);
tmp =interp2(tmp,2);
cplot_comps_3_3(tmp.*1e5,-.5,.5, ...
	'~/Documents/OSU/figures/air-sea/comps/north_norm_comp_crlg_a')	
	
%{
mask_min=nan*north_gradt_a.N(r,c);
mask_min((north_gradt_a.N(r,c)./north_gradt_a.n_max_sample)>=.1)=1;
tmp = double(north_gradt_a.mean(r,c).*mask_min);

%[t_noc,t_nsc,l_noc]=transect2(tmp,tmp2,100,-.6,.6);

cplot_comps_cont_pos_scale_chelle_3_3(tmp,trap,0.5,1,5,75,100, ...
	'~/Documents/OSU/figures/air-sea/comps/north_norm_comp_gradt_a_bg')

tmp = double(north_gradt_a.mean(r,c).*mask_maj);

cplot_comps_cont_pos_scale_chelle_3_3(tmp,trap,0.5,1,5,75,100, ...
	'~/Documents/OSU/figures/air-sea/comps/north_norm_comp_gradt_a')	
	
%}
trap=south_trap_c.per_cov(r,c).*100;
mask_min=nan*south_foi_c.N(r,c);
mask_min((south_foi_c.N(r,c)./south_foi_c.n_max_sample)>=.1)=1;
tmp = double(south_foi_c.mean(r,c).*mask_min);

%[t_noc,t_nsc,l_noc]=transect2(tmp,tmp2,100,-.6,.6);

cplot_comps_3_3(tmp,-.3,.3, ...
	'~/Documents/OSU/figures/air-sea/comps/south_norm_comp_foi_c_bg')

tmp = double(south_foi_c.mean(r,c).*mask_maj);

cplot_comps_3_3(tmp,-.3,.3, ...
	'~/Documents/OSU/figures/air-sea/comps/south_norm_comp_foi_c')
	
mask_min=nan*south_spd_c.N(r,c);
mask_min((south_spd_c.N(r,c)./south_spd_c.n_max_sample)>=.1)=1;
tmp = double(south_spd_c.mean(r,c).*mask_min);

%[t_noc,t_nsc,l_noc]=transect2(tmp,tmp2,100,-.6,.6);

cplot_comps_3_3(tmp,-.3,.3, ...
	'~/Documents/OSU/figures/air-sea/comps/south_norm_comp_spd_c_bg')

tmp = double(south_spd_c.mean(r,c).*mask_maj);

cplot_comps_3_3(tmp,-.3,.3, ...
	'~/Documents/OSU/figures/air-sea/comps/south_norm_comp_spd_c')
mask_min=nan*south_spd_21_c.N(r,c);
mask_min((south_spd_21_c.N(r,c)./south_spd_21_c.n_max_sample)>=.1)=1;
tmp = double(south_spd_21_c.mean(r,c).*mask_min);

%[t_noc,t_nsc,l_noc]=transect2(tmp,tmp2,100,-.6,.6);

cplot_comps_3_3(tmp,-.3,.3, ...
	'~/Documents/OSU/figures/air-sea/comps/south_norm_comp_spd_21_c_bg')

tmp = double(south_spd_21_c.mean(r,c).*mask_maj);

cplot_comps_3_3(tmp,-.3,.3, ...
	'~/Documents/OSU/figures/air-sea/comps/south_norm_comp_spd_21_c')	

mask_min=nan*south_oi_c.N(r,c);
mask_min((south_oi_c.N(r,c)./south_oi_c.n_max_sample)>=.1)=1;
tmp = double(south_oi_c.mean(r,c).*mask_min);

%[t_noc,t_nsc,l_noc]=transect2(tmp,tmp2,100,-.6,.6);

cplot_comps_3_3_pos_scale(tmp,18.5,19.5, ...
	'~/Documents/OSU/figures/air-sea/comps/south_norm_comp_oi_c_bg')

tmp = double(south_oi_c.mean(r,c).*mask_maj);

cplot_comps_3_3_pos_scale(tmp,18.5,19.5, ...
	'~/Documents/OSU/figures/air-sea/comps/south_norm_comp_oi_c')	
	
	
mask_min=nan*south_crl_c.N(r,c);
mask_min((south_crl_c.N(r,c)./south_crl_c.n_max_sample)>=.1)=1;
tmp = double(south_crl_c.mean(r,c).*mask_min);
tmp =interp2(tmp,2);

%[t_noc,t_nsc,l_noc]=transect2(tmp,tmp2,100,-.6,.6);

cplot_comps_3_3(tmp.*1e5,-.25,.25, ...
	'~/Documents/OSU/figures/air-sea/comps/south_norm_comp_crl_c_bg')

tmp = double(south_crl_c.mean(r,c).*mask_maj);
tmp =interp2(tmp,2);
cplot_comps_3_3(tmp.*1e5,-.25,.25, ...
	'~/Documents/OSU/figures/air-sea/comps/south_norm_comp_crl_c')	
	
mask_min=nan*south_crlg_c.N(r,c);
mask_min((south_crlg_c.N(r,c)./south_crlg_c.n_max_sample)>=.1)=1;
tmp = double(south_crlg_c.mean(r,c).*mask_min);
tmp =interp2(tmp,2);

%[t_noc,t_nsc,l_noc]=transect2(tmp,tmp2,100,-.6,.6);

cplot_comps_3_3(tmp.*1e5,-.5,.5, ...
	'~/Documents/OSU/figures/air-sea/comps/south_norm_comp_crlg_c_bg')

tmp = double(south_crlg_c.mean(r,c).*mask_maj);
tmp =interp2(tmp,2);
cplot_comps_3_3(tmp.*1e5,-.5,.5, ...
	'~/Documents/OSU/figures/air-sea/comps/south_norm_comp_crlg_c')	
	
%{
mask_min=nan*south_gradt_c.N(r,c);
mask_min((south_gradt_c.N(r,c)./south_gradt_c.n_max_sample)>=.1)=1;
tmp = double(south_gradt_c.mean(r,c).*mask_min);

%[t_noc,t_nsc,l_noc]=transect2(tmp,tmp2,100,-.6,.6);

cplot_comps_cont_pos_scale_chelle_3_3(tmp,trap,0.5,1,5,75,100, ...
	'~/Documents/OSU/figures/air-sea/comps/south_norm_comp_gradt_c_bg')

tmp = double(south_gradt_c.mean(r,c).*mask_maj);

cplot_comps_cont_pos_scale_chelle_3_3(tmp,trap,0.5,1,5,75,100, ...
	'~/Documents/OSU/figures/air-sea/comps/south_norm_comp_gradt_c')	

%}

trap=south_trap_a.per_cov(r,c).*100;
mask_min=nan*south_foi_a.N(r,c);
mask_min((south_foi_a.N(r,c)./south_foi_a.n_max_sample)>=.1)=1;
tmp = double(south_foi_a.mean(r,c).*mask_min);

%[t_noa,t_nsa,l_noa]=transect2(tmp,tmp2,100,-.6,.6);

cplot_comps_3_3(tmp,-.3,.3, ...
	'~/Documents/OSU/figures/air-sea/comps/south_norm_comp_foi_a_bg')

tmp = double(south_foi_a.mean(r,c).*mask_maj);

cplot_comps_3_3(tmp,-.3,.3, ...
	'~/Documents/OSU/figures/air-sea/comps/south_norm_comp_foi_a')
	
mask_min=nan*south_spd_a.N(r,c);
mask_min((south_spd_a.N(r,c)./south_spd_a.n_max_sample)>=.1)=1;
tmp = double(south_spd_a.mean(r,c).*mask_min);

%[t_noa,t_nsa,l_noa]=transect2(tmp,tmp2,100,-.6,.6);

cplot_comps_3_3(tmp,-.3,.3, ...
	'~/Documents/OSU/figures/air-sea/comps/south_norm_comp_spd_a_bg')

tmp = double(south_spd_a.mean(r,c).*mask_maj);

cplot_comps_3_3(tmp,-.3,.3, ...
	'~/Documents/OSU/figures/air-sea/comps/south_norm_comp_spd_a')

mask_min=nan*south_spd_21_a.N(r,c);
mask_min((south_spd_21_a.N(r,c)./south_spd_21_a.n_max_sample)>=.1)=1;
tmp = double(south_spd_21_a.mean(r,c).*mask_min);

%[t_noa,t_nsa,l_noa]=transect2(tmp,tmp2,100,-.6,.6);

cplot_comps_3_3(tmp,-.3,.3, ...
	'~/Documents/OSU/figures/air-sea/comps/south_norm_comp_spd_21_a_bg')

tmp = double(south_spd_21_a.mean(r,c).*mask_maj);

cplot_comps_3_3(tmp,-.3,.3, ...
	'~/Documents/OSU/figures/air-sea/comps/south_norm_comp_spd_21_a')

mask_min=nan*south_oi_a.N(r,c);
mask_min((south_oi_a.N(r,c)./south_oi_a.n_max_sample)>=.1)=1;
tmp = double(south_oi_a.mean(r,c).*mask_min);

%[t_noc,t_nsc,l_noc]=transect2(tmp,tmp2,100,-.6,.6);

cplot_comps_3_3_pos_scale(tmp,18.5,29.5, ...
	'~/Documents/OSU/figures/air-sea/comps/south_norm_comp_oi_a_bg')

tmp = double(south_oi_a.mean(r,c).*mask_maj);

cplot_comps_3_3_pos_scale(tmp,18.5,29.5, ...
	'~/Documents/OSU/figures/air-sea/comps/south_norm_comp_oi_a')	
	
	
mask_min=nan*south_crl_a.N(r,c);
mask_min((south_crl_a.N(r,c)./south_crl_a.n_max_sample)>=.1)=1;
tmp = double(south_crl_a.mean(r,c).*mask_min);
tmp =interp2(tmp,2);

%[t_noc,t_nsc,l_noc]=transect2(tmp,tmp2,100,-.6,.6);

cplot_comps_3_3(tmp.*1e5,-.25,.25, ...
	'~/Documents/OSU/figures/air-sea/comps/south_norm_comp_crl_a_bg')

tmp = double(south_crl_a.mean(r,c).*mask_maj);
tmp =interp2(tmp,2);
cplot_comps_3_3(tmp.*1e5,-.25,.25, ...
	'~/Documents/OSU/figures/air-sea/comps/south_norm_comp_crl_a')	
	
mask_min=nan*south_crlg_a.N(r,c);
mask_min((south_crlg_a.N(r,c)./south_crlg_a.n_max_sample)>=.1)=1;
tmp = double(south_crlg_a.mean(r,c).*mask_min);
tmp =interp2(tmp,2);

%[t_noc,t_nsc,l_noc]=transect2(tmp,tmp2,100,-.6,.6);

cplot_comps_3_3(tmp.*1e5,-.5,.5, ...
	'~/Documents/OSU/figures/air-sea/comps/south_norm_comp_crlg_a_bg')

tmp = double(south_crlg_a.mean(r,c).*mask_maj);
tmp =interp2(tmp,2);
cplot_comps_3_3(tmp.*1e5,-.5,.5, ...
	'~/Documents/OSU/figures/air-sea/comps/south_norm_comp_crlg_a')	
	
	
	return

mask_min=nan*south_gradt_a.N(r,c);
mask_min((south_gradt_a.N(r,c)./south_gradt_a.n_max_sample)>=.1)=1;
tmp = double(south_gradt_a.mean(r,c).*mask_min);

%[t_noc,t_nsc,l_noc]=transect2(tmp,tmp2,100,-.6,.6);

cplot_comps_cont_pos_scale_chelle_3_3(tmp,trap,0.5,1,5,75,100, ...
	'~/Documents/OSU/figures/air-sea/comps/south_norm_comp_gradt_a_bg')

tmp = double(south_gradt_a.mean(r,c).*mask_maj);

cplot_comps_cont_pos_scale_chelle_3_3(tmp,trap,0.5,1,5,75,100, ...
	'~/Documents/OSU/figures/air-sea/comps/south_norm_comp_gradt_a')