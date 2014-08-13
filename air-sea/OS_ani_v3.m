clear all
%want_id=39788;
want_id=141248;
%want_id=149011

%find track
load /matlab/data/eddy/V4/global_tracks_V4
f1=find(id==want_id);
x=x(f1);
y=y(f1);
gx=gx(f1);
gy=gy(f1);
id=id(f1);
k=k(f1);
jdays=track_jday(f1);
clearallbut x y id k jdays gx gy

load rwp.pal
load bwr.pal
load chelle.pal
FRAME_DIR='/matlab/matlab/eddy-wind/frames/OS_ek_141248/';
ff=2;

min_lat=min(y)-3;
max_lat=max(y)+3;
min_lon=min(x)-3;
max_lon=max(x)+20;

load(['/matlab/data/eddy/V4/mat/AVISO_25_W_',num2str(jdays(1))],'hp66_crlg','lat','lon')
slat=lat;
slon=lon;
[rs,cs]=imap(min_lat,max_lat,min_lon,max_lon,slat,slon);

load(['/matlab/data/QuickScat/mat/QSCAT_30_25km_',num2str(jdays(1))],'bp62_crl','lat','lon')
[r,c]=imap(min_lat,max_lat,min_lon,max_lon,lat,lon);
ilon=interp2(lon);
ilat=interp2(lat);
[ir,ic]=imap(min_lat,max_lat,min_lon,max_lon,ilat,ilon);



for m=1:length(k)

load(['/matlab/data/eddy/V4/mat/AVISO_25_W_',num2str(jdays(m))],'hp66_crlg','ssh')
load(['/matlab/data/QuickScat/mat/QSCAT_30_25km_',num2str(jdays(m))],'w_ek','bp26_crl')
crlg=hp66_crlg;
crl=w_ek;
icrl=interp2(crl);



figure(1)
clf

%crlg
subplot(322)
[ctr,ctc]=imap(gy(m),gy(m),gx(m),gx(m),slat,slon);
tc=ctc-7:ctc+7;
tr=ctr-7:ctr+7;
fcrlg=interp2(1e5*double(crlg(tr,tc)),'cubic');
fssh=interp2(double(ssh(tr,tc)),'cubic');
pcolor(fcrlg);
shading interp
hold on
contour(fssh,[1:4:30],'k')
set(gca,'xticklabel',[])
set(gca,'yticklabel',[])
hold on
line([15 15],[0 29],'color','k')
line([0 29],[15 15],'color','k')
axis image
caxis([-1.2 1.2])
hold off
title('  Instantaneous Geostrophic Vorticity  ')
colormap(bwr)
freezecolors

%crl
subplot(321)
[ctr,ctc]=imap(gy(m),gy(m),gx(m),gx(m),lat,lon);
tc=ctc-7:ctc+7;
tr=ctr-7:ctr+7;
fcrl=interp2(double(crl(tr,tc)),'cubic');
pcolor(fcrl);
shading interp
hold on
contour(fssh,[1:4:30],'k')
set(gca,'xticklabel',[])
set(gca,'yticklabel',[])
hold on
line([15 15],[0 29],'color','k')
line([0 29],[15 15],'color','k')
axis image
caxis([-.2 .2])
hold off
title('  Instantaneous Ekman Pumping  ')
colormap(bwr)
freezecolors
all_crl(:,:,m)=fcrl;
all_crlg(:,:,m)=fcrlg;

%map
subplot(3,2,[3 4])
%pmap(islon(irs,ics),islat(irs,ics),double(icrl(irs,ics)))
pmap(lon(r,c),lat(r,c),-1e5*bp26_crl(r,c))
shading interp
caxis([-.5 .5])
hold on
m_contour(slon(rs,cs),slat(rs,cs),ssh(rs,cs),[-40:3:-3],'k--')
m_contour(slon(rs,cs),slat(rs,cs),ssh(rs,cs),[3:3:40],'k')
m_plot(x(1:m),y(1:m),'k','LineWidth',2)
[mon,day,yea]=jd2jdate(jdays(m));
title({'-Wind Vorticity  ',[num2str(mon),'-',num2str(day),'-',num2str(yea)]})
m_coast('patch',[0 0 0]);;
colormap(bwr)
freezecolors
%comps

subplot(325)
pcolor(nanmean(all_crl,3));shading interp
set(gca,'xticklabel',[])
set(gca,'yticklabel',[])
hold on
line([15 15],[0 29],'color','k')
line([0 29],[15 15],'color','k')
axis image
caxis([-.2 .2])
title({'  Composite Average of   ','  Ekman Pumping   '})
colormap(bwr)
freezecolors

subplot(326)
pcolor(nanmean(all_crlg,3));shading interp
set(gca,'xticklabel',[])
set(gca,'yticklabel',[])
hold on
line([15 15],[0 29],'color','k')
line([0 29],[15 15],'color','k')
axis image
caxis([-1.2 1.2])
title({'  Composite Average of   ','  Geostrophic Vorticity   '})
colormap(bwr)
freezecolors
eval(['print -dpng -r300 ' FRAME_DIR 'frame_' num2str(ff) '.png'])
ff=ff+1;

end
eval(['!cp ' FRAME_DIR 'frame_' num2str(m) '.png ' FRAME_DIR 'frame_1.png'])
eval(['!ffmpeg -i ' FRAME_DIR 'frame_%d.png -y ' FRAME_DIR 'out.mpg'])

