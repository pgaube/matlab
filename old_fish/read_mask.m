function [lat,lon,mask]=read_mask(fname)

tt=load(fname);
tt=(flipud(tt));
%figure out what the lat lons are
maxlat=str2num(fname(5:9))./100;
minlat=str2num(fname(11:15))./100;
maxlon=str2num(fname(17:22))./100;
minlon=str2num(fname(24:29))./100;

maxlat=34.4884478378
minlat=30.4562502903
maxlon=-115.8156738281
minlon=-121.3154296875

ncols=2214;
nrows=1881;
xllcorner=-120.4175931578;
yllcorner=30.9320400519;
cellsize=0.00185303196116888;
nodata_value=-9999;

mlat=yllcorner:cellsize:yllcorner+(cellsize*nrows);
mlat=mlat(1:end-1);
mlon=xllcorner:cellsize:xllcorner+(cellsize*ncols);
mlon=mlon(1:end-1);


mdy=111.11*cellsize

%now figure out what a 250m resolution grid would be
dy=3;


%make 250m grid
lat=linspace(minlat,maxlat,round(length(tt(:,1))/dy));
lon=linspace(minlon,maxlon,round(length(tt(1,:))/dy));
fdy=111.11*abs((lat(2)-lat(1)));
fdx=111.11*abs((lon(2)-lon(1))).*cosd(nanmean(lat(:)));
%now make mask
mask=tt;
lat=mlat;
lon=mlon;
[lon,lat]=meshgrid(lon,lat);

%mask=griddata(mlon,mlat,tt,lon,lat,'linear');
mask(mask>0)=nan;
mask(mask<=0)=1;
