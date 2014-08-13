clear all

load bwr.pal
load chelle.pal
load bwy.pal
figure(1);
ff=1;
max_lat=45;
min_lat=25;
max_lon=330;
min_lon=280;


load GS_rings_tracks_aviso_jan_5
load test_aviso_GS_mdt

AHEAD='/Users/new_gaube/data/eddy/V5/mat/AVISO_25_W_';
ajdays=unique(aviso_eddies.track_jday);



load([AHEAD num2str(ajdays(1))],'lat','lon')

lat_step=5;
lon_step=10;
[rr,cr]=imap(min_lat,max_lat,min_lon,max_lon,lat,lon);
dlat=lat(rr,cr);
dlon=lon(rr,cr);


m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);
m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick',[round(min_lat):lat_step:round(max_lat)],'tickdir','in','color','k','lineweight',1.5);
m_gshhs_f('save','gumby');


for m=1:200
    afname=[AHEAD num2str(ajdays(m))];
    if exist([afname,'.mat'])
        
        %load data
        load(afname,'ssh')
        
        figure(1)
        clf
        
        rect = get(gcf,'Position');
        rect(1:2) = [0 0];
        fr=gcf;
        
        subplot(211)
        m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);
        m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick',[round(min_lat):lat_step:round(max_lat)],'tickdir','in','color','k','lineweight',1.5);
        hold on
        m_pcolor(lon(rr,cr),lat(rr,cr),double(ssh(rr,cr)))
        caxis([-60 60])
        title(['AVISO SSH Tracked, week ',num2str(m)])
        colormap(chelle)
        shading interp
        hold on
        %             m_contour(lon(r,c),lat(r,c),ssh,[-100:5:100],'k')
        m_contour(lon(rr,cr),lat(rr,cr),ssh(rr,cr),[7:7:100],'k')
        m_contour(lon(rr,cr),lat(rr,cr),ssh(rr,cr),[-100:7:-7],'k--')
        ii=find(aviso_eddies.track_jday==ajdays(m));
        uid=unique(aviso_eddies.id(ii));
        for d=1:length(uid)
            ii=find(aviso_eddies.id==uid(d) & aviso_eddies.track_jday<=ajdays(m));
            jj=find(aviso_eddies.id==uid(d) & aviso_eddies.track_jday==ajdays(m));
            m_plot(aviso_eddies.x(jj),aviso_eddies.y(jj),'k.','markersize',12)
            m_plot(aviso_eddies.x(ii),aviso_eddies.y(ii),'k','linewidth',1)
            %                     m_text(aviso_eddies.x(jj),aviso_eddies.y(jj)+.2,num2str(uid(d)))
        end
        shading flat
%         colormap(bwr)
        grid
        m_usercoast('gumby','patch','k');

        subplot(212)
        m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);
        m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick',[round(min_lat):lat_step:round(max_lat)],'tickdir','in','color','k','lineweight',1.5);
        hold on
        m_pcolor(lon(rr,cr),lat(rr,cr),double(ssh(rr,cr)))
        caxis([-60 60])
        title(['AVISO MDT Tracked, week ',num2str(m)])
        colormap(chelle)
        shading interp
        hold on
        %             m_contour(lon(r,c),lat(r,c),ssh,[-100:5:100],'k')
        m_contour(lon(rr,cr),lat(rr,cr),ssh(rr,cr),[7:7:100],'k')
        m_contour(lon(rr,cr),lat(rr,cr),ssh(rr,cr),[-100:7:-7],'k--')
        ii=find(mdt_eddies.track_jday==ajdays(m));
        uid=unique(mdt_eddies.id(ii));
        for d=1:length(uid)
            ii=find(mdt_eddies.id==uid(d) & mdt_eddies.track_jday<=ajdays(m));
            jj=find(mdt_eddies.id==uid(d) & mdt_eddies.track_jday==ajdays(m));
            m_plot(mdt_eddies.x(jj),mdt_eddies.y(jj),'k.','markersize',12)
            m_plot(mdt_eddies.x(ii),mdt_eddies.y(ii),'k','linewidth',1)
            %                     m_text(aviso_eddies.x(jj),aviso_eddies.y(jj)+.2,num2str(uid(d)))
        end
        shading flat
%         colormap(bwr)
        grid
        m_usercoast('gumby','patch','k');
%         writeVideo(aviobj,getframe(fr,rect));

% 
        eval(['print -dpng -r300 frames/MDT_test/frame_' num2str(ff) '.png'])
        ff=ff+1;
    end
end
        close(aviobj);



