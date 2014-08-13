set(0,'DefaultFigureVisible','off')
clear all
close all
global DATA_DIR
global HOME_DIR
global IMAGE_DIR
global HDF_DIR
global MAT_DIR
global d
global s
global jd

set_fish

cd(DATA_DIR)


minlon = -121;
maxlon = -116;
minlat = 30;
maxlat = 35;

xvec = [minlon maxlon];
yvec = [minlat maxlat];


vo = [datenum(s(1),s(2),s(3)) datenum(s(1),s(2),s(3))];
v1 = [datenum(s(1),s(2),s(3)) datenum(s(1),s(2),s(3)+1)];

[sstn nlon nlat ntime] = xtracto_3D_bdap(xvec,yvec,v1,'TATsstnhday');
[sstd dlon dlat dtime] = xtracto_3D_bdap(xvec,yvec,v1,'TATsstdhday');
[ssta alon alat atime] = xtracto_3D_bdap(xvec,yvec,v1,'TMWsstd');


sstd=squeeze(sstd);
sstn=squeeze(sstn);
ssta=squeeze(ssta);

%do avhrr
[lon,lat]=meshgrid(nlon,nlat);
smask=nan*sstn;
smask(~isnan(sstn))=1;
sm_sstn=smoothn(sstn,3).*smask;
gradtn=sqrt(dfdx(lat,sm_sstn,.01).^2+dfdy(sm_sstn,.01).^2);

smask=nan*sstd;
smask(~isnan(sstd))=1;
sm_sstd=smoothn(sstd,3).*smask;
gradtd=sqrt(dfdx(lat,sm_sstd,.01).^2+dfdy(sm_sstd,.01).^2);


sstn=griddata(lon,lat,sstn,mlon,mlat);
gradtn=griddata(lon,lat,gradtn,mlon,mlat);
sstd=griddata(lon,lat,sstd,mlon,mlat);
gradtd=griddata(lon,lat,gradtd,mlon,mlat);

sstn=sstn.*mask;
sstd=sstd.*mask;
gradtd=gradtd.*mask;
gradtn=gradtn.*mask;

%do modis
[lon,lat]=meshgrid(alon,alat);
smask=nan*ssta;
smask(~isnan(ssta))=1;
sm_ssta=smoothn(ssta,3).*smask;
gradta=sqrt(dfdx(lat,sm_ssta,.01).^2+dfdy(sm_ssta,.01).^2);

ssta=griddata(lon,lat,ssta,mlon,mlat);
gradta=griddata(lon,lat,gradta,mlon,mlat);

ssta=ssta.*mask;
gradta=gradta.*mask;

lon=mlon;
lat=mlat;


figure(1)
	clf
	pcolor(lon,lat,sstd.*(9/5)+32)
	colormap(chelle)
	shading interp
	axis equal
	ran=round(caxis);
	spran=ran(2)-ran(1);
	if max(ran)<=40 | min(ran)<5 | spran<5 | spran >10
		ran=[57 65];
	end
	caxis(ran)
	set(gca,'tickdir','out')
	set(gca,'box','off')
	set(gca,'xcolor',[1 1 1])
	set(gca,'ycolor',[1 1 1])
	tmp_time=datestr(dtime);
	eval(['print -dpng ' IMAGE_DIR 'sstd_' ...
	num2str(s(1)) num2str(s(2)) num2str(s(3)) '_' tmp_time(13:14) tmp_time(16:17) '_' num2str(ran(1)) '_' num2str(ran(2))]) 
	eval(['ls ' [IMAGE_DIR 'sstd_' ...
	num2str(s(1)) num2str(s(2)) num2str(s(3)) '_' tmp_time(13:14) tmp_time(16:17) '_' num2str(ran(1)) '_' num2str(ran(2)) '.png']]) 


