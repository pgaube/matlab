load section_30_new_comps
zgrid_grid
r=17:65;
c=17:65;
dist=dist(r,c);
dist=interp2(dist,2);
mask=nan*dist;
ii=find(dist<=1.7);
mask(ii)=1;


tmp = double(interp2(compc.chl_median,2));
tmp2 = double(interp2(compc.ssh_median,2));
cplot_comps_cont_3_3(tmp.*mask,tmp2.*mask,-.07,.07,1,-10,-1,'CHL cyclones with SSH',...
	['~/Documents/OSU/figures/hovmuller/comps/new_ssh_section30_cyclones']) 
	
tmp = double(interp2(compa.chl_median,2));
tmp2 = double(interp2(compa.ssh_median,2));
cplot_comps_cont_3_3(tmp.*mask,tmp2.*mask,-.07,.07,1,1,10,'CHL anticyclones with SSH',...
	['~/Documents/OSU/figures/hovmuller/comps/new_ssh_section30_anticyclones']) 
	
tmp = double(interp2(compa.chl_median,2));
tmp2 = double(interp2(smoothn(compa.wek_median,3),2));
cplot_comps_cont_3_3(tmp.*mask,tmp2.*mask,-.07,.07,.005,0,1,'CHL anticyclones with W_E',...
	['~/Documents/OSU/figures/hovmuller/comps/new_section30_anticyclones']) 	
	
tmp = double(interp2(compc.chl_median,2));
tmp2 = double(interp2(smoothn(compc.wek_median,3),2));
cplot_comps_cont_3_3(tmp.*mask,tmp2.*mask,-.07,.07,.005,-1,0,'CHL cyclones with W_E',...
	['~/Documents/OSU/figures/hovmuller/comps/new_section30_cyclones']) 	