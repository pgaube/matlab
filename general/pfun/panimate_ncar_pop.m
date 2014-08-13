clear all
TYPE='hp66_chl'

load bwr.pal
load chelle.pal
load bwy.pal
figure(1);
ff=1;


switch TYPE
    case{'hp66_chl'}
        frame_dir='~/matlab/ncar_pop/frames/hp66_chl_sio/'
        eval(['mkdir ',frame_dir])
        load /Volumes/ys-scratch/mat/POP_BEC_1 flon flat jdays
        lon=tlon;lat=tlat;
        HEAD='/Volumes/ys-scratch/mat/POP_BEC_';
        
        lat_step=4;
        lon_step=8;
        
        minlat=-36;
        maxlat=-15;
        minlon=60;
        maxlon=120;
        
        [r,c]=imap(minlat,maxlat,minlon,maxlon,lat,lon);
        dlat=lat(r,c);
        dlon=lon(r,c);
        max_lat=max(dlat(:));
        min_lat=min(dlat(:));
        max_lon=max(dlon(:));
        min_lon=min(dlon(:));
        m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);
        m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick',[round(min_lat):lat_step:round(max_lat)],'tickdir','in','color','k','lineweight',1.5);
        m_gshhs_f('save','gumby');
        
        %         aviobj = VideoWriter('GS_rings_num.avi');
        %
        %         aviobj.FrameRate=10;
        %         aviobj.Quality=100;
        %         open(aviobj)
        
        for m=1:200
            fname=[HEAD num2str(jdays(m))]
            if exist([fname,'.mat'])
                
                %load data
                load(fname,'hp21_fssh','hp66_fchl')
                
                figure(1)
                clf
                
                rect = get(gcf,'Position');
                rect(1:2) = [0 0];
                fr=gcf;
                
                
                m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);
                m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick',[round(min_lat):lat_step:round(max_lat)],'tickdir','in','color','k','lineweight',1.5);
                hold on
                m_pcolor(lon(r,c),lat(r,c),double(hp66_chl(r,c)))
                caxis([-.02 .02])
                title(['NCAR-POP-BEC Filtered CHL, week ',num2str(jdays(m))])
                colormap(chelle)
                shading interp
                hold on
                %             m_contour(lon(r,c),lat(r,c),ssh,[-100:5:100],'k')
                m_contour(lon(r,c),lat(r,c),hp21_ssh(r,c),[3:3:100],'k')
                m_contour(lon(r,c),lat(r,c),hp21_ssh(r,c),[-100:3:-3],'k--')
%                 ii=find(track_jday==jdays(m));
%                 uid=unique(id(ii));
%                 for d=1:length(uid)
%                     ii=find(id==uid(d) & track_jday'<=jdays(m));
%                     jj=find(id==uid(d) & track_jday'==jdays(m));
%                     m_plot(x(jj),y(jj),'k.','markersize',8)
%                     m_plot(x(ii),y(ii),'k','linewidth',5)
%                     m_text(x(jj),y(jj)+.2,num2str(uid(d)))
%                 end
                shading flat
                colormap(chelle)
                grid
                m_usercoast('gumby','patch','k');
                %                 writeVideo(aviobj,getframe(fr,rect));
                
                eval(['print -dpng -r300 ',frame_dir, 'frame_' num2str(ff) '.png'])
                ff=ff+1;
            end
        end
end

