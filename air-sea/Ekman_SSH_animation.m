clear all
%want_id=39788;
want_id=149011 ;


%find track
load ~/data/eddy/V4/global_tracks_V4
f1=find(id==want_id);
x=x(f1);
gx=gx(f1);
gy=gy(f1);
y=y(f1);
id=id(f1);
k=k(f1);
jdays=track_jday(f1);
clearallbut x y id k jdays gx gy

load rwp.pal
load bwr.pal
load chelle.pal

min_lat=min(y)-5;
max_lat=max(y)+3;
min_lon=min(x)-3;
max_lon=max(x)+8;

load(['~/data/eddy/V5/mat/AVISO_25_W_',num2str(jdays(1))],'ssh','lat','lon')
slat=lat;
slon=lon;
islat=interp2(slat);
islon=interp2(slon);
[rs,cs]=imap(min_lat,max_lat,min_lon,max_lon,slat,slon);
[irs,ics]=imap(min_lat,max_lat,min_lon,max_lon,islat,islon);

load(['~/data/QuickScat/mat/QSCAT_30_25km_',num2str(jdays(1))],'bp26_crl','lat','lon')
[r,c]=imap(min_lat,max_lat,min_lon,max_lon,lat,lon);
ilon=interp2(lon);
ilat=interp2(lat);
[ir,ic]=imap(min_lat,max_lat,min_lon,max_lon,ilat,ilon);


aviobj = VideoWriter('Ekman_pumping_SIO_eddy_example.avi');

aviobj.FrameRate=3;
aviobj.Quality=100;

open(aviobj)
for m=1:length(k)
    
    load(['~/data/eddy/V5/mat/AVISO_25_W_',num2str(jdays(m))],'crl','ssh')
    load(['~/data/QuickScat/mat/QSCAT_30_25km_',num2str(jdays(m))],'bp26_crl','w_ek')
    crlg=crl;
    crl=-bp26_crl;
    icrl=interp2(crl);
    issh=interp2(ssh);
    iwek=interp2(w_ek);
    
    
    figure(1)
    clf
    
    %set(gcf,'Resize','off')
    rect = get(gcf,'Position');
    rect(1:2) = [0 0];
    fr=gcf;
    %crlg
    subplot(322)
    [ctr,ctc]=imap(gy(m),gy(m),gx(m),gx(m),slat,slon);
    tc=ctc-7:ctc+7;
    tr=ctr-7:ctr+7;
    fcrlg=interp2(1e5*double(crlg(tr,tc)),'cubic');
    fssh=interp2(double(ssh(tr,tc)),'cubic');
    pcolor(fcrlg);
    shading flat
    hold on
    contour(fssh,[1:5:100],'k')
    set(gca,'xticklabel',[])
    set(gca,'yticklabel',[])
    hold on
    line([15 15],[0 29],'color','k')
    line([0 29],[15 15],'color','k')
    axis image
    caxis([-1 1])
    hold off
    title('Instantaneous Geostrophic Vorticity  ')
    
    %crl
    subplot(321)
    [ctr,ctc]=imap(gy(m),gy(m),gx(m),gx(m),lat,lon);
    tc=ctc-7:ctc+7;
    tr=ctr-7:ctr+7;
    fcrl=interp2(double(w_ek(tr,tc)),'cubic');
    pcolor(fcrl);
    shading flat
    hold on
    contour(fssh,[1:5:100],'k')
    set(gca,'xticklabel',[])
    set(gca,'yticklabel',[])
    hold on
    line([15 15],[0 29],'color','k')
    line([0 29],[15 15],'color','k')
    axis image
    caxis([-.15 .15])
    hold off
    title('Instantaneous Ekman pumping  ')
    
    all_crl(:,:,m)=fcrl;
    all_crlg(:,:,m)=fcrlg;
    all_ssh(:,:,m)=fssh;
    colormap(bwr)
    freezeColors
    %map
    subplot(3,2,[3 4])
    pmap(ilon(ir,ic),ilat(ir,ic),double(1e5*icrl(ir,ic)))
    m_contour(islon(irs,ics),islat(irs,ics),double(issh(irs,ics)),[-100:5:-5],'k--')
    m_contour(islon(irs,ics),islat(irs,ics),double(issh(irs,ics)),[5:5:100],'k')
    
    %pmap(slon(rs,cs),slat(rs,cs),nan*ssh(rs,cs))
    shading interp
    caxis([-1 1])
    hold on
    m_plot(x(1:m),y(1:m),'k','LineWidth',2)
    [mon,day,yea]=jd2jdate(jdays(m));
    title({'Wind Vorticity  ',[num2str(mon),'-',num2str(day),'-',num2str(yea)]})
    m_coast('patch',[0 0 0]);
    colormap(chelle)
    freezeColors
    
    %comps
    
    subplot(325)
    pcolor(nanmean(all_crl,3));shading interp
    caxis([-1.2 1.2])
    set(gca,'xticklabel',[])
    set(gca,'yticklabel',[])
    hold on
    line([15 15],[0 29],'color','k')
    line([0 29],[15 15],'color','k')
    hold on
    contour(nanmean(all_ssh,3),[2:5:30],'k')
    axis image
    caxis([-.15 .15])
    title({'Composite Average of   ','Ekman Pumping   '})
    
    subplot(326)
    pcolor(nanmean(all_crlg,3));shading interp
    set(gca,'xticklabel',[])
    set(gca,'yticklabel',[])
    hold on
    line([15 15],[0 29],'color','k')
    line([0 29],[15 15],'color','k')
    axis image
    hold on
    contour(nanmean(all_ssh,3),[2:5:30],'k')
    caxis([-1 1])
    title({'Composite Average of   ','Geostrophic Vorticity   '})
    colormap(bwr)
    drawnow
    writeVideo(aviobj,getframe(fr,rect));
    
    if m==length(k)
        figure(1)
        clf
        
        %set(gcf,'Resize','off')
        rect = get(gcf,'Position');
        rect(1:2) = [0 0];
        fr=gcf;
        %crlg
        subplot(121)
        pcolor(nanmean(all_crl,3));shading interp
        set(gca,'xticklabel',[])
        set(gca,'yticklabel',[])
        hold on
        line([15 15],[0 29],'color','k')
        line([0 29],[15 15],'color','k')
        hold on
        contour(nanmean(all_crl,3),[.01:.01:1],'k')
        contour(nanmean(all_crl,3),[-1:.01:-.01],'k--')
        axis image
        caxis([-.15 .15])
        title({'Composite Average of   ','Ekman Pumping   '})
        
        subplot(122)
        pcolor(nanmean(all_crlg,3));shading interp
        set(gca,'xticklabel',[])
        set(gca,'yticklabel',[])
        hold on
        line([15 15],[0 29],'color','k')
        line([0 29],[15 15],'color','k')
        axis image
        hold on
        contour(nanmean(all_ssh,3),[2:2:30],'k')
        contour(nanmean(all_ssh,3),[-30:2:-2],'k--')
        caxis([-1 1])
        title({'Composite Average of   ','Geostrophic Vorticity   '})
        colormap(bwr)
        writeVideo(aviobj,getframe(fr,rect));
    end
    
end
close(aviobj);