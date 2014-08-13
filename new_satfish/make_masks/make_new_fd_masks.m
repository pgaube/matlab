%make all FD regions for new FD site%from north to south


%chanel islands
fname='bw_masks/bwi_+3430_+3250_-12125_-11850.png'
minlon=-121.4166666667
maxlat=34.5000000000
maxlon=-118.8333333333
minlat=32.8333333333

[lat,lon,mask]=read_mask(fname,maxlat,minlat,maxlon,minlon,.2,-8,'ca2_mask');

%SoCAl offshore and islands
fname='bw_masks/bwi_+3400_+33230_-11915_-11714.png'
minlon=-119.2500000000
maxlat=34.0000000000
maxlon=-117.2333333333
minlat=32.5000000000
[lat,lon,mask]=read_mask(fname,maxlat,minlat,maxlon,minlon,.2,-8,'ca3_mask');

%SoCAl banks
fname='bw_masks/bwi_+3250_+3120_-11915_-11735.png'
minlon=-119.2500000000
maxlat=32.8411483765
maxlon=-117.5833358765
minlat=31.3333339691
[lat,lon,mask]=read_mask(fname,maxlat,minlat,maxlon,minlon,.2,-8,'ca4_mask');

%SD to Ens
fname='bw_masks/bwi_+3245_+3125_-11805_-11635.png'
minlon=-118.0833358765
maxlat=32.75
maxlon=-116.5833358765
minlat=31.4166660309
[lat,lon,mask]=read_mask(fname,maxlat,minlat,maxlon,minlon,.2,-8,'ca5_mask');


%Ens to SQ
fname='bw_masks/bwi_+3140_+3000_-11830_-11555.png'
minlon=-118.5
maxlat=31.6666666667
maxlon=-115.9159037482
minlat=30
[lat,lon,mask]=read_mask(fname,maxlat,minlat,maxlon,minlon,.2,-8,'ca6_mask');