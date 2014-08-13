clear all

load /Volumes/matlab/matlab/eddy-wind/norm_comps_16_weeks
zgrid_grid
[r,c]=imap(-3,3,-3,3,yi,xi);
xi=xi(r,c);
yi=yi(r,c);
dist=sqrt(xi.^2+yi.^2);
dist=interp2(dist,2);
ii=find(dist<=1.5);

ttt=interp2(LW_wek_a.N(r,c),2);
mask_min=ones(size(ttt));
mask_min((ttt./LW_wek_a.n_max_sample)>=.1)=1;
mask_maj=nan*ttt;
mask_maj(ii)=1;

%{
tmp = double(interp2(LW_wek_a.mean(r,c),2).*mask_min);
cplot_comps_cont_3_3(tmp,tmp,-.11,.11,.01,-1,1,...
	'~/Documents/OSU/figures/air-sea/comps/LW_wek_a_bg')
tmp = double(interp2(LW_wek_a.mean(r,c),2).*mask_maj);	
cplot_comps_cont_3_3(tmp,tmp,-.11,.11,.01,-1,1,...
	'~/Documents/OSU/figures/air-sea/comps/LW_wek_a')

tmp = double(interp2(LW_wek_c.mean(r,c),2).*mask_min);
cplot_comps_cont_3_3(tmp,tmp,-.11,.11,.01,-1,1,...
	'~/Documents/OSU/figures/air-sea/comps/LW_wek_c_bg')
tmp = double(interp2(LW_wek_c.mean(r,c),2).*mask_maj);	
cplot_comps_cont_3_3(tmp,tmp,-.11,.11,.01,-1,1,...
	'~/Documents/OSU/figures/air-sea/comps/LW_wek_c')	
%}	
tmp = double(interp2(LW_achl_c.mean(r,c),2).*mask_min);
cplot_comps_cont_3_3(tmp,tmp,-.04,.04,.002,-1,1,...
	'~/Documents/OSU/figures/air-sea/comps/LW_achl_c_bg')
tmp = double(interp2(LW_achl_c.mean(r,c),2).*mask_maj);	
cplot_comps_cont_3_3(tmp,tmp,-.04,.04,.002,-1,1,...
	'~/Documents/OSU/figures/air-sea/comps/LW_achl_c')	
	
return

tmp = double(interp2(LW_achl_a.mean(r,c),2).*mask_min);
cplot_comps_cont_3_3(tmp,tmp,-.02,.02,.002,-1,1,...
	'~/Documents/OSU/figures/air-sea/comps/LW_achl_a_bg')
tmp = double(interp2(LW_achl_a.mean(r,c),2).*mask_maj);	
cplot_comps_cont_3_3(tmp,tmp,-.02,.02,.002,-1,1,...
	'~/Documents/OSU/figures/air-sea/comps/LW_achl_a')	
	