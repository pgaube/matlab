%
clear
load pCC_argo_2d
load rwp.pal
load cha_bwr.pal
load cha.pal
load chelle.pal
load bwr.pal



%load /matlab/data/eddy/V4/full_tracks/air-sea_eio_lat_lon_tracks.mat lon lat nneg
%load /matlab/data/eddy/V4/full_tracks/chaigneau_lat_lon_tracks.mat lon lat nneg
load /matlab/data/eddy/V4/full_tracks/pCC_lat_lon_tracks.mat lon lat nneg prop_speed

c_spd=pmean(prop_speed)/100;


load pCC_eddy_argo_prof eddy_dist_x eddy_dist_y eddy_ist eddy_x eddy_y eddy_id eddy_ist ia ic
tt=nansum(eddy_ist,1);
ii=find(tt==0);

dist=sqrt(eddy_dist_x.^2+eddy_dist_y.^2);
dist(ii)=nan;
dist(eddy_dist_x<0)=-dist(eddy_dist_x<0);
step=.1;
tbins=-2.2:step:2.2;
[ba,nda]=phist(dist(ia),tbins);
[bc,ndc]=phist(dist(ic),tbins);

for m=1:length(ppres)
	ac_max_speed(m)=max(ac_spd(m,:));
	cc_max_speed(m)=max(cc_spd(m,:));
end

ac_non=ac_max_speed./c_spd;
cc_non=cc_max_speed./c_spd;

i_non_ac=find(ac_non<1);
i_non_ac=i_non_ac(1);
i_non_cc=find(cc_non<1);
i_non_cc=i_non_cc(1);




%
%
figure(1)
clf
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
print -dpng -r300 figs/2d/pCC_profile_map

