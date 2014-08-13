clear all
want_id=[
	  143729
	  143726
	  141248
	  149011
	  125980
	  130666];

ff=1;

FRAME_DIR='/Volumes/matlab/matlab/eddy-wind/frames/good_ac/';
eval(['!toast ' FRAME_DIR '*'])

for zz=1:length(want_id)
%find track
load /Volumes/matlab/data/eddy/V4/global_tracks_V4
f1=find(id==want_id(zz) & track_jday>=2451556 & track_jday<=2454461);
x=x(f1);
y=y(f1);
id=id(f1);
k=k(f1);
jdays=track_jday(f1);
clearallbut x y id k jdays want_id zz ff

load rwp.pal
load bwr.pal
load chelle.pal
FRAME_DIR='/Volumes/matlab/matlab/eddy-wind/frames/good_ac/';
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
min_lon=min(x)-3;
max_lon=max(x)+20;

load(['/Volumes/matlab/data/eddy/V4/mat/AVISO_25_W_',num2str(jdays(1))],'lat','lon')
slat=lat;
slon=lon;
[rs,cs]=imap(min_lat,max_lat,min_lon,max_lon,slat,slon);

load(['/Volumes/matlab/data/QuickScat/mat/QSCAT_30_25km_',num2str(jdays(1))],'lat','lon')
[r,c]=imap(min_lat,max_lat,min_lon,max_lon,lat,lon);
fc=f_cor(lat);

load(['/Volumes/matlab/data/gsm/mat/GSM_9_21_',num2str(jdays(1))],'glat','glon')
glat=flipud(glat);
[cr,cc]=imap(min_lat,max_lat,min_lon,max_lon,glat,glon);



for m=1:length(k)

load(['/Volumes/matlab/data/eddy/V4/mat/AVISO_25_W_',num2str(jdays(m))],'ssh')
load(['/Volumes/matlab/data/QuickScat/mat/QSCAT_30_25km_',num2str(jdays(m))],'w_ek')
load(['/Volumes/matlab/data/gsm/mat/GSM_9_21_',num2str(jdays(m))],'nbp21_chl','bp26_mu')
ssh=ssh(41:600,:);
crl=w_ek;
chl=flipud(nbp21_chl);
mu=flipud(bp26_mu);



figure(1)
clf

%chl
subplot(332)
[ctr,ctc]=imap(gy(m),gy(m),gx(m),gx(m),glat,glon);
tc=ctc-7:ctc+7;
tr=ctr-7:ctr+7;
[ssctr,ssctc]=imap(gy(m),gy(m),gx(m),gx(m),lat,lon);
sstc=ssctc-7:ssctc+7;
sstr=ssctr-7:ssctr+7;
fmu=fillnans(interp2(double(mu(tr,tc)),'cubic'));
fssh=interp2(double(ssh(sstr,sstc)),'cubic');
pcolor(fmu(2:end,2:end));
shading interp
hold on
contour(fssh(2:end,2:end),[1:4:70],'k','LineWidth',2)
set(gca,'xticklabel',[],'yticklabel',[],'LineWidth',2)
hold on
line([15 15],[0 29],'color','k','LineWidth',2)
line([0 29],[15 15],'color','k','LineWidth',2)
axis image
caxis([-.08 .08])
hold off
title(' \mu Anomaly  ')
colormap(chelle)
freezecolors

%chl
subplot(333)
[ctr,ctc]=imap(gy(m),gy(m),gx(m),gx(m),glat,glon);
tc=ctc-7:ctc+7;
tr=ctr-7:ctr+7;
[ssctr,ssctc]=imap(gy(m),gy(m),gx(m),gx(m),lat,lon);
sstc=ssctc-7:ssctc+7;
sstr=ssctr-7:ssctr+7;
fchl=fillnans(interp2(double(chl(tr,tc)),'cubic'));
fssh=interp2(double(ssh(sstr,sstc)),'cubic');
pcolor(fchl(2:end,2:end));
shading interp
hold on
contour(fssh(2:end,2:end),[1:4:70],'k','LineWidth',2)
set(gca,'xticklabel',[],'yticklabel',[],'LineWidth',2)
hold on
line([15 15],[0 29],'color','k','LineWidth',2)
line([0 29],[15 15],'color','k','LineWidth',2)
axis image
caxis([-.08 .08])
hold off
title(' CHL Anomaly  ')
colormap(chelle)
freezecolors

