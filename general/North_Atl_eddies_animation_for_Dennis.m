
load chelle.pal
load ~/data/gsm/mean_gchl.mat mean_gchl glat glon
load ~/data/gsm/mask
%mean_gchl=smoothn(mean_gchl,20);


spath='~/data/eddy/V5/mat/AVISO_25_W_';
gpath='~/data/gsm/mat/GSM_9_21_';
startjd=2448910;%2450821+(4*21);
endjd=2455581;%2454405;%
jdays=[startjd:7:endjd];

clons=310;
clats=40;

ff=1;


load ~/data/eddy/V5/global_tracks_V5_12_weeks id x y amp track_jday k
load ~/matlab/resonate/mapped_eddy_properties amplitude_map lon lat
glon=lon;glat=lat;
load([spath num2str(jdays(1))],'lat','lon')
amplitude_map=griddata(glon,glat,amplitude_map,lon,lat);
amplitude_map=cat(2,amplitude_map,amplitude_map);

filename = 'NA_eddies.gif';
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
    load([spath num2str(jdays(m))],'ssh','u','v','lat','lon')
%     ssh(ssh==0)=0.0001;
    lon=cat(2,lon,lon+max(lon(:)));
    lat=cat(2,lat,lat);
    ssh=cat(2,ssh,ssh);
    m_proj('satellite','lon',clons,'lat',clats,'alt',2);
    %m_grid('xtick',[0:50:360],'ytick',[-90:10:90],'tickdir','in','color','w','lineweight',1.5);
%     m_pcolor(lon,lat,double(sign(ssh).*log10(abs(ssh))));
    m_pcolor(lon,lat,double(ssh./amplitude_map));
    hold on
    
    ii=find(track_jday==jdays(m));
    uid=unique(id(ii));
    
    for rr=1:length(uid)
        ii=find(id==uid(rr) & track_jday<=jdays(m));
        m_plot(x(ii),y(ii),'k')
    end
    shading flat
    m_coast('patch',[0 0 0]);
    m_coast('color','w');
    caxis([-2.7 2.7])
    colormap(chelle)
    set(gca,'xcolor','k','ycolor','k')
    axis image
    set(gca,'color','k')
    [yea,mon,day]=jd2jdate(jdays(m));
    text(.6,-.7,[num2str(yea),'-',num2str(mon),'-',num2str(day)],'color','w','fontsize',16)
    text(.6,-.78,['Peter Gaube'],'color','w','fontsize',12)
    text(.6,-.85,['pgaube@whoi.edu'],'color','w','fontsize',12)
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
