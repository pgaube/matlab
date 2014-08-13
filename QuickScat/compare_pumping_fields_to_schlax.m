% clear all
load chelle.pal
jday=date2jd(2002,8,7)+.5;
% load /Volumes/new_gaube/data/QuickScat/ULTI_mat4/QSCAT_30_25km_2452494
load /Volumes/new_gaube/data/QuickScat/new_mat/QSCAT_30_25km_2452494 u_week v_week sm_u_week sm_v_week
% whos
% return
% load ~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_2452494
% slat=lat;
% slon=lon;

thet=rad2deg(cart2pol(sm_u_week,sm_v_week));
spd=sqrt(sm_u_week.^2+sm_v_week.^2);
spd2=sqrt(u_week.^2+v_week.^2);
% thet=rad2deg(cart2pol(sm_66_u,sm_66_v));
load /Volumes/new_gaube/matlab/domains/AGU_lat_lon
[r2,c2]=imap(min(lat),max(lat),min(lon),max(lon),slat,slon);

load /Volumes/new_gaube/matlab/domains/new_SP_lat_lon
[r1,c1]=imap(min(lat),max(lat),min(lon),max(lon),slat,slon);
[r1,c1]=imap(-25,-15,180,180+40,slat,slon);
clear lat lon

add=hp_wek_sst_week_fixed+hp_total_wek_est;


vars={'add','hp_wek_sst_week_fixed','hp_total_wek_est','hp_total_wek_qscat',...
       'hp_crl_wek_est','hp_crl_wek_qscat','hp_zeta_wek_est','hp_zeta_wek_qscat',...
       'thet','spd','spd2'};
   
tits={'tilde W_{tot}=(W_{cur}+W_{SST})','W_{SST}','W_{cur}','W_{tot}',...
      'tilde W_c','W_c','tilde W_{zeta}','W_{zeta}','theta',...
      'speed of 6x6 smoothed winds','weekly wind speed'};
  
names={'tilde_w_tot','w_sst','w_cur','w_tot','tilde_w_c','w_c',...
       'tilde_w_zeta','w_zeta','theta','smoothed_wspd','wspd'};
for mm=1%1:length(vars)
    figure(1)
    clf
    set(gcf,'PaperPosition',[1 1 8.5 11])
    subplot(211)
    set(gca,'Units','inches','Position',[1 7 7 3])
    m_proj('Equidistant cylindrical','lon',[min(slon(1,c1)) max(slon(1,c1))],'lat',[min(slat(r1,1)) max(slat(r1,1))]);
    hm=gca;
    eval(['m_pcolor(slon(r1,c1),slat(r1,c1),double(',vars{mm},'(r1,c1)))'])
    if mm==9
        hold on
        [c,s]=m_contour(slon(r1,c1),slat(r1,c1),double(thet(r1,c1)),[-180:15:180],'k')
        clabel(c,s)
        caxis([-180 180])
    elseif mm==10
        hold on
        [c,s]=m_contour(slon(r1,c1),slat(r1,c1),double(spd(r1,c1)),[1:50],'k')
        clabel(c,s)
        caxis([1 15])
    elseif mm==11
        hold on
        [c,s]=m_contour(slon(r1,c1),slat(r1,c1),double(spd2(r1,c1)),[1:50],'k')
        clabel(c,s)
        caxis([1 15])
    else
        caxis([-50 50])
    end
    colormap(chelle)
    shading flat
    m_grid('xtick',[round(min(slon(1,c1))):10:round(max(slon(1,c1)))],'ytick',[round(min(slat(r1,1))):5:round(max(slat(r1,1)))],'tickdir','in','color','k','lineweight',1.5);
    title(tits{mm})
    axis normal
    
    subplot(212)
    set(gca,'Units','inches','Position',[1 2.5 3.5 3.5])
    m_proj('Equidistant cylindrical','lon',[min(slon(1,c2)) max(slon(1,c2))],'lat',[min(slat(r2,1)) max(slat(r2,1))]);
    eval(['m_pcolor(slon(r2,c2),slat(r2,c2),double(',vars{mm},'(r2,c2)))'])
    if mm==9
        hold on
        [c,s]=m_contour(slon(r2,c2),slat(r2,c2),double(thet(r2,c2)),[-180:15:180],'k')
        clabel(c,s)
        caxis([-180 180])
    elseif mm==10
        hold on
        [c,s]=m_contour(slon(r2,c2),slat(r2,c2),double(spd(r2,c2)),[1:50],'k')
        clabel(c,s)
        caxis([1 15])
    elseif mm==11
        hold on
        [c,s]=m_contour(slon(r2,c2),slat(r2,c2),double(spd2(r2,c2)),[1:50],'k')
        clabel(c,s)
        caxis([1 15])
    else
        caxis([-50 50])
    end
    colormap(chelle)
    shading flat
    m_grid('xtick',[round(min(slon(1,c2))):10:round(max(slon(1,c2)))],'ytick',[round(min(slat(r2,1))):5:round(max(slat(r2,1)))],'tickdir','in','color','k','lineweight',1.5);
    axis normal
    cc=colorbar('horiz');
    if mm==9
    	set(cc,'Units','inches','Position',[1 2 4 .15],'xtick',[-180 -90 0 90 180])
    elseif mm>9
    	set(cc,'Units','inches','Position',[1 2 4 .15],'xtick',[1 5 10 15])
    else
    	set(cc,'Units','inches','Position',[1 2 4 .15],'xtick',[-50 -25 0 25 50])
    end
    axes(cc)
    xlabel('cm/day')
    
    eval(['print -dpng -r300 ~/Desktop/compare_to_schlax_dec_27/',names{mm}])
