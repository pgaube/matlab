%
clear
load VOCALS_argo_3d
flf=find(yi==min(abs(yi)));
load rwp.pal
load cha_bwr.pal
load cha.pal
load chelle.pal


%
figure(1)
clf
%load /matlab/data/eddy/V4/full_tracks/air-sea_eio_lat_lon_tracks.mat lon lat nneg
load /matlab/data/eddy/V4/full_tracks/chaigneau_lat_lon_tracks.mat lon lat nneg
%load /matlab/data/eddy/V4/full_tracks/VOCALS_lat_lon_tracks.mat lon lat nneg

load VOCALS_eddy_argo_prof eddy_dist_x eddy_dist_y eddy_ist eddy_x eddy_y eddy_id
dist=sqrt(eddy_dist_x.^2+eddy_dist_y.^2);
tt=nansum(eddy_ist,1);
ii=find(tt>0);
xx=eddy_x(ii);
yy=eddy_y(ii);
idid=eddy_id(ii);
%lat=min(eddy_y(:)):max(eddy_y(:));
%lon=min(eddy_x(:)):max(eddy_x(:));
pmap(lon,lat,nan(length(lat),length(lon)))
hold on
ii=find(idid>=nneg);
for m=1:length(ii)
	m_plot(xx(ii(m)),yy(ii(m)),'r.')
end
ii=find(idid<nneg);
for m=1:length(ii)
	m_plot(xx(ii(m)),yy(ii(m)),'b.')
end
na=length(find(idid>=nneg));
nc=length(find(idid<nneg));
title([num2str(na),' profiles in AC and ',num2str(nc),' profiles in CC'])
drawnow
print -dpng -r300 figs/VOCALS_profile_map



