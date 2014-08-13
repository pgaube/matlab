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
            aviso_eddies.k==1 & aviso_eddies.x<=180+180-50);
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

save GS_core_eddies_observed_sla_1_week stream_eddies


