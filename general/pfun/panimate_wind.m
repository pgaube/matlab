TYPE='haw_wek'

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
    
    case {'haw_wek'}
        txt_month={'Jan';'Feb';'Mar';'Apr';'May';'Jun';'Jul';'Aug';'Sep';'Oct';'Nov';'Dec'};
        spath='/Users/new_gaube/data/QuickScat/ULTI_mat4/QSCAT_30_25km_';
        load([spath '2452585'],'lat','lon')
        qlat=lat;
        qlon=lon;
        load ~/data/eddy/V5/mat/AVISO_25_W_2451556 lat lon
        slat=lat;
        slon=lon;
        normer=f_cor(qlat)./f_cor(25);
        startjd=2452585;
        endjd=2455140;
        jdays=[startjd:7:endjd];
        load ~/matlab/domains/HAW_lat_lon.mat
        lat=15:35;
        lon=180:250;
        [r,c]=imap(min(lat),max(lat),min(lon),max(lon),qlat,qlon);
        [rs,cs]=imap(min(lat),max(lat),min(lon),max(lon),slat,slon);
        
        max_lat=max(lat(:));
        min_lat=min(lat(:));
        max_lon=max(lon(:));
        min_lon=min(lon(:));
        lat_step=5;
        lon_step=10;

        for m=1:length(jdays)
            load([spath num2str(jdays(m))],'hp_crl_wek_est')
            load(['~/data/eddy/V5/mat/AVISO_25_W_',num2str(jdays(m))],'ssh')
            
            figure(1)
            clf
            set(gcf,'InvertHardCopy', 'off','PaperPosition',[1 1 600 300],'PaperUnits','points')
            pmap(qlon(r,c),qlat(r,c),double(normer(r,c).*hp_crl_wek_est(r,c)))
            shading interp
            caxis([-20 20])
            hold on
            m_contour(slon(rs,cs),slat(rs,cs),ssh(rs,cs),[-100:3:-4],'k')
            m_contour(slon(rs,cs),slat(rs,cs),ssh(rs,cs),[4:3:100],'k')
            [year,month,day]=jd2jdate(jdays(m));
            m_coast('patch',[0 0 0]);
%             grid  
            colormap(bwr)
            m_text(181,37,[txt_month(month)],'fontsize',10)
            m_text(185,37,[num2str(year)],'fontsize',10)
            pause(.1)
            eval(['print -dpng frame_' num2str(ff) '.png'])
            ff=ff+1;
            clear hp_wek_crlg_week str strm_week
        end

        

        
        
        
    case {'sst_wek_with_comps'}
        spath='~/data/QuickScat/ULTI_mat2/QSCAT_30_25km_';
        opath='~/data/QuickScat/new_mat/QSCAT_30_25km_';
        load([spath '2451556'],'lat','lon')
        qlat=lat;
        qlon=lon;
        load ~/data/eddy/V5/mat/AVISO_25_W_2451556 lat lon
        slat=lat;
        slon=lon;
        startjd=2452459;
        endjd=2454489;
        jdays=[startjd:7:endjd];
        load ~/matlab/domains/new_SP_lat_lon.mat
        
        [r,c]=imap(min(lat),max(lat),min(lon),max(lon),qlat,qlon);
        [rs,cs]=imap(min(lat),max(lat),min(lon),max(lon),slat,slon);
        
        load ~/data/eddy/V5/new_SP_lat_lon_tracks
        x=ext_x;
        y=ext_y;
        % Create indicies
        ic = length(find(cyc<0));
        ia = length(find(cyc>0));
        
        % Create matrices to save jdays
        xi=[-2:.125:2];
        yi=xi';
        M=length(xi);
        tcompaq=single(nan(M,M,ia));
        tcompcq=single(nan(M,M,ic));
        tcompaa=single(nan(M,M,ia));
        tcompca=single(nan(M,M,ic));
        zzaq=1;
        zzcq=1;
        zzaa=1;
        zzca=1;
        
        for m=1:length(jdays)
            load([spath num2str(jdays(m))],'hp_wek_crlg_week','hp_wek_sst_week_dtdn','wek')
            load([opath num2str(jdays(m))],'sm_u_week','sm_v_week')
            load(['~/data/eddy/V5/mat/AVISO_25_W_',num2str(jdays(m))],'ssh')
            figure(1)
            clf

            fr=gcf;
            subplot(3,4,[1 2 3 4])
            m_proj('Equidistant cylindrical','lon',[min(lon) max(lon)],'lat',[min(lat) max(lat)]);
            m_pcolor(qlon(r,c),qlat(r,c),double(hp_wek_sst_week_dtdn(r,c)));shading flat;grid
            caxis([-2 2])
            hold on
            m_contour(slon(rs,cs),slat(rs,cs),ssh(rs,cs),[-100:3:-4],'k')
            m_contour(slon(rs,cs),slat(rs,cs),ssh(rs,cs),[4:3:100],'k')
            m_grid('xtick',[min(lon):10:max(lon)],'ytick',[min(lat):5:max(lat)],'tickdir','in','color','k','lineweight',1.5);
            m_coast
            [year,month,day]=jd2jdate(jdays(m));
            title(['SST Ekman Pumping  ' num2str(year) '-' num2str(month) '-' num2str(day)],'fontsize',12)
            
            
            subplot(3,4,[5 6 7 8])
            quiver(qlon(r(1:10:end),c(1:10:end)),qlat(r(1:10:end),c(1:10:end)),sm_u_week(r(1:10:end),c(1:10:end)),sm_v_week(r(1:10:end),c(1:10:end)),1,'k');axis image
            title(['QuikSCAT Background Wind  '],'fontsize',12)
            colormap(bwr)
            
            ii=find(track_jday==jdays(m));
            for pp=1:length(ii)
                ir = find(y(ii(pp))+.125 >= qlat(:,1) & y(ii(pp))-.125 <= qlat(:,1));
                ic = find(x(ii(pp))+.125 >= qlon(1,:) & x(ii(pp))-.125 <= qlon(1,:));
                rr=ir-40:ir+40;
                cr=ic-40:ic+40;
%                 if min(rr)>0 & max(rr)<length(qlat(:,1)) & min(cr)>0 & max(cr)<length(qlon(1,:))
                    scene_lat = qlat(rr,cr);
                    scene_lon = qlon(rr,cr);
                    obs=hp_wek_sst_week_dtdn(rr,cr);
                    ndata=zgrid(double(scene_lon), ...
                        double(scene_lat), ...
                        double(x(ii(pp))), ...
                        double(y(ii(pp))), ...
                        double(obs), ...
                        double(scale(ii(pp))));
                    
                    if cyc(ii(pp))>0;
                        tcompaq(:,:,zzaq)=single(ndata);
                        zzaq=zzaq+1;
                        
                    else
                        tcompcq(:,:,zzcq)=single(ndata);
                        zzcq=zzcq+1;
                        
                    end
                    
                    obs=hp_wek_crlg_week(rr,cr);
                    ndata=zgrid(double(scene_lon), ...
                        double(scene_lat), ...
                        double(x(ii(pp))), ...
                        double(y(ii(pp))), ...
                        double(obs), ...
                        double(scale(ii(pp))));
                    
                    if cyc(ii(pp))>0;
                        tcompaa(:,:,zzaa)=single(ndata);
                        zzaa=zzaa+1;
                        
                    else
                        tcompca(:,:,zzca)=single(ndata);
                        zzca=zzca+1;
                        
                    end