end

%
%
% figure(1)
% clf
% m_proj('Equidistant cylindrical','lon',[min(slon(1,:)) max(slon(1,:))],'lat',[min(slat(:,1)) max(slat(:,1))]);
% m_pcolor(slon,slat,double(spd))
% hold on
% caxis([1 15])
% colormap(chelle)
% colorbar('horiz')
% shading flat
% m_grid('xtick',[round(min(slon(1,:))):50:round(max(slon(1,:)))],'ytick',[round(min(slat(:,1))):20:round(max(slat(:,1)))],'tickdir','in','color','k','lineweight',1.5);
%     m_coast('patch',[0 0 0]);
%
% print -dpng -r300 ~/Desktop/compare_to_schlax_dec_27/wspd_global


%
%
% figure(1)
% clf
% m_proj('Equidistant cylindrical','lon',[min(slon(1,:)) max(slon(1,:))],'lat',[min(slat(:,1)) max(slat(:,1))]);
% m_pcolor(slon,slat,double(thet))
% hold on
% caxis([-180 180])
% colormap(chelle)
% colorbar('horiz')
% shading flat
% m_grid('xtick',[round(min(slon(1,:))):50:round(max(slon(1,:)))],'ytick',[round(min(slat(:,1))):20:round(max(slat(:,1)))],'tickdir','in','color','k','lineweight',1.5);
%     m_coast('patch',[0 0 0]);
%
% print -dpng -r300 ~/Desktop/compare_to_schlax_dec_27/theta_global_6x6_smoothing
% % return

