cd /matlab/matlab/regions
curs = {'cc',...
		'natl',...
		'haw',...
		'lw',...
		'eac',...
		'agu',...
		'bmc',...
		'gs',...
		'opac',...
		'agur',...
		'nhaw',...
		'satl',...
		'spac',...
		'pc',...
		'adv',...
		'lw2',...
		'lw_c',...
		'lw_p'};
set_regions
cd /matlab/matlab/argo/v1

for m=[1 3 5 7 8 9 17 18] 
	argo_radial_comps_orgin(['/matlab/data/eddy/V5/new_',curs{m},'_lat_lon_orgin_tracks.mat'],curs{m})
end    