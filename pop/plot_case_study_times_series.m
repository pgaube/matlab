load obs_stream_sla
dft=1:12;
tend=12;

figure(1)
clf
set(gcf,'PaperPosition',[1 1 10 5.5])
hold on

% ii=find(hp66_chl_a.id==415)
% plot(hp66_chl_a.k(ii),hp66_chl_a.ks_mean_all(ii),'r','linewidth',3)
% ii=find(hp66_chl_c.id==324)
% plot(hp66_chl_c.k(ii),hp66_chl_c.ks_mean_all(ii),'b','linewidth',3)


ii=find(hp66_chl_a.id==415)
plot(norm_hp66_chl_a.k(ii),norm_hp66_chl_a.ks_mean_all(ii),'r','linewidth',3)
ii=find(hp66_chl_c.id==324)
plot(norm_hp66_chl_c.k(ii),norm_hp66_chl_c.ks_mean_all(ii),'b','linewidth',3)

xlabel('eddy age (weeks)','fontsize',20,'fontweight','bold')
line([1 tend+1],[0 0],'color','k','LineWidth',2)
set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top')
set(gca,'xtick',[0:2:20],'xlim',[1 tend+.5],'ylim',[-.04 .04])
box
print -dpng -r300 figs/stream_obs_ts/case_study_ts





figure(2)
clf
set(gcf,'PaperPosition',[1 1 10 5.5])
hold on
ii=find(hp66_chl_a.id==415)
plot(hp66_chl_a.k(ii),hp66_chl_a.ks_orgin_all(ii),'r','linewidth',3)
ii=find(hp66_chl_c.id==324)
plot(hp66_chl_c.k(ii),hp66_chl_c.ks_orgin_all(ii),'b','linewidth',3)


xlabel('eddy age (weeks)','fontsize',20,'fontweight','bold')
% ylabel(['mg m^{-3} per second?'],'fontsize',20,'fontweight','bold')
line([1 tend+1],[0 0],'color','k','LineWidth',2)
set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top')
set(gca,'xtick',[0:2:20],'xlim',[1 tend+.5],'ylim',[-.04 .04])
box
print -dpng -r300 figs/stream_obs_ts/case_study_orgin_ts

