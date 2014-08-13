
load GS_rings_cor_tracks_jan_5
pop_eddies.amp=amp;
pop_eddies.radius=radius;
pop_eddies.cyc=cyc;
pop_eddies.k=k;
pop_eddies.id=id


load AVISO_GS_rings_cor_tracks_jan_5
aviso_eddies.amp=amp;
aviso_eddies.radius=radius;
aviso_eddies.cyc=cyc;
aviso_eddies.k=k;
aviso_eddies.id=id


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
axis([4 100 0 30])
set(gca,'xtick',[10:20:100],'ytick',[5:5:60])
title('AVISO')
text(50,20,['Anticyclones ',num2str(round(100*pmean(aviso_eddies.amp(ai)))./100),' cm'],'fontsize',10,'color','r')
text(50,17,['     Cyclones ',num2str(round(100*pmean(aviso_eddies.amp(ci)))./100),' cm'],'fontsize',10,'color','b')

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
axis([4 100 0 30])
set(gca,'xtick',[10:20:100],'ytick',[5:5:60])
title('POP')
text(50,20,['Anticyclones ',num2str(round(100*pmean(pop_eddies.amp(pai)))./100),' cm'],'fontsize',10,'color','r')
text(50,17,['     Cyclones ',num2str(round(100*pmean(pop_eddies.amp(pci)))./100),' cm'],'fontsize',10,'color','b')

subplot(224)
plot(ba,npc./npa,'k','linewidth',2)
line([0 100],[1 1],'color','k')
axis([4 100 0 8])
set(gca,'xtick',[10:20:100])
text(10,6,'cyclonic/anticyclonic','fontsize',10)
xlabel('Amplitude (cm)')

print -dpng -r300 figs/histos_rings_amps_jan_5


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
axis([60 180 0 15])
set(gca,'ytick',[2:2:20])
title('AVISO')
text(120,13,['Anticyclones ',num2str(round(1*pmean(aviso_eddies.radius(ai)))./1),' km'],'fontsize',10,'color','r')
text(120,12,['     Cyclones ',num2str(round(1*pmean(aviso_eddies.radius(ci)))./1),' km'],'fontsize',10,'color','b')

subplot(223)
plot(ba,nc./na,'k','linewidth',2)
line([0 1000],[1 1],'color','k')
axis([60 180 0 2])
% set(gca,'xtick',[10:20:100])
text(70,1.5,'cyclonic/anticyclonic','fontsize',10)
xlabel('Effective radius (km)')

subplot(222)
stairs(ba,npa,'r','linewidth',2)
hold on
stairs(bc,npc,'b','linewidth',2)
axis([60 180 0 15])
set(gca,'ytick',[2:2:20])
title('POP')
text(120,13,['Anticyclones ',num2str(round(1*pmean(pop_eddies.radius(pai)))./1),' km'],'fontsize',10,'color','r')
text(120,12,['     Cyclones ',num2str(round(1*pmean(pop_eddies.radius(pci)))./1),' km'],'fontsize',10,'color','b')

subplot(224)
plot(ba,npc./npa,'k','linewidth',2)
line([0 1000],[1 1],'color','k')
axis([60 180 0 2])
% set(gca,'xtick',[10:20:100])
text(70,1.5,'cyclonic/anticyclonic','fontsize',10)
xlabel('Effective radius (km)')

print -dpng -r300 figs/histos_rings_scale_jan_5


%lifetime
uid=unique(pop_eddies.id);
for n=1:length(uid)
    ii=find(pop_eddies.id==uid(n));
    pop_eddies.lt(n)=max(pop_eddies.k(ii));
    pop_eddies.cc(n)=pop_eddies.cyc(ii(1));
end

uid=unique(aviso_eddies.id);
for n=1:length(uid)
    ii=find(aviso_eddies.id==uid(n));
    aviso_eddies.lt(n)=max(aviso_eddies.k(ii));
    aviso_eddies.cc(n)=aviso_eddies.cyc(ii(1));
end
tbins=4:2:30;
[ba,na]=phist(aviso_eddies.lt(aviso_eddies.cc==1),tbins);
[bc,nc]=phist(aviso_eddies.lt(aviso_eddies.cc==-1),tbins);
[b,npa]=phist(pop_eddies.lt(pop_eddies.cc==1),tbins);
[b,npc]=phist(pop_eddies.lt(pop_eddies.cc==-1),tbins);

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
axis([4 30 0 40])
% set(gca,'xtick',[10:20:100])
title('AVISO')
text(12,30,['Anticyclones ',num2str(round(10*pmean(aviso_eddies.lt(aviso_eddies.cc==1)))./10),' weeks'],'fontsize',10,'color','r')
text(12,27,['    Cyclones ',num2str(round(10*pmean(aviso_eddies.lt(aviso_eddies.cc==-1)))./10),' weeks'],'fontsize',10,'color','b')

subplot(223)
plot(ba,nc./na,'k','linewidth',2)
line([0 1000],[1 1],'color','k')
axis([4 30 0 2])
% set(gca,'xtick',[10:20:100])
text(1.2,1.7,'cyclonic/anticyclonic','fontsize',10)
xlabel('Age (weeks)')

subplot(222)
stairs(ba,npa,'r','linewidth',2)
hold on
stairs(bc,npc,'b','linewidth',2)
axis([4 30 0 40])
% set(gca,'xtick',[10:20:100])
title('POP')
text(12,30,['Anticyclones ',num2str(round(10*pmean(pop_eddies.lt(pop_eddies.cc==1)))./10),' weeks'],'fontsize',10,'color','r')
text(12,27,['    Cyclones ',num2str(round(10*pmean(pop_eddies.lt(pop_eddies.cc==-1)))./10),' weeks'],'fontsize',10,'color','b')

subplot(224)
plot(ba,npc./npa,'k','linewidth',2)
line([0 1000],[1 1],'color','k')
axis([4 30 0 2])
% set(gca,'xtick',[10:20:100])
text(1.2,1.7,'cyclonic/anticyclonic','fontsize',10)
xlabel('Age (weeks)')

print -dpng -r300 figs/histos_rings_age_jan_5
