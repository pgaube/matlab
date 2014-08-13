clear all
jday=date2jd(2002,7,10)+.5

load(['ULTI_mat2/QSCAT_30_25km_',num2str(jday)])
load bwr.pal
%first HAW

load ~/matlab/domains/HAW_lat_lon
dlat=lat;
dlon=lon;
max_lat=max(lat(:)); 
min_lat=min(lat(:)); 
max_lon=max(lon(:)); 
min_lon=min(lon(:)); 
load ULTI_mat2/QSCAT_30_25km_2452466 lat lon

[r,c]=imap(min(dlat),max(dlat),min(dlon),max(dlon),lat,lon);
% r=1:length(lat(:,1));
% c=1:length(lon(1,:));
figure(1)
clf

mm=subplot(311);
m_proj('Equidistant cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);   
m_pcolor(lon(r,c),lat(r,c),double(wek(r,c)));shading flat
colormap(bwr)
caxis([-30 30])
cc=colorbar('horiz');
title('Curl Pumping')
m_grid('xtick',[round(min_lon):5:round(max_lon)],'ytick',[round(min_lat):5:round(max_lat)],'tickdir','in','color','k','lineweight',1.5,'fontsize',8);  
m_coast('patch',[0 0 0]);
% print -dpng -r300 curl_pumping
set(cc,'Position',[0.3970 0.66 0.2414 0.015],'fontsize',6)
set(mm,'Position',[0.13 0.709265 0.775 0.17])
% m_text(160,35,'10-July-2002')

% figure(1)
% clf
mm=subplot(312);
m_proj('Equidistant cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);   
m_pcolor(lon(r,c),lat(r,c),double(hp_wek_crlg_week(r,c)));shading flat
colormap(bwr)
caxis([-30 30])
cc=colorbar('horiz');
title('SSH Pumping')
m_grid('xtick',[round(min_lon):5:round(max_lon)],'ytick',[round(min_lat):5:round(max_lat)],'tickdir','in','color','k','lineweight',1.5,'fontsize',8); 
m_coast('patch',[0 0 0]);
set(cc,'Position',[0.3970 0.345 0.2414 0.015],'fontsize',6)
set(mm,'Position',[0.13 0.4 0.775 0.17])
% print -dpng -r300 SSH_pumping

% figure(1)
% clf
mm=subplot(313);
m_proj('Equidistant cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);   
m_pcolor(lon(r,c),lat(r,c),-double(hp_wek_sst_week_fixed(r,c)));shading flat
colormap(bwr)
caxis([-10 10])
cc=colorbar('horiz');
title('SST Pumping')
m_grid('xtick',[round(min_lon):5:round(max_lon)],'ytick',[round(min_lat):5:round(max_lat)],'tickdir','in','color','k','lineweight',1.5,'fontsize',8);  
% xlabel('10-July-2002')
m_coast('patch',[0 0 0]);
set(cc,'Position',[0.3970 0.04 0.2414 0.015],'fontsize',6)
set(mm,'Position',[0.13 0.08 0.775 0.17])
% print -dpng -r300 SST_pumping
return

eval(['print -dpng -r300 SPO_Ekman_pumping_',num2str(jday)])


