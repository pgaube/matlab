%loads NetCDF data using the mexcdf.m comand

%Set path and fname
path = '/Volumes/matlab/data/ReynoldsSST/'
fname = 'sst4-navy-amsr-eot.20080101.nc'

%Read nc file and find num var
file=[path fname];
[ncid] = mexnc('OPEN',file,'write');
[nvars] = mexnc('INQ_NVARS',ncid);
lat = mexnc('GET_VAR_DOUBLE',ncid,2);
lon = mexnc('GET_VAR_DOUBLE',ncid,3);
sst = mexnc('GET_VAR_DOUBLE',ncid,4);
sst(sst<-900)=nan;
sst = (sst*.01)';
clear path fname x file