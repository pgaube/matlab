load ~/matlab/hovmuller/new_mgrad_rot_comps rot_all_bp21_chl_N_cc rot_all_bp21_chl_N_c
load chelle.pal
scale=.5;

horz=flipud(smoothn(rot_all_bp21_chl_N_cc.mean,5));
horz=horz./max(abs(horz(:)));
horz=double(scale*horz);

x=linspace(-2,2,65);
y=x;
[lon_h,lat_h]=meshgrid(x,y);

a=.6; %m
L=.9; %deg
xo=0; 
yo=0;
dist=sqrt((lon_h-xo).^2+(lat_h-yo).^2);

cent=a*exp((-dist.^2)/(L^2));


pcomps_raw2(horz,horz,[-.7 .7],-1,.1,1,['CHL',char(39),' dipole'],1,30)
print -dpng -r300 ~/Documents/OSU/figures/eddy-wind/scam/a_horz_sst
pcomps_raw2(cent,cent,[-.7 .7],-1,.1,1,['CHL',char(39),' monopole'],1,30)
print -dpng -r300 ~/Documents/OSU/figures/eddy-wind/scam/a_gauss_chl
pcomps_raw2(cent+horz,cent+horz,[-.8 .8],-1,.1,1,['combined CHL',char(39)],1,30)
print -dpng -r300 ~/Documents/OSU/figures/eddy-wind/scam/a_combo_chl


	
horz=flipud(smoothn(rot_all_bp21_chl_N_cc.mean,5));
horz=horz./max(abs(horz(:)));
horz=double(scale*horz);

x=linspace(-2,2,65);
y=x;
[lon_h,lat_h]=meshgrid(x,y);

a=.6; %m
L=.9; %deg
xo=0; 
yo=0;
dist=sqrt((lon_h-xo).^2+(lat_h-yo).^2);

cent=a*exp((-dist.^2)/(L^2));	

pcomps_raw2(horz,horz,[-.7 .7],-1,.1,1,['CHL',char(39),' dipole'],1,30)
print -dpng -r300 ~/Documents/OSU/figures/eddy-wind/scam/c_horz_sst
pcomps_raw2(-cent,-cent,[-.7 .7],-1,.1,1,['CHL',char(39),' monopole'],1,30)
print -dpng -r300 ~/Documents/OSU/figures/eddy-wind/scam/c_gauss_chl
pcomps_raw2(-cent+horz,-cent+horz,[-.8 .8],-1,.1,1,['combined CHL',char(39)],1,30)
print -dpng -r300 ~/Documents/OSU/figures/eddy-wind/scam/c_combo_chl

