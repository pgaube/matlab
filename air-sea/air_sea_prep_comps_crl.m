clear all

load comps/norm_comps_16_weeks.mat
zgrid_grid
[r,c]=imap(-3,3,-3,3,yi,xi);
xi=xi(r,c);
yi=yi(r,c);
dist=sqrt(xi.^2+yi.^2);
dist=interp2(dist,2);
ii=find(dist<=1.6);

ttt=interp2(north_crl_c.N(r,c),2);
mask_min=nan*ttt;
mask_min((ttt./north_crl_c.n_max_sample)>=.2)=1;
mask_maj=nan*ttt;
mask_maj(ii)=1;
tmp = double(interp2(north_crl_c.mean(r,c),2).*mask_min);

cplot_comps_cont_3_3(tmp.*1e5,tmp.*1e5,-.25,.25,.05,-1,1,...
	'~/Documents/OSU/figures/air-sea/comps/north_crl_c_bg')
tmp = double(interp2(north_crl_c.mean(r,c),2).*mask_maj);	
cplot_comps_cont_3_3(tmp.*1e5,tmp.*1e5,-.25,.25,.05,-1,1,...
	'~/Documents/OSU/figures/air-sea/comps/north_crl_c')
	
ttt=interp2(north_crlg_c.N(r,c),2);
mask_min=nan*ttt;
mask_min((ttt./north_crlg_c.n_max_sample)>=.2)=1;
tmp = double(interp2(north_crlg_c.mean(r,c),2).*mask_min);

cplot_comps_cont_3_3(tmp.*1e5,tmp.*1e5,-.5,.5,.05,-1,1,...
	'~/Documents/OSU/figures/air-sea/comps/north_crlg_c_bg')
tmp = double(interp2(north_crlg_c.mean(r,c),2).*mask_maj);	
cplot_comps_cont_3_3(tmp.*1e5,tmp.*1e5,-.5,.5,.05,-1,1,...
	'~/Documents/OSU/figures/air-sea/comps/north_crlg_c')	
	
ttt=interp2(north_crl_a.N(r,c),2);
mask_min=nan*ttt;
mask_min((ttt./north_crl_a.n_max_sample)>=.2)=1;
tmp = double(interp2(north_crl_a.mean(r,c),2).*mask_min);

cplot_comps_cont_3_3(tmp.*1e5,tmp.*1e5,-.25,.25,.05,-1,1,...
	'~/Documents/OSU/figures/air-sea/comps/north_crl_a_bg')
tmp = double(interp2(north_crl_a.mean(r,c),2).*mask_maj);	
cplot_comps_cont_3_3(tmp.*1e5,tmp.*1e5,-.25,.25,.05,-1,1,...
	'~/Documents/OSU/figures/air-sea/comps/north_crl_a')
	
ttt=interp2(north_crlg_a.N(r,c),2);
mask_min=nan*ttt;
mask_min((ttt./north_crlg_a.n_max_sample)>=.2)=1;
tmp = double(interp2(north_crlg_a.mean(r,c),2).*mask_min);

cplot_comps_cont_3_3(tmp.*1e5,tmp.*1e5,-.5,.5,.05,-1,1,...
'~/Documents/OSU/figures/air-sea/comps/north_crlg_a_bg')
tmp = double(interp2(north_crlg_a.mean(r,c),2).*mask_maj);	
cplot_comps_cont_3_3(tmp.*1e5,tmp.*1e5,-.5,.5,.05,-1,1,...
	'~/Documents/OSU/figures/air-sea/comps/north_crlg_a')	
	
ttt=interp2(south_crl_c.N(r,c),2);
mask_min=nan*ttt;
mask_min((ttt./south_crl_c.n_max_sample)>=.2)=1;
tmp = double(interp2(south_crl_c.mean(r,c),2).*mask_min);

cplot_comps_cont_3_3(tmp.*1e5,tmp.*1e5,-.25,.25,.05,-1,1,...
	'~/Documents/OSU/figures/air-sea/comps/south_crl_c_bg')
