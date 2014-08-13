% Function to read data from a level 2 MODIS or SeaWiFS file.
% Copyright by Jasmine S Nahorniak, Oregon State University.
% apr 25 2008 
% [data]=readMODISL2(pathfile,parameter);
%    parameters: chlor_a,latitude,longitude,K_490,nLw_412
%

function [data]=readMODISL2(pathfile,parameter);

SD_id = hdfsd('start',pathfile,'read');   % open HDF file

% find the ref number for the parameter
for ref=1:40,
  sds_index = hdfsd('reftoindex',SD_id,ref);  % create an index number from the reference number
  sds_id = hdfsd('select',SD_id,sds_index); % create an id number
  [name,rank,edge,data_type,nattrs,status2] = hdfsd('getinfo',sds_id); % info about data
  if (strmatch(name,parameter,'exact')),
      break;
  end
end

if ref==40,
    fprintf(1,'%s','Parameter not found.');
    return;
end

% get slope and intercept
slopeid=hdfsd('findattr',sds_id,'slope');
interceptid=hdfsd('findattr',sds_id,'intercept');
[slope,slopestat] = hdfsd('readattr',sds_id,slopeid);
[intercept,interceptstat] = hdfsd('readattr',sds_id,interceptid);
if slopestat==-1,
   slope=1;
   intercept=0;
end



% get data
start=0*ones(1,rank);               % starting data point
stride=1*ones(1,rank);              % step between data points in each direction
[data,status3] = hdfsd('readdata',sds_id,start,stride,edge);  % read dataset
data=double(data);                   % convert from int16 to double precision
status4 = hdfsd('endaccess',sds_id);  % close dataset

status5 = hdfsd('end',SD_id);   % close HDF file

% apply the slope and intercept
data=data*double(slope)+double(intercept);
