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
global ran
global fran
global cran
global gran
global pd
global minlon
global maxlon
global minlat
global maxlat


set_nb

mlon=fliplr(mlon);
mask=fliplr(flipud(mask));
mlat=flipud(mlat);

DATA_DIR='/Users/fish/fish/tmp/';

s=datevec(date);
jd=date2jd(s(1),s(2),s(3))+.5;
[s(1),s(2),s(3)]=jd2jdate(jd-1);
d=julian(s(2),s(3),s(1),s(1));
cd(DATA_DIR)
!rm *

xvec = [minlon maxlon];
yvec = [minlat maxlat];


base_url=['http://data.ncof.co.uk/data/ostia/' num2str(s(1)) '/sst/'];
if s(2)<10 & s(3)<10
	fname=[base_url num2str(s(1)) '0' num2str(s(2)) '0' num2str(s(3)) '-UKMO-L4HRfnd-GLOB-v01-fv02-OSTIA.nc.bz2'];

elseif s(2)<10 & s(3)>=10
	fname=[base_url num2str(s(1)) '0' num2str(s(2))  num2str(s(3)) '-UKMO-L4HRfnd-GLOB-v01-fv02-OSTIA.nc.bz2'];

elseif s(2)>=10 & s(3)<10
	fname=[base_url num2str(s(1)) num2str(s(2)) '0' num2str(s(3)) '-UKMO-L4HRfnd-GLOB-v01-fv02-OSTIA.nc.bz2'];

elseif s(2)>=10 & s(3)>=10
	fname=[base_url num2str(s(1)) num2str(s(2)) num2str(s(3)) '-UKMO-L4HRfnd-GLOB-v01-fv02-OSTIA.nc.bz2'];
end

eval(['!/usr/local/bin/wget -Oghrsst.nc.bz2 ' char(39) fname char(39)])
!bunzip2 *
lat=nc_varget([DATA_DIR 'ghrsst.nc'],'lat');
lon=nc_varget([DATA_DIR 'ghrsst.nc'],'lon');
sst=nc_varget([DATA_DIR 'ghrsst.nc'],'analysed_sst');
sst=((sst-272.15)*(9/5))+32;
r=find(lat>=minlat & lat<=maxlat);
c=find(lon>=minlon & lon<=maxlon);

lat=lat(r);
lon=lon(c);
sst=sst(r,c);
[lon,lat]=meshgrid(lon,lat);
sst=fillnans(sst);
sst=griddata(lon,lat,sst,mlon,mlat,'linear');
sst=sst.*mask;
bulk_temp=sst;
lon=mlon;
lat=mlat;


ran(1)=ran(1)-adjt_down;
ran(2)=ran(2)+adjt_up;
new_fplot(sst,mask,ran(1)+adjt_down,ran(2)-adjt_up,'fdcolor',['~/Desktop/stuff_for_india/NB/fsst_bdsc_'],pd,['0102a'],'sst')


cd(HOME_DIR)