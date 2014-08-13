clear all
load bwr.pal
bs=7;
as=2;

loads={'GS_rings_tracks_run14_sla','GS_rings_tracks_run14_sla','GS_rings_tracks_run33_sla','GS_rings_tracks_run14_sla','GS_rings_tracks_run14_sla','GS_rings_tracks_run33_sla'};
fnames={'GS_core_eddies_observed_sla','GS_core_eddies_run14_sla','GS_core_eddies_run33_sla','GS_core_meanders_observed_sla','GS_core_meanders_run14_sla','GS_core_meanders_run33_sla'};
norths={'mean_gs_path_obs_pop','mean_gs_path_obs_pop','mean_gs_path_obs_pop_run_33','mean_gs_path_obs_pop','mean_gs_path_obs_pop','mean_gs_path_obs_pop_run_33'};
fig_names={'gs_core_with_cor_tracks_obs_sla','gs_core_with_cor_tracks_run14_sla','gs_core_with_cor_tracks_run33_sla','gs_core_meanders_obs_sla','gs_meanders_tracks_run14_sla','gs_meanders_tracks_run33_sla'};
load mean_gs_path_obs_pop_run_33 mean
minlat=30;
maxlat=50;
minlon=min(mean(:,1));
maxlon=max(mean(:,1));

load obs_cor_0 slon slat
plat=slat;plon=slon;
[rp,cp]=imap(minlat,maxlat,minlon,maxlon,plat,plon);
plat=plat(rp,cp);
plon=plon(rp,cp);

for drap=1:length(fnames)
    clearallbut fnames drap loads norths minlat maxlat minlon maxlon plon plat bwr as bs fig_names
    %%load tracks
    if drap==1 | drap==4
        load(loads{drap},'aviso_eddies')
        pop_eddies=aviso_eddies;
        load(norths{drap})
        lons=mean(:,1);
        lats=mean(:,2);
        std_lats=std;
    else
        load(loads{drap},'pop_eddies')
        load(norths{drap})
    end
    
    %%Identify eddie in GS
    good_ids=nan*pop_eddies.id;
    for m=1:length(lons)-1
        ii=find(pop_eddies.x>=lons(m) & pop_eddies.x<lons(m+1) & ...
            pop_eddies.y>=lats(m)-bs & ...
            pop_eddies.y<=lats(m)+as & ...
            pop_eddies.k==1 & pop_eddies.x<=180+180-50 &...
            pop_eddies.age>=1);
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
    
    
    
    %%%now aplly westward-or-eastward only criteria
    uid=unique(stream_eddies.id);
    ugood=nan*uid;
    if drap<4 %then looking for westward eddies
        for mmu=1:length(uid)
            ii=find(stream_eddies.id==uid(mmu));
%             alph(mmu)=nansum(abs(atan2d(stream_eddies.y(ii(2:end))-stream_eddies.y(ii(1:end-1)),stream_eddies.x(ii(2:end))-stream_eddies.x(ii(1:end-1)))));
            if stream_eddies.x(ii(1))>stream_eddies.x(ii(end))
                ugood(ii)=uid(mmu);
            end
        end
    else %looking for eastward meanders
        for mmu=1:length(uid)
            ii=find(stream_eddies.id==uid(mmu));
            if stream_eddies.x(ii(1))<stream_eddies.x(ii(end))
                ugood(ii)=uid(mmu);
            end
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
    
    stream_eddies.mask=pop_eddies.mask;
    stream_eddies.jdays=pop_eddies.jdays;
    eval(['save ',fnames{drap},' stream_eddies'])
    
%     %%Now plot
%     lat=min(pop_eddies.y):.25:max(pop_eddies.y);
%     lon=min(pop_eddies.x):.25:max(pop_eddies.x);
%     [lon,lat]=meshgrid(lon,lat);
%     
%     figure(1)
%     clf
%     pmap(lon,lat,nan(length(lat(:,1)),length(lon(1,:))),'gs')
%     hold on
%     uid=unique(pop_eddies.id);
%     for m=1:length(uid)
%         ii=find(pop_eddies.id==uid(m));
%         m_plot(pop_eddies.x(ii),pop_eddies.y(ii),'color',[.5 .5 .5],'clipping','off')
%         m_plot(pop_eddies.x(ii(1)),pop_eddies.y(ii(1)),'.','color',[.5 .5 .5],'markersize',5,'clipping','off')
%     end
%     ia=unique(stream_eddies.id(find(stream_eddies.cyc==1)));
%     ic=unique(stream_eddies.id(find(stream_eddies.cyc==-1)));
%     for m=1:length(ia)
%         ii=find(stream_eddies.id==ia(m));
%         m_plot(stream_eddies.x(ii),stream_eddies.y(ii),'r','linewidth',1,'clipping','off')
%         m_plot(stream_eddies.x(ii(1)),stream_eddies.y(ii(1)),'r.','markersize',10,'clipping','off')
%     end
%     
%     for m=1:length(ic)
%         ii=find(stream_eddies.id==ic(m));
%         m_plot(stream_eddies.x(ii),stream_eddies.y(ii),'b','linewidth',1,'clipping','off')
%         m_plot(stream_eddies.x(ii(1)),stream_eddies.y(ii(1)),'b.','markersize',10,'clipping','off')
%     end
%     
%     if drap==1
%         %%%now add case study
%         ii=find(pop_eddies.id==1507);
%         m_plot(pop_eddies.x(ii)-12,pop_eddies.y(ii)-1.5,'r','linewidth',4)
%         ii=find(pop_eddies.id==230);
%         m_plot(pop_eddies.x(ii)-5,pop_eddies.y(ii)-4,'b','linewidth',4)
%     end
%     
%     m_plot(smoothn(lons,10),smoothn(lats,10),'k','linewidth',2);
%     m_plot(smoothn(lons,10),smoothn(lats-bs,10),'k--','linewidth',1)
%     m_plot(smoothn(lons,10),smoothn(lats+as,10),'k--','linewidth',1)
%     m_text(291,50.1,[num2str(length(unique(stream_eddies.id(stream_eddies.cyc==1)))),' anticyclones'],'color','r')
%     m_text(302,50.1,[num2str(length(unique(stream_eddies.id(stream_eddies.cyc==-1)))),' cyclones'],'color','b')
% %     eval(['print -dpng -r300 figs/',fig_names{drap}])
    
    
    
end
