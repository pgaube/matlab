load chelle.pal
figure(2)
clf
r=find(lat(:,1)<-37);
tmplat=lat(r,:);
tmplon=lon(r,:);
max_lat=max(tmplat(:)); 
min_lat=min(tmplat(:)); 
max_lon=max(tmplon(:)); 
min_lon=min(tmplon(:)); 

Ysst=nanmean(sst_hp(r,:,:),3);
Yctt=nanmean(ctt_hp(r,:,:),3);
Ywnd=nanmean(wind_spd_hp(r,:,:),3);
Ydiv=nanmean(tau_div_hp(r,:,:),3);
Ycrl=nanmean(tau_crl_hp(r,:,:),3);



r_sst=pcor(Ysst(:),Yctt(:));
r_div=pcor(Ydiv(:),Yctt(:));
r_wnd=pcor(Ywnd(:),Yctt(:));

subplot(311) %ssthp with cloud
m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);  
m_pcolor(lon(r,:),lat(r,:),Ysst); 
colormap('jet');
m_grid('xtick',[round(min_lon):5:round(max_lon)],'ytick',[round(min_lat):2:round(max_lat)],'tickdir','out','color','k');  
shading flat 
caxis([-1.5 1.5])
c=colorbar;
hold on
m_contour(lon(r,:),lat(r,:),Yctt,[.2:.2:4],'k');
m_contour(lon(r,:),lat(r,:),Yctt,[-4:.2:-.2],'k--');
grid
title({'ALL CLOUDS',['Annually Averged (2007) HP Filtered SST with HP Filtered CTT Contours r = ' num2str(r_sst)],'Contour Interval .2 K'});
axes(c);
ylabel('Celsius')

subplot(312) %divhp with cloud
m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);  
m_pcolor(lon(r,:),lat(r,:),Ydiv);
colormap('jet');
m_grid('xtick',[round(min_lon):5:round(max_lon)],'ytick',[round(min_lat):2:round(max_lat)],'tickdir','out','color','k');  
shading flat 
caxis([-4 4])
c=colorbar;
hold on
m_contour(lon(r,:),lat(r,:),Yctt,[.2:.2:4],'k');
m_contour(lon(r,:),lat(r,:),Yctt,[-4:.2:-.2],'k--');
grid
title({['Annually Averged (2007) Wind Stress Divergence with HP Filtered CTT Contours r = ' num2str(r_div)],'Contour Interval .2 K'});
axes(c);
ylabel('N/m^2 per 100 km')


subplot(313) %wnd_spdhp with cloud
m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);  
m_pcolor(lon(r,:),lat(r,:),Ywnd);
colormap('jet');
m_grid('xtick',[round(min_lon):5:round(max_lon)],'ytick',[round(min_lat):2:round(max_lat)],'tickdir','out','color','k');  
shading flat 
caxis([-1 1])
c=colorbar;
hold on
m_contour(lon(r,:),lat(r,:),Yctt,[.2:.2:4],'k');
m_contour(lon(r,:),lat(r,:),Yctt,[-4:.2:-.2],'k--');
grid
title({['Annually Averged (2007) HP Filtered Wind Speed with HP Filtered CTT Contours r = ' num2str(r_wnd)],'Contour Interval .2 K'});
axes(c);
ylabel('m/s')
land

print -dpsc tmp.ps
!sed 's/6 dpi2point mul] 0 setdash/1 dpi2point mul] 0 setdash/' tmp.ps > ~/Documents/OSU/figures/agulhas/agu_3_cloud_cont.ps
!open agu_3_cloud_cont.ps

figure(2)
clf

subplot(311) %ssthp with cloud
m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);  
m_pcolor(lon(r,:),lat(r,:),Yctt); 
colormap(chelle);
m_grid('xtick',[round(min_lon):5:round(max_lon)],'ytick',[round(min_lat):2:round(max_lat)],'tickdir','out','color','k');  
shading flat 
caxis([-1 .8])
c=colorbar;
hold on
m_contour(lon(r,:),lat(r,:),Ysst,[.25:.25:5],'k');
m_contour(lon(r,:),lat(r,:),Ysst,[-5:.25:-.25],'k--');
grid
title({'ALL CLOUDS',['Annually Averged (2007) HP Filtered CTT with HP Filtered SST Contours r = ' num2str(r_sst)],'Contour Interval .25 C'});
axes(c);
ylabel('Kelvin')

