
load chelle.pal
load ~/data/gsm/mean_gchl.mat mean_gchl glat glon
load ~/data/gsm/mask
%mean_gchl=smoothn(mean_gchl,20);


spath='~/data/eddy/V5/mat/AVISO_25_W_';
gpath='~/data/gsm/mat/GSM_9_21_';
startjd=2448910;%2450821+(4*21);
endjd=2455581;%2454405;%
jdays=[startjd:7:endjd];

pat=[	-20	0
    -40	10
    -40	60
    -20	100
    -30	160
    -30	200
    -40	260
    -30	300
    -20	360
    20	330
    40	300
    40	225
    30	175
    0	150
    -20	100
    -20	0];
clats=interp1(1:length(pat(:,1)),pat(:,1),linspace(1,length(pat(:,1)),length(jdays)),'cubic');
clons=interp1(1:length(pat(:,1)),pat(:,2),linspace(1,length(pat(:,1)),length(jdays)),'cubic');


ff=1;


load ~/data/eddy/V5/global_tracks_V5_12_weeks id x y amp track_jday k

% aviobj = VideoWriter('spin_globe.avi');
% 
% aviobj.FrameRate=14.4;
% aviobj.Quality=40;
% open(aviobj)

filename = 'spin_globe.gif';
for m=500%:20:900%length(clons)
    figure(1)
    rect = get(gcf,'Position');
    rect(1:2) = [0 0];
        
    clf
    fr=gcf;
%     set(gcf,'color','k')
%     set(gca,'color','k')
%     set(gcf, 'InvertHardCopy', 'off')
    load([spath num2str(jdays(m))],'ssh','u','v','lat','lon')
    lon=cat(2,lon,lon+max(lon(:)));
    lat=cat(2,lat,lat);
    ssh=cat(2,ssh,ssh);
    m_proj('satellite','lon',clons(m),'lat',clats(m),'alt',300);
    %m_grid('xtick',[0:50:360],'ytick',[-90:10:90],'tickdir','in','color','w','lineweight',1.5);
    m_pcolor(lon,lat,double(ssh))
    hold on
    
    ii=find(track_jday==jdays(m));
    uid=unique(id(ii));
    
    for rr=1:length(uid)
        ii=find(id==uid(rr) & track_jday<=jdays(m));
        m_plot(x(ii),y(ii),'k')
    end
    %m_contour(glon,glat,double(mean_gchl),[-3:.1:1],'color',[.5 .5 .5])
    shading flat
    m_coast('patch',[0 0 0]);
    m_coast('color','w');
    caxis([-20 20])
    colormap(chelle)
    set(gca,'xcolor','w','ycolor','w')
    axis image
    set(gca,'color','w')
    [yea,mon,day]=jd2jdate(jdays(m));
%     text(.92,-.9,[num2str(yea),'-',num2str(mon),'-',num2str(day)],'color','w','fontsize',16)
%     text(.92,-1,['Peter Gaube'],'color','w','fontsize',12)
%     text(.92,-1.1,['pgaube@whoi.edu'],'color','w','fontsize',12)
    pause(.1)
%     writeVideo(aviobj,getframe(fr,rect));
print -dpng -r300 figs/globe_eddies_image
return
    frame = getframe(1);
    im = frame2im(frame);
    [imind,cm] = rgb2ind(im,256);
      if m == 1;
          imwrite(imind,cm,filename,'gif', 'Loopcount',inf);
      else
          imwrite(imind,cm,filename,'gif','WriteMode','append');
      end
      clear ssh
end
% close(aviobj);
return


for m=1:length(clons)
    figure(1)
    clf
    set(gcf,'color','k')
    set(gca,'color','k')
    set(gcf, 'InvertHardCopy', 'off')
    %load([spath num2str(jdays(m))],'ssh','u','v','lat','lon')
    load([gpath num2str(jdays(m))],'sp66_chl','glat','glon')
    m_proj('satellite','lon',clons(m),'lat',clats(m),'alt',300);
    %m_grid('xtick',[0:50:360],'ytick',[-90:10:90],'tickdir','in','color','w','lineweight',1.5);
    m_pcolor(glon,glat,double(sp66_chl).*mask)
    hold on
    
    ii=find(track_jday==jdays(m));
    uid=unique(id(ii));
    
    for rr=1:length(uid)
        ii=find(id==uid(rr) & track_jday<=jdays(m));
        m_plot(x(ii),y(ii),'k')
    end
    %m_contour(glon,glat,double(mean_gchl),[-3:.1:1],'color',[.5 .5 .5])
    shading flat
    m_coast('patch',[0 0 0]);
    m_coast('color','w');
    caxis([-.05 .05])
    colormap(chelle)
    set(gca,'xcolor','k','ycolor','k')
    axis image
    set(gca,'color','k')
    eval(['print -dpng -r100 frame_' num2str(m)]);
    ff=ff+1;
    clear ssh
end

return

for m=1:length(clons)
    figure(1)
    clf
    %set(gcf,'color','k')
    %set(gca,'color','k')
    %set(gcf, 'InvertHardCopy', 'off')
    
    m_proj('satellite','lon',clons(m),'lat',clats(m),'alt',300);
    %m_grid('xtick',[0:50:360],'ytick',[-90:10:90],'tickdir','in','color','w','lineweight',1.5);
    m_pcolor(glon,glat,double(mean_gchl))
    hold on
    %m_contour(glon,glat,double(mean_gchl),[-3:.1:1],'color',[.5 .5 .5])
    shading flat
    m_coast('patch',[0 0 0]);
    caxis([-1.3 .1])
    
    colormap(chelle)
    set(gca,'xcolor','w','ycolor','w')
    axis image
    eval(['print -dpng -r100 frame_' num2str(m)]);
end






