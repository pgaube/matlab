clear all

load comps/norm_comps_16_weeks.mat
zgrid_grid
[r,c]=imap(-3,3,-3,3,yi,xi);
xi=xi(r,c);
yi=yi(r,c);
dist=sqrt(xi.^2+yi.^2);
dist=interp2(dist,2);
ii=find(dist<=1.5);

ttt=interp2(north_wek_c.N(r,c),2);
mask_min=nan*ttt;
mask_min((ttt./north_wek_c.n_max_sample)>=.1)=1;
mask_maj=nan*ttt;
mask_maj(ii)=1;
tmp = double(interp2(north_wek_c.mean(r,c),2).*mask_min);

%{
cplot_comps_cont_3_3(tmp,tmp,-.06,.06,.01,-1,1,...
	'~/Documents/OSU/figures/air-sea/comps/north_wek_c_bg')
tmp = double(interp2(north_wek_c.mean(r,c),2).*mask_maj);	
cplot_comps_cont_3_3(tmp,tmp,-.06,.06,.01,-1,1,...
	'~/Documents/OSU/figures/air-sea/comps/north_wek_c')

ttt=interp2(north_crlg_c.N(r,c),2);
mask_min=ones(size(ttt));
tmp = double(interp2(north_crlg_c.median(r,c),2).*mask_min);

cplot_comps_cont_3_3(tmp.*1e5,tmp.*1e5,-.45,.45,.05,-1,1,...
	'~/Documents/OSU/figures/air-sea/comps/north_crlg_c_bg')
tmp = double(interp2(north_crlg_c.median(r,c),2).*mask_maj);	
cplot_comps_cont_3_3(tmp.*1e5,tmp.*1e5,-.45,.45,.05,-1,1,...
	'~/Documents/OSU/figures/air-sea/comps/north_crlg_c')		
ttt=interp2(north_crl_c.N(r,c),2);
mask_min=ones(size(ttt));
tmp = -double(interp2(north_crl_c.median(r,c),2).*mask_min);

cplot_comps_cont_3_3(tmp.*1e5,tmp.*1e5,-.25,.25,.025,-1,1,...
	'~/Documents/OSU/figures/air-sea/comps/north_crl_c_bg')
tmp = -double(interp2(north_crl_c.median(r,c),2).*mask_maj);	
cplot_comps_cont_3_3(tmp.*1e5,tmp.*1e5,-.25,.25,.025,-1,1,...
	'~/Documents/OSU/figures/air-sea/comps/north_crl_c')		
	
ttt=interp2(north_wek_a.N(r,c),2);
mask_min=ones(size(ttt));
tmp = double(interp2(north_wek_a.mean(r,c),2).*mask_min);

cplot_comps_cont_3_3(tmp,tmp,-.06,.06,.01,-1,1,...
	'~/Documents/OSU/figures/air-sea/comps/north_wek_a_bg')
tmp = double(interp2(north_wek_a.mean(r,c),2).*mask_maj);	
cplot_comps_cont_3_3(tmp,tmp,-.06,.06,.01,-1,1,...
	'~/Documents/OSU/figures/air-sea/comps/north_wek_a')
	
ttt=interp2(north_crlg_a.N(r,c),2);
mask_min=ones(size(ttt));
tmp = double(interp2(north_crlg_a.median(r,c),2).*mask_min);

cplot_comps_cont_3_3(tmp.*1e5,tmp.*1e5,-.45,.45,.05,-1,1,...
'~/Documents/OSU/figures/air-sea/comps/north_crlg_a_bg')
tmp = double(interp2(north_crlg_a.median(r,c),2).*mask_maj);	
cplot_comps_cont_3_3(tmp.*1e5,tmp.*1e5,-.45,.45,.05,-1,1,...
	'~/Documents/OSU/figures/air-sea/comps/north_crlg_a')	
ttt=interp2(north_crl_a.N(r,c),2);
mask_min=ones(size(ttt));
tmp = -double(interp2(north_crl_a.median(r,c),2).*mask_min);

cplot_comps_cont_3_3(tmp.*1e5,tmp.*1e5,-.25,.25,.025,-1,1,...
'~/Documents/OSU/figures/air-sea/comps/north_crl_a_bg')
tmp = -double(interp2(north_crl_a.median(r,c),2).*mask_maj);	
cplot_comps_cont_3_3(tmp.*1e5,tmp.*1e5,-.25,.25,.025,-1,1,...
	'~/Documents/OSU/figures/air-sea/comps/north_crl_a')		
	
ttt=interp2(south_wek_c.N(r,c),2);
mask_min=ones(size(ttt));
tmp = double(interp2(south_wek_c.mean(r,c),2).*mask_min);

cplot_comps_cont_3_3(tmp,tmp,-.06,.06,.01,-1,1,...
	'~/Documents/OSU/figures/air-sea/comps/south_wek_c_bg')
tmp = double(interp2(south_wek_c.mean(r,c),2).*mask_maj);	
cplot_comps_cont_3_3(tmp,tmp,-.06,.06,.01,-1,1,...
	'~/Documents/OSU/figures/air-sea/comps/south_wek_c')
	
ttt=interp2(south_crlg_c.N(r,c),2);
mask_min=ones(size(ttt));
tmp = double(interp2(south_crlg_c.median(r,c),2).*mask_min);

cplot_comps_cont_3_3(tmp.*1e5,tmp.*1e5,-.45,.45,.05,-1,1,...
	'~/Documents/OSU/figures/air-sea/comps/south_crlg_c_bg')
tmp = double(interp2(south_crlg_c.median(r,c),2).*mask_maj);	
cplot_comps_cont_3_3(tmp.*1e5,tmp.*1e5,-.45,.45,.05,-1,1,...
	'~/Documents/OSU/figures/air-sea/comps/south_crlg_c')		
ttt=interp2(south_crl_c.N(r,c),2);
mask_min=ones(size(ttt));
tmp = -double(interp2(south_crl_c.median(r,c),2).*mask_min);

cplot_comps_cont_3_3(tmp.*1e5,tmp.*1e5,-.25,.25,.025,-1,1,...
	'~/Documents/OSU/figures/air-sea/comps/south_crl_c_bg')
tmp = -double(interp2(south_crl_c.median(r,c),2).*mask_maj);	
cplot_comps_cont_3_3(tmp.*1e5,tmp.*1e5,-.25,.25,.025,-1,1,...
	'~/Documents/OSU/figures/air-sea/comps/south_crl_c')	

ttt=interp2(south_wek_a.N(r,c),2);
mask_min=ones(size(ttt));
tmp = double(interp2(south_wek_a.mean(r,c),2).*mask_min);

cplot_comps_cont_3_3(tmp,tmp,-.06,.06,.01,-1,1,...
	'~/Documents/OSU/figures/air-sea/comps/south_wek_a_bg')
tmp = double(interp2(south_wek_a.mean(r,c),2).*mask_maj);	
cplot_comps_cont_3_3(tmp,tmp,-.06,.06,.01,-1,1,...
	'~/Documents/OSU/figures/air-sea/comps/south_wek_a')	
	
ttt=interp2(south_crlg_a.N(r,c),2);
mask_min=ones(size(ttt));
tmp = double(interp2(south_crlg_a.median(r,c),2).*mask_min);

cplot_comps_cont_3_3(tmp.*1e5,tmp.*1e5,-.45,.45,.05,-1,1,...
	'~/Documents/OSU/figures/air-sea/comps/south_crlg_a_bg')
tmp = double(interp2(south_crlg_a.median(r,c),2).*mask_maj);	
cplot_comps_cont_3_3(tmp.*1e5,tmp.*1e5,-.45,.45,.05,-1,1,...
	'~/Documents/OSU/figures/air-sea/comps/south_crlg_a')	

ttt=interp2(south_crl_a.N(r,c),2);
mask_min=ones(size(ttt));
tmp = -double(interp2(south_crl_a.median(r,c),2).*mask_min);

cplot_comps_cont_3_3(tmp.*1e5,tmp.*1e5,-.25,.25,.025,-1,1,...
	'~/Documents/OSU/figures/air-sea/comps/south_crl_a_bg')
tmp = -double(interp2(south_crl_a.median(r,c),2).*mask_maj);	
cplot_comps_cont_3_3(tmp.*1e5,tmp.*1e5,-.25,.25,.025,-1,1,...
	'~/Documents/OSU/figures/air-sea/comps/south_crl_a')		
%}
%
ii=find(dist<=2.25);
mask_maj(ii)=1;
%

