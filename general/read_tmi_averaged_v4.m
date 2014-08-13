
% this subroutine reads RSS TMI averaged byte maps (Version-4 released September 2006).
% The averaged files include: 3-Day, weekly, and monthly time composites.
% The averaged time composite files all share the same data format.
%
% File name format is  	tmi_yyyymmddv4_d3d for 3-day (average of 3 days ending on file date)
%			      tmi_yyyymmddv4	 for weekly  (start sunday, end saturday, named by saturday date)
%			      tmi_yyyymmv4	 for monthly 
%
% input arguments:
% data_file = the full path and name to the uncompressed data file
%
% the function returns these products:
% sst = sea surface temperature in deg C
% wind11 = wind speed derived using 11 GHz channel in meters/second
% wind37 = wind speed derived using 37 GHz channel in meters/second
% vapor = atmospheric water vapor in millimeters
% cloud = liquid cloud water in millimeters
% rain  = rain rate in millimeters/hour
%
% longitude is 0.25*xdim- 0.125
% latitude  is 0.25*ydim-40.125
%
% For detailed data description, see 
% http://www.remss.com/tmi/tmi_description.html
% Remote Sensing Systems
% support@remss.com


function [sst,wind11,wind37,vapor,cloud,rain]=read_tmi_averaged_v4(data_file)

scale=[.15 .2 .2 .3 .01 .1];
offset=[-3 0 0 0 0 0];
xdim=1440;ydim=320;numvar=6;
mapsiz=xdim*ydim;

if ~exist(data_file)
   error = ['file not found: ', data_file]
   sst=[];wind=[];vapor=[];cloud=[];rain=[];
   return;
end;

fid=fopen(data_file,'rb');
data=fread(fid,mapsiz*numvar,'uint8');
fclose(fid);
data_file
map=reshape(data,[xdim ydim numvar]);

for i=1:numvar
    tmp=map(:,:,i);
    ia=find(tmp<=250);tmp(ia)=tmp(ia)*scale(i)+offset(i);
    map(:,:,i)=tmp;
end;

sst    = map(:,:,1);
wind11 = map(:,:,2);
wind37 = map(:,:,3);
vapor  = map(:,:,4);
cloud  = map(:,:,5);
rain   = map(:,:,6);

return;