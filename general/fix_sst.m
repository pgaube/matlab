
head = 'OI_25_W_'
pp = '/Volumes/matlab/data/ReynoldsSST/mat/'

for m=1:length(mid_week_jdays)
	fname = [pp head num2str(mid_week_jdays(m))];
	load(fname)
	filtered_sst_oi=filtered_sst;
	sst_oi=sst;
	save(fname, 'sst_oi','filtered_sst_oi','mid_week_jdays',...
	 			'lat','lon')
end	