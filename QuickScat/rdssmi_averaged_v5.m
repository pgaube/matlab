% rdSSMI_averaged_v5 - reads uncompressed SSM/I data from Remote Sensing 
%   Systems' byte map format  (version 5 release August 2002)
%   time-averaged files can be 3-day, weekly or monthly averages
% File name format is  	
%   Fss_yyyymmddv5_d3d for 3-day   (average of 3 days ending on file date)
%   Fss_yyyymmddv5 for weekly  (start sunday, end saturday, named by saturday 
%                               date)
%   Fss_yyyymmv5 for monthly 
%	
%   Usage: 
%      ssmi_data = rdSSMI_averaged_v5(filename)
%      ssmi_data = rdSSMI_averaged_v5(filename,icemask)
%      ssmi_data = rdSSMI_averaged_v5(filename,icemask,landmask)
%
%      Return argument data is a structure containing data the following fields:
%
%        wind - wind speed in m/s
%	 vapor - integrated column water vapor in mm
%	 cloud - total cloud liquid water in mm
%	 rain - rain rate in mm/hr
%	 ice - sea ice mask (null matrix unless icemask argument is nonzero)
%	 land - land mask (null matrix unless landmask argument is nonzero)
%
%      All missing or bad data are represented as NaNs.  Memory requirements 
%      are significant as MATLAB converts values to 8 byte double precision 
%      for internal storage.  
%
%      longitude is 0.25*xdim-0.125,  latitude is 0.25*ydim-90.125
%
%
%      r1.0, 2002/08/20	reads version5 time-averaged files
%
%	Matthias Schabel
%	Remote Sensing Systems
%	438 First St., Suite 200
%	Santa Rosa, CA  95401
%	http://www.remss.com/support

function  ssmi_data = rdSSMI_averaged_v5(filename,landmask,icemask)

if (nargin == 1)
   icemask = 0;
   landmask = 0;
elseif (nargin == 2)
   landmask = 0;
end;
   
xdim=1440;
ydim=720;
mapsiz=xdim*ydim;
nummaps=4;

fid=fopen(filename,'rb');
data=fread(fid,mapsiz*nummaps,'uint8');
for i=1:nummaps
   offs1=(i-1)*mapsiz+1;
   offs2=i*mapsiz;
   map(i,:,:)=fliplr(reshape(data(offs1:offs2),[xdim ydim]))';
   map(i,find(map(i,:,:)>250)) = NaN;
end;
fclose(fid);

if (icemask | landmask)
   tmp=fliplr(reshape(data(1*mapsiz+1:2*mapsiz),[xdim ydim]))';
end;

if (icemask)
	ice=zeros(size(tmp));
	ice(:,:)=NaN;
	ice(find(tmp==252))=1;
   ice(find(tmp<=250))=0;
else
	ice=[];
end;

if (landmask)
	land=zeros(size(tmp));
	land(:,:)=NaN;
	land(find(tmp==255))=1;
   land(find(tmp<=250))=0;
else
	land=[];
end;

ssmi_data=struct('wind',squeeze(flipdim(map(1,:,:)*0.2,2)),...
	     'vapor',squeeze(flipdim(map(2,:,:)*0.3,2)),...
	     'cloud',squeeze(flipdim(map(3,:,:)*0.01,2)),...
           'rain',squeeze(flipdim(map(4,:,:)*0.1,2)),...
           'ice',flipud(ice),'land',flipud(land));
        
     
return;
