function data = load_ncep_nc(path,fname);

%loads NetCDF data using the mexcdf.m comand

%Specify path and fname
% i.e   path = '/Users/gaube/Documents/OSU/data/QuickScat/'
%       fname = 'wind_spd_cubed_monthly_maps.nc'

load ncep_mask

%Set scale and offset from file metadata
scale = 0.00999999977648258;
offset = 225.449996948242;
missingvalue = 32766;

%Read nc file and find num var
file=[path fname];
[ncid] = mexnc('OPEN',file,'write');
[nvars] = mexnc('INQ_NVARS',ncid);

%Load data data into [lat,lon,time] matrix
tmp = mexnc('GET_VAR_DOUBLE',ncid,3);

%set up for map projectio and add landmask
[m,n,p] = size(tmp);
data = nan(n,m,p);

for i = 1:length(tmp(1,1,:))    
    x = tmp(:,:,i);
    x = x.*mask;
    x = x';
    x = flipdim(x,1);
    x(x==missingvalue)=nan;
    x = (x.*scale)+offset;
    data(:,:,i) = x;
end