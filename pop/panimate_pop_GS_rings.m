clear all

load chelle.pal

figure(1);
ff=1;
set_pop
spath='~/matlab/pop/mat/run14_';
load([spath '1801'],'lat','lon')
load GS_rings_tracks_run14_jan_5 pop_eddies
jdays=min(pop_eddies.track_jday):max(pop_eddies.track_jday);
[r,c]=imap(25,50,200,330,lat,lon);
lat_step=4;
lon_step=5;
dlat=lat(r,c);
dlon=lon(r,c);
max_lat=max(dlat(:));
min_lat=min(dlat(:));
max_lon=max(dlon(:));
min_lon=min(dlon(:));



for m=1:length(jdays)
    fname=[spath num2str(jdays(m))]
    
    if exist([fname,'.mat'])
        
        %load data
        load(fname,'total_chl','bp21_ssh')
        
        figure(1)
        clf        
        pmap(lon(r,c),lat(r,c),double(real(log10(total_chl(r,c)))))
        caxis([-2 1.4])
        title(['BEC CHL, week ',num2str(jdays(m))])
        colormap(chelle)
        shading interp
        hold on

        m_contour(lon(r,c),lat(r,c),bp21_ssh(r,c),[7:7:100],'k')
        m_contour(lon(r,c),lat(r,c),bp21_ssh(r,c),[-100:7:-7],'k--')
        
        ii=find(pop_eddies.track_jday==jdays(m));
        uid=unique(pop_eddies.id(ii));
        for d=1:length(uid)
            ii=find(pop_eddies.id==uid(d) & pop_eddies.track_jday<=jdays(m));
            jj=find(pop_eddies.id==uid(d) & pop_eddies.track_jday==jdays(m));
            m_plot(pop_eddies.x(jj),pop_eddies.y(jj),'k.','markersize',5)
            m_plot(pop_eddies.x(ii),pop_eddies.y(ii),'k','linewidth',1)
            m_text(pop_eddies.x(jj),pop_eddies.y(jj)+.2,num2str(uid(d)))
        end
        shading flat
        grid
%         colorbar
        m_coast('patch','k');

        eval(['print -dpng -r300 frames/GS_rings_pop_chl/frame_' num2str(ff) '.png'])
        ff=ff+1;
    end
end
%         close(aviobj);