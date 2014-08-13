load chelle.pal
load rwp.pal
load bwr.pal

load /matlab/matlab/domains/larry_BMC_lat_lon.mat
elat=lat;
elon=lon;
max_lat=max(lat);
min_lat=min(lat);
max_lon=max(lon);
min_lon=min(lon);
load /matlab/data/gsm/cor_chl_ssh_out
load /matlab/data/gsm/mean_gchl.mat mean_gchl glat glon
%lat=glat;
%lon=glon;
[r,c]=imap(min_lat,max_lat,min_lon,max_lon,glat,glon);
[rb,cb]=imap(min_lat,max_lat+10,min_lon-20,max_lon+20,lat,lon);
[rg,cg]=imap(min_lat,max_lat+10,min_lon-20,max_lon+20,glat,glon);
load /matlab/matlab/regions/tracks/tight/bmc_tracks.mat x y id track_jday nneg k

startjd=2451395; %from mid_week_jdays of eddy files
endjd=2454804;

ii=find(track_jday>=startjd & track_jday<=endjd);
x=x(ii);
y=y(ii);
track_jday=track_jday(ii);
id=id(ii);

ai=find(id>=nneg);
ci=find(id<nneg);
auid=length(unique(id(ai)))
cuid=length(unique(id(ci)))
figure(1)
clf
m_proj('lambert','lon',[min(lon(1,cb)) max(lon(1,cb))],'lat',[min(lat(rb,1)) max(lat(rb,1))]);   
m_grid('xtick',[round(min(lon(1,cb))):20:round(max(lon(1,cb)))],'ytick',[round(min(lat(rb,1))):10:round(max(lat(rb,1)))],'tickdir','in','color','k','lineweight',1.5);  
hold on
m_pcolor(glon(rg,cg),glat(rg,cg),double(mean_gchl(rg,cg)))
shading flat
m_coast('patch',[0 0 0]);
grid
caxis([-1.3 .1])
colormap(chelle)
print -dpng -r300 figs/domains/bg_mean_gchl


figure(2)
clf
m_proj('lambert','lon',[min(lon(1,cb)) max(lon(1,cb))],'lat',[min(lat(rb,1)) max(lat(rb,1))]);   
m_grid('xtick',[round(min(lon(1,cb))):20:round(max(lon(1,cb)))],'ytick',[round(min(lat(rb,1))):10:round(max(lat(rb,1)))],'tickdir','in','color','k','lineweight',1.5);  
hold on
m_pcolor(glon(r,c),glat(r,c),double(mean_gchl(r,c)))
shading flat
m_coast('patch',[0 0 0]);
grid
caxis([-1.3 .1])
colormap(chelle)
print -dpng -r300 figs/domains/mean_gchl


figure(3)
clf
m_proj('lambert','lon',[min(lon(1,cb)) max(lon(1,cb))],'lat',[min(lat(rb,1)) max(lat(rb,1))]);   
m_grid('xtick',[round(min(lon(1,cb))):20:round(max(lon(1,cb)))],'ytick',[round(min(lat(rb,1))):10:round(max(lat(rb,1)))],'tickdir','in','color','k','lineweight',1.5);  
hold on

[jdays,is]=sort(track_jday);
x=x(is);
y=y(is);
id=id(is);
uid=unique(id);
hold on
%m_pcolor(x,y,amp);
uid=unique(id);
for m=1:length(uid)
	ii=find(id==uid(m));
	if id(m)>=nneg
		m_plot(x(ii),y(ii),'r','markersize',2)
	else
		m_plot(x(ii),y(ii),'b','markersize',2)
	end	
end


m_coast('patch',[0 0 0]);
grid
caxis([-1 1])
colormap(rwp)
print -dpng -r300 figs/domains/tracks

	
   		