% read_amsr_day_v5.m
%
% this subroutine reads uncompressed RSS AMSR-E or AMSR-J daily byte maps
% (version-5)
%
% input arguments:
% file_name = the full path and name of the uncompressed data file
%
% the function returns these products:
% time = time of observation in fractional hours GMT
% sst = sea surface temperature in deg C
% wind = wind speed in meters/second
% vapor = atmospheric water vapor in millimeters
% cloud = liquid cloud water in millimeters
% rain  = rain rate in millimeters/hour
%
% longitude is 0.25*xdim-0.125
% latitude is 0.25*ydim-90.125
%
% For detailed data description, see 
% http://www.remss.com/amsr/amsr_data_description.html
%
% Remote Sensing Systems
% support@remss.com

function [time,sst,wind,vapor,cloud,rain] = read_amsr_day_v5(file_name)

scale=[.1,.15 .2 .3 .01 .1];
offset=[0 -3 0 0 0 0];
xdim=1440;ydim=720;tdim=2;numvar=6;
mapsiz=xdim*ydim*tdim;

if ~exist(file_name)
   error = ['file not found: ', file_name]
   time=[];sst=[];wind=[];vapor=[];cloud=[];rain=[];
   return;
end;

fid=fopen(file_name,'rb');
data=fread(fid,mapsiz*numvar,'uint8');
fclose(fid);
%data_file
map=reshape(data,[xdim ydim numvar tdim]);

for i=1:numvar
    tmp=map(:,:,i,:);
    ia=find(tmp<=250);tmp(ia)=tmp(ia)*scale(i)+offset(i);
    map(:,:,i,:)=tmp;
end;

time  = map(:,:,1,:);
sst   = map(:,:,2,:);
wind  = map(:,:,3,:);
vapor = map(:,:,4,:);
cloud = map(:,:,5,:);
rain  = map(:,:,6,:);

return;