%crl
subplot(331)
[ctr,ctc]=imap(gy(m),gy(m),gx(m),gx(m),lat,lon);
tc=ctc-7:ctc+7;
tr=ctr-7:ctr+7;
fcrl=interp2(double(crl(tr,tc)),'cubic');
pcolor(fcrl(2:end,2:end));
shading interp
hold on
contour(fssh(2:end,2:end),[1:4:70],'k','LineWidth',2)
set(gca,'xticklabel',[],'yticklabel',[],'LineWidth',2)
hold on
line([15 15],[0 29],'color','k','LineWidth',2)
line([0 29],[15 15],'color','k','LineWidth',2)
axis image
caxis([-.12 .12])
hold off
title(' Ekman Pumping  ')
colormap(bwr)
freezecolors
all_crl(:,:,m)=fcrl;
all_chl(:,:,m)=fchl;
all_mu(:,:,m)=fmu;



%map
subplot(3,3,[4 5 6])
%pmap(islon(irs,ics),islat(irs,ics),double(icrl(irs,ics)))
pmap(lon(r,c),lat(r,c),w_ek(r,c))
shading interp
caxis([-.2 .2])
hold on
m_contour(lon(r,c),lat(r,c),ssh(r,c),[-40:3:-3],'k--')
m_contour(lon(r,c),lat(r,c),ssh(r,c),[3:3:40],'k')
m_plot(x(1:m),y(1:m),'k','LineWidth',2)
title({'Filtered QuickSCAT Ekman Pumping  '})
m_coast('patch',[0 0 0]);
colormap(bwr)
freezecolors


%map
subplot(3,3,[7 8 9])
pmap(glon(cr,cc),glat(cr,cc),chl(cr,cc))
shading interp
caxis([-.1 .1])
hold on
m_contour(lon(r,c),lat(r,c),ssh(r,c),[-40:3:-3],'k--')
m_contour(lon(r,c),lat(r,c),ssh(r,c),[3:3:40],'k')
m_plot(x(1:m),y(1:m),'k','LineWidth',2)
title({'bp21-chl SeaWiFS CHL  '})
m_coast('patch',[0 0 0]);
colormap(chelle)
freezecolors
[year,month,day]=jd2jdate(jdays(m));
xlabel([num2str(year) '-' num2str(month) '-' num2str(day) ' frame ' num2str(ff) 'id = ' num2str(want_id(zz))])

eval(['print -dpng ' FRAME_DIR 'frame_' num2str(ff) '.png'])
ff=ff+1;

end
figure(1)
clf

subplot(131)
pcolor(nanmedian(all_crl,3));shading interp
caxis([-.12 .12])
axis image
title('Ekman Pumping  ')

subplot(132)
pcolor(nanmedian(all_mu,3));shading interp
caxis([-.08 .08])
axis image
title('\mu  ')

subplot(133)
pcolor(nanmedian(all_chl,3));shading interp
caxis([-.06 .06])
axis image
title('bp21-chl  ')

eval(['print -dpng ' FRAME_DIR 'frame_' num2str(ff) '.png'])
ff=ff+1;

end
%eval(['!cp ' FRAME_DIR 'frame_' num2str(m) '.png ' FRAME_DIR 'frame_1.png'])
eval(['!ffmpeg -i ' FRAME_DIR 'frame_%d.png -y ' FRAME_DIR 'out.mpg'])


