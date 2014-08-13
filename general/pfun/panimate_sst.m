TYPE='oi_contour2'

load bwr.pal
load chelle.pal
load pchelle.pal
load rwp.pal
jjj=jet(256);
jetrwp=cat(1,jjj,rwp);
figure(1);
ff=1;
prev_x=[];
prev_y=[];
prev_id=[];

switch TYPE
    
    case {'oi_contour2'}
        txt_month={'Jan';'Feb';'Mar';'Apr';'May';'Jun';'Jul';'Aug';'Sep';'Oct';'Nov';'Dec'};
        warning('off','all')
        figure(1)
        load ~/matlab/domains/air-sea_sio_lat_lon
        lon=65:110;
        max_lat=max(lat(:))+24;
        min_lat=min(lat(:))-5;
        max_lon=max(lon(:))+30;
        min_lon=min(lon(:));
        load ~/data/ReynoldsSST/mat/OI_25_30_2452459 lat lon
        r=find(lat(:,1)>=min_lat & lat(:,1)<=max_lat);
        c=find(lon(1,:)>=min_lon & lon(1,:)<=max_lon);
        load ~/data/eddy/V5/mat/AVISO_25_W_2452459 lat lon
        slon=interp2(lon);
        slat=interp2(lat);
        rssh=find(slat(:,1)>=min_lat & slat(:,1)<=max_lat);
        cssh=find(slon(1,:)>=min_lon & slon(1,:)<=max_lon);
        load ~/data/ReynoldsSST/mat/OI_25_30_2452459 lat lon
        
        startjd=2452459;
        endjd=2454489;
        jdays=[startjd:7:endjd];
        

        eval(['print -dpng -r150 frame_' num2str(ff) '.png'])
        for m=1:length(jdays)
            figure(1)
            clf

            [year,month,day]=jd2jdate(jdays(m));
            dd=(yea*1000)+julian(mon,day,yea,yea)
            load(['~/data/ReynoldsSST/mat/OI_25_30_',num2str(jdays(m))],'sst_week','hp66_sst')
            
            pmap(lon(r,c),lat(r,c),hp66_sst(r,c))
            set(gca,'fontsize',30)
            m_text(65,-14.5,[txt_month(month)],'fontsize',10)
            m_text(68.2,-14.5,[num2str(year)],'fontsize',10)

            hold on
            load(['~/data/eddy/V5/mat/AVISO_25_W_',num2str(jdays(m))],'ssh')
            ssh=interp2(ssh);
            m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[-100:5:-5],'k')
            m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[5:5:100],'k')
            m_coast('patch',[0 0 0],'edgecolor','k');
            colormap(chelle)
            caxis([-1.3 1.3])
            
            
            pause(.1)
            eval(['print -dpng -r150 frame_' num2str(ff) '.png'])
            ff=ff+1;

        end
        close(aviobj);
        
        
        
        case {'oi_contour'}
        warning('off','all')
        figure(1)
        load ~/matlab/domains/air-sea_sio_lat_lon
        max_lat=max(lat(:));
        min_lat=min(lat(:));
        max_lon=max(lon(:));
        min_lon=min(lon(:));
        load ~/data/ReynoldsSST/mat/OI_25_30_2452459 lat lon
        r=find(lat(:,1)>=min_lat & lat(:,1)<=max_lat);
        c=find(lon(1,:)>=min_lon & lon(1,:)<=max_lon);
        load ~/data/eddy/V5/mat/AVISO_25_W_2452459 lat lon
        slon=interp2(lon);
        slat=interp2(lat);
        rssh=find(slat(:,1)>=min_lat & slat(:,1)<=max_lat);
        cssh=find(slon(1,:)>=min_lon & slon(1,:)<=max_lon);
        load ~/data/ReynoldsSST/mat/OI_25_30_2452459 lat lon
        
        startjd=2452459;
        endjd=2452459+700;
        jdays=[startjd:7:endjd];
        
        aviobj = VideoWriter('AGR_ssh_sst.avi');
        
        aviobj.FrameRate=10;
        aviobj.Quality=70;
        
        for m=1:length(jdays)
            figure(1)
            clf
            rect = get(gcf,'Position');
            rect(1:2) = [0 0];
            [yea,mon,day]=jd2jdate(jdays(m));
            dd=(yea*1000)+julian(mon,day,yea,yea)
            load(['~/data/ReynoldsSST/mat/OI_25_30_',num2str(jdays(m))],'sst_week','bp26_sst')
            
            subplot(211)
            pmap(lon(r,c),lat(r,c),sst_week(r,c))
            title(['Reynold',char(39),'s SST (AVHRR+AMSR)  ',num2str(yea),'-',num2str(mon),'-',num2str(day),'   '])
            ran=caxis;
            m_coast('patch',[0 0 0],'edgecolor','k');
            colormap(chelle)
            caxis(ran)
            
            subplot(212)
            pmap(lon(r,c),lat(r,c),sst_week(r,c))
            title(['SST overlaid with SSH contours'])
            hold on
            load(['~/data/eddy/V5/mat/AVISO_25_W_',num2str(jdays(m))],'ssh')
            ssh=interp2(ssh);
            m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[-82:3:-2],'k')
            m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[2:3:82],'k')
            m_coast('patch',[0 0 0],'edgecolor','k');
            colormap(chelle)
            caxis(ran)
            return
            pause(.1)
            writeVideo(aviobj,getframe(fr,rect));
        end
        
    case {'oi_foi_contour'}
        warning('off','all')
        figure(1)
        load /matlab/matlab/domains/SST_SIO_lat_lon
        load /matlab/data/eddy/V4/LW_lat_lon_tracks
        max_lat=max(lat(:));
        min_lat=min(lat(:));
        max_lon=max(lon(:));
        min_lon=min(lon(:));
        load /matlab/data/ReynoldsSST/mat/OI_25_30_2452459 lat lon
        r=find(lat(:,1)>=min_lat & lat(:,1)<=max_lat);
        c=find(lon(1,:)>=min_lon & lon(1,:)<=max_lon);
        load /matlab/data/eddy/V4/mat/AVISO_25_W_2452459 lat lon
        slat=lat;
        slon=lon;
        rssh=find(lat(:,1)>=min_lat & lat(:,1)<=max_lat);
        cssh=find(lon(1,:)>=min_lon & lon(1,:)<=max_lon);
        load /matlab/data/ReynoldsSST/mat/OI_25_30_2452459 lat lon
        
        startjd=2452459;
        endjd=2452459+700;
        jdays=[startjd:7:endjd];
        
        
        for m=1:length(jdays)
            clf
            [yea,mon,day]=jd2jdate(jdays(m));
            dd=(yea*1000)+julian(mon,day,yea,yea)
            load(['/matlab/data/ReynoldsSST/mat/OI_25_30_',num2str(jdays(m))],'sst_week','bp26_sst')
            
            subplot(211)
            pmap(lon(r,c),lat(r,c),sst_week(r,c))
            title(['Reynold',char(39),'s SST (AVHRR+AMSR)  ',num2str(yea),'-',num2str(mon),'-',num2str(day),'   '])
            ran=caxis;
            hold on
            load(['/matlab/data/eddy/V4/mat/AVISO_25_W_',num2str(jdays(m))],'ssh')
            m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[-82:4:-2],'color', [.5 .5 .5])
            m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[2:4:82],'k')
            
            d=find(track_jday==jdays(m));
            p=find(track_jday<=jdays(m));
            m_plot(x(d),y(d),'o','markerfacecolor', ...
                'k','markeredgecolor','k','markersize',5);
            %m_text(qx(dq),qy(dq),num2str(qid(dq)),'fontsize',12)
            tmp_ids=id(d);
            time_ids=id(p);
            time_xs=x(p);
            time_ys=y(p);;
            for b=1:length(tmp_ids)
                tmp=tmp_ids(b);
                e=find(time_ids==tmp);
                m_plot(time_xs(e),time_ys(e),'k', ...
                    'linewidth',.5);
            end
            caxis(ran)
            
            subplot(212)
            pmap(lon(r,c),lat(r,c),bp26_sst(r,c))
            caxis([-1 1])
            hold on
            title('Filtered SST  ')
            m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[-82:4:-2],'color', [.5 .5 .5])
            m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[2:4:82],'k')
            
            m_plot(x(d),y(d),'o','markerfacecolor', ...
                'k','markeredgecolor','k','markersize',5);
            %m_text(qx(dq),qy(dq),num2str(qid(dq)),'fontsize',12)
            
            for b=1:length(tmp_ids)
                tmp=tmp_ids(b);
                e=find(time_ids==tmp);
                m_plot(time_xs(e),time_ys(e),'k', ...
                    'linewidth',.5);
            end
            shading interp
            m_coast('patch',[0 0 0],'edgecolor','k');
            colormap(chelle)
            eval(['print -dpng -r150 frame_' num2str(ff) '.png'])
            ff=ff+1;
        end
        
    case {'sst'}
        warning('off','all')
        figure(1)
        load /matlab/matlab/domains/TROPAC_lat_lon.mat
        max_lat=max(lat(:));
        min_lat=min(lat(:));
        max_lon=max(lon(:));
        min_lon=min(lon(:));
        load /matlab/data/ReynoldsSST/mat/OI_25_D_2454991 lat lon
        r=find(lat(:,1)>=min_lat & lat(:,1)<=max_lat);
        c=find(lon(1,:)>=min_lon & lon(1,:)<=max_lon);
        
        %load /matlab/matlab/ebc/tracks/cLW_lat_lon_tracks.mat
        startyear = 2008;
        startmonth = 1;
        startday = 1;
        
        endyear = 2009;
        endmonth = 12;
        endday = 31;
        
        
        
        %construct date vector
        startjd=date2jd(startyear,startmonth,startday)+.5;
        endjd=date2jd(endyear,endmonth,endday)+.5;
        jdays=[startjd:endjd];
        
        for m=1:length(jdays)
            clf
            [yea,mon,day]=jd2jdate(jdays(m));
            dd=(yea*1000)+julian(mon,day,yea,yea)
            load(['/matlab/data/ReynoldsSST/mat/OI_25_D_',num2str(jdays(m))],'sst_oi','lat','lon')
            pmap(lon(r,c),lat(r,c),sst_oi(r,c),'oi',num2str(dd))
            %caxis([10 27])
            colorbar
            colormap(chelle)
            eval(['print -dpng -r90 frame_' num2str(ff) '.png'])
            ff=ff+1;
        end
        
        
    case {'oi_contour'}
        warning('off','all')
        figure(1)
        load /matlab/matlab/domains/oNPC_lat_lon.mat
        max_lat=max(lat(:));
        min_lat=min(lat(:));
        max_lon=max(lon(:));
        min_lon=min(lon(:));
        load /matlab/data/ReynoldsSST/mat/OI_25_W_2452459 lat lon jdays
        r=find(lat(:,1)>=min_lat & lat(:,1)<=max_lat);
        c=find(lon(1,:)>=min_lon & lon(1,:)<=max_lon);
        load /matlab/data/eddy/V4/mat/AVISO_25_W_2452459 lat lon
        slat=lat;
        slon=lon;
        rssh=find(lat(:,1)>=min_lat & lat(:,1)<=max_lat);
        cssh=find(lon(1,:)>=min_lon & lon(1,:)<=max_lon);
        %load /matlab/matlab/ebc/tracks/cLW_lat_lon_tracks.mat
        
        
        for m=1:length(jdays)
            clf
            [yea,mon,day]=jd2jdate(jdays(m));
            dd=(yea*1000)+julian(mon,day,yea,yea)
            load(['/matlab/data/ReynoldsSST/mat/OI_25_W_',num2str(jdays(m))],'sst_oi','lat','lon')
            pmap(lon(r,c),lat(r,c),sst_oi(r,c),'oi',num2str(dd))
            caxis([10 27])
            hold on
            load(['/matlab/data/eddy/V4/mat/AVISO_25_W_',num2str(jdays(m))])
            m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[-82:4:-2],'color', [.5 .5 .5])
            m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[2:4:82],'k')
            shading interp
            m_coast('patch',[0 0 0],'edgecolor','k');
            
            d=find(track_jday==mid_week_mid_week_jdays(m));
            p=find(track_jday<=mid_week_mid_week_jdays(m));
            m_plot(x(d),y(d),'o','markerfacecolor', ...
                'k','markeredgecolor','k','markersize',5);
            %m_text(qx(dq),qy(dq),num2str(qid(dq)),'fontsize',12)
            tmp_ids=id(d);
            time_ids=id(p);
            time_xs=x(p);
            time_ys=y(p);;
            for b=1:length(tmp_ids)
                tmp=tmp_ids(b);
                e=find(time_ids==tmp);
                m_plot(time_xs(e),time_ys(e),'w', ...
                    'linewidth',.5);
            end
            
            eval(['print -dpng -r300 frame_' num2str(ff) '.png'])
            eval(['!convert -trim frame_' num2str(ff) '.png frame_' num2str(ff) ...
                '.png'])
            ff=ff+1;
        end
        
    case {'foi_contour'}
        warning('off','all')
        figure(1)
        mid_week_jdays=[2452459:7:2454489];
        load /matlab/matlab/domains/TROPAC_lat_lon.mat
        max_lat=max(lat(:));
        min_lat=min(lat(:));
        max_lon=max(lon(:));
        min_lon=min(lon(:));
        load /matlab/data/ReynoldsSST/mat/OI_25_30_2452459 lat lon
        r=find(lat(:,1)>=min_lat & lat(:,1)<=max_lat);
        c=find(lon(1,:)>=min_lon & lon(1,:)<=max_lon);
        load /matlab/data/eddy/V4/mat/AVISO_25_W_2452459 lat lon
        slat=lat;
        slon=lon;
        rssh=find(lat(:,1)>=min_lat & lat(:,1)<=max_lat);
        cssh=find(lon(1,:)>=min_lon & lon(1,:)<=max_lon);
        %load /matlab/matlab/ebc/tracks/cLW_lat_lon_tracks.mat
        
        
        for m=3:length(mid_week_jdays)
            clf
            [yea,mon,day]=jd2jdate(mid_week_jdays(m));
            dd=(yea*1000)+julian(mon,day,yea,yea)
            load(['/matlab/data/ReynoldsSST/mat/OI_25_30_',num2str(mid_week_jdays(m))],'sst_week','lat','lon')
            pmap(lon(r,c),lat(r,c),sst_week(r,c))
            title({'Reynols SST',num2str(dd)})
            %caxis([-1.3 1.3])
            caxis([20 30])
            hold on
            load(['/matlab/data/eddy/V4/mat/AVISO_25_W_',num2str(mid_week_jdays(m))])
            m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[-40:5:-5],'color', [.5 .5 .5])
            m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[5:5:40],'k')
            shading interp
            m_coast('patch',[0 0 0],'edgecolor','k');
            
            eval(['print -dpng -r300 frame_' num2str(ff) '.png'])
            eval(['!convert -trim frame_' num2str(ff) '.png frame_' num2str(ff) ...
                '.png'])
            ff=ff+1;
        end
        
    case {'oi'}
        warning('off','all')
        startyear = 2003;
        startmonth = 1;
        startday = 1;
        
        endyear = 2008;
        endmonth = 12;
        endday = 03;
        
        
        %make lat lon
        
        
        
        %construct date vector
        startjd=date2jd(startyear,startmonth,startday)+.5;
        endjd=date2jd(endyear,endmonth,endday)+.5;
        jdays=[startjd:endjd];
        
        figure(1)
        load /matlab/matlab/domains/cLW_lat_lon.mat
        max_lat=max(lat(:));
        min_lat=min(lat(:));
        max_lon=max(lon(:));
        min_lon=min(lon(:));
        load /matlab/data/ReynoldsSST/mat/OI_25_W_2452459 lat lon mid_week_jdays
        r=find(lat(:,1)>=min_lat & lat(:,1)<=max_lat);
        c=find(lon(1,:)>=min_lon & lon(1,:)<=max_lon);
        load /matlab/data/eddy/V3/mat/AVISO_25_W_2452459 lat lon
        slat=lat;
        slon=lon;
        rssh=find(slat(:,1)>=min_lat & slat(:,1)<=max_lat);
        cssh=find(slon(1,:)>=min_lon & slon(1,:)<=max_lon);
        
        for m=1:length(jdays)
            clf
            [yea,mon,day]=jd2jdate(jdays(m));
            dd=(yea*1000)+julian(mon,day,yea,yea)
            load(['/matlab/data/ReynoldsSST/mat/OI_25_W_',num2str(jdays(m))])
            %load(['/matlab/data/eddy/V3/mat/AVISO_25_W_',num2str(mid_week_jdays(m))],'mask','ssh')
            %subplot(121)
            %cstep = (length(jet)-1)/(26-15);
            %X1 = round((sst_oi(r,c)+26)*cstep+1);
            %X1(X1>256)=256;
            %X1(X1<1)=1;
            pmap(lon(r,c),lat(r,c),sst_oi(r,c),'oi',num2str(dd))
            %caxis([15 29])
            title(['OI SST ' num2str(dd) '  '])
            %hold on
            %m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[-80:4:-2],'color', [.5 .5 .5])
            %m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[2:4:80],'k')
            shading interp
            colormap(chelle)
            m_coast('patch',[0 0 0],'edgecolor','k');
            
            
            eval(['print -dpng frame_' num2str(ff) '.png'])
            eval(['!convert -trim frame_' num2str(ff) '.png frame_' num2str(ff) ...
                '.png'])
            ff=ff+1;
        end
        !ffmpeg -r 5 -sameq -i frame_%d.png -y clw_oi_oihp_contours.mp4
        
    case {'oi_foi'}
        warning('off','all')
        figure(1)
        load /matlab/matlab/domains/GS_lat_lon.mat
        max_lat=max(lat(:));
        min_lat=min(lat(:));
        max_lon=max(lon(:));
        min_lon=min(lon(:));
        load /matlab/data/ReynoldsSST/mat/OI_25_W_2452459 lat lon mid_week_jdays
        r=find(lat(:,1)>=min_lat & lat(:,1)<=max_lat);
        c=find(lon(1,:)>=min_lon & lon(1,:)<=max_lon);
        load /matlab/data/eddy/V3/mat/AVISO_25_W_2452459 lat lon
        slat=lat;
        slon=lon;
        rssh=find(slat(:,1)>=min_lat & slat(:,1)<=max_lat);
        cssh=find(slon(1,:)>=min_lon & slon(1,:)<=max_lon);
        
        for m=1:length(mid_week_jdays)
            clf
            [yea,mon,day]=jd2jdate(mid_week_jdays(m));
            dd=(yea*1000)+julian(mon,day,yea,yea)
            load(['/matlab/data/ReynoldsSST/mat/OI_25_W_',num2str(mid_week_jdays(m))])
            load(['/matlab/data/eddy/V3/mat/AVISO_25_W_',num2str(mid_week_jdays(m))],'mask','ssh')
            subplot(121)
            %cstep = (length(jet)-1)/(26-15);
            %X1 = round((sst_oi(r,c)+26)*cstep+1);
            %X1(X1>256)=256;
            %X1(X1<1)=1;
            pmap(lon(r,c),lat(r,c),sst_oi(r,c),'oi',num2str(dd))
            caxis([15 29])
            title(['OI SST ' num2str(dd) '  '])
            hold on
            m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[-80:4:-2],'color', [.5 .5 .5])
            m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[2:4:80],'k')
            shading interp
            m_coast('patch',[0 0 0],'edgecolor','k');
            
            subplot(122)
            cstep = (length(rwp)-1)/(26-15);
            %Xtmp  = round((filtered_sst_oi(r,c)+26)*cstep+1)
            %Xtmp(Xtmp>256)=256;
            %Xtmp(X1<1)=1;
            %X2=Xtmp+256;
            pmap(lon(r,c),lat(r,c),filtered_sst_oi(r,c),'oihp',num2str(dd))
            title(['HP Filtered OI SST ' num2str(dd) '  '])
            %ax = findobj(gcf,'Type','axes');
            %set(ax,'CLim', [min(X1(:)) max(X2(:))])
            colormap(chelle)
            hold on
            load(['/matlab/data/eddy/V3/mat/AVISO_25_W_',num2str(mid_week_jdays(m))])
            m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[-80:4:-2],'color', [.5 .5 .5])
            m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[2:4:80],'k')
            shading interp
            m_coast('patch',[0 0 0],'edgecolor','k');
            
            eval(['print -dpng frame_' num2str(ff) '.png'])
            eval(['!convert -trim frame_' num2str(ff) '.png frame_' num2str(ff) ...
                '.png'])
            ff=ff+1;
        end
        !ffmpeg -r 5 -sameq -i frame_%d.png -y clw_oi_oihp_contours.mp4
        
    case {'famsre_contour'}
        warning('off','all')
        figure(1)
        load /matlab/matlab/domains/CCex_lat_lon.mat
        max_lat=max(lat(:));
        min_lat=min(lat(:));
        max_lon=max(lon(:));
        min_lon=min(lon(:));
        load /matlab/data/AMSRE/mat/AMSRE_25_W_2452459 lat lon mid_week_jdays
        r=find(lat(:,1)>=min_lat & lat(:,1)<=max_lat);
        c=find(lon(1,:)>=min_lon & lon(1,:)<=max_lon);
        load /matlab/data/eddy/V3/mat/AVISO_25_W_2452459 lat lon
        rssh=find(lat>=min_lat & lat<=max_lat);
        cssh=find(lon>=min_lon & lon<=max_lon);
        
        
        for m=1:100%length(mid_week_jdays)
            clf
            [yea,mon,day]=jd2jdate(mid_week_jdays(m));
            dd=(yea*1000)+julian(mon,day,yea,yea)
            load(['/matlab/data/AMSRE/mat/AMSRE_25_W_',num2str(mid_week_jdays(m))])
            pmap(lon(r,c),lat(r,c),filtered_sst_amsre(r,c),'amsrehp',num2str(dd))
            hold on
            load(['/matlab/data/eddy/V3/mat/AVISO_25_W_',num2str(mid_week_jdays(m))])
            m_contour(lon(cssh),lat(rssh),ssh(rssh,cssh),[-80:2:-2],'color', [.5 .5 .5])
            m_contour(lon(cssh),lat(rssh),ssh(rssh,cssh),[2:2:80],'k')
            shading interp
            m_coast('patch',[0 0 0],'edgecolor','k');
            
            eval(['print -dpng -r300 frame_' num2str(ff) '.png'])
            eval(['!convert -trim frame_' num2str(ff) '.png frame_' num2str(ff) ...
                '.png'])
            ff=ff+1;
        end
        
        
    case {'famsre_mask_contour'}
        warning('off','all')
        figure(1)
        load /matlab/matlab/domains/LW_lat_lon.mat
        max_lat=max(lat(:));
        min_lat=min(lat(:));
        max_lon=max(lon(:));
        min_lon=min(lon(:));
        load /matlab/data/AMSRE/mat/AMSRE_25_W_2452459 lat lon mid_week_jdays
        r=find(lat(:,1)>=min_lat & lat(:,1)<=max_lat);
        c=find(lon(1,:)>=min_lon & lon(1,:)<=max_lon);
        load /matlab/data/eddy/V3/mat/AVISO_25_W_2452459 lat lon
        rssh=find(lat>=min_lat & lat<=max_lat);
        cssh=find(lon>=min_lon & lon<=max_lon);
        
        
        for m=1:length(mid_week_jdays)
            clf
            [yea,mon,day]=jd2jdate(mid_week_jdays(m));
            dd=(yea*1000)+julian(mon,day,yea,yea)
            load(['/matlab/data/AMSRE/mat/AMSRE_25_W_',num2str(mid_week_jdays(m))])
            load(['/matlab/data/eddy/V3/mat/AVISO_25_W_',num2str(mid_week_jdays(m))],'mask')
            pmap(lon(r,c),lat(r,c),filtered_sst_amsre(r,c).*mask(rssh,cssh),'amsrehp',num2str(dd))
            hold on
            load(['/matlab/data/eddy/V3/mat/AVISO_25_W_',num2str(mid_week_jdays(m))])
            m_contour(lon(cssh),lat(rssh),ssh(rssh,cssh).*mask(rssh,cssh),[-80:2:-2],'color', [.5 .5 .5])
            m_contour(lon(cssh),lat(rssh),ssh(rssh,cssh).*mask(rssh,cssh),[2:2:80],'k')
            shading interp
            m_coast('patch',[0 0 0],'edgecolor','k');
            
            eval(['print -dpng -r300 frame_' num2str(ff) '.png'])
            eval(['!convert -trim frame_' num2str(ff) '.png frame_' num2str(ff) ...
                '.png'])
            ff=ff+1;
        end
        !ffmpeg -r 5 -sameq -i frame_%d.png -y lw_famsre_contours.mp4
        
        
        
        
    case {'tss_tiwi'}
        warning('off','all')
        figure(1)
        pp=find(twii_70>0);
        nn=find(twii_70<0);
        tmpp=twii_70;
        tmpp(nn)=0;
        tmpn=twii_70;
        tmpn(pp)=0;
        for m=1:length(mid_week_jdays)
            clf
            subplot(311)
            [yea,mon,day]=jd2jdate(mid_week_jdays(m));
            dd=(yea*1000)+julian(mon,day,yea,yea);
            pmap(lon,lat,sst_week_tmi(:,:,m),'tsst',num2str(dd))
            hold on
            m_line([lon(1,c(1)) lon(1,c(length(c)))],[lat(r(1),1) lat(r(1),1)])
            m_line([lon(1,c(1)) lon(1,c(length(c)))],[lat(r(length(r)),1) lat(r(length(r)),1)])
            m_line([lon(1,c(1)) lon(1,c(1))],[lat(r(1),1) lat(r(length(r)),1)])
            m_line([lon(1,c(length(c))) lon(1,c(length(c)))],[lat(r(1),1) lat(r(length(r)),1)])
            hold off
            subplot(312)
            pmap(lon,lat,sst_anom(:,:,m),'tssthp',num2str(dd))
            hold on
            m_line([lon(1,c(1)) lon(1,c(length(c)))],[lat(r(1),1) lat(r(1),1)])
            m_line([lon(1,c(1)) lon(1,c(length(c)))],[lat(r(length(r)),1) lat(r(length(r)),1)])
            m_line([lon(1,c(1)) lon(1,c(1))],[lat(r(1),1) lat(r(length(r)),1)])
            m_line([lon(1,c(length(c))) lon(1,c(length(c)))],[lat(r(1),1) lat(r(length(r)),1)])
            hold off
            subplot(313)
            mask=ones(1,731);
            mask(m+1:731)=0;
            hp=area(1:731,tmpp.*mask);
            set(hp,'facecolor','r')
            hold on
            hn=area(1:731,tmpn.*mask);
            set(hn,'facecolor','b')
            axis([0 731 -1.5 1.5])
            title('tiwi-70')
            eval(['print -dpng frame_' num2str(ff) '.png'])
            ff=ff+1;
        end
        !ffmpeg -r 7 -sameq -i frame_%d.png -y tropac_sst_tiwi.mp4
        
    case {'tsstanom'}
        warning('off','all')
        figure(1)
        for m=1:length(mid_week_jdays)
            clf
            
            [yea,mon,day]=jd2jdate(mid_week_jdays(m));
            dd=(yea*1000)+julian(mon,day,yea,yea);
            pmap(lon,lat,sst_anom(:,:,m),'tssthp',num2str(dd))
            eval(['print -dpng frame_' num2str(ff) '.png'])
            eval(['!convert -trim frame_' num2str(ff) '.png frame_' num2str(ff) ...
                ...
                '.png'])
            ff=ff+1;
        end
        !ffmpeg -r 3 -sameq -i frame_%d.png -y tropac_sst_anom.mp4
        
        
    case {'tss'}
        warning('off','all')
        figure(1)
        for m=1:length(mid_week_jdays)
            clf
            
            [yea,mon,day]=jd2jdate(mid_week_jdays(m));
            dd=(yea*1000)+julian(mon,day,yea,yea);
            pmap(lon,lat,sst_week_tmi(:,:,m),'tsst',num2str(dd))
            eval(['print -dpng frame_' num2str(ff) '.png'])
            eval(['!convert -trim frame_' num2str(ff) '.png frame_' ...
                num2str(ff) ...
                ...
                '.png'])
            ff=ff+1;
        end
        
        
        
    case {'amsre_trans_box_tracks'}
        %load eddies
        warning('off','all')
        figure(1)
        
        
        %north
        unid = [119421 115644];
        cors = [.8963 .5372];
        %unid = [61843 51058];
        %cors = [.8555 .6084];
        
        %south
        %unid = [127827 119375];
        %cors = [.8995 .7449];
        %unid = [59584 37262];
        %cors = [.8632 .4161];
        for ee=1:length(unid)
            itid=find(id==unid(ee));
            tid=id(itid);
            for n=1:length(tid)
                if track_jday(itid(n)) >= 2452459
                    load(['/matlab/data/AMSRE/mat/AMSRE_25_W_',num2str(track_jday(itid(n)))])
                    r=find(lat(:,1)>=y(itid(n))-3 & lat(:,1)<=y(itid(n))+3);
                    c=find(lon(1,:)>=x(itid(n))-3 & lon(1,:)<=x(itid(n))+3);
                    if length(r)>20 & length(c)>20
                        clf
                        [yea,mon,day]=jd2jdate(track_jday(itid(n)));
                        dd=(yea*1000)+julian(mon,day,yea,yea);
                        pmap(lon(r,c),lat(r,c),filtered_sst_amsre(r,c),'amsrehp',num2str(dd))
                        hold on
                        load(['/matlab/data/eddy/V3/mat/AVISO_25_W_',num2str(track_jday(itid(n)))])
                        r=find(lat>=y(itid(n))-3 & lat<=y(itid(n))+3);
                        c=find(lon>=x(itid(n))-3 & lon<=x(itid(n))+3);
                        m_contour(lon(c),lat(r),ssh(r,c),[-40:2:-2],'--','color',[.5 .5 .5])
                        m_contour(lon(c),lat(r),ssh(r,c),[2:2:40],'color',[.5 .5 .5])
                        xlabel(['ID = ', num2str(id(itid(n))), '  cor = ' num2str(cors(ee))  '  k = ',num2str(k(itid(n))), ' of ' , num2str(max(k(itid)))...
                            '  U/c = ',num2str(axial_speed(itid(n))/prop_speed(itid(n))),'  Amp = ',num2str(amp(itid(n)))],'color','k')
                        d=find(track_jday(itid)==track_jday(itid(n)));
                        p=find(track_jday(itid)<=track_jday(itid(n)));
                        h=m_plot(x(itid(d)),y(itid(d)),'ko','markerfacecolor', ...
                            'k','markersize',4);
                        tmp_ids=id(itid(d));
                        time_ids=id(itid(p));
                        time_xs=x(itid(p));
                        time_ys=y(itid(p));
                        for b=1:length(tmp_ids)
                            tmp=tmp_ids(b);
                            e=find(time_ids==tmp);
                            h=m_plot(time_xs(e),time_ys(e),'k', ...
                                'linewidth',2);
                            set(h,'clipping','off')
                        end
                        
                        eval(['print -dpng frame_' num2str(ff) '.png'])
                        %eval(['!convert -trim frame_' num2str(ff) '.png frame_' num2str(ff) ...
                        %		'.png'])
                        ff=ff+1;
                        if n==length(tid)
                            clf
                            pmap(lon(c),lat(r),ssh(r,c)*nan,'amsrehp',num2str(dd))
                            eval(['print -dpng frame_' num2str(ff) '.png'])
                            %eval(['!convert -trim frame_' num2str(ff) '.png frame_' num2str(ff) ...
                            %		'.png'])
                            ff=ff+1;
                        end
                    else
                    end
                end
            end
        end
        !ffmpeg -r 5 -sameq -i frame_%d.png -y north_famsre_track_trans_box_anti.mp4
        
        
    case {'amsre'}
        warning('off','all')
        figure(1)
        max_lat=max(lat(:));
        min_lat=min(lat(:));
        max_lon=max(lon(:));
        min_lon=min(lon(:));
        
        
        for m=7:length(mid_week_jdays)
            clf
            [yea,mon,day]=jd2jdate(mid_week_jdays(m));
            dd=(yea*1000)+julian(mon,day,yea,yea)
            pmap(sst_lon,sst_lat,sst_week(:,:,m),'amsre',num2str(dd))
            eval(['print -dpng frame_' num2str(ff) '.png'])
            eval(['!convert -trim frame_' num2str(ff) '.png frame_' num2str(ff) ...
                '.png'])
            clf
            ff=ff+1;
        end
        !ffmpeg -r 10 -sameq -i frame_%d.png -y timor_amsre.mp4
        
    case {'msst_contour'}
        warning('off','all')
        figure(1)
        load /matlab/matlab/domains/LW_lat_lon.mat
        max_lat=max(lat(:));
        min_lat=min(lat(:));
        max_lon=max(lon(:));
        min_lon=min(lon(:));
        load /matlab/data/ReynoldsSST/mat/OI_25_W_2452459 lat lon mid_week_jdays
        r=find(lat(:,1)>=min_lat & lat(:,1)<=max_lat);
        c=find(lon(1,:)>=min_lon & lon(1,:)<=max_lon);
        load /matlab/data/eddy/V4/mat/AVISO_25_W_2452459 lat lon
        slat=lat;
        slon=lon;
        rssh=find(lat(:,1)>=min_lat & lat(:,1)<=max_lat);
        cssh=find(lon(1,:)>=min_lon & lon(1,:)<=max_lon);
        
        
        for m=1:length(mid_week_jdays)
            clf
            [yea,mon,day]=jd2jdate(mid_week_jdays(m));
            dd=(yea*1000)+julian(mon,day,yea,yea)
            load(['/matlab/data/ReynoldsSST/mat/OI_25_W_',num2str(mid_week_jdays(m))],'sst_oi','lat','lon')
            pmap(lon(r,c),lat(r,c),sst_oi(r,c),'oi',num2str(dd))
            hold on
            load(['/matlab/data/eddy/V4/mat/AVISO_25_W_',num2str(mid_week_jdays(m))])
            %m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[-80:2:-2],'color', [.5 .5 .5])
            m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[1:2:80],'k')
            shading interp
            m_coast('patch',[0 0 0],'edgecolor','k');
            
            d=find(track_jday==mid_week_jdays(m));
            p=find(track_jday<=mid_week_jdays(m));
            m_plot(x(d),y(d),'o','markerfacecolor', ...
                'k','markeredgecolor','k','markersize',5);
            %m_text(qx(dq),qy(dq),num2str(qid(dq)),'fontsize',12)
            tmp_ids=id(d);
            time_ids=id(p);
            time_xs=x(p);
            time_ys=y(p);;
            for b=1:length(tmp_ids)
                tmp=tmp_ids(b);
                e=find(time_ids==tmp);
                m_plot(time_xs(e),time_ys(e),'w', ...
                    'linewidth',.5);
            end
            
            eval(['print -dpng -r300 frame_' num2str(ff) '.png'])
            eval(['!convert -trim frame_' num2str(ff) '.png frame_' num2str(ff) ...
                '.png'])
            ff=ff+1;
        end
        !ffmpeg -r 5 -sameq -s hd1080 -i frame_%d.png -y out.mp4
        
        
        
    case {'oi_contour'}
        warning('off','all')
        figure(1)
        ff=1;
        tlat=lat;
        tlon=lon;
        load /matlab/matlab/domains/LW_lat_lon.mat
        max_lat=max(lat(:));
        min_lat=min(lat(:));
        max_lon=max(lon(:));
        min_lon=min(lon(:));
        r=find(tlat(:,1)>=min_lat & tlat(:,1)<=max_lat);
        c=find(tlon(1,:)>=min_lon & tlon(1,:)<=max_lon);
        lat=tlat;
        lon=tlon;
        %rssh=find(ssh_lat(:,1)>=min_lat & ssh_lat(:,1)<=max_lat);
        %cssh=find(ssh_lon(1,:)>=min_lon & ssh_lon(1,:)<=max_lon);
        
        
        for m=100:152
            clf
            [yea,mon,day]=jd2jdate(mid_week_jdays(m));
            dd=(yea*1000)+julian(mon,day,yea,yea)
            pmap(lon(r,c),lat(r,c),sst_week(r,c,m),'oi',num2str(dd))
            hold on
            ii=find(jdays==mid_week_jdays(m));
            %m_text(75,-62,{'Cyclones are white and anticyclones are black.',...
            %'Contour interval if 4 cm with a max at +/- 20 cm'})
            m_contour(lon(r,c),lat(r,c),ssh(r,c,ii),[-40:2:-4],'w');
            m_contour(lon(r,c),lat(r,c),ssh(r,c,ii),[4:2:40],'k');
            drawnow
            eval(['print -dpng frame_' num2str(ff) '.png'])
            eval(['!convert -trim frame_' num2str(ff) '.png frame_' num2str(ff) ...
                '.png'])
            ff=ff+1;
        end
        !ffmpeg -r 10 -sameq -i frame_%d.png -y vocals_oi_contour.mp4
        
    case {'oi_hp_contour'}
        warning('off','all')
        figure(1)
        ff=1;
        
        for m=100:152
            clf
            [yea,mon,day]=jd2jdate(mid_week_jdays(m));
            dd=(yea*1000)+julian(mon,day,yea,yea)
            pmap(lon,lat,filtered_sst(:,:,m),'oihp',num2str(dd))
            hold on
            ii=find(jdays==mid_week_jdays(m));
            %m_text(75,-62,{'Cyclones are white and anticyclones are black.',...
            %'Contour interval if 4 cm with a max at +/- 20 cm'})
            m_contour(lon,lat,ssh(:,:,ii),[-20:2:-2],'w');
            m_contour(lon,lat,ssh(:,:,ii),[2:2:20],'k');
            drawnow
            %eval(['print -dpng frame_' num2str(ff) '.png'])
            %eval(['!convert -trim frame_' num2str(ff) '.png frame_' num2str(ff) ...
            %      '.png'])
            %ff=ff+1;
        end
        !ffmpeg -r 10 -sameq -i frame_%d.png -y timor_oi_contour.mp4
        
        
    case {'amsre_hp_contour'}
        warning('off','all')
        figure(1)
        ff=1;
        
        for m=100:152
            clf
            [yea,mon,day]=jd2jdate(mid_week_jdays(m));
            dd=(yea*1000)+julian(mon,day,yea,yea)
            pmap(lon,lat,filtered_sst(:,:,m),'amsrehp',num2str(dd))
            hold on
            ii=find(jdays==mid_week_jdays(m));
            %m_text(75,-62,{'Cyclones are white and anticyclones are black.',...
            %'Contour interval if 4 cm with a max at +/- 20 cm'})
            m_contour(lon,lat,ssh(:,:,ii),[-20:2:-2],'w');
            m_contour(lon,lat,ssh(:,:,ii),[2:2:20],'k');
            drawnow
            eval(['print -dpng frame_' num2str(ff) '.png'])
            eval(['!convert -trim frame_' num2str(ff) '.png frame_' num2str(ff) ...
                '.png'])
            ff=ff+1;
        end
        !ffmpeg -r 10 -sameq -i frame_%d.png -y timor_amsre_contour.mp4
        
        
        
    case {'amsre_contour'}
        warning('off','all')
        figure(1)
        ff=1;
        ff=1;
        tlat=lat;
        tlon=lon;
        load /matlab/matlab/domains/LW_lat_lon.mat
        max_lat=max(lat(:));
        min_lat=min(lat(:));
        max_lon=max(lon(:));
        min_lon=min(lon(:));
        r=find(tlat(:,1)>=min_lat & tlat(:,1)<=max_lat);
        c=find(tlon(1,:)>=min_lon & tlon(1,:)<=max_lon);
        lat=tlat;
        lon=tlon;
        %rssh=find(ssh_lat(:,1)>=min_lat & ssh_lat(:,1)<=max_lat);
        %cssh=find(ssh_lon(1,:)>=min_lon & ssh_lon(1,:)<=max_lon);
        
        for m=100:152
            clf
            [yea,mon,day]=jd2jdate(mid_week_jdays(m));
            dd=(yea*1000)+julian(mon,day,yea,yea)
            pmap(lon(r,c),lat(r,c),sst_week(r,c,m),'amsre',num2str(dd))
            hold on
            ii=find(jdays==mid_week_jdays(m));
            %m_text(75,-62,{'Cyclones are white and anticyclones are black.',...
            %'Contour interval if 4 cm with a max at +/- 20 cm'})
            m_contour(lon(r,c),lat(r,c),ssh(r,c,ii),[-40:2:-4],'w');
            m_contour(lon(r,c),lat(r,c),ssh(r,c,ii),[4:2:40],'k');
            drawnow
            eval(['print -dpng frame_' num2str(ff) '.png'])
            eval(['!convert -trim frame_' num2str(ff) '.png frame_' num2str(ff) ...
                '.png'])
            ff=ff+1;
        end
        !ffmpeg -r 10 -sameq -i frame_%d.png -y timor_amsre_contour.mp4
        
        
    case {'amsre_ssthp_tracks_contour'}
        warning('off','all')
        figure(1)
        max_lat=max(lat(:));
        min_lat=min(lat(:));
        max_lon=max(lon(:));
        min_lon=min(lon(:));
        
        
        
        match_time=find(mid_week_jdays>= min(track_jday) & mid_week_jdays<=max(track_jday));
        match_time(1:7)=[];
        
        for m=match_time
            clf
            [yea,mon,day]=jd2jdate(mid_week_jdays(m));
            dd=(yea*1000)+julian(mon,day,yea,yea)
            pmap(sst_lon,sst_lat,filtered_sst(:,:,m),'amsrehp',num2str(dd))
            hold on
            m_text(75,-62,{'Cyclones are white and anticyclones are black.',...
                'Contour interval if 4 cm with a max at +/- 20 cm'})
            m_contour(lon,lat,filtered_ssh(:,:,m),[-20:4:-2],'w');
            m_contour(lon,lat,filtered_ssh(:,:,m),[2:4:20],'k');
            
            da=find(track_jday==jdays(m) & id>=nneg);
            dc=find(track_jday==jdays(m) & id<nneg);
            p=find(track_jday<=jdays(m));
            h=m_plot(x(dc),y(dc),'o','markerfacecolor', ...
                'w','markersize',2);
            h=m_plot(x(da),y(da),'o','markersize',2);
            set(h,'clipping','off')
            tmp_ids_a=id(da);
            tmp_ids_c=id(dc);
            time_ids=id(p);
            time_xs=x(p);
            time_ys=y(p);
            for b=1:length(tmp_ids_a)
                tmp=tmp_ids_a(b);
                e=find(time_ids==tmp);
                h=m_plot(time_xs(e),time_ys(e),'k', ...
                    'linewidth',.5);
                set(h,'clipping','off')
            end
            for b=1:length(tmp_ids_c)
                tmp=tmp_ids_c(b);
                e=find(time_ids==tmp);
                h=m_plot(time_xs(e),time_ys(e),'w', ...
                    'linewidth',.5);
                set(h,'clipping','off')
            end
            
            
            
            eval(['print -dpng frame_' num2str(ff) '.png'])
            eval(['!convert -trim frame_' num2str(ff) '.png frame_' num2str(ff) ...
                '.png'])
            ff=ff+1;
        end
end
png2mpg