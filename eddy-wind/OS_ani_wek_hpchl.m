clear all
want_id=[	125980	
			129581     
			130375     
			131961     
			132472     
			132906     
			143726     
			143729     
			149011     
			157168   
			158098      
			158190
			141248];
			
want_id=149011;

for gg=1:length(want_id)

%find track
load /matlab/data/eddy/V4/global_tracks_V4
f1=find(id==want_id(gg) & track_jday>=2452459);
x=x(f1);
y=y(f1);

id=id(f1);
k=k(f1);
jdays=track_jday(f1);
clearallbut x y id k jdays gg want_id

if any(jdays)
load rwp.pal
load bwr.pal
load chelle.pal
FRAME_DIR=['/matlab/matlab/eddy-wind/frames/OS_ek_chl_',num2str(want_id(gg)),'/'];
eval(['!mkdir ' FRAME_DIR])
eval(['!toast ' FRAME_DIR,' *.png'])
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
    gy(m)=tmpys(iminy(1));
end    

min_lat=min(y)-3;
max_lat=max(y)+3;
min_lon=min(x)-3;
max_lon=max(x)+20;

load(['/matlab/data/eddy/V4/mat/AVISO_25_W_',num2str(jdays(1))],'hp66_crlg','lat','lon')
slat=lat;
slon=lon;
[rs,cs]=imap(min_lat,max_lat,min_lon,max_lon,slat,slon);

%load('/data/modisa/mat/CHL_4_W_2452620','lat','lon')
%[mr,mc]=imap(min_lat,max_lat,min_lon,max_lon,lat,lon);
%mlat=lat;
%mlon=lon;

load(['/matlab/data/QuickScat/mat/QSCAT_30_25km_',num2str(jdays(1))],'bp26_crlstr','lat','lon')
[r,c]=imap(min_lat,max_lat,min_lon,max_lon,lat,lon);
fc=f_cor(lat);

load(['/matlab/data/gsm/mat/GSM_9_21_',num2str(jdays(1))],'gchl_week','glat','glon')
glat=flipud(glat);
[cr,cc]=imap(min_lat,max_lat,min_lon,max_lon,glat,glon);




for m=1:length(k)

load(['/matlab/data/eddy/V4/mat/AVISO_25_W_',num2str(jdays(m))],'hp66_crlg','ssh')
load(['/matlab/data/QuickScat/mat/QSCAT_30_25km_',num2str(jdays(m))],'w_ek')
load(['/matlab/data/gsm/mat/GSM_9_21_',num2str(jdays(m))],'bp26_chl','sm_gchl_week')
%load(['/data/modisa/mat/CHL_4_W_',num2str(jdays(m))],'chl_week')
hp66_crlg=hp66_crlg(41:600,:);
ssh=ssh(41:600,:);
crlg=hp66_crlg;
crl=w_ek;
chl=flipud(bp26_chl);
raw_chl=flipud(sm_gchl_week);



figure(1)
clf

%chl
subplot(222)
[ctr,ctc]=imap(gy(m),gy(m),gx(m),gx(m),glat,glon);
tc=ctc-7:ctc+7;
tr=ctr-7:ctr+7;
[ssctr,ssctc]=imap(gy(m),gy(m),gx(m),gx(m),lat,lon);
sstc=ssctc-7:ssctc+7;
sstr=ssctr-7:ssctr+7;
fchl=fillnans(interp2(double(raw_chl(tr,tc)),'cubic'));
fssh=interp2(double(ssh(sstr,sstc)),'cubic');
pcolor(fchl(2:end,2:end));
shading interp
ran=caxis
hold on
contour(fssh(2:end,2:end),[1:4:70],'k','LineWidth',1)
set(gca,'xticklabel',[],'yticklabel',[],'LineWidth',2)
hold on
line([15 15],[0 29],'color','k','LineWidth',2)
line([0 29],[15 15],'color','k','LineWidth',2)
axis image
hold off
caxis(ran)
title('Instantaneous Smoothed CHL  ')
colormap(chelle)
freezeColors


