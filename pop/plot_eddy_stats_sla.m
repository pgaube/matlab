
load test_aviso_GS_mdt

load GS_rings_tracks_aviso_jan_5


ai=find(aviso_eddies.cyc==1);
ci=find(aviso_eddies.cyc==-1);
pai=find(mdt_eddies.cyc==1);
pci=find(mdt_eddies.cyc==-1);

%%make maps
minlat=30;
maxlat=50;
minlon=180+(180-70);
maxlon=180+(180-35);


figure(1)
clf
pmap(minlon:maxlon,minlat:maxlat,nan(length(minlat:maxlat),length(minlon:maxlon)))
hold on
uid=unique(aviso_eddies.id);
for m=1:length(uid)
    ii=find(aviso_eddies.id==uid(m));
    if aviso_eddies.cyc(ii(1))==1
        m_plot(aviso_eddies.x(ii),aviso_eddies.y(ii),'r')
        dd=find(aviso_eddies.k(ii)==1);
        if any(dd)
            m_plot(aviso_eddies.x(ii(dd)),aviso_eddies.y(ii(dd)),'r.','markersize',15)
        end    
    elseif aviso_eddies.cyc(ii(1))<1
        m_plot(aviso_eddies.x(ii),aviso_eddies.y(ii),'b')
        dd=find(aviso_eddies.k(ii)==1);
        if any(dd)
            m_plot(aviso_eddies.x(ii(dd)),aviso_eddies.y(ii(dd)),'b.','markersize',15)
        end
    end
end
title('Eddies tracked in SLA')
xlabel([num2str(length(aviso_eddies.id(aviso_eddies.cyc==-1))),' cyclones and ',num2str(length(aviso_eddies.id(aviso_eddies.cyc==1))),' anticyclones'])
print -dpng -r300 figs/tracks_from_sla

figure(2)
clf
pmap(minlon:maxlon,minlat:maxlat,nan(length(minlat:maxlat),length(minlon:maxlon)))
hold on
uid=unique(mdt_eddies.id);
for m=1:length(uid)
    ii=find(mdt_eddies.id==uid(m));
    if mdt_eddies.cyc(ii(1))==1
        m_plot(mdt_eddies.x(ii),mdt_eddies.y(ii),'r')
        dd=find(mdt_eddies.k(ii)==1);
        if any(dd)
            m_plot(mdt_eddies.x(ii(dd)),mdt_eddies.y(ii(dd)),'r.','markersize',15)
        end    
    elseif mdt_eddies.cyc(ii(1))<1
        m_plot(mdt_eddies.x(ii),mdt_eddies.y(ii),'b')
        dd=find(mdt_eddies.k(ii)==1);
        if any(dd)
            m_plot(mdt_eddies.x(ii(dd)),mdt_eddies.y(ii(dd)),'b.','markersize',15)
        end
    end
end
title('Eddies tracked in MDT')
xlabel([num2str(length(mdt_eddies.id(mdt_eddies.cyc==-1))),' cyclones and ',num2str(length(mdt_eddies.id(mdt_eddies.cyc==1))),' anticyclones'])
print -dpng -r300 figs/tracks_from_mdt
% return


%%make hists

[na,ba]=hist(aviso_eddies.amp(ai),15);
[nc,bc]=hist(aviso_eddies.amp(ci),ba);
npa=hist(mdt_eddies.amp(pai),ba);
npc=hist(mdt_eddies.amp(pci),bc);

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
title('SSH')
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
title('MDT')
text(50,20,['Anticyclones ',num2str(round(100*pmean(mdt_eddies.amp(pai)))./100),' cm'],'fontsize',10,'color','r')
text(50,17,['     Cyclones ',num2str(round(100*pmean(mdt_eddies.amp(pci)))./100),' cm'],'fontsize',10,'color','b')

subplot(224)
plot(ba,npc./npa,'k','linewidth',2)
line([0 100],[1 1],'color','k')
axis([4 100 0 8])
set(gca,'xtick',[10:20:100])
text(10,6,'cyclonic/anticyclonic','fontsize',10)
xlabel('Amplitude (cm)')

print -dpng -r300 figs/histos_mdt_amps_jan_5


[na,ba]=hist(aviso_eddies.radius(ai),15);
[nc,bc]=hist(aviso_eddies.radius(ci),ba);
npa=hist(mdt_eddies.radius(pai),ba);
npc=hist(mdt_eddies.radius(pci),bc);

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
title('SSH')
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
title('MDT')
text(120,13,['Anticyclones ',num2str(round(1*pmean(mdt_eddies.radius(pai)))./1),' km'],'fontsize',10,'color','r')
text(120,12,['     Cyclones ',num2str(round(1*pmean(mdt_eddies.radius(pci)))./1),' km'],'fontsize',10,'color','b')

subplot(224)
plot(ba,npc./npa,'k','linewidth',2)
line([0 1000],[1 1],'color','k')
axis([60 180 0 2])
% set(gca,'xtick',[10:20:100])
text(70,1.5,'cyclonic/anticyclonic','fontsize',10)
xlabel('Effective radius (km)')

print -dpng -r300 figs/histos_mdt_scale_jan_5


%lifetime
uid=unique(mdt_eddies.id);
for n=1:length(uid)
    ii=find(mdt_eddies.id==uid(n));
    mdt_eddies.lt(n)=max(mdt_eddies.k(ii));
    mdt_eddies.cc(n)=mdt_eddies.cyc(ii(1));
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
[b,npa]=phist(mdt_eddies.lt(mdt_eddies.cc==1),tbins);
[b,npc]=phist(mdt_eddies.lt(mdt_eddies.cc==-1),tbins);

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
title('SSH')
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
title('MDT')
text(12,30,['Anticyclones ',num2str(round(10*pmean(mdt_eddies.lt(mdt_eddies.cc==1)))./10),' weeks'],'fontsize',10,'color','r')
text(12,27,['    Cyclones ',num2str(round(10*pmean(mdt_eddies.lt(mdt_eddies.cc==-1)))./10),' weeks'],'fontsize',10,'color','b')

subplot(224)
plot(ba,npc./npa,'k','linewidth',2)
line([0 1000],[1 1],'color','k')
axis([4 30 0 2])
% set(gca,'xtick',[10:20:100])
text(1.2,1.7,'cyclonic/anticyclonic','fontsize',10)
xlabel('Age (weeks)')

print -dpng -r300 figs/histos_mdt_age_jan_5