ttt=interp2(north_foi_a.N(r,c),2);
mask_min=ones(size(ttt));
tmp = double(interp2(north_foi_a.median(r,c),2).*mask_min);

cplot_comps_cont_3_3(tmp,tmp,-.3,.3,.05,-1,1,...
	'~/Documents/OSU/figures/air-sea/comps/north_foi_a_bg')
tmp = double(interp2(north_foi_a.median(r,c),2).*mask_maj);	
cplot_comps_cont_3_3(tmp,tmp,-.3,.3,.05,-1,1,...
	'~/Documents/OSU/figures/air-sea/comps/north_foi_a')
	
ttt=interp2(north_spd_a.N(r,c),2);
mask_min=ones(size(ttt));
tmp = double(interp2(north_spd_a.median(r,c),2).*mask_min);

cplot_comps_cont_3_3(tmp,tmp,-.2,.2,.05,-1,1,...
'~/Documents/OSU/figures/air-sea/comps/north_spd_a_bg')
tmp = double(interp2(north_spd_a.median(r,c),2).*mask_maj);	
cplot_comps_cont_3_3(tmp,tmp,-.2,.2,.05,-1,1,...
	'~/Documents/OSU/figures/air-sea/comps/north_spd_a')		

ttt=interp2(north_foi_c.N(r,c),2);
mask_min=ones(size(ttt));
tmp = double(interp2(north_foi_c.median(r,c),2).*mask_min);

