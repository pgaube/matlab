%download hdf files from
%http://eastcoast.coastwatch.noaa.gov/data/avhrr/sst/daily/ec/
%AVHCW_2013223_3DAY_MULTISAT_SSTMASKED_NE_1KM.hdf
sst=double(sst_masked);
sst(sst<0)=nan;
sst=flipud(0.01*sst);

lat=linspace(38,47,length(sst(:,1)));
lon=linspace(-73,-59,length(sst(1,:)));

figure(1)
clf
pmap(lon,lat,sst)
