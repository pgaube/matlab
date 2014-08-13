function [zz]=panimate_ac(want_id,FRAME_DIR)
ff=1;
warning('off','all')


eval(['mkdir ' FRAME_DIR])
eval(['!toast ' FRAME_DIR '*'])

for zz=1:length(want_id)
%find track
load /matlab/data/eddy/V4/global_tracks_V4
f1=find(id==want_id(zz) & track_jday>=2451556 & track_jday<=2454461);
if any(f1)
x=x(f1);
df=x(2:end)-x(1:end-1);
ix=find(df>100);
if any(ix)
	x(1:ix)=x(1:ix)+360;
end
y=y(f1);
id=id(f1);
k=k(f1);
jdays=track_jday(f1);
clearallbut x y id k jdays want_id zz ff FRAME_DIR


load rwp.pal
load bwr.pal
load chelle.pal
%eval(['!toast ' FRAME_DIR '*'])


%grid x y
for m=1:length(x)
	tx=x(m);
	ty=y(m);
	tmpxs=floor(tx)-2.125:.25:ceil(tx)+2.125;
	tmpys=floor(ty)-2.125:.25:ceil(ty)+2.125;
    disx = abs(tmpxs-tx);
    disy = abs(tmpys-ty);
    iminx=find(disx==min(disx));
    iminy=find(disy==min(disy));
    gx(m)=tmpxs(iminx(1));
    gy(m)=tmpys(iminy(1));
end    

min_lat=min(y)-3;
max_lat=max(y)+3;
min_lon=min(x)-5;
max_lon=max(x)+15;

load(['/matlab/data/eddy/V4/mat/AVISO_25_W_',num2str(jdays(1))],'lat','lon')
slon=cat(2,lon,lon+360);
slat=cat(2,lat,lat);

[rs,cs]=imap(min_lat,max_lat,min_lon,max_lon,slat,slon);

load(['/matlab/data/QuickScat/mat/QSCAT_30_25km_',num2str(jdays(1))],'lat','lon')
lon=cat(2,lon,lon+360);
lat=cat(2,lat,lat);
[r,c]=imap(min_lat,max_lat,min_lon,max_lon,lat,lon);
fc=f_cor(lat);

load(['/matlab/data/gsm/mat/GSM_9_21_',num2str(jdays(1))],'glat','glon')
glon=cat(2,glon,glon+360);
glat=cat(2,glat,glat);
glat=flipud(glat);
[cr,cc]=imap(min_lat,max_lat,min_lon,max_lon,glat,glon);



for m=1:length(k)

load(['/matlab/data/eddy/V4/mat/AVISO_25_W_',num2str(jdays(m))],'ssh')
load(['/matlab/data/QuickScat/mat/QSCAT_30_25km_',num2str(jdays(m))],'w_ek')
load(['/matlab/data/gsm/mat/GSM_9_21_',num2str(jdays(m))],'bp26_chl','sm_gchl_week','bp21_car')
load(['/matlab/data/mu/mat/MU_25_30_',num2str(jdays(m))],'bp21_mu')
ssh=cat(2,ssh(41:600,:),ssh(41:600,:));
crl=cat(2,w_ek,w_ek);
chl=cat(2,flipud(bp26_chl),flipud(bp26_chl));
mu=cat(2,flipud(bp21_mu),flipud(bp21_mu));
full_chl=cat(2,flipud(sm_gchl_week),flipud(sm_gchl_week));
car=cat(2,flipud(bp21_car),flipud(bp21_car));



figure(1)
clf




subplot(4,3,[1 2 3])
%pmap(islon(irs,ics),islat(irs,ics),double(icrl(irs,ics)))
%pmap(glon(cr,cc),glat(cr,cc),mu(cr,cc))
pmap(lon(r,c),lat(r,c),ssh(r,c))
shading interp
caxis([-30 30])
hold on
m_contour(lon(r,c),lat(r,c),ssh(r,c),[-300:3:-2],'color', [.5 .5 .5])
m_contour(lon(r,c),lat(r,c),ssh(r,c),[2:3:300],'k')
m_plot(x(1:m),y(1:m),'k','LineWidth',2)
title({'Filtered SSH  '})
m_coast('patch',[0 0 0]);
colormap(chelle)
freezecolors

%map
subplot(4,3,[7 8 9])
%pmap(islon(irs,ics),islat(irs,ics),double(icrl(irs,ics)))
%pmap(glon(cr,cc),glat(cr,cc),mu(cr,cc))
pmap(glon(cr,cc),glat(cr,cc),car(cr,cc))
shading interp
caxis([-.1 .1])
hold on
m_contour(lon(r,c),lat(r,c),ssh(r,c),[-300:3:-2],'color', [.5 .5 .5])
m_contour(lon(r,c),lat(r,c),ssh(r,c),[2:3:300],'k')
m_plot(x(1:m),y(1:m),'k','LineWidth',2)
m_coast('patch',[0 0 0]);
colormap(chelle)
freezecolors
title('filter Car')

subplot(4,3,[4 5 6])
pmap(glon(cr,cc),glat(cr,cc),full_chl(cr,cc))
shading interp
%caxis([-.15 .15])
ran=caxis;
%caxis([-1.5 -.7])
hold on
m_contour(lon(r,c),lat(r,c),ssh(r,c),[-300:3:-2],'color', [.5 .5 .5])
m_contour(lon(r,c),lat(r,c),ssh(r,c),[2:3:300],'k')
m_plot(x(1:m),y(1:m),'k','LineWidth',2)
%ylabel({'Smoothed CHL'})
caxis(ran)
m_coast('patch',[0 0 0]);
colormap(chelle)
freezecolors
title('smoothed CHL')

%map
subplot(4,3,[10 11 12])
pmap(glon(cr,cc),glat(cr,cc),chl(cr,cc))
shading interp
caxis([-.1 .1])
hold on
m_contour(lon(r,c),lat(r,c),ssh(r,c),[-300:4:-2],'color', [.5 .5 .5])
m_contour(lon(r,c),lat(r,c),ssh(r,c),[2:4:300],'k')
m_plot(x(1:m),y(1:m),'k','LineWidth',2)
%ylabel({'Filtered CHL'})
m_coast('patch',[0 0 0]);
colormap(chelle)
freezecolors
title('filtered CHL')
[year,month,day]=jd2jdate(jdays(m));
xlabel([num2str(year) '-' num2str(month) '-' num2str(day) ' frame ' num2str(ff) ' id = ' num2str(want_id(zz))])
eval(['print -dpng ' FRAME_DIR 'frame_' num2str(ff) '.png'])
ff=ff+1;

end
%{
figure(1)
clf

subplot(131)
pcolor(nanmedian(all_crl,3));shading interp
caxis([-.12 .12])
axis image
title('Ekman Pumping  ')



subplot(132)
pcolor(nanmedian(all_mu,3));shading interp
caxis([-.05 .05])
axis image
title('\mu  ')


subplot(133)
pcolor(nanmedian(all_chl,3));shading interp
caxis([-.05 .05])
axis image
title('bp21-chl  ')
eval(['print -dpng ' FRAME_DIR 'frame_' num2str(ff) '.png'])
ff=ff+1;
%}
end
end
%eval(['!cp ' FRAME_DIR 'frame_' num2str(m) '.png ' FRAME_DIR 'frame_1.png'])
eval(['!ffmpeg -i ' FRAME_DIR 'frame_%d.png -y ' FRAME_DIR 'out.mpg'])
%eval(['!ffmpeg -r 5 -i ' FRAME_DIR 'frame_%d.png -y ' FRAME_DIR 'hd_out.mp4'])
warning('on','all')


