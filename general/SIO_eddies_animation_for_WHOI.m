
load chelle.pal
load zissou.pal
load ~/data/gsm/mean_gchl.mat mean_gchl glat glon
load ~/data/gsm/mask
%mean_gchl=smoothn(mean_gchl,20);


spath='~/data/eddy/V5/mat/AVISO_25_W_';
gpath='~/data/gsm/mat/GSM_9_21_';
startjd=2448910;%2450821+(4*21);
endjd=2455581;%2454405;%
jdays=[startjd:7:endjd];

clons=105;
clats=-30;

ff=1;


load ~/matlab/eddy-wind/tracks/LW_lat_lon_tracks id x y amp track_jday k
load ~/matlab/resonate/mapped_eddy_properties amplitude_map lon lat
glon=lon;glat=lat;
load([spath num2str(jdays(1))],'lat','lon')
amplitude_map=griddata(glon,glat,amplitude_map,lon,lat);
amplitude_map=cat(2,amplitude_map,amplitude_map);

for m=1:length(jdays)
    m
    figure(1)
    rect = get(gcf,'Position');
    rect(1:2) = [0 0];
    
    clf
    fr=gcf;
    set(gcf,'color','k')
    set(gca,'color','k')
    set(gcf, 'InvertHardCopy', 'off')
    load([spath num2str(jdays(m))],'u','v','lat','lon')
	ssh=sqrt(u.^2+v.^2);
    lon=interp2(lon);
    lat=interp2(lat);
    ssh=interp2(ssh);
    m_proj('satellite','lon',clons,'lat',clats,'alt',.45);
    %m_grid('xtick',[0:50:360],'ytick',[-90:10:90],'tickdir','in','color','w','lineweight',1.5);
%     m_pcolor(lon,lat,double(sign(ssh).*log10(abs(ssh))));
%     m_pcolor(lon,lat,double(ssh./amplitude_map));
    m_pcolor(lon,lat,double(ssh));
    hold on
    
    ii=find(track_jday==jdays(m));
    uid=unique(id(ii));
%     
%     for rr=1:length(uid)
%         ii=find(id==uid(rr) & track_jday<=jdays(m));
%         m_plot(x(ii),y(ii),'w')
%         m_plot(x(ii(end)),y(ii(end)),'.','color','w','markersize',5)
%     end
    shading interp
    m_coast('patch',[0 0 0]);
    m_coast('color','w');
%     caxis([-2.7 2.7])
    caxis([0 .9])
    colormap(jet)
    set(gca,'xcolor','k','ycolor','k')
    axis image
    set(gca,'color','k')
    [yea,mon,day]=jd2jdate(jdays(m));
    text(.4,-.35,[num2str(yea),'-',num2str(mon),'-',num2str(day)],'color','w','fontsize',16)
    text(.4,-.43,['Peter Gaube'],'color','w','fontsize',12)
    text(.4,-.5,['www.whoi.edu'],'color','w','fontsize',12)
    m_text(115,-26,'Australia ','color','w')
    m_text(85,-15,'South Indian Ocean ','color','k','fontweight','bold')
    m_text(75,-50,'Antarctic Circumpolar Current ','color','k','fontweight','bold')
    
    
    pause(.1)

    eval(['print -dpng -r300 frame_' num2str(m)]);
    
%     
%     frame = getframe(1);
%     im = frame2im(frame);
%     [imind,cm] = rgb2ind(im,256);
%     if m == 1;
%         imwrite(imind,cm,filename,'gif', 'Loopcount',inf);
%     else
%         imwrite(imind,cm,filename,'gif','WriteMode','append');
%     end
    clear ssh
end
% close(aviobj);
