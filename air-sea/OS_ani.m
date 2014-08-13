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
FRAME_DIR='/Volumes/matlab/matlab/eddy-wind/frames/OS_ani/';
ff=1;

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
max_lon=max(x)+5;

load(['/Volumes/matlab/data/eddy/V4/mat/AVISO_25_W_',num2str(jdays(1))],'hp66_crlg','lat','lon')
slat=lat;
slon=lon;
[rs,cs]=imap(min_lat,max_lat,min_lon,max_lon,slat,slon);

load(['/Volumes/matlab/data/QuickScat/new_mat/QSCAT_21_25km_',num2str(jdays(1))],'bp62_crl','lat','lon')
[r,c]=imap(min_lat,max_lat,min_lon,max_lon,lat,lon);

tns_crl_N=zeros(41,1);
tew_crl_N=zeros(1,41);
tns_crlg_N=tns_crl_N;
tew_crlg_N=tew_crl_N;
tns_crl_bar=zeros(41,1);
tew_crl_bar=zeros(1,41);
tns_crlg_bar=tns_crl_bar;
tew_crlg_bar=tew_crl_bar;

for m=1:length(k)

load(['/Volumes/matlab/data/eddy/V4/mat/AVISO_25_W_',num2str(jdays(m))],'hp66_crlg','ssh')
load(['/Volumes/matlab/data/QuickScat/new_mat/QSCAT_21_25km_',num2str(jdays(m))],'hp66_crl')
crlg=hp66_crlg;
crl=-hp66_crl;


figure(1)
clf

%crlg
subplot(322)
[ctr,ctc]=imap(gy(m),gy(m),gx(m),gx(m),slat,slon);
tc=ctc-10:ctc+10;
tr=ctr-10:ctr+10;
fcrlg=interp2(1e5*double(crlg(tr,tc)),'cubic');
pcolor(fcrlg);
shading flat
hold on
contour(fcrlg,[-20:.25:20],'k')
set(gca,'xticklabel',[])
set(gca,'yticklabel',[])
hold on
line([20 20],[0 41],'color','k')
line([0 41],[20 20],'color','k')
axis image
caxis([-1.2 1.2])
hold off
title('Geostorphic Vorticity  ')

%crl
subplot(321)
[ctr,ctc]=imap(gy(m),gy(m),gx(m),gx(m),lat,lon);
tc=ctc-10:ctc+10;
tr=ctr-10:ctr+10;
fcrl=interp2(1e5*double(crl(tr,tc)),'cubic');
pcolor(fcrl);
shading flat
hold on
contour(fcrlg,[-20:.25:20],'k')
set(gca,'xticklabel',[])
set(gca,'yticklabel',[])
hold on
line([20 20],[0 41],'color','k')
line([0 41],[20 20],'color','k')
axis image
caxis([-1.2 1.2])
hold off
title('-Wind Vorticity  ')


%map
subplot(3,2,[3 4])
pmap(slon(rs,cs),slat(rs,cs),nan*ssh(rs,cs))
shading interp
caxis([-20 20])
hold on
m_plot(x(1:m),y(1:m),'k','LineWidth',2)
title({'Eddy Track  ',['Eddy Age ' num2str(m) ' weeks ']})
m_coast('patch',[0 0 0]);

%transects
tew_crl=fcrl(20,:);
tew_crlg=fcrlg(20,:);
tns_crl=fcrl(:,20);
tns_crlg=fcrlg(:,20);

tns_crl(isnan(tns_crl))=0;
tns_crlg(isnan(tns_crlg))=0;
tew_crl(isnan(tew_crl))=0;
tew_crlg(isnan(tew_crlg))=0;

tns_crl_bar=(1./(tns_crl_N+1)).*((tns_crl_bar.*tns_crl_N)+tns_crl);
tns_crlg_bar=(1./(tns_crlg_N+1)).*((tns_crlg_bar.*tns_crlg_N)+tns_crlg);
tew_crl_bar=(1./(tew_crl_N+1)).*((tew_crl_bar.*tew_crl_N)+tew_crl);
tew_crlg_bar=(1./(tew_crlg_N+1)).*((tew_crlg_bar.*tew_crlg_N)+tew_crlg);

tns_crl_N=tns_crl_N+1;
tns_crlg_N=tns_crlg_N+1;
tew_crl_N=tew_crl_N+1;
tew_crlg_N=tew_crlg_N+1;

subplot(325)
plot([-4:.2:4],tew_crl,'r--')
hold on
plot([-4:.2:4],tew_crlg,'b--')
plot([-4:.2:4],tew_crlg_bar,'b','LineWidth',2)
plot([-4:.2:4],tew_crl_bar,'r','LineWidth',2)
hold off
axis([-2 2 -.5 3])
title('Zonal Transect  ')
xlabel('distance from eddy centroid (degrees)  ')
ylabel('ms^{-1} per 100 km  ')

subplot(326)
plot([-4:.2:4],tns_crl,'r--')
hold on
plot([-4:.2:4],tns_crlg,'b--')
plot([-4:.2:4],tns_crlg_bar,'b','Linewidth',2)
plot([-4:.2:4],tns_crl_bar,'r','Linewidth',2)
hold off
axis([-2 2 -.5 3])
title('Meridional Transect  ')
xlabel('distance from eddy centroid (degrees)  ')
ylabel('ms^{-1} per 100 km  ')


eval(['print -dpng ' FRAME_DIR 'frame_' num2str(ff) '.png'])
ff=ff+1;

end
eval(['!ffmpeg -r 5 -sameq -s hd1080 -i ' FRAME_DIR 'frame_%d.png -y ' FRAME_DIR 'out.mp4'])

