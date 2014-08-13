out_dir='/Volumes/matlab/data/QuickScat/new_mat/'
out_head='QSCAT_21_25km_'

%Set range of dates



jdays=[2451395:7:2454811];

%make lat lon
lat = -69.875:0.25:69.875;
lon = 0.125:0.25:359.875;
[lon,lat]=meshgrid(lon,lat);

[year,month,day]=jd2jdate(jdays);
%loess filter

for m=1:length(jdays)
	yearday(m) = year(m)*1000+julian(month(m),day(m),year(m));
	calday(m) =  year(m)*10000+month(m)*100+day(m);
	fprintf('\r   filtering %08u \r',calday(m))
	
	load([out_dir out_head num2str(jdays(m))],'crlstr_21')
	
	lp=linx_smooth2d_f(crlstr_21,6,6);
	bp615_crlstr=linx_smooth2d_f(crlstr_21,1.5,1.5)-lp;

	eval(['save -append ' [out_dir out_head num2str(jdays(m))] ' bp615_crlstr'])
	
end

