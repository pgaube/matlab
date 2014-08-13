function [ssh,lon,lat] = read_ssh(filename)
% This function read ssh files from schlax.  They are binary with machine format little-endian

fid=fopen(filename,'r','l');
skip=fread(fid,1,'float');
data=fread(fid,[1440,640],'float=>single')';
data(data>1e35)=nan;
ssh=data;
fclose(fid);
j=[1:640];
i=[1:1440];
dy=.25;
dx=.25;
lat= -80+dy/2+(j-1)*dy;
lon= 0+dx/2+(i-1)*dx;