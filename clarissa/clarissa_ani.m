load /matlab/data/eddy/V4/full_tracks/dCC_lat_lon_tracks.mat x y id track_jday k lat lon amp
min_lat=min(lat);
max_lat=max(lat);
min_lon=min(lon);
max_lon=max(lon);
alljdays=[2451556:7:2454461];

ii=find(track_jday>=alljdays(1) & track_jday<=alljdays(end) & y>=26);

x=x(ii);
y=y(ii);
id=id(ii);
track_jday=track_jday(ii);
k=k(ii);
amp=amp(ii);

l=find(k>52);
uid=unique(id(l));
longs=sames(uid,id);
long_id=id(longs);
goods=find(k(longs)==1);

good_uid=unique(long_id(goods));
length(good_uid)

igood=sames(good_uid,id);



map_lat=min(y(igood)):max(y(igood));
map_lon=min(x(igood)):max(x(igood))+5;

figure(1)
clf
pmap(map_lon,map_lat,[x(igood) y(igood) id(igood) track_jday(igood)],'tracks')


cd frames/test/
!toast *.png
for edd=6:length(good_uid)
ff=1;
fff=1;
load /matlab/data/eddy/V4/full_tracks/dCC_lat_lon_tracks.mat x y id track_jday k lat lon amp
ii=find(track_jday>=alljdays(1) & track_jday<=alljdays(end) & y>=26);
x=x(ii);
y=y(ii);
id=id(ii);
track_jday=track_jday(ii);
k=k(ii);
amp=amp(ii);

f1=find(id==good_uid(edd));
x=x(f1);
y=y(f1);
id=id(f1);
k=k(f1);
jdays=track_jday(f1);
amp=amp(f1);

min_lat=min(y)-3;
max_lat=max(y)+3;
min_lon=min(x)-5;
max_lon=250;

load chelle.pal
load bwr.pal
load rwp.pal

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

if any(x)

load(['/matlab/data/eddy/V4/mat/AVISO_25_W_',num2str(jdays(1))],'lat','lon')
slat=lat;
slon=lon;
islat=interp2(slat);
islon=interp2(slon);
[rs,cs]=imap(min_lat,max_lat,min_lon,max_lon,islat,islon);
load(['/matlab/data/QuickScat/mat/QSCAT_30_25km_',num2str(jdays(1))],'lat','lon')
[r,c]=imap(min_lat,max_lat,min_lon,max_lon,lat,lon);
fc=f_cor(lat);
ilon=interp2(lon);
ilat=interp2(lat);
load(['/matlab/data/gsm/mat/GSM_9_21_',num2str(jdays(1))],'glat','glon')
[cr,cc]=imap(min_lat,max_lat,min_lon,max_lon,glat,glon);
iglat=interp2(glat);
iglon=interp2(glon);
[rg,cg]=imap(min_lat,max_lat,min_lon,max_lon,iglat,iglon);

load /matlab/data/gsm/mask
figure(2)
clf
pmap(map_lon,map_lat,[x y id jdays],'tracks')
title(['Eddy # ',num2str(id(1))])
eval(['print -dpng -r100 frame_' num2str(ff) '.png'])
ff=ff+1;


for m=1:length(k)
load(['/matlab/data/eddy/V4/mat/AVISO_25_W_',num2str(jdays(m))],'ssh','bp26_crlg')
load(['/matlab/data/QuickScat/mat/QSCAT_30_25km_',num2str(jdays(m))],'w_ek')
load(['/matlab/data/gsm/mat/GSM_9_21_',num2str(jdays(m))],'bp26_chl','sp66_chl')
issh=interp2(ssh);
ichl=interp2(sp66_chl.*mask);
ism=interp2(bp26_chl);
chl=bp26_chl.*mask;
hpchl=sp66_chl.*mask;
[mon,day,yea]=jd2jdate(jdays(m));


figure(2)
clf

subplot(3,3,[7 8 9])
%pmap(islon(irs,ics),islat(irs,ics),double(icrl(irs,ics)))
%pmap(glon(cr,cc),glat(cr,cc),mu(cr,cc))
pmap(iglon(rg,cg),iglat(rg,cg),ichl(rg,cg))
shading flat
caxis([-.1 .1])
hold on
m_contour(islon(rs,cs),islat(rs,cs),issh(rs,cs),[-300:2:-2],'color',[.5 .5 .5])
m_contour(islon(rs,cs),islat(rs,cs),issh(rs,cs),[2:2:300],'k')
m_plot(x(1:m),y(1:m),'k','LineWidth',2)
m_plot(x(m),y(m),'k.','markersize',15)
m_coast('patch',[0 0 0]);
colormap(chelle)
%title('Plankton')
freezecolors
niceplot
xlabel(['amp = ',num2str(amp(m)),'   x = ',num2str(x(m)-360),'   y = ',num2str(y(m)),'  '])