%                 end
            end
            
            subplot(349)
            pcolor(xi,yi,double(nanmean(tcompaq,3)));
            hold on
            contour(xi,yi,nanmean(tcompaq,3),[-100:.1:-.1],'k--');
            contour(xi,yi,nanmean(tcompaq,3),[.1:.1:100],'k');
            shading flat;axis image;caxis([-1 1])
            xlabel('SST-Ekman')
            title('anticyclones')
            colorbar
            subplot(3,4,10)
            pcolor(xi,yi,double(nanmean(tcompcq,3)));
            hold on
            contour(xi,yi,nanmean(tcompcq,3),[-100:.1:-.1],'k--');
            contour(xi,yi,nanmean(tcompcq,3),[.1:.1:100],'k');
            shading flat;axis image;caxis([-1 1])
            xlabel('SST-Ekman')
            title('cyclones')
            colorbar
            
            subplot(3,4,11)
            pcolor(xi,yi,double(nanmean(tcompaa,3)));
            hold on
            contour(xi,yi,nanmean(tcompaa,3),[-100:.5:-.5],'k--');
            contour(xi,yi,nanmean(tcompaa,3),[.5:.5:100],'k');
            shading flat;axis image;caxis([-5 5])
            xlabel('AVISO')
            title('anticyclones')
            colorbar
            
            subplot(3,4,12)
            pcolor(xi,yi,double(nanmean(tcompca,3)));
            hold on
            contour(xi,yi,nanmean(tcompca,3),[-100:.5:-.5],'k--');
            contour(xi,yi,nanmean(tcompca,3),[.5:.5:100],'k');
            shading flat;axis image;caxis([-5 5])
            xlabel('AVISO')
            title('cyclones')
            colorbar
            
            
            
            
            eval(['print -dpng frames/SP/frame_' num2str(ff) '.png'])
            ff=ff+1;
            clear hp_wek_crlg_week wek
        end
        %         close(aviobj);
        
        return
        
        
    case {'crl_wek_with_comps'}
        spath='~/data/QuickScat/ULTI_mat2/QSCAT_30_25km_';
        load([spath '2451556'],'lat','lon')
        qlat=lat;
        qlon=lon;
        load ~/data/eddy/V5/mat/AVISO_25_W_2451556 lat lon
        slat=lat;
        slon=lon;
        startjd=2452459;
        endjd=2454489;
        jdays=[startjd:7:endjd];
        load ~/matlab/domains/EIO_lat_lon.mat
        
        [r,c]=imap(min(lat),max(lat),min(lon),max(lon),qlat,qlon);
        [rs,cs]=imap(min(lat),max(lat),min(lon),max(lon),slat,slon);
        
        load ~/data/eddy/V5/EIO_lat_lon_tracks
        x=ext_x;
        y=ext_y;
        % Create indicies
        ic = length(find(cyc<0));
        ia = length(find(cyc>0));
        
        % Create matrices to save jdays
        xi=[-2:.125:2];
        yi=xi';
        M=length(xi);
        tcompaq=single(nan(M,M,ia));
        tcompcq=single(nan(M,M,ic));
        tcompaa=single(nan(M,M,ia));
        tcompca=single(nan(M,M,ic));
        zzaq=1;
        zzcq=1;
        zzaa=1;
        zzca=1;
        
        for m=1:length(jdays)
            load([spath num2str(jdays(m))],'hp_wek_crlg_week','wek')
            %hp_wek_crlg_week(abs(hp_wek_crlg_week)>50)=nan;
            load(['~/data/eddy/V5/mat/AVISO_25_W_',num2str(jdays(m))],'ssh')
            figure(1)
            clf

            fr=gcf;
            subplot(3,4,[1 2 3 4])
            m_proj('Equidistant cylindrical','lon',[min(lon) max(lon)],'lat',[min(lat) max(lat)]);
            m_pcolor(qlon(r,c),qlat(r,c),double(hp_wek_crlg_week(r,c)));shading flat;grid
            caxis([-25 25])
            hold on
            m_contour(slon(rs,cs),slat(rs,cs),ssh(rs,cs),[-100:3:-4],'k')
            m_contour(slon(rs,cs),slat(rs,cs),ssh(rs,cs),[4:3:100],'k')
            m_grid('xtick',[min(lon):10:max(lon)],'ytick',[min(lat):5:max(lat)],'tickdir','in','color','k','lineweight',1.5);
            m_coast
            [year,month,day]=jd2jdate(jdays(m));
            title(['AVISO Ekman Pumping  ' num2str(year) '-' num2str(month) '-' num2str(day)],'fontsize',12)
            
            
            subplot(3,4,[5 6 7 8])
            m_proj('Equidistant cylindrical','lon',[min(lon) max(lon)],'lat',[min(lat) max(lat)]);
            m_pcolor(qlon(r,c),qlat(r,c),double(wek(r,c)));shading flat;grid
            caxis([-25 25])
            hold on
            m_contour(slon(rs,cs),slat(rs,cs),ssh(rs,cs),[-100:3:-4],'k')
            m_contour(slon(rs,cs),slat(rs,cs),ssh(rs,cs),[4:3:100],'k')
            m_grid('xtick',[min(lon):10:max(lon)],'ytick',[min(lat):5:max(lat)],'tickdir','in','color','k','lineweight',1.5);
            m_coast
            title(['QuikSCAT Ekman Pumping  '],'fontsize',12)
            colormap(bwr)
            
            ii=find(track_jday==jdays(m));
            for pp=1:length(ii)
                ir = find(y(ii(pp))+.125 >= qlat(:,1) & y(ii(pp))-.125 <= qlat(:,1));
                ic = find(x(ii(pp))+.125 >= qlon(1,:) & x(ii(pp))-.125 <= qlon(1,:));
                rr=ir-40:ir+40;
                cr=ic-40:ic+40;
%                 if min(rr)>0 & max(rr)<length(qlat(:,1)) & min(cr)>0 & max(cr)<length(qlon(1,:))
                    scene_lat = qlat(rr,cr);
                    scene_lon = qlon(rr,cr);
                    obs=wek(rr,cr);
                    ndata=zgrid(double(scene_lon), ...
                        double(scene_lat), ...
                        double(x(ii(pp))), ...
                        double(y(ii(pp))), ...
                        double(obs), ...
                        double(scale(ii(pp))));
                    
                    if cyc(ii(pp))>0;
                        tcompaq(:,:,zzaq)=single(ndata);
                        zzaq=zzaq+1;
                        
                    else
                        tcompcq(:,:,zzcq)=single(ndata);
                        zzcq=zzcq+1;
                        
                    end
                    
                    obs=hp_wek_crlg_week(rr,cr);
                    ndata=zgrid(double(scene_lon), ...
                        double(scene_lat), ...
                        double(x(ii(pp))), ...
                        double(y(ii(pp))), ...
                        double(obs), ...
                        double(scale(ii(pp))));
                    
                    if cyc(ii(pp))>0;
                        tcompaa(:,:,zzaa)=single(ndata);
                        zzaa=zzaa+1;
                        
                    else
                        tcompca(:,:,zzca)=single(ndata);
                        zzca=zzca+1;
                        
                    end
