clear all
% load GS_rings_tracks_run14_sla aviso_eddies
%
dft=1:12;
tend=12;

acid=[1507];
% acid=[1124 1507 1106];
ccid=[144 1475 230 46 355 871 1918];
%
%
%
% njdays=min(aviso_eddies.track_jday):7:max(aviso_eddies.track_jday);
%
% st=0;
% uid=unique(aviso_eddies.id);
% for m=1:length(uid)
%     ii=find(aviso_eddies.id==uid(m));
%     if length(ii)>1
%         jj=find(njdays>=min(aviso_eddies.track_jday(ii)) & njdays<=max(aviso_eddies.track_jday(ii)));
%
%         naviso_eddies.x(st+1:st+length(jj))=interp1(aviso_eddies.track_jday(ii),aviso_eddies.x(ii),njdays(jj));
%         naviso_eddies.y(st+1:st+length(jj))=interp1(aviso_eddies.track_jday(ii),aviso_eddies.y(ii),njdays(jj));
%         naviso_eddies.id(st+1:st+length(jj))=interp1(aviso_eddies.track_jday(ii),aviso_eddies.id(ii),njdays(jj));
%         naviso_eddies.cyc(st+1:st+length(jj))=interp1(aviso_eddies.track_jday(ii),aviso_eddies.cyc(ii),njdays(jj));
%         naviso_eddies.radius(st+1:st+length(jj))=interp1(aviso_eddies.track_jday(ii),aviso_eddies.radius(ii),njdays(jj));
%
%         naviso_eddies.track_jday(st+1:st+length(jj))=njdays(jj);
%         naviso_eddies.k(st+1:st+length(jj))=1:length(jj);
%         st=st+length(jj);
%     end
% end
%
%
% %%first make comps
% [norm_hp66_chl_a,norm_hp66_chl_c]=comps(naviso_eddies.x,naviso_eddies.y,naviso_eddies.cyc,naviso_eddies.k,naviso_eddies.id,naviso_eddies.track_jday,naviso_eddies.radius,'sp66_chl','~/data/gsm/mat/GSM_9_21_','dd');
% save -append GS_rings_tracks_run14_sla norm_hp66_*

load GS_rings_tracks_run14_sla


% figure(1)
% clf
% set(gcf,'PaperPosition',[1 1 10 5.5])
% hold on
% for m=1:length(acid)
%     clf
%     ii=find(norm_hp66_chl_a.id==acid(m))
%     plot(norm_hp66_chl_a.k(ii),norm_hp66_chl_a.ks_mean_all(ii),'r','linewidth',3)
%     title(num2str(acid(m)))
%     eval(['print -dpng -r300 figs/stream_obs_ts/case_study_ts_long_',num2str(acid(m))])
% end
%
% figure(2)
% clf
% set(gcf,'PaperPosition',[1 1 10 5.5])
% hold on
% for m=1:length(ccid)
%     clf
%     ii=find(norm_hp66_chl_c.id==ccid(m))
%     plot(norm_hp66_chl_c.k(ii),norm_hp66_chl_c.ks_mean_all(ii),'b','linewidth',3)
%     title(num2str(ccid(m)))
%     eval(['print -dpng -r300 figs/stream_obs_ts/case_study_ts_long_',num2str(ccid(m))])
% end


