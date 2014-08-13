function [lat,lon,mask,ff]=read_mask(fname,maxlat,minlat,maxlon,minlon,dx,UTC,outname)
%[mlat,mlon,mask]=read_mask('bwm_+3430_+3000_-12125_-11545.png',34.5,30,-115.75,-121.4167,9);
%dx is in km
tt=double(imread(fname));
ff=flipud(tt(:,:,1));
tt=ff(1:2:end,1:2:end);
mlat=linspace(minlat,maxlat,length(tt(:,1)));
mlon=(linspace(minlon,maxlon,length(tt(1,:))));
mdy=111.11*abs((mlat(2)-mlat(1)));
% figure(1)
% clf
% pcolor(mlon,mlat,tt);shading flat

%now figure out what a 250m resolution grid would be
dy=dx/mdy;

%make dx grid
lat=linspace(minlat,maxlat,round(length(tt(:,1))/dy));
lon=linspace(minlon,maxlon,round(length(tt(1,:))/dy));
[lon,lat]=meshgrid(lon,lat);
fdy=111.11*abs((lat(2)-lat(1)));
fdx=111.11*abs((lon(2)-lon(1)));

%now make mask

%%%Who knows what Jason did, but this works
%%NE
% tt(tt~=255)=nan;
% tt(tt==255)=1;

% %WA
tt(tt==126)=1;
tt(tt~=1)=nan;
%old way doesn't work with fucked maskes
%tt(tt<=1)=nan;
%tt(tt>1)=1;

%%also an old-new way
% tt(tt==1)=nan;
% tt(tt<1)=1;
% tt(tt>1)=1;

mask=griddata(mlon,mlat,tt,lon,lat,'nearest');
mask(~isnan(mask))=1;
figure(1)
clf
pcolor(lon,lat,mask);shading flat
aspect_org=length(ff(1,:))/length(ff(:,1))
aspect_new=length(mask(1,:))/length(mask(:,1))
mlon=lon;mlat=lat;
save(outname,'mlat','mlon','mask','UTC')

