clear all
TYPE='GS_rings'

load bwr.pal
load chelle.pal
load bwy.pal
figure(1);
ff=1;
set_pop
spath='~/data/eddy/V5/mat/AVISO_25_W_';
startjd=2448924;
endjd=2454832;
jdays=[startjd:7:endjd];
load([spath '2454713'],'lat','lon')
load rings_cor_orgin_tracks_AVISO
[r,c]=imap(min(y)-5,max(y)+5,min(x)-5,max(x)+5,lat,lon);
lat_step=4;
lon_step=5;
dlat=lat(r,c);
dlon=lon(r,c);
max_lat=max(dlat(:));
min_lat=min(dlat(:));
max_lon=max(dlon(:));
min_lon=min(dlon(:));
m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);
m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick',[round(min_lat):lat_step:round(max_lat)],'tickdir','in','color','k','lineweight',1.5);
m_gshhs_f('save','gumby');



for m=1:length(jdays)
    fname=[spath num2str(jdays(m))];
    if exist([fname,'.mat'])
        
        %load data
        load(fname,'ssh')
        
        figure(1)
        clf
        
        rect = get(gcf,'Position');
        rect(1:2) = [0 0];
        fr=gcf;
        
        
        m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);
        m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick',[round(min_lat):lat_step:round(max_lat)],'tickdir','in','color','k','lineweight',1.5);
        hold on
        m_pcolor(lon(r,c),lat(r,c),double(ssh(r,c)))
        caxis([-60 60])
        title(['AVISO SSH, week ',num2str(jdays(m))])
        colormap(chelle)
        shading interp
        hold on
        %             m_contour(lon(r,c),lat(r,c),ssh,[-100:5:100],'k')
        m_contour(lon(r,c),lat(r,c),ssh(r,c),[7:7:100],'k')
        m_contour(lon(r,c),lat(r,c),ssh(r,c),[-100:7:-7],'k--')
        ii=find(track_jday==jdays(m));
        uid=unique(id(ii));
        for d=1:length(uid)
            ii=find(id==uid(d) & track_jday<=jdays(m));
            jj=find(id==uid(d) & track_jday==jdays(m));
            m_plot(x(jj),y(jj),'k.','markersize',8)
            m_plot(x(ii),y(ii),'k','linewidth',5)
            m_text(x(jj),y(jj)+.2,num2str(uid(d)))
        end
        shading flat
        colormap(bwr)
        grid
        m_usercoast('gumby','patch','k');
        colorbar
        
        eval(['print -dpng -r300 frames/GS_rings_AVISO/frame_' num2str(ff) '.png'])
        ff=ff+1;
    end
end
%         close(aviobj);