%loads NetCDF data using the mexcdf.m comand

%Set path and fname
path = '/Volumes/matlab/data/SSH/'
fname = 'msla_oer_merged_h_21391.nc'

%Read nc file and find num var
file=[path fname];
[ncid] = mexnc('OPEN',file,'write');
[nvars] = mexnc('INQ_NVARS',ncid);

%Load wind data into [lat,lon,time] matrix
for i = 2:nvars-1
    x = mexnc('GET_VAR_DOUBLE',ncid,i);
    x=x';
    x(x==-9999)=nan;
    wind(:,:,i-1)=x;
end

%Get lat and lon vectors
lat = mexnc('GET_VAR_DOUBLE',ncid,1);
%lon = mexnc('GET_VAR_DOUBLE',ncid,14);  %CRAIG variable 14 seems to be
%corrupted, please check you nc file
  
clear path fname x file