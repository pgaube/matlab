function [mask,lon,lat,ntot,nneg,nx,ny] = read_mask(filename)
% This function read ssh mask files from schlax.  They are binary with machine format little-endian

fid=fopen(filename,'r','l');
skip=fread(fid,1,'int32');
ntot=fread(fid,1,'int32');
nneg=fread(fid,1,'int32');
nx=fread(fid,1,'int32');
ny=fread(fid,1,'int32');
skip=fread(fid,1,'int32');
skip=fread(fid,1,'int32');
data=fread(fid,[1560,640],'int16')';
test = fread(fid','int16');
data(data==0)=nan;
mask=data;
fclose(fid);
j=[1:640];
i=[1:1560];
dy=.25;
dx=.25;
lat= -80+dy/2+(j-1)*dy;
lon= 259+dx/2+(i-1)*dx;
lon=lon-360;
lon(lon<0)=lon(lon<0)+360;
