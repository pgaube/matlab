load /matlab/matlab/hovmuller/new_mgrad_rot_comps rot_all_bp21_chl_N_cc rot_all_bp26_sst_N_cc
load chelle.pal
scale=.3;

horz=smoothn(rot_all_bp21_chl_N_cc.mean,5);
horz=horz./max(abs(horz(:)));
horz=double(scale*horz);

sst=double(rot_all_bp26_sst_N_cc.mean);
sst=sst./max(abs(sst(:)));
sst=double(.5*sst);

x=linspace(-2,2,65);
y=x;
[lon_h,lat_h]=meshgrid(x,y);

a=scale; %m
L=.9; %deg
xo=0; 
yo=0;
dist=sqrt((lon_h-xo).^2+(lat_h-yo).^2);

cent=a*exp((-dist.^2)/(L^2));


figure(10)
subplot(331)
pcolor(horz);shading flat
line([1 65],[33 33],'color','k','linewidth',1)
line([33 33],[1 65],'color','k','linewidth',1)
axis image
caxis([-.3 .3])
colormap(chelle)
colorbar
%title({'rotated midlat CHL composites','scaled to have a amplitude of 0.3 ^\circ C'})

subplot(332)
pcolor(cent);shading flat
line([1 65],[33 33],'color','k','linewidth',1)
line([33 33],[1 65],'color','k','linewidth',1)
axis image
caxis([-.3 .3])
colormap(chelle)
colorbar
%title('Gaussian SST anomaly of 0.3 ^\circ C')

subplot(333)
pcolor(cent+horz);shading flat
line([1 65],[33 33],'color','k','linewidth',1)
line([33 33],[1 65],'color','k','linewidth',1)
axis image
caxis([-.5 .5])
colormap(chelle)
colorbar
%title('Superpostion of previous 2 panels')


subplot(3,3,[4 5 6 7 8 9])
pcolor(sst);shading flat
line([1 65],[33 33],'color','k','linewidth',1)
line([33 33],[1 65],'color','k','linewidth',1)
axis image
caxis([-.5 .5])
colormap(chelle)
colorbar
%title({'Midlatitude SST composite for counter clockwise rotation','in N grad SST 0.5 ^\circ C'})

print -dpng -r300 figs/make_asymetric_sst_comp

cplot_comps_cont_2_2(horz,horz,-.3,.3,.05,-1,1,['scaled log_10^(CHL) composite'],...
	['~/Documents/OSU/figures/air-sea/scam/horz_sst'])
cplot_comps_cont_2_2(cent,cent,-.3,.3,.05,-1,1,['scaled Gaussian SST anomaly'],...
	['~/Documents/OSU/figures/air-sea/scam/gauss_sst'])
cplot_comps_cont_2_2(cent+horz,cent+horz,-.5,.5,.05,-1,1,['simulated midlat SST composite'],...
	['~/Documents/OSU/figures/air-sea/scam/combo_sst'])	
cplot_comps_cont_2_2(sst,sst,-.5,.5,.05,-1,1,['scaled midlat SST composite'],...
	['~/Documents/OSU/figures/air-sea/scam/scaled_sst'])
