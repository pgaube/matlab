clear all
load bwr.pal
bs=7;
as=2;

norths={'mean_gs_path_obs_pop','mean_gs_path_obs_pop','mean_gs_path_obs_pop_run_33','mean_gs_path_obs_pop','mean_gs_path_obs_pop','mean_gs_path_obs_pop_run_33'};
loads={'GS_rings_tracks_run14_sla','GS_rings_tracks_run14_sla','GS_rings_tracks_run33_sla','GS_rings_tracks_run14_sla','GS_rings_tracks_run14_sla','GS_rings_tracks_run33_sla'};
fnames={'GS_core_eddies_observed_sla','GS_core_eddies_run14_sla','GS_core_eddies_run33_sla','GS_core_meanders_observed_sla','GS_core_meanders_run14_sla','GS_core_meanders_run33_sla'};
fig_names={'obs_tracks_eddies_meanders','run14_tracks_eddies_meanders','run33_tracks_eddies_meanders'};
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

for drap=1:3%length(fnames)
    clearallbut fnames drap loads norths minlat maxlat minlon maxlon plon plat bwr as bs fig_names
    load(loads{drap},'pop_eddies')
    eval(['load ',fnames{drap},' stream_eddies'])
    eddies=stream_eddies;
    eval(['load ',fnames{drap+3},' stream_eddies'])
    meanders=stream_eddies;
    
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
    
    %%Now plot
    lat=min(pop_eddies.y):.25:max(pop_eddies.y);
    lon=min(pop_eddies.x):.25:max(pop_eddies.x);
    [lon,lat]=meshgrid(lon,lat);
    
    figure(1)
    clf
    pmap(lon,lat,nan(length(lat(:,1)),length(lon(1,:))),'gs')
    hold on
    uid=unique(pop_eddies.id);
    for m=1:length(uid)
        ii=find(pop_eddies.id==uid(m));
        m_plot(pop_eddies.x(ii),pop_eddies.y(ii),'color',[.5 .5 .5],'clipping','off')
        m_plot(pop_eddies.x(ii(1)),pop_eddies.y(ii(1)),'.','color',[.5 .5 .5],'markersize',5,'clipping','off')
    end
    uid=unique(eddies.id);
    for m=1:length(uid)
        ii=find(eddies.id==uid(m));
        m_plot(eddies.x(ii),eddies.y(ii),'k','linewidth',1,'clipping','off')
        m_plot(eddies.x(ii(1)),eddies.y(ii(1)),'k.','markersize',10,'clipping','off')
    end
    uid=unique(meanders.id);
    for m=1:length(uid)
        ii=find(meanders.id==uid(m));
        m_plot(meanders.x(ii),meanders.y(ii),'g','linewidth',1,'clipping','off')
        m_plot(meanders.x(ii(1)),meanders.y(ii(1)),'g.','markersize',10,'clipping','off')
    end
    
    
    m_plot(smoothn(lons,10),smoothn(lats,10),'k','linewidth',2);
    m_plot(smoothn(lons,10),smoothn(lats-bs,10),'k--','linewidth',1)
    m_plot(smoothn(lons,10),smoothn(lats+as,10),'k--','linewidth',1)
    m_text(291,51.1,[num2str(length(unique(eddies.id(eddies.cyc==1)))),' anticyclonic and ',num2str(length(unique(eddies.id(eddies.cyc==-1)))),' cyclonic eddies   '],'color','k')
    m_text(291,50.1,[num2str(length(unique(eddies.id(meanders.cyc==1)))),' anticyclonic and ',num2str(length(unique(eddies.id(meanders.cyc==-1)))),' cyclonic meanders   '],'color','g')
    eval(['print -dpng -r300 figs/',fig_names{drap}])
%     eval(['!open figs/',fig_names{drap} '.png'])
   
    
end