cplot_comps_cont_3_3(tmp,tmp,-.3,.3,.05,-1,1,...
	'~/Documents/OSU/figures/air-sea/comps/north_foi_c_bg')
tmp = double(interp2(north_foi_c.median(r,c),2).*mask_maj);	
cplot_comps_cont_3_3(tmp,tmp,-.3,.3,.05,-1,1,...
	'~/Documents/OSU/figures/air-sea/comps/north_foi_c')
	
ttt=interp2(north_spd_c.N(r,c),2);
mask_min=ones(size(ttt));
tmp = double(interp2(north_spd_c.median(r,c),2).*mask_min);

cplot_comps_cont_3_3(tmp,tmp,-.2,.2,.05,-1,1,...
'~/Documents/OSU/figures/air-sea/comps/north_spd_c_bg')
tmp = double(interp2(north_spd_c.median(r,c),2).*mask_maj);	
cplot_comps_cont_3_3(tmp,tmp,-.2,.2,.05,-1,1,...
	'~/Documents/OSU/figures/air-sea/comps/north_spd_c')	


ttt=interp2(south_foi_a.N(r,c),2);
mask_min=nan*ttt;
mask_min=ones(size(ttt));tmp = double(interp2(south_foi_a.median(r,c),2).*mask_min);

cplot_comps_cont_3_3(tmp,tmp,-.3,.3,.05,-1,1,...
	'~/Documents/OSU/figures/air-sea/comps/south_foi_a_bg')
tmp = double(interp2(south_foi_a.median(r,c),2).*mask_maj);	
cplot_comps_cont_3_3(tmp,tmp,-.3,.3,.05,-1,1,...
	'~/Documents/OSU/figures/air-sea/comps/south_foi_a')
	
ttt=interp2(south_spd_a.N(r,c),2);
mask_min=ones(size(ttt));
tmp = double(interp2(south_spd_a.median(r,c),2).*mask_min);

cplot_comps_cont_3_3(tmp,tmp,-.2,.2,.05,-1,1,...
'~/Documents/OSU/figures/air-sea/comps/south_spd_a_bg')
tmp = double(interp2(south_spd_a.median(r,c),2).*mask_maj);	
cplot_comps_cont_3_3(tmp,tmp,-.2,.2,.05,-1,1,...
	'~/Documents/OSU/figures/air-sea/comps/south_spd_a')		
	
ttt=interp2(south_foi_c.N(r,c),2);
mask_min=ones(size(ttt));
mask_min=ones(size(ttt));
tmp = double(interp2(south_foi_c.median(r,c),2).*mask_min);

cplot_comps_cont_3_3(tmp,tmp,-.3,.3,.05,-1,1,...
	'~/Documents/OSU/figures/air-sea/comps/south_foi_c_bg')
tmp = double(interp2(south_foi_c.median(r,c),2).*mask_maj);	
cplot_comps_cont_3_3(tmp,tmp,-.3,.3,.05,-1,1,...
	'~/Documents/OSU/figures/air-sea/comps/south_foi_c')
	
ttt=interp2(south_spd_c.N(r,c),2);
mask_min=ones(size(ttt));
mask_min=ones(size(ttt));
tmp = double(interp2(south_spd_c.median(r,c),2).*mask_min);

cplot_comps_cont_3_3(tmp,tmp,-.2,.2,.05,-1,1,...
'~/Documents/OSU/figures/air-sea/comps/south_spd_c_bg')
tmp = double(interp2(south_spd_c.median(r,c),2).*mask_maj);	
cplot_comps_cont_3_3(tmp,tmp,-.2,.2,.05,-1,1,...
	'~/Documents/OSU/figures/air-sea/comps/south_spd_c')		
	