% figure(1)
% clf
% subplot(211)
% m_proj('Equidistant cylindrical','lon',[min(slon(1,c1)) max(slon(1,c1))],'lat',[min(slat(r1,1)) max(slat(r1,1))]);
% hm=gca;
% m_pcolor(slon(r1,c1),slat(r1,c1),double( hp_total_wek_est(r1,c1)))
% caxis([-50 50])
% colormap(chelle)
% shading flat
% m_grid('xtick',[round(min(slon(1,c1))):10:round(max(slon(1,c1)))],'ytick',[round(min(slat(r1,1))):5:round(max(slat(r1,1)))],'tickdir','in','color','k','lineweight',1.5);
% title('W_{cur}')
%
%
% subplot(212)
% m_proj('Equidistant cylindrical','lon',[min(slon(1,c2)) max(slon(1,c2))],'lat',[min(slat(r2,1)) max(slat(r2,1))]);
% m_pcolor(slon(r2,c2),slat(r2,c2),double( hp_total_wek_est(r2,c2)))
% caxis([-50 50])
% colormap(chelle)
% colorbar('horiz')
% shading flat
% m_grid('xtick',[round(min(slon(1,c2))):10:round(max(slon(1,c2)))],'ytick',[round(min(slat(r2,1))):5:round(max(slat(r2,1)))],'tickdir','in','color','k','lineweight',1.5);
%
% print -dpng -r300 ~/Desktop/compare_to_schlax_dec_27/w_cur
%
% figure(1)
% clf
% subplot(211)
% m_proj('Equidistant cylindrical','lon',[min(slon(1,c1)) max(slon(1,c1))],'lat',[min(slat(r1,1)) max(slat(r1,1))]);
% hm=gca;
% m_pcolor(slon(r1,c1),slat(r1,c1),double( hp_total_wek_qscat(r1,c1)))
% caxis([-50 50])
% colormap(chelle)
% shading flat
% m_grid('xtick',[round(min(slon(1,c1))):10:round(max(slon(1,c1)))],'ytick',[round(min(slat(r1,1))):5:round(max(slat(r1,1)))],'tickdir','in','color','k','lineweight',1.5);
% title('W_{tot}')
%
%
% subplot(212)
% m_proj('Equidistant cylindrical','lon',[min(slon(1,c2)) max(slon(1,c2))],'lat',[min(slat(r2,1)) max(slat(r2,1))]);
% m_pcolor(slon(r2,c2),slat(r2,c2),double( hp_total_wek_qscat(r2,c2)))
% caxis([-50 50])
% colormap(chelle)
% colorbar('horiz')
% shading flat
% m_grid('xtick',[round(min(slon(1,c2))):10:round(max(slon(1,c2)))],'ytick',[round(min(slat(r2,1))):5:round(max(slat(r2,1)))],'tickdir','in','color','k','lineweight',1.5);
%
% print -dpng -r300 ~/Desktop/compare_to_schlax_dec_27/w_tot
%
%
% figure(1)
% clf
% subplot(211)
% m_proj('Equidistant cylindrical','lon',[min(slon(1,c1)) max(slon(1,c1))],'lat',[min(slat(r1,1)) max(slat(r1,1))]);
% hm=gca;
% m_pcolor(slon(r1,c1),slat(r1,c1),double(hp_wek_sst_week_fixed(r1,c1)))
% caxis([-50 50])
% colormap(chelle)
% shading flat
% m_grid('xtick',[round(min(slon(1,c1))):10:round(max(slon(1,c1)))],'ytick',[round(min(slat(r1,1))):5:round(max(slat(r1,1)))],'tickdir','in','color','k','lineweight',1.5);
% title('W_{SST}')
%
%
% subplot(212)
% m_proj('Equidistant cylindrical','lon',[min(slon(1,c2)) max(slon(1,c2))],'lat',[min(slat(r2,1)) max(slat(r2,1))]);
% m_pcolor(slon(r2,c2),slat(r2,c2),double(hp_wek_sst_week_fixed(r2,c2)))
% caxis([-50 50])
% colormap(chelle)
% colorbar('horiz')
% shading flat
% m_grid('xtick',[round(min(slon(1,c2))):10:round(max(slon(1,c2)))],'ytick',[round(min(slat(r2,1))):5:round(max(slat(r2,1)))],'tickdir','in','color','k','lineweight',1.5);
%
% print -dpng -r300 ~/Desktop/compare_to_schlax_dec_27/w_sst
% return

