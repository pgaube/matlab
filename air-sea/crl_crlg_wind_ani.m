clear all
%want_id=39788;
want_id=149011 ;


%find track
load ~/data/eddy/V4/global_tracks_V4
f1=find(id==want_id);
x=x(f1);
gx=gx(f1);
gy=gy(f1);
y=y(f1);
id=id(f1);
k=k(f1);
jdays=track_jday(f1);
clearallbut x y id k jdays gx gy

load rwp.pal
load chelle.pal
FRAME_DIR='/matlab/matlab/air-sea/frames/na_crlg_eddy_nomap/';
ff=1;

%grid x y
  

min_lat=min(y)-3;
max_lat=max(y)+3;
min_lon=min(x)-3;
max_lon=max(x)+5;

load(['~/data/eddy/V5/mat/AVISO_25_W_',num2str(jdays(1))],'bp26_crlg','lat','lon')
slat=lat;
slon=lon;
islat=interp2(slat);
islon=interp2(slon);
[rs,cs]=imap(min_lat,max_lat,min_lon,max_lon,slat,slon);
[irs,ics]=imap(min_lat,max_lat,min_lon,max_lon,islat,islon);

load(['~/data/QuickScat/mat/QSCAT_30_25km_',num2str(jdays(1))],'hp66_crl','lat','lon')
[r,c]=imap(min_lat,max_lat,min_lon,max_lon,lat,lon);
ilon=interp2(lon);
ilat=interp2(lat);
[ir,ic]=imap(min_lat,max_lat,min_lon,max_lon,ilat,ilon);



for m=1:length(k)

load(['~/data/eddy/V5/mat/AVISO_25_W_',num2str(jdays(m))],'bp26_crlg','ssh')
load(['~/data/QuickScat/mat/QSCAT_30_25km_',num2str(jdays(m))],'bp26_crl','hp66_crl','u_week','v_week')
load(['~/data/rand/RAND_W_',num2str(jdays(m))],'na_crlg')
crlg=bp26_crlg;
crl=-hp66_crl;
bp=-bp26_crl;
na=na_crlg;
%{
icrl=interp2(crl);
ibp=interp2(bp);
issh=interp2(ssh);
ina=interp2(na);
%}

figure(1)
clf

%crlg
subplot(231)
[ctr,ctc]=imap(gy(m),gy(m),gx(m),gx(m),slat,slon);
tc=ctc-7:ctc+7;
tr=ctr-7:ctr+7;
fcrlg=interp2(1e5*double(crlg(tr,tc)),'cubic');
fssh=interp2(double(ssh(tr,tc)),'cubic');
pcolor(fcrlg);
shading flat
hold on
contour(fssh,[1:5:100],'k')
set(gca,'xticklabel',[])
set(gca,'yticklabel',[])
hold on
line([15 15],[0 29],'color','k')
line([0 29],[15 15],'color','k')
axis image
caxis([-1 1])
hold off
title({'Instantaneous    ','Geostrophic Vorticity  '})
%niceplot

%na_crlg
subplot(232)
[ctr,ctc]=imap(gy(m),gy(m),gx(m),gx(m),lat,lon);
tc=ctc-7:ctc+7;
tr=ctr-7:ctr+7;
quiver(u_week(tr,tc),v_week(tr,tc));
fnu=interp2(1e5*double(u_week(tr,tc)),'cubic');
fnv=interp2(1e5*double(v_week(tr,tc)),'cubic');
wspd=sqrt(fnu.^2+fnv.^2);
shading flat
set(gca,'xticklabel',[])
set(gca,'yticklabel',[])
hold on
axis image
hold off
title({'Instantaneous    ','Wind  '})
%niceplot

%crl
subplot(233)
[ctr,ctc]=imap(gy(m),gy(m),gx(m),gx(m),lat,lon);
tc=ctc-7:ctc+7;
tr=ctr-7:ctr+7;
fcrl=interp2(1e5*double(crl(tr,tc)),'cubic');
pcolor(fcrl);
shading flat
hold on
contour(fssh,[1:5:100],'k')
set(gca,'xticklabel',[])
set(gca,'yticklabel',[])
hold on
line([15 15],[0 29],'color','k')
line([0 29],[15 15],'color','k')
axis image
caxis([-1 1])
hold off
title({'Instantaneous   ','Wind Vorticity  '})
%niceplot

all_crl(:,:,m)=fcrl;
all_crlg(:,:,m)=fcrlg;
all_na(:,:,m)=wspd;

%comps
%crl
subplot(236)
pcolor(nanmean(all_crl,3));shading interp
hold on
contour(nanmean(all_crl,3),[-5:.2:5],'k');
caxis([-1 1])
set(gca,'xticklabel',[])
set(gca,'yticklabel',[])
hold on
line([15 15],[0 29],'color','k')
line([0 29],[15 15],'color','k')
axis image
caxis([-1 1])
title({'Composite Average of   ','Wind Vorticity   '})
%niceplot

%wspd
subplot(235)
pcolor(nanmean(all_na,3));shading interp
hold on
contour(nanmean(all_na,3),[-5:.2:5],'k');
set(gca,'xticklabel',[])
set(gca,'yticklabel',[])
hold on
line([15 15],[0 29],'color','k')
line([0 29],[15 15],'color','k')
axis image
%caxis([-1 1])
title({'Composite Average of   ','wind speed   '})
colormap(chelle)
[mon,day,yea]=jd2jdate(jdays(m));
text(3,40,[num2str(mon),'-',num2str(day),'-',num2str(yea)])
%niceplot

%crlg
subplot(234)
pcolor(nanmean(all_crlg,3));shading interp
hold on
contour(nanmean(all_crlg,3),[-5:.2:5],'k');
set(gca,'xticklabel',[])
set(gca,'yticklabel',[])
hold on
line([15 15],[0 29],'color','k')
line([0 29],[15 15],'color','k')
axis image
caxis([-1 1])
title({'Composite Average of   ','Geostrophic Vorticity   '})
colormap(chelle)
[mon,day,yea]=jd2jdate(jdays(m));
%niceplot
return

eval(['print -dpng -r100 ' FRAME_DIR 'frame_' num2str(ff) '.png'])
%{
ff=ff+1;
eval(['print -dpng -r100 ' FRAME_DIR 'frame_' num2str(ff) '.png'])
ff=ff+1;
eval(['print -dpng -r100 ' FRAME_DIR 'frame_' num2str(ff) '.png'])
%}
ff=ff+1;

end
pp=pwd;
cd(FRAME_DIR)
%!cp frame_131.png frame_1.png
png2mpg
cd(pp)