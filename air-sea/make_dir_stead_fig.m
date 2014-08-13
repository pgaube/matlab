load ~/data/QuickSCAT/mean_qscat
lat = -69.875:0.25:69.875;
lon = 0.125:0.25:359.875;
[lon,lat]=meshgrid(lon,lat);
[r,c]=imap(-60,60,0,360,lat,lon);

vscale=0;

spd=sqrt(u_bar.^2+v_bar.^2);


figure(1)
clf
% pmap(lon(r,c),lat(r,c),spd(r,c))
% caxis([1 7])
pmap(lon(r,c),lat(r,c),dir_steady(r,c))
caxis([0 1])
hold on
lon=lon(r,c);
lat=lat(r,c);
u_bar=u_bar(r,c);
v_bar=v_bar(r,c);
lat_step=3.75/.25;
lon_step=6.25/.25;
spd=sqrt(u_bar.^2+v_bar.^2);
ii=find(spd>12);
u_bar(ii)=nan;
v_bar(ii)=nan;
m_quiver(lon(1:lat_step:end,1:lon_step:end),lat(1:lat_step:end,1:lon_step:end),u_bar(1:lat_step:end,1:lon_step:end),v_bar(1:lat_step:end,1:lon_step:end),vscale,'k')
draw_air_sea_regions
print -dpng -r300 figs/dir_steady_vector
!open figs/dir_steady_vector.png



lat = -69.875:0.25:69.875;
lon = 0.125:0.25:359.875;
[lon,lat]=meshgrid(lon,lat);
[r,c]=imap(-60,60,0,360,lat,lon);
lon=lon(r,c);
lat=lat(r,c);


u=u_bar;
v=v_bar;

ii=find(spd<4.9 | spd>5.1);
u(ii)=nan;
v(ii)=nan;

figure(2)
clf
pmap(lon,lat,nan*dir_steady(r,c))
m_quiver(lon(1:lat_step:end,1:lon_step:end),lat(1:lat_step:end,1:lon_step:end),u(1:lat_step:end,1:lon_step:end),v(1:lat_step:end,1:lon_step:end),vscale,'k')
print -dpng -r300 figs/vector_scale
!open figs/vector_scale.png