clear
ppres=[10:10:1000]';
xi=[-2.2:.1:2.2];
yi=xi;
[X,Y,P]=meshgrid(xi,yi,ppres);

load VOCALS_argo_3d ac_t ac_t_anom
load VOCALS_eddy_argo_prof eddy_scale eddy_y
km_x=pmean(eddy_scale)*xi;
km_y=km_x';
ff=f_cor(pmean(eddy_y));

ac_s=25*ones(size(ac_t));
rho=sw_dens(ac_s,ac_t,P);
ac_sigma=rho-1000;
[ac_u,ac_v]=geostro_3d(rho,km_x,km_y,ppres,ff);

flf=find(yi==min(abs(yi)));
figure(5)
clf
subplot(122)
pcolor(xi,-ppres,squeeze(ac_v(flf,:,:))');shading flat
hold on
contour(xi,-ppres,squeeze(ac_sigma(flf,:,:))',[10:.5:30],'k')
line([0 0], [-1000 0])
caxis([-.1 .1])
colorbar
axis([-1.4 1.4 -1000 0])
daspect([1 300 1])
%daspect([1 300 1])
title('Geostrophic velocity of anticyclones')
subplot(121)
pcolor(xi,-ppres,squeeze(ac_t_anom(flf,:,:))');shading flat
hold on
contour(xi,-ppres,squeeze(ac_sigma(flf,:,:))',[10:.5:30],'k')
line([0 0], [-1000 0])
caxis([-1 1])
colorbar
axis([-1.4 1.4 -1000 0])
daspect([1 300 1])
%daspect([1 300 1])
title('temperature of anticyclones')