%{
subplot(321)
[ctr,ctc]=imap_4km(min(slat(sstr,1)),max(slat(sstr,1)),min(slon(1,sstc)),max(slon(1,sstc)),mlat,mlon);
pcolor(mlon(ctr,ctc),mlat(ctr,ctc),double(chl_week(ctr,ctc)));
%ran=caxis;
shading flat
hold on
contour(slon(sstr,sstc),slat(sstr,sstc),ssh(sstr,sstc),[1:4:70],'k','LineWidth',1)
set(gca,'xticklabel',[],'yticklabel',[],'LineWidth',2)
%line([44 44],[0 86],'color','k','LineWidth',2)
%line([0 86],[44 44],'color','k','LineWidth',2)
axis image
%caxis([-.12 .12])
caxis(ran);
hold off
title('Instantaneous 4km CHL  ')
colormap(chelle)
freezeColors
%}


%
crl
subplot(221)
[ctr,ctc]=imap(gy(m),gy(m),gx(m),gx(m),lat,lon);
tc=ctc-7:ctc+7;
tr=ctr-7:ctr+7;
fcrl=interp2(double(crl(tr,tc)),'cubic');
pcolor(fcrl(2:end,2:end));
shading interp
hold on
contour(fssh(2:end,2:end),[1:4:70],'k','LineWidth',1)
set(gca,'xticklabel',[],'yticklabel',[],'LineWidth',2)
hold on
line([15 15],[0 29],'color','k','LineWidth',2)
line([0 29],[15 15],'color','k','LineWidth',2)
axis image
caxis([-.12 .12])
hold off
title('Instantaneous Ekman Pumping  ')
colormap(bwr)
freezeColors
all_crl(:,:,m)=fcrl;
all_chl;(:,:,m)=fchl;
all_ssh;(:,:,m)=fssh;
%

%crl comp
subplot(223)
[ctr,ctc]=imap(gy(m),gy(m),gx(m),gx(m),lat,lon);
tc=ctc-7:ctc+7;
tr=ctr-7:ctr+7;
pcolor(nanmean(all_crl(2:end,2:end),3));
shading interp
hold on
contour(nanmean(all_ssh(2:end,2:end)),[1:4:70],'k','LineWidth',1)
set(gca,'xticklabel',[],'yticklabel',[],'LineWidth',2)
hold on
line([15 15],[0 29],'color','k','LineWidth',2)
line([0 29],[15 15],'color','k','LineWidth',2)
axis image
caxis([-.12 .12])
hold off
title('Composite Ekman Pumping  ')
colormap(bwr)
freezeColors
return
%map
%{
subplot(3,2,[3 4])
%pmap(islon(irs,ics),islat(irs,ics),double(icrl(irs,ics)))
pmap(lon(r,c),lat(r,c),w_ek(r,c))
shading flat
caxis([-.2 .2])
hold on
m_contour(lon(r,c),lat(r,c),ssh(r,c),[-40:3:-3],'k--')
m_contour(lon(r,c),lat(r,c),ssh(r,c),[3:3:40],'k')
m_plot(x(1:m),y(1:m),'k','LineWidth',2)
title({'Filtered QuickSCAT Ekman Pumping  '})
m_coast('patch',[0 0 0]);
colormap(bwr)
freezeColors


%map
subplot(3,2,[5 6])
%pmap(islon(irs,ics),islat(irs,ics),double(icrl(irs,ics)))
pmap(glon(cr,cc),glat(cr,cc),chl(cr,cc))
shading flat
caxis([-.08 .08])
hold on
m_contour(lon(r,c),lat(r,c),ssh(r,c),[-40:3:-3],'k--')
m_contour(lon(r,c),lat(r,c),ssh(r,c),[3:3:40],'k')
m_plot(x(1:m),y(1:m),'k','LineWidth',2)
title({'Filtered SeaWiFS CHL  '})
m_coast('patch',[0 0 0]);
colormap(chelle)
freezeColors
[year,mon,day]=jd2jdate(jdays(m));
xlabel([num2str(year),'-',num2str(mon),'-',num2str(day)])
%}


