clear all

load chelle.pal

figure(1);
ff=1;
set_pop
spath='~/matlab/pop/mat/run14_';
load([spath '1801'],'lat','lon')
load case_study_tracks 
jdays=min(track_jday):max(track_jday);
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
        caxis([-1.7 1])
        title(['BEC CHL, week ',num2str(jdays(m))])
        colormap(chelle)
        shading interp
        hold on

        m_contour(lon(r,c),lat(r,c),bp21_ssh(r,c),[7:7:100],'k')
        m_contour(lon(r,c),lat(r,c),bp21_ssh(r,c),[-100:7:-7],'k--')
        
        ii=find(track_jday==jdays(m));
        uid=unique(id(ii));
        for d=1:length(uid)
            ii=find(id==uid(d) & track_jday<=jdays(m));
            jj=find(id==uid(d) & track_jday==jdays(m));
            m_plot(x(jj),y(jj),'k.','markersize',5)
            m_plot(x(ii),y(ii),'k','linewidth',1)
            m_text(x(jj),y(jj)+.2,num2str(uid(d)))
        end
        shading flat
        grid
%         colorbar
        m_coast('patch','k');

        eval(['print -dpng -r300 frames/case_study_chl/frame_' num2str(ff) '.png'])
        ff=ff+1;
    end
end
%         close(aviobj);