tmp = double(interp2(south_crl_c.mean(r,c),2).*mask_maj);	
cplot_comps_cont_3_3(tmp.*1e5,tmp.*1e5,-.25,.25,.05,-1,1,...
	'~/Documents/OSU/figures/air-sea/comps/south_crl_c')
	
ttt=interp2(south_crlg_c.N(r,c),2);
mask_min=nan*ttt;
mask_min((ttt./south_crlg_c.n_max_sample)>=.2)=1;
tmp = double(interp2(south_crlg_c.mean(r,c),2).*mask_min);

cplot_comps_cont_3_3(tmp.*1e5,tmp.*1e5,-.5,.5,.05,-1,1,...
	'~/Documents/OSU/figures/air-sea/comps/south_crlg_c_bg')
tmp = double(interp2(south_crlg_c.mean(r,c),2).*mask_maj);	
cplot_comps_cont_3_3(tmp.*1e5,tmp.*1e5,-.5,.5,.05,-1,1,...
	'~/Documents/OSU/figures/air-sea/comps/south_crlg_c')	

ttt=interp2(south_crl_a.N(r,c),2);
mask_min=nan*ttt;
mask_min((ttt./south_crl_a.n_max_sample)>=.2)=1;
tmp = double(interp2(south_crl_a.mean(r,c),2).*mask_min);

cplot_comps_cont_3_3(tmp.*1e5,tmp.*1e5,-.25,.25,.05,-1,1,...
	'~/Documents/OSU/figures/air-sea/comps/south_crl_a_bg')
tmp = double(interp2(south_crl_a.mean(r,c),2).*mask_maj);	
cplot_comps_cont_3_3(tmp.*1e5,tmp.*1e5,-.25,.25,.05,-1,1,...
	'~/Documents/OSU/figures/air-sea/comps/south_crl_a')	
	
ttt=interp2(south_crlg_a.N(r,c),2);
mask_min=nan*ttt;
mask_min((ttt./south_crlg_a.n_max_sample)>=.2)=1;
tmp = double(interp2(south_crlg_a.mean(r,c),2).*mask_min);

cplot_comps_cont_3_3(tmp.*1e5,tmp.*1e5,-.5,.5,.05,-1,1,...
	'~/Documents/OSU/figures/air-sea/comps/south_crlg_a_bg')
tmp = double(interp2(south_crlg_a.mean(r,c),2).*mask_maj);	
cplot_comps_cont_3_3(tmp.*1e5,tmp.*1e5,-.5,.5,.05,-1,1,...
	'~/Documents/OSU/figures/air-sea/comps/south_crlg_a')	

ttt=interp2(north_foi_a.N(r,c),2);
mask_min=nan*ttt;
mask_min((ttt./north_foi_a.n_max_sample)>=.2)=1;
tmp = double(interp2(north_foi_a.mean(r,c),2).*mask_min);

cplot_comps_cont_3_3(tmp,tmp,-.3,.3,.05,-1,1,...
	'~/Documents/OSU/figures/air-sea/comps/north_foi_a_bg')
tmp = double(interp2(north_foi_a.mean(r,c),2).*mask_maj);	
cplot_comps_cont_3_3(tmp,tmp,-.3,.3,.05,-1,1,...
	'~/Documents/OSU/figures/air-sea/comps/north_foi_a')
	
ttt=interp2(north_spd_a.N(r,c),2);
mask_min=nan*ttt;
mask_min((ttt./north_spd_a.n_max_sample)>=.2)=1;
tmp = double(interp2(north_spd_a.mean(r,c),2).*mask_min);

cplot_comps_cont_3_3(tmp,tmp,-.3,.3,.05,-1,1,...
'~/Documents/OSU/figures/air-sea/comps/north_spd_a_bg')
tmp = double(interp2(north_spd_a.mean(r,c),2).*mask_maj);	
cplot_comps_cont_3_3(tmp,tmp,-.3,.3,.05,-1,1,...
	'~/Documents/OSU/figures/air-sea/comps/north_spd_a')		
	
ttt=interp2(north_foi_c.N(r,c),2);
mask_min=nan*ttt;
mask_min((ttt./north_foi_c.n_max_sample)>=.2)=1;
tmp = double(interp2(north_foi_c.mean(r,c),2).*mask_min);

