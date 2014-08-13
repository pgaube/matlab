

load GS_rings_tracks_aviso_jan_5 aviso_eddies slon slat 
load GS_rings_tracks_run14_jan_5 pop_eddies pSSH



ai=find(aviso_eddies.cyc==1);
ci=find(aviso_eddies.cyc==-1);
pai=find(pop_eddies.cyc==1);
pci=find(pop_eddies.cyc==-1);


%%make hists

[na,ba]=hist(aviso_eddies.amp(ai),15);
[nc,bc]=hist(aviso_eddies.amp(ci),ba);
npa=hist(pop_eddies.amp(pai),ba);
npc=hist(pop_eddies.amp(pci),bc);

na=100*(na./sum(na));
nc=100*(nc./sum(nc));

npa=100*(npa./sum(npa));
npc=100*(npc./sum(npc));


figure(3)
clf
set(gcf,'PaperPosition',[1 1 8 6])
subplot(221)
stairs(ba,na,'r','linewidth',2)
hold on
stairs(bc,nc,'b','linewidth',2)
axis([4 100 0 55])
set(gca,'xtick',[10:20:100])
title('AVISO')
text(50,50,['Anticyclones ',num2str(round(100*pmean(aviso_eddies.amp(ai)))./100),' cm'],'fontsize',10,'color','r')
text(50,45,['     Cyclones ',num2str(round(100*pmean(aviso_eddies.amp(ci)))./100),' cm'],'fontsize',10,'color','b')

subplot(223)
plot(ba,nc./na,'k','linewidth',2)
line([0 100],[1 1],'color','k')
axis([4 100 0 8])
set(gca,'xtick',[10:20:100])
text(10,6,'cyclonic/anticyclonic','fontsize',10)
xlabel('Amplitude (cm)')

subplot(222)
stairs(ba,npa,'r','linewidth',2)
hold on
stairs(bc,npc,'b','linewidth',2)
axis([4 100 0 55])
set(gca,'xtick',[10:20:100])
title('POP')
text(50,50,['Anticyclones ',num2str(round(100*pmean(pop_eddies.amp(pai)))./100),' cm'],'fontsize',10,'color','r')
text(50,45,['     Cyclones ',num2str(round(100*pmean(pop_eddies.amp(pci)))./100),' cm'],'fontsize',10,'color','b')

subplot(224)
plot(ba,npc./npa,'k','linewidth',2)
line([0 100],[1 1],'color','k')
axis([4 100 0 8])
set(gca,'xtick',[10:20:100])
text(10,6,'cyclonic/anticyclonic','fontsize',10)
xlabel('Amplitude (cm)')

print -dpng -r300 figs/histos_amps_jan_5


[na,ba]=hist(aviso_eddies.radius(ai),15);
[nc,bc]=hist(aviso_eddies.radius(ci),ba);
npa=hist(pop_eddies.radius(pai),ba);
npc=hist(pop_eddies.radius(pci),bc);

na=100*(na./sum(na));
nc=100*(nc./sum(nc));

npa=100*(npa./sum(npa));
npc=100*(npc./sum(npc));

figure(3)
clf
set(gcf,'PaperPosition',[1 1 8 6])
subplot(221)
stairs(ba,na,'r','linewidth',2)
hold on
stairs(bc,nc,'b','linewidth',2)
axis([60 180 0 14])
% set(gca,'xtick',[10:20:100])
title('AVISO')
text(110,13,['Anticyclones ',num2str(round(10*pmean(aviso_eddies.radius(ai)))./10),' km'],'fontsize',10,'color','r')
text(110,12,['     Cyclones ',num2str(round(10*pmean(aviso_eddies.radius(ci)))./10),' km'],'fontsize',10,'color','b')

subplot(223)
plot(ba,nc./na,'k','linewidth',2)
line([0 1000],[1 1],'color','k')
axis([60 180 0 2])
% set(gca,'xtick',[10:20:100])
text(70,1.5,'cyclonic/anticyclonic','fontsize',10)
xlabel('radius (km)')

subplot(222)
stairs(ba,npa,'r','linewidth',2)
hold on
stairs(bc,npc,'b','linewidth',2)
axis([60 180 0 14])
% set(gca,'xtick',[10:20:100])
title('POP')
text(110,13,['Anticyclones ',num2str(round(10*pmean(pop_eddies.radius(pai)))./10),' km'],'fontsize',10,'color','r')
text(110,12,['     Cyclones ',num2str(round(10*pmean(pop_eddies.radius(pci)))./10),' km'],'fontsize',10,'color','b')

subplot(224)
plot(ba,npc./npa,'k','linewidth',2)
line([0 1000],[1 1],'color','k')
axis([60 180 0 2])
% set(gca,'xtick',[10:20:100])
text(70,1.5,'cyclonic/anticyclonic','fontsize',10)
xlabel('radius (km)')

print -dpng -r300 figs/histos_scale_jan_5
