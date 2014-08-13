clear all
want_id=153341%141248;


%find track
load /Volumes/matlab/data/eddy/V4/global_tracks_V4
f1=find(id==want_id);
x=x(f1);
y=y(f1);
id=id(f1);
k=k(f1);
jdays=track_jday(f1);
clearallbut x y id k jdays

if jdays(1)<2450821
	jdays=[2450821:7:jdays(end)];
end	
load rwp.pal
load bwr.pal
load chelle.pal
FRAME_DIR='/Volumes/matlab/matlab/eddy-wind/frames/OS_ek_chl/';
eval(['!toast ' FRAME_DIR '*'])
ff=2;

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
    gy(m)=tmpys(iminy(1))+.25;
end    

min_lat=min(y)-3;
max_lat=max(y)+3;
min_lon=min(x)-3;
max_lon=max(x)+7;

load(['/Volumes/matlab/data/eddy/V4/mat/AVISO_25_W_',num2str(jdays(1))],'hp66_crlg','lat','lon')
slat=lat;
slon=lon;
[rs,cs]=imap(min_lat,max_lat,min_lon,max_lon,slat,slon);

load(['/Volumes/matlab/data/QuickScat/new_mat/QSCAT_21_25km_',num2str(jdays(1))],'lat','lon')
[r,c]=imap(min_lat,max_lat,min_lon,max_lon,lat,lon);

load(['/Volumes/matlab/data/seawifs/mat/SCHL_9_21_',num2str(jdays(1))],'nbp26_chl','glat','glon')
glat=flipud(glat);
[cr,cc]=imap(min_lat,max_lat,min_lon,max_lon,glat,glon);



for m=4:length(k)

load(['/Volumes/matlab/data/eddy/V4/mat/AVISO_25_W_',num2str(jdays(m))],'hp66_crlg','ssh')
load(['/Volumes/matlab/data/QuickScat/new_mat/QSCAT_21_25km_',num2str(jdays(m))],'w_ek')
load(['/Volumes/matlab/data/seawifs/mat/SCHL_9_21_',num2str(jdays(m))],'nbp26_chl')
crlg=hp66_crlg;
crl=w_ek;
chl=flipud(nbp26_chl);



figure(1)
clf

%chl
subplot(222)
[ctr,ctc]=imap(gy(m),gy(m),gx(m),gx(m),glat,glon);
tc=ctc-7:ctc+7;
tr=ctr-7:ctr+7;
[ssctr,ssctc]=imap(gy(m),gy(m),gx(m),gx(m),slat,slon);
sstc=ssctc-7:ssctc+7;
sstr=ssctr-7:ssctr+7;
fcrlg=interp2(fillnans(double(chl(tr,tc))),'cubic');
fssh=interp2(double(ssh(sstr,sstc)),'cubic');
pcolor(fcrlg(2:end,2:end));
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
title('Instantaneous CHL Anomaly  ')
colormap(chelle)
freezecolors

%crl
subplot(221)
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
caxis([-.2 .2])
hold off
title('Instantaneous Ekman Pumping  ')
colormap(bwr)
freezecolors
all_crl(:,:,m)=fcrl;
all_crlg(:,:,m)=fcrlg;

%map
subplot(2,2,[3 4])
%pmap(islon(irs,ics),islat(irs,ics),double(icrl(irs,ics)))
pmap(slon(rs,cs),slat(rs,cs),ssh(rs,cs))
shading interp
caxis([-20 20])
hold on
m_contour(slon(rs,cs),slat(rs,cs),ssh(rs,cs),[-40:3:-3],'k--')
m_contour(slon(rs,cs),slat(rs,cs),ssh(rs,cs),[3:3:40],'k')
m_plot(x(1:m),y(1:m),'k','LineWidth',2)
title({'SSH  ',['Eddy Age ' num2str(m) ' weeks ']})
m_coast('patch',[0 0 0]);
colormap(rwp)
freezecolors

eval(['print -dpng ' FRAME_DIR 'frame_' num2str(ff) '.png'])
ff=ff+1;

end
eval(['!cp ' FRAME_DIR 'frame_' num2str(m) '.png ' FRAME_DIR 'frame_1.png'])
eval(['!ffmpeg -i ' FRAME_DIR 'frame_%d.png -y ' FRAME_DIR 'out.mpg'])
