set(0,'DefaultFigureVisible','off')
clear all
close all
global DATA_DIR
global HOME_DIR
global IMAGE_DIR
global HDF_DIR
global MAT_DIR
global CW_DIR
global COMP_MAT_DIR
global d
global s
global jd
global ran
global fran
global AVHRR_DATA_DIR
global AVHRR_ARC_DIR
global AVHRR_CUR_DIR
global ran
global fran
global cran
global pd
global minlon
global maxlon
global minlat
global maxlat

set_fish

%%%%%
%mlat=mlat+.0125;
%mlon=mlon+.01;

%%%%%

cd(CW_DIR)




xvec = [minlon maxlon];
yvec = [minlat maxlat];

vo = [datenum(s(1),s(2),s(3)) datenum(s(1),s(2),s(3))];
v1 = [datenum(s(1),s(2),s(3)) datenum(s(1),s(2),s(3)-4)];

[csst lon lat time] = xtracto_3D_bdap(xvec,yvec,v1,'TATssta8day');

if ndims(csst)>2
[lon,lat]=meshgrid(lon,lat);
smask=nan*squeeze(csst(1,1,:,:));
smask(~isnan(squeeze(csst(1,1,:,:))))=1;
sm_sst=smoothn(squeeze(csst(1,1,:,:)),3).*smask;
gradt=sqrt(dfdx(lat,sm_sst,.01).^2+dfdy(sm_sst,.01).^2);

tmp_sst=griddata(lon,lat,squeeze(csst(1,1,:,:)),mlon,mlat,'linear');
gradt=griddata(lon,lat,gradt,mlon,mlat,'linear');
tmp_sst=tmp_sst.*mask;
gradt=gradt.*mask;

lon=mlon;
lat=mlat;
tt=num2str(1200);

sst=tmp_sst.*(9/5)+32;

ty=sst-bulk_temp;
offset=nanmedian(ty(:));
sran=ran;

tt='1208p';


fplot(sst,mask,ran(1),ran(2),'fdcolor',[IMAGE_DIR 'bdsc_'],pd,tt,'sst')
fplot(gradt,mask,fran(1),fran(2),'pjet',[IMAGE_DIR 'cw8_bz_'],pd,tt,'sst')

end
cd(HOME_DIR)

