
load GS_core_eddies_run33_sla_gridded
run33_eddies.amp=stream_eddies.amp;
run33_eddies.radius=stream_eddies.radius;
run33_eddies.cyc=stream_eddies.cyc;
run33_eddies.k=stream_eddies.k;
run33_eddies.id=stream_eddies.id;
run33_eddies.age=stream_eddies.age;

load GS_core_eddies_run14_sla_gridded
run14_eddies.amp=stream_eddies.amp;
run14_eddies.radius=stream_eddies.radius;
run14_eddies.cyc=stream_eddies.cyc;
run14_eddies.k=stream_eddies.k;
run14_eddies.id=stream_eddies.id;
run14_eddies.age=stream_eddies.age;

load GS_core_eddies_observed_sla
obs_eddies.amp=stream_eddies.amp;
obs_eddies.radius=stream_eddies.radius;
obs_eddies.cyc=stream_eddies.cyc;
obs_eddies.k=stream_eddies.k;
obs_eddies.id=stream_eddies.id;
obs_eddies.age=stream_eddies.age;
% load GS_rings_tracks_run33_sla
% run33_eddies.amp=pop_grid_eddies.amp;
% run33_eddies.radius=pop_grid_eddies.radius;
% run33_eddies.cyc=pop_grid_eddies.cyc;
% run33_eddies.k=pop_grid_eddies.k;
% run33_eddies.id=pop_grid_eddies.id;
% run33_eddies.age=pop_grid_eddies.age;
% 
% load GS_rings_tracks_run14_sla
% run14_eddies.amp=pop_grid_eddies.amp;
% run14_eddies.radius=pop_grid_eddies.radius;
% run14_eddies.cyc=pop_grid_eddies.cyc;
% run14_eddies.k=pop_grid_eddies.k;
% run14_eddies.id=pop_grid_eddies.id;
% run14_eddies.age=pop_grid_eddies.age;
% 
% obs_eddies.amp=aviso_eddies.amp;
% obs_eddies.radius=aviso_eddies.radius;
% obs_eddies.cyc=aviso_eddies.cyc;
% obs_eddies.k=aviso_eddies.k;
% obs_eddies.id=aviso_eddies.id;
% obs_eddies.age=aviso_eddies.age;


ai_14=find(run14_eddies.cyc==1);
ci_14=find(run14_eddies.cyc==-1);
ai_33=find(run33_eddies.cyc==1);
ci_33=find(run33_eddies.cyc==-1);
ai_ob=find(obs_eddies.cyc==1);
ci_ob=find(obs_eddies.cyc==-1);

%%make Amp hists
tbins=1:10:120;
[na_14,ba]=hist(run14_eddies.amp(ai_14),tbins);
nc_14=hist(run14_eddies.amp(ci_14),tbins);
na_33=hist(run33_eddies.amp(ai_33),tbins);
nc_33=hist(run33_eddies.amp(ci_33),tbins);
na_ob=hist(obs_eddies.amp(ai_ob),tbins);
nc_ob=hist(obs_eddies.amp(ci_ob),tbins);

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
set(gca,'xtick',[1 20:20:100])
title('AVISO','fontsize',12)
set(ga,'Position',[0.1 0.3 0.25 0.4],'fontsize',9)
line([min(tbins) max(tbins)],[0 0],'color','k')
text(75,30,[num2str(round(pmean(obs_eddies.amp(ai_ob)))),' cm'],'fontsize',10,'color','r')
text(75,35,[num2str(round(pmean(obs_eddies.amp(ci_ob)))),' cm'],'fontsize',10,'color','b')
gb=subplot(132);
stairs(tbins,na_14,'r','linewidth',1)
hold on
stairs(tbins,nc_14,'b','linewidth',1)
axis([min(tbins) max(tbins) 0 45])
set(gca,'xtick',[1 20:20:100])
title('run14','fontsize',12)
set(gb,'Position',[0.4 0.3 0.25 0.4],'fontsize',9)
xlabel('Amplitude (cm)','fontsize',12)
line([min(tbins) max(tbins)],[0 0],'color','k')
text(75,30,[num2str(round(pmean(run14_eddies.amp(ai_14)))),' cm'],'fontsize',10,'color','r')
text(75,35,[num2str(round(pmean(run14_eddies.amp(ci_14)))),' cm'],'fontsize',10,'color','b')

gc=subplot(133);
stairs(tbins,na_33,'r','linewidth',1)
hold on
stairs(tbins,nc_33,'b','linewidth',1)
axis([min(tbins) max(tbins) 0 45])
set(gca,'xtick',[1 20:20:100])
title('run33','fontsize',12)
set(gc,'Position',[0.7 0.3 0.25 0.4],'fontsize',9)
line([min(tbins) max(tbins)],[0 0],'color','k')
text(75,30,[num2str(round(pmean(run33_eddies.amp(ai_33)))),' cm'],'fontsize',10,'color','r')
text(75,35,[num2str(round(pmean(run33_eddies.amp(ci_33)))),' cm'],'fontsize',10,'color','b')
print -dpng -r300 figs/paper_sla_histo_amp

