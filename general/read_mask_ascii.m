function [mask,lon,lat] = read_mask(filename)
% This function read ssh mask files from schlax.  They are binary with machine format little-endian


data=load(filename);
data=reshape(data,1560,640)';
%test = fread(fid','int16');
data(data==0)=nan;
mask=data;
%fclose(fid);
j=[1:640];
i=[1:1560];
dy=.25;
dx=.25;
lat= -80+dy/2+(j-1)*dy;
lon= 260+dx/2+(i-1)*dx;
lon=lon-360;
