clear
load VOCALS_eddy_argo_prof

xi=[-2:.25:2];
yi=xi;

[ac_sigma,ac_t,ac_s,ac_t_anom,ac_s_anom,ac_st_anom,ac_comp_dh,ac_comp_v,ac_comp_u,...
cc_sigma,cc_t,cc_s,cc_t_anom,cc_s_anom,cc_st_anom,cc_comp_dh,cc_comp_v,cc_comp_u,...
ac_u,ac_v,cc_u,cc_v,ac_spd,cc_spd]=deal(nan(length(xi),length(yi),length(ppres)));


sp=1000*pmean(eddy_scale)*pmean(diff(xi));
ff=f_cor(pmean(eddy_y));


fprintf('\n interpolating anticyclones \r')
for m=1:length(ppres);
	ac_t(:,:,m)=grid2d_loess(eddy_it(m,ia)',eddy_dist_x(ia),eddy_dist_y(ia),1.5,1.5,xi,yi);
	ac_s(:,:,m)=grid2d_loess(eddy_is(m,ia)',eddy_dist_x(ia),eddy_dist_y(ia),1.5,1.5,xi,yi);
	ac_t_anom(:,:,m)=grid2d_loess(eddy_it_anom(m,ia)',eddy_dist_x(ia),eddy_dist_y(ia),1.5,1.5,xi,yi);
	ac_s_anom(:,:,m)=grid2d_loess(eddy_is_anom(m,ia)',eddy_dist_x(ia),eddy_dist_y(ia),1.5,1.5,xi,yi);
	ac_dh(:,:,m)=grid2d_loess(eddy_dh(m,ia)',eddy_dist_x(ia),eddy_dist_y(ia),1.5,1.5,xi,yi);
end

fprintf('\n now interpolating cyclones \r')
	
for m=1:length(ppres);
	cc_t(:,:,m)=grid2d_loess(eddy_it(m,ic)',eddy_dist_x(ic),eddy_dist_y(ic),1.5,1.5,xi,yi);
	cc_s(:,:,m)=grid2d_loess(eddy_is(m,ic)',eddy_dist_x(ic),eddy_dist_y(ic),1.5,1.5,xi,yi);
	cc_t_anom(:,:,m)=grid2d_loess(eddy_it_anom(m,ic)',eddy_dist_x(ic),eddy_dist_y(ic),1.5,1.5,xi,yi);
	cc_s_anom(:,:,m)=grid2d_loess(eddy_is_anom(m,ic)',eddy_dist_x(ic),eddy_dist_y(ic),1.5,1.5,xi,yi);
	cc_dh(:,:,m)=grid2d_loess(eddy_dh(m,ic)',eddy_dist_x(ic),eddy_dist_y(ic),1.5,1.5,xi,yi);
end



fprintf('\n now calculating velocites \r')

for m=1:length(xi)
for n=1:length(yi)
for zz=length(ppres):-1:1
	ac_comp_dh(m,n,zz)=(1e5*nansum(sw_svan(squeeze(ac_s(m,n,zz:end)),squeeze(ac_t(m,n,zz:end)),ppres(zz:end))));
end
end
end

for m=1:length(ppres)
	ac_comp_v(:,:,m)=dfdx_m(ac_comp_dh(:,:,m),sp)./ff;
	ac_comp_u(:,:,m)=-dfdy_m(ac_comp_dh(:,:,m),sp)./ff;
end

for m=1:length(xi)
for n=1:length(yi)
for zz=length(ppres):-1:1
	cc_comp_dh(m,n,zz)=(1e5*nansum(sw_svan(squeeze(cc_s(m,n,zz:end)),squeeze(cc_t(m,n,zz:end)),ppres(zz:end))));
end
end
end

for m=1:length(ppres)
	cc_comp_v(:,:,m)=dfdx_m(cc_comp_dh(:,:,m),sp)./ff;
	cc_comp_u(:,:,m)=-dfdy_m(cc_comp_dh(:,:,m),sp)./ff;
end	
ac_spd=sqrt(ac_comp_u.^2+ac_comp_v.^2);
cc_spd=sqrt(cc_comp_u.^2+cc_comp_v.^2);


save VOCALS_argo_3d ac_* cc_* ppres xi yi


load chelle.pal

figure(4)
clf
subplot(121)
pcolor(xi,-ppres,squeeze(ac_t_anom(17,:,:))');shading flat
hold on
contour(xi,-ppres,squeeze(ac_sigma(17,:,:))',[20:.1:30],'k')
line([0 0], [-1000 0])
caxis([-1 1])
colorbar
axis([-1.5 1.5 -1000 0])
%daspect([1 300 1])
title('Temperature anomalies of anticyclones')
subplot(122)
pcolor(xi,-ppres,squeeze(cc_t_anom(17,:,:))');shading flat
hold on
contour(xi,-ppres,squeeze(cc_sigma(17,:,:))',[20:.1:30],'k')
line([0 0], [-1000 0])
caxis([-1 1])
load rwp.pal
colormap(chelle)
axis([-1.5 1.5 -1000 0])
%daspect([1 300 1])
title('Temperature anomalies of cyclones')
cc=colorbar
axes(cc)
ylabel('^\circ C')


figure(5)
clf
subplot(121)
pcolor(xi,-ppres,squeeze(ac_s_anom(17,:,:))');shading flat
hold on
contour(xi,-ppres,squeeze(ac_sigma(17,:,:))',[20:.1:30],'k')
line([0 0], [-1000 0])
caxis([-.1 .1])
colorbar
axis([-1.5 1.5 -1000 0])
%daspect([1 300 1])
title('Salinity anomalies of anticyclones')
subplot(122)
pcolor(xi,-ppres,squeeze(cc_s_anom(17,:,:))');shading flat
hold on
contour(xi,-ppres,squeeze(cc_sigma(17,:,:))',[20:.1:30],'k')
line([0 0], [-1000 0])
caxis([-.1 .1])
load rwp.pal
colormap(chelle)
axis([-1.5 1.5 -1000 0])
%daspect([1 300 1])
title('Salinity anomalies of cyclones')
cc=colorbar
axes(cc)
ylabel('PSU')



figure(7)
clf
subplot(121)
pcolor(xi,-ppres,squeeze(ac_comp_v(17,:,:))');shading flat
hold on
contour(xi,-ppres,squeeze(ac_sigma(17,:,:))',[20:.1:30],'k')
line([0 0], [-1000 0])
caxis([-.1 .1])
colorbar
axis([-1.5 1.5 -1000 0])
%daspect([1 300 1])
%daspect([1 300 1])
title('Geostrophic velocity of anticyclones')
subplot(122)
pcolor(xi,-ppres,squeeze(cc_comp_v(17,:,:))');shading flat
hold on
contour(xi,-ppres,squeeze(cc_sigma(17,:,:))',[20:.1:30],'k')
line([0 0], [-1000 0])
caxis([-.1 .1])
load rwp.pal
colormap(chelle)
axis([-1.5 1.5 -1000 0])
%daspect([1 300 1])
title('Geostrophic veloctiy of cyclones')
cc=colorbar
axes(cc)
ylabel('(m s^{-1})')


