load mean_gs_path_obs_pop lons lats std_lats mean std
load GS_rings_tracks_run14_mdt pop_grid_eddies
load pop_bec_cor_0

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


good_ids=nan*pop_grid_eddies.id;
for m=1:length(lons)-1
    ii=find(pop_grid_eddies.x>=lons(m) & pop_grid_eddies.x<lons(m+1) & ...
            pop_grid_eddies.y>=lats(m)-bs & ...
            pop_grid_eddies.y<=lats(m)+as & ...
            pop_grid_eddies.k==1 & pop_grid_eddies.x<=180+180-50 &...
            pop_grid_eddies.age>=4);
        if any(ii)
            good_ids(ii)=pop_grid_eddies.id(ii);
        end
    clear ii
end

ii=sames(unique(good_ids),pop_grid_eddies.id);
stream_eddies.x=pop_grid_eddies.x(ii);
stream_eddies.y=pop_grid_eddies.y(ii);
stream_eddies.k=pop_grid_eddies.k(ii);
stream_eddies.eid=pop_grid_eddies.eid(ii);
stream_eddies.id=pop_grid_eddies.id(ii);
stream_eddies.cyc=pop_grid_eddies.cyc(ii);
stream_eddies.ro=pop_grid_eddies.ro(ii);
stream_eddies.track_jday=pop_grid_eddies.track_jday(ii);
stream_eddies.radius=pop_grid_eddies.radius(ii);
stream_eddies.age=pop_grid_eddies.age(ii);

stream_eddies.adens=nan*stream_eddies.x;
stream_eddies.adens(stream_eddies.cyc==1)=-1;
stream_eddies.adens(stream_eddies.cyc==-1)=1;

save GS_core_grid_eddies_run14 stream_eddies



figure(1)
clf
pmap(plon,plat,nan(length(plat(:,1)),length(plon(1,:))),'gs')
hold on
uid=unique(pop_grid_eddies.id);
for m=1:length(uid)
    ii=find(pop_grid_eddies.id==uid(m));
    m_plot(pop_grid_eddies.x(ii),pop_grid_eddies.y(ii),'color',[.5 .5 .5])
    m_plot(pop_grid_eddies.x(ii(1)),pop_grid_eddies.y(ii(1)),'.','color',[.5 .5 .5],'markersize',5)
end
ia=unique(stream_eddies.id(find(stream_eddies.cyc==1)));
ic=unique(stream_eddies.id(find(stream_eddies.cyc==-1)));
for m=1:length(ia)
    ii=find(stream_eddies.id==ia(m));
    m_plot(stream_eddies.x(ii),stream_eddies.y(ii),'r')
    m_plot(stream_eddies.x(ii(1)),stream_eddies.y(ii(1)),'r.','markersize',10)
end

for m=1:length(ic)
    ii=find(stream_eddies.id==ic(m));
    m_plot(stream_eddies.x(ii),stream_eddies.y(ii),'b')
    m_plot(stream_eddies.x(ii(1)),stream_eddies.y(ii(1)),'b.','markersize',10)
end

m_plot(smoothn(lons,10),smoothn(lats,10),'k','linewidth',2);
m_plot(smoothn(lons,10),smoothn(lats-bs,10),'k--','linewidth',1)
m_plot(smoothn(lons,10),smoothn(lats+as,10),'k--','linewidth',1)
title('run33 +/- 4 std 4 weeks')
print -dpng -r300 figs/gs_core_with_cor_tracks_grid_run13

