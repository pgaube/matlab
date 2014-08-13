clear all

ncid=netcdf.open('/data/argo/mldinfo_varDT.nc', 'NC_NOWRITE');
[dum,tes]=netcdf.inq(ncid);

plat = netcdf.getvar(ncid,netcdf.inqvarid(ncid,'latitude'));
plon = netcdf.getvar(ncid,netcdf.inqvarid(ncid,'longitude'));
date = datevec(double(netcdf.getvar(ncid,netcdf.inqvarid(ncid,'date'))));
mld = netcdf.getvar(ncid,netcdf.inqvarid(ncid,'da_mld'));
pjday=date2jd(date(:,1),date(:,2),date(:,3));

save UCSD_mld plat plon mld pjday

