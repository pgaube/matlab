clear all
load mean_gs_path_obs_pop lons lats std_lats mean std
load GS_rings_tracks_run33_jan_5.mat pop_eddies
load pop_bec_cor_0_run_33

minlat=30;
maxlat=50;
minlon=min(mean(:,1));
maxlon=max(mean(:,1));

% plat=slat;plon=slon;


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


good_ids=nan*pop_eddies.id;
for m=1:length(lons)-1
    ii=find(pop_eddies.x>=lons(m) & pop_eddies.x<lons(m+1) & ...
            pop_eddies.y>=lats(m)-bs & ...
            pop_eddies.y<=lats(m)+as & ...
            pop_eddies.k==1 & pop_eddies.x<=180+180-50 &...
            pop_eddies.age>=6);
        if any(ii)
            good_ids(ii)=pop_eddies.id(ii);
        end
    clear ii
end

ii=sames(unique(good_ids),pop_eddies.id);
stream_eddies.x=pop_eddies.x(ii);
stream_eddies.y=pop_eddies.y(ii);
stream_eddies.k=pop_eddies.k(ii);
stream_eddies.eid=pop_eddies.eid(ii);
stream_eddies.id=pop_eddies.id(ii);
stream_eddies.cyc=pop_eddies.cyc(ii);
stream_eddies.amp=pop_eddies.amp(ii);
stream_eddies.track_jday=pop_eddies.track_jday(ii);
stream_eddies.radius=pop_eddies.radius(ii);
stream_eddies.age=pop_eddies.age(ii);

stream_eddies.adens=nan*stream_eddies.x;
stream_eddies.adens(stream_eddies.cyc==1)=-1;
stream_eddies.adens(stream_eddies.cyc==-1)=1;
% 
%%%now aplly westward only criteria

uid=unique(stream_eddies.id);
ugood=nan*uid;

for mmu=1:length(uid)
    ii=find(stream_eddies.id==uid(mmu));
    if stream_eddies.x(ii(1))>stream_eddies.x(ii(end))
        ugood(ii)=uid(mmu);
    end
end
  
ii=sames(unique(ugood),pop_eddies.id);
stream_eddies.x=pop_eddies.x(ii);
stream_eddies.y=pop_eddies.y(ii);
stream_eddies.k=pop_eddies.k(ii);
stream_eddies.eid=pop_eddies.eid(ii);
stream_eddies.id=pop_eddies.id(ii);
stream_eddies.cyc=pop_eddies.cyc(ii);
stream_eddies.amp=pop_eddies.amp(ii);
stream_eddies.track_jday=pop_eddies.track_jday(ii);
stream_eddies.radius=pop_eddies.radius(ii);
stream_eddies.age=pop_eddies.age(ii);

stream_eddies.adens=nan*stream_eddies.x;
stream_eddies.adens(stream_eddies.cyc==1)=-1;
stream_eddies.adens(stream_eddies.cyc==-1)=1;


save GS_core_eddies_run33 stream_eddies



figure(1)
clf
pmap(plon,plat,nan(length(plat(:,1)),length(plon(1,:))),'gs')
hold on
uid=unique(pop_eddies.id);
for m=1:length(uid)
    ii=find(pop_eddies.id==uid(m));
    m_plot(pop_eddies.x(ii),pop_eddies.y(ii),'color',[.5 .5 .5])
    m_plot(pop_eddies.x(ii(1)),pop_eddies.y(ii(1)),'.','color',[.5 .5 .5],'markersize',5)
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

% load case_study_tracks
% ii=find(id==515);
% cra=m_plot(x(ii),y(ii),'r','linewidth',3);
% set(cra,'clipping','off')
% m_plot(x(ii(1)),y(ii(1)),'r.','markersize',10)
% 
% ii=find(id==1);
% cra=m_plot(x(ii),y(ii),'b','linewidth',3)
% set(cra,'clipping','off')
% m_plot(x(ii(1)),y(ii(1)),'b.','markersize',10)

m_plot(smoothn(lons,10),smoothn(lats,10),'k','linewidth',2);
m_plot(smoothn(lons,10),smoothn(lats-bs,10),'k--','linewidth',1)
m_plot(smoothn(lons,10),smoothn(lats+as,10),'k--','linewidth',1)
% title('run14 Tracked in SLA and go westward  4 weeks')
m_text(291,50.5,[num2str(length(unique(stream_eddies.id(stream_eddies.cyc==1)))),' anticyclones'],'color','r')
m_text(302,50.5,[num2str(length(unique(stream_eddies.id(stream_eddies.cyc==-1)))),' cyclones'],'color','b')
print -dpng -r300 figs/gs_core_with_cor_tracks_run33

