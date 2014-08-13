function [zz]=panimate_ac(want_id,FRAME_DIR)
ff=1;
warning('off','all')


eval(['mkdir ' FRAME_DIR])
eval(['!toast ' FRAME_DIR '*'])
load /matlab/data/eddy/V4/global_tracks_V4

for zz=1:length(want_id)
%find track
load /matlab/data/eddy/V4/global_tracks_V4
f1=find(id==want_id(zz) & track_jday>=2452459 & track_jday<=2454461);
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

load(['/matlab/data/ReynoldsSST/mat/OI_25_D_2455194'],'lat','lon')
olon=cat(2,lon,lon+360);
olat=cat(2,lat,lat);
[ro,co]=imap(min_lat,max_lat,min_lon,max_lon,lat,lon);

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
load(['/matlab/data/QuickScat/mat/QSCAT_30_25km_',num2str(jdays(m))],'w_ek','hp_wek_crlg_week','hp_wek_sst_week_dtdn')
load(['/matlab/data/gsm/mat/GSM_9_21_',num2str(jdays(m))],'raw_hp66_chl','bp26_chl','sm_gchl_week','bp21_car')
load(['/matlab/data/ReynoldsSST/mat/OI_25_30_',num2str(jdays(m))],'bp26_sst')
ssh=cat(2,ssh,ssh);
sst=cat(2,bp26_sst,bp26_sst);
crl=cat(2,w_ek,w_ek);
chl=cat(2,flipud(bp26_chl),flipud(bp26_chl));
raw=cat(2,flipud(raw_hp66_chl),flipud(raw_hp66_chl));
full_chl=cat(2,flipud(sm_gchl_week),flipud(sm_gchl_week));
car=cat(2,flipud(bp21_car),flipud(bp21_car));
wekg=cat(2,hp_wek_crlg_week,hp_wek_crlg_week);
%wekt=cat(2,hp_wek_sst_dtdn_week,hp_wek_sst_dtdn_week);

figure(1)
clf





subplot(4,3,[1 2 3])
%pmap(islon(irs,ics),islat(irs,ics),double(icrl(irs,ics)))
%pmap(glon(cr,cc),glat(cr,cc),mu(cr,cc))
pmap(slon(rs,cs),slat(rs,cs),ssh(rs,cs))
shading interp
caxis([-20 20])
hold on
m_contour(slon(rs,c),slat(rs,cs),ssh(rs,cs),[-300:3:-2],'color', [.5 .5 .5])
m_contour(slon(rs,cs),slat(rs,cs),ssh(rs,cs),[2:3:300],'k')
m_plot(x(1:m),y(1:m),'k','LineWidth',2)
title({'fSSH  '})
m_coast('patch',[0 0 0]);
colormap(chelle)
freezecolors

%{
map
subplot(4,3,[7 8 9])
%pmap(islon(irs,ics),islat(irs,ics),double(icrl(irs,ics)))
%pmap(glon(cr,cc),glat(cr,cc),mu(cr,cc))
pmap(glon(cr,cc),glat(cr,cc),car(cr,cc))
shading interp
caxis([-.1 .1])
hold on
m_contour(lon(rs,cs),lat(rs,cs),ssh(rs,cs),[-300:3:-2],'color', [.5 .5 .5])
m_contour(lon(rs,cs),lat(rs,cs),ssh(rs,cs),[2:3:300],'k')
m_plot(x(1:m),y(1:m),'k','LineWidth',2)
m_coast('patch',[0 0 0]);
colormap(chelle)
freezecolors
ylabel('fCar')
%}

subplot(4,3,[4 5 6])
pmap(olon(ro,co),olat(ro,co),sst(ro,co))
shading interp
caxis([-.4 .4])
hold on
m_contour(slon(rs,cs),slat(rs,cs),ssh(rs,cs),[-300:3:-2],'color', [.5 .5 .5])
m_contour(slon(rs,cs),slat(rs,cs),ssh(rs,cs),[2:3:300],'k')
m_plot(x(1:m),y(1:m),'k','LineWidth',2)
%ylabel({'Smoothed CHL'})
m_coast('patch',[0 0 0]);
colormap(chelle)
freezecolors
title('fSST')
[year,month,day]=jd2jdate(jdays(m));
xlabel(['id = ',num2str(want_id(zz)),'   ',num2str(year) '-' num2str(month) '-' num2str(day) '   '])

