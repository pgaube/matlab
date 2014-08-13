%loads NetCDF data using the mexcdf.m comand

%Specify path and fname
% i.e   path = '/Users/gaube/Documents/OSU/data/QuickScat/'
%       fname = 'wind_spd_cubed_monthly_maps.nc'


%Read nc file and find num var
path = '/Volumes/matlab/data/QuickScat/from_craig/'
fname = 'wind_spd_cubed_monthly_maps.nc'

file=[path fname];
[ncid] = mexnc('OPEN',file,'write');
[nvars] = mexnc('INQ_NVARS',ncid);


%Load data  into [lat,lon,time] matrix
for i = 0:nvars-1
    var = mexnc('GET_VAR_DOUBLE',ncid,i);
    var(var==-9999)=nan;
    fname = ['var_', int2str(i)];
    eval([fname ' = var' char(39) ';']);
end

lat = var_0;
lon = var_1;
wnd_spd_cubed=cat(3,var_2,var_3,var_4,var_5,var_6,var_7,var_8,var_9,var_10,var_11,var_12,var_13);

clear var* path fname file ncid nvars i fname

