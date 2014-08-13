clear all

load tmp_ssh hp_ssh tlat tlon


minlat=30;
maxlat=50;
minlon=180+(180-70);
maxlon=180+(180-35);

[r,c]=imap(minlat,maxlat,minlon,maxlon,tlat,tlon);
lat=tlat(r,c);
lon=tlon(r,c);

SSH=hp_ssh(r,c,:);

clear hp_ssh tlat tlon
jdays=1:5:35;

whos lon lat SSH
eddies=track_eddies2(lon,lat,jdays,SSH,.25);

save 7_week_pop_eddies eddies SSH


load tmp_aviso_eddies aviso_eddies
load tmp_larry_pop_eddies pop_eddies
load 7_week_pop_eddies eddies SSH


uid=unique(aviso_eddies.id);
puid=unique(eddies.id);



ai=find(aviso_eddies.cyc==1);
ci=find(aviso_eddies.cyc==-1);
pai=find(eddies.cyc==1);
pci=find(eddies.cyc==-1);
lai=find(pop_eddies.cyc==1);
lci=find(pop_eddies.cyc==-1);

[na,ba]=hist(aviso_eddies.amp(ai),20);
[nc,bc]=hist(aviso_eddies.amp(ci),ba);
npa=hist(eddies.amp(pai),ba);
npc=hist(eddies.amp(pci),bc);
nla=hist(pop_eddies.amp(pai),ba);
nlc=hist(pop_eddies.amp(pci),bc);

figure(3)
clf
subplot(311)
stairs(ba,100*(na./nansum(na)),'r','linewidth',1)
hold on
stairs(bc,100*(nc./nansum(nc)),'b','linewidth',1)
set(gca,'fontsize',8,'fontweight','bold','LineWidth',1,'TickLength',[.02 .05],'layer','top')
title('AVISO eddy amplitude (16-years)','fontsize',14,'fontweight','bold')

subplot(312)
stairs(ba,100*(nla./nansum(nla)),'r','linewidth',1)
hold on
stairs(bc,100*(nlc./nansum(nlc)),'b','linewidth',1)
title('WHOI POP eddy amplitude (5-years)','fontsize',14,'fontweight','bold')
set(gca,'fontsize',14,'fontweight','bold','LineWidth',1,'TickLength',[.02 .05],'layer','top')

subplot(313)
stairs(ba,100*(npa./nansum(npa)),'r','linewidth',1)
hold on
stairs(bc,100*(npc./nansum(npc)),'b','linewidth',1)
title('NCAR POP eddy amplitude (7  weeks)','fontsize',14,'fontweight','bold')
set(gca,'fontsize',14,'fontweight','bold','LineWidth',1,'TickLength',[.02 .05],'layer','top')

print -dpng -r150 test_eddies_amp_hist


[na,ba]=hist(aviso_eddies.radius(ai),20);
[nc,bc]=hist(aviso_eddies.radius(ci),ba);
npa=hist(eddies.radius(pai),ba);
npc=hist(eddies.radius(pci),bc);
nla=hist(pop_eddies.radius(lai),ba);
nlc=hist(pop_eddies.radius(lci),bc);

figure(4)
clf
subplot(311)
stairs(ba,100*(na./nansum(na)),'r','linewidth',1)
hold on
stairs(bc,100*(nc./nansum(nc)),'b','linewidth',1)
title('AVISO eddy radius (16-years)','fontsize',14,'fontweight','bold')
set(gca,'fontsize',8,'fontweight','bold','LineWidth',1,'TickLength',[.02 .05],'layer','top')

subplot(312)
stairs(ba,100*(nla./nansum(nla)),'r','linewidth',1)
hold on
stairs(bc,100*(nlc./nansum(nlc)),'b','linewidth',1)
title('WHOI POP eddy radius (5-years)','fontsize',14,'fontweight','bold')
set(gca,'fontsize',14,'fontweight','bold','LineWidth',1,'TickLength',[.02 .05],'layer','top')

