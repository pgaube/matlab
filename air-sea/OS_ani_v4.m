clear all
%want_id=39788;
want_id=141248;


%find track
load /Volumes/matlab/data/eddy/V4/global_tracks_V4
f1=find(id==want_id);
x=x(f1);
y=y(f1);
id=id(f1);
k=k(f1);
jdays=track_jday(f1);
clearallbut x y id k jdays

load rwp.pal
load bwr.pal
FRAME_DIR='/Volumes/matlab/matlab/eddy-wind/frames/OS_ek_ek_nl/';
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
max_lon=max(x)+5;

load(['/Volumes/matlab/data/eddy/V4/mat/AVISO_25_W_',num2str(jdays(1))],'hp66_crlg','lat','lon')
slat=lat;
slon=lon;
islon=interp2(slon);
islat=interp2(slat);
[rs,cs]=imap(min_lat,max_lat,min_lon,max_lon,slat,slon);
[irs,ics]=imap(min_lat,max_lat,min_lon,max_lon,islat,islon);

load(['/Volumes/matlab/data/QuickScat/new_mat/QSCAT_21_25km_',num2str(jdays(1))],'bp62_crl','lat','lon')
[r,c]=imap(min_lat,max_lat,min_lon,max_lon,lat,lon);
ilon=interp2(lon);
ilat=interp2(lat);
[ir,ic]=imap(min_lat,max_lat,min_lon,max_lon,ilat,ilon);



for m=1:length(k)

load(['/Volumes/matlab/data/eddy/V4/mat/AVISO_25_W_',num2str(jdays(m))],'hp66_crlg','ssh')
load(['/Volumes/matlab/data/QuickScat/new_mat/QSCAT_21_25km_',num2str(jdays(m))],'w_ek','w_ek_nl')
crlg=w_ek_nl;
crl=w_ek;
icrl=interp2(ssh);



figure(1)
clf

%crlg
subplot(322)
[ctr,ctc]=imap(gy(m),gy(m),gx(m),gx(m),lat,lon);
tc=ctc-7:ctc+7;
tr=ctr-7:ctr+7;
fcrlg=interp2(double(crlg(tr,tc)),'cubic');
[ctr,ctc]=imap(gy(m),gy(m),gx(m),gx(m),slat,slon);
tc=ctc-7:ctc+7;
tr=ctr-7:ctr+7;
fssh=interp2(double(ssh(tr,tc)),'cubic');
pcolor(fcrlg);
shading flat
hold on
contour(fssh,[1:4:30],'k')
set(gca,'xticklabel',[])
set(gca,'yticklabel',[])
hold on
line([15 15],[0 29],'color','k')
line([0 29],[15 15],'color','k')
axis image
caxis([-5 5])
hold off
title('Instantaneous Nonlinear Ekman Pumping  ')

%crl
subplot(321)
[ctr,ctc]=imap(gy(m),gy(m),gx(m),gx(m),lat,lon);
tc=ctc-7:ctc+7;
tr=ctr-7:ctr+7;
fcrl=interp2(double(crl(tr,tc)),'cubic');
pcolor(fcrl);
shading flat
hold on
contour(fssh,[1:4:30],'k')
set(gca,'xticklabel',[])
set(gca,'yticklabel',[])
hold on
line([15 15],[0 29],'color','k')
line([0 29],[15 15],'color','k')
axis image
caxis([-.25 .25])
hold off
title('Instantaneous Ekman Pumping  ')

all_crl(:,:,m)=fcrl;
all_crlg(:,:,m)=fcrlg;

%map
subplot(3,2,[3 4])
pmap(islon(irs,ics),islat(irs,ics),double(icrl(irs,ics)))
%pmap(slon(rs,cs),slat(rs,cs),nan*ssh(rs,cs))
shading interp
caxis([-20 20])
hold on
m_plot(x(1:m),y(1:m),'k','LineWidth',2)
title({'SSH  ',['Eddy Age ' num2str(m) ' weeks ']})
m_coast('patch',[0 0 0]);

%comps

subplot(325)
pcolor(nanmean(all_crl,3));shading interp
caxis([-1.5 1.5])
set(gca,'xticklabel',[])
set(gca,'yticklabel',[])
hold on
line([15 15],[0 29],'color','k')
line([0 29],[15 15],'color','k')
axis image
caxis([-.25 .25])
title({'Composite Average of   ','Ekman Pumping   '})

subplot(326)
pcolor(nanmean(all_crlg,3));shading interp
set(gca,'xticklabel',[])
set(gca,'yticklabel',[])
hold on
line([15 15],[0 29],'color','k')
line([0 29],[15 15],'color','k')
axis image
caxis([-5 5])
title({'Composite Average of   ','Nonlinear Ekman Pumping   '})
colormap(bwr)

eval(['print -dpng ' FRAME_DIR 'frame_' num2str(ff) '.png'])
ff=ff+1;

end
eval(['!cp frame_2.png frame_' num2str(m) '.png'])
eval(['!ffmpeg -r 5 -sameq -s hd1080 -i ' FRAME_DIR 'frame_%d.png -y ' FRAME_DIR 'out.mp4'])