figure(9)
clf
subplot(121)
ii=find(tt>0 & eddy_id'>=nneg);
xx=eddy_dist_x(ii);
yy=eddy_dist_y(ii);
scatter(xx,yy,'r.')
axis equal
axis([-2 2 -2 2])
line([0 0],[-2 2],'color','k')
line([-2 2],[0 0],'color','k')
title('profiles in AC')

subplot(122)
ii=find(tt>0 & eddy_id'<nneg);
xx=eddy_dist_x(ii);
yy=eddy_dist_y(ii);
scatter(xx,yy,'b.')
axis equal
axis([-2 2 -2 2])
line([0 0],[-2 2],'color','k')
line([-2 2],[0 0],'color','k')
title('profiles in CC')
print -dpng -r300 figs/2d/pCC_profile_loc_comps



figure(2)
clf
subplot(121)
contourf(xi,-ppres,ac_sigma,[2:.5:40]);shading flat
hold on
line([0 0], [-1000 0])
axis([-2 2 -1000 0])
%daspect([1 300 1])
title('Density strucutre of anticyclones')
caxis([24 32])
colorbar
subplot(122)
contourf(xi,-ppres,cc_sigma,[2:.5:40]);shading flat
hold on
line([0 0], [-1000 0])
caxis([24 32])
axis([-2 2 -1000 0])
%daspect([1 300 1])
title('Density strucutre of cyclones')
cc=colorbar;
axes(cc)
ylabel('\sigma_\theta (kg m^{-3})')
colormap(cha)

figure(3)
clf
subplot(121)
contourf(xi,-ppres,ac_t_anom,[-2:.1:2]);shading flat
hold on
line([0 0], [-1000 0])
caxis([-1.5 1.5])
colorbar
axis([-2 2 -1000 0])
%daspect([1 300 1])
title('Temperature anomalies of anticyclones')
subplot(122)
contourf(xi,-ppres,cc_t_anom,[-2:.1:2]);shading flat
hold on
line([0 0], [-1000 0])
caxis([-1.5 1.5])
load rwp.pal
colormap(cha)
axis([-2 2 -1000 0])
%daspect([1 300 1])
title('Temperature anomalies of cyclones')
cc=colorbar;
axes(cc)
ylabel('^\circ C')
print -dpng -r300 figs/2d/pCC_tmp_anom

figure(4)
clf
subplot(121)
contourf(xi,-ppres,ac_s_anom,[-2:.01:2]);shading flat
hold on
line([0 0], [-1000 0])
caxis([-.2 .2])
colorbar
axis([-2 2 -1000 0])
%daspect([1 300 1])
title('Salinity anomalies of anticyclones')
subplot(122)
contourf(xi,-ppres,cc_s_anom,[-2:.01:2]);shading flat
hold on
line([0 0], [-1000 0])
caxis([-.2 .2])
load rwp.pal
colormap(cha)
axis([-2 2 -1000 0])
%daspect([1 300 1])
title('Salinity anomalies of cyclones')
cc=colorbar;
axes(cc)
ylabel('PSU')
print -dpng -r300 figs/2d/pCC_sal_anom

figure(5)
clf
subplot(121)
contourf(xi,-ppres,ac_sigma_anom,[-2:.01:2]);shading flat
hold on
line([0 0], [-1000 0])
caxis([-.25 .25])
colorbar
axis([-2 2 -1000 0])
%daspect([1 300 1])
title('Density anomalies of anticyclones')
subplot(122)
contourf(xi,-ppres,cc_sigma_anom,[-2:.01:2]);shading flat
hold on
line([0 0], [-1000 0])
caxis([-.25 .25])
load rwp.pal
colormap(cha)
axis([-2 2 -1000 0])
%daspect([1 300 1])
title('Density anomalies of cyclones')
cc=colorbar;
axes(cc)
ylabel('\sigma_\theta (kg m^{-3})')
print -dpng -r300 figs/2d/pCC_sigma_anom

%
figure(6)
clf
subplot(221)
stairs(tbins(1:end-1),nda,'r')
set(gca,'xlim',[-1.5 1.5])
subplot(223)
contourf(xi,-ppres,ac_v,[-2:.01:2]);shading flat
hold on
line([0 0], [-1000 0])
caxis([-.2 .2])
%colorbar
axis([-2 2 -1000 0])
%daspect([1 300 1])
%daspect([1 300 1])
title('Geostrophic v velocity of anticyclones')
subplot(222)
stairs(tbins(1:end-1),ndc,'b')
set(gca,'xlim',[-1.5 1.5])
subplot(224)
contourf(xi,-ppres,cc_v,[-2:.01:2]);shading flat
hold on
line([0 0], [-1000 0])
caxis([-.2 .2])
colormap(cha)
axis([-2 2 -1000 0])
%daspect([1 300 1])
title('Geostrophic v veloctiy of cyclones')
%cc=colorbar;
%axes(cc)
%ylabel('(m s^{-1})')

print -dpng -r300 figs/2d/pCC_gvel_histo

%}
figure(7)
clf
subplot(121)
contourf(xi,-ppres,ac_v,[-2:.01:2]);shading flat
hold on
contour(xi,-ppres,ac_v,[-.1 -.05],'k--')
contour(xi,-ppres,ac_v,[.05 .1],'k')
hold on
line([0 0], [-1000 0])
line([-1 -1], [-1000 0],'color',[.5 .5 .5],'linewidth',2,'linestyle','-.')
line([1 1], [-1000 0],'color',[.5 .5 .5],'linewidth',2,'linestyle','-.')
line([-8 8],[-ppres(i_non_ac) -ppres(i_non_ac)],'color','k','linewidth',2,'linestyle','--')
caxis([-.1 .1])
contour(xi,-ppres,ac_crl,[0 0],'k','linewidth',1)
cc=colorbar
axis([-2 2 -1000 0])

%daspect([1 300 1])
%daspect([1 300 1])
title('Geostrophic v velocity of anticyclones')

subplot(122)
contourf(xi,-ppres,cc_v,[-2:.01:2]);shading flat
hold on
contour(xi,-ppres,cc_v,[-.1 -.05],'k--')
contour(xi,-ppres,cc_v,[.05 .1],'k')
hold on
line([0 0], [-1000 0])
line([-1 -1], [-1000 0],'color',[.5 .5 .5],'linewidth',2,'linestyle','-.')
line([1 1], [-1000 0],'color',[.5 .5 .5],'linewidth',2,'linestyle','-.')
line([-8 8],[-ppres(i_non_cc) -ppres(i_non_cc)],'color','k','linewidth',2,'linestyle','--')
caxis([-.1 .1])
contour(xi,-ppres,cc_crl,[0 0],'k','linewidth',1)
colormap(bwr)
axis([-2 2 -1000 0])
%daspect([1 300 1])
title('Geostrophic v veloctiy of cyclones')
xlabel('contour of \nabla \times u = 0')

cc=colorbar;
axes(cc)

ylabel('(m s^{-1})')
print -dpng -r300 figs/2d/pCC_gvel


figure(8)
clf
plot(cc_max_speed./c_spd,-ppres,'b')
hold on
plot(ac_max_speed./c_spd,-ppres,'r')
line([1 1],[-1000 0],'color','k')
line([0 8],[-ppres(i_non_ac) -ppres(i_non_ac)],'color','r')
line([0 8],[-ppres(i_non_cc) -ppres(i_non_cc)],'color','b')
text(4,-700,num2str(ppres(i_non_ac)))
text(4,-400,num2str(ppres(i_non_cc)))
title({'Vertical profiles of the nonlinearity parameter U/c','c=2.78 cm s^{-1}'})
ylabel('pressure (dbars)')
xlabel('U/c')

print -dpng -r300 figs/2d/pCC_u_over_c

return
