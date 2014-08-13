clear all

load bwr.pal

figure(1);
clf
ff=1;



load ~/matlab/pop/mat/pop_model_domain r c lat lon
load pop_run14_tracks
HEAD='~/matlab/pop/mat/run14_';
pdays=[1801:1873];
jdays=[2453376:7:2453733];
set_pop
[r,c]=imap(28,45,intense_domain(3),intense_domain(4),lat,lon);
lat_step=4;
lon_step=5;
dlat=lat(r,c);
dlon=lon(r,c);
max_lat=max(dlat(:));
min_lat=min(dlat(:));
max_lon=max(dlon(:));
min_lon=min(dlon(:));

load ~/data/eddy/V5/mat/AVISO_25_W_2448910.mat lat lon
[rs,cs]=imap(28,45,intense_domain(3),intense_domain(4),lat,lon);
slat=lat;
slon=lon;

load ~/matlab/pop/mat/pop_model_domain lat lon

m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);
m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick',[round(min_lat):lat_step:round(max_lat)],'tickdir','in','color','k','lineweight',1.5);
m_gshhs_f('save','gumby');


%%%load and interp tracks
%%first aviso
load rings_cor_orgin_tracks_AVISO x y id cyc track_jday
ii=find(track_jday>=jdays(1) & track_jday<=jdays(end));
ax=x(ii);
ay=y(ii);
aid=id(ii);
acyc=cyc(ii);
atrack_jday=track_jday(ii);
uid=unique(aid);


load rings_cor_orgin_TS_tracks x y id cyc track_jday
ii=find(track_jday>=pdays(1) & track_jday<=pdays(end));
x=x(ii);
y=y(ii);
id=id(ii);
cyc=cyc(ii);
track_jday=track_jday(ii);
uid=unique(id);

for m=1:length(pdays)
    
    figure(1)
    clf
    
    rect = get(gcf,'Position');
    rect(1:2) = [0 0];
    fr=gcf;
    
    subplot(211)
    m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);
    m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick',[round(min_lat):lat_step:round(max_lat)],'tickdir','in','color','k','lineweight',1.5,'color','k','fontsize',18);
    hold on
    m_pcolor(lon(r,c),lat(r,c),double(pdSSH(:,:,m)))
    caxis([-30 30])
    title(['POP SSH, yearday ',num2str(days(m)),'    '],'fontsize',20)
    shading interp
    hold on
    m_contour(lon(r,c),lat(r,c),pdSSH(:,:,m),[5:7:100],'k')
    m_contour(lon(r,c),lat(r,c),pdSSH(:,:,m),[-100:7:-5],'k--')
    shading flat
    m_usercoast('gumby','patch','k');
    m_usercoast('gumby','line','color','k');
    set(gca,'fontsize',18,'fontweight','bold')
    grid
    
%     ii=find(track_jday==
    
    [yea,mon,day]=jd2jdate(jdays(m))
    subplot(212)
    m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);
    m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick',[round(min_lat):lat_step:round(max_lat)],'tickdir','in','color','k','lineweight',1.5,'color','k','fontsize',18);
    hold on
    m_pcolor(slon(rs,cs),slat(rs,cs),dSSH(:,:,m))
    caxis([-30 30])
    title(['AVISO SSH, ',num2str(yea),'-',num2str(mon),'-',num2str(day),'    '],'fontsize',20)
    shading interp
    hold on
    m_contour(slon(rs,cs),slat(rs,cs),dSSH(:,:,m),[5:7:100],'k')
    m_contour(slon(rs,cs),slat(rs,cs),dSSH(:,:,m),[-100:7:-5],'k--')
    shading flat
    colormap(bwr)
    m_usercoast('gumby','patch','k');
    m_usercoast('gumby','line','color','k');
    set(gca,'fontsize',18,'fontweight','bold')
    grid
    %     fr=gcf;
    %     writeVideo(aviobj,getframe(fr,rect));
    eval(['print -dpng -r300 frames/ssh/frame_',num2str(ff)])
    ff=ff+1;
    
    return
end
% close(aviobj);


