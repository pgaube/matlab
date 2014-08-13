

set_satfish
lon=double(hdfread('~/fish/avhrr_data/poes/arc/2012_187_1307_n15_fd.hdf','/longitude'));
lat=double(hdfread('~/fish/avhrr_data/poes/arc/2012_187_1307_n15_fd.hdf','/latitude'));
for m=6%1:length(labs(:,1))
	labs(m,:)
	load([labs(m,:),'_sf_mask'],'mlat','mlon','mask') %set to land mask you want
	return
	avhrr_mask=griddata(mlon,mlat,mask,lon,lat,'nearest');
	tmp_mask=buffnan_rad(avhrr_mask,8);
	pass_land_mask=nan(size(tmp_mask));
	pass_land_mask(isnan(tmp_mask))=1;
	save([labs(m,:),'_sf_mask'],'-append','avhrr_mask','pass_land_mask') 
end	