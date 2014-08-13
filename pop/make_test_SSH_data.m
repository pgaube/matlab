clear all
spath='~/data/eddy/V5/mat/AVISO_25_W_';
startjd=2450548;
endjd=2451633;
jdays=[startjd:7:endjd];
    
jdays=jdays(1:50);

minlat=30;
maxlat=50;
minlon=180+(180-70);
maxlon=180+(180-35);
% load ~/data/eddy/V5/global_tracks_V5 x y amp k id cyc track_jday scale
% ii=find(track_jday>=min(jdays) & track_jday<=max(jdays) & x>=minlon & x<=maxlon & y>=minlat & y<=maxlat);
% x=x(ii);
% y=y(ii);
% amp=amp(ii);
% cyc=cyc(ii);
% track_jday=track_jday(ii);
% scale=scale(ii);
% k=k(ii);
% id=id(ii);
% %now only ones that orrignated here
% ii=find(k==1);
% uid=unique(id(ii));
% ii=sames(uid,id);
% x=x(ii);
% y=y(ii);
% amp=amp(ii);
% cyc=cyc(ii);
% track_jday=track_jday(ii);
% scale=scale(ii);
% k=k(ii);
% id=id(ii);
% 
% % 
% % % now load SSH data
load([spath,num2str(startjd)],'lat','lon')
[r,c]=imap(minlat,maxlat,minlon,maxlon,lat,lon);
lat=lat(r,c);
lon=lon(r,c);

SSH=nan(length(r),length(c),length(jdays));
for m=1:length(jdays)
    load([spath,num2str(jdays(m))],'ssh')
    SSH(:,:,m)=ssh(r,c);
    clear ssh
end

[year,month,day]=jd2jdate(jdays);
save test_data SSH lat lon jdays year month day
return



% eddies_v2=track_eddies2(lon,lat,jdays,SSH,.25);
eddies_v3=track_eddies_PG(lon,lat,jdays,SSH,.25,5);
return
% save test_tracks

load test_tracks eddies
figure(1)
clf
subplot(211)
pmap(lon,lat,nan*SSH(:,:,1))
hold on
uid=unique(id);
for m=1:length(uid)
    ii=find(id==uid(m));
    m_plot(x(ii),y(ii),'k')
end

subplot(212)
pmap(lon,lat,nan*SSH(:,:,1))
hold on
uid=unique(eddies.id);
for m=1:length(uid)
    ii=find(eddies.id==uid(m));
    m_plot(eddies.x(ii),eddies.y(ii),'b')
end

uid=unique(id);
puid=unique(eddies.id);
length(x)
length(eddies.x)


% return

figure(2)
clf
pmap(lon,lat,nan*SSH(:,:,1))
hold on
uid=unique(id);
for m=1:length(uid)
    ii=find(id==uid(m));
    m_plot(x(ii),y(ii),'k')
end

uid=unique(eddies.id);
for m=1:length(uid)
    ii=find(eddies.id==uid(m));
    m_plot(eddies.x(ii),eddies.y(ii),'b')
end

% return

uid=unique(id);
puid=unique(eddies.id);
length(x)
length(eddies.x)


ai=find(cyc==1);
ci=find(cyc==-1);
pai=find(eddies.cyc==1);
pci=find(eddies.cyc==-1);

[na,ba]=hist(amp(ai),20);
[nc,bc]=hist(amp(ci),ba);
npa=hist(eddies.amp(pai),ba);
npc=hist(eddies.amp(pci),bc);

figure(3)
clf
subplot(211)
stairs(ba,100*(na./nansum(na)),'r')
hold on
stairs(bc,100*(nc./nansum(nc)),'b')

subplot(212)
stairs(ba,100*(npa./nansum(npa)),'r')
hold on
stairs(bc,100*(npc./nansum(npc)),'b')


[na,ba]=hist(scale(ai),20);
[nc,bc]=hist(scale(ci),ba);
npa=hist(eddies.radius(pai),ba);
npc=hist(eddies.radius(pci),bc);

figure(4)
clf
subplot(211)
stairs(ba,100*(na./nansum(na)),'r')
hold on
stairs(bc,100*(nc./nansum(nc)),'b')

subplot(212)
stairs(ba,100*(npa./nansum(npa)),'r')
hold on
stairs(bc,100*(npc./nansum(npc)),'b')
