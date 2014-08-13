
startjd=2452427;
endjd=2455159;

%%SIO
load ~/data/eddy/V5/EIO_lat_lon_orgin_tracks
ii=find(track_jday>=startjd & track_jday<=endjd);
x=x(ii);y=y(ii);id=id(ii);cyc=cyc(ii);k=k(ii);track_jday=track_jday(ii);
lon=50:150;lat=-45:-12;
figure(1)
clf
max_lat=max(lat(:));
min_lat=min(lat(:));
max_lon=max(lon(:));
min_lon=min(lon(:));
lat_step=10;
lon_step=10;
m_proj('Equidistant cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);
%colormap('jet');
m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick',[round(min_lat):lat_step:round(max_lat)],'tickdir','in','color','k','lineweight',1.5);
hm=gca;
set(hm,'clipping','off')
hold on

[jdays,is]=sort(track_jday);
x=x(is);
y=y(is);
id=id(is);
k=k(is);
cyc=cyc(is);
ujd=unique(jdays);
for qq=1:length(ujd)
    dd=find(jdays==ujd(qq) & k==1);
    uid=unique(id(dd));
    for m=1:length(uid)
        ii=find(id==uid(m));
        if cyc(ii(1))>=1
            m_plot(x(ii),y(ii),'r','linewidth',.5)
        else
            m_plot(x(ii),y(ii),'b','linewidth',.5)
        end
%         if cyc(ii(1))>=1
%             m_plot(x(ii(1)),y(ii(1)),'r.','markersize',7)
%             m_plot(x(ii(1)),y(ii(1)),'ko','markersize',2)
%         else
%             m_plot(x(ii(1)),y(ii(1)),'b.','markersize',7)
%             m_plot(x(ii(1)),y(ii(1)),'ko','markersize',2)
%         end
    end
end
grid
m_coast('patch',[0 0 0],'edgecolor','k');
hold off
load ~/matlab/domains/EIO_lat_lon
draw_domain(lon,lat)
print -dpng -r300 ~/Documents/OSU/figures/air-sea/EIO_map
return


%%%CAR
load ~/data/eddy/V5/CAR_lat_lon_orgin_tracks
ii=find(track_jday>=startjd & track_jday<=endjd);
x=x(ii);y=y(ii);id=id(ii);cyc=cyc(ii);k=k(ii);track_jday=track_jday(ii);
lon=250:330;lat=5:30;
figure(1)
clf
max_lat=max(lat(:));
min_lat=min(lat(:));
max_lon=max(lon(:));
min_lon=min(lon(:));
lat_step=10;
lon_step=10;
m_proj('Equidistant cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);
%colormap('jet');
m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick',[round(min_lat):lat_step:round(max_lat)],'tickdir','in','color','k','lineweight',1.5);
hm=gca;
set(hm,'clipping','off')
hold on

[jdays,is]=sort(track_jday);
x=x(is);
y=y(is);
id=id(is);
k=k(is);
cyc=cyc(is);
ujd=unique(jdays);
for qq=1:length(ujd)
    dd=find(jdays==ujd(qq) & k==1);
    uid=unique(id(dd));
    for m=1:length(uid)
        ii=find(id==uid(m));
        if cyc(ii(1))>=1
            m_plot(x(ii),y(ii),'r','linewidth',.1)
        else
            m_plot(x(ii),y(ii),'b','linewidth',.1)
        end
%         if cyc(ii(1))>=1
%             m_plot(x(ii(1)),y(ii(1)),'r.','markersize',7)
%             m_plot(x(ii(1)),y(ii(1)),'ko','markersize',2)
%         else
%             m_plot(x(ii(1)),y(ii(1)),'b.','markersize',7)
%             m_plot(x(ii(1)),y(ii(1)),'ko','markersize',2)
%         end
    end
end
grid
m_coast('patch',[0 0 0],'edgecolor','k');
hold off
load ~/matlab/domains/CAR_lat_lon
draw_domain(lon,lat)
print -dpng -r300 ~/Documents/OSU/figures/air-sea/CAR_map
% return

%%%HAW
load ~/data/eddy/V5/HAW_lat_lon_orgin_tracks
ii=find(track_jday>=startjd & track_jday<=endjd);
x=x(ii);y=y(ii);id=id(ii);cyc=cyc(ii);k=k(ii);track_jday=track_jday(ii);
lon=140:230;lat=10:30;
figure(1)
clf
max_lat=max(lat(:));
min_lat=min(lat(:));
max_lon=max(lon(:));
min_lon=min(lon(:));
lat_step=10;
lon_step=20;
m_proj('Equidistant cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);
%colormap('jet');
m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick',[round(min_lat):lat_step:round(max_lat)],'tickdir','in','color','k','lineweight',1.5);
hm=gca;
set(hm,'clipping','off')
hold on

[jdays,is]=sort(track_jday);
x=x(is);
y=y(is);
id=id(is);
k=k(is);
cyc=cyc(is);
ujd=unique(jdays);
for qq=1:length(ujd)
    dd=find(jdays==ujd(qq) & k==1);
    uid=unique(id(dd));
    for m=1:length(uid)
        ii=find(id==uid(m));
        if cyc(ii(1))>=1
            m_plot(x(ii),y(ii),'r','linewidth',.1)
        else
            m_plot(x(ii),y(ii),'b','linewidth',.1)
        end
%         if cyc(ii(1))>=1
%             m_plot(x(ii(1)),y(ii(1)),'r.','markersize',7)
%             m_plot(x(ii(1)),y(ii(1)),'ko','markersize',2)
%         else
%             m_plot(x(ii(1)),y(ii(1)),'b.','markersize',7)
%             m_plot(x(ii(1)),y(ii(1)),'ko','markersize',2)
%         end
    end
end
grid
m_coast('patch',[0 0 0],'edgecolor','k');
hold off
load ~/matlab/domains/HAW_lat_lon
draw_domain(lon,lat)
print -dpng -r300 ~/Documents/OSU/figures/air-sea/HAW_map
% return


%%%SPO
load ~/data/eddy/V5/new_SP_lat_lon_orgin_tracks
ii=find(track_jday>=startjd & track_jday<=endjd);
x=x(ii);y=y(ii);id=id(ii);cyc=cyc(ii);k=k(ii);track_jday=track_jday(ii);
lon=140:300;lat=-30:-10;
figure(1)
clf
max_lat=max(lat(:));
min_lat=min(lat(:));
max_lon=max(lon(:));
min_lon=min(lon(:));
lat_step=10;
lon_step=20;
m_proj('Equidistant cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);
%colormap('jet');
m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick',[round(min_lat):lat_step:round(max_lat)],'tickdir','in','color','k','lineweight',1.5);
hm=gca;
set(hm,'clipping','off')
hold on

[jdays,is]=sort(track_jday);
x=x(is);
y=y(is);
id=id(is);
k=k(is);
cyc=cyc(is);
ujd=unique(jdays);
for qq=1:length(ujd)
    dd=find(jdays==ujd(qq) & k==1);
    uid=unique(id(dd));
    for m=1:length(uid)
        ii=find(id==uid(m));
        if cyc(ii(1))>=1
            m_plot(x(ii),y(ii),'r','linewidth',.1)
        else
            m_plot(x(ii),y(ii),'b','linewidth',.1)
        end
%         if cyc(ii(1))>=1
%             m_plot(x(ii(1)),y(ii(1)),'r.','markersize',7)
%             m_plot(x(ii(1)),y(ii(1)),'ko','markersize',2)
%         else
%             m_plot(x(ii(1)),y(ii(1)),'b.','markersize',7)
%             m_plot(x(ii(1)),y(ii(1)),'ko','markersize',2)
%         end
    end
end
grid
m_coast('patch',[0 0 0],'edgecolor','k');
hold off
load ~/matlab/domains/new_SP_lat_lon
draw_domain(lon,lat)
print -dpng -r300 ~/Documents/OSU/figures/air-sea/SP_map
%  return

%%%SEA
load ~/data/eddy/V5/AGU_lat_lon_orgin_tracks
ii=find(track_jday>=startjd & track_jday<=endjd);
x=x(ii);y=y(ii);id=id(ii);cyc=cyc(ii);k=k(ii);track_jday=track_jday(ii);
lon=-40:30;lat=-50:-20;
figure(1)
clf
max_lat=max(lat(:));
min_lat=min(lat(:));
max_lon=max(lon(:));
min_lon=min(lon(:));
lat_step=10;
lon_step=10;
m_proj('Equidistant cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);
%colormap('jet');
m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick',[round(min_lat):lat_step:round(max_lat)],'tickdir','in','color','k','lineweight',1.5);
hm=gca;
set(hm,'clipping','off')
hold on

[jdays,is]=sort(track_jday);
x=x(is);
y=y(is);
id=id(is);
k=k(is);
cyc=cyc(is);
ujd=unique(jdays);
x(x>30)=x(x>30)-360;
for qq=1:length(ujd)
    dd=find(jdays==ujd(qq) & k==1);
    uid=unique(id(dd));
    for m=1:length(uid)
        ii=find(id==uid(m));
        if cyc(ii(1))>=1
            m_plot(x(ii),y(ii),'r','linewidth',.1)
        else
            m_plot(x(ii),y(ii),'b','linewidth',.1)
        end
%         if cyc(ii(1))>=1
%             m_plot(x(ii(1)),y(ii(1)),'r.','markersize',7)
%             m_plot(x(ii(1)),y(ii(1)),'ko','markersize',2)
%         else
%             m_plot(x(ii(1)),y(ii(1)),'b.','markersize',7)
%             m_plot(x(ii(1)),y(ii(1)),'ko','markersize',2)
%         end
    end
end
grid
m_coast('patch',[0 0 0],'edgecolor','k');
hold off
load ~/matlab/domains/AGU_lat_lon
draw_domain(lon,lat)
print -dpng -r300 ~/Documents/OSU/figures/air-sea/AGU_map
% return

% %%%AGR
load ~/data/eddy/V5/AGR_lat_lon_orgin_tracks
ii=find(track_jday>=startjd & track_jday<=endjd);
x=x(ii);y=y(ii);id=id(ii);cyc=cyc(ii);k=k(ii);track_jday=track_jday(ii);
lon=10:150;lat=-55:-25;
figure(1)
clf
max_lat=max(lat(:));
min_lat=min(lat(:));
max_lon=max(lon(:));
min_lon=min(lon(:));
lat_step=10;
lon_step=20;
m_proj('Equidistant cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);
%colormap('jet');
m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick',[round(min_lat):lat_step:round(max_lat)],'tickdir','in','color','k','lineweight',1.5);
hm=gca;
set(hm,'clipping','off')
hold on

[jdays,is]=sort(track_jday);
x=x(is);
y=y(is);
id=id(is);
k=k(is);
cyc=cyc(is);
ujd=unique(jdays);
for qq=1:length(ujd)
    dd=find(jdays==ujd(qq) & k==1);
    uid=unique(id(dd));
    for m=1:length(uid)
        ii=find(id==uid(m));
        if cyc(ii(1))>=1
            m_plot(x(ii),y(ii),'r','linewidth',.1)
        else
            m_plot(x(ii),y(ii),'b','linewidth',.1)
        end
%         if cyc(ii(1))>=1
%             m_plot(x(ii(1)),y(ii(1)),'r.','markersize',7)
%             m_plot(x(ii(1)),y(ii(1)),'ko','markersize',2)
%         else
%             m_plot(x(ii(1)),y(ii(1)),'b.','markersize',7)
%             m_plot(x(ii(1)),y(ii(1)),'ko','markersize',2)
%         end
    end
end
grid
m_coast('patch',[0 0 0],'edgecolor','k');
hold off
load ~/matlab/domains/AGR_lat_lon
draw_domain(lon,lat)
print -dpng -r300 ~/Documents/OSU/figures/air-sea/AGR_map
% return