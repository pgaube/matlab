%
clear

load LW_argo_3d
load rwp.pal
load cha_bwr.pal
load cha.pal
load chelle.pal
load bwr.pal


flf=find(yi==min(abs(yi)));

load LW_eddy_argo_prof.mat   
load /matlab/data/eddy/V4/full_tracks/LW_lat_lon_tracks.mat lon lat nneg prop_speed amp scale track_jday id amp axial_speed

tt=nansum(eddy_ist,1);
ii=find(tt>0); 

eddy_id=eddy_id(ii);
eddy_pjday_round=eddy_pjday_round(ii);

for m=1:length(eddy_id)
	same_prof(m)=find(id==eddy_id(m) & track_jday==eddy_pjday_round(m));
end	

id=id(same_prof);
amp=amp(same_prof);
scale=scale(same_prof);
axial_speed=axial_speed(same_prof);

ia=find(id>=nneg);
ic=find(id<nneg);

med_srf_spd_ac=nanmedian(axial_speed(ia))./100;
med_srf_spd_cc=nanmedian(axial_speed(ic))./100;
mean_srf_spd_ac=nanmean(axial_speed(ia))./100;
mean_srf_spd_cc=nanmean(axial_speed(ic))./100;

c_spd=pmean(prop_speed)/100;


load LW_eddy_argo_prof eddy_dist_x eddy_dist_y eddy_ist eddy_x eddy_y eddy_id eddy_ist ia ic
tt=nansum(eddy_ist,1);
ii=find(tt==0);

dist=sqrt(eddy_dist_x.^2+eddy_dist_y.^2);
dist(ii)=nan;
dist(eddy_dist_x<0)=-dist(eddy_dist_x<0);
step=.1;
tbins=-2.2:step:2.2;
[ba,nda]=phist(dist(ia),tbins);
[bc,ndc]=phist(dist(ic),tbins);

[r,c]=imap(-1.5,1.5,-1.5,1.5,xi,yi);

for m=1:length(ppres)
	sp=ac_spd(flf,c,m);
	ac_max_speed(m)=max(sp(:));
	sp=cc_spd(flf,c,m);
	cc_max_speed(m)=max(sp(:));
end

ac_non=ac_max_speed./c_spd;
cc_non=cc_max_speed./c_spd;

i_non_ac=find(ac_non<1);
i_non_ac=i_non_ac(1);
i_non_cc=find(cc_non<1);
i_non_cc=i_non_cc(1);

i_max_ac=find(ac_max_speed==max(ac_max_speed(1:end)));
%i_max_ac=1
i_max_cc=find(cc_max_speed==max(cc_max_speed(1:end)));

load LW_eddy_argo_prof eddy_scale eddy_y
km_x=pmean(eddy_scale)*xi;
ff=f_cor(pmean(eddy_y));


dx=1000*pmean(diff(km_x));


