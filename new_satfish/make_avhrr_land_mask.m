function make_avhrr_land_mask(mask_file,avhrr_file)

lon=double(hdfread(avhrr_file,'/longitude'));
lat=double(hdfread(avhrr_file,'/latitude'));
load(mask_file,'mlat','mlon','mask')
whos lon lat mlon mlat

% avhrr_mask=griddata(mlon,mlat,mask,lon,lat,'nearest');
avhrr_mask=interp2(mlon,mlat,mask,lon,lat,'nearest');
save(mask_file,'-append','avhrr_mask')