figure(2)
clf
subplot(121)
contourf(xi,-ppres,squeeze(ac_sigma(flf,:,:))',[2:.5:40]);shading flat
hold on
line([0 0], [-1000 0])
axis([-1.5 1.5 -1000 0])
%daspect([1 300 1])
title('Density strucutre of anticyclones')
caxis([24 32])
colorbar
subplot(122)
contourf(xi,-ppres,squeeze(cc_sigma(flf,:,:))',[2:.5:40]);shading flat
hold on
line([0 0], [-1000 0])
caxis([24 32])
axis([-1.5 1.5 -1000 0])
%daspect([1 300 1])
title('Density strucutre of cyclones')
cc=colorbar;
axes(cc)
ylabel('\sigma_\theta (kg m^{-3})')
colormap(cha)

figure(3)
clf
subplot(121)
contourf(xi,-ppres,squeeze(ac_t_anom(flf,:,:))',[-2:.1:2]);shading flat
hold on
line([0 0], [-1000 0])
caxis([-1.5 1.5])
colorbar
axis([-1.5 1.5 -1000 0])
%daspect([1 300 1])
title('Temperature anomalies of anticyclones')
subplot(122)
contourf(xi,-ppres,squeeze(cc_t_anom(flf,:,:))',[-2:.1:2]);shading flat
hold on
line([0 0], [-1000 0])
caxis([-1.5 1.5])
load rwp.pal
colormap(cha)
axis([-1.5 1.5 -1000 0])
%daspect([1 300 1])
title('Temperature anomalies of cyclones')
cc=colorbar;
axes(cc)
ylabel('^\circ C')
print -dpng -r300 figs/VOCALS_tmp_anom

figure(4)
clf
subplot(121)
contourf(xi,-ppres,squeeze(ac_s_anom(flf,:,:))',[-2:.01:2]);shading flat
hold on
line([0 0], [-1000 0])
caxis([-.2 .2])
colorbar
axis([-1.5 1.5 -1000 0])
%daspect([1 300 1])
title('Salinity anomalies of anticyclones')
subplot(122)
contourf(xi,-ppres,squeeze(cc_s_anom(flf,:,:))',[-2:.01:2]);shading flat
hold on
line([0 0], [-1000 0])
caxis([-.2 .2])
load rwp.pal
colormap(cha)
axis([-1.5 1.5 -1000 0])
%daspect([1 300 1])
title('Salinity anomalies of cyclones')
cc=colorbar;
axes(cc)
ylabel('PSU')
print -dpng -r300 figs/VOCALS_sal_anom

figure(5)
clf
subplot(121)
contourf(xi,-ppres,squeeze(ac_sigma_anom(flf,:,:))',[-2:.01:2]);shading flat
hold on
line([0 0], [-1000 0])
caxis([-.25 .25])
colorbar
axis([-1.5 1.5 -1000 0])
%daspect([1 300 1])
title('Density anomalies of anticyclones')
subplot(122)
contourf(xi,-ppres,squeeze(cc_sigma_anom(flf,:,:))',[-2:.01:2]);shading flat
hold on
line([0 0], [-1000 0])
caxis([-.25 .25])
load rwp.pal
colormap(cha)
axis([-1.5 1.5 -1000 0])
%daspect([1 300 1])
title('Density anomalies of cyclones')
cc=colorbar;
axes(cc)
ylabel('\sigma_\theta (kg m^{-3})')
print -dpng -r300 figs/VOCALS_sigma_anom


figure(6)
clf
subplot(121)
contourf(xi,-ppres,squeeze(ac_v(flf,:,:))',[-2:.01:2]);shading flat
hold on
line([0 0], [-1000 0])
caxis([-.1 .1])
colorbar
axis([-1.5 1.5 -1000 0])
%daspect([1 300 1])
%daspect([1 300 1])
title('Geostrophic velocity of anticyclones')
subplot(122)
contourf(xi,-ppres,squeeze(cc_v(flf,:,:))',[-2:.01:2]);shading flat
hold on
line([0 0], [-1000 0])
caxis([-.1 .1])
colormap(cha)
axis([-1.5 1.5 -1000 0])
%daspect([1 300 1])
title('Geostrophic veloctiy of cyclones')
cc=colorbar;
axes(cc)
ylabel('(m s^{-1})')
print -dpng -r300 figs/VOCALS_gvel

figure(7)
clf
subplot(221)
contourf(xi,-ppres,squeeze(ac_v(flf,:,:))',[-2:.01:2]);shading flat
hold on
line([0 0], [-1000 0])
caxis([-.1 .1])
colorbar
axis([-1.5 1.5 -1000 0])
daspect([1 300 1])
%daspect([1 300 1])
title('Geostrophic velocity of anticyclones')
subplot(222)
contourf(xi,-ppres,squeeze(cc_v(flf,:,:))',[-2:.01:2]);shading flat
hold on
line([0 0], [-1000 0])
caxis([-.1 .1])
load rwp.pal
colormap(cha)
axis([-1.5 1.5 -1000 0])
daspect([1 300 1])
title('Geostrophic veloctiy of cyclones')
cc=colorbar;
axes(cc)
ylabel('(m s^{-1})')
subplot(223)
contourf(xi,-ppres,squeeze(ac_v_t(flf,:,:))',[-2:.01:2]);shading flat
hold on
line([0 0], [-1000 0])
caxis([-.1 .1])
colorbar
axis([-1.5 1.5 -1000 0])
daspect([1 300 1])
%daspect([1 300 1])
title('Geostrophic velocity from T of anticyclones')
subplot(224)
contourf(xi,-ppres,squeeze(cc_v_t(flf,:,:))',[-2:.01:2]);shading flat
hold on
line([0 0], [-1000 0])
caxis([-.1 .1])
load rwp.pal
colormap(cha)
axis([-1.5 1.5 -1000 0])
daspect([1 300 1])
title('Geostrophic veloctiy from T of cyclones')
cc=colorbar;
axes(cc)
ylabel('(m s^{-1})')
print -dpng -r300 figs/VOCALS_gvel_from_t
return

%}
figure(8)
clf

subplot(521)
contourf(xi,yi,fillnans(squeeze(cc_t_anom(:,:,find(ppres==100)))),[-2:.2:2]);axis image;hold on
contour(xi,yi,fillnans(squeeze(cc_t_anom(:,:,find(ppres==100)))),[-2:.2:2],'k');axis image
shading flat
colormap(cha)
line([-2.5 2.5],[0 0],'color','k')
line([0 0],[-2.5 2.5],'color','k')
caxis([-1 1])
title('temperature anomaly cyclones')
ylabel('100 m')
subplot(522)
contourf(xi,yi,fillnans(squeeze(ac_t_anom(:,:,find(ppres==100)))),[-2:.2:2]);axis image;hold on
contour(xi,yi,fillnans(squeeze(ac_t_anom(:,:,find(ppres==100)))),[-2:.2:2],'k');axis image
shading flat
colormap(cha)
line([-2.5 2.5],[0 0],'color','k')
line([0 0],[-2.5 2.5],'color','k')
caxis([-1 1])
title('temperature anomaly anticyclones')

subplot(523)
contourf(xi,yi,fillnans(squeeze(cc_t_anom(:,:,find(ppres==200)))),[-2:.2:2]);axis image;hold on
contour(xi,yi,fillnans(squeeze(cc_t_anom(:,:,find(ppres==200)))),[-2:.2:2],'k');axis image
shading flat
colormap(cha)
line([-2.5 2.5],[0 0],'color','k')
line([0 0],[-2.5 2.5],'color','k')
caxis([-1 1])
ylabel('200 m')
subplot(524)
contourf(xi,yi,fillnans(squeeze(ac_t_anom(:,:,find(ppres==200)))),[-2:.2:2]);axis image;hold on
contour(xi,yi,fillnans(squeeze(ac_t_anom(:,:,find(ppres==200)))),[-2:.2:2],'k');axis image
shading flat
colormap(cha)
line([-2.5 2.5],[0 0],'color','k')
line([0 0],[-2.5 2.5],'color','k')
caxis([-1 1])

subplot(525)
contourf(xi,yi,fillnans(squeeze(cc_t_anom(:,:,find(ppres==300)))),[-2:.2:2]);axis image;hold on
contour(xi,yi,fillnans(squeeze(cc_t_anom(:,:,find(ppres==300)))),[-2:.2:2],'k');axis image
shading flat
colormap(cha)
line([-2.5 2.5],[0 0],'color','k')
line([0 0],[-2.5 2.5],'color','k')
caxis([-1 1])
ylabel('300 m')
subplot(526)
contourf(xi,yi,fillnans(squeeze(ac_t_anom(:,:,find(ppres==300)))),[-2:.2:2]);axis image;hold on
contour(xi,yi,fillnans(squeeze(ac_t_anom(:,:,find(ppres==300)))),[-2:.2:2],'k');axis image
shading flat
colormap(cha)
line([-2.5 2.5],[0 0],'color','k')
line([0 0],[-2.5 2.5],'color','k')
caxis([-1 1])


subplot(527)
contourf(xi,yi,fillnans(squeeze(cc_t_anom(:,:,find(ppres==400)))),[-2:.2:2]);axis image;hold on
contour(xi,yi,fillnans(squeeze(cc_t_anom(:,:,find(ppres==400)))),[-2:.2:2],'k');axis image
shading flat
colormap(cha)
line([-2.5 2.5],[0 0],'color','k')
line([0 0],[-2.5 2.5],'color','k')
caxis([-1 1])
ylabel('400 m')
subplot(528)
contourf(xi,yi,fillnans(squeeze(ac_t_anom(:,:,find(ppres==400)))),[-2:.2:2]);axis image;hold on
contour(xi,yi,fillnans(squeeze(ac_t_anom(:,:,find(ppres==400)))),[-2:.2:2],'k');axis image
shading flat
colormap(cha)
line([-2.5 2.5],[0 0],'color','k')
line([0 0],[-2.5 2.5],'color','k')
caxis([-1 1])


subplot(529)
contourf(xi,yi,fillnans(squeeze(cc_t_anom(:,:,find(ppres==500)))),[-2:.2:2]);axis image;hold on
contour(xi,yi,fillnans(squeeze(cc_t_anom(:,:,find(ppres==500)))),[-2:.2:2],'k');axis image
shading flat
colormap(cha)
line([-2.5 2.5],[0 0],'color','k')
line([0 0],[-2.5 2.5],'color','k')
caxis([-1 1])
ylabel('500 m')
subplot(5,2,10)
contourf(xi,yi,fillnans(squeeze(ac_t_anom(:,:,find(ppres==500)))),[-2:.2:2]);axis image;hold on
contour(xi,yi,fillnans(squeeze(ac_t_anom(:,:,find(ppres==500)))),[-2:.2:2],'k');axis image
shading flat
colormap(cha)
line([-2.5 2.5],[0 0],'color','k')
line([0 0],[-2.5 2.5],'color','k')
caxis([-1 1])
print -dpng -r300 figs/VOCALS_temp_slices


figure(9)
clf
subplot(521)
contourf(xi,yi,fillnans(squeeze(100*cc_s_anom(:,:,find(ppres==100)))),[-20:2:20]);axis image;hold on
contour(xi,yi,fillnans(squeeze(100*cc_s_anom(:,:,find(ppres==100)))),[-20:2:20],'k');axis image
shading flat
colormap(cha)
line([-2.5 2.5],[0 0],'color','k')
line([0 0],[-2.5 2.5],'color','k')
caxis([-10 10])
ylabel('100 m')
title('salinity anomaly cyclones')
subplot(522)
contourf(xi,yi,fillnans(squeeze(100*ac_s_anom(:,:,find(ppres==100)))),[-20:2:20]);axis image;hold on
contour(xi,yi,fillnans(squeeze(100*ac_s_anom(:,:,find(ppres==100)))),[-20:2:20],'k');axis image
shading flat
colormap(cha)
line([-2.5 2.5],[0 0],'color','k')
line([0 0],[-2.5 2.5],'color','k')
caxis([-10 10])
title('salinity anomaly anticyclones')


subplot(523)
contourf(xi,yi,fillnans(squeeze(100*cc_s_anom(:,:,find(ppres==200)))),[-20:2:20]);axis image;hold on
contour(xi,yi,fillnans(squeeze(100*cc_s_anom(:,:,find(ppres==200)))),[-20:2:20],'k');axis image
shading flat
colormap(cha)
line([-2.5 2.5],[0 0],'color','k')
line([0 0],[-2.5 2.5],'color','k')
caxis([-10 10])
ylabel('200 m')
subplot(524)
contourf(xi,yi,fillnans(squeeze(100*ac_s_anom(:,:,find(ppres==200)))),[-20:2:20]);axis image;hold on
contour(xi,yi,fillnans(squeeze(100*ac_s_anom(:,:,find(ppres==200)))),[-20:2:20],'k');axis image
shading flat
colormap(cha)
line([-2.5 2.5],[0 0],'color','k')
line([0 0],[-2.5 2.5],'color','k')
caxis([-10 10])

subplot(525)
contourf(xi,yi,fillnans(squeeze(100*cc_s_anom(:,:,find(ppres==300)))),[-20:2:20]);axis image;hold on
contour(xi,yi,fillnans(squeeze(100*cc_s_anom(:,:,find(ppres==300)))),[-20:2:20],'k');axis image
shading flat
colormap(cha)
line([-2.5 2.5],[0 0],'color','k')
line([0 0],[-2.5 2.5],'color','k')
caxis([-10 10])
ylabel('300 m')
subplot(526)
contourf(xi,yi,fillnans(squeeze(100*ac_s_anom(:,:,find(ppres==300)))),[-20:2:20]);axis image;hold on
contour(xi,yi,fillnans(squeeze(100*ac_s_anom(:,:,find(ppres==300)))),[-20:2:20],'k');axis image
shading flat
colormap(cha)
line([-2.5 2.5],[0 0],'color','k')
line([0 0],[-2.5 2.5],'color','k')
caxis([-10 10])


subplot(527)
contourf(xi,yi,fillnans(squeeze(100*cc_s_anom(:,:,find(ppres==400)))),[-20:2:20]);axis image;hold on
contour(xi,yi,fillnans(squeeze(100*cc_s_anom(:,:,find(ppres==400)))),[-20:2:20],'k');axis image
shading flat
colormap(cha)
line([-2.5 2.5],[0 0],'color','k')
line([0 0],[-2.5 2.5],'color','k')
caxis([-10 10])
ylabel('400 m')
subplot(528)
contourf(xi,yi,fillnans(squeeze(100*ac_s_anom(:,:,find(ppres==400)))),[-20:2:20]);axis image;hold on
contour(xi,yi,fillnans(squeeze(100*ac_s_anom(:,:,find(ppres==400)))),[-20:2:20],'k');axis image
shading flat
colormap(cha)
line([-2.5 2.5],[0 0],'color','k')
line([0 0],[-2.5 2.5],'color','k')
caxis([-10 10])


subplot(529)
contourf(xi,yi,fillnans(squeeze(100*cc_s_anom(:,:,find(ppres==500)))),[-20:2:20]);axis image;hold on
contour(xi,yi,fillnans(squeeze(100*cc_s_anom(:,:,find(ppres==500)))),[-20:2:20],'k');axis image
shading flat
colormap(cha)
line([-2.5 2.5],[0 0],'color','k')
line([0 0],[-2.5 2.5],'color','k')
caxis([-10 10])
ylabel('500 m')
subplot(5,2,10)
contourf(xi,yi,fillnans(squeeze(100*ac_s_anom(:,:,find(ppres==500)))),[-20:2:20]);axis image;hold on
contour(xi,yi,fillnans(squeeze(100*ac_s_anom(:,:,find(ppres==500)))),[-20:2:20],'k');axis image
shading flat
colormap(cha)
line([-2.5 2.5],[0 0],'color','k')
line([0 0],[-2.5 2.5],'color','k')
caxis([-10 10])
print -dpng -r300 figs/VOCALS_sal_slices

figure(10)
clf
subplot(521)
contourf(xi,yi,fillnans(squeeze(cc_sigma_anom(:,:,find(ppres==100)))),[-.2:.05:.2]);axis image;hold on
contour(xi,yi,fillnans(squeeze(cc_sigma_anom(:,:,find(ppres==100)))),[-.2:.05:.2],'k');axis image
shading flat
colormap(cha)
line([-2.5 2.5],[0 0],'color','k')
line([0 0],[-2.5 2.5],'color','k')
%caxis([-.2 .2])
ylabel('100 m')
title('sigma anomaly cyclones')
subplot(522)
contourf(xi,yi,fillnans(squeeze(ac_sigma_anom(:,:,find(ppres==100)))),[-.2:.05:.2]);axis image;hold on
contour(xi,yi,fillnans(squeeze(ac_sigma_anom(:,:,find(ppres==100)))),[-.2:.05:.2],'k');axis image
shading flat
colormap(cha)
line([-2.5 2.5],[0 0],'color','k')
line([0 0],[-2.5 2.5],'color','k')
%caxis([-.2 .2])
title('sigma anomaly anticyclones')


subplot(523)
contourf(xi,yi,fillnans(squeeze(cc_sigma_anom(:,:,find(ppres==200)))),[-.2:.05:.2]);axis image;hold on
contour(xi,yi,fillnans(squeeze(cc_sigma_anom(:,:,find(ppres==200)))),[-.2:.05:.2],'k');axis image
shading flat
colormap(cha)
line([-2.5 2.5],[0 0],'color','k')
line([0 0],[-2.5 2.5],'color','k')
%caxis([-.2 .2])
ylabel('200 m')
subplot(524)
contourf(xi,yi,fillnans(squeeze(ac_sigma_anom(:,:,find(ppres==200)))),[-.2:.05:.2]);axis image;hold on
contour(xi,yi,fillnans(squeeze(ac_sigma_anom(:,:,find(ppres==200)))),[-.2:.05:.2],'k');axis image
shading flat
colormap(cha)
line([-2.5 2.5],[0 0],'color','k')
line([0 0],[-2.5 2.5],'color','k')
%caxis([-.2 .2])

subplot(525)
contourf(xi,yi,fillnans(squeeze(cc_sigma_anom(:,:,find(ppres==300)))),[-.2:.05:.2]);axis image;hold on
contour(xi,yi,fillnans(squeeze(cc_sigma_anom(:,:,find(ppres==300)))),[-.2:.05:.2],'k');axis image
shading flat
colormap(cha)
line([-2.5 2.5],[0 0],'color','k')
line([0 0],[-2.5 2.5],'color','k')
%caxis([-.2 .2])
ylabel('300 m')
subplot(526)
contourf(xi,yi,fillnans(squeeze(ac_sigma_anom(:,:,find(ppres==300)))),[-.2:.05:.2]);axis image;hold on
contour(xi,yi,fillnans(squeeze(ac_sigma_anom(:,:,find(ppres==300)))),[-.2:.05:.2],'k');axis image
shading flat
colormap(cha)
line([-2.5 2.5],[0 0],'color','k')
line([0 0],[-2.5 2.5],'color','k')
%caxis([-.2 .2])


subplot(527)
contourf(xi,yi,fillnans(squeeze(cc_sigma_anom(:,:,find(ppres==400)))),[-.2:.05:.2]);axis image;hold on
contour(xi,yi,fillnans(squeeze(cc_sigma_anom(:,:,find(ppres==400)))),[-.2:.05:.2],'k');axis image
shading flat
colormap(cha)
line([-2.5 2.5],[0 0],'color','k')
line([0 0],[-2.5 2.5],'color','k')
%caxis([-.2 .2])
ylabel('400 m')
subplot(528)
contourf(xi,yi,fillnans(squeeze(ac_sigma_anom(:,:,find(ppres==400)))),[-.2:.05:.2]);axis image;hold on
contour(xi,yi,fillnans(squeeze(ac_sigma_anom(:,:,find(ppres==400)))),[-.2:.05:.2],'k');axis image
shading flat
colormap(cha)
line([-2.5 2.5],[0 0],'color','k')
line([0 0],[-2.5 2.5],'color','k')
%caxis([-.2 .2])


subplot(529)
contourf(xi,yi,fillnans(squeeze(cc_sigma_anom(:,:,find(ppres==500)))),[-.2:.05:.2]);axis image;hold on
contour(xi,yi,fillnans(squeeze(cc_sigma_anom(:,:,find(ppres==500)))),[-.2:.05:.2],'k');axis image
shading flat
colormap(cha)
line([-2.5 2.5],[0 0],'color','k')
line([0 0],[-2.5 2.5],'color','k')
%caxis([-.2 .2])
ylabel('500 m')
subplot(5,2,10)
contourf(xi,yi,fillnans(squeeze(ac_sigma_anom(:,:,find(ppres==500)))),[-.2:.05:.2]);axis image;hold on
contour(xi,yi,fillnans(squeeze(ac_sigma_anom(:,:,find(ppres==500)))),[-.2:.05:.2],'k');axis image
shading flat
colormap(cha)
line([-2.5 2.5],[0 0],'color','k')
line([0 0],[-2.5 2.5],'color','k')
%caxis([-.2 .2])
print -dpng -r300 figs/VOCALS_sal_dens
return



subplot(323)
contourf(xi,yi,fillnans(squeeze(100*cc_s_anom(:,:,ipc))),[[-20:2:20]]);axis image;hold on
contour(xi,yi,fillnans(squeeze(100*cc_s_anom(:,:,ipc))),[[-20:2:20]],'k');axis image
shading flat
colormap(cha_bwr)
line([-2.5 2.5],[0 0],'color','k')
line([0 0],[-2.5 2.5],'color','k')
caxis([-10 10])
ylabel('salinity anomaly')
colorbar
freezecolors
subplot(324)
contourf(xi,yi,fillnans(squeeze(100*ac_s_anom(:,:,ipa))),[[-20:2:20]]);axis image;hold on
contour(xi,yi,fillnans(squeeze(100*ac_s_anom(:,:,ipa))),[[-20:2:20]],'k');axis image
shading flat
colormap(cha_bwr)
line([-2.5 2.5],[0 0],'color','k')
line([0 0],[-2.5 2.5],'color','k')
caxis([-10 10])
colorbar
freezecolors

subplot(325)
contourf(xi,yi,squeeze(100*cc_spd(:,:,ipc)),[-20:1:20]);axis image
shading flat
colormap(jet)
line([-2.5 2.5],[0 0],'color','k')
line([0 0],[-2.5 2.5],'color','k')
caxis([-0 10])
ylabel('geostro speed')
colorbar
subplot(326)
contourf(xi,yi,squeeze(100*ac_spd(:,:,ipa)),[-20:1:20]);axis image
shading flat
colormap(jet)
line([-2.5 2.5],[0 0],'color','k')
line([0 0],[-2.5 2.5],'color','k')
caxis([-0 10])
colorbar
print -dpng -r300 figs/VOCALS_horz_tmp_sal



figure(10)
clf
subplot(121)
contourf(xi,-ppres,squeeze(ac_ss(flf,:,:))',[20:.1:30]);shading flat
hold on
line([0 0], [ 0])
axis([-1.5 1.5 -1000 0])
%daspect([1 300 1])
title('Density strucutre of smoothed anticyclones')
caxis([24 30])
colorbar
subplot(122)
contourf(xi,-ppres,squeeze(cc_ss(flf,:,:))',[20:.1:30]);shading flat
hold on
line([0 0], [ 0])
caxis([24 30])
axis([-1.5 1.5 -1000 0])
%daspect([1 300 1])
title('Density strucutre of smoothed cyclones')
cc=colorbar;
axes(cc)
ylabel('\sigma_\theta (kg m^{-3})')
colormap(cha)


figure(9)
clf
subplot(322)
contourf(xi,-ppres,squeeze(ac_t_anom(:,flf,:))',[-2:.1:2]);shading flat
hold on
%contour(xi,-ppres,squeeze(ac_sigma(:,flf,:))',[20:.1:30],'k')
line([0 0], [-1000 0])
caxis([-1 1])
colorbar
axis([-1.5 1.5 -1000 0])
daspect([1 300 1])
line([-2 2],[-530 -530],'color','k')
title('Temperature anomalies of anticyclones')
subplot(321)
contourf(xi,-ppres,squeeze(cc_t_anom(:,flf,:))',[-2:.1:2]);shading flat
hold on
%contour(xi,-ppres,squeeze(cc_sigma(:,flf,:))',[20:.1:30],'k')
line([0 0], [-1000 0])
caxis([-1 1])
load rwp.pal
colormap(cha)
axis([-1.5 1.5 -1000 0])
daspect([1 300 1])
line([-2 2],[-240 -240],'color','k')
title('Temperature anomalies of cyclones')
cc=colorbar;
axes(cc)
ylabel('^\circ C')


subplot(324)
contourf(xi,-ppres,squeeze(ac_s_anom(:,flf,:))',[-2:.01:2]);shading flat
hold on
%contour(xi,-ppres,squeeze(ac_sigma(:,flf,:))',[20:.1:30],'k')
line([0 0], [-1000 0])
caxis([-.1 .1])
colorbar
axis([-1.5 1.5 -1000 0])
daspect([1 300 1])
line([-2 2],[-530 -530],'color','k')
title('Salinity anomalies of anticyclones')
subplot(323)
contourf(xi,-ppres,squeeze(cc_s_anom(:,flf,:))',[-2:.01:2]);shading flat
hold on
%contour(xi,-ppres,squeeze(cc_sigma(:,flf,:))',[20:.1:30],'k')
line([0 0], [-1000 0])
caxis([-.1 .1])
load rwp.pal
colormap(cha)
axis([-1.5 1.5 -1000 0])
daspect([1 300 1])
line([-2 2],[-240 -240],'color','k')
title('Salinity anomalies of cyclones')
cc=colorbar;
axes(cc)
ylabel('PSU')


subplot(326)
contourf(xi,-ppres,squeeze(ac_u(:,flf,:))',[-2:.01:2]);shading flat
hold on
%contour(xi,-ppres,squeeze(ac_sigma(:,flf,:))',[20:.1:30],'k')
line([0 0], [-1000 0])
caxis([-.1 .1])
colorbar
axis([-1.5 1.5 -1000 0])
daspect([1 300 1])
daspect([1 300 1])
line([-2 2],[-530 -530],'color','k')
title('Geostrophic velocity of anticyclones')
subplot(325)
contourf(xi,-ppres,squeeze(cc_u(:,flf,:))',[-2:.01:2]);shading flat
hold on
%contour(xi,-ppres,squeeze(cc_sigma(:,flf,:))',[20:.1:30],'k')
line([0 0], [-1000 0])
caxis([-.1 .1])
load rwp.pal
colormap(cha)
axis([-1.5 1.5 -1000 0])
daspect([1 300 1])
line([-2 2],[-240 -240],'color','k')
title('Geostrophic veloctiy of cyclones')
cc=colorbar;
axes(cc)
ylabel('(m s^{-1})')
warning('on','all')
print -dpng -r300 figs/VOCALS_chan_fig_5_merid

figure(6)
clf
subplot(322)
contourf(xi,-ppres,squeeze(ac_t_anom(flf,:,:))',[-2:.1:2]);shading flat
hold on
%contour(xi,-ppres,squeeze(ac_sigma(flf,:,:))',[20:.1:30],'k')
line([0 0], [-1000 0])
caxis([-1 1])
colorbar
axis([-1.5 1.5 -1000 0])
daspect([1 300 1])
line([-2 2],[-530 -530],'color','k')
title('Temperature anomalies of anticyclones')
subplot(321)
contourf(xi,-ppres,squeeze(cc_t_anom(flf,:,:))',[-2:.1:2]);shading flat
hold on
%contour(xi,-ppres,squeeze(cc_sigma(flf,:,:))',[20:.1:30],'k')
line([0 0], [-1000 0])
caxis([-1 1])
load rwp.pal
colormap(cha)
axis([-1.5 1.5 -1000 0])
daspect([1 300 1])
line([-2 2],[-240 -240],'color','k')
title('Temperature anomalies of cyclones')
cc=colorbar;
axes(cc)
ylabel('^\circ C')


subplot(324)
contourf(xi,-ppres,squeeze(ac_s_anom(flf,:,:))',[-2:.01:2]);shading flat
hold on
%contour(xi,-ppres,squeeze(ac_sigma(flf,:,:))',[20:.1:30],'k')
line([0 0], [-1000 0])
caxis([-.1 .1])
colorbar
axis([-1.5 1.5 -1000 0])
daspect([1 300 1])
line([-2 2],[-530 -530],'color','k')
title('Salinity anomalies of anticyclones')
subplot(323)
contourf(xi,-ppres,squeeze(cc_s_anom(flf,:,:))',[-2:.01:2]);shading flat
hold on
%contour(xi,-ppres,squeeze(cc_sigma(flf,:,:))',[20:.1:30],'k')
line([0 0], [-1000 0])
caxis([-.1 .1])
load rwp.pal
colormap(cha)
axis([-1.5 1.5 -1000 0])
daspect([1 300 1])
line([-2 2],[-240 -240],'color','k')
title('Salinity anomalies of cyclones')
cc=colorbar;
axes(cc)
ylabel('PSU')


subplot(326)
contourf(xi,-ppres,squeeze(ac_v(flf,:,:))',[-2:.01:2]);shading flat
hold on
%contour(xi,-ppres,squeeze(ac_sigma(flf,:,:))',[20:.1:30],'k')
line([0 0], [-1000 0])
caxis([-.1 .1])
colorbar
axis([-1.5 1.5 -1000 0])
daspect([1 300 1])
daspect([1 300 1])
line([-2 2],[-530 -530],'color','k')
title('Geostrophic velocity of anticyclones')
subplot(325)
contourf(xi,-ppres,squeeze(cc_v(flf,:,:))',[-2:.01:2]);shading flat
hold on
%contour(xi,-ppres,squeeze(cc_sigma(flf,:,:))',[20:.1:30],'k')
line([0 0], [-1000 0])
caxis([-.1 .1])
load rwp.pal
colormap(cha)
axis([-1.5 1.5 -1000 0])
daspect([1 300 1])
line([-2 2],[-240 -240],'color','k')
title('Geostrophic veloctiy of cyclones')
cc=colorbar;
axes(cc)
ylabel('(m s^{-1})')
warning('on','all')
print -dpng -r300 figs/VOCALS_chan_fig_5