ac_sm_v=smooth2d_loess(squeeze(ac_v(flf,:,:))',xi,ppres,3,200,xi,ppres);
cc_sm_v=smooth2d_loess(squeeze(cc_v(flf,:,:))',xi,ppres,3,200,xi,ppres);

for m=1:length(ppres);
	ac_crl_sec(m,:)=dfdx_m(ac_sm_v(m,:),dx);
	cc_crl_sec(m,:)=dfdx_m(cc_sm_v(m,:),dx);
end	



%
%
figure(1)
clf
pmap(lon,lat,nan(length(lat),length(lon)))
hold on
for m=1:length(eddy_x)
	m_plot(eddy_x(m),eddy_y(m),'.','color',[.5 .5 .5])
end
ii=find(tt>0);
xx=eddy_x(ii);
yy=eddy_y(ii);
idid=eddy_id(ii);
%lat=min(eddy_y(:)):max(eddy_y(:));
%lon=min(eddy_x(:)):max(eddy_x(:));

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
print -dpng -r300 figs/3d/LW_profile_map

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
print -dpng -r300 figs/3d/LW_profile_loc_comps



figure(2)
clf
subplot(121)
contourf(xi,-ppres,squeeze(ac_sigma(flf,:,:))',[2:.2:40]);shading flat
hold on
line([0 0], [-1000 0])
axis([-1.5 1.5 -1000 0])
%daspect([1 300 1])
title('Density strucutre of anticyclones')
caxis([24 32])
colorbar
subplot(122)
contourf(xi,-ppres,squeeze(cc_sigma(flf,:,:))',[2:.2:40]);shading flat
hold on
line([0 0], [-1000 0])
caxis([24 32])
axis([-1.5 1.5 -1000 0])
%daspect([1 300 1])
title('Density strucutre of cyclones')
cc=colorbar;
axes(cc)
ylabel('\sigma_\theta (kg m^{-3})')
colormap(chelle)
print -dpng -r300 figs/3d/LW_sigma

%}
figure(6)
clf
subplot(121)
contourf(xi,-ppres,squeeze(100*ac_v(flf,:,:))',[-200:200]);shading flat
hold on
contour(xi,-ppres,squeeze(100*ac_v(flf,:,:))',[-10 -5],'k--');
contour(xi,-ppres,squeeze(100*ac_v(flf,:,:))',[3 7],'k');
hold on
contour(xi,-ppres,ac_crl_sec,[0 0],'k','linewidth',1)
%contour(xi,-ppres,squeeze(ac_crl(flf,:,:))',[0 0],'k','linewidth',1)
line([0 0], [-1000 0])
caxis([-10 10])
colorbar
axis([-2.2 2.2 -1000 0])
%daspect([1 300 1])
%daspect([1 300 1])
title('Geostrophic velocity of anticyclones')
line([0 0], [-1000 0])
%line([-1.5 -1.5], [-1000 0],'color',[.5 .5 .5],'linewidth',.5,'linestyle','--')
%line([1.5 1.5], [-1000 0],'color',[.5 .5 .5],'linewidth',.5,'linestyle','--')
line([-1 -1], [-1000 0],'color',[.5 .5 .5],'linewidth',2,'linestyle','-.')
line([1 1], [-1000 0],'color',[.5 .5 .5],'linewidth',2,'linestyle','-.')
line([-8 8],[-ppres(i_non_ac) -ppres(i_non_ac)],'color','k','linewidth',2,'linestyle','--')
line([-8 8],[-ppres(i_max_ac) -ppres(i_max_ac)],'color','w','linewidth',2,'linestyle','--')
xlabel('contour interval 5 cm s^{-1}')

subplot(122)
contourf(xi,-ppres,squeeze(100*cc_v(flf,:,:))',[-200:200]);shading flat
hold on
contour(xi,-ppres,cc_crl_sec,[0 0],'k','linewidth',1)
contour(xi,-ppres,squeeze(100*cc_v(flf,:,:))',[-10 -5],'k--');
contour(xi,-ppres,squeeze(100*cc_v(flf,:,:))',[5 10],'k')
%contour(xi,-ppres,squeeze(cc_crl(flf,:,:))',[0 0],'k','linewidth',1)
line([0 0], [-1000 0])
line([0 0], [-1000 0])
line([-1 -1], [-1000 0],'color',[.5 .5 .5],'linewidth',2,'linestyle','-.')
line([1 1], [-1000 0],'color',[.5 .5 .5],'linewidth',2,'linestyle','-.')
line([-1.5 -1.5], [-1000 0],'color',[.5 .5 .5],'linewidth',.5,'linestyle','--')
line([1.5 1.5], [-1000 0],'color',[.5 .5 .5],'linewidth',.5,'linestyle','--')
line([-8 8],[-ppres(i_non_cc) -ppres(i_non_cc)],'color','k','linewidth',2,'linestyle','--')
line([-8 8],[-ppres(i_max_cc) -ppres(i_max_cc)],'color','w','linewidth',2,'linestyle','--')
caxis([-10 10])
colormap(chelle)
axis([-2.2 2.2 -1000 0])
%daspect([1 300 1])
title('Geostrophic veloctiy of cyclones')
xlabel('contour of \nabla \times u = 0')
cc=colorbar;
axes(cc)
ylabel('(cm s^{-1})')
print -dpng -r300 figs/3d/LW_gvel

figure(8)
clf
plot(100*cc_max_speed,-ppres,'b')
hold on
plot(100*ac_max_speed,-ppres,'r')
line([100*c_spd 100*c_spd],[-1000 0],'color','k')
line([0 80],[-ppres(i_non_ac) -ppres(i_non_ac)],'color','r')
line([0 80],[-ppres(i_non_cc) -ppres(i_non_cc)],'color','b')
text(.2,-ppres(i_non_ac)-30,num2str(ppres(i_non_ac)))
text(.2,-ppres(i_non_cc)-30,num2str(ppres(i_non_cc)))
title({'Vertical profiles of the nonlinearity parameter U/c','c=2.78 cm s^{-1}'})
ylabel('pressure (dbars)')
xlabel('rotaional velocoty (cm s^{-1})')
axis([0 20 -1000 0])
line([100*mean_srf_spd_ac 100*mean_srf_spd_ac],[-1000 0],'color','r')
line([100*mean_srf_spd_cc 100*mean_srf_spd_cc],[-1000 0],'color','b')
line([100*med_srf_spd_ac 100*med_srf_spd_ac],[-1000 0],'color','r','linestyle','--')
line([100*med_srf_spd_cc 100*med_srf_spd_cc],[-1000 0],'color','b','linestyle','--')
print -dpng -r300 figs/3d/LW_u_over_c

[r,c]=imap(-2,2,-2,2,xi,yi);

figure(7)
clf
subplot(121)
contourf(xi(r),yi(c),squeeze(ac_spd(r,c,i_max_cc))',[0:.01:2]);shading flat;hold on
contour(xi(r),yi(c),squeeze(ac_spd(r,c,i_max_cc))',[0:.02:2],'k');
axis image
title('Speed of AC at level of max speed')
xlabel(['z = ',num2str(ppres(i_max_ac))])
line([-2.5 2.5],[0 0],'color','k')
line([0 0],[-2.5 2.5],'color','k')
colorbar
subplot(122)
contourf(xi(r),yi(c),squeeze(cc_spd(r,c,i_max_ac))',[0:.01:2]);shading flat;hold on
contour(xi(r),yi(c),squeeze(cc_spd(r,c,i_max_cc))',[0:.02:2],'k');
axis image
title('Speed of cC at level of max speed')
xlabel(['z = ',num2str(ppres(i_max_cc))])
line([-2.5 2.5],[0 0],'color','k')
line([0 0],[-2.5 2.5],'color','k')
colorbar
colormap(chelle)
print -dpng -r300 figs/3d/LW_speed_plan




return

subplot(221)
contourf(xi,-ppres,squeeze(ac_v(flf,:,:))',[-2:.01:2]);shading flat
hold on
line([0 0], [-1000 0])
caxis([-.1 .1])
colorbar
axis([-1.5 1.5 -1000 0])
daspect([1 300 1])
%daspect([1 300 1])
title('Geostrophic v velocity of anticyclones')
subplot(222)
contourf(xi,-ppres,squeeze(cc_v(flf,:,:))',[-2:.01:2]);shading flat
hold on
line([0 0], [-1000 0])
caxis([-.1 .1])
load rwp.pal
colormap(cha)
axis([-1.5 1.5 -1000 0])
daspect([1 300 1])
title('Geostrophic v veloctiy of cyclones')
cc=colorbar;
axes(cc)
ylabel('(m s^{-1})')
subplot(223)
contourf(xi,-ppres,squeeze(ac_u(:,flf,:))',[-2:.01:2]);shading flat
hold on
line([0 0], [-1000 0])
caxis([-.1 .1])
colorbar
axis([-1.5 1.5 -1000 0])
daspect([1 300 1])
%daspect([1 300 1])
title('Geostrophic u velocity of anticyclones')
subplot(224)
contourf(xi,-ppres,squeeze(cc_u(:,flf,:))',[-2:.01:2]);shading flat
hold on
line([0 0], [-1000 0])
caxis([-.1 .1])
load rwp.pal
colormap(cha)
axis([-1.5 1.5 -1000 0])
daspect([1 300 1])
title('Geostrophic u veloctiy of cyclones')
cc=colorbar;
axes(cc)
ylabel('(m s^{-1})')
print -dpng -r300 figs/3d/LW_gvel_4_way

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
print -dpng -r300 figs/3d/LW_tmp_anom

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
print -dpng -r300 figs/3d/LW_sal_anom

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
print -dpng -r300 figs/3d/LW_sigma_anom


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
print -dpng -r300 figs/3d/LW_temp_slices


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
print -dpng -r300 figs/3d/LW_sal_slices

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
print -dpng -r300 figs/3d/LW_sal_dens
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
print -dpng -r300 figs/3d/LW_horz_tmp_sal



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
print -dpng -r300 figs/3d/LW_chan_fig_5_merid

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
print -dpng -r300 figs/3d/LW_chan_fig_5