cplot_comps_cont_3_3(tmp,tmp,-.3,.3,.05,-1,1,...
	'~/Documents/OSU/figures/air-sea/comps/north_foi_c_bg')
tmp = double(interp2(north_foi_c.mean(r,c),2).*mask_maj);	
cplot_comps_cont_3_3(tmp,tmp,-.3,.3,.05,-1,1,...
	'~/Documents/OSU/figures/air-sea/comps/north_foi_c')
	
ttt=interp2(north_spd_c.N(r,c),2);
mask_min=nan*ttt;
mask_min((ttt./north_spd_c.n_max_sample)>=.2)=1;
tmp = double(interp2(north_spd_c.mean(r,c),2).*mask_min);

cplot_comps_cont_3_3(tmp,tmp,-.3,.3,.05,-1,1,...
'~/Documents/OSU/figures/air-sea/comps/north_spd_c_bg')
tmp = double(interp2(north_spd_c.mean(r,c),2).*mask_maj);	
cplot_comps_cont_3_3(tmp,tmp,-.3,.3,.05,-1,1,...
	'~/Documents/OSU/figures/air-sea/comps/north_spd_c')	


ttt=interp2(south_foi_a.N(r,c),2);
mask_min=nan*ttt;
mask_min((ttt./south_foi_a.n_max_sample)>=.2)=1;
tmp = double(interp2(south_foi_a.mean(r,c),2).*mask_min);

cplot_comps_cont_3_3(tmp,tmp,-.3,.3,.05,-1,1,...
	'~/Documents/OSU/figures/air-sea/comps/south_foi_a_bg')
tmp = double(interp2(south_foi_a.mean(r,c),2).*mask_maj);	
cplot_comps_cont_3_3(tmp,tmp,-.3,.3,.05,-1,1,...
	'~/Documents/OSU/figures/air-sea/comps/south_foi_a')
	
ttt=interp2(south_spd_a.N(r,c),2);
mask_min=nan*ttt;
mask_min((ttt./south_spd_a.n_max_sample)>=.2)=1;
tmp = double(interp2(south_spd_a.mean(r,c),2).*mask_min);

cplot_comps_cont_3_3(tmp,tmp,-.3,.3,.05,-1,1,...
'~/Documents/OSU/figures/air-sea/comps/south_spd_a_bg')
tmp = double(interp2(south_spd_a.mean(r,c),2).*mask_maj);	
cplot_comps_cont_3_3(tmp,tmp,-.3,.3,.05,-1,1,...
	'~/Documents/OSU/figures/air-sea/comps/south_spd_a')		
	
ttt=interp2(south_foi_c.N(r,c),2);
mask_min=nan*ttt;
mask_min((ttt./south_foi_c.n_max_sample)>=.2)=1;
tmp = double(interp2(south_foi_c.mean(r,c),2).*mask_min);

cplot_comps_cont_3_3(tmp,tmp,-.3,.3,.05,-1,1,...
	'~/Documents/OSU/figures/air-sea/comps/south_foi_c_bg')
tmp = double(interp2(south_foi_c.mean(r,c),2).*mask_maj);	
cplot_comps_cont_3_3(tmp,tmp,-.3,.3,.05,-1,1,...
	'~/Documents/OSU/figures/air-sea/comps/south_foi_c')
	
ttt=interp2(south_spd_c.N(r,c),2);
mask_min=nan*ttt;
mask_min((ttt./south_spd_c.n_max_sample)>=.2)=1;
tmp = double(interp2(south_spd_c.mean(r,c),2).*mask_min);

cplot_comps_cont_3_3(tmp,tmp,-.3,.3,.05,-1,1,...
'~/Documents/OSU/figures/air-sea/comps/south_spd_c_bg')
tmp = double(interp2(south_spd_c.mean(r,c),2).*mask_maj);	
cplot_comps_cont_3_3(tmp,tmp,-.3,.3,.05,-1,1,...
	'~/Documents/OSU/figures/air-sea/comps/south_spd_c')		
	