%
% % figure(1)
% % clf
% % subplot(211)
% % m_proj('Equidistant cylindrical','lon',[min(slon(1,c1)) max(slon(1,c1))],'lat',[min(slat(r1,1)) max(slat(r1,1))]);
% % hm=gca;
% % m_pcolor(slon(r1,c1),slat(r1,c1),double(hp_crl_wek_qscat(r1,c1)))
% % caxis([-50 50])
% % colormap(chelle)
% % shading flat
% % m_grid('xtick',[round(min(slon(1,c1))):10:round(max(slon(1,c1)))],'ytick',[round(min(slat(r1,1))):5:round(max(slat(r1,1)))],'tickdir','in','color','k','lineweight',1.5);
% % title('W_{c}')
% %
% %
% % subplot(212)
% % m_proj('Equidistant cylindrical','lon',[min(slon(1,c2)) max(slon(1,c2))],'lat',[min(slat(r2,1)) max(slat(r2,1))]);
% % m_pcolor(slon(r2,c2),slat(r2,c2),double(hp_crl_wek_qscat(r2,c2)))
% % caxis([-50 50])
% % colormap(chelle)
% % colorbar('horiz')
% % shading flat
% % m_grid('xtick',[round(min(slon(1,c2))):10:round(max(slon(1,c2)))],'ytick',[round(min(slat(r2,1))):5:round(max(slat(r2,1)))],'tickdir','in','color','k','lineweight',1.5);
% %
% % print -dpng -r300 ~/Desktop/compare_to_schlax_dec_27/w_c
%
% figure(1)
% clf
% subplot(211)
% m_proj('Equidistant cylindrical','lon',[min(slon(1,c1)) max(slon(1,c1))],'lat',[min(slat(r1,1)) max(slat(r1,1))]);
% hm=gca;
% m_pcolor(slon(r1,c1),slat(r1,c1),double(hp_crl_wek_est(r1,c1)))
% caxis([-50 50])
% colormap(chelle)
% shading flat
% m_grid('xtick',[round(min(slon(1,c1))):10:round(max(slon(1,c1)))],'ytick',[round(min(slat(r1,1))):5:round(max(slat(r1,1)))],'tickdir','in','color','k','lineweight',1.5);
% title('tilde W_{c}')
%
%
% subplot(212)
% m_proj('Equidistant cylindrical','lon',[min(slon(1,c2)) max(slon(1,c2))],'lat',[min(slat(r2,1)) max(slat(r2,1))]);
% m_pcolor(slon(r2,c2),slat(r2,c2),double(hp_crl_wek_est(r2,c2)))
% caxis([-50 50])
% colormap(chelle)
% colorbar('horiz')
% shading flat
% m_grid('xtick',[round(min(slon(1,c2))):10:round(max(slon(1,c2)))],'ytick',[round(min(slat(r2,1))):5:round(max(slat(r2,1)))],'tickdir','in','color','k','lineweight',1.5);
%
% print -dpng -r300 ~/Desktop/compare_to_schlax_dec_27/tilde_w_c
%
%
%
% figure(1)
% clf
% subplot(211)
% m_proj('Equidistant cylindrical','lon',[min(slon(1,c1)) max(slon(1,c1))],'lat',[min(slat(r1,1)) max(slat(r1,1))]);
% hm=gca;
% m_pcolor(slon(r1,c1),slat(r1,c1),double(hp_zeta_wek_qscat(r1,c1)))
% caxis([-50 50])
% colormap(chelle)
% shading flat
% m_grid('xtick',[round(min(slon(1,c1))):10:round(max(slon(1,c1)))],'ytick',[round(min(slat(r1,1))):5:round(max(slat(r1,1)))],'tickdir','in','color','k','lineweight',1.5);
% title('W_{zeta}')
%
%
% subplot(212)
% m_proj('Equidistant cylindrical','lon',[min(slon(1,c2)) max(slon(1,c2))],'lat',[min(slat(r2,1)) max(slat(r2,1))]);
% m_pcolor(slon(r2,c2),slat(r2,c2),double(hp_zeta_wek_qscat(r2,c2)))
% caxis([-50 50])
% colormap(chelle)
% colorbar('horiz')
% shading flat
% m_grid('xtick',[round(min(slon(1,c2))):10:round(max(slon(1,c2)))],'ytick',[round(min(slat(r2,1))):5:round(max(slat(r2,1)))],'tickdir','in','color','k','lineweight',1.5);
%
% print -dpng -r300 ~/Desktop/compare_to_schlax_dec_27/w_zeta
%
% figure(1)
% clf
% subplot(211)
% m_proj('Equidistant cylindrical','lon',[min(slon(1,c1)) max(slon(1,c1))],'lat',[min(slat(r1,1)) max(slat(r1,1))]);
% hm=gca;
% m_pcolor(slon(r1,c1),slat(r1,c1),double(hp_zeta_wek_est(r1,c1)))
% caxis([-50 50])
% colormap(chelle)
% shading flat
% m_grid('xtick',[round(min(slon(1,c1))):10:round(max(slon(1,c1)))],'ytick',[round(min(slat(r1,1))):5:round(max(slat(r1,1)))],'tickdir','in','color','k','lineweight',1.5);
% title('tilde W_{zeta}')
%
%
% subplot(212)
% m_proj('Equidistant cylindrical','lon',[min(slon(1,c2)) max(slon(1,c2))],'lat',[min(slat(r2,1)) max(slat(r2,1))]);
% m_pcolor(slon(r2,c2),slat(r2,c2),double(hp_zeta_wek_est(r2,c2)))
% caxis([-50 50])
% colormap(chelle)
% colorbar('horiz')
% shading flat
% m_grid('xtick',[round(min(slon(1,c2))):10:round(max(slon(1,c2)))],'ytick',[round(min(slat(r2,1))):5:round(max(slat(r2,1)))],'tickdir','in','color','k','lineweight',1.5);
%
% print -dpng -r300 ~/Desktop/compare_to_schlax_dec_27/tilde_w_zeta

