load bwr.pal

spath='/Users/new_gaube/data/QuickScat/ULTI_mat4/QSCAT_30_25km_';
startjd=2452585;
endjd=2455140;
jdays=[startjd:7:endjd];

clons=210;
clats=25;

clons=105;
clats=-30;

ff=1;


load ~/data/eddy/V5/global_tracks_V5_12_weeks id x y amp track_jday k
glon=lon;glat=lat;
load([spath num2str(jdays(1))],'lat','lon')



for m=1:length(jdays)
    m
    figure(1)
    rect = get(gcf,'Position');
    rect(1:2) = [0 0];
    
    clf
    fr=gcf;
    set(gcf,'color','w')
    set(gca,'color','w')
    set(gcf, 'InvertHardCopy', 'off')
    load([spath num2str(jdays(m))],'hp_crl_wek_est','lat','lon')
%     ssh(ssh==0)=0.0001;
    lon=cat(2,lon,lon+max(lon(:)));
    lat=cat(2,lat,lat);
    ssh=cat(2,hp_crl_wek_est,hp_crl_wek_est);
    fnor=f_cor(lat);
    m_proj('satellite','lon',clons,'lat',clats,'alt',.2);
    %m_grid('xtick',[0:50:360],'ytick',[-90:10:90],'tickdir','in','color','w','lineweight',1.5);
%     m_pcolor(lon,lat,double(sign(ssh).*log10(abs(ssh))));
    m_pcolor(lon,lat,double((fnor./f_cor(30)).*ssh));
    hold on
    
    ii=find(track_jday==jdays(m));
    uid=unique(id(ii));
    
    for rr=1:length(uid)
        ii=find(id==uid(rr) & track_jday<=jdays(m));
        m_plot(x(ii),y(ii),'k')
    end
    shading flat
    m_coast('patch',[0 0 0]);
    m_coast('color','k');
    caxis([-12 12])
    colormap(bwr)
    set(gca,'xcolor','w','ycolor','w')
    axis image
    set(gca,'color','w')
    [yea,mon,day]=jd2jdate(jdays(m));
%     text(.6,-.7,[num2str(yea),'-',num2str(mon),'-',num2str(day)],'color','w','fontsize',16)
%     text(.6,-.78,['Peter Gaube'],'color','w','fontsize',12)
%     text(.6,-.85,['pgaube@whoi.edu'],'color','w','fontsize',12)
    pause(.1)
    return
    eval(['print -dpng -r300 frames/haw_globe/frame_' num2str(m)]);
    
%     
%     frame = getframe(1);
%     im = frame2im(frame);
%     [imind,cm] = rgb2ind(im,256);
%     if m == 1;
%         imwrite(imind,cm,filename,'gif', 'Loopcount',inf);
%     else
%         imwrite(imind,cm,filename,'gif','WriteMode','append');
%     end
    clear *wek*
end
% close(aviobj);
