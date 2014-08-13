set_regions
startjd=date2jd(2001,1,1);
endjd=date2jd(2009,11,31);
load FINAL_cor_sm_output sm_cor_0 lat lon
clon=lon;clat=lat;
load bwr.pal
%%%Gs
load(['~/data/eddy/V5/','new_',curs{8},'_lat_lon_orgin_tracks'])
ii=find(track_jday>=startjd & track_jday<=endjd);
x=x(ii);y=y(ii);id=id(ii);cyc=cyc(ii);k=k(ii);track_jday=track_jday(ii);
lon=180+(180-80):180+(180-25);lat=25:55;

figure(1)
clf
max_lat=max(lat(:));
min_lat=min(lat(:));
max_lon=max(lon(:));
min_lon=min(lon(:));
[r,c]=imap(min_lat,max_lat,min_lon,max_lon,clat,clon);
lat_step=5;
lon_step=10;
m_proj('Equidistant cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);
%colormap('jet');
m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick',[round(min_lat):lat_step:round(max_lat)],'tickdir','in','color','k','lineweight',1.5);
hm=gca;
set(hm,'clipping','off')
hold on
m_pcolor(clon(r,c),clat(r,c),sm_cor_0(r,c));shading flat;colormap(bwr);caxis([-.5 .5])
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
            m_plot(x(ii),y(ii),'k','linewidth',.1)
        else
            m_plot(x(ii),y(ii),'k','linewidth',.1)
        end
        if cyc(ii(1))>=1
            m_plot(x(ii(1)),y(ii(1)),'k.','markersize',7)
            m_plot(x(ii(1)),y(ii(1)),'ko','markersize',2)
        else
            m_plot(x(ii(1)),y(ii(1)),'k.','markersize',7)
            m_plot(x(ii(1)),y(ii(1)),'ko','markersize',2)
        end
    end
end
grid
m_coast('patch',[0 0 0],'edgecolor','k');
hold off
axis normal

draw_regions_boxes
print -dpng -r300 ~/Documents/Publications/gaube_geographic_PNO/figs/GS_map_with_cor


%%%BMC
load(['~/data/eddy/V5/','new_',curs{7},'_lat_lon_orgin_tracks'])
ii=find(track_jday>=startjd & track_jday<=endjd);
x=x(ii);y=y(ii);id=id(ii);cyc=cyc(ii);k=k(ii);track_jday=track_jday(ii);
lon=180+(180-70):180+(180-25);
lat=-55:-25;
figure(1)
clf
max_lat=max(lat(:));
min_lat=min(lat(:));
max_lon=max(lon(:));
min_lon=min(lon(:));
[r,c]=imap(min_lat,max_lat,min_lon,max_lon,clat,clon);

lat_step=5;
lon_step=10;
m_proj('Equidistant cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);
%colormap('jet');
m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick',[round(min_lat):lat_step:round(max_lat)],'tickdir','in','color','k','lineweight',1.5);
hm=gca;
set(hm,'clipping','off')
hold on
m_pcolor(clon(r,c),clat(r,c),sm_cor_0(r,c));shading flat;colormap(bwr);caxis([-.5 .5])

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
            m_plot(x(ii),y(ii),'k','linewidth',.1)
        else
            m_plot(x(ii),y(ii),'k','linewidth',.1)
        end
        if cyc(ii(1))>=1
            m_plot(x(ii(1)),y(ii(1)),'k.','markersize',7)
            m_plot(x(ii(1)),y(ii(1)),'ko','markersize',2)
        else
            m_plot(x(ii(1)),y(ii(1)),'k.','markersize',7)
            m_plot(x(ii(1)),y(ii(1)),'ko','markersize',2)
        end
    end
end
grid
m_coast('patch',[0 0 0],'edgecolor','k');
hold off
axis normal

draw_regions_boxes
print -dpng -r300 ~/Documents/Publications/gaube_geographic_PNO/figs/BMC_map_with_cor


%%%EAC
load(['~/data/eddy/V5/','new_',curs{5},'_lat_lon_orgin_tracks'])
ii=find(track_jday>=startjd & track_jday<=endjd);
x=x(ii);y=y(ii);id=id(ii);cyc=cyc(ii);k=k(ii);track_jday=track_jday(ii);
lon=120:165;
lat=-50:-10;
% lat=min(y):max(y);
% lon=min(x):max(x);
figure(1)
clf
max_lat=max(lat(:));
min_lat=min(lat(:));
max_lon=max(lon(:));
min_lon=min(lon(:));
[r,c]=imap(min_lat,max_lat,min_lon,max_lon,clat,clon);
lat_step=5;
lon_step=10;
m_proj('Equidistant cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);
%colormap('jet');
m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick',[round(min_lat):lat_step:round(max_lat)],'tickdir','in','color','k','lineweight',1.5);
hm=gca;
set(hm,'clipping','off')
hold on
m_pcolor(clon(r,c),clat(r,c),sm_cor_0(r,c));shading flat;colormap(bwr);caxis([-.5 .5])

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
            m_plot(x(ii),y(ii),'k','linewidth',.1)
        else
            m_plot(x(ii),y(ii),'k','linewidth',.1)
        end
        if cyc(ii(1))>=1
            m_plot(x(ii(1)),y(ii(1)),'k.','markersize',7)
            m_plot(x(ii(1)),y(ii(1)),'ko','markersize',2)
        else
            m_plot(x(ii(1)),y(ii(1)),'k.','markersize',7)
            m_plot(x(ii(1)),y(ii(1)),'ko','markersize',2)
        end
    end
end
grid
m_coast('patch',[0 0 0],'edgecolor','k');
hold off
axis normal

draw_regions_boxes
print -dpng -r300 ~/Documents/Publications/gaube_geographic_PNO/figs/EAC_map_with_cor


%%CC
load(['~/data/eddy/V5/','new_',curs{19},'_lat_lon_orgin_tracks'])
ii=find(track_jday>=startjd & track_jday<=endjd);
x=x(ii);y=y(ii);id=id(ii);cyc=cyc(ii);k=k(ii);track_jday=track_jday(ii);
lon=180+(180-155):180+(180-105);
lat=25:50;
% lat=min(y):max(y);
% lon=min(x):max(x);
figure(1)
clf
max_lat=max(lat(:));
min_lat=min(lat(:));
max_lon=max(lon(:));
min_lon=min(lon(:));
[r,c]=imap(min_lat,max_lat,min_lon,max_lon,clat,clon);
lat_step=5;
lon_step=10;
m_proj('Equidistant cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);
%colormap('jet');
m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick',[round(min_lat):lat_step:round(max_lat)],'tickdir','in','color','k','lineweight',1.5);
hm=gca;
set(hm,'clipping','off')
hold on
m_pcolor(clon(r,c),clat(r,c),sm_cor_0(r,c));shading flat;colormap(bwr);caxis([-.5 .5])

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
            m_plot(x(ii),y(ii),'k','linewidth',.1)
        else
            m_plot(x(ii),y(ii),'k','linewidth',.1)
        end
        if cyc(ii(1))>=1
            m_plot(x(ii(1)),y(ii(1)),'k.','markersize',7)
            m_plot(x(ii(1)),y(ii(1)),'ko','markersize',2)
        else
            m_plot(x(ii(1)),y(ii(1)),'k.','markersize',7)
            m_plot(x(ii(1)),y(ii(1)),'ko','markersize',2)
        end
    end
end
grid
m_coast('patch',[0 0 0],'edgecolor','k');
hold off
axis normal

draw_regions_boxes
print -dpng -r300 ~/Documents/Publications/gaube_geographic_PNO/figs/CC_map_with_cor

%%%SIO

load(['~/data/eddy/V5/','new_',curs{18},'_lat_lon_orgin_tracks'])
ii=find(track_jday>=startjd & track_jday<=endjd);
x=x(ii);y=y(ii);id=id(ii);cyc=cyc(ii);k=k(ii);track_jday=track_jday(ii);
lon=30:130;
lat=-35:-15;
% lat=min(y):max(y);
% lon=min(x):max(x);
figure(1)
clf
set(gcf,'PaperPosition',[1 1 11 5])
max_lat=max(lat(:));
min_lat=min(lat(:));
max_lon=max(lon(:));
min_lon=min(lon(:));
[r,c]=imap(min_lat,max_lat,min_lon,max_lon,clat,clon);
lat_step=5;
lon_step=15;
m_proj('Equidistant cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);
%colormap('jet');
m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick',[round(min_lat):lat_step:round(max_lat)],'tickdir','in','color','k','lineweight',1.5);
hm=gca;
% set(hm,'clipping','off')
hold on
axis normal
m_pcolor(clon(r,c),clat(r,c),sm_cor_0(r,c));shading flat;colormap(bwr);caxis([-.5 .5])


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
            m_plot(x(ii),y(ii),'k','linewidth',.1)
        else
            m_plot(x(ii),y(ii),'k','linewidth',.1)
        end
        if cyc(ii(1))>=1
            m_plot(x(ii(1)),y(ii(1)),'k.','markersize',7)
            m_plot(x(ii(1)),y(ii(1)),'ko','markersize',2)
        else
            m_plot(x(ii(1)),y(ii(1)),'k.','markersize',7)
            m_plot(x(ii(1)),y(ii(1)),'ko','markersize',2)
        end
    end
end
grid
m_coast('patch',[0 0 0],'edgecolor','k');
hold off
draw_regions_boxes
axis normal
% daspect([1 2 1])
print -dpng -r300 ~/Documents/Publications/gaube_geographic_PNO/figs/SIO_map_with_cor


%%%SP
load(['~/data/eddy/V5/','new_',curs{9},'_lat_lon_orgin_tracks'])
ii=find(track_jday>=startjd & track_jday<=endjd);
x=x(ii);y=y(ii);id=id(ii);cyc=cyc(ii);k=k(ii);track_jday=track_jday(ii);
lon=175:180+(180-105);
lat=-30:-10;
% lat=min(y):max(y);
% lon=min(x):max(x);
figure(1)
clf
max_lat=max(lat(:));
min_lat=min(lat(:));
max_lon=max(lon(:));
min_lon=min(lon(:));
[r,c]=imap(min_lat,max_lat,min_lon,max_lon,clat,clon);
lat_step=5;
lon_step=10;
m_proj('Equidistant cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);
%colormap('jet');
m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick',[round(min_lat):lat_step:round(max_lat)],'tickdir','in','color','k','lineweight',1.5);
hm=gca;
set(hm,'clipping','off')
hold on
m_pcolor(clon(r,c),clat(r,c),sm_cor_0(r,c));shading flat;colormap(bwr);caxis([-.5 .5])

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
            m_plot(x(ii),y(ii),'k','linewidth',.1)
        else
            m_plot(x(ii),y(ii),'k','linewidth',.1)
        end
        if cyc(ii(1))>=1
            m_plot(x(ii(1)),y(ii(1)),'k.','markersize',7)
            m_plot(x(ii(1)),y(ii(1)),'ko','markersize',2)
        else
            m_plot(x(ii(1)),y(ii(1)),'k.','markersize',7)
            m_plot(x(ii(1)),y(ii(1)),'ko','markersize',2)
        end
    end
end
grid
m_coast('patch',[0 0 0],'edgecolor','k');
hold off
draw_regions_boxes
axis normal

print -dpng -r300 ~/Documents/Publications/gaube_geographic_PNO/figs/SP_map_with_cor
return

%%%SP dual region
load(['~/data/eddy/V5/','new_',curs{20},'_lat_lon_orgin_tracks'])
ii=find(track_jday>=startjd & track_jday<=endjd);
x=x(ii);y=y(ii);id=id(ii);cyc=cyc(ii);k=k(ii);track_jday=track_jday(ii);
lon=175:180+(180-105);
lat=-30:-10;
% lat=min(y):max(y);
% lon=min(x):max(x);
figure(1)
clf
max_lat=max(lat(:));
min_lat=min(lat(:));
max_lon=max(lon(:));
min_lon=min(lon(:));
lat_step=5;
lon_step=10;
m_proj('Equidistant cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);
%colormap('jet');
m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick',[round(min_lat):lat_step:round(max_lat)],'tickdir','in','color','k','lineweight',1.5);
hm=gca;
set(hm,'clipping','off')
hold on
m_pcolor(clon(r,c),clat(r,c),sm_cor_0(r,c));shading flat;colormap(bwr);caxis([-.5 .5])

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
        if cyc(ii(1))>=1
            m_plot(x(ii(1)),y(ii(1)),'r.','markersize',7)
            m_plot(x(ii(1)),y(ii(1)),'ko','markersize',2)
        else
            m_plot(x(ii(1)),y(ii(1)),'b.','markersize',7)
            m_plot(x(ii(1)),y(ii(1)),'ko','markersize',2)
        end
    end
end

load(['~/data/eddy/V5/','new_',curs{21},'_lat_lon_orgin_tracks'])
ii=find(track_jday>=startjd & track_jday<=endjd);
x=x(ii);y=y(ii);id=id(ii);cyc=cyc(ii);k=k(ii);track_jday=track_jday(ii);
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
        if cyc(ii(1))>=1
            m_plot(x(ii(1)),y(ii(1)),'r.','markersize',7)
            m_plot(x(ii(1)),y(ii(1)),'ko','markersize',2)
        else
            m_plot(x(ii(1)),y(ii(1)),'b.','markersize',7)
            m_plot(x(ii(1)),y(ii(1)),'ko','markersize',2)
        end
    end
end

grid
m_coast('patch',[0 0 0],'edgecolor','k');
hold off
draw_regions_boxes
axis normal

print -dpng -r300 figs/SP12_map