subplot(3,3,[4 5 6])
%pmap(islon(irs,ics),islat(irs,ics),double(icrl(irs,ics)))
%pmap(glon(cr,cc),glat(cr,cc),mu(cr,cc))
pmap(iglon(rg,cg),iglat(rg,cg),ism(rg,cg))
shading flat
caxis([-.2 .2])
hold on
m_contour(islon(rs,cs),islat(rs,cs),issh(rs,cs),[-300:2:-2],'color',[.5 .5 .5])
m_contour(islon(rs,cs),islat(rs,cs),issh(rs,cs),[2:2:300],'k')
m_plot(x(1:m),y(1:m),'k','LineWidth',2)
m_plot(x(m),y(m),'k.','markersize',15)
m_coast('patch',[0 0 0]);
colormap(chelle)
%title('Plankton w/o clouds')
freezecolors
niceplot


[chl_r,chl_c]=imap(y(m)-3,y(m)+3,x(m)-3,x(m)+3,glat,glon);
[eddy_r,eddy_c]=imap(y(m)-3,y(m)+3,x(m)-3,x(m)+3,slat,slon);
[wek_r,wek_c]=imap(y(m)-3,y(m)+3,x(m)-3,x(m)+3,lat,lon);

subplot(3,3,1)
[ctr,ctc]=imap(gy(m),gy(m),gx(m),gx(m),lat,lon);
tc=ctc-7:ctc+7;
tr=ctr-7:ctr+7;
fwek=interp2(double(w_ek(tr,tc)),'cubic');

[ctr,ctc]=imap(gy(m),gy(m),gx(m),gx(m),slat,slon);
tc=ctc-7:ctc+7;
tr=ctr-7:ctr+7;
fssh=interp2(double(ssh(tr,tc)),'cubic');
pcolor(fwek);
shading flat
colormap(bwr)
hold on
contour(fssh,[2:2:100],'k')
contour(fssh,[-100:2:-2],'color',[.5 .5 .5])
%colorbar
set(gca,'xticklabel',[])
set(gca,'yticklabel',[])
hold on
line([15 15],[0 29],'color','k')
line([0 29],[15 15],'color','k')
axis image
caxis([-.1 .1])
hold off
title('Upwelling/Downwelling')
xlabel(['frame # ',num2str(fff)])
niceplot
freezecolors

subplot(3,3,3)
[ctr,ctc]=imap(gy(m),gy(m),gx(m),gx(m),glat,glon);
tc=ctc-7:ctc+7;
tr=ctr-7:ctr+7;
fchl=flipud(interp2(double(hpchl(tr,tc)),'cubic'));
pcolor(fchl);
shading flat
hold on
contour(fssh,[2:2:100],'k')
contour(fssh,[-100:2:-2],'color',[.5 .5 .5])
%colorbar
set(gca,'xticklabel',[])
set(gca,'yticklabel',[])
hold on
line([15 15],[0 29],'color','k')
line([0 29],[15 15],'color','k')
axis image
caxis([-.05 .05])
title('Plankton')
%xlabel([num2str(mon),'-',num2str(day),'-',num2str(yea)])
colormap(chelle)
freezecolors
hold off
niceplot

subplot(3,3,2)
[ctr,ctc]=imap(gy(m),gy(m),gx(m),gx(m),glat,glon);
tc=ctc-7:ctc+7;
tr=ctr-7:ctr+7;
fchl=flipud(interp2(double(chl(tr,tc)),'cubic'));
pcolor(fchl);
shading flat
hold on
contour(fssh,[2:2:100],'k')
contour(fssh,[-100:2:-2],'color',[.5 .5 .5])
%colorbar
set(gca,'xticklabel',[])
set(gca,'yticklabel',[])
hold on
line([15 15],[0 29],'color','k')
line([0 29],[15 15],'color','k')
axis image
caxis([-.08 .08])
title('Plankton w/out clouds')
xlabel([num2str(mon),'-',num2str(day),'-',num2str(yea)])
colormap(chelle)
freezecolors
hold off
niceplot

eval(['print -dpng -r100 frame_' num2str(ff) '.png'])
ff=ff+1;
%eval(['print -dpng -r100 frame_' num2str(ff) '.png'])
%ff=ff+1;
%eval(['print -dpng -r100 frame_' num2str(ff) '.png'])
%ff=ff+1;
fff=fff+1;
clear w_ek ssh bp26_chl fwek fssh
end
end
png2mpg
eval(['!mv output.mpg eddy_',num2str(good_uid(edd)),'.mpg'])
!toast *.png
end

cd ../../