%%make radius hists
tbins=40:20:220;
[na_14,ba]=hist(run14_eddies.radius(ai_14),tbins);
nc_14=hist(run14_eddies.radius(ci_14),tbins);
na_33=hist(run33_eddies.radius(ai_33),tbins);
nc_33=hist(run33_eddies.radius(ci_33),tbins);
na_ob=hist(obs_eddies.radius(ai_ob),tbins);
nc_ob=hist(obs_eddies.radius(ci_ob),tbins);

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
axis([min(tbins) max(tbins) 0 30])
set(gca,'xtick',[60:40:200])
title('AVISO','fontsize',12)
set(ga,'Position',[0.1 0.3 0.25 0.4],'fontsize',9)
line([min(tbins) max(tbins)],[0 0],'color','k')
text(150,22,[num2str(round(pmean(obs_eddies.radius(ai_ob)))),' km'],'fontsize',10,'color','r')
text(150,26,[num2str(round(pmean(obs_eddies.radius(ci_ob)))),' km'],'fontsize',10,'color','b')

gb=subplot(132);
stairs(tbins,na_14,'r','linewidth',1)
hold on
stairs(tbins,nc_14,'b','linewidth',1)
axis([min(tbins) max(tbins) 0 30])
set(gca,'xtick',[60:40:200])
title('run14','fontsize',12)
set(gb,'Position',[0.4 0.3 0.25 0.4],'fontsize',9)
line([min(tbins) max(tbins)],[0 0],'color','k')
xlabel('Radius (km)','fontsize',12)
text(162,22,[num2str(round(pmean(run14_eddies.radius(ai_14)))),' km'],'fontsize',10,'color','r')
text(162,26,[num2str(round(pmean(run14_eddies.radius(ci_14)))),' km'],'fontsize',10,'color','b')

gc=subplot(133);
stairs(tbins,na_33,'r','linewidth',1)
hold on
stairs(tbins,nc_33,'b','linewidth',1)
axis([min(tbins) max(tbins) 0 30])
set(gca,'xtick',[60:40:200])
title('run33','fontsize',12)
set(gc,'Position',[0.7 0.3 0.25 0.4],'fontsize',9)
line([min(tbins) max(tbins)],[0 0],'color','k')
text(153,22,[num2str(round(pmean(run33_eddies.radius(ai_33)))),' km'],'fontsize',10,'color','r')
text(153,26,[num2str(round(pmean(run33_eddies.radius(ci_33)))),' km'],'fontsize',10,'color','b')
print -dpng -r300 figs/paper_sla_histo_radius

%%make lifetime hists
tbins=1:10:80;
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
axis([min(tbins) max(tbins) 0 65])
set(gca,'xtick',[1 10:10:73 73])
title('AVISO','fontsize',12)
set(ga,'Position',[0.1 0.3 0.25 0.4],'fontsize',9)
line([min(tbins) max(tbins)],[0 0],'color','k')
text(45,39,[num2str(round(pmean(obs_eddies.age(ai_ob)))),' weeks'],'fontsize',10,'color','r')
text(45,46,[num2str(round(pmean(obs_eddies.age(ci_ob)))),' weeks'],'fontsize',10,'color','b')

gb=subplot(132);
stairs(tbins,na_14,'r','linewidth',1)
hold on
stairs(tbins,nc_14,'b','linewidth',1)
axis([min(tbins) max(tbins) 0 65])
set(gca,'xtick',[1 10:10:73 73])
title('run14','fontsize',12)
set(gb,'Position',[0.4 0.3 0.25 0.4],'fontsize',9)
line([min(tbins) max(tbins)],[0 0],'color','k')
xlabel('Lifetime (weeks)','fontsize',12)
text(45,39,[num2str(round(pmean(run14_eddies.age(ai_14)))),' weeks'],'fontsize',10,'color','r')
text(45,46,[num2str(round(pmean(run14_eddies.age(ci_14)))),' weeks'],'fontsize',10,'color','b')

gc=subplot(133);
stairs(tbins,na_33,'r','linewidth',1)
hold on
stairs(tbins,nc_33,'b','linewidth',1)
axis([min(tbins) max(tbins) 0 65])
set(gca,'xtick',[1 10:10:73 73])
title('run33','fontsize',12)
set(gc,'Position',[0.7 0.3 0.25 0.4],'fontsize',9)
line([min(tbins) max(tbins)],[0 0],'color','k')
text(45,39,[num2str(round(pmean(run33_eddies.age(ai_33)))),' weeks'],'fontsize',10,'color','r')
text(45,46,[num2str(round(pmean(run33_eddies.age(ci_33)))),' weeks'],'fontsize',10,'color','b')
print -dpng -r300 figs/paper_sla_histo_lifetime
