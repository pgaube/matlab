
clear all
load /Volumes/matlab/data/eddy/V3/mat/AVISO_25_W_2453166 ssh lat lon
slat=lat;
slon=lon;
load /Volumes/matlab/data/ReynoldsSST/mat/OI_25_W_2453168
load /Volumes/matlab/data/eddy/V3/global_tracks_V3.mat x y id track_jday
load chelle.pal

ii=find(track_jday==2453166 & y>=-35 & y<=-20 & x>=50 & x<=115);
x=x(ii);
y=y(ii);
id=id(ii);

r=find(lat(:,1)>=-35 & lat(:,1)<=-20);
c=find(lon(1,:)>=50 &lon(1,:)<=115);
lat=lat(r,c);
lon=lon(r,c);
rs=find(slat>=-35 & slat<=-20);
cs=find(slon>=50 & slon<=115);
slat=slat(rs)'*ones(1,length(slon(cs)));
slon=ones(length(slat(:,1)),1)*slon(cs);

lat=interp2(lat,3);
lon=interp2(lon,3);
slat=interp2(slat,3);
slon=interp2(slon,3);
sst_oi=interp2(sst_oi(r,c),3);
filtered_sst_oi=interp2(filtered_sst_oi(r,c),3);
%aoi_sst=interp2(sst_oi_anom(r,c),2);
ssh=interp2(ssh(rs,cs),3);



max_lat=max(lat(:));
min_lat=min(lat(:));
max_lon=max(lon(:));
min_lon=min(lon(:));
rlat=max_lat-min_lat;
rlon=max_lon-min_lon;



figure(1)
clf
m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);
colormap(chelle);
m_pcolor(lon,lat,sst_oi)
shading flat
land
grid
m_coast('patch',[0 0 0]);
m_grid('xtick',[round(min_lon):10:round(max_lon)],'ytick', ...
       [round(min_lat):5:round(max_lat)],'tickdir','in','color','k','linewidth',2,'fontsize',14);
caxis([14.5 25])
title('OI SST June 4, 2004')
cc=colorbar
set(cc,'yaxislocation','right','linewidth',2)
axes(cc)
ylabel('^{\circ}C','fontsize',14)
land
print -dpng sst_20020611



figure(3)
clf
m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);
colormap(chelle);
m_pcolor(lon,lat,filtered_sst_oi)
shading interp
axis image
land
grid
m_coast('patch',[0 0 0]);
m_grid('xtick',[round(min_lon):10:round(max_lon)],'ytick', ...
       [round(min_lat):5:round(max_lat)],'tickdir','in','color','k','linewidth',2,'fontsize',14);
hold on
m_contour(slon,slat,ssh,[-50:3:-3],'k--')
m_contour(slon,slat,ssh,[3:3:50],'k')
%for m=1:length(x)
%m_plot(x(m),y(m),'k.','markersize',20);
%end
hold off
caxis([-2 2])
m_text(100,-39,{'contour interval 3 cm','negative contours dashed'})
title({'Loess Filtered OI SST','with contours of spatially high-pass filtered SSH'})
cc=colorbar
set(cc,'yaxislocation','right','linewidth',2)
axes(cc)
ylabel('^{\circ}C','fontsize',14)

print -dpng -r300 hpsst_ssh_20020611
return
figure(2)
clf
m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);
colormap(chelle);
m_pcolor(lon,lat,sst_oi)
shading flat
axis image
land
grid
m_coast('patch',[0 0 0]);
m_grid('xtick',[round(min_lon):10:round(max_lon)],'ytick', ...
       [round(min_lat):5:round(max_lat)],'tickdir','in','color','k','linewidth',2,'fontsize',14);
hold on
%for m=1:length(x)
%m_plot(x(m),y(m),'k.','markersize',20);
%end
m_contour(slon,slat,ssh,[-50:3:-3],'k--')
m_contour(slon,slat,ssh,[3:3:50],'k')
hold off
caxis([14.5 25])
title({'OI SST June 4, 2004','with contours of spatially high-pass filtered SSH'})
m_text(100,-39,{'contour interval 3 cm','negative contours dashed'})
cc=colorbar
set(cc,'yaxislocation','right','linewidth',2)
axes(cc)
ylabel('^{\circ}C','fontsize',14)
land
print -dpng -r300 sst_ssh_20020611

return
figure(1)
clf
subplot(311)
m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);
colormap(chelle);
m_pcolor(lon,lat,sst_oi)
shading interp
axis image
land
grid
m_coast('patch',[0 0 0]);
m_grid('xtick',[round(min_lon):10:round(max_lon)],'ytick', ...
       [round(min_lat):5:round(max_lat)],'tickdir','in','color','k','linewidth',2,'fontsize',14);
hold on
m_contour(slon,slat,ssh,[-50:3:-3],'k--')
m_contour(slon,slat,ssh,[3:3:50],'k')
hold off
caxis([11.5 25])
title('OI SST June 4, 2004')
cc=colorbar
set(cc,'yaxislocation','right','linewidth',2)
axes(cc)
ylabel('^{\circ}C','fontsize',14)

subplot(312)
m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);
colormap(chelle);
m_pcolor(lon,lat,filtered_sst_oi)
shading interp
axis image
land
grid
m_coast('patch',[0 0 0]);
m_grid('xtick',[round(min_lon):10:round(max_lon)],'ytick', ...
       [round(min_lat):5:round(max_lat)],'tickdir','in','color','k','linewidth',2,'fontsize',14);
hold on
m_contour(slon,slat,ssh,[-50:3:-3],'k--')
m_contour(slon,slat,ssh,[3:3:50],'k')
hold off
caxis([-2 2])
title('Loess Filtered OI SST')
cc=colorbar
set(cc,'yaxislocation','right','linewidth',2)
axes(cc)
ylabel('^{\circ}C','fontsize',14)

subplot(313)
m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);
colormap(chelle);
m_pcolor(lon,lat,double(aoi_sst))
shading interp
axis image
land
grid
m_coast('patch',[0 0 0]);
m_grid('xtick',[round(min_lon):10:round(max_lon)],'ytick', ...
       [round(min_lat):5:round(max_lat)],'tickdir','in','color','k','linewidth',2,'fontsize',14);
hold on
m_contour(slon,slat,ssh,[-50:3:-3],'k--')
m_contour(slon,slat,ssh,[3:3:50],'k')
hold off
caxis([-2 2])
title('Harmonically Filtered OI SST')
cc=colorbar
set(cc,'yaxislocation','right','linewidth',2)
axes(cc)
ylabel('^{\circ}C','fontsize',14)
%land
print -dpng -r300 large_sst_3_panel.png


%print -dpsc tmp.ps
%!sed 's/6 dpi2point mul] 0 setdash/4 dpi2point mul] 0 setdash/' /Volumes/matlab/matlab/leeuwin/tmp.ps > /Volumes/matlab/matlab/leeuwin/tmp2.ps

