clear all

load comps_wind_sst_N_S

mask_maj=nan*north_rnfoi_c.N(r,c);
mask_min=nan*north_rnfoi_c.N(r,c);
mask_maj((north_rnfoi_c.N(r,c)./north_rnfoi_c.n_max_sample)>=.1)=1;
mask_min(north_rnfoi_c.N(r,c)>=100)=1;
tmp = double(north_rnfoi_c.mean(r,c).*mask_min);

mask_maj2=nan*north_rncrl_c.N(r,c);
mask_min2=nan*north_rncrl_c.N(r,c);
mask_maj2((north_rncrl_c.N(r,c)./north_rncrl_c.n_max_sample)>=.1)=1;
mask_min2(north_rncrl_c.N(r,c)>=100)=1;
tmp2 = double(north_rncrl_c.mean(r,c).*mask_min2.*1e6);

mask_maj3=nan*north_rndiv_c.N(r,c);
mask_min3=nan*north_rndiv_c.N(r,c);
mask_maj3((north_rndiv_c.N(r,c)./north_rndiv_c.n_max_sample)>=.1)=1;
mask_min3(north_rndiv_c.N(r,c)>=100)=1;
tmp3 = double(north_rndiv_c.mean(r,c).*mask_min3.*1e6);

cplot_comps(tmp,-.5,.5, ...
	'~/Documents/OSU/figures/south/north_comp_rnfoi_c_bg')
cplot_comps(tmp2,-5,5, ...
	'~/Documents/OSU/figures/south/north_comp_rncrl_c_bg')	
cplot_comps(tmp3,-3,3, ...
	'~/Documents/OSU/figures/south/north_comp_rndiv_c_bg')	

tmp = double(north_rnfoi_c.mean(r,c).*mask_maj);
tmp2 = double(north_rncrl_c.mean(r,c).*mask_maj2.*1e6);
tmp3 = double(north_rndiv_c.mean(r,c).*mask_maj3.*1e6);

cplot_comps_cont_line(tmp,tmp,l_noc(1,:),l_noc(2,:),-.5,.5,-.35, ...
	'~/Documents/OSU/figures/south/north_comp_rnfoi_c')
cplot_comps_cont_line(tmp2,tmp,l_noc(1,:),l_noc(2,:),-5,5,-.35, ...
	'~/Documents/OSU/figures/south/north_comp_rncrl_c')	
cplot_comps_cont_line(tmp3,tmp,l_noc(1,:),l_noc(2,:),-3,3,-.35, ...
	'~/Documents/OSU/figures/south/north_comp_rndiv_c')	

mask_maj=nan*north_rnfoi_a.N(r,c);
mask_min=nan*north_rnfoi_a.N(r,c);
mask_maj((north_rnfoi_a.N(r,c)./north_rnfoi_a.n_max_sample)>=.1)=1;
mask_min(north_rnfoi_a.N(r,c)>=100)=1;
tmp = double(north_rnfoi_a.mean(r,c).*mask_min);

mask_maj2=nan*north_rncrl_a.N(r,c);
mask_min2=nan*north_rncrl_a.N(r,c);
mask_maj2((north_rncrl_a.N(r,c)./north_rncrl_a.n_max_sample)>=.1)=1;
mask_min2(north_rncrl_a.N(r,c)>=100)=1;
tmp2 = double(north_rncrl_a.mean(r,c).*mask_min2.*1e6);

mask_maj3=nan*north_rndiv_a.N(r,c);
mask_min3=nan*north_rndiv_a.N(r,c);
mask_maj3((north_rndiv_a.N(r,c)./north_rndiv_a.n_max_sample)>=.1)=1;
mask_min3(north_rndiv_a.N(r,c)>=100)=1;
tmp3 = double(north_rndiv_a.mean(r,c).*mask_min3.*1e6);

[t_noa,t_nca,t_nda,l_noa]=transect3(tmp,tmp2,tmp3,100,-.6,.6);


cplot_comps(tmp,-.5,.5, ...
	'~/Documents/OSU/figures/south/north_comp_rnfoi_a_bg')
cplot_comps(tmp2,-5,5, ...
	'~/Documents/OSU/figures/south/north_comp_rncrl_a_bg')	
cplot_comps(tmp3,-3,3, ...
	'~/Documents/OSU/figures/south/north_comp_rndiv_a_bg')	

tmp = double(north_rnfoi_a.mean(r,c).*mask_maj);
tmp2 = double(north_rncrl_a.mean(r,c).*mask_maj2.*1e6);
tmp3 = double(north_rndiv_a.mean(r,c).*mask_maj3.*1e6);

cplot_comps_cont_line(tmp,tmp,l_noa(1,:),l_noa(2,:),-.5,.5,.45, ...
	'~/Documents/OSU/figures/south/north_comp_rnfoi_a')
cplot_comps_cont_line(tmp2,tmp,l_noa(1,:),l_noa(2,:),-5,5,.45, ...
	'~/Documents/OSU/figures/south/north_comp_rncrl_a')
cplot_comps_cont_line(tmp3,tmp,l_noa(1,:),l_noa(2,:),-3,3,.45, ...
	'~/Documents/OSU/figures/south/north_comp_rndiv_a')	


mask_maj=nan*south_rnfoi_c.N(r,c);
mask_min=nan*south_rnfoi_c.N(r,c);
mask_maj((south_rnfoi_c.N(r,c)./south_rnfoi_c.n_max_sample)>=.1)=1;
mask_min(south_rnfoi_c.N(r,c)>=100)=1;
tmp = double(south_rnfoi_c.mean(r,c).*mask_min);

