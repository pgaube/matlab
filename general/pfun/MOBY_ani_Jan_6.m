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


load GS_rings_tracks_run14_jan_5
load GS_rings_tracks_aviso_jan_5

PHEAD='~/matlab/pop/mat/run14_';
AHEAD='/Users/new_gaube/data/eddy/V5/mat/AVISO_25_W_';
pjdays=unique(pop_eddies.track_jday);
ajdays=unique(aviso_eddies.track_jday);


load([PHEAD num2str(pjdays(1))],'lat','lon')
plat=lat;
plon=lon;

load([AHEAD num2str(ajdays(1))],'lat','lon')

lat_step=5;
lon_step=10;
[rr,cr]=imap(min_lat,max_lat,min_lon,max_lon,lat,lon);
[r,c]=imap(min_lat,max_lat,min_lon,max_lon,plat,plon);
dlat=lat(rr,cr);
dlon=lon(rr,cr);


m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);
m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick',[round(min_lat):lat_step:round(max_lat)],'tickdir','in','color','k','lineweight',1.5);
m_gshhs_f('save','gumby');

        aviobj = VideoWriter('GS_rings_MOBY.avi');

        aviobj.FrameRate=12;
        aviobj.Quality=100;
        open(aviobj)

for m=1:200
    pfname=[PHEAD num2str(pjdays(m))];
    afname=[AHEAD num2str(ajdays(m))];
    if exist([pfname,'.mat'])
        
        %load data
        load(pfname,'hp21_ssh')
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
        title(['AVISO SSH, week ',num2str(m)])
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
        m_pcolor(plon(r,c),plat(r,c),double(hp21_ssh(r,c)))
        caxis([-60 60])
        title(['POP SSH, week ',num2str(m)])
        colormap(chelle)
        shading interp
        hold on
        %             m_contour(lon(r,c),lat(r,c),ssh,[-100:5:100],'k')
        m_contour(plon(r,c),plat(r,c),hp21_ssh(r,c),[7:7:100],'k')
        m_contour(plon(r,c),plat(r,c),hp21_ssh(r,c),[-100:7:-7],'k--')
        ii=find(pop_eddies.track_jday==pjdays(m));
        uid=unique(pop_eddies.id(ii));
        for d=1:length(uid)
            ii=find(pop_eddies.id==uid(d) & pop_eddies.track_jday<=pjdays(m));
            jj=find(pop_eddies.id==uid(d) & pop_eddies.track_jday==pjdays(m));
            m_plot(pop_eddies.x(jj),pop_eddies.y(jj),'k.','markersize',12)
            m_plot(pop_eddies.x(ii),pop_eddies.y(ii),'k','linewidth',1)
            %                     m_text(aviso_eddies.x(jj),aviso_eddies.y(jj)+.2,num2str(uid(d)))
        end
        shading flat
%         colormap(bwr)
        grid
        m_usercoast('gumby','patch','k');
        writeVideo(aviobj,getframe(fr,rect));

% 
%         eval(['print -dpng -r300 frames/GS_rings/frame_' num2str(ff) '.png'])
%         ff=ff+1;
    end
end
        close(aviobj);



