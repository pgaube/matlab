clear all
jdays=date2jd(2002,7,10)+.5:7:2454713;

load(['ULTI_mat3/QSCAT_30_25km_',num2str(jdays(1))])
load bwr.pal
%first HAW

load ~/matlab/domains/agu_lat_lon
dlat=lat;
dlon=lon;
max_lat=max(lat(:));
min_lat=min(lat(:));
max_lon=max(lon(:));
min_lon=min(lon(:));
load ULTI_mat2/QSCAT_30_25km_2452466 lat lon
ff=f_cor(lat);
[r,c]=imap(min(dlat),max(dlat),min(dlon),max(dlon),lat,lon);
% r=1:length(lat(:,1));
% c=1:length(lon(1,:));


for m=1:length(jdays)
    [year,month,day]=jd2jdate(jdays(m));
    load(['ULTI_mat3/QSCAT_30_25km_',num2str(jdays(m))],'wek','hp_wek_sst_week_fixed','hp_wek_crlg_week')
    figure(1)
    clf
%     wek=(1./((ff*1020))).*hp66_crlstr.*8640000;
    
    mm=subplot(311);
    m_proj('Equidistant cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);
    m_pcolor(lon(r,c),lat(r,c),double(wek(r,c)));shading flat
    colormap(bwr)
    caxis([-40 40])
%     cc=colorbar('horiz');
    title('Curl Pumping')
    m_grid('xtick',[round(min_lon):10:round(max_lon)],'ytick',[round(min_lat):5:round(max_lat)],'tickdir','in','color','k','lineweight',1.5,'fontsize',8);
    m_coast('patch',[0 0 0]);
    % print -dpng -r300 curl_pumping
%     set(cc,'Position',[0.45 0.68 0.25 0.005],'fontsize',6)
%     set(mm,'Position',[0.13 0.709265 0.775 0.17])
    % m_text(160,35,'10-July-2002')
    
    % figure(1)
    % clf
    daspect([.6 1 1])
    
    mm=subplot(312);
    m_proj('Equidistant cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);
    m_pcolor(lon(r,c),lat(r,c),double(fillnans(hp_wek_crlg_week(r,c))));shading flat
    colormap(bwr)
    caxis([-30 30])
%     cc=colorbar('horiz');
    title('SSH Pumping')
    m_grid('xtick',[round(min_lon):10:round(max_lon)],'ytick',[round(min_lat):5:round(max_lat)],'tickdir','in','color','k','lineweight',1.5,'fontsize',8);
    m_coast('patch',[0 0 0]);
%     set(cc,'Position',[0.45 0.4 0.25 0.005],'fontsize',6)
    daspect([.6 1 1])
    
    mm=subplot(313);
    m_proj('Equidistant cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);
    m_pcolor(lon(r,c),lat(r,c),-double(hp_wek_sst_week_fixed(r,c)));shading flat
    colormap(bwr)
    caxis([-20 20])
%     cc=colorbar('horiz');
    title('SST Pumping')
    m_grid('xtick',[round(min_lon):10:round(max_lon)],'ytick',[round(min_lat):5:round(max_lat)],'tickdir','in','color','k','lineweight',1.5,'fontsize',8);
    % xlabel('10-July-2002')
    m_coast('patch',[0 0 0]);
%     set(cc,'Position',[0.45 0.02 0.25 0.005],'fontsize',6)

    xlabel([num2str(day),'-',num2str(month),'-',num2str(year)])
    daspect([.6 1 1])
    clear hp_wek_sst_week_fixed hp_wek_crlg_week wek
    eval(['print -dpng -r150 frames/sea_crl/frame_',num2str(m)])
end