subplot(312) %divhp with cloud
m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);  
m_pcolor(lon(r,:),lat(r,:),Yctt);
colormap(chelle);
m_grid('xtick',[round(min_lon):5:round(max_lon)],'ytick',[round(min_lat):2:round(max_lat)],'tickdir','out','color','k');  
shading flat 
caxis([-1 .8])
c=colorbar;
hold on
m_contour(lon(r,:),lat(r,:),Ydiv,[.5:4],'k');
m_contour(lon(r,:),lat(r,:),Ydiv,[-4:-.5],'k--');
grid
title({['Annually Averged (2007) HP Filtered CTT with Wind Stress Divergence Contours r = ' num2str(r_div)],'Contour Interval 1 N/m^2 per 100 km'});
axes(c);
ylabel('Kelvin')

subplot(313) %wnd_spdhp with cloud
m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);  
m_pcolor(lon(r,:),lat(r,:),Yctt);
colormap(chelle);
m_grid('xtick',[round(min_lon):5:round(max_lon)],'ytick',[round(min_lat):2:round(max_lat)],'tickdir','out','color','k');  
shading flat 
caxis([-1 .8])
c=colorbar;
hold on
m_contour(lon(r,:),lat(r,:),Ywnd,[.1:.1:4],'k');
m_contour(lon(r,:),lat(r,:),Ywnd,[-4:.1:-.1],'k--');
grid
title({['Annually Averged (2007) HP Filtered CTT with HP Filtered Wind Speed  Contours r = ' num2str(r_wnd)],'Contour Interval .1 m/s'});
axes(c);
ylabel('Kelvin')
land

print -dpsc tmp.ps
!sed 's/6 dpi2point mul] 0 setdash/1 dpi2point mul] 0 setdash/' tmp.ps > ~/Documents/OSU/figures/agulhas/agu_3_cloud_colour.ps
!open agu_3_cloud_colour.ps


Yctt=nanmean(ctt_hi_hp(r,:,:),3);
r_sst=pcor(Ysst(:),Yctt(:));
r_div=pcor(Ydiv(:),Yctt(:));
r_wnd=pcor(Ywnd(:),Yctt(:));

figure(3)
clf
subplot(311) %hi
m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);  
m_pcolor(lon(r,:),lat(r,:),Ysst); 
colormap('jet');
m_grid('xtick',[round(min_lon):5:round(max_lon)],'ytick',[round(min_lat):2:round(max_lat)],'tickdir','out','color','k');  
shading flat 
caxis([-1.5 1.5])
c=colorbar;
hold on
m_contour(lon(r,:),lat(r,:),Yctt,[.2:.2:4],'k');
m_contour(lon(r,:),lat(r,:),Yctt,[-4:.2:-.2],'k--');
grid
title({'HIGH CLOUDS',['Annually Averged (2007) HP Filtered SST with HP Filtered CTT Contours of Cloud Tops Over 2 km (795.25 hPa) r = ' num2str(r_sst)],'Contour Interval .2 K'});
axes(c);
ylabel('Celsius')

subplot(312) %divhp with cloud
m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);  
m_pcolor(lon(r,:),lat(r,:),Ydiv);
colormap('jet');
m_grid('xtick',[round(min_lon):5:round(max_lon)],'ytick',[round(min_lat):2:round(max_lat)],'tickdir','out','color','k');  
shading flat 
caxis([-4 4])
c=colorbar;
hold on
m_contour(lon(r,:),lat(r,:),Yctt,[.2:.2:4],'k');
m_contour(lon(r,:),lat(r,:),Yctt,[-4:.2:-.2],'k--');
grid
title({['Annually Averged (2007) Wind Stress Divergence with HP Filtered CTT Contours of Cloud Tops Over 2 km (795.25 hPa) r = ' num2str(r_div)],'Contour Interval .2 K'});
axes(c);
ylabel('N/m^2 per 100 km')

subplot(313) %wnd_spdhp with cloud
m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);  
m_pcolor(lon(r,:),lat(r,:),Ywnd);
colormap('jet');
m_grid('xtick',[round(min_lon):5:round(max_lon)],'ytick',[round(min_lat):2:round(max_lat)],'tickdir','out','color','k');  
shading flat 
caxis([-1 1])
c=colorbar;
hold on
m_contour(lon(r,:),lat(r,:),Yctt,[.2:.2:4],'k');
m_contour(lon(r,:),lat(r,:),Yctt,[-4:.2:-.2],'k--');
grid
title({['Annually Averged (2007) HP Filtered Wind Speed with HP Filtered CTT Contours of Cloud Tops Over 2 km (795.25 hPa) r = ' num2str(r_wnd)],'Contour Interval .2 K'});
axes(c);
ylabel('m/s')
land

