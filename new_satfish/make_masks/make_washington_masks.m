%make all FD regions for new FD site%from north to south


%chanel islands
fname='tbg_+48.44_+45.43_-128.10_-123.29.png'
minlon=-128.1031320285
maxlat=48.4466933596
maxlon=-123.2948171903
minlat=45.4354664617

[lat,lon,mask,tt]=read_jason_mask(fname,maxlat,minlat,maxlon,minlon,.2,-8,'wa1_mask');
