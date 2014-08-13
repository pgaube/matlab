clear all
%want_id=39788;
want_id=149011 ;



%find track
load /matlab/data/eddy/V4/global_tracks_V4
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
FRAME_DIR='/matlab/matlab/air-sea/frames/wek_wek_crlg_eddy/';
ff=2;

%grid x y
  

min_lat=min(y)-3;
max_lat=max(y)+3;
min_lon=min(x)-3;
max_lon=max(x)+5;

load(['/matlab/data/eddy/V4/mat/AVISO_25_W_',num2str(jdays(1))],'bp26_crlg','lat','lon')
slat=lat;
slon=lon;
islat=interp2(slat);
islon=interp2(slon);
[rs,cs]=imap(min_lat,max_lat,min_lon,max_lon,slat,slon);
[irs,ics]=imap(min_lat,max_lat,min_lon,max_lon,islat,islon);
 
load(['/matlab/data/QuickScat/mat/QSCAT_30_25km_',num2str(jdays(1))],'bp26_crl','lat','lon')
[r,c]=imap(min_lat,max_lat,min_lon,max_lon,lat,lon);
ilon=interp2(lon);
ilat=interp2(lat);
[ir,ic]=imap(min_lat,max_lat,min_lon,max_lon,ilat,ilon);



for m=1:length(k)

load(['/matlab/data/QuickScat/mat/QSCAT_30_25km_',num2str(jdays(m))],'w_ek','wek_crlg_week')
load(['/matlab/data/eddy/V4/mat/AVISO_25_W_',num2str(jdays(m))],'bp26_crlg','ssh')

crlg=wek_crlg_week;
crl=100*w_ek;
icrl=interp2(crl);
ibp=interp2(crlg);
issh=interp2(ssh);


figure(1)
clf

%crlg
subplot(322)
[ctr,ctc]=imap(gy(m),gy(m),gx(m),gx(m),slat,slon);
tc=ctc-7:ctc+7;
tr=ctr-7:ctr+7;
fssh=interp2(double(ssh(tr,tc)),'cubic');
[ctr,ctc]=imap(gy(m),gy(m),gx(m),gx(m),lat,lon);
tc=ctc-7:ctc+7;
tr=ctr-7:ctr+7;
fcrlg=interp2(double(crlg(tr,tc)),'cubic');
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
caxis([-20 20])
hold off
title({'Instantaneous    ','Current-induced Ekman Upwelling  '})
niceplot

%crl
subplot(321)
[ctr,ctc]=imap(gy(m),gy(m),gx(m),gx(m),lat,lon);
tc=ctc-7:ctc+7;
tr=ctr-7:ctr+7;
fcrl=interp2(double(crl(tr,tc)),'cubic');
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
caxis([-20 20])
hold off
title({'Instantaneous   ','Observed Ekman Upwelling  '})
niceplot

all_crl(:,:,m)=fcrl;
all_crlg(:,:,m)=fcrlg;

%map
subplot(3,2,[3 4])
pmap(islon(irs,ics),islat(irs,ics),double(issh(irs,ics)))
m_contour(islon(irs,ics),islat(irs,ics),double(issh(irs,ics)),[-100:5:-5],'color',[.5 .5 .5])
m_contour(islon(irs,ics),islat(irs,ics),double(issh(irs,ics)),[5:5:100],'k')

%pmap(slon(rs,cs),slat(rs,cs),nan*ssh(rs,cs))
shading interp
caxis([-20 20])
hold on
m_plot(x(1:m),y(1:m),'k','LineWidth',2)
[mon,day,yea]=jd2jdate(jdays(m));
title({'SSH of Eddies  ',[num2str(mon),'-',num2str(day),'-',num2str(yea)]})
m_coast('patch',[0 0 0]);
niceplot

%comps

subplot(325)
pcolor(nanmean(all_crl,3));shading interp
hold on
contour(nanmean(all_crl,3),[-50:3:50],'k');
caxis([-20 20])
set(gca,'xticklabel',[])
set(gca,'yticklabel',[])
hold on
line([15 15],[0 29],'color','k')
line([0 29],[15 15],'color','k')
axis image
caxis([-20 20])
title({'Composite Average of   ','Observed Ekman Upwelling   '})
niceplot

subplot(326)
pcolor(nanmean(all_crlg,3));shading interp
hold on
contour(nanmean(all_crlg,3),[-50:3:50],'k');
set(gca,'xticklabel',[])
set(gca,'yticklabel',[])
hold on
line([15 15],[0 29],'color','k')
line([0 29],[15 15],'color','k')
axis image
caxis([-20 20])
title({'Composite Average of   ','Current-induced Ekman Upwelling   '})
colormap(chelle)
niceplot


eval(['print -dpng -r100 ' FRAME_DIR 'frame_' num2str(ff) '.png'])
ff=ff+1;
eval(['print -dpng -r100 ' FRAME_DIR 'frame_' num2str(ff) '.png'])
ff=ff+1;
eval(['print -dpng -r100 ' FRAME_DIR 'frame_' num2str(ff) '.png'])
ff=ff+1;
%}
end
pp=pwd;
cd(FRAME_DIR)
eval(['!cp frame_',num2str(ff),'.png frame_1.png'])
png2mpg
cd(pp)