print -dpsc tmp.ps
!sed 's/6 dpi2point mul] 0 setdash/1 dpi2point mul] 0 setdash/' tmp.ps > ~/Documents/OSU/figures/agulhas/agu_3_hi_cloud_cont.ps
!open agu_3_hi_cloud_cont.ps

figure(4)
clf
subplot(311) %ssthp with cloud
m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);  
m_pcolor(lon(r,:),lat(r,:),Yctt); 
colormap(chelle);
m_grid('xtick',[round(min_lon):5:round(max_lon)],'ytick',[round(min_lat):2:round(max_lat)],'tickdir','out','color','k');  
shading flat 
caxis([-1 .8])
c=colorbar;
hold on
m_contour(lon(r,:),lat(r,:),Ysst,[.25:.25:5],'k');
m_contour(lon(r,:),lat(r,:),Ysst,[-5:.25:-.25],'k--');
grid
title({'HIGH CLOUDS',['Annually Averged (2007) HP Filtered CTT of Cloud Tops Over 2 km (795.25 hPa) with HP Filtered SST Contours r = ' num2str(r_sst)],'Contour Interval .25 C'});
axes(c);
ylabel('Kelvin')

subplot(312) %divhp with cloud
m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);  
m_pcolor(lon(r,:),lat(r,:),Yctt);
colormap(chelle);
m_grid('xtick',[round(min_lon):5:round(max_lon)],'ytick',[round(min_lat):2:round(max_lat)],'tickdir','out','color','k');  
shading flat 
caxis([-1 .8])
c=colorbar;
hold on
m_contour(lon(r,:),lat(r,:),Ydiv,[.5:4],'k');
m_contour(lon(r,:),lat(r,:),Ydiv,[-4:-.5],'k--');
grid
title({['Annually Averged (2007) HP Filtered CTT of Cloud Tops Over 2 km (795.25 hPa) with Wind Stress Divergence Contours r = ' num2str(r_div)],'Contour Interval 1 N/m^2 per 100 km'});
axes(c);
ylabel('Kelvin')

subplot(313) %wnd_spdhp with cloud
m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);  
m_pcolor(lon(r,:),lat(r,:),Yctt);
colormap(chelle);
m_grid('xtick',[round(min_lon):5:round(max_lon)],'ytick',[round(min_lat):2:round(max_lat)],'tickdir','out','color','k');  
shading flat 
caxis([-1 .8])
c=colorbar;
hold on
m_contour(lon(r,:),lat(r,:),Ywnd,[.1:.1:4],'k');
m_contour(lon(r,:),lat(r,:),Ywnd,[-4:.1:-.1],'k--');
grid
title({['Annually Averged (2007) HP Filtered CTT of Cloud Tops Over 2 km (795.25 hPa) with HP Filtered Wind Speed Contours r = ' num2str(r_wnd)],'Contour Interval .1 m/s'});
axes(c);
ylabel('Kelvin')
land

print -dpsc tmp.ps
!sed 's/6 dpi2point mul] 0 setdash/1 dpi2point mul] 0 setdash/' tmp.ps > ~/Documents/OSU/figures/agulhas/agu_3_hi_cloud_colour.ps
!open agu_3_hi_cloud_colour.ps


figure(5)
clf

Yctt=nanmean(ctt_lo_hp(r,:,:),3);
r_sst=pcor(Ysst(:),Yctt(:));
r_div=pcor(Ydiv(:),Yctt(:));
r_wnd=pcor(Ywnd(:),Yctt(:));

subplot(311) %lo
m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);  
m_pcolor(lon(r,:),lat(r,:),Ysst); 
colormap('jet');
m_grid('xtick',[round(min_lon):5:round(max_lon)],'ytick',[round(min_lat):2:round(max_lat)],'tickdir','out','color','k');  
shading flat 
caxis([-1.5 1.5])
c=colorbar;
hold on
m_contour(lon(r,:),lat(r,:),Yctt,[.1:.1:4],'k');
m_contour(lon(r,:),lat(r,:),Yctt,[-4:.1:-.1],'k--');
grid
title({'LOW CLOUDS',['Annually Averged (2007) HP Filtered SST with HP Filtered CTT Contours of Cloud Tops Under 2 km (795.25 hPa) r = ' num2str(r_sst)],'Contour Interval .1 K'});
axes(c);
ylabel('Celsius')