%                 end
            end
            
            subplot(349)
            pcolor(xi,yi,double(nanmean(tcompaq,3)));
            hold on
            contour(xi,yi,nanmean(tcompaq,3),[-100:1:-1],'k--');
            contour(xi,yi,nanmean(tcompaq,3),[1:1:100],'k');
            shading flat;axis image;caxis([-15 15])
            xlabel('QSCAT')
            title('anticyclones')
            subplot(3,4,10)
            pcolor(xi,yi,double(nanmean(tcompcq,3)));
            hold on
            contour(xi,yi,nanmean(tcompcq,3),[-100:1:-1],'k--');
            contour(xi,yi,nanmean(tcompcq,3),[1:1:100],'k');
            shading flat;axis image;caxis([-15 15])
            xlabel('QSCAT')
            title('cyclones')
            
            subplot(3,4,11)
            pcolor(xi,yi,double(nanmean(tcompaa,3)));
            hold on
            contour(xi,yi,nanmean(tcompaa,3),[-100:1:-1],'k--');
            contour(xi,yi,nanmean(tcompaa,3),[1:1:100],'k');
            shading flat;axis image;caxis([-15 15])
            xlabel('AVISO')
            title('anticyclones')
            
            subplot(3,4,12)
            pcolor(xi,yi,double(nanmean(tcompca,3)));
            hold on
            contour(xi,yi,nanmean(tcompca,3),[-100:1:-1],'k--');
            contour(xi,yi,nanmean(tcompca,3),[1:1:100],'k');
            shading flat;axis image;caxis([-15 15])
            xlabel('AVISO')
            title('cyclones')
            
            
            
            
            eval(['print -dpng frames/EIO/frame_' num2str(ff) '.png'])
            ff=ff+1;
            clear hp_wek_crlg_week wek
        end
        %         close(aviobj);
        
        return
        
    case {'crl_wek_magt'}
        spath='~/data/QuickScat/new_mat/QSCAT_30_25km_';
        load([spath '2451556'],'lat','lon')
        qlat=lat;
        qlon=lon;
        load ~/data/eddy/V5/mat/AVISO_25_W_2451556 lat lon
        slat=lat;
        slon=lon;
        startjd=2452459;
        endjd=2454489;
        jdays=[startjd:7:endjd];
        load ~/matlab/domains/HAW_lat_lon.mat
        lat=15:30;
        lon=180:230;
        [r,c]=imap(min(lat),max(lat),min(lon),max(lon),qlat,qlon);
        [rs,cs]=imap(min(lat),max(lat),min(lon),max(lon),slat,slon);
        
        max_lat=max(lat(:));
        min_lat=min(lat(:));
        max_lon=max(lon(:));
        min_lon=min(lon(:));
        lat_step=5;
        lon_step=10;
        aviobj = VideoWriter('HAW_crl_wek.avi');
        
        aviobj.FrameRate=10;
        aviobj.Quality=100;
        open(aviobj)
        for m=1:length(jdays)
            load([spath num2str(jdays(m))],'hp_wek_crlg_week')
            load(['~/data/QuickScat/mat/QSCAT_30_25km_', num2str(jdays(m))],'strm_week')
            %hp_wek_crlg_week(abs(hp_wek_crlg_week)>50)=nan;
            load(['~/data/eddy/V5/mat/AVISO_25_W_',num2str(jdays(m))],'ssh')
            figure(1)
            clf
            rect = get(gcf,'Position');
            rect(1:2) = [0 0];
            fr=gcf;
            subplot(211)
            m_proj('Equidistant cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);
            m_pcolor(qlon(r,c),qlat(r,c),hp_wek_crlg_week(r,c))
            shading interp
            caxis([-20 20])
            hold on
            m_contour(slon(rs,cs),slat(rs,cs),ssh(rs,cs),[-100:3:-4],'k')
            m_contour(slon(rs,cs),slat(rs,cs),ssh(rs,cs),[4:3:100],'k')
            [year,month,day]=jd2jdate(jdays(m));
            m_coast('patch',[0 0 0]);
            grid
            m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick',[round(min_lat):lat_step:round(max_lat)],'tickdir','in','color','k','lineweight',1.5,'fontsize',20);
            
            title(['Eddy Surface Current-Induced Ekman Pumping  ' num2str(year) '-' num2str(month) '-' num2str(day) '  '],'fontsize',40)
            %             colorbar
            colormap(bwr)
            freezeColors
            subplot(212)
            str=smoothn(strm_week(r,c),50);
            m_proj('Equidistant cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);
            m_pcolor(qlon(r,c),qlat(r,c),str)
            shading interp
            caxis([.005 .3])
            %             hold on
            %             m_contour(slon(rs,cs),slat(rs,cs),ssh(rs,cs),[-100:3:-4],'k')
            %             m_contour(slon(rs,cs),slat(rs,cs),ssh(rs,cs),[4:3:100],'k')
            [year,month,day]=jd2jdate(jdays(m));
            m_coast('patch',[0 0 0]);
            grid
            m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick',[round(min_lat):lat_step:round(max_lat)],'tickdir','in','color','k','lineweight',1.5,'fontsize',20);
            
            title('Wind Stress Magnitude from QuikSCAT  ','fontsize',40)
            %             colorbar
            colormap(chelle)
            %             xlabel([num2str(m)])
            drawnow
            %             return
            writeVideo(aviobj,getframe(fr,rect));
            %        	eval(['print -dpng tmp/frame_' num2str(ff) '.png'])
            ff=ff+1;
            clear hp_wek_crlg_week str strm_week
        end
        close(aviobj);
        
        return
        
        
    case {'fixwek'}
        spath='~/data/QuickScat/new_mat/QSCAT_30_25km_';
        load([spath '2451556'],'lat','lon')
        qlat=lat;
        qlon=lon;
        load ~/data/eddy/V5/mat/AVISO_25_W_2451556 lat lon
        slat=lat;
        slon=lon;
        jdays=[2451388:7:2455147];
        load ~/matlab/domains/air-sea_car_lat_lon
        [r,c]=imap(min(lat),max(lat),min(lon),max(lon),qlat,qlon);
        [rs,cs]=imap(min(lat),max(lat),min(lon),max(lon),slat,slon);
        
        load ~/matlab/domains/HAW_lat_lon
        [r1,c1]=imap(min(lat),max(lat),min(lon),max(lon),qlat,qlon);
        [rs1,cs1]=imap(min(lat),max(lat),min(lon),max(lon),slat,slon);
        
        %     aviobj = VideoWriter('lw_crl_wek.avi');
        %
        %     aviobj.FrameRate=15;
        %     aviobj.Quality=100;
        % 	open(aviobj)
        for m=1:length(jdays)
            load([spath num2str(jdays(m))],'wek')
            tt=100*wek;
            tt(abs(tt)>50)=nan;
            load(['~/data/eddy/V5/mat/AVISO_25_W_',num2str(jdays(m))],'ssh')
            figure(1)
            clf
            rect = get(gcf,'Position');
            rect(1:2) = [0 0];
            fr=gcf;
            subplot(211)
            pmap(qlon(r,c),qlat(r,c),tt(r,c))
            caxis([-20 20])
            hold on
            m_contour(slon(rs,cs),slat(rs,cs),ssh(rs,cs),[-100:5:-2],'color', [.5 .5 .5])
            m_contour(slon(rs,cs),slat(rs,cs),ssh(rs,cs),[2:5:100],'k')
            [year,month,day]=jd2jdate(jdays(m));
            title(['W_E   ' num2str(year) '-' num2str(month) '-' num2str(day) '   ',num2str(jdays(m))])
            colorbar
            colormap(bwr)
            xlabel([num2str(jdays(m))])
            
            subplot(212)
            pmap(qlon(r1,c1),qlat(r1,c1),tt(r1,c1))
            caxis([-20 20])
            % 		hold on
            % 		m_contour(slon(rs,cs),slat(rs,cs),ssh(rs,cs),[-100:5:-2],'color', [.5 .5 .5])
            % 		m_contour(slon(rs,cs),slat(rs,cs),ssh(rs,cs),[2:5:100],'k')
            [year,month,day]=jd2jdate(jdays(m));
            colorbar
            colormap(bwr)
            drawnow
            pause(.1)
            %writeVideo(aviobj,getframe(fr,rect));
            eval(['print -dpng frames/tmp/frame_' num2str(ff) '.png'])
            ff=ff+1;
            clear wek
            clean_wek=tt;
            save([spath num2str(jdays(m))],'clean_wek','-append')
        end
        
        % 	 close(aviobj);
    case {'crl_wek'}
        spath='~/data/QuickScat/mat/QSCAT_30_25km_';
        load([spath '2451556'],'lat','lon')
        qlat=lat;
        qlon=lon;
        load ~/data/eddy/V5/mat/AVISO_25_W_2451556 lat lon
        slat=lat;
        slon=lon;
        jdays=[2451556:7:2454489];
        load ~/matlab/domains/lw_lat_lon
        [r,c]=imap(min(lat),max(lat),min(lon),max(lon),qlat,qlon);
        [rs,cs]=imap(min(lat),max(lat),min(lon),max(lon),slat,slon);
        
        %     aviobj = VideoWriter('lw_crl_wek.avi');
        %
        %     aviobj.FrameRate=15;
        %     aviobj.Quality=100;
        % 	open(aviobj)
        for m=1:length(jdays)
            load([spath num2str(jdays(m))],'hp_wek_crlg_week')
            %hp_wek_crlg_week(abs(hp_wek_crlg_week)>50)=nan;
            load(['~/data/eddy/V5/mat/AVISO_25_W_',num2str(jdays(m))],'ssh')
            figure(1)
            clf
            rect = get(gcf,'Position');
            rect(1:2) = [0 0];
            fr=gcf;
            pmap(qlon(r,c),qlat(r,c),hp_wek_crlg_week(r,c))
            caxis([-50 50])
            hold on
            m_contour(slon(rs,cs),slat(rs,cs),ssh(rs,cs),[-100:5:-2],'color', [.5 .5 .5])
            m_contour(slon(rs,cs),slat(rs,cs),ssh(rs,cs),[2:5:100],'k')
            [year,month,day]=jd2jdate(jdays(m));
            title(['W_E crlg  ' num2str(year) '-' num2str(month) '-' num2str(day) '   ',num2str(jdays(m))])
            colorbar
            colormap(bwr)
            xlabel([num2str(m)])
            drawnow
            pause(.1)
            %writeVideo(aviobj,getframe(fr,rect));
            eval(['print -dpng tmp/frame_' num2str(ff) '.png'])
            ff=ff+1;
            clear hp_wek_crlg_week
        end
        % 	 close(aviobj);
        
        
    case {'wekn'}
        spath='~/data/QuickScat/mat/QSCAT_30_25km_';
        load([spath '2454713'],'lat','lon')
        qlat=lat;
        qlon=lon;
        load ~/data/eddy/V5/mat/AVISO_25_W_2453530 lat lon
        slat=lat;
        slon=lon;
        jdays=[2451556:7:2454797];
        load ~/matlab/domains/air-sea_eio_lat_lon
        [r,c]=imap(min(lat),max(lat),min(lon),max(lon),qlat,qlon);
        [rs,cs]=imap(min(lat),max(lat),min(lon),max(lon),slat,slon);
        
        aviobj = VideoWriter('SIO_wek.avi');
        
        aviobj.FrameRate=15;
        aviobj.Quality=100;
        open(aviobj)
        for m=1:length(jdays)
            load([spath num2str(jdays(m))],'w_ek')
            load(['~/data/eddy/V5/mat/AVISO_25_W_',num2str(jdays(m))],'ssh')
            figure(1)
            clf
            rect = get(gcf,'Position');
            rect(1:2) = [0 0];
            fr=gcf;
            pmap(qlon(r,c),qlat(r,c),100*w_ek(r,c))
            caxis([-20 20])
            hold on
            m_contour(slon(rs,cs),slat(rs,cs),ssh(rs,cs),[-100:3:-2],'color', [.5 .5 .5])
            m_contour(slon(rs,cs),slat(rs,cs),ssh(rs,cs),[2:3:100],'k')
            [year,month,day]=jd2jdate(jdays(m));
            title(['W_E crlg  ' num2str(year) '-' num2str(month) '-' num2str(day) '   '])
            colorbar
            colormap(chelle)
            xlabel([num2str(m)])
            drawnow
            pause(.1)
            writeVideo(aviobj,getframe(fr,rect));
            clear w_ek
        end
        close(aviobj);
        
    case {'wspd'}
        spath='/matlab/data/QuickScat/mat/QSCAT_30_25km_';
        load([spath '2454713'],'lat','lon')
        qlat=lat;
        qlon=lon;
        load /matlab/data/eddy/V4/mat/AVISO_25_W_2453530 lat lon
        slat=lat;
        slon=lon;
        jdays=[2452459:7:2454489];
        load /matlab/matlab/domains/LW_lat_lon
        [r,c]=imap(min(lat),max(lat),min(lon),max(lon),qlat,qlon);
        [rs,cs]=imap(min(lat),max(lat),min(lon),max(lon),slat,slon);
        
        for m=160:length(jdays)
            load([spath num2str(jdays(m))],'sm_u_week','sm_v_week')
            figure(1)
            clf
            wspd=sqrt(sm_u_week.^2+sm_v_week.^2);
            
            pmap(qlon(r,c),qlat(r,c),wspd(r,c))
            caxis([5 25])
            hold on
            m_quiver(qlon(r(1:3:end),c(1:3:end)),qlat(r(1:3:end),c(1:3:end)),sm_u_week(r(1:3:end),c(1:3:end)),sm_v_week(r(1:3:end),c(1:3:end)))
            [year,month,day]=jd2jdate(jdays(m));
            title(['Smoothed WSDP ' num2str(year) '-' num2str(month) '-' num2str(day) '   '])
            caxis([5 25])
            colormap(chelle)
            colorbar
            eval(['print -dpng -r300 frame_' num2str(ff) '.png'])
            ff=ff+1;
            clear bp62_crl
        end
        
        
    case {'crls'}
        spath='/matlab/data/QuickScat/mat/QSCAT_30_25km_';
        load([spath '2454713'],'lat','lon')
        qlat=lat;
        qlon=lon;
        load /matlab/data/eddy/V4/mat/AVISO_25_W_2453530 lat lon
        slat=lat;
        slon=lon;
        jdays=[2452459:7:2454489];
        load /matlab/matlab/domains/HAW_lat_lon
        [r,c]=imap(min(lat),max(lat),min(lon),max(lon),qlat,qlon);
        [rs,cs]=imap(min(lat),max(lat),min(lon),max(lon),slat,slon);
        
        for m=50:length(jdays)
            load([spath num2str(jdays(m))],'bp26_crl_sst','w_ek','bp26_crl','hp_wek_crlg_week','hp_wek_sst_week_dtdn')
            load(['/matlab/data/eddy/V4/mat/AVISO_25_W_',num2str(jdays(m))],'ssh','bp26_crlg')
            figure(1)
            clf
            subplot(221)
            pmap(slon(rs,cs),slat(rs,cs),1e5*bp26_crlg(rs,cs))
            caxis([-1 1])
            hold on
            m_contour(slon(rs,cs),slat(rs,cs),ssh(rs,cs),[-100:10:-5],'color', [.5 .5 .5])
            m_contour(slon(rs,cs),slat(rs,cs),ssh(rs,cs),[5:10:100],'k')
            [year,month,day]=jd2jdate(jdays(m));
            title(['crlg  ' num2str(year) '-' num2str(month) '-' num2str(day) '   '])
            colorbar
            
            subplot(222)
            pmap(qlon(r,c),qlat(r,c),1e5*(bp26_crlg(rs,cs)-bp26_crl_sst(r,c)))
            caxis([-1 1])
            hold on
            m_contour(slon(rs,cs),slat(rs,cs),ssh(rs,cs),[-100:10:-2],'color', [.5 .5 .5])
            m_contour(slon(rs,cs),slat(rs,cs),ssh(rs,cs),[2:10:100],'k')
            [year,month,day]=jd2jdate(jdays(m));
            title(['crlg+crlSST  ' num2str(year) '-' num2str(month) '-' num2str(day) '   '])
            colormap(rwp)
            colorbar
            
            subplot(224)
            pmap(qlon(r,c),qlat(r,c),-1e5*bp26_crl(r,c))
            caxis([-1 1])
            hold on
            m_contour(slon(rs,cs),slat(rs,cs),ssh(rs,cs),[-100:10:-5],'color', [.5 .5 .5])
            m_contour(slon(rs,cs),slat(rs,cs),ssh(rs,cs),[5:10:100],'k')
            [year,month,day]=jd2jdate(jdays(m));
            title(['crl QSCAT  ' num2str(year) '-' num2str(month) '-' num2str(day) '   '])
            colormap(rwp)
            colorbar
            
            subplot(223)
            pmap(qlon(r,c),qlat(r,c),-1e5*bp26_crl_sst(r,c))
            caxis([-.2 .2])
            hold on
            m_contour(slon(rs,cs),slat(rs,cs),ssh(rs,cs),[-100:10:-5],'color', [.5 .5 .5])
            m_contour(slon(rs,cs),slat(rs,cs),ssh(rs,cs),[5:10:100],'k')
            [year,month,day]=jd2jdate(jdays(m));
            title(['crl SST  ' num2str(year) '-' num2str(month) '-' num2str(day) '   '])
            colormap(chelle)
            colorbar
            drawnow
            %eval(['print -dpng -r300 frame_' num2str(ff) '.png'])
            ff=ff+1;
            clear hp*
        end
        
        
    case {'crl'}
        spath='/matlab/data/QuickScat/mat/QSCAT_30_25km_';
        load([spath '2454713'],'lat','lon')
        qlat=lat;
        qlon=lon;
        load /matlab/data/eddy/V4/mat/AVISO_25_W_2453530 lat lon
        slat=lat;
        slon=lon;
        jdays=[2451556:7:2454797];
        load /matlab/matlab/domains/EK_lat_lon
        [r,c]=imap(min(lat),max(lat),min(lon),max(lon),qlat,qlon);
        [rs,cs]=imap(min(lat),max(lat),min(lon),max(lon),slat,slon);
        
        for m=1:length(jdays)
            load([spath num2str(jdays(m))],'w_ek','bp26_crl')
            load(['/matlab/data/eddy/V4/mat/AVISO_25_W_',num2str(jdays(m))],'ssh')
            figure(1)
            clf
            subplot(211)
            pmap(qlon(r,c),qlat(r,c),1e5*bp26_crl(r,c))
            caxis([-1.5 1.5])
            hold on
            m_contour(slon(rs,cs),slat(rs,cs),ssh(rs,cs),[-100:2:-2],'color', [.5 .5 .5])
            m_contour(slon(rs,cs),slat(rs,cs),ssh(rs,cs),[2:2:100],'k')
            [year,month,day]=jd2jdate(jdays(m));
            title(['25km Wind Curl 6x6 and 2x2  ' num2str(year) '-' num2str(month) '-' num2str(day) '   '])
            colormap(rwp)
            colorbar
            subplot(212)
            pmap(qlon(r,c),qlat(r,c),w_ek(r,c))
            caxis([-.3 .3])
            hold on
            m_contour(slon(rs,cs),slat(rs,cs),ssh(rs,cs),[-100:2:-2],'color', [.5 .5 .5])
            m_contour(slon(rs,cs),slat(rs,cs),ssh(rs,cs),[2:2:100],'k')
            [year,month,day]=jd2jdate(jdays(m));
            title(['25km W_E 6x6 and 2x2  ' num2str(year) '-' num2str(month) '-' num2str(day) '   '])
            colormap(rwp)
            colorbar
            eval(['print -dpng -r300 frame_' num2str(ff) '.png'])
            eval(['!convert -trim frame_' num2str(ff) '.png frame_' num2str(ff) ...
                '.png'])
            ff=ff+1;
            clear bp62_crl
        end
        !ffmpeg -r 5 -sameq -s hd1080 -i frame_%d.png -y out.mp4
        
        
    case {'ant'}
        cd /matlab/matlab/anti/frames
        spath='/matlab/data/QuickScat/mat/anti_no_ice_';
        load /matlab/matlab/anti/mat/lat_lon
        jdays=2454102:2454466;
        for m=1:length(jdays)-1
            if exist([spath num2str(jdays(m)) '.mat'])
                load([spath num2str(jdays(m))],'Dwspd','Du','Dv','Dstrm','cwspd')
                figure(197)
                clf
                pmap(lon,lat,Dwspd,'stereo')
                hold on
                %m_quiver(lon,lat,Du,Dv)
                caxis([0 25])
                [year,month,day]=jd2jdate(jdays(m));
                title([{'Daily Avg Wind Speed  [m s  ^{-2}]   '},{[num2str(year) '-' num2str(month) '-' num2str(day) '   ']}])
                colormap(chelle)
                eval(['print -dpng -r300 Dwspd/frame_' num2str(ff) '.png'])
                
                figure(190)
                clf
                pmap(lon,lat,cwspd,'stereo')
                hold on
                %m_quiver(lon,lat,Du,Dv)
                caxis([0 6])
                [year,month,day]=jd2jdate(jdays(m));
                title([{'Number of Observations in Daily Averaged Product   '},{[num2str(year) '-' num2str(month) '-' num2str(day) '   ']}])
                colormap(chelle)
                eval(['print -dpng -r300 Cwspd/frame_' num2str(ff) '.png'])
                max(cwspd(:))
                figure(198)
                clf
                pmap(lon,lat,Dstrm,'stereo')
                hold on
                %m_quiver(lon,lat,Du,Dv)
                caxis([0 .4])
                [year,month,day]=jd2jdate(jdays(m));
                title([{'Daily Avg Wind Stress Magnitude [N m  ^{-2}]  '},{[num2str(year) '-' num2str(month) '-' num2str(day) '   ']}])
                colormap(chelle)
                eval(['print -dpng -r300 Dstrm/frame_' num2str(ff) '.png'])
                %eval(['!convert -trim frame_' num2str(ff) '.png frame_' num2str(ff) ...
                %      '.png'])
                ff=ff+1;
            end
        end
        !ffmpeg -i Dstrm/frame_%d.png -y Dstrm/Dstrm_low.mpg
        !ffmpeg -i Dwspd/frame_%d.png -y Dwspd/Dwspd_low.mpg
        !ffmpeg -i Cwspd/frame_%d.png -y Cwspd/Cwspd_low.mpg
    case {'wek'}
        spath='/matlab/data/QuickScat/mat/QSCAT_30_25km_';
        load([spath '2454713'],'lat','lon')
        qlat=lat;
        qlon=lon;
        load /matlab/data/eddy/V4/mat/AVISO_25_W_2453530 lat lon
        slat=lat;
        slon=lon;
        jdays=[2451556:7:2454797];
        load /matlab/matlab/domains/GLOBAL_lat_lon
        [r,c]=imap(min(lat),max(lat),min(lon),max(lon),qlat,qlon);
        [rs,cs]=imap(min(lat),max(lat),min(lon),max(lon),slat,slon);
        
        %[r,c]=imap(-60,60,0,360,lat,lon);
        for m=1:length(jdays)
            load([spath num2str(jdays(m))],'w_ek')
            load(['/matlab/data/eddy/V4/mat/AVISO_25_W_',num2str(jdays(m))],'ssh')
            figure(1)
            clf
            pmap(qlon(r,c),qlat(r,c),w_ek(r,c))
            caxis([-.3 .3])
            hold on
            m_contour(slon(rs,cs),slat(rs,cs),ssh(rs,cs),[-7 -5],'color', [.5 .5 .5])
            m_contour(slon(rs,cs),slat(rs,cs),ssh(rs,cs),[5 7],'k')
            [year,month,day]=jd2jdate(jdays(m));
            title(['25km Ekman Pumping 6x6 and 2x2  ' num2str(year) '-' num2str(month) '-' num2str(day) '   '])
            colormap(rwp)
            eval(['print -dpng -r300 frame_' num2str(ff) '.png'])
            eval(['!convert -trim frame_' num2str(ff) '.png frame_' num2str(ff) ...
                '.png'])
            ff=ff+1;
            clear bp62_crl
        end
        !ffmpeg -r 5 -sameq -s hd1080 -i frame_%d.png -y out.mp4
    case {'wek_wek_nl'}
        ff=1;
        jdays=[2451556:7:2454797];
        
        
        warning('off','all')
        figure(1)
        load //matlab/matlab/domains/LW_lat_lon.mat
        max_lat=max(lat(:));
        min_lat=min(lat(:));
        max_lon=max(lon(:));
        min_lon=min(lon(:));
        load //matlab/data/eddy/V4/mat/AVISO_25_W_2453530 lat lon
        slat=interp2(lat);
        slon=interp2(lon);
        rssh=find(slat(:,1)>=min_lat & slat(:,1)<=max_lat);
        cssh=find(slon(1,:)>=min_lon & slon(1,:)<=max_lon);
        load //matlab/data/QuickScat/new_mat/QSCAT_30_25km_2452606 lat lon hp66_crl
        lat=interp2(lat);
        lon=interp2(lon);
        r=find(lat(:,1)>=min_lat & lat(:,1)<=max_lat);
        c=find(lon(1,:)>=min_lon & lon(1,:)<=max_lon);
        
        
        
        
        for m=1:length(jdays)
            clf
            [yea,mon,day]=jd2jdate(jdays(m));
            dd=(yea*1000)+julian(mon,day,yea,yea)
            
            subplot(211)
            load(['//matlab/data/QuickScat/new_mat/QSCAT_30_25km_',num2str(jdays(m))],'w_ek')
            w_ek=interp2(w_ek);
            w_ek_nl=interp2(w_ek_nl);
            load(['//matlab/data/eddy/V4/mat/AVISO_25_W_',num2str(jdays(m))],'mask','hp66_crlg','ssh')
            ssh=interp2(ssh);
            pmap(lon(r,c),lat(r,c),w_ek(r,c),'crlhp',num2str(dd))
            title(['Ekman Pumping  [-.25 .25] m day^{-1}   ' num2str(yea) '-' num2str(mon) '-' num2str(day) '  '])
            hold on
            m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[-80:4:-2],'color', [.5 .5 .5])
            m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[2:4:80],'k')
            shading flat
            caxis([-.25 .25])
            m_coast('patch',[0 0 0],'edgecolor','k');
            %cc=colorbar;
            %axes(cc)
            %set(cc,'yaxislocation','right')
            %ylabel('ms^{-1} per 100 km')
            
            
            %{
subplot(211)
%[u,v]=geostro(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh)./100,.25);
%crl = dfdx(v,slat(rssh,cssh),.25)-dfdy(u,.25);
pmap(lon(r,c),lat(r,c),hp66_crl_21(r,c).*1e5,'crlhp',num2str(dd))
title(['BP Filtered Surface Vorticity (crl) with contours of SSH   '])
hold on
m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[-80:2:-2],'color', [.5 .5 .5])
m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[2:2:80],'k')
shading flat
caxis([-2 2])
m_coast('patch',[0 0 0],'edgecolor','k')
cc=colorbar;
axes(cc)
set(cc,'yaxislocation','right')
ylabel('ms^{-1} per 100 km')
            %}
            
            
            subplot(212)
            %[u,v]=geostro(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh)./100,.25);
            %crl = dfdx(v,slat(rssh,cssh),.25)-dfdy(u,.25);
            mask=nan*w_ek_nl(r,c);
            mask(abs(w_ek_nl(r,c))<=10)=1;
            pmap(lon(r,c),lat(r,c),w_ek_nl(r,c).*mask,'crlhp',num2str(dd))
            title(['Nonlinear Ekman Pumping  [-5 5] m day^{-1}   '])
            hold on
            m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[-80:4:-2],'color', [.5 .5 .5])
            m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[2:4:80],'k')
            shading flat
            caxis([-5 5])
            m_coast('patch',[0 0 0],'edgecolor','k')
            colormap(bwr)
            %cc=colorbar;
            %axes(cc)
            %set(cc,'yaxislocation','right')
            %ylabel('ms^{-1} per 100 km')
            
            eval(['print -dpng frame_' num2str(ff) '.png'])
            %eval(['!convert -trim frame_' num2str(ff) '.png frame_' num2str(ff) ...
            %      '.png'])
            ff=ff+1;
        end
        
        
        
    case {'crlg_track_id'}
        ff=1;
        jdays=[2451395:7:2454811];
        
        
        warning('off','all')
        figure(1)
        load //matlab/matlab/domains/LW_lat_lon.mat
        max_lat=max(lat(:));
        min_lat=min(lat(:));
        max_lon=max(lon(:));
        min_lon=min(lon(:));
        load //matlab/data/eddy/V4/mat/AVISO_25_W_2453530 lat lon
        slat=interp2(lat);
        slon=interp2(lon);
        rssh=find(slat(:,1)>=min_lat & slat(:,1)<=max_lat);
        cssh=find(slon(1,:)>=min_lon & slon(1,:)<=max_lon);
        load //matlab/data/eddy/V4/cLW_lat_lon_tracks.mat
        
        
        
        
        
        
        for m=1:length(jdays)
            clf
            [yea,mon,day]=jd2jdate(jdays(m));
            dd=(yea*1000)+julian(mon,day,yea,yea)
            
            load(['//matlab/data/eddy/V4/mat/AVISO_25_W_',num2str(jdays(m))],'mask','hp66_crlg','ssh')
            hp66_crlg=interp2(hp66_crlg);
            pmap(slon(rssh,cssh),slat(rssh,cssh),hp66_crlg(rssh,cssh).*1e5,'crlg',num2str(dd))
            title(['HP Filtered Geostprhic Vorticity 6x6 (crlg)  ' num2str(yea) '-' num2str(mon) '-' num2str(day) '  '])
            hold on
            shading flat
            caxis([-.7 .7])
            p=find(track_jday<=jdays(m));
            d=find(track_jday==jdays(m));
            m_plot(x(d),y(d),'ko','markerfacecolor', ...
                'k','markersize',4,'clip','off');
            m_text(x(d),y(d),num2str(id(d)),'fontsize',14,'fontweight','bold');
            tmp_ids=id(d);
            time_ids=id(p);
            time_xs=x(p);
            time_ys=y(p);
            for b=1:length(tmp_ids)
                tmp=tmp_ids(b);
                e=find(time_ids==tmp);
                if tmp>=nneg
                    h=m_plot(time_xs(e),time_ys(e),'k','linewidth',2);
                    set(h,'clipping','off')
                else
                    h=m_plot(time_xs(e),time_ys(e),'k','linewidth',2);
                    set(h,'clipping','off')
                end
            end
            m_coast('patch',[0 0 0],'edgecolor','k')
            colormap(jet)
            cc=colorbar;
            axes(cc)
            set(cc,'yaxislocation','right')
            ylabel('ms^{-1} per 100 km')
            
            eval(['print -dpng frame_' num2str(ff) '.png'])
            %eval(['!convert -trim frame_' num2str(ff) '.png frame_' num2str(ff) ...
            %      '.png'])
            ff=ff+1;
        end
        
    case {'wspd_21'}
        ff=1;
        
        
        jdays=[2451395:7:2454811];
        
        [year,month,day]=jd2jdate(jdays);
        
        
        warning('off','all')
        figure(1)
        load //matlab/matlab/domains/LW_lat_lon.mat
        max_lat=max(lat(:));
        min_lat=min(lat(:));
        max_lon=max(lon(:));
        min_lon=min(lon(:));
        load //matlab/data/eddy/V4/mat/AVISO_25_W_2453530 lat lon
        slat=interp2(lat);
        slon=interp2(lon);
        rssh=find(slat(:,1)>=min_lat & slat(:,1)<=max_lat);
        cssh=find(slon(1,:)>=min_lon & slon(1,:)<=max_lon);
        eval(['load //matlab/data/QuickScat/new_mat/QSCAT_21_25km_' num2str(jdays(1)) ' lat lon crl_21'])
        %[lon,lat]=meshgrid(lon,lat);
        lat=interp2(lat);
        lon=interp2(lon);
        r=find(lat(:,1)>=min_lat & lat(:,1)<=max_lat);
        c=find(lon(1,:)>=min_lon & lon(1,:)<=max_lon);
        
        
        
        
        for m=1:length(jdays)
            clf
            [yea,mon,day]=jd2jdate(jdays(m));
            dd=(yea*1000)+julian(mon,day,yea,yea)
            
            load(['//matlab/data/QuickScat/new_mat/QSCAT_21_25km_',num2str(jdays(m))],'crl_21','wspd_21')
            crl_21=interp2(crl_21);
            wspd_21=interp2(wspd_21);
            pmap(lon(r,c),lat(r,c),wspd_21(r,c),'crlhp',num2str(dd))
            title(['New wspd_21  ' num2str(yea) '-' num2str(mon) '-' num2str(day) '  '])
            shading flat
            caxis([5 15])
            m_coast('patch',[0 0 0],'edgecolor','k');
            cc=colorbar;
            axes(cc)
            set(cc,'yaxislocation','right')
            ylabel('ms^{-1}')
            
            eval(['print -dpng frame_' num2str(ff) '.png'])
            eval(['!convert -trim frame_' num2str(ff) '.png frame_' num2str(ff) ...
                '.png'])
            ff=ff+1;
        end
        
    case {'crl'}
        ff=1;
        
        jdays=[2451395:7:2454811];
        
        [year,month,day]=jd2jdate(jdays);
        
        
        warning('off','all')
        figure(1)
        load //matlab/matlab/domains/LW_lat_lon.mat
        max_lat=max(lat(:));
        min_lat=min(lat(:));
        max_lon=max(lon(:));
        min_lon=min(lon(:));
        load //matlab/data/eddy/V4/mat/AVISO_25_W_2453530 lat lon
        slat=interp2(lat);
        slon=interp2(lon);
        rssh=find(slat(:,1)>=min_lat & slat(:,1)<=max_lat);
        cssh=find(slon(1,:)>=min_lon & slon(1,:)<=max_lon);
        eval(['load //matlab/data/QuickScat/new_mat/QSCAT_21_25km_' num2str(jdays(1)) ' lat lon crl_21'])
        %[lon,lat]=meshgrid(lon,lat);
        lat=interp2(lat);
        lon=interp2(lon);
        r=find(lat(:,1)>=min_lat & lat(:,1)<=max_lat);
        c=find(lon(1,:)>=min_lon & lon(1,:)<=max_lon);
        
        
        
        for m=1:length(jdays)
            clf
            [yea,mon,day]=jd2jdate(jdays(m));
            dd=(yea*1000)+julian(mon,day,yea,yea)
            
            load(['//matlab/data/QuickScat/new_mat/QSCAT_21_25km_',num2str(jdays(m))],'hp66_crl','wspd_21')
            crl_21=interp2(crl_21);
            wspd_21=interp2(wspd_21);
            pmap(lon(r,c),lat(r,c),crl_21(r,c).*1e5,'crlhp',num2str(dd))
            title(['New crl_21  ' num2str(yea) '-' num2str(mon) '-' num2str(day) '  '])
            shading flat
            caxis([-2.5 2.5])
            m_coast('patch',[0 0 0],'edgecolor','k');
            cc=colorbar;
            axes(cc)
            set(cc,'yaxislocation','right')
            ylabel('ms^{-1}')
            
            eval(['print -dpng frame_' num2str(ff) '.png'])
            eval(['!convert -trim frame_' num2str(ff) '.png frame_' num2str(ff) ...
                '.png'])
            ff=ff+1;
        end
        
    case {'crl_multi'}
        ff=1;
        
        jdays=[2451395:7:2452248];
        
        [year,month,day]=jd2jdate(jdays);
        
        
        warning('off','all')
        figure(1)
        load //matlab/matlab/domains/LW_lat_lon.mat
        max_lat=max(lat(:));
        min_lat=min(lat(:));
        max_lon=max(lon(:));
        min_lon=min(lon(:));
        load //matlab/data/eddy/V4/mat/AVISO_25_W_2453530 lat lon
        slat=interp2(lat);
        slon=interp2(lon);
        rssh=find(slat(:,1)>=min_lat & slat(:,1)<=max_lat);
        cssh=find(slon(1,:)>=min_lon & slon(1,:)<=max_lon);
        eval(['load //matlab/data/QuickScat/new_mat/QSCAT_21_25km_' num2str(jdays(1)) ' lat lon hp66_crl_21'])
        %[lon,lat]=meshgrid(lon,lat);
        lat=interp2(lat);
        lon=interp2(lon);
        r=find(lat(:,1)>=min_lat & lat(:,1)<=max_lat);
        c=find(lon(1,:)>=min_lon & lon(1,:)<=max_lon);
        
        
        
        
        for m=1:length(jdays)
            clf
            [yea,mon,day]=jd2jdate(jdays(m));
            dd=(yea*1000)+julian(mon,day,yea,yea)
            
            subplot(212)
            load(['//matlab/data/eddy/V4/mat/AVISO_25_W_',num2str(jdays(m))],'mask','hp66_crlg','ssh')
            load(['//matlab/data/QuickScat/new_mat/QSCAT_21_25km_',num2str(jdays(m))],'hp66_crl','hp66_crl_ss','wspd_21')
            hp66_crl_ss=interp2(hp66_crl_ss);
            hp66_crl=interp2(hp66_crl);
            wspd_21=interp2(wspd_21);
            hp66_crlg=interp2(hp66_crlg);
            ssh=interp2(ssh);
            mask=interp2(mask);
            mask(isnan(mask))=0;
            %{
pmap(lon(r,c),lat(r,c),wspd_21(r,c),'crlhp',num2str(dd))
title(['New Wspd  ' num2str(yea) '-' num2str(mon) '-' num2str(day) '  '])
%hold on
%m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[-80:4:-2],'color', [.5 .5 .5])
%m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[2:4:80],'k')
shading flat
caxis([0 15])
m_coast('patch',[0 0 0],'edgecolor','k');
cc=colorbar;
axes(cc)
set(cc,'yaxislocation','right')
ylabel('ms^{-1}')
            %}
            
            subplot(211)
            pmap(lon(r,c),lat(r,c),-hp66_crl_ss(r,c).*1e5,'crlhp',num2str(dd))
            title(['New -crl  ' num2str(yea) '-' num2str(mon) '-' num2str(day) '  '])
            %hold on
            %m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[-80:4:-2],'color', [.5 .5 .5])
            %m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[2:4:80],'k')
            shading flat
            caxis([-2 2])
            m_coast('patch',[0 0 0],'edgecolor','k');
            cc=colorbar;
            axes(cc)
            set(cc,'yaxislocation','right')
            ylabel('ms^{-1} per 100 km')
            
            subplot(212)
            %load(['//matlab/data/QuickScat/new_mat/QSCAT_21_25km_',num2str(jdays(m))],'hp66_crl_21')
            %[u,v]=geostro(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh)./100,.25);
            %crl = dfdx(v,slat(rssh,cssh),.25)-dfdy(u,.25);
            pmap(slon(rssh,cssh),slat(rssh,cssh),hp66_crlg(rssh,cssh).*1e5,'crlg',num2str(dd))
            title(['BP Filtered Geostrophic Vorticity (crlg)  '])
            hold on
            m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[-80:4:-2],'color', [.5 .5 .5])
            m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[2:4:80],'k')
            shading flat
            caxis([-1.5 1.5])
            m_coast('patch',[0 0 0],'edgecolor','k')
            colormap(jet)
            cc=colorbar;
            axes(cc)
            set(cc,'yaxislocation','right')
            ylabel('ms^{-1} per 100 km')
            
            eval(['print -dpng frame_' num2str(ff) '.png'])
            eval(['!convert -trim frame_' num2str(ff) '.png frame_' num2str(ff) ...
                '.png'])
            ff=ff+1;
        end
        !ffmpeg -r 5 -sameq -s hd1080 -i frame_%d.png -y lw_crln_crlo.mp4
        
    case {'crlold_crlnew'}
        ff=1;
        
        jdays=[2451394:2452248];
        
        [year,month,day]=jd2jdate(jdays);
        
        
        warning('off','all')
        figure(1)
        load //matlab/matlab/domains/LW_lat_lon.mat
        max_lat=max(lat(:));
        min_lat=min(lat(:));
        max_lon=max(lon(:));
        min_lon=min(lon(:));
        load //matlab/data/eddy/V4/mat/AVISO_25_W_2453530 lat lon
        slat=interp2(lat);
        slon=interp2(lon);
        rssh=find(slat(:,1)>=min_lat & slat(:,1)<=max_lat);
        cssh=find(slon(1,:)>=min_lon & slon(1,:)<=max_lon);
        load //matlab/data/QuickScat/mat/QSCAT_21_25km_2452606 lat lon hp66_crl_21
        [lon,lat]=meshgrid(lon,lat);
        lat=interp2(lat);
        lon=interp2(lon);
        r=find(lat(:,1)>=min_lat & lat(:,1)<=max_lat);
        c=find(lon(1,:)>=min_lon & lon(1,:)<=max_lon);
        
        
        
        
        for m=1:length(jdays)
            clf
            [yea,mon,day]=jd2jdate(jdays(m));
            dd=(yea*1000)+julian(mon,day,yea,yea)
            
            subplot(212)
            load(['//matlab/data/QuickScat/mat/QSCAT_21_25km_',num2str(jdays(m))],'hp66_crl_21')
            hp66_crl_21=interp2(hp66_crl_21);
            load(['//matlab/data/eddy/V4/mat/AVISO_25_W_',num2str(jdays(m))],'mask','hp66_crlg','ssh')
            hp66_crlg=interp2(hp66_crlg);
            ssh=interp2(ssh);
            mask=interp2(mask);
            mask(isnan(mask))=0;
            pmap(lon(r,c),lat(r,c),hp66_crl_21(r,c).*1e5.*mask(rssh,cssh),'crlhp',num2str(dd))
            title(['Old crl  ' num2str(yea) '-' num2str(mon) '-' num2str(day) '  '])
            %hold on
            %m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[-80:4:-2],'color', [.5 .5 .5])
            %m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[2:4:80],'k')
            shading flat
            caxis([-2 2])
            m_coast('patch',[0 0 0],'edgecolor','k');
            cc=colorbar;
            axes(cc)
            set(cc,'yaxislocation','right')
            ylabel('ms^{-1} per 100 km')
            
            
            subplot(211)
            load(['//matlab/data/QuickScat/new_mat/QSCAT_21_25km_',num2str(jdays(m))],'hp66_crl_21')
            hp66_crl_21=interp2(hp66_crl_21);
            ssh=interp2(ssh);
            mask=interp2(mask);
            mask(isnan(mask))=0;
            pmap(lon(r,c),lat(r,c),hp66_crl_21(r,c).*1e5.*mask(rssh,cssh),'crlhp',num2str(dd))
            title(['New crl  ' num2str(yea) '-' num2str(mon) '-' num2str(day) '  '])
            %hold on
            %m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[-80:4:-2],'color', [.5 .5 .5])
            %m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[2:4:80],'k')
            shading flat
            caxis([-2 2])
            m_coast('patch',[0 0 0],'edgecolor','k');
            cc=colorbar;
            axes(cc)
            set(cc,'yaxislocation','right')
            ylabel('ms^{-1} per 100 km')
            
            %{
subplot(211)
%[u,v]=geostro(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh)./100,.25);
%crl = dfdx(v,slat(rssh,cssh),.25)-dfdy(u,.25);
pmap(lon(r,c),lat(r,c),hp66_crl_21(r,c).*1e5,'crlhp',num2str(dd))
title(['BP Filtered Surface Vorticity (crl) with contours of SSH   '])
hold on
m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[-80:2:-2],'color', [.5 .5 .5])
m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[2:2:80],'k')
shading flat
caxis([-2 2])
m_coast('patch',[0 0 0],'edgecolor','k')
cc=colorbar;
axes(cc)
set(cc,'yaxislocation','right')
ylabel('ms^{-1} per 100 km')