[chl_r,chl_c]=imap(y(m)-3,y(m)+3,x(m)-3,x(m)+3,glat,glon)
[eddy_r,eddy_c]=imap(y(m)-3,y(m)+3,x(m)-3,x(m)+3,slat,slon)
[wek_r,wek_c]=imap(y(m)-3,y(m)+3,x(m)-3,x(m)+3,lat,lon)

subplot(4,3,10)
pcolor(double(wekg(wek_r,wek_c)));shading flat;axis image
set(gca,'xticklabel',[])
set(gca,'yticklabel',[])
line([length(wek_c)/2 length(wek_c)/2],[1 length(wek_r)],'color','k')
line([1 length(wek_c)],[length(wek_r)/2 length(wek_r)/2],'color','k')
caxis([-7 7])
title('W_E crlg')
colormap(chelle)
freezecolors

%{
subplot(4,3,11)
pcolor(double(wekt(wek_r,wek_c)));shading flat;axis image
set(gca,'xticklabel',[])
set(gca,'yticklabel',[])
line([length(wek_c)/2 length(wek_c)/2],[1 length(wek_r)],'color','k')
line([1 length(wek_c)],[length(wek_r)/2 length(wek_r)/2],'color','k')
caxis([-7 7])
title('W_E SST')
colormap(chelle)
freezecolors
%}
%
subplot(4,3,10)
pcolor(double(chl(chl_r,chl_c)));shading flat;axis image
set(gca,'xticklabel',[])
set(gca,'yticklabel',[])
line([length(wek_c)/2 length(wek_c)/2],[1 length(wek_r)],'color','k')
line([1 length(wek_c)],[length(wek_r)/2 length(wek_r)/2],'color','k')
caxis([-.05 .05])
title('raw fCHL')
colormap(chelle)
freezecolors


subplot(4,3,11)
pcolor(double(ssh(eddy_r,eddy_c)));shading flat;axis image
set(gca,'xticklabel',[])
set(gca,'yticklabel',[])
line([length(wek_c)/2 length(wek_c)/2],[1 length(wek_r)],'color','k')
line([1 length(wek_c)],[length(wek_r)/2 length(wek_r)/2],'color','k')
caxis([-20 20])
title('fSSH')
colormap(chelle)
freezecolors
%}

subplot(4,3,12)
pcolor(double(crl(wek_r,wek_c)));shading flat;axis image
set(gca,'xticklabel',[])
set(gca,'yticklabel',[])
line([length(wek_c)/2 length(wek_c)/2],[1 length(wek_r)],'color','k')
line([1 length(wek_c)],[length(wek_r)/2 length(wek_r)/2],'color','k')
caxis([-.15 .15])
title('W_E')
colormap(bwr)

%{
%map
subplot(4,3,[10 11 12])
pmap(glon(cr,cc),glat(cr,cc),chl(cr,cc))
shading interp
caxis([-.07 .07])
hold on
m_contour(lon(rs,cs),lat(rs,cs),ssh(rs,cs),[-300:4:-2],'color', [.5 .5 .5])
m_contour(lon(rs,cs),lat(rs,cs),ssh(rs,cs),[2:4:300],'k')
m_plot(x(1:m),y(1:m),'k','LineWidth',2)
%ylabel({'Filtered CHL'})
m_coast('patch',[0 0 0]);
colormap(chelle)
freezecolors
ylabel('fCHL')
[year,month,day]=jd2jdate(jdays(m));
xlabel([num2str(year) '-' num2str(month) '-' num2str(day) ' frame ' num2str(ff) ' id = ' num2str(want_id(zz))])
%}



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
png2mpg
warning('on','all')


