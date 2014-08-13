clear all
TYPE='gs_eddies_both_runs'

load bwr.pal
load chelle.pal
load zissou.pal
figure(1);
ff=1;


switch TYPE
    
    case{'gs_eddies_both_runs'}
        set_pop
        load ~/matlab/pop/mat/pop_model_domain r c lat lon
        load GS_rings_tracks_run14_sla pop_eddies
        run14_eddies=pop_eddies;
        load GS_rings_tracks_run33_sla pop_eddies
        run33_eddies=pop_eddies;
        
        [r,c]=imap(min(run14_eddies.y)-10,max(run14_eddies.y)+5,min(run14_eddies.x)-10,max(run14_eddies.x)+5,lat,lon);
        
        HEAD1='~/matlab/pop/mat/run14_';
        HEAD2='~/matlab/pop/mat/run33_';
        jdays=[1770:2100];
        lat_step=6;
        lon_step=10;
        dlat=lat(r,c);
        dlon=lon(r,c);
        max_lat=max(dlat(:));
        min_lat=min(dlat(:));
        max_lon=max(dlon(:));
        min_lon=min(dlon(:));
        %         m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);
        %         m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick',[round(min_lat):lat_step:round(max_lat)],'tickdir','in','color','k','lineweight',1.5);
        %         m_gshhs_f('save','gumby');
        
        
        for m=1:length(jdays)
            fname1=[HEAD1 num2str(jdays(m))];
            fname2=[HEAD2 num2str(jdays(m))];
            if exist([fname1,'.mat'])
                
                %load data
                load(fname1,'hp21_ssh')
                if exist('hp21_ssh')
                    run14_ssh=hp21_ssh;
                    clear hp21_ssh
                    load(fname2,'hp21_ssh')
                    if exist('hp21_ssh')
                        run33_ssh=hp21_ssh;
                        clear hp21_ssh
                        
                        figure(1)
                        clf
                        set(gcf,'InvertHardCopy', 'off','PaperPosition',[1 1 500 300],'PaperUnits','points')
                        
                        subplot(121)
                        %                 m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);
                        %                 m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick',[round(min_lat):lat_step:round(max_lat)],'tickdir','in','color','k','lineweight',1.5);
                        hold on
                        pmap(lon(r,c),lat(r,c),double(run14_ssh(r,c)))
                        caxis([-70 70])
                        hold on
                        %                 m_contour(lon(r,c),lat(r,c),run14_ssh(r,c),[5:10:150],'k')
                        %                 m_contour(lon(r,c),lat(r,c),run14_ssh(r,c),[-150:10:-5],'k--')
                                        ii=find(run14_eddies.track_jday==jdays(m));
                                        uid=unique(run14_eddies.id(ii));
                                        for d=1:length(uid)
                                            ii=find(run14_eddies.id==uid(d) & run14_eddies.track_jday<=jdays(m));
                                            jj=find(run14_eddies.id==uid(d) & run14_eddies.track_jday==jdays(m));
                                            m_plot(run14_eddies.x(jj),run14_eddies.y(jj),'k.','markersize',4)
                                            m_plot(run14_eddies.x(ii),run14_eddies.y(ii),'k','linewidth',1)
                                        end
                        shading flat
                        
                        grid
                        %                 m_usercoast('gumby','patch','k');
                        m_coast('patch',[0 0 0]);
                        subplot(122)
                        %                 m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);
                        %                 m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick',[round(min_lat):lat_step:round(max_lat)],'tickdir','in','color','k','lineweight',1.5);
                        hold on
                        pmap(lon(r,c),lat(r,c),double(run33_ssh(r,c)))
                        caxis([-70 70])
                        shading flat
                        colormap(zissou)
                        %                 hold on
                        %                 m_contour(lon(r,c),lat(r,c),run33_ssh(r,c),[5:10:150],'k')
                        %                 m_contour(lon(r,c),lat(r,c),run33_ssh(r,c),[-150:10:-5],'k--')
                                        ii=find(run33_eddies.track_jday==jdays(m));
                                        uid=unique(run33_eddies.id(ii));
                                        for d=1:length(uid)
                                            ii=find(run33_eddies.id==uid(d) & run33_eddies.track_jday<=jdays(m));
                                            jj=find(run33_eddies.id==uid(d) & run33_eddies.track_jday==jdays(m));
                                            m_plot(run33_eddies.x(jj),run33_eddies.y(jj),'k.','markersize',4)
                                            m_plot(run33_eddies.x(ii),run33_eddies.y(ii),'k','linewidth',1)
                                        end
                        grid
                        %                 m_usercoast('gumby','patch','k');
                        m_coast('patch',[0 0 0]);
                        %                 return
                        eval(['print -dpng -r300 frames/GS_rings3/frame_' num2str(ff) '.png'])
                        ff=ff+1;
                    end
                end
            end
        end
        %         close(aviobj);
        
        
        
    case{'rings'}
        set_pop
        dx=3
        mkdir ~/matlab/pop/frames/rings/
        load ~/matlab/pop/mat/pop_model_domain r c lat lon mask1
        mask=mask1;
        HEAD='~/matlab/pop/mat/run14_';
        jdays=[1740:1773 1801:1873 1901:1973 2001:2073 2101:2139];
        
        lat_step=5;
        lon_step=10;
        load mean_gs_path_obs_pop lons lats std_lats mean std
        minlat=30;
        maxlat=45;
        minlon=min(mean(:,1));
        maxlon=max(mean(:,1));
        
        [r,c]=imap(minlat,maxlat,minlon,maxlon,lat,lon);
        
        
        dlat=lat(r,c);
        dlon=lon(r,c);
        max_lat=max(dlat(:));
        min_lat=min(dlat(:));
        max_lon=max(dlon(:));
        min_lon=min(dlon(:));
        m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);
        m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick',[round(min_lat):lat_step:round(max_lat)],'tickdir','in','color','k','lineweight',1.5);
        %         m_gshhs_f('save','gumby');
        
        [xx,yy]=m_ll2xy(dlon,dlat);
        for m=1:length(jdays)
            fname=[HEAD num2str(jdays(m))];
            if exist([fname,'.mat'])
                
                %load data
                load(fname,'hp66_chl','bp21_ssh','z_crl','total_chl')
                clf
                m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);
                m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick',[round(min_lat):lat_step:round(max_lat)],'tickdir','in','color','k','lineweight',1.5);
                hold on
                m_pcolor(dlon,dlat,real(log10(total_chl(r,c))))
                shading flat
                colormap(chelle)
                grid
                m_usercoast('gumby','patch','k');
                
                [u,v]=geostro(dlon,dlat,bp21_ssh(r,c).*mask(r,c),.1);
                
                [verts averts] = streamslice(xx,yy,u,v,4);
                h=streamline([verts averts]);
                set(h, 'Color', 'k');
                caxis([-1.6 .1])
                eval(['print -dpng -r300 ~/matlab/pop/frames/rings/frame_' num2str(ff) '.png'])
                ff=ff+1;
            end
        end
        
        
    case{'one_ring'}
        set_pop
        dx=3
        mkdir ~/matlab/pop/frames/one_ring/
        load ~/matlab/pop/mat/pop_model_domain r c lat lon
        HEAD='~/matlab/pop/mat/run14_';
        jdays=[1740:1773 1801:1873 1901:1973 2001:2073 2101:2139];
        
        load GS_eddies_run14_sla
        good_id=stream_eddies.id(find(stream_eddies.k==max(stream_eddies.age(stream_eddies.cyc==-1))))
        ii=find(stream_eddies.id==good_id)
        
        jdays=stream_eddies.track_jday(ii);
        for m=1:length(jdays)
            fname=[HEAD num2str(jdays(m))];
            if exist([fname,'.mat'])
                
                %load data
                load(fname,'hp66_chl','bp21_ssh','z_crl','total_chl')
                
                [r,c]=imap(stream_eddies.y(ii(m))-dx,stream_eddies.y(ii(m))+dx,stream_eddies.x(ii(m))-dx,stream_eddies.x(ii(m))+dx,lat,lon);
                
                figure(1)
                clf
                crl=interp2(real(log10(total_chl(r,c))),3,'linear');
                pcolor(crl);shading flat;axis tight;colormap(chelle)
                %                 caxis([-.002 .002])
                hold on
                [u,v]=geostro(lon(r,c),lat(r,c),bp21_ssh(r,c),.1);
                u=interp2(u,3,'linear');
                v=interp2(v,3,'linear');
                [verts averts] = streamslice(u,v,1);
                h=streamline([verts averts]);
                set(h, 'Color', 'k');
                
                set(gca,'xcolor','w','ycolor','w','color','w')
                set(gcf,'color','w')
                
                eval(['print -dpng -r300 ~/matlab/pop/frames/one_ring/frame_' num2str(ff) '.png'])
                ff=ff+1;
            end
        end
        
        
        
    case{'ss66_chl'}
        set_pop
        mkdir ~/matlab/pop/frames/ss66_chl/
        load ~/matlab/pop/mat/pop_model_domain r c lat lon
        HEAD='~/matlab/pop/mat/run14_';
        jdays=[1740:1773 1801:1873 1901:1973 2001:2073 2101:2139];
        
        lat_step=5;
        lon_step=10;
        load mean_gs_path_obs_pop lons lats std_lats mean std
        
        minlat=30;
        maxlat=50;
        minlon=min(mean(:,1));
        maxlon=max(mean(:,1));
        
        [r,c]=imap(minlat,maxlat,minlon,maxlon,lat,lon);
        %         [r,c]=imap(min(lat(:)),max(lat(:)),min(lon(:)),max(lon(:)),lat,lon);
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
        
        for m=1:length(jdays)
            fname=[HEAD num2str(jdays(m))];
            if exist([fname,'.mat'])
                
                %load data
                load(fname,'ssh','ss66_chl')
                
                figure(1)
                clf
                
                rect = get(gcf,'Position');
                rect(1:2) = [0 0];
                fr=gcf;
                
                
                m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);
                m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick',[round(min_lat):lat_step:round(max_lat)],'tickdir','in','color','k','lineweight',1.5);
                hold on
                m_pcolor(lon(r,c),lat(r,c),double(ss66_chl(r,c)))
                caxis([-.1 .1])
                title(['ss66 CHL, week ',num2str(jdays(m))])
                colormap(chelle)
                shading interp
                hold on
                %             m_contour(lon(r,c),lat(r,c),ssh,[-100:5:100],'k')
                m_contour(lon(r,c),lat(r,c),ssh(r,c),[7:7:100],'k')
                m_contour(lon(r,c),lat(r,c),ssh(r,c),[-100:7:-7],'k--')
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
                
                eval(['print -dpng -r300 ~/matlab/pop/frames/ss66_chl/frame_' num2str(ff) '.png'])
                ff=ff+1;
            end
        end
        
        
    case{'GS_rings'}
        set_pop
        load ~/matlab/pop/mat/pop_model_domain r c lat lon
        %         load intense_cor_orgin_tracks
        load rings_cor_orgin_TS_tracks x y
        [r,c]=imap(min(y)-5,max(y)+5,min(x)-5,max(x)+5,lat,lon);
        load pop_run14_tracks x y track_jday id
        ii=find(x>=min(lon(1,c)) & x<=max(lon(1,c)) & y>=min(lat(r,1)) & y<=max(lat(r,1)));
        y=y(ii);
        x=x(ii);
        id=id(ii);
        track_jday=track_jday(ii);
        HEAD='~/matlab/pop/mat/run14_';
        jdays=[1770:2100];
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
        
        %         aviobj = VideoWriter('GS_rings_num.avi');
        %
        %         aviobj.FrameRate=10;
        %         aviobj.Quality=100;
        %         open(aviobj)
        
        for m=1:length(jdays)
            fname=[HEAD num2str(jdays(m))];
            if exist([fname,'.mat'])
                
                %load data
                load(fname,'hp21_ssh')
                
                figure(1)
                clf
                
                rect = get(gcf,'Position');
                rect(1:2) = [0 0];
                fr=gcf;
                
                
                m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);
                m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick',[round(min_lat):lat_step:round(max_lat)],'tickdir','in','color','k','lineweight',1.5);
                hold on
                m_pcolor(lon(r,c),lat(r,c),double(hp21_ssh(r,c)))
                caxis([-60 60])
                title(['SSH, week ',num2str(jdays(m))])
                colormap(chelle)
                shading interp
                hold on
                %             m_contour(lon(r,c),lat(r,c),ssh,[-100:5:100],'k')
                m_contour(lon(r,c),lat(r,c),hp21_ssh(r,c),[7:7:100],'k')
                m_contour(lon(r,c),lat(r,c),hp21_ssh(r,c),[-100:7:-7],'k--')
                ii=find(track_jday==jdays(m));
                uid=unique(id(ii));
                for d=1:length(uid)
                    ii=find(id==uid(d) & track_jday'<=jdays(m));
                    jj=find(id==uid(d) & track_jday'==jdays(m));
                    m_plot(x(jj),y(jj),'k.','markersize',4)
                    m_plot(x(ii),y(ii),'k','linewidth',1)
                    m_text(x(jj),y(jj)+.2,num2str(uid(d)))
                end
                shading flat
                colormap(bwr)
                grid
                m_usercoast('gumby','patch','k');
                colorbar
                
                eval(['print -dpng -r300 frames/GS_rings/frame_' num2str(ff) '.png'])
                ff=ff+1;
            end
        end
        %         close(aviobj);
        
        
    case{'GS_rings_diat_SS'}
        set_pop
        mkdir ~/matlab/pop/frames/GS_rings_diat_SS/
        load ~/matlab/pop/mat/pop_model_domain r c lat lon
        %         load intense_cor_orgin_tracks
        load intense_cor_orgin_TS_tracks
        [r,c]=imap(min(y)-5,max(y)+5,min(x)-5,max(x)+5,lat,lon);
        HEAD='/private/d1/larrya/0pt1_run14/t.14.';
        MHEAD='~/matlab/pop/mat/run14_';
        % [small_bio_a,small_bio_m,small_bio_c,small_bio_t]= pop_comps(x,y,cyc,k,id,track_jday,adens,'ss_spc_vint104','/private/d1/larrya/0pt1_run14/t.14.',1,0);
        
        jdays=[1800:2100];
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
        
        %         aviobj = VideoWriter('GS_rings_num.avi');
        %
        %         aviobj.FrameRate=10;
        %         aviobj.Quality=100;
        %         open(aviobj)
        
        for m=1:length(jdays)
            fname=[HEAD num2str(jdays(m)) '.ss_diatc_vint104'];
            mname=[MHEAD num2str(jdays(m))];
            if exist(fname)
                
                %load data
                load(mname,'ssh')
                data=read_pop(HEAD,num2str(jdays(m)),'ss_diatc_vint104',1);
                
                figure(1)
                clf
                
                rect = get(gcf,'Position');
                rect(1:2) = [0 0];
                fr=gcf;
                
                
                m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);
                m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick',[round(min_lat):lat_step:round(max_lat)],'tickdir','in','color','k','lineweight',1.5);
                hold on
                m_pcolor(lon(r,c),lat(r,c),double(data(r,c)))
                caxis([-1e-3 1e-3])
                title(['DIAT SS, week ',num2str(jdays(m))])
                colormap(chelle)
                shading interp
                hold on
                
                %             m_contour(lon(r,c),lat(r,c),ssh,[-100:5:100],'k')
                m_contour(lon(r,c),lat(r,c),ssh(r,c),[7:7:100],'k')
                m_contour(lon(r,c),lat(r,c),ssh(r,c),[-100:7:-7],'k--')
                ii=find(track_jday==jdays(m));
                uid=unique(id(ii));
                for d=1:length(uid)
                    ii=find(id==uid(d) & track_jday'<=jdays(m));
                    jj=find(id==uid(d) & track_jday'==jdays(m));
                    m_plot(x(jj),y(jj),'k.','markersize',8)
                    m_plot(x(ii),y(ii),'k','linewidth',5)
                    m_text(x(jj),y(jj)+.2,num2str(uid(d)))
                end
                shading flat
                colormap(chelle)
                grid
                m_usercoast('gumby','patch','k');
                %                 writeVideo(aviobj,getframe(fr,rect));
                
                eval(['print -dpng -r300 ~/matlab/pop/frames/GS_rings_diat_SS/frame_' num2str(ff) '.png'])
                ff=ff+1;
            end
        end
        
    case{'GS_rings_diaz_SS'}
        set_pop
        mkdir ~/matlab/pop/frames/GS_rings_diaz_SS/
        load ~/matlab/pop/mat/pop_model_domain r c lat lon
        %         load intense_cor_orgin_tracks
        load intense_cor_orgin_TS_tracks
        [r,c]=imap(min(y)-5,max(y)+5,min(x)-5,max(x)+5,lat,lon);
        HEAD='/private/d1/larrya/0pt1_run14/t.14.';
        MHEAD='~/matlab/pop/mat/run14_';
        % [small_bio_a,small_bio_m,small_bio_c,small_bio_t]= pop_comps(x,y,cyc,k,id,track_jday,adens,'ss_spc_vint104','/private/d1/larrya/0pt1_run14/t.14.',1,0);
        
        jdays=[1800:2100];
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
        
        %         aviobj = VideoWriter('GS_rings_num.avi');
        %
        %         aviobj.FrameRate=10;
        %         aviobj.Quality=100;
        %         open(aviobj)
        
        for m=1:length(jdays)
            fname=[HEAD num2str(jdays(m)) '.ss_diazc_vint104'];
            mname=[MHEAD num2str(jdays(m))];
            if exist(fname)
                
                %load data
                load(mname,'ssh')
                data=read_pop(HEAD,num2str(jdays(m)),'ss_diazc_vint104',1);
                
                figure(1)
                clf
                
                rect = get(gcf,'Position');
                rect(1:2) = [0 0];
                fr=gcf;
                
                
                m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);
                m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick',[round(min_lat):lat_step:round(max_lat)],'tickdir','in','color','k','lineweight',1.5);
                hold on
                m_pcolor(lon(r,c),lat(r,c),double(data(r,c)))
                caxis([-1e-6 1e-6])
                title(['DIAZ SS, week ',num2str(jdays(m))])
                colormap(chelle)
                shading interp
                hold on
                
                %             m_contour(lon(r,c),lat(r,c),ssh,[-100:5:100],'k')
                m_contour(lon(r,c),lat(r,c),ssh(r,c),[7:7:100],'k')
                m_contour(lon(r,c),lat(r,c),ssh(r,c),[-100:7:-7],'k--')
                ii=find(track_jday==jdays(m));
                uid=unique(id(ii));
                for d=1:length(uid)
                    ii=find(id==uid(d) & track_jday'<=jdays(m));
                    jj=find(id==uid(d) & track_jday'==jdays(m));
                    m_plot(x(jj),y(jj),'k.','markersize',8)
                    m_plot(x(ii),y(ii),'k','linewidth',5)
                    m_text(x(jj),y(jj)+.2,num2str(uid(d)))
                end
                shading flat
                colormap(chelle)
                grid
                m_usercoast('gumby','patch','k');
                %                 writeVideo(aviobj,getframe(fr,rect));
                
                eval(['print -dpng -r300 ~/matlab/pop/frames/GS_rings_diaz_SS/frame_' num2str(ff) '.png'])
                ff=ff+1;
            end
        end
        %         close(aviobj);
    case{'GS_rings_sp_SS'}
        set_pop
        mkdir ~/matlab/pop/frames/GS_rings_sp_SS/
        load ~/matlab/pop/mat/pop_model_domain r c lat lon
        %         load intense_cor_orgin_tracks
        load intense_cor_orgin_TS_tracks
        [r,c]=imap(min(y)-5,max(y)+5,min(x)-5,max(x)+5,lat,lon);
        HEAD='/private/d1/larrya/0pt1_run14/t.14.';
        MHEAD='~/matlab/pop/mat/run14_';
        % [small_bio_a,small_bio_m,small_bio_c,small_bio_t]= pop_comps(x,y,cyc,k,id,track_jday,adens,'ss_spc_vint104','/private/d1/larrya/0pt1_run14/t.14.',1,0);
        
        jdays=[1800:2100];
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
        
        %         aviobj = VideoWriter('GS_rings_num.avi');
        %
        %         aviobj.FrameRate=10;
        %         aviobj.Quality=100;
        %         open(aviobj)
        
        for m=1:length(jdays)
            fname=[HEAD num2str(jdays(m)) '.ss_spc_vint104'];
            mname=[MHEAD num2str(jdays(m))];
            if exist(fname)
                
                %load data
                load(mname,'ssh')
                data=read_pop(HEAD,num2str(jdays(m)),'ss_spc_vint104',1);
                
                figure(1)
                clf
                
                rect = get(gcf,'Position');
                rect(1:2) = [0 0];
                fr=gcf;
                
                
                m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);
                m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick',[round(min_lat):lat_step:round(max_lat)],'tickdir','in','color','k','lineweight',1.5);
                hold on
                m_pcolor(lon(r,c),lat(r,c),double(data(r,c)))
                caxis([-2e-4 2e-4])
                title(['Small SS, week ',num2str(jdays(m))])
                colormap(chelle)
                shading interp
                hold on
                
                %             m_contour(lon(r,c),lat(r,c),ssh,[-100:5:100],'k')
                m_contour(lon(r,c),lat(r,c),ssh(r,c),[7:7:100],'k')
                m_contour(lon(r,c),lat(r,c),ssh(r,c),[-100:7:-7],'k--')
                ii=find(track_jday==jdays(m));
                uid=unique(id(ii));
                for d=1:length(uid)
                    ii=find(id==uid(d) & track_jday'<=jdays(m));
                    jj=find(id==uid(d) & track_jday'==jdays(m));
                    m_plot(x(jj),y(jj),'k.','markersize',8)
                    m_plot(x(ii),y(ii),'k','linewidth',5)
                    m_text(x(jj),y(jj)+.2,num2str(uid(d)))
                end
                shading flat
                colormap(chelle)
                grid
                m_usercoast('gumby','patch','k');
                %                 writeVideo(aviobj,getframe(fr,rect));
                
                eval(['print -dpng -r300 ~/matlab/pop/frames/GS_rings_sp_SS/frame_' num2str(ff) '.png'])
                ff=ff+1;
            end
        end
        %         close(aviobj);
        
    case{'GS_rings_chl'}
        set_pop
        mkdir ~/matlab/pop/frames/GS_rings_chl/
        load ~/matlab/pop/mat/pop_model_domain r c lat lon
        %         load intense_cor_orgin_tracks
        load intense_cor_orgin_TS_tracks
        [r,c]=imap(min(y)-5,max(y)+5,min(x)-5,max(x)+5,lat,lon);
        HEAD='~/matlab/pop/mat/run14_';
        jdays=[1800:2100];
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
        
        %         aviobj = VideoWriter('GS_rings_num.avi');
        %
        %         aviobj.FrameRate=10;
        %         aviobj.Quality=100;
        %         open(aviobj)
        
        for m=1:length(jdays)
            fname=[HEAD num2str(jdays(m))];
            if exist([fname,'.mat'])
                
                %load data
                load(fname,'ssh','hp66_chl')
                
                figure(1)
                clf
                
                rect = get(gcf,'Position');
                rect(1:2) = [0 0];
                fr=gcf;
                
                
                m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);
                m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick',[round(min_lat):lat_step:round(max_lat)],'tickdir','in','color','k','lineweight',1.5);
                hold on
                m_pcolor(lon(r,c),lat(r,c),double(hp66_chl(r,c)))
                caxis([-.1 .1])
                title(['SSH, week ',num2str(jdays(m))])
                colormap(chelle)
                shading interp
                hold on
                %             m_contour(lon(r,c),lat(r,c),ssh,[-100:5:100],'k')
                m_contour(lon(r,c),lat(r,c),ssh(r,c),[7:7:100],'k')
                m_contour(lon(r,c),lat(r,c),ssh(r,c),[-100:7:-7],'k--')
                ii=find(track_jday==jdays(m));
                uid=unique(id(ii));
                for d=1:length(uid)
                    ii=find(id==uid(d) & track_jday'<=jdays(m));
                    jj=find(id==uid(d) & track_jday'==jdays(m));
                    m_plot(x(jj),y(jj),'k.','markersize',8)
                    m_plot(x(ii),y(ii),'k','linewidth',5)
                    m_text(x(jj),y(jj)+.2,num2str(uid(d)))
                end
                shading flat
                colormap(chelle)
                grid
                m_usercoast('gumby','patch','k');
                %                 writeVideo(aviobj,getframe(fr,rect));
                
                eval(['print -dpng -r300 frames/GS_rings_chl/frame_' num2str(ff) '.png'])
                ff=ff+1;
            end
        end
        %         close(aviobj);
        
    case{'GS_rings'}
        set_pop
        load ~/matlab/pop/mat/pop_model_domain r c lat lon
        %         load intense_cor_orgin_tracks
        load intense_cor_orgin_TS_tracks
        [r,c]=imap(min(y)-5,max(y)+5,min(x)-5,max(x)+5,lat,lon);
        HEAD='~/matlab/pop/mat/run14_';
        jdays=[1700:2100];
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
        
        %         aviobj = VideoWriter('GS_rings_num.avi');
        %
        %         aviobj.FrameRate=10;
        %         aviobj.Quality=100;
        %         open(aviobj)
        
        for m=1:length(jdays)
            fname=[HEAD num2str(jdays(m))];
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
                title(['SSH, week ',num2str(jdays(m))])
                colormap(chelle)
                shading interp
                hold on
                %             m_contour(lon(r,c),lat(r,c),ssh,[-100:5:100],'k')
                m_contour(lon(r,c),lat(r,c),ssh(r,c),[7:7:100],'k')
                m_contour(lon(r,c),lat(r,c),ssh(r,c),[-100:7:-7],'k--')
                ii=find(track_jday==jdays(m));
                uid=unique(id(ii));
                for d=1:length(uid)
                    ii=find(id==uid(d) & track_jday'<=jdays(m));
                    jj=find(id==uid(d) & track_jday'==jdays(m));
                    m_plot(x(jj),y(jj),'k.','markersize',8)
                    m_plot(x(ii),y(ii),'k','linewidth',5)
                    m_text(x(jj),y(jj)+.2,num2str(uid(d)))
                end
                shading flat
                colormap(chelle)
                grid
                m_usercoast('gumby','patch','k');
                %                 writeVideo(aviobj,getframe(fr,rect));
                
                eval(['print -dpng -r300 frames/GS_rings/frame_' num2str(ff) '.png'])
                ff=ff+1;
            end
        end
        %         close(aviobj);
    case{'ssh'}
        load ~/matlab/pop/mat/pop_model_domain r c lat lon
        load intense_tracks
        HEAD='~/matlab/pop/mat/run14_';
        jdays=[1740:2139];
        set_pop
        [r,c]=imap(intense_domain(1),intense_domain(2),intense_domain(3),intense_domain(4),lat,lon);
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
        
        %         aviobj = VideoWriter('run14_3phyto_intense_domain.avi');
        %
        %         aviobj.FrameRate=10;
        %         aviobj.Quality=100;
        %         open(aviobj)
        
        for m=1:length(jdays)
            fname=[HEAD num2str(jdays(m))];
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
                caxis([-50 50])
                title(['SSH, week ',num2str(jdays(m))])
                colormap(chelle)
                shading interp
                hold on
                %             m_contour(lon(r,c),lat(r,c),ssh,[-100:5:100],'k')
                m_contour(lon(r,c),lat(r,c),ssh(r,c),[3:5:100],'k')
                m_contour(lon(r,c),lat(r,c),ssh(r,c),[-100:5:-3],'k--')
                ii=find(track_jday==jdays(m));
                uid=unique(id(ii));
                for d=1:length(uid)
                    ii=find(id==uid(d) & track_jday'<=jdays(m));
                    jj=find(id==uid(d) & track_jday'==jdays(m));
                    m_plot(x(jj),y(jj),'k.','markersize',8)
                    m_plot(x(ii),y(ii),'k','linewidth',1)
                end
                shading flat
                colormap(chelle)
                grid
                m_usercoast('gumby','patch','k');
                
                eval(['print -dpng -r300 frames/GS_ssh/frame_' num2str(ff) '.png'])
                ff=ff+1;
            end
        end
        %         close(aviobj);
        
    case {'3phyo_anoms2'}
        
        load ~/matlab/pop/mat/pop_model_domain r c lat lon
        load intense_tracks
        HEAD='~/matlab/pop/mat/run14_';
        jdays=[1740:2139];
        [r,c]=imap(32,40,300,315,lat,lon);
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
        
        %         aviobj = VideoWriter('run14_3phyto_intense_domain.avi');
        %
        %         aviobj.FrameRate=10;
        %         aviobj.Quality=100;
        %         open(aviobj)
        
        for m=1:length(jdays)
            fname=[HEAD num2str(jdays(m))];
            if exist([fname,'.mat'])
                
                %load data
                ssh1=read_pop('/private/d1/larrya/0pt1_run14/t.14.',num2str(jdays(m)),'ssh',1);
                sm_ssh=read_pop('/private/d1/larrya/0pt1_run14/t.14.',num2str(jdays(m)),'ssh_sm',1);
                ssh=ssh1-sm_ssh;
                ssh=ssh(r,c);
                %                ssh=ssh1(r,c);
                
                load(fname,'hp66_small_biomass','hp66_diat_biomass','hp66_diaz_biomass');
                
                figure(1)
                clf
                
                rect = get(gcf,'Position');
                rect(1:2) = [0 0];
                fr=gcf;
                
                subplot(311)
                m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);
                m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick',[round(min_lat):lat_step:round(max_lat)],'tickdir','in','color','k','lineweight',1.5);
                hold on
                m_pcolor(lon(r,c),lat(r,c),double(hp66_diat_biomass(r,c)))
                caxis([-10 10])
                colorbar
                title(['Diatom biomass anom, week ',num2str(jdays(m))])
                colormap(chelle)
                shading interp
                hold on
                %             m_contour(lon(r,c),lat(r,c),ssh,[-100:5:100],'k')
                m_contour(lon(r,c),lat(r,c),ssh,[3:5:100],'k')
                m_contour(lon(r,c),lat(r,c),ssh,[-100:5:-3],'k--')
                ii=find(track_jday==jdays(m));
                uid=unique(id(ii));
                for d=1:length(uid)
                    ii=find(id==uid(d) & track_jday'<=jdays(m));
                    jj=find(id==uid(d) & track_jday'==jdays(m));
                    m_plot(x(jj),y(jj),'k.','markersize',8)
                    m_plot(x(ii),y(ii),'k','linewidth',1)
                end
                shading flat
                colormap(chelle)
                grid
                m_usercoast('gumby','patch','k');
                
                subplot(312)
                m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);
                m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick',[round(min_lat):lat_step:round(max_lat)],'tickdir','in','color','k','lineweight',1.5);
                hold on
                m_pcolor(lon(r,c),lat(r,c),double(hp66_small_biomass(r,c)))
                caxis([-10 10])
                colorbar
                title(['Small Phyto biomass anom, week ',num2str(jdays(m))])
                colormap(chelle)
                shading interp
                hold on
                %             m_contour(lon(r,c),lat(r,c),ssh,[-100:5:100],'k')
                m_contour(lon(r,c),lat(r,c),ssh,[3:5:100],'k')
                m_contour(lon(r,c),lat(r,c),ssh,[-100:5:-3],'k--')
                ii=find(track_jday==jdays(m));
                uid=unique(id(ii));
                for d=1:length(uid)
                    ii=find(id==uid(d) & track_jday'<=jdays(m));
                    jj=find(id==uid(d) & track_jday'==jdays(m));
                    m_plot(x(jj),y(jj),'k.','markersize',8)
                    m_plot(x(ii),y(ii),'k','linewidth',1)
                end
                shading flat
                colormap(chelle)
                grid
                m_usercoast('gumby','patch','k');
                
                subplot(313)
                m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);
                m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick',[round(min_lat):lat_step:round(max_lat)],'tickdir','in','color','k','lineweight',1.5);
                hold on
                m_pcolor(lon(r,c),lat(r,c),double(hp66_diaz_biomass(r,c)))
                caxis([-.3 .3])
                colorbar
                title(['Diazotroph biomass anom, week ',num2str(jdays(m))])
                colormap(chelle)
                shading interp
                hold on
                %             m_contour(lon(r,c),lat(r,c),ssh,[-100:5:100],'k')
                m_contour(lon(r,c),lat(r,c),ssh,[3:5:100],'k')
                m_contour(lon(r,c),lat(r,c),ssh,[-100:5:-3],'k--')
                ii=find(track_jday==jdays(m));
                uid=unique(id(ii));
                for d=1:length(uid)
                    ii=find(id==uid(d) & track_jday'<=jdays(m));
                    jj=find(id==uid(d) & track_jday'==jdays(m));
                    m_plot(x(jj),y(jj),'k.','markersize',8)
                    m_plot(x(ii),y(ii),'k','linewidth',1)
                end
                shading flat
                colormap(chelle)
                grid
                m_usercoast('gumby','patch','k');
                
                
                %             writeVideo(aviobj,getframe(fr,rect));
                eval(['print -dpng -r300 frames/3phyto_anom2/frame_' num2str(ff) '.png'])
                ff=ff+1;
            end
        end
        close(aviobj);
        
        
        
    case {'3phyo_anoms'}
        
        load ~/matlab/pop/mat/pop_model_domain r c lat lon
        load intense_tracks
        jdays=[1740:2139];
        [r,c]=imap(32,40,300,315,lat,lon);
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
        
        %         aviobj = VideoWriter('run14_3phyto_intense_domain.avi');
        %
        %         aviobj.FrameRate=10;
        %         aviobj.Quality=100;
        %         open(aviobj)
        
        for m=1:length(jdays)
            if exist(['/private/d1/larrya/0pt1_run14/t.14.',num2str(jdays(m)),'.ssh'])
                %load data
                ssh1=read_pop('/private/d1/larrya/0pt1_run14/t.14.',num2str(jdays(m)),'ssh',1);
                sm_ssh=read_pop('/private/d1/larrya/0pt1_run14/t.14.',num2str(jdays(m)),'ssh_sm',1);
                ssh=ssh1-sm_ssh;
                ssh=ssh(r,c);
                %             ssh=ssh1(r,c);
                
                small=read_pop('/private/d1/larrya/0pt1_run14/t.14.',num2str(jdays(m)),'spc_vint104',1);
                %             sm_small=read_pop('/private/d1/larrya/0pt1_run14/t.14.',num2str(jdays(m)),'spc_vint104sm',1);
                sm_small=smoothn(small,11000);
                hp_small=small(r,c)-sm_small(r,c);
                diat=read_pop('/private/d1/larrya/0pt1_run14/t.14.',num2str(jdays(m)),'diatc_vint104',1);
                sm_diat=read_pop('/private/d1/larrya/0pt1_run14/t.14.',num2str(jdays(m)),'diatc_vint104sm',1);
                hp_diat=small(r,c)-sm_small(r,c);
                diaz=read_pop('/private/d1/larrya/0pt1_run14/t.14.',num2str(jdays(m)),'diazc_vint104',1);
                sm_diaz=read_pop('/private/d1/larrya/0pt1_run14/t.14.',num2str(jdays(m)),'diazc_vint104sm',1);
                hp_diaz=small(r,c)-sm_small(r,c);
                
                
                figure(1)
                clf
                
                rect = get(gcf,'Position');
                rect(1:2) = [0 0];
                fr=gcf;
                
                subplot(311)
                m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);
                m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick',[round(min_lat):lat_step:round(max_lat)],'tickdir','in','color','k','lineweight',1.5);
                hold on
                m_pcolor(lon(r,c),lat(r,c),hp_diat)
                caxis([-25 25])
                colorbar
                title(['Diatom biomass anom, week ',num2str(jdays(m))])
                colormap(chelle)
                shading interp
                hold on
                %             m_contour(lon(r,c),lat(r,c),ssh,[-100:5:100],'k')
                m_contour(lon(r,c),lat(r,c),ssh,[3:5:100],'k')
                m_contour(lon(r,c),lat(r,c),ssh,[-100:5:-3],'k--')
                ii=find(track_jday==jdays(m));
                uid=unique(id(ii));
                for d=1:length(uid)
                    ii=find(id==uid(d) & track_jday'<=jdays(m));
                    jj=find(id==uid(d) & track_jday'==jdays(m));
                    m_plot(x(jj),y(jj),'k.','markersize',8)
                    m_plot(x(ii),y(ii),'k','linewidth',1)
                end
                shading flat
                colormap(chelle)
                grid
                m_usercoast('gumby','patch','k');
                
                subplot(312)
                m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);
                m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick',[round(min_lat):lat_step:round(max_lat)],'tickdir','in','color','k','lineweight',1.5);
                hold on
                m_pcolor(lon(r,c),lat(r,c),hp_small)
                caxis([-15 15])
                colorbar
                title(['Small Phyto biomass anom, week ',num2str(jdays(m))])
                colormap(chelle)
                shading interp
                hold on
                %             m_contour(lon(r,c),lat(r,c),ssh,[-100:5:100],'k')
                m_contour(lon(r,c),lat(r,c),ssh,[3:5:100],'k')
                m_contour(lon(r,c),lat(r,c),ssh,[-100:5:-3],'k--')
                ii=find(track_jday==jdays(m));
                uid=unique(id(ii));
                for d=1:length(uid)
                    ii=find(id==uid(d) & track_jday'<=jdays(m));
                    jj=find(id==uid(d) & track_jday'==jdays(m));
                    m_plot(x(jj),y(jj),'k.','markersize',8)
                    m_plot(x(ii),y(ii),'k','linewidth',1)
                end
                shading flat
                colormap(chelle)
                grid
                m_usercoast('gumby','patch','k');
                
                subplot(313)
                m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);
                m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick',[round(min_lat):lat_step:round(max_lat)],'tickdir','in','color','k','lineweight',1.5);
                hold on
                m_pcolor(lon(r,c),lat(r,c),hp_diaz)
                caxis([-15 15])
                colorbar
                title(['Diazotroph biomass anom, week ',num2str(jdays(m))])
                colormap(chelle)
                shading interp
                hold on
                %             m_contour(lon(r,c),lat(r,c),ssh,[-100:5:100],'k')
                m_contour(lon(r,c),lat(r,c),ssh,[3:5:100],'k')
                m_contour(lon(r,c),lat(r,c),ssh,[-100:5:-3],'k--')
                ii=find(track_jday==jdays(m));
                uid=unique(id(ii));
                for d=1:length(uid)
                    ii=find(id==uid(d) & track_jday'<=jdays(m));
                    jj=find(id==uid(d) & track_jday'==jdays(m));
                    m_plot(x(jj),y(jj),'k.','markersize',8)
                    m_plot(x(ii),y(ii),'k','linewidth',1)
                end
                shading flat
                colormap(chelle)
                grid
                m_usercoast('gumby','patch','k');
                
                
                %             writeVideo(aviobj,getframe(fr,rect));
                eval(['print -dpng -r300 frames/3phyto_anom/frame_' num2str(ff) '.png'])
                ff=ff+1;
            end
        end
        close(aviobj);
        
    case {'hpchl_eddies'}
        
        load ~/matlab/pop/mat/pop_model_domain r c lat lon
        load pop_run14_tracks.mat
        jdays=[1740:2139];
        [r,c]=imap(35,38,304,310,lat,lon);
        lat_step=1;
        lon_step=2;
        dlat=lat(r,c);
        dlon=lon(r,c);
        max_lat=max(dlat(:));
        min_lat=min(dlat(:));
        max_lon=max(dlon(:));
        min_lon=min(dlon(:));
        m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);
        m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick',[round(min_lat):lat_step:round(max_lat)],'tickdir','in','color','k','lineweight',1.5);
        m_gshhs_f('save','gumby');
        
        aviobj = VideoWriter('run14_hpchl_intense_domain.avi');
        
        aviobj.FrameRate=10;
        aviobj.Quality=100;
        open(aviobj)
        
        for m=1:length(jdays)
            if exist(['/private/d1/larrya/0pt1_run14/t.14.',num2str(jdays(m)),'.ssh'])
                %load data
                ssh1=read_pop('/private/d1/larrya/0pt1_run14/t.14.',num2str(jdays(m)),'ssh',1);
                sm_ssh=read_pop('/private/d1/larrya/0pt1_run14/t.14.',num2str(jdays(m)),'ssh_sm',1);
                ssh=ssh1-sm_ssh;
                ssh=ssh(r,c);
                
                c1=read_pop('/private/d1/larrya/0pt1_run14/t.14.',num2str(jdays(m)),'spchl_1',1);
                c2=read_pop('/private/d1/larrya/0pt1_run14/t.14.',num2str(jdays(m)),'diatchl_1',1);
                c3=read_pop('/private/d1/larrya/0pt1_run14/t.14.',num2str(jdays(m)),'diazchl_1',1);
                chl=c1+c1+c3;
                chl=chl(r,c);
                sm_chl=smoothn(chl,11000);
                hp=chl-sm_chl;
                
                figure(1)
                clf
                
                rect = get(gcf,'Position');
                rect(1:2) = [0 0];
                fr=gcf;
                
                m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);
                m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick',[round(min_lat):lat_step:round(max_lat)],'tickdir','in','color','k','lineweight',1.5);
                hold on
                m_pcolor(lon(r,c),lat(r,c),hp)
                caxis([-.02 .02])
                colorbar
                title(['high-pass filtere (CHL) Run 14, week ',num2str(jdays(m))])
                colormap(chelle)
                shading interp
                hold on
                m_contour(lon(r,c),lat(r,c),ssh,[1:2:100],'k')
                m_contour(lon(r,c),lat(r,c),ssh,[-100:2:-1],'k--')
                ii=find(track_jday==jdays(m));
                uid=unique(id(ii));
                for d=1:length(uid)
                    ii=find(id==uid(d) & track_jday'<=jdays(m));
                    jj=find(id==uid(d) & track_jday'==jdays(m));
                    m_plot(x(jj),y(jj),'k.','markersize',8)
                    m_plot(x(ii),y(ii),'k','linewidth',1)
                end
                shading flat
                colormap(chelle)
                grid
                m_usercoast('gumby','patch','k');
                
                
                writeVideo(aviobj,getframe(fr,rect));
                eval(['print -dpng -r300 frames/hp66_chl/frame_' num2str(ff) '.png'])
                ff=ff+1;
            end
        end
        close(aviobj);
        
    case {'chl_eddies'}
        
        load ~/matlab/pop/mat/pop_model_domain r c lat lon
        load pop_run33_tracks.mat
        jdays=[1740:2139];
        [r,c]=imap(25,40,295,340,lat,lon);
        lat_step=4;
        lon_step=6;
        dlat=lat(r,c);
        dlon=lon(r,c);
        max_lat=max(dlat(:));
        min_lat=min(dlat(:));
        max_lon=max(dlon(:));
        min_lon=min(dlon(:));
        m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);
        m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick',[round(min_lat):lat_step:round(max_lat)],'tickdir','in','color','k','lineweight',1.5);
        m_gshhs_f('save','gumby');
        
        aviobj = VideoWriter('run33_chl_center.avi');
        
        aviobj.FrameRate=10;
        aviobj.Quality=100;
        open(aviobj)
        
        for m=1:length(jdays)
            if exist(['/private/d1/larrya/0pt1_run14/t.14.',num2str(jdays(m)),'.ssh'])
                %load data
                ssh1=read_pop('/private/d1/larrya/0pt1_run14/t.14.',num2str(jdays(m)),'ssh',1);
                sm_ssh=read_pop('/private/d1/larrya/0pt1_run14/t.14.',num2str(jdays(m)),'ssh_sm',1);
                ssh=ssh1-sm_ssh;
                ssh=ssh(r,c);
                
                c1=read_pop('/private/d1/larrya/0pt1_run14/t.14.',num2str(jdays(m)),'spchl_1',1);
                c2=read_pop('/private/d1/larrya/0pt1_run14/t.14.',num2str(jdays(m)),'diatchl_1',1);
                c3=read_pop('/private/d1/larrya/0pt1_run14/t.14.',num2str(jdays(m)),'diazchl_1',1);
                chl=c1+c1+c3;
                chl=chl(r,c);
                
                
                figure(1)
                clf
                
                rect = get(gcf,'Position');
                rect(1:2) = [0 0];
                fr=gcf;
                
                m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);
                m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick',[round(min_lat):lat_step:round(max_lat)],'tickdir','in','color','k','lineweight',1.5);
                hold on
                m_pcolor(lon(r,c),lat(r,c),log10(chl))
                caxis([-1.6 -.8])
                colorbar
                title(['log_{10}(CHL) Run 33, week ',num2str(jdays(m))])
                colormap(chelle)
                shading interp
                hold on
                m_contour(lon(r,c),lat(r,c),ssh,[1:4:100],'k')
                m_contour(lon(r,c),lat(r,c),ssh,[-100:4:-1],'k--')
                ii=find(track_jday==jdays(m));
                uid=unique(id(ii));
                for d=1:length(uid)
                    ii=find(id==uid(d) & track_jday'<=jdays(m));
                    jj=find(id==uid(d) & track_jday'==jdays(m));
                    m_plot(x(jj),y(jj),'k.','markersize',8)
                    m_plot(x(ii),y(ii),'k','linewidth',1)
                end
                shading flat
                colormap(chelle)
                grid
                m_usercoast('gumby','patch','k');
                
                
                writeVideo(aviobj,getframe(fr,rect));
                eval(['print -dpng -r300 frames/hp66_chl/frame_' num2str(ff) '.png'])
                ff=ff+1;
            end
        end
        close(aviobj);
        
    case {'double_chl_eddies'}
        
        load mat/run14_1740.mat lat lon
        load pop_run33_tracks.mat
        jdays=[1740:2139];
        [r,c]=imap(20,35,305,330,lat,lon);
        lat_step=4;
        lon_step=6;
        dlat=lat(r,c);
        dlon=lon(r,c);
        max_lat=max(dlat(:));
        min_lat=min(dlat(:));
        max_lon=max(dlon(:));
        min_lon=min(dlon(:));
        m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);
        m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick',[round(min_lat):lat_step:round(max_lat)],'tickdir','in','color','k','lineweight',1.5);
        m_gshhs_f('save','gumby');
        
        %         aviobj = VideoWriter('run33_chl_center.avi');
        %
        %         aviobj.FrameRate=10;
        %         aviobj.Quality=100;
        %         open(aviobj)
        
        for m=5:length(jdays)
            
            %load data
            matObj = matfile(['mat/run33_',num2str(jdays(m))]);
            
            ssh=squeeze(matObj.ssh(r,c));
            hp=squeeze(matObj.hp66_chl(r,c));
            chl=squeeze(matObj.chl(r,c));
            chl(chl<0)=nan;
            
            figure(1)
            clf
            
            rect = get(gcf,'Position');
            rect(1:2) = [0 0];
            fr=gcf;
            subplot(211)
            m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);
            m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick',[round(min_lat):lat_step:round(max_lat)],'tickdir','in','color','k','lineweight',1.5);
            hold on
            m_pcolor(lon(r,c),lat(r,c),hp)
            caxis([-.013 .013])
            colorbar
            title(['high-pass filtered CHL Run 33, week ',num2str(jdays(m))])
            colormap(chelle)
            shading flat
            hold on
            m_contour(lon(r,c),lat(r,c),ssh,[1:4:100],'k')
            m_contour(lon(r,c),lat(r,c),ssh,[100:4:-1],'k--')
            ii=find(track_jday==jdays(m));
            uid=unique(id(ii));
            for d=1:length(uid)
                ii=find(id==uid(d) & track_jday'<=jdays(m));
                jj=find(id==uid(d) & track_jday'==jdays(m));
                m_plot(x(jj),y(jj),'k.','markersize',10)
                m_plot(x(ii),y(ii),'k','linewidth',1)
            end
            shading flat
            colormap(chelle)
            grid
            m_usercoast('gumby','patch','k');
            
            subplot(212)
            m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);
            m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick',[round(min_lat):lat_step:round(max_lat)],'tickdir','in','color','k','lineweight',1.5);
            hold on
            m_pcolor(lon(r,c),lat(r,c),log10(chl))
            caxis([-1.6 -.8])
            colorbar
            title(['log_{10}(CHL) Run 33, week ',num2str(jdays(m))])
            colormap(chelle)
            shading flat
            hold on
            m_contour(lon(r,c),lat(r,c),ssh,[1:4:100],'k')
            m_contour(lon(r,c),lat(r,c),ssh,[-100:4:-1],'k--')
            ii=find(track_jday==jdays(m));
            uid=unique(id(ii));
            for d=1:length(uid)
                ii=find(id==uid(d) & track_jday'<=jdays(m));
                jj=find(id==uid(d) & track_jday'==jdays(m));
                m_plot(x(jj),y(jj),'k','markersize',20)
                m_plot(x(ii),y(ii),'k','linewidth',1)
            end
            shading flat
            colormap(chelle)
            grid
            m_usercoast('gumby','patch','k');
            
            
            %             writeVideo(aviobj,getframe(fr,rect));
            eval(['print -dpng -r300 frames/hp66_chl/frame_' num2str(ff) '.png'])
            ff=ff+1;
        end
end




