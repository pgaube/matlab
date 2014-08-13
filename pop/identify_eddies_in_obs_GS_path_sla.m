load mean_gs_path_obs_pop lons lats std_lats mean std
% load GS_rings_tracks_run14_mdt aviso_eddies
load GS_rings_tracks_run14_sla aviso_eddies
load obs_cor_0

minlat=30;
maxlat=50;
minlon=min(mean(:,1));
maxlon=max(mean(:,1));

plat=slat;plon=slon;
lons=mean(:,1);
lats=mean(:,2);
std_lats=std;

[rp,cp]=imap(minlat,maxlat,minlon,maxlon,plat,plon);
plat=plat(rp,cp);
plon=plon(rp,cp);


load bwr.pal
load chelle.pal
rref=-.3;
r0(:,:,9)=smoothn(r0(:,:,9),20);
bs=7;
as=2;

load mean_gulf_stream
mean(:,1)=180+(180+mean(:,1));
minlat=30;
maxlat=50;
minlon=min(mean(:,1));
maxlon=max(mean(:,1));


good_ids=nan*aviso_eddies.id;
for m=1:length(lons)-1
    ii=find(aviso_eddies.x>=lons(m) & aviso_eddies.x<lons(m+1) & ...
            aviso_eddies.y>=lats(m)-bs & ...
            aviso_eddies.y<=lats(m)+as & ...
            aviso_eddies.k==1 & aviso_eddies.x<=180+180-50 &...
            aviso_eddies.age>=1);
        if any(ii)
            good_ids(ii)=aviso_eddies.id(ii);
        end
    clear ii
end

ii=sames(unique(good_ids),aviso_eddies.id);
stream_eddies.x=aviso_eddies.x(ii);
stream_eddies.y=aviso_eddies.y(ii);
stream_eddies.k=aviso_eddies.k(ii);
stream_eddies.eid=aviso_eddies.eid(ii);
stream_eddies.id=aviso_eddies.id(ii);
stream_eddies.cyc=aviso_eddies.cyc(ii);
stream_eddies.amp=aviso_eddies.amp(ii);
stream_eddies.track_jday=aviso_eddies.track_jday(ii);
stream_eddies.radius=aviso_eddies.radius(ii);
stream_eddies.age=aviso_eddies.age(ii);

stream_eddies.adens=nan*stream_eddies.x;
stream_eddies.adens(stream_eddies.cyc==1)=-1;
stream_eddies.adens(stream_eddies.cyc==-1)=1;


%%%now aplly westward only criteria

uid=unique(stream_eddies.id);
ugood=nan*uid;

for mmu=1:length(uid)
    ii=find(stream_eddies.id==uid(mmu));
    if stream_eddies.x(ii(1))>stream_eddies.x(ii(end))
        ugood(ii)=uid(mmu);
    end
end
  
ii=sames(unique(ugood),aviso_eddies.id);
stream_eddies.x=aviso_eddies.x(ii);
stream_eddies.y=aviso_eddies.y(ii);
stream_eddies.k=aviso_eddies.k(ii);
stream_eddies.eid=aviso_eddies.eid(ii);
stream_eddies.id=aviso_eddies.id(ii);
stream_eddies.cyc=aviso_eddies.cyc(ii);
stream_eddies.amp=aviso_eddies.amp(ii);
stream_eddies.track_jday=aviso_eddies.track_jday(ii);
stream_eddies.radius=aviso_eddies.radius(ii);
stream_eddies.age=aviso_eddies.age(ii);

stream_eddies.adens=nan*stream_eddies.x;
stream_eddies.adens(stream_eddies.cyc==1)=-1;
stream_eddies.adens(stream_eddies.cyc==-1)=1;

save GS_core_eddies_observed_sla stream_eddies

load GS_rings_tracks_run14_sla

lat=min(pop_eddies.y):.25:max(pop_eddies.y);
lon=min(pop_eddies.x):.25:max(pop_eddies.x);
[lon,lat]=meshgrid(lon,lat);

load GS_core_eddies_observed_sla

figure(1)
clf
pmap(lon,lat,nan(length(lat(:,1)),length(lon(1,:))),'gs')
hold on
uid=unique(aviso_eddies.id);
for m=1:length(uid)
    ii=find(aviso_eddies.id==uid(m));
    m_plot(aviso_eddies.x(ii),aviso_eddies.y(ii),'color',[.5 .5 .5])
    m_plot(aviso_eddies.x(ii(1)),aviso_eddies.y(ii(1)),'.','color',[.5 .5 .5],'markersize',5)
end
ia=unique(stream_eddies.id(find(stream_eddies.cyc==1)));
ic=unique(stream_eddies.id(find(stream_eddies.cyc==-1)));
for m=1:length(ia)
    ii=find(stream_eddies.id==ia(m));
    m_plot(stream_eddies.x(ii),stream_eddies.y(ii),'r','linewidth',1)
    m_plot(stream_eddies.x(ii(1)),stream_eddies.y(ii(1)),'r.','markersize',10)
end

for m=1:length(ic)
    ii=find(stream_eddies.id==ic(m));
    m_plot(stream_eddies.x(ii),stream_eddies.y(ii),'b','linewidth',1)
    m_plot(stream_eddies.x(ii(1)),stream_eddies.y(ii(1)),'b.','markersize',10)
end

%%%now add case study
ii=find(aviso_eddies.id==1507);
m_plot(aviso_eddies.x(ii)-12,aviso_eddies.y(ii)-1.5,'r','linewidth',4)
ii=find(aviso_eddies.id==230);
m_plot(aviso_eddies.x(ii)-5,aviso_eddies.y(ii)-4,'b','linewidth',4)
% ii=find(stream_eddies.id==1475);
% m_plot(stream_eddies.x(ii),stream_eddies.y(ii),'g','linewidth',4)
% ii=find(stream_eddies.id==882);
% m_plot(stream_eddies.x(ii),stream_eddies.y(ii),'c','linewidth',4)
% ii=find(stream_eddies.id==1592);
% m_plot(stream_eddies.x(ii),stream_eddies.y(ii),'k','linewidth',4)

m_plot(smoothn(lons,10),smoothn(lats,10),'k','linewidth',2);
m_plot(smoothn(lons,10),smoothn(lats-bs,10),'k--','linewidth',1)
m_plot(smoothn(lons,10),smoothn(lats+as,10),'k--','linewidth',1)
% title('Tracked in SLA and go westward  4 weeks')
m_text(291,50.1,[num2str(length(unique(stream_eddies.id(stream_eddies.cyc==1)))),' anticyclones'],'color','r')
m_text(302,50.1,[num2str(length(unique(stream_eddies.id(stream_eddies.cyc==-1)))),' cyclones'],'color','b')
print -dpng -r300 figs/gs_core_with_cor_tracks_obs_sla

