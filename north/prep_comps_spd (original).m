clear all

load new_north_south_comps

mask_maj=nan*north_rnfoi_c.N(r,c);
mask_min=nan*north_rnfoi_c.N(r,c);
mask_maj((north_rnfoi_c.N(r,c)./north_rnfoi_c.n_max_sample)>=.1)=1;
mask_min(north_rnfoi_c.N(r,c)>=100)=1;
tmp = double(north_rnfoi_c.mean(r,c).*mask_min);

mask_maj2=nan*north_rnspd_c.N(r,c);
mask_min2=nan*north_rnspd_c.N(r,c);
mask_maj2((north_rnspd_c.N(r,c)./north_rnspd_c.n_max_sample)>=.1)=1;
mask_min2(north_rnspd_c.N(r,c)>=100)=1;
tmp2 = double(north_rnspd_c.mean(r,c).*mask_min2);

[t_noc,t_nsc,l_noc]=transect2(tmp,tmp2,100,-.4,.4);

save -ascii /Volumes/matlab/calcomp/data/t_noc.txt t_noc
save -ascii /Volumes/matlab/calcomp/data/t_nsc.txt t_nsc
save -ascii /Volumes/matlab/calcomp/data/l_noc.txt l_noc

cplot_comps(tmp,-.3,.3, ...
	'~/Documents/OSU/figures/south/north_comp_rnfoi_c_transect_bg')
cplot_comps(tmp2,-.25,.25, ...
	'~/Documents/OSU/figures/south/north_comp_rnspd_c_transect_bg')	

tmp = double(north_rnfoi_c.mean(r,c).*mask_maj);
tmp2 = double(north_rnspd_c.mean(r,c).*mask_maj2);

cplot_comps_cont_w_line(tmp,tmp,l_noc(1,:),l_noc(2,:),-.4,.4,.1,-.3,-.2, ...
	'~/Documents/OSU/figures/south/north_comp_rnfoi_c_transect')
cplot_comps_cont_w_line(tmp2,tmp,l_noc(1,:),l_noc(2,:),-.25,.25,.35,-.5,-.25, ...
	'~/Documents/OSU/figures/south/north_comp_rnspd_c_transect')	

mask_maj=nan*north_rnfoi_a.N(r,c);
mask_min=nan*north_rnfoi_a.N(r,c);
mask_maj((north_rnfoi_a.N(r,c)./north_rnfoi_a.n_max_sample)>=.1)=1;
mask_min(north_rnfoi_a.N(r,c)>=100)=1;
tmp = double(north_rnfoi_a.mean(r,c).*mask_min);

mask_maj2=nan*north_rnspd_a.N(r,c);
mask_min2=nan*north_rnspd_a.N(r,c);
mask_maj2((north_rnspd_a.N(r,c)./north_rnspd_a.n_max_sample)>=.1)=1;
mask_min2(north_rnspd_a.N(r,c)>=100)=1;
tmp2 = double(north_rnspd_a.mean(r,c).*mask_min2);

[t_noa,t_nsa,l_noa]=transect2(tmp,tmp2,100,-.4,.4);

save -ascii /Volumes/matlab/calcomp/data/t_noa.txt t_noa
save -ascii /Volumes/matlab/calcomp/data/t_nsa.txt t_nsa
save -ascii /Volumes/matlab/calcomp/data/l_noa.txt l_noa

cplot_comps(tmp,-.4,.4, ...
	'~/Documents/OSU/figures/south/north_comp_rnfoi_a_transect_bg')
cplot_comps(tmp2,-.25,.25, ...
	'~/Documents/OSU/figures/south/north_comp_rnspd_a_transect_bg')	

tmp = double(north_rnfoi_a.mean(r,c).*mask_maj);
tmp2 = double(north_rnspd_a.mean(r,c).*mask_maj2);

cplot_comps_cont_w_line(tmp,tmp,l_noa(1,:),l_noa(2,:),-.4,.4,.1,.361,.4, ...
	'~/Documents/OSU/figures/south/north_comp_rnfoi_a_transect')
cplot_comps_cont_w_line(tmp2,tmp,l_noa(1,:),l_noa(2,:),-.25,.25,.45,.45,.9, ... 
	'~/Documents/OSU/figures/south/north_comp_rnspd_a_transect')	




mask_maj=nan*south_rnfoi_c.N(r,c);
mask_min=nan*south_rnfoi_c.N(r,c);
mask_maj((south_rnfoi_c.N(r,c)./south_rnfoi_c.n_max_sample)>=.1)=1;
mask_min(south_rnfoi_c.N(r,c)>=100)=1;
tmp = double(south_rnfoi_c.mean(r,c).*mask_min);