subplot(312) %divhp with cloud
m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);  
m_pcolor(lon(r,:),lat(r,:),Ydiv);
colormap('jet');
m_grid('xtick',[round(min_lon):5:round(max_lon)],'ytick',[round(min_lat):2:round(max_lat)],'tickdir','out','color','k');  
shading flat 
caxis([-4 4])
c=colorbar;
hold on
m_contour(lon(r,:),lat(r,:),Yctt,[.1:.1:4],'k');
m_contour(lon(r,:),lat(r,:),Yctt,[-4:.1:-.1],'k--');
grid
title({['Annually Averged (2007) Wind Stress Divergence with HP Filtered CTT Contours of Cloud Tops Under 2 km (795.25 hPa) r = ' num2str(r_div)],'Contour Interval .1 K'});
axes(c);
ylabel('N/m^2 per 100 km')

subplot(313) %wnd_spdhp with cloud
m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);  
m_pcolor(lon(r,:),lat(r,:),Ywnd);
colormap('jet');
m_grid('xtick',[round(min_lon):5:round(max_lon)],'ytick',[round(min_lat):2:round(max_lat)],'tickdir','out','color','k');  
shading flat 
caxis([-1 1])
c=colorbar;
hold on
m_contour(lon(r,:),lat(r,:),Yctt,[.1:.1:4],'k');
m_contour(lon(r,:),lat(r,:),Yctt,[-4:.1:-.1],'k--');
grid
title({['Annually Averged (2007) HP Filtered Wind Speed with HP Filtered CTT Contours of Cloud Tops Under 2 km (795.25 hPa) r = ' num2str(r_wnd)],'Contour Interval .1 K'});
axes(c);
ylabel('m/s')
land

print -dpsc tmp.ps
!sed 's/6 dpi2point mul] 0 setdash/1 dpi2point mul] 0 setdash/' tmp.ps > ~/Documents/OSU/figures/agulhas/agu_3_lo_cloud_cont.ps
!open agu_3_lo_cloud_cont.ps

figure(6)
clf
subplot(311) %ssthp with cloud
m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);  
m_pcolor(lon(r,:),lat(r,:),Yctt); 
colormap(chelle);
m_grid('xtick',[round(min_lon):5:round(max_lon)],'ytick',[round(min_lat):2:round(max_lat)],'tickdir','out','color','k');  
shading flat 
caxis([-.5 .5])
c=colorbar;
hold on
m_contour(lon(r,:),lat(r,:),Ysst,[.25:.25:5],'k');
m_contour(lon(r,:),lat(r,:),Ysst,[-5:.25:-.25],'k--');
grid
title({'LOW CLOUDS',['Annually Averged (2007) HP Filtered CTT of Cloud Tops Under 2 km (795.25 hPa) with HP Filtered SST Contours r = ' num2str(r_sst)],'Contour Interval .25 C'});
axes(c);
ylabel('Kelvin')

subplot(312) %divhp with cloud
m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);  
m_pcolor(lon(r,:),lat(r,:),Yctt);
colormap(chelle);
m_grid('xtick',[round(min_lon):5:round(max_lon)],'ytick',[round(min_lat):2:round(max_lat)],'tickdir','out','color','k');  
shading flat 
caxis([-.5 .5])
c=colorbar;
hold on
m_contour(lon(r,:),lat(r,:),Ydiv,[.5:4],'k');
m_contour(lon(r,:),lat(r,:),Ydiv,[-4:-.5],'k--');
grid
title({['Annually Averged (2007) HP Filtered CTT of Cloud Tops Under 2 km (795.25 hPa) with Wind Stress Divergence Contours r = ' num2str(r_div)],'Contour Interval 1 N/m^2 per 100 km'});
axes(c);
ylabel('Kelvin')

subplot(313) %wnd_spdhp with cloud
m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);  
m_pcolor(lon(r,:),lat(r,:),Yctt);
colormap(chelle);
m_grid('xtick',[round(min_lon):5:round(max_lon)],'ytick',[round(min_lat):2:round(max_lat)],'tickdir','out','color','k');  
shading flat 
caxis([-.5 .5])
c=colorbar;
hold on
m_contour(lon(r,:),lat(r,:),Ywnd,[.1:.1:4],'k');
m_contour(lon(r,:),lat(r,:),Ywnd,[-4:.1:-.1],'k--');
grid
title({['Annually Averged (2007) HP Filtered CTT of Cloud Tops Under 2 km (795.25 hPa) with HP Filtered Wind Speed Contours r = ' num2str(r_wnd)],'Contour Interval .1 m/s'});
axes(c);
ylabel('Kelvin')
land

print -dpsc tmp.ps
!sed 's/6 dpi2point mul] 0 setdash/1 dpi2point mul] 0 setdash/' tmp.ps > ~/Documents/OSU/figures/agulhas/agu_3_lo_cloud_colour.ps
!open agu_3_lo_cloud_colour.ps


