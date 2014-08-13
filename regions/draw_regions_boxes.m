hold on
set_regions

for m=[8 7 5 19 18]
	load(['~/matlab/domains/new_',curs{m},'_lat_lon'])
	draw_domain(lon,lat)
	clear lat lon
end