figure(2)
	clf
	pcolor(lon,lat,sstn.*(9/5)+32)
	colormap(chelle)
	shading interp
	axis equal
	ran=round(caxis);
	spran=ran(2)-ran(1);
	if max(ran)<=40 | min(ran)<5 | spran<5 | spran >10
		ran=[57 65];
	end
	caxis(ran)
	set(gca,'tickdir','out')
	set(gca,'box','off')
	set(gca,'xcolor',[1 1 1])
	set(gca,'ycolor',[1 1 1])
	tmp_time=datestr(ntime);
	eval(['print -dpng ' IMAGE_DIR 'sstn_' ...
	num2str(s(1)) num2str(s(2)) num2str(s(3)) '_' tmp_time(13:14) tmp_time(16:17) '_' num2str(ran(1)) '_' num2str(ran(2))]) 
	eval(['ls ' [IMAGE_DIR 'sstn_' ...
	num2str(s(1)) num2str(s(2)) num2str(s(3)) '_' tmp_time(13:14) tmp_time(16:17) '_' num2str(ran(1)) '_' num2str(ran(2)) '.png']]) 

figure(2)
	clf
	pcolor(lon,lat,ssta.*(9/5)+32)
	colormap(chelle)
	shading interp
	axis equal
	ran=round(caxis);
	spran=ran(2)-ran(1);
	if max(ran)<=40 | min(ran)<5 | spran<5 | spran >10
		ran=[57 65];
	end
	caxis(ran)
	set(gca,'tickdir','out')
	set(gca,'box','off')
	set(gca,'xcolor',[1 1 1])
	set(gca,'ycolor',[1 1 1])
	tmp_time=datestr(ntime);
	eval(['print -dpng ' IMAGE_DIR 'ssta2_' ...
	num2str(s(1)) num2str(s(2)) num2str(s(3)) '_' tmp_time(13:14) tmp_time(16:17) '_' num2str(ran(1)) '_' num2str(ran(2))]) 
	eval(['ls ' [IMAGE_DIR 'ssta2_' ...
	num2str(s(1)) num2str(s(2)) num2str(s(3)) '_' tmp_time(13:14) tmp_time(16:17) '_' num2str(ran(1)) '_' num2str(ran(2)) '.png']]) 



figure(3)
pcolor(lon,lat,gradtn);
shading flat
axis image
caxis([4e-5 3e-4])
set(gca,'tickdir','out')
set(gca,'box','off')
set(gca,'xcolor',[1 1 1])
set(gca,'ycolor',[1 1 1])
eval(['print -dpng ' IMAGE_DIR 'front_sstn_'  ...
	num2str(s(1)) num2str(s(2)) num2str(s(3)) '_' tmp_time(13:14) tmp_time(16:17) '_0_00004']) 
eval(['ls ' IMAGE_DIR 'front_sstn_'  ...
	num2str(s(1)) num2str(s(2)) num2str(s(3)) '_' tmp_time(13:14) tmp_time(16:17) '_0_00004.png'])
	
figure(4)
pcolor(lon,lat,gradtd);
shading flat
axis image
caxis([4e-5 3e-4])
set(gca,'tickdir','out')
set(gca,'box','off')
set(gca,'xcolor',[1 1 1])
set(gca,'ycolor',[1 1 1])
eval(['print -dpng ' IMAGE_DIR 'front_sstd_'  ...
	num2str(s(1)) num2str(s(2)) num2str(s(3)) '_' tmp_time(13:14) tmp_time(16:17) '_0_00004']) 
eval(['ls ' IMAGE_DIR 'front_sstd_'  ...
	num2str(s(1)) num2str(s(2)) num2str(s(3)) '_' tmp_time(13:14) tmp_time(16:17) '_0_00004.png'])

figure(4)
clf
pcolor(lon,lat,gradta);
shading flat
axis image
caxis([4e-5 3e-4])
set(gca,'tickdir','out')
set(gca,'box','off')
set(gca,'xcolor',[1 1 1])
set(gca,'ycolor',[1 1 1])
eval(['print -dpng ' IMAGE_DIR 'front_ssta2_'  ...
	num2str(s(1)) num2str(s(2)) num2str(s(3)) '_' tmp_time(13:14) tmp_time(16:17) '_0_00004']) 
eval(['ls ' IMAGE_DIR 'front_ssta2_'  ...
	num2str(s(1)) num2str(s(2)) num2str(s(3)) '_' tmp_time(13:14) tmp_time(16:17) '_0_00004.png'])
		

cd(HOME_DIR)

