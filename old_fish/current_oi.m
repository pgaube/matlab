set(0,'DefaultFigureVisible','off')
clear all
close all
global DATA_DIR
global HOME_DIR
global IMAGE_DIR
global HDF_DIR
global MAT_DIR
global COMP_MAT_DIR
global d
global s
global jd
global ran
global fran
global cran
global pd
global minlon
global maxlon
global minlat
global maxlat


set_fish_1_delay


cd(DATA_DIR)

%set up constants and grid
jd=date2jd(s(1),s(2),s(3))+.5;
[yea,mon,day]=jd2jdate(jd);
dates=(yea*10000)+(mon*100)+day;
fname2 = num2str([yea*1000+julian(mon,day,yea,yea)]);
fname = ['avhrr-only-v2.' num2str(dates) '_preliminary.nc.gz'];%avhrr-only-v2.20120601_preliminary.nc.gz
fobj = ftp('eclipse.ncdc.noaa.gov')
pasv(fobj)
eval(['cd(fobj,' char(39) '/pub/OI-daily-v2/NetCDF/' num2str(s(1)) '/AVHRR/' char(39) ')'])
mget(fobj,fname);
close(fobj);

eval(['!mv ' fname ' ghrsst.nc.gz'])
!gunzip -f ghrsst.nc.gz
lat=nc_varget([DATA_DIR 'ghrsst.nc'],'lat');
lon=nc_varget([DATA_DIR 'ghrsst.nc'],'lon');
sst=nc_varget([DATA_DIR 'ghrsst.nc'],'sst');
sst=(sst*(9/5))+32;
[r,c]=imap(minlat,maxlat,180+(180+minlon),180+(180+maxlon),lat,lon);

lat=lat(r);
lon=minlon+.125:.25:maxlon-.125;
sst=sst(r,c);
[lon,lat]=meshgrid(lon,lat);
sst=fillnans(sst);
sst=griddata(lon,lat,sst,mlon,mlat,'linear').*mask;
lon=mlon;
lat=mlat;
save([MAT_DIR,'pgSoCal_oisst',num2str(s(1)) num2str(d)],'lat','lon','r','c','sst')


fplot(sst,mask,ran(1),ran(2),'fdcolor',[L0_IMAGE_DIR 'bdsc_'],pd,['0102a'],'sst')

cd(HOME_DIR)	