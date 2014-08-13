%make all FD regions for new FD site%from north to south


%chanel islands
fname='tbg_+73.41_+67.17_-42.06_-38.32.png'
minlon=-73.6875000000
maxlat=42.1063737058
maxlon=-67.2890625000
minlat=38.5412913044

[lat,lon,mask,tt]=read_jason_mask(fname,maxlat,minlat,maxlon,minlon,.2,-5,'ne1_mask');