subplot(313)
stairs(ba,100*(npa./nansum(npa)),'r','linewidth',1)
hold on
stairs(bc,100*(npc./nansum(npc)),'b','linewidth',1)
title('NCAR POP eddy radius (7  weeks)','fontsize',14,'fontweight','bold')
set(gca,'fontsize',8,'fontweight','bold','LineWidth',1,'TickLength',[.02 .05],'layer','top')

print -dpng -r150 test_eddies_radius_hist

figure(2)
clf

% % now just look at first 5 weeks of aviso eddies
ujd=unique(aviso_eddies.track_jday);
ii=sames(ujd(1:5),aviso_eddies.track_jday);

aviso_eddies.id=aviso_eddies.id(ii);aviso_eddies.x=aviso_eddies.x(ii);
aviso_eddies.y=aviso_eddies.y(ii);aviso_eddies.track_jday=aviso_eddies.track_jday(ii);
aviso_eddies.cyc=aviso_eddies.cyc(ii);aviso_eddies.eid=aviso_eddies.eid(ii);
aviso_eddies.amp=aviso_eddies.amp(ii);aviso_eddies.k=aviso_eddies.k(ii);
aviso_eddies.radius=aviso_eddies.radius(ii);

% % now just look at first 7 weeks of WHOI eddies
ujd=unique(pop_eddies.track_jday);
ii=sames(ujd(1:7),pop_eddies.track_jday);

pop_eddies.id=pop_eddies.id(ii);pop_eddies.x=pop_eddies.x(ii);
pop_eddies.y=pop_eddies.y(ii);pop_eddies.track_jday=pop_eddies.track_jday(ii);
pop_eddies.cyc=pop_eddies.cyc(ii);pop_eddies.eid=pop_eddies.eid(ii);
pop_eddies.amp=pop_eddies.amp(ii);pop_eddies.k=pop_eddies.k(ii);
pop_eddies.radius=pop_eddies.radius(ii);


           
subplot(311)
pmap(lon,lat,nan*SSH(:,:,1))
hold on
uid=unique(aviso_eddies.id);
for m=1:length(uid)
    ii=find(aviso_eddies.id==uid(m));
    m_plot(aviso_eddies.x(ii),aviso_eddies.y(ii),'k')
end
title('AVISO tracks (first 5 7-day weeks)','fontsize',14,'fontweight','bold')
m_text(maxlon+2,40,[num2str(length(aviso_eddies.id)),' eddies'],'fontsize',8)
set(gca,'fontsize',8,'fontweight','bold','LineWidth',1,'TickLength',[.02 .05],'layer','top')

subplot(312)
pmap(lon,lat,nan*SSH(:,:,1))
hold on
uid=unique(pop_eddies.id);
for m=1:length(uid)
    ii=find(pop_eddies.id==uid(m));
%     pop_eddies.x(ii)
%     pop_eddies.y(ii)
    m_plot(pop_eddies.x(ii),pop_eddies.y(ii),'k')
end
title('WHOI POP tracks (first 7 5-day weeks)','fontsize',14,'fontweight','bold')
m_text(maxlon+2,40,[num2str(length(pop_eddies.id)),' eddies'],'fontsize',8)
set(gca,'fontsize',8,'fontweight','bold','LineWidth',1,'TickLength',[.02 .05],'layer','top')


subplot(313)
pmap(lon,lat,nan*SSH(:,:,1))
hold on
uid=unique(eddies.id);
for m=1:length(uid)
    ii=find(eddies.id==uid(m));
    m_plot(eddies.x(ii),eddies.y(ii),'k')
end
title('NCAR POP tracks (first 7 5-day weeks)','fontsize',14,'fontweight','bold')
m_text(maxlon+2,40,[num2str(length(isnan(eddies.id))),' eddies'],'fontsize',8)
set(gca,'fontsize',8,'fontweight','bold','LineWidth',1,'TickLength',[.02 .05],'layer','top')

print -dpng -r150 test_eddies_tracks

