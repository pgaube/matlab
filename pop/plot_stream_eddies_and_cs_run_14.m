load mean_gs_path_obs_pop lons lats std_lats mean std
load GS_rings_tracks_run14_mdt pop_eddies
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
bs=6;
as=2;

load mean_gulf_stream
mean(:,1)=180+(180+mean(:,1));
minlat=30;
maxlat=50;
minlon=min(mean(:,1));
maxlon=max(mean(:,1));

load GS_core_eddies

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
    m_plot(stream_eddies.x(ii),stream_eddies.y(ii),'r')
    m_plot(stream_eddies.x(ii(1)),stream_eddies.y(ii(1)),'r.','markersize',10)
end

for m=1:length(ic)
    ii=find(stream_eddies.id==ic(m));
    m_plot(stream_eddies.x(ii),stream_eddies.y(ii),'b')
    m_plot(stream_eddies.x(ii(1)),stream_eddies.y(ii(1)),'b.','markersize',10)
end

load case_study_tracks
ii=find(id==515);
cra=m_plot(x(ii),y(ii),'r','linewidth',3);
set(cra,'clipping','off')
m_plot(x(ii(1)),y(ii(1)),'r.','markersize',10)

ii=find(id==1);
cra=m_plot(x(ii),y(ii),'b','linewidth',3)
set(cra,'clipping','off')
m_plot(x(ii(1)),y(ii(1)),'b.','markersize',10)



m_plot(smoothn(lons,10),smoothn(lats,10),'k','linewidth',2);
m_plot(smoothn(lons,10),smoothn(lats-bs,10),'k--','linewidth',1)
m_plot(smoothn(lons,10),smoothn(lats+as,10),'k--','linewidth',1)
title('run14 +/- 4 std 4 weeks')
print -dpng -r300 figs/gs_core_with_cor_tracks_run14

