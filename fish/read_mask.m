function [lat,lon,mask]=read_mask(fname)

tt=flipud(fliplr(double(imread(fname))));
whos
%figure out what the lat lons are
maxlat=str2num(fname(5:9))./100;
minlat=str2num(fname(11:15))./100;
maxlon=str2num(fname(17:22))./100;
minlon=str2num(fname(24:29))./100;

mlat=linspace(minlat,maxlat,length(tt(:,1)));
mlon=linspace(minlon,maxlon,length(tt(1,:)));
mdy=111.11*abs((mlat(2)-mlat(1)));
mdx=111.11*abs((mlon(2)-mlon(1))).*cosd(pmean(mlat));

%now figure out what a 250m resolution grid would be
dx=0.25/mdx;
dy=0.25/mdy;

%make 250m grid
lat=linspace(minlat,maxlat,round(length(tt(:,1))/dy));
lon=linspace(minlon,maxlon,round(length(tt(1,:))/dx));
fdy=111.11*abs((lat(2)-lat(1)));
fdx=111.11*abs((lon(2)-lon(1))).*cosd(pmean(lat));

%now make mask
tt(tt<=1)=nan;
tt(tt>1)=1;
[lon,lat]=meshgrid(lon,lat);
mask=griddata(mlon,mlat,tt,lon,lat,'linear');
mask(~isnan(mask))=1;