mask_maj2=nan*south_rnspd_c.N(r,c);
mask_min2=nan*south_rnspd_c.N(r,c);
mask_maj2((south_rnspd_c.N(r,c)./south_rnspd_c.n_max_sample)>=.1)=1;
mask_min2(south_rnspd_c.N(r,c)>=100)=1;
tmp2 = double(south_rnspd_c.mean(r,c).*mask_min2);

[t_soc,t_ssc,l_soc]=transect2(tmp,tmp2,100,-.6,.6);

save -ascii /Volumes/matlab/calcomp/data/t_noc.txt t_noc
save -ascii /Volumes/matlab/calcomp/data/t_nsc.txt t_nsc
save -ascii /Volumes/matlab/calcomp/data/l_noc.txt l_noc

cplot_comps(tmp,-.4,.4, ...
	'~/Documents/OSU/figures/south/south_comp_rnfoi_c_transect_bg')
cplot_comps(tmp2,-.25,.25, ...
	'~/Documents/OSU/figures/south/south_comp_rnspd_c_transect_bg')	

tmp = double(south_rnfoi_c.mean(r,c).*mask_maj);
tmp2 = double(south_rnspd_c.mean(r,c).*mask_maj2);

cplot_comps_cont_w_line(tmp,tmp,l_soc(1,:),l_soc(2,:),-.4,.4,.1,-.3,-.2, ...
	'~/Documents/OSU/figures/south/south_comp_rnfoi_c_transect')
cplot_comps_cont_w_line(tmp2,tmp,l_soc(1,:),l_soc(2,:),-.25,.25,.35,-.7,-.35, ...
	'~/Documents/OSU/figures/south/south_comp_rnspd_c_transect')	

mask_maj=nan*south_rnfoi_a.N(r,c);
mask_min=nan*south_rnfoi_a.N(r,c);
mask_maj((south_rnfoi_a.N(r,c)./south_rnfoi_a.n_max_sample)>=.1)=1;
mask_min(south_rnfoi_a.N(r,c)>=100)=1;
tmp = double(south_rnfoi_a.mean(r,c).*mask_min);

mask_maj2=nan*south_rnspd_a.N(r,c);
mask_min2=nan*south_rnspd_a.N(r,c);
mask_maj2((south_rnspd_a.N(r,c)./south_rnspd_a.n_max_sample)>=.1)=1;
mask_min2(south_rnspd_a.N(r,c)>=100)=1;
tmp2 = double(south_rnspd_a.mean(r,c).*mask_min2);

[t_soa,t_ssa,l_soa]=transect2(tmp,tmp2,100,-.6,.6);

save -ascii /Volumes/matlab/calcomp/data/t_soa.txt t_soa
save -ascii /Volumes/matlab/calcomp/data/t_ssa.txt t_ssa
save -ascii /Volumes/matlab/calcomp/data/l_soa.txt l_soa

cplot_comps(tmp,-.4,.4, ...
	'~/Documents/OSU/figures/south/south_comp_rnfoi_a_transect_bg')
cplot_comps(tmp2,-.25,.25, ...
	'~/Documents/OSU/figures/south/south_comp_rnspd_a_transect_bg')	

tmp = double(south_rnfoi_a.mean(r,c).*mask_maj);
tmp2 = double(south_rnspd_a.mean(r,c).*mask_maj2);

cplot_comps_cont_w_line(tmp,tmp,l_soa(1,:),l_soa(2,:),-.4,.4,.1,.361,.4, ...
	'~/Documents/OSU/figures/south/south_comp_rnfoi_a_transect')
cplot_comps_cont_w_line(tmp2,tmp,l_soa(1,:),l_soa(2,:),-.25,.25,.45,.45,.9, ... 
	'~/Documents/OSU/figures/south/south_comp_rnspd_a_transect')	
	
cplot_yy_r_b(t_noc,t_noa,t_nsc,t_nsa,-.4,.4,.1,-.25,.25,.1,2,...
	'deg c','m s^{-2}','~/Documents/OSU/figures/south/transects/north_rnspd')
cplot_yy_r_b(t_soc,t_soa,t_ssc,t_ssa,-.4,.4,.1,-.25,.25,.1,2,....
	'deg c','m s^{-2}','~/Documents/OSU/figures/south/transects/south_rnspd')