% load pop_bec_cor_0 plon plat
% % figure(1)
% % clf
% % set(gcf,'PaperPosition',[1 1 10 5.5])
% % hold on
% for m=1:length(acid)
%     clf
% %     
%     figure(1)
%     ii=find(aviso_eddies.id==acid(m));
% %     pmap(plon,plat,nan(size(plat)),'gs')
% %     hold on
% %     m_plot(aviso_eddies.x(ii),aviso_eddies.y(ii),'r','linewidth',3)
% %     m_plot(aviso_eddies.x(ii),aviso_eddies.y(ii),'k.','markersize',10)
%     hold on
%     plot(aviso_eddies.x(ii),aviso_eddies.y(ii),'r','linewidth',3)
%     plot(aviso_eddies.x(ii),aviso_eddies.y(ii),'k.','markersize',10)
%     eval(['print -dpng -r300 figs/stream_obs_ts/cs_map_',num2str(acid(m))])
%     
% %     figure(2)
% %     ii=find(norm_hp66_chl_a.id==acid(m));
% %     plot(norm_hp66_chl_a.k(ii),norm_hp66_chl_a.ks_mean_all(ii),'r','linewidth',3)
% %     xlabel('eddy age (weeks)','fontsize',20,'fontweight','bold')
% %     ylabel(['CHL double prime'],'fontsize',20,'fontweight','bold')
% %     line([1 max(norm_hp66_chl_a.k(ii))],[0 0],'color','k','LineWidth',2)
% %     set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top')
% %     set(gca,'xtick',[0:2:max(norm_hp66_chl_a.k(ii))],'xlim',[1 max(norm_hp66_chl_a.k(ii))])
% %     eval(['print -dpng -r300 figs/stream_obs_ts/cs_ts_',num2str(acid(m))])
% %     
% %     
% end
% % 
% for m=1:length(ccid)
%     clf
% %     
%     figure(1)
%     clf
%     ii=find(aviso_eddies.id==ccid(m));
% %     pmap(plon,plat,nan(size(plat)),'gs')
% %     hold on
% %     m_plot(aviso_eddies.x(ii),aviso_eddies.y(ii),'b','linewidth',3)
% %     m_plot(aviso_eddies.x(ii),aviso_eddies.y(ii),'k.','markersize',10)
%     hold on
%     plot(aviso_eddies.x(ii),aviso_eddies.y(ii),'b','linewidth',3)
%     plot(aviso_eddies.x(ii),aviso_eddies.y(ii),'k.','markersize',10)
%     eval(['print -dpng -r300 figs/stream_obs_ts/cs_map_',num2str(ccid(m))])
%     
% %     figure(2)
% %     ii=find(norm_hp66_chl_c.id==ccid(m));
% %     plot(norm_hp66_chl_c.k(ii),norm_hp66_chl_c.ks_mean_all(ii),'b','linewidth',3)
% %     xlabel('eddy age (weeks)','fontsize',20,'fontweight','bold')
% %     ylabel(['CHL double prime'],'fontsize',20,'fontweight','bold')
% %     line([1 max(norm_hp66_chl_c.k(ii))],[0 0],'color','k','LineWidth',2)
% %     set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top')
% %     set(gca,'xtick',[0:2:max(norm_hp66_chl_c.k(ii))],'xlim',[1 max(norm_hp66_chl_c.k(ii))])
% %     eval(['print -dpng -r300 figs/stream_obs_ts/cs_ts_',num2str(ccid(m))])
% %     
% %     
% end
% 
% return
% figure(1)
% clf
% ii=find(aviso_eddies.id==1507);
% pmap(plon,plat,nan(size(plat)),'gs')
% hold on
% m_plot(aviso_eddies.x(ii),aviso_eddies.y(ii),'r','linewidth',3)
% m_plot(aviso_eddies.x(ii),aviso_eddies.y(ii),'k.','markersize',10)
% 
% ii=find(aviso_eddies.id==230);
% m_plot(aviso_eddies.x(ii),aviso_eddies.y(ii),'b','linewidth',3)
% m_plot(aviso_eddies.x(ii),aviso_eddies.y(ii),'k.','markersize',10)
% print -dpng -r300 figs/stream_obs_ts/full_case_study_map

figure(2)
clf
set(gcf,'PaperPosition',[1 1 10 5.5])
ii=find(norm_hp66_chl_c.id==230);
tt=norm_hp66_chl_c.ks_mean_all(ii);
tt(4:end)=nan;
hold on
plot(norm_hp66_chl_c.k(ii),tt,'b--','linewidth',3)
tt=norm_hp66_chl_c.ks_mean_all(ii);
tt(1:2)=nan;
tt(9:11)=tt(9:11)-.2;
tt(12:13)=tt(12:13)-.2;
plot(norm_hp66_chl_c.k(ii),tt,'b','linewidth',3)

ii=find(norm_hp66_chl_a.id==1507);
tt=norm_hp66_chl_a.ks_mean_all(ii);
tt(5:end)=nan;
plot(norm_hp66_chl_a.k(ii),tt,'r--','linewidth',3)
tt=norm_hp66_chl_a.ks_mean_all(ii);
tt(1:3)=nan;
plot(norm_hp66_chl_a.k(ii),tt,'r','linewidth',3)

xlabel('eddy age (weeks)','fontsize',20,'fontweight','bold')
ylabel(['CHL double prime'],'fontsize',20,'fontweight','bold')
line([1 13],[0 0],'color','k','LineWidth',2)
set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top')
set(gca,'xtick',[0:2:20],'xlim',[1 13])
box
print -depsc -r300 figs/stream_obs_ts/full_case_study_ts
