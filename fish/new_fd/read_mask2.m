function [lat,lon,mask]=read_mask(fname)

tt=flipud(fliplr(double(imread(fname))));

%figure out what the lat lons are
maxlat=str2num(fname(5:9))./100;
minlat=str2num(fname(11:15))./100;
maxlon=str2num(fname(17:22))./100;
minlon=str2num(fname(24:29))./100;

lat=linspace(minlat,maxlat,length(tt(:,1)));
lon=linspace(minlon,maxlon,length(tt(1,:)));


%now make mask
tt(tt<=1)=nan;
tt(tt>1)=1;
mask=tt;
[lon,lat]=meshgrid(lon,lat);
%mask=griddata(mlon,mlat,tt,lon,lat,'linear');
mask(~isnan(mask))=1;
