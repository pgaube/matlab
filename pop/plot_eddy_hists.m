
load GS_core_grid_eddies_run33
run33_eddies.ro=stream_eddies.ro;
run33_eddies.radius=stream_eddies.radius;
run33_eddies.cyc=stream_eddies.cyc;
run33_eddies.k=stream_eddies.k;
run33_eddies.id=stream_eddies.id;
run33_eddies.age=stream_eddies.age;

load GS_core_grid_eddies_run14
run14_eddies.ro=stream_eddies.ro;
run14_eddies.radius=stream_eddies.radius;
run14_eddies.cyc=stream_eddies.cyc;
run14_eddies.k=stream_eddies.k;
run14_eddies.id=stream_eddies.id;
run14_eddies.age=stream_eddies.age;

load GS_core_eddies_observed
obs_eddies.ro=stream_eddies.ro;
obs_eddies.radius=stream_eddies.radius;
obs_eddies.cyc=stream_eddies.cyc;
obs_eddies.k=stream_eddies.k;
obs_eddies.id=stream_eddies.id;
obs_eddies.age=stream_eddies.age;


ai_14=find(run14_eddies.cyc==1);
ci_14=find(run14_eddies.cyc==-1);
ai_33=find(run33_eddies.cyc==1);
ci_33=find(run33_eddies.cyc==-1);
ai_ob=find(obs_eddies.cyc==1);
ci_ob=find(obs_eddies.cyc==-1);

% % %%make Ro hists
% % tbins=.005:.02:.25;
% % [na_14,ba]=hist(run14_eddies.ro(ai_14),tbins);
% % nc_14=hist(run14_eddies.ro(ci_14),tbins);
% % na_33=hist(run33_eddies.ro(ai_33),tbins);
% % nc_33=hist(run33_eddies.ro(ci_33),tbins);
% % na_ob=hist(obs_eddies.ro(ai_ob),tbins);
% % nc_ob=hist(obs_eddies.ro(ci_ob),tbins);
% % 
% % na_14=100*(na_14./sum(na_14));
% % nc_14=100*(nc_14./sum(nc_14));
% % na_33=100*(na_33./sum(na_33));
% % nc_33=100*(nc_33./sum(nc_33));
% % na_ob=100*(na_ob./sum(na_ob));
% % nc_ob=100*(nc_ob./sum(nc_ob));
% % 
% % 
% % figure(3)
% % clf
% % hold on
% % set(gcf,'PaperPosition',[1 1 7 3])
% % ga=subplot(131);
% % stairs(tbins,na_ob,'r','linewidth',1)
% % hold on
% % stairs(tbins,nc_ob,'b','linewidth',1)
% % axis([min(tbins) max(tbins) 0 35])
% % set(gca,'xtick',[.01:.06:.25])
% % title('AVISO','fontsize',12)
% % set(ga,'Position',[0.1 0.3 0.25 0.4],'fontsize',9)
% % line([min(tbins) max(tbins)],[0 0],'color','k')
% % 
% % % text(50,50,['Anticyclones ',num2str(round(100*pmean(aviso_eddies.amp(ai)))./100),' cm'],'fontsize',10,'color','r')
% % % text(50,45,['     Cyclones ',num2str(round(100*pmean(aviso_eddies.amp(ci)))./100),' cm'],'fontsize',10,'color','b')
% % 
% % gb=subplot(132);
% % stairs(tbins,na_14,'r','linewidth',1)
% % hold on
% % stairs(tbins,nc_14,'b','linewidth',1)
% % axis([min(tbins) max(tbins) 0 35])
% % set(gca,'xtick',[.01:.06:.25])
% % title('run14','fontsize',12)
% % set(gb,'Position',[0.4 0.3 0.25 0.4],'fontsize',9)
% % xlabel('Rossby number','fontsize',12)
% % line([min(tbins) max(tbins)],[0 0],'color','k')
% % 
% % gc=subplot(133);
% % stairs(tbins,na_33,'r','linewidth',1)
% % hold on
% % stairs(tbins,nc_33,'b','linewidth',1)
% % axis([min(tbins) max(tbins) 0 35])
% % set(gca,'xtick',[.01:.06:.25])
% % title('run33','fontsize',12)
% % set(gc,'Position',[0.7 0.3 0.25 0.4],'fontsize',9)
% % line([min(tbins) max(tbins)],[0 0],'color','k')
% % print -dpng -r300 figs/paper_histo_ro
% % 
% % %%make radius hists
% % tbins=40:20:220;
% % [na_14,ba]=hist(run14_eddies.radius(ai_14),tbins);
% % nc_14=hist(run14_eddies.radius(ci_14),tbins);
% % na_33=hist(run33_eddies.radius(ai_33),tbins);
% % nc_33=hist(run33_eddies.radius(ci_33),tbins);
% % na_ob=hist(obs_eddies.radius(ai_ob),tbins);
% % nc_ob=hist(obs_eddies.radius(ci_ob),tbins);
% % 
% % na_14=100*(na_14./sum(na_14));
% % nc_14=100*(nc_14./sum(nc_14));
% % na_33=100*(na_33./sum(na_33));
% % nc_33=100*(nc_33./sum(nc_33));
% % na_ob=100*(na_ob./sum(na_ob));
% % nc_ob=100*(nc_ob./sum(nc_ob));
% % 
% % 
% % figure(3)
% % clf
% % hold on
% % set(gcf,'PaperPosition',[1 1 7 3])
% % ga=subplot(131);
% % stairs(tbins,na_ob,'r','linewidth',1)
% % hold on
% % stairs(tbins,nc_ob,'b','linewidth',1)
% % axis([min(tbins) max(tbins) 0 35])
% % set(gca,'xtick',[60:40:190])
% % title('AVISO','fontsize',12)
% % set(ga,'Position',[0.1 0.3 0.25 0.4],'fontsize',9)
% % line([min(tbins) max(tbins)],[0 0],'color','k')
% % 
% % % text(50,50,['Anticyclones ',num2str(round(100*pmean(aviso_eddies.amp(ai)))./100),' cm'],'fontsize',10,'color','r')
% % % text(50,45,['     Cyclones ',num2str(round(100*pmean(aviso_eddies.amp(ci)))./100),' cm'],'fontsize',10,'color','b')
% % 
% % gb=subplot(132);
% % stairs(tbins,na_14,'r','linewidth',1)
% % hold on
% % stairs(tbins,nc_14,'b','linewidth',1)
% % axis([min(tbins) max(tbins) 0 35])
% % set(gca,'xtick',[60:40:190])
% % title('run14','fontsize',12)
% % set(gb,'Position',[0.4 0.3 0.25 0.4],'fontsize',9)
% % line([min(tbins) max(tbins)],[0 0],'color','k')
% % xlabel('Radius (km)','fontsize',12)
% % 
% % gc=subplot(133);
% % stairs(tbins,na_33,'r','linewidth',1)
% % hold on
% % stairs(tbins,nc_33,'b','linewidth',1)
% % axis([min(tbins) max(tbins) 0 35])
% % set(gca,'xtick',[60:40:190])
% % title('run33','fontsize',12)
% % set(gc,'Position',[0.7 0.3 0.25 0.4],'fontsize',9)
% % line([min(tbins) max(tbins)],[0 0],'color','k')
% % print -dpng -r300 figs/paper_histo_radius

