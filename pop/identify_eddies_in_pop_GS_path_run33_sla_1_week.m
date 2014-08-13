clear all
load mean_gs_path_obs_pop lons lats std_lats mean std
load GS_rings_tracks_run33_sla pop_eddies
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
            pop_eddies.k==1 & pop_eddies.x<=180+180-50);
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


save GS_core_eddies_run33_sla_1_week stream_eddies



