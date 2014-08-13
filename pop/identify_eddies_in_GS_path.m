load mean_gs_path_obs_pop lons lats std_lats mean std
load GS_rings_tracks_run14_jan_30 pop_eddies
load cor_ssh_3chl_out r0 lon lat
load bwr.pal
load chelle.pal
rref=-.3;
[r,c]=imap(30,47,284,325,lat,lon);
r0(:,:,9)=smoothn(r0(:,:,9),20);
bs=3;
as=3;

% lon=min(pop_eddies.x-2):max(pop_eddies.x+2);
% lat=min(pop_eddies.y-1):max(pop_eddies.y+1);

good_ids=nan*pop_eddies.id;
for m=1:length(lons)-1
    ii=find(pop_eddies.x>=lons(m) & pop_eddies.x<lons(m+1) & ...
            pop_eddies.y>=lats(m)-bs*std_lats(m) & ...
            pop_eddies.y<=lats(m)+as*std_lats(m) & ...
            pop_eddies.k==1 & pop_eddies.x<=180+180-52);
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

save GS_core_eddies stream_eddies


figure(1)
clf
pmap(lon(r,c),lat(r,c),r0(r,c,9))
caxis([-.5 .5])
colormap(chelle)
hold on
% m_contour(lon(r,c),lat(r,c),r0(r,c,9),[rref rref],'k','linewidth',2)

hold on
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

m_plot(lons,lats,'k','linewidth',4)
m_plot(lons,lats-bs*std_lats,'k--','linewidth',3)
m_plot(lons,lats+as*std_lats,'k--','linewidth',3)
m_line([180+180-52 180+180-52],[30 50],'color','k')
print -dpng -r300 figs/r0_with_gs_core


figure(2)
clf
pmap(lon(r,c),lat(r,c),nan*r0(r,c,9))
hold on
ia=unique(pop_eddies.id(find(pop_eddies.cyc==1)));
ic=unique(pop_eddies.id(find(pop_eddies.cyc==-1)));
for m=1:length(ia)
    ii=find(pop_eddies.id==ia(m));
    m_plot(pop_eddies.x(ii),pop_eddies.y(ii),'r')
    m_plot(pop_eddies.x(ii(1)),pop_eddies.y(ii(1)),'r.','markersize',10)
end

for m=1:length(ic)
    ii=find(pop_eddies.id==ic(m));
    m_plot(pop_eddies.x(ii),pop_eddies.y(ii),'b')
    m_plot(pop_eddies.x(ii(1)),pop_eddies.y(ii(1)),'b.','markersize',10)
end

m_plot(lons,lats,'k','linewidth',4)
m_plot(lons,lats-bs*std_lats,'k--','linewidth',3)
m_plot(lons,lats+as*std_lats,'k--','linewidth',3)
m_line([180+180-52 180+180-52],[30 50],'color','k')
print -dpng -r300 figs/gs_core_with_all_tracks

good_ids=nan*pop_eddies.id;
for m=1:length(lons)-1
    ii=find(pop_eddies.x>=lons(m) & pop_eddies.x<lons(m+1) & ...
            pop_eddies.y>=lats(m)-bs*std_lats(m) & ...
            pop_eddies.y<=lats(m)+as*std_lats(m) & ...
            pop_eddies.k==1 & pop_eddies.x<=180+180-52);
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

save GS_core_eddies stream_eddies

figure(3)
clf
pmap(lon(r,c),lat(r,c),nan*r0(r,c,9))
hold on
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

m_plot(lons,lats,'k','linewidth',4)
m_plot(lons,lats-bs*std_lats,'k--','linewidth',3)
m_plot(lons,lats+as*std_lats,'k--','linewidth',3)
m_line([180+180-52 180+180-52],[30 50],'color','k')
print -dpng -r300 figs/gs_core_with_cor_tracks