%%make radius hists
tbins=1:3:44;
[na_14,ba]=hist(run14_eddies.age(ai_14),tbins);
nc_14=hist(run14_eddies.age(ci_14),tbins);
na_33=hist(run33_eddies.age(ai_33),tbins);
nc_33=hist(run33_eddies.age(ci_33),tbins);
na_ob=hist(obs_eddies.age(ai_ob),tbins);
nc_ob=hist(obs_eddies.age(ci_ob),tbins);

na_14=100*(na_14./sum(na_14));
nc_14=100*(nc_14./sum(nc_14));
na_33=100*(na_33./sum(na_33));
nc_33=100*(nc_33./sum(nc_33));
na_ob=100*(na_ob./sum(na_ob));
nc_ob=100*(nc_ob./sum(nc_ob));


figure(3)
clf
hold on
set(gcf,'PaperPosition',[1 1 7 3])
ga=subplot(131);
stairs(tbins,na_ob,'r','linewidth',1)
hold on
stairs(tbins,nc_ob,'b','linewidth',1)
axis([min(tbins) max(tbins) 0 45])
set(gca,'xtick',[4:10:44])
title('AVISO','fontsize',12)
set(ga,'Position',[0.1 0.3 0.25 0.4],'fontsize',9)
line([min(tbins) max(tbins)],[0 0],'color','k')
% text(50,50,['Anticyclones ',num2str(round(100*pmean(aviso_eddies.amp(ai)))./100),' cm'],'fontsize',10,'color','r')
% text(50,45,['     Cyclones ',num2str(round(100*pmean(aviso_eddies.amp(ci)))./100),' cm'],'fontsize',10,'color','b')

gb=subplot(132);
stairs(tbins,na_14,'r','linewidth',1)
hold on
stairs(tbins,nc_14,'b','linewidth',1)
axis([min(tbins) max(tbins) 0 45])
set(gca,'xtick',[4:10:44])
title('run14','fontsize',12)
set(gb,'Position',[0.4 0.3 0.25 0.4],'fontsize',9)
line([min(tbins) max(tbins)],[0 0],'color','k')
xlabel('Lifetime (weeks)','fontsize',12)

gc=subplot(133);
stairs(tbins,na_33,'r','linewidth',1)
hold on
stairs(tbins,nc_33,'b','linewidth',1)
axis([min(tbins) max(tbins) 0 45])
set(gca,'xtick',[4:10:44])
title('run33','fontsize',12)
set(gc,'Position',[0.7 0.3 0.25 0.4],'fontsize',9)
line([min(tbins) max(tbins)],[0 0],'color','k')
print -dpng -r300 figs/paper_histo_lifetime