subplot(212)
load(['//matlab/data/QuickScat/new_mat/QSCAT_21_25km_',num2str(jdays(m))],'hp66_crl_21')
%[u,v]=geostro(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh)./100,.25);
%crl = dfdx(v,slat(rssh,cssh),.25)-dfdy(u,.25);
pmap(slon(rssh,cssh),slat(rssh,cssh),-hp66_crlg(rssh,cssh).*1e5.*mask(rssh,cssh),'crlg',num2str(dd))
title(['BP Filtered Geostrophic Vorticity (-crlg)  '])
%hold on
%m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[-80:4:-2],'color', [.5 .5 .5])
%m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[2:4:80],'k')
shading flat
caxis([-2 2])
m_coast('patch',[0 0 0],'edgecolor','k')
colormap(jet)
cc=colorbar;
axes(cc)
set(cc,'yaxislocation','right')
ylabel('ms^{-1} per 100 km')
            %}
            eval(['print -dpng frame_' num2str(ff) '.png'])
            eval(['!convert -trim frame_' num2str(ff) '.png frame_' num2str(ff) ...
                '.png'])
            ff=ff+1;
        end
        !ffmpeg -r 5 -sameq -s hd1080 -i frame_%d.png -y lw_crln_crlo.mp4
        
    case {'chl_ssh'}
        ff=1;
        jdays=[2452459:7:2454804];
        
        warning('off','all')
        figure(1)
        load //matlab/matlab/domains/LW_lat_lon.mat
        max_lat=max(lat(:));
        min_lat=min(lat(:));
        max_lon=max(lon(:));
        min_lon=min(lon(:));
        load //matlab/data/eddy/V4/mat/AVISO_25_W_2453530 lat lon
        slat=interp2(lat);
        slon=interp2(lon);
        rssh=find(slat(:,1)>=min_lat & slat(:,1)<=max_lat);
        cssh=find(slon(1,:)>=min_lon & slon(1,:)<=max_lon);
        load //data2/data/modisa/CHL_4_W_2453530 lat lon chl_anom
        clat=lat;
        clon=lon;
        rchl=find(clat(:,1)>=min_lat & clat(:,1)<=max_lat);
        cchl=find(clon(1,:)>=min_lon & clon(1,:)<=max_lon);
        load //matlab/data/QuickScat/mat/QSCAT_21_25km_2452606 lat lon hp66_crl_21
        [lon,lat]=meshgrid(lon,lat);
        lat=interp2(lat);
        lon=interp2(lon);
        r=find(lat(:,1)>=min_lat & lat(:,1)<=max_lat);
        c=find(lon(1,:)>=min_lon & lon(1,:)<=max_lon);
        
        
        
        
        for m=1:length(jdays)
            clf
            [yea,mon,day]=jd2jdate(jdays(m));
            dd=(yea*1000)+julian(mon,day,yea,yea)
            
            load(['//data2/data/modisa/CHL_4_W_',num2str(jdays(m))],'chl_week')
            load(['//matlab/data/eddy/V4/mat/AVISO_25_W_',num2str(jdays(m))],'mask','hp66_crlg','ssh')
            pmap(clon(rchl,cchl),clat(rchl,cchl),chl_week(rchl,cchl),'logmchl')
            title(['MODIS Chl overlaid with SSH contours  ' num2str(yea) '-' num2str(mon) '-' num2str(day) '  '])
            hold on
            m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[-80:4:-2],'color', [.5 .5 .5])
            m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[2:4:80],'k')
            shading flat
            caxis([-1 1])
            m_coast('patch',[0 0 0],'edgecolor','k');
            
            
            eval(['print -dpng frame_' num2str(ff) '.png'])
            %eval(['!convert -trim frame_' num2str(ff) '.png frame_' num2str(ff) ...
            %      '.png'])
            ff=ff+1;
        end
        !ffmpeg -r 5 -sameq -s hd1080 -i frame_%d.png -y lw_crlhp_crlg.mp4
        
    case {'crl_crlg'}
        ff=1;
        jdays=[2452361:7:2453306];
        
        
        warning('off','all')
        figure(1)
        load //matlab/matlab/domains/LW_lat_lon.mat
        max_lat=max(lat(:));
        min_lat=min(lat(:));
        max_lon=max(lon(:));
        min_lon=min(lon(:));
        load //matlab/data/eddy/V4/mat/AVISO_25_W_2453530 lat lon
        slat=interp2(lat);
        slon=interp2(lon);
        rssh=find(slat(:,1)>=min_lat & slat(:,1)<=max_lat);
        cssh=find(slon(1,:)>=min_lon & slon(1,:)<=max_lon);
        load //matlab/data/QuickScat/new_mat/QSCAT_21_25km_2452606 lat lon hp66_crl
        lat=interp2(lat);
        lon=interp2(lon);
        r=find(lat(:,1)>=min_lat & lat(:,1)<=max_lat);
        c=find(lon(1,:)>=min_lon & lon(1,:)<=max_lon);
        
        
        
        
        for m=1:length(jdays)
            clf
            [yea,mon,day]=jd2jdate(jdays(m));
            dd=(yea*1000)+julian(mon,day,yea,yea)
            
            subplot(211)
            load(['//matlab/data/QuickScat/new_mat/QSCAT_21_25km_',num2str(jdays(m))],'bp62_crl')
            hp66_crl=interp2(bp62_crl);
            load(['//matlab/data/eddy/V4/mat/AVISO_25_W_',num2str(jdays(m))],'mask','hp66_crlg','ssh')
            hp66_crlg=interp2(hp66_crlg);
            ssh=interp2(ssh);
            mask=interp2(mask);
            mask(isnan(mask))=0;
            pmap(lon(r,c),lat(r,c),-hp66_crl(r,c).*1e5,'crlhp',num2str(dd))
            title(['BP Filtered Wind Vorticity 6x6 and 1.5x1.5 (-crl)  ' num2str(yea) '-' num2str(mon) '-' num2str(day) '  '])
            hold on
            m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[-80:4:-2],'color', [.5 .5 .5])
            m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[2:4:80],'k')
            shading flat
            caxis([-1 1])
            m_coast('patch',[0 0 0],'edgecolor','k');
            %cc=colorbar;
            %axes(cc)
            %set(cc,'yaxislocation','right')
            %ylabel('ms^{-1} per 100 km')
            
            
            %{
subplot(211)
%[u,v]=geostro(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh)./100,.25);
%crl = dfdx(v,slat(rssh,cssh),.25)-dfdy(u,.25);
pmap(lon(r,c),lat(r,c),hp66_crl_21(r,c).*1e5,'crlhp',num2str(dd))
title(['BP Filtered Surface Vorticity (crl) with contours of SSH   '])
hold on
m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[-80:2:-2],'color', [.5 .5 .5])
m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[2:2:80],'k')
shading flat
caxis([-2 2])
m_coast('patch',[0 0 0],'edgecolor','k')
cc=colorbar;
axes(cc)
set(cc,'yaxislocation','right')
ylabel('ms^{-1} per 100 km')
            %}
            
            
            subplot(212)
            %[u,v]=geostro(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh)./100,.25);
            %crl = dfdx(v,slat(rssh,cssh),.25)-dfdy(u,.25);
            pmap(slon(rssh,cssh),slat(rssh,cssh),hp66_crlg(rssh,cssh).*1e5,'crlg',num2str(dd))
            title(['HP Filtered Geostrophic Vorticity 6x6 (crlg)  '])
            hold on
            m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[-80:4:-2],'color', [.5 .5 .5])
            m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[2:4:80],'k')
            shading flat
            caxis([-1 1])
            m_coast('patch',[0 0 0],'edgecolor','k')
            colormap(jet)
            %cc=colorbar;
            %axes(cc)
            %set(cc,'yaxislocation','right')
            %ylabel('ms^{-1} per 100 km')
            
            eval(['print -dpng frame_' num2str(ff) '.png'])
            %eval(['!convert -trim frame_' num2str(ff) '.png frame_' num2str(ff) ...
            %      '.png'])
            ff=ff+1;
        end
        
    case {'crl_test'}
        ff=1;
        startyear = 2002;
        startmonth = 7;
        startday = 3;
        
        endyear = 2008;
        endmonth = 1;
        endday = 03;
        
        %construct date vector
        startjd=date2jd(startyear,startmonth,startday)+.5;
        endjd=date2jd(endyear,endmonth,endday)+.5;
        jdays=[startjd:7:endjd];
        [year,month,day]=jd2jdate(jdays);
        
        
        warning('off','all')
        figure(1)
        load //matlab/matlab/domains/LW_lat_lon.mat
        max_lat=max(lat(:));
        min_lat=min(lat(:));
        max_lon=max(lon(:));
        min_lon=min(lon(:));
        load //matlab/data/QuickScat/mat/QSCAT_W_25km_2452606 lat lon hp66_crl
        r=find(lat>=min_lat & lat<=max_lat);
        c=find(lon>=min_lon & lon<=max_lon);
        load //matlab/data/rand/RAND_W_2452459 lat lon
        slat=lat;
        slon=lon;
        rssh=find(slat(:,1)>=min_lat & slat(:,1)<=max_lat);
        cssh=find(slon(1,:)>=min_lon & slon(1,:)<=max_lon);
        
        for m=1:50%length(jdays)
            clf
            [yea,mon,day]=jd2jdate(jdays(m));
            dd=(yea*1000)+julian(mon,day,yea,yea)
            subplot(211)
            load(['//matlab/data/QuickScat/gridded_mstr_week/QSCAT_W_25km_',num2str(jdays(m))],'hp33_crl','lat','lon')
            load(['//matlab/data/eddy/V3/mat/AVISO_25_W_',num2str(jdays(m))],'ssh','hp66_crlg')
            load(['//matlab/data/rand/RAND_W_',num2str(jdays(m))],'nR')
            pmap(lon(c),lat(r),hp33_crl(r,c).*1e5,'crlhp',num2str(dd))
            title(['HP Filtered Wind Vorticity (crl)  ' num2str(yea) '-' num2str(mon) '-' num2str(day) '  '])
            hold on
            m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[-80:4:-2],'color', [.5 .5 .5])
            m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[2:4:80],'k')
            shading interp
            m_coast('patch',[0 0 0],'edgecolor','k');
            caxis([-3 3])
            %cc=colorbar;
            %axes(cc)
            %set(cc,'yaxislocation','right')
            %ylabel('ms^{-1} per 100 km')
            
            
            subplot(212)
            tmp=-hp66_crlg +(.5*(nR .* pstd(hp66_crlg)));
            
            pmap(slon(rssh,cssh),slat(rssh,cssh),tmp(rssh,cssh).*1e5,'crlg',num2str(dd))
            title(['Modeled Vorticity (-crl+(nR*\sigma_{crlg}))  ' num2str(yea) '-' num2str(mon) '-' num2str(day) '  '])
            hold on
            m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[-80:4:-2],'color', [.5 .5 .5])
            m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[2:4:80],'k')
            shading interp
            m_coast('patch',[0 0 0],'edgecolor','k')
            colormap(rwp)
            caxis([-3 3])
            %cc=colorbar;
            %axes(cc)
            %set(cc,'yaxislocation','right')
            %ylabel('ms^{-1} per 100 km')
            %drawnow
            eval(['print -dpng frame_' num2str(ff) '.png'])
            eval(['!convert -trim frame_' num2str(ff) '.png frame_' num2str(ff) ...
                '.ps'])
            ff=ff+1;
        end
        !ffmpeg -r 5 -sameq -s hd1080 -i frame_%d.png -y lw_crl_test_nR.mp4
        
        
    case {'crl_sst_contour'}
        ff=1;
        startyear = 2002;
        startmonth = 7;
        startday = 3;
        
        endyear = 2008;
        endmonth = 12;
        endday = 03;
        
        %construct date vector
        startjd=date2jd(startyear,startmonth,startday)+.5;
        endjd=date2jd(endyear,endmonth,endday)+.5;
        jdays=[startjd:7:endjd];
        [year,month,day]=jd2jdate(jdays);
        
        
        warning('off','all')
        figure(1)
        load //matlab/matlab/domains/LW_lat_lon.mat
        max_lat=max(lat(:));
        min_lat=min(lat(:));
        max_lon=max(lon(:));
        min_lon=min(lon(:));
        load //matlab/data/QuickScat/gridded_mstr_week/QSCAT_W_25km_2453530 lat lon hp_crl
        r=find(lat>=min_lat & lat<=max_lat);
        c=find(lon>=min_lon & lon<=max_lon);
        load //matlab/data/ReynoldsSST/mat/OI_25_W_2452459 lat lon mid_week_jdays
        rsst=find(lat(:,1)>=min_lat & lat(:,1)<=max_lat);
        csst=find(lon(1,:)>=min_lon & lon(1,:)<=max_lon);
        load //matlab/data/eddy/V3/mat/AVISO_25_W_2452459 lat lon
        slat=lat;
        slon=lon;
        rssh=find(slat(:,1)>=min_lat & slat(:,1)<=max_lat);
        cssh=find(slon(1,:)>=min_lon & slon(1,:)<=max_lon);
        
        for m=1:length(jdays)
            clf
            [yea,mon,day]=jd2jdate(jdays(m));
            dd=(yea*1000)+julian(mon,day,yea,yea)
            subplot(211)
            load(['//matlab/data/QuickScat/gridded_mstr_week/QSCAT_W_25km_',num2str(jdays(m))],'hp33_crl','lat','lon')
            load(['//matlab/data/eddy/V3/mat/AVISO_25_W_',num2str(jdays(m))],'mask','ssh')
            pmap(lon(c),lat(r),hp_crl(r,c),'crlhp',num2str(dd))
            title(['HP Filtered Wind Vorticity ' num2str(yea) '-' num2str(mon) '-' num2str(day) '  '])
            hold on
            m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[-80:4:-2],'color', [.5 .5 .5])
            m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[2:4:80],'k')
            shading interp
            m_coast('patch',[0 0 0],'edgecolor','k');
            
            load(['//matlab/data/ReynoldsSST/mat/OI_25_W_',num2str(mid_week_jdays(m))],'filtered_sst_oi','lon','lat')
            subplot(212)
            pmap(lon(rsst,csst),lat(rsst,csst),filtered_sst_oi(rsst,csst),'oihp',num2str(dd))
            title(['HP Filtered OI SST ' num2str(yea) '-' num2str(mon) '-' num2str(day) '  '])
            colormap(chelle)
            hold on
            load(['//matlab/data/eddy/V3/mat/AVISO_25_W_',num2str(mid_week_jdays(m))])
            m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[-80:4:-2],'color', [.5 .5 .5])
            m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[2:4:80],'k')
            shading interp
            m_coast('patch',[0 0 0],'edgecolor','k')
            colormap(rwp)
            eval(['print -dpng frame_' num2str(ff) '.png'])
            eval(['!convert -trim frame_' num2str(ff) '.png frame_' num2str(ff) ...
                '.ps'])
            ff=ff+1;
        end
        !ffmpeg -r 5 -s hd1080 -i frame_%d.png -y lw_crlhp_oihpcontours.mp4
        
    case {'crl_ssh'}
        ff=1;
        startyear = 2002;
        startmonth = 7;
        startday = 3;
        
        endyear = 2008;
        endmonth = 1;
        endday = 03;
        
        %construct date vector
        startjd=date2jd(startyear,startmonth,startday)+.5;
        endjd=date2jd(endyear,endmonth,endday)+.5;
        jdays=[startjd:7:endjd];
        [year,month,day]=jd2jdate(jdays);
        
        
        warning('off','all')
        figure(1)
        load //matlab/matlab/domains/LW_lat_lon.mat
        max_lat=max(lat(:));
        min_lat=min(lat(:));
        max_lon=max(lon(:));
        min_lon=min(lon(:));
        load //matlab/data/QuickScat/mat/QSCAT_W_25km_2452606 lat lon hp66_crl
        r=find(lat>=min_lat & lat<=max_lat);
        c=find(lon>=min_lon & lon<=max_lon);
        load //matlab/data/eddy/V4/mat/AVISO_25_W_2453530 lat lon
        slat=lat;
        slon=lon;
        rssh=find(slat(:,1)>=min_lat & slat(:,1)<=max_lat);
        cssh=find(slon(1,:)>=min_lon & slon(1,:)<=max_lon);
        
        for m=1:length(jdays)
            clf
            [yea,mon,day]=jd2jdate(jdays(m));
            dd=(yea*1000)+julian(mon,day,yea,yea)
            subplot(211)
            load(['//matlab/data/QuickScat/mat/QSCAT_W_25km_',num2str(jdays(m))],'hp66_crl','lat','lon')
            load(['//matlab/data/eddy/V4/mat/AVISO_25_W_',num2str(jdays(m))],'mask','hp66_crlg','ssh')
            pmap(lon(c),lat(r),hp66_crl(r,c).*1e5,'crlhp',num2str(dd))
            title(['HP Filtered Wind Vorticity (crl)  ' num2str(yea) '-' num2str(mon) '-' num2str(day) '  '])
            hold on
            m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[-80:4:-2],'color', [.5 .5 .5])
            m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[2:4:80],'k')
            shading interp
            m_coast('patch',[0 0 0],'edgecolor','k');
            cc=colorbar;
            axes(cc)
            set(cc,'yaxislocation','right')
            ylabel('ms^{-1} per 100 km')
            
            
            subplot(212)
            %[u,v]=geostro(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh)./100,.25);
            %crl = dfdx(v,slat(rssh,cssh),.25)-dfdy(u,.25);
            pmap(slon(rssh,cssh),slat(rssh,cssh),-hp66_crlg(rssh,cssh).*1e5,'crlg',num2str(dd))
            title(['BP Filtered 1.44x1.44-6x6 Geostrophic Vorticity (-crlg)  ' num2str(yea) '-' num2str(mon) '-' num2str(day) '  '])
            colormap(chelle)
            hold on
            m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[-80:4:-2],'color', [.5 .5 .5])
            m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[2:4:80],'k')
            shading interp
            m_coast('patch',[0 0 0],'edgecolor','k')
            colormap(rwp)
            cc=colorbar;
            axes(cc)
            set(cc,'yaxislocation','right')
            ylabel('ms^{-1} per 100 km')
            eval(['print -dpng frame_' num2str(ff) '.png'])
            eval(['!convert -trim frame_' num2str(ff) '.png frame_' num2str(ff) ...
                '.png'])
            ff=ff+1;
        end
        !ffmpeg -r 5 -sameq -s hd1080 -i frame_%d.png -y lw_crlhp_crlg.mp4
        
    case {'lp_crlm_crlg'}
        ff=1;
        startyear = 2002;
        startmonth = 7;
        startday = 3;
        
        endyear = 2008;
        endmonth = 1;
        endday = 03;
        
        %construct date vector
        startjd=date2jd(startyear,startmonth,startday)+.5;
        endjd=date2jd(endyear,endmonth,endday)+.5;
        jdays=[startjd:7:endjd];
        [year,month,day]=jd2jdate(jdays);
        
        
        warning('off','all')
        figure(1)
        load //matlab/matlab/domains/LW_lat_lon.mat
        max_lat=max(lat(:));
        min_lat=min(lat(:));
        max_lon=max(lon(:));
        min_lon=min(lon(:));
        load //matlab/data/QuickScat/gridded_mstr_week/QSCAT_W_25km_2453530 lat lon lp66_crl
        r=find(lat>=min_lat & lat<=max_lat);
        c=find(lon>=min_lon & lon<=max_lon);
        load //matlab/data/eddy/V3/mat/AVISO_25_W_2453530 lat lon
        slat=lat;
        slon=lon;
        rssh=find(slat(:,1)>=min_lat & slat(:,1)<=max_lat);
        cssh=find(slon(1,:)>=min_lon & slon(1,:)<=max_lon);
        
        for m=1:20%:length(jdays)
            clf
            [yea,mon,day]=jd2jdate(jdays(m));
            dd=(yea*1000)+julian(mon,day,yea,yea)
            subplot(311)
            load(['//matlab/data/QuickScat/gridded_mstr_week/QSCAT_W_25km_',num2str(jdays(m))],'lp66_crl','lat','lon')
            load(['//matlab/data/eddy/V3/mat/AVISO_25_W_',num2str(jdays(m))],'mask','crl','ssh')
            %fix omain
            tmp_crl=crl(41:600,:);
            
            crlm=-(tmp_crl+(2*lp66_crl));
            pmap(lon(c),lat(r),crlm(r,c).*1e5,'crlhp',num2str(dd))
            title(['\nabla x u_t  ' num2str(yea) '-' num2str(mon) '-' num2str(day) '  '])
            %{
hold on
m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[-80:4:-2],'color', [.5 .5 .5])
m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[2:4:80],'k')
shading interp
            %}
            m_coast('patch',[0 0 0],'edgecolor','k');
            cc=colorbar;
            axes(cc)
            set(cc,'yaxislocation','right')
            ylabel('ms^{-1} per 100 km')
            
            subplot(312)
            pmap(lon(c),lat(r),lp66_crl(r,c).*1e5,'crlhp',num2str(dd))
            title(['\nabla x u_a 6x6 LP  ' num2str(yea) '-' num2str(mon) '-' num2str(day) '  '])
            %hold on
            %m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[-80:4:-2],'color', [.5 .5 .5])
            %m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[2:4:80],'k')
            %shading interp
            m_coast('patch',[0 0 0],'edgecolor','k');
            cc=colorbar;
            axes(cc)
            set(cc,'yaxislocation','right')
            ylabel('ms^{-1} per 100 km')
            
            subplot(313)
            %[u,v]=geostro(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh)./100,.25);
            %crl = dfdx(v,slat(rssh,cssh),.25)-dfdy(u,.25);
            pmap(slon(rssh,cssh),slat(rssh,cssh),-crl(rssh,cssh).*1e5,'crlg',num2str(dd))
            title(['-\nabla x u_g  ' num2str(yea) '-' num2str(mon) '-' num2str(day) '  '])
            colormap(chelle)
            %{
hold on
m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[-80:4:-2],'color', [.5 .5 .5])
m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[2:4:80],'k')
shading interp
            %}
            m_coast('patch',[0 0 0],'edgecolor','k')
            colormap(rwp)
            cc=colorbar;
            axes(cc)
            set(cc,'yaxislocation','right')
            ylabel('ms^{-1} per 100 km')
            eval(['print -dpng frame_' num2str(ff) '.png'])
            eval(['!convert -trim frame_' num2str(ff) '.png frame_' num2str(ff) ...
                '.png'])
            ff=ff+1;
        end
        !ffmpeg -r 5 -sameq -s hd1080 -i frame_%d.png -y big_lw_crlm_crlg.mp4
end
!ffmpeg -r 5 -sameq -s hd1080 -i frame_%d.png -y out.mp4