mask_maj2=nan*south_rncrl_c.N(r,c);
mask_min2=nan*south_rncrl_c.N(r,c);
mask_maj2((south_rncrl_c.N(r,c)./south_rncrl_c.n_max_sample)>=.1)=1;
mask_min2(south_rncrl_c.N(r,c)>=100)=1;
tmp2 = double(south_rncrl_c.mean(r,c).*mask_min2.*1e6);

mask_maj3=nan*south_rndiv_c.N(r,c);
mask_min3=nan*south_rndiv_c.N(r,c);
mask_maj3((south_rndiv_c.N(r,c)./south_rndiv_c.n_max_sample)>=.1)=1;
mask_min3(south_rndiv_c.N(r,c)>=100)=1;
tmp3 = double(south_rndiv_c.mean(r,c).*mask_min3.*1e6);

[t_soc,t_scc,t_sdc,l_soc]=transect3(tmp,tmp2,tmp3,100,-.6,.6);

cplot_comps(tmp,-.5,.5, ...
	'~/Documents/OSU/figures/south/south_comp_rnfoi_c_bg')
cplot_comps(tmp2,-5,5, ...
	'~/Documents/OSU/figures/south/south_comp_rncrl_c_bg')	
cplot_comps(tmp3,-3,3, ...
	'~/Documents/OSU/figures/south/south_comp_rndiv_c_bg')	
	

tmp = double(south_rnfoi_c.mean(r,c).*mask_maj);
tmp2 = double(south_rncrl_c.mean(r,c).*mask_maj2.*1e6);
tmp3 = double(south_rndiv_c.mean(r,c).*mask_maj3.*1e6);

cplot_comps_cont_line(tmp,tmp,l_soc(1,:),l_soc(2,:),-.5,.5,-.35, ...
	'~/Documents/OSU/figures/south/south_comp_rnfoi_c')
cplot_comps_cont_line(tmp2,tmp,l_soc(1,:),l_soc(2,:),-5,5,-.35, ...
	'~/Documents/OSU/figures/south/south_comp_rncrl_c')	
cplot_comps_cont_line(tmp3,tmp,l_soc(1,:),l_soc(2,:),-3,3,-.35, ...
	'~/Documents/OSU/figures/south/south_comp_rndiv_c')	

mask_maj=nan*south_rnfoi_a.N(r,c);
mask_min=nan*south_rnfoi_a.N(r,c);
mask_maj((south_rnfoi_a.N(r,c)./south_rnfoi_a.n_max_sample)>=.1)=1;
mask_min(south_rnfoi_a.N(r,c)>=100)=1;
tmp = double(south_rnfoi_a.mean(r,c).*mask_min);

mask_maj2=nan*south_rncrl_a.N(r,c);
mask_min2=nan*south_rncrl_a.N(r,c);
mask_maj2((south_rncrl_a.N(r,c)./south_rncrl_a.n_max_sample)>=.1)=1;
mask_min2(south_rncrl_a.N(r,c)>=100)=1;
tmp2 = double(south_rncrl_a.mean(r,c).*mask_min2.*1e6);

mask_maj3=nan*south_rndiv_a.N(r,c);
mask_min3=nan*south_rndiv_a.N(r,c);
mask_maj3((south_rndiv_a.N(r,c)./south_rndiv_a.n_max_sample)>=.1)=1;
mask_min3(south_rndiv_a.N(r,c)>=100)=1;
tmp3 = double(south_rndiv_a.mean(r,c).*mask_min3.*1e6);

[t_soa,t_sca,t_sda,l_soa]=transect3(tmp,tmp2,tmp3,100,-.6,.6);

cplot_comps(tmp,-.5,.5, ...
	'~/Documents/OSU/figures/south/south_comp_rnfoi_a_bg')
cplot_comps(tmp2,-5,5, ...
	'~/Documents/OSU/figures/south/south_comp_rncrl_a_bg')	
cplot_comps(tmp3,-3,3, ...
	'~/Documents/OSU/figures/south/south_comp_rndiv_a_bg')	

tmp = double(south_rnfoi_a.mean(r,c).*mask_maj);
tmp2 = double(south_rncrl_a.mean(r,c).*mask_maj2.*1e6);
tmp3 = double(south_rndiv_a.mean(r,c).*mask_maj3.*1e6);

cplot_comps_cont_line(tmp,tmp,l_soa(1,:),l_soa(2,:),-.5,.5,.45, ...
	'~/Documents/OSU/figures/south/south_comp_rnfoi_a')
cplot_comps_cont_line(tmp2,tmp,l_soa(1,:),l_soa(2,:),-5,5,.45, ...
	'~/Documents/OSU/figures/south/south_comp_rncrl_a')	
cplot_comps_cont_line(tmp3,tmp,l_soa(1,:),l_soa(2,:),-3,3,.45, ...
	'~/Documents/OSU/figures/south/south_comp_rndiv_a')	
	
cplot_yy_r_b(t_noc,t_noa,t_ncc,t_nca,-.5,.5,.1,-5,5,2,1,...
	'deg c','m s^{-2}','~/Documents/OSU/figures/south/transects/north_crl')
cplot_yy_r_b(t_soc,t_soa,t_scc,t_sca,-.5,.5,.1,-5,5,2,1,...
	'deg c','m s^{-2}','~/Documents/OSU/figures/south/transects/south_crl')
		
cplot_yy_r_b(t_noc,t_noa,t_ndc,t_nda,-.5,.5,.1,-3,3,2,1,...
	'deg c','m s^{-2}','~/Documents/OSU/figures/south/transects/north_div')
cplot_yy_r_b(t_soc,t_soa,t_sdc,t_sda,-.5,.5,.1,-3,3,2,1,...
	'deg c','m s^{-2}','~/Documents/OSU/figures/south/transects/south_div')