% read_ssmi_day_v6.m
%
% this subroutine reads uncompressed RSS SSM/I daily byte maps
% (version-6 data released Sepetember 2006)
%
% input arguments:
% data_file = the full path and name of the uncompressed data file
%
% the function returns these products:
% time = time of observation in fractional hours GMT
% wind = wind speed in meters/second
% vapor = atmospheric water vapor in millimeters
% cloud = liquid cloud water in millimeters
% rain  = rain rate in millimeters/hour
%
%  longitude is 0.25*xdim- 0.125
%  latitude  is 0.25*ydim-90.125
%
% For detailed data description, see 
% http://www.remss.com/ssmi/ssmi_data_description.html
%
% Remote Sensing Systems
% support@remss.com

function [time,wind,vapor,cloud,rain] = read_ssmi_day_v6(data_file)

scale=[.1,.2 .3 .01 .1];
xdim=1440;ydim=720;tdim=2;numvar=5;
mapsiz=xdim*ydim*tdim;

if ~exist(data_file)
   error = ['file not found: ', data_file]
   time=[];wind=[];vapor=[];cloud=[];rain=[];
   return;
end;

fid=fopen(data_file,'rb');
data=fread(fid,mapsiz*numvar,'uint8');
fclose(fid);
data_file
map=reshape(data,[xdim ydim numvar tdim]);

for i=1:numvar
    tmp=map(:,:,i,:);
    ia=find(tmp<=250);tmp(ia)=tmp(ia)*scale(i);
    map(:,:,i,:)=tmp;
end;

time  = map(:,:,1,:);
wind  = map(:,:,2,:);
vapor = map(:,:,3,:);
cloud = map(:,:,4,:);
rain  = map(:,:,5,:);

return;