%
%
% figure(1)
% clf
% subplot(211)
% m_proj('Equidistant cylindrical','lon',[min(slon(1,c1)) max(slon(1,c1))],'lat',[min(slat(r1,1)) max(slat(r1,1))]);
% hm=gca;
% m_pcolor(slon(r1,c1),slat(r1,c1),double(thet(r1,c1)))
% hold on
% [c,s]=m_contour(slon(r1,c1),slat(r1,c1),double(thet(r1,c1)),[-180:15:180],'k')
% clabel(c,s)
% caxis([-180 180])
% colormap(chelle)
% shading flat
% m_grid('xtick',[round(min(slon(1,c1))):10:round(max(slon(1,c1)))],'ytick',[round(min(slat(r1,1))):5:round(max(slat(r1,1)))],'tickdir','in','color','k','lineweight',1.5);
% title('theta')
%
%
% subplot(212)
% m_proj('Equidistant cylindrical','lon',[min(slon(1,c2)) max(slon(1,c2))],'lat',[min(slat(r2,1)) max(slat(r2,1))]);
% m_pcolor(slon(r2,c2),slat(r2,c2),double(thet(r2,c2)))
% hold on
% [c,s]=m_contour(slon(r2,c2),slat(r2,c2),double(thet(r2,c2)),[-180:15:180],'k')
% clabel(c,s)
% caxis([-180 180])
% colormap(chelle)
% colorbar('horiz')
% shading flat
% m_grid('xtick',[round(min(slon(1,c2))):10:round(max(slon(1,c2)))],'ytick',[round(min(slat(r2,1))):5:round(max(slat(r2,1)))],'tickdir','in','color','k','lineweight',1.5);
%
% print -dpng -r300 ~/Desktop/compare_to_schlax_dec_27/theta_6x6_smoothing
%
%
%
% figure(1)
% clf
% subplot(211)
% m_proj('Equidistant cylindrical','lon',[min(slon(1,c1)) max(slon(1,c1))],'lat',[min(slat(r1,1)) max(slat(r1,1))]);
% hm=gca;
% m_pcolor(slon(r1,c1),slat(r1,c1),double(spd(r1,c1)))
% hold on
% [c,s]=m_contour(slon(r1,c1),slat(r1,c1),double(spd(r1,c1)),[1:100],'k')
% clabel(c,s)
% caxis([1 15])
% colormap(chelle)
% shading flat
% m_grid('xtick',[round(min(slon(1,c1))):10:round(max(slon(1,c1)))],'ytick',[round(min(slat(r1,1))):5:round(max(slat(r1,1)))],'tickdir','in','color','k','lineweight',1.5);
% title('speed of 6x6 smoothed winds')
%
%
% subplot(212)
% m_proj('Equidistant cylindrical','lon',[min(slon(1,c2)) max(slon(1,c2))],'lat',[min(slat(r2,1)) max(slat(r2,1))]);
% m_pcolor(slon(r2,c2),slat(r2,c2),double(spd(r2,c2)))
% hold on
% [c,s]=m_contour(slon(r2,c2),slat(r2,c2),double(spd(r2,c2)),[1:100],'k')
% clabel(c,s)
% caxis([1 15])
% colormap(chelle)
% colorbar('horiz')
% shading flat
% m_grid('xtick',[round(min(slon(1,c2))):10:round(max(slon(1,c2)))],'ytick',[round(min(slat(r2,1))):5:round(max(slat(r2,1)))],'tickdir','in','color','k','lineweight',1.5);
%
% print -dpng -r300 ~/Desktop/compare_to_schlax_dec_27/spd