eval(['print -dpng ' FRAME_DIR 'frame_' num2str(ff) '.png'])
ff=ff+1;
eval(['print -dpng ' FRAME_DIR 'frame_' num2str(ff) '.png'])
ff=ff+1;
eval(['print -dpng ' FRAME_DIR 'frame_' num2str(ff) '.png'])
ff=ff+1;
eval(['print -dpng ' FRAME_DIR 'frame_' num2str(ff) '.png'])
ff=ff+1;
end
eval(['!cp ' FRAME_DIR 'frame_' num2str(m) '.png ' FRAME_DIR 'frame_1.png'])
eval(['!ffmpeg -i ' FRAME_DIR 'frame_%d.png -y ' FRAME_DIR 'eddy_chl_comps_' num2str(want_id(gg)) '.mpg'])
end
end

%{
figure(1)
clf

%chl
subplot(322)
[ctr,ctc]=imap(gy(m),gy(m),gx(m),gx(m),glat,glon);
tc=ctc-7:ctc+7;
tr=ctr-7:ctr+7;
fcrlg=interp2(double(chl(tr,tc)),'cubic');
fssh=interp2(double(ssh(tr,tc)),'cubic');
pcolor(fcrlg);
shading flat
hold on
contour(fssh,[1:4:70],'k')
set(gca,'xticklabel',[])
set(gca,'yticklabel',[])
hold on
line([15 15],[0 29],'color','k')
line([0 29],[15 15],'color','k')
axis image
caxis([-.08 .08])
hold off
title('Instantaneous CHL Anomaly  ')
colormap(chelle)
freezeColors

%crl
subplot(321)
[ctr,ctc]=imap(gy(m),gy(m),gx(m),gx(m),lat,lon);
tc=ctc-7:ctc+7;
tr=ctr-7:ctr+7;
fcrl=interp2(double(crl(tr,tc)),'cubic');
pcolor(fcrl);
shading flat
hold on
contour(fssh,[1:4:70],'k')
set(gca,'xticklabel',[])
set(gca,'yticklabel',[])
hold on
line([15 15],[0 29],'color','k')
line([0 29],[15 15],'color','k')
axis image
caxis([-.2 .2])
hold off
title('Instantaneous Ekman Pumping  ')
colormap(bwr)
freezeColors
all_crl(:,:,m)=fcrl;
all_crlg(:,:,m)=fcrlg;
all_ssh(:,:,m)=fssh;

%map
subplot(3,2,[3 4])
%pmap(islon(irs,ics),islat(irs,ics),double(icrl(irs,ics)))
pmap(slon(rs,cs),slat(rs,cs),ssh(rs,cs))
shading flat
caxis([-20 20])
hold on
m_contour(slon(rs,cs),slat(rs,cs),ssh(rs,cs),[-40:3:-3],'k--')
m_contour(slon(rs,cs),slat(rs,cs),ssh(rs,cs),[3:3:40],'k')
m_plot(x(1:m),y(1:m),'k','LineWidth',2)
title({'SSH  ',['Eddy Age ' num2str(m) ' weeks ']})
m_coast('patch',[0 0 0]);
colormap(rwp)
freezeColors
%comps

subplot(325)
pcolor(nanmedian(all_crl,3));shading flat
set(gca,'xticklabel',[])
set(gca,'yticklabel',[])
hold on
contour(nanmean(all_ssh,3),[1:4:70],'k')
line([15 15],[0 29],'color','k')
line([0 29],[15 15],'color','k')
axis image
caxis([-.08 .08])
title({'Composite Median of   ','Ekman Pumping   '})
colormap(bwr)
freezeColors

subplot(326)
pcolor(nanmedian(all_crlg,3));shading flat
set(gca,'xticklabel',[])
set(gca,'yticklabel',[])
hold on
contour(nanmean(all_ssh,3),[1:4:70],'k')
line([15 15],[0 29],'color','k')
line([0 29],[15 15],'color','k')
axis image
caxis([-.03 .03])
title({'Composite Median of   ','CHL Anomaly   '})
colormap(chelle)
freezeColors
eval(['print -dpng ' FRAME_DIR 'frame_' num2str(ff) '.png'])
ff=ff+1;

end
eval(['!cp ' FRAME_DIR 'frame_' num2str(m) '.png ' FRAME_DIR 'frame_1.png'])
eval(['!ffmpeg -r 5 -sameq -s hd1080 -i ' FRAME_DIR 'frame_%d.png -y ' FRAME_DIR 'out.mp4'])
%}
