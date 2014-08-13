spath='/matlab/data/QuickScat/new_mat/QSCAT_30_25km_'

%Set range of dates

jdays=[2451381+7:7:2455154-7];

[year,month,day]=jd2jdate(jdays);
%loess filter
load qscat_lat_lon
for m=1:length(jdays)
	yearday(m) = year(m)*1000+julian(month(m),day(m),year(m));
	calday(m) =  year(m)*10000+month(m)*100+day(m);
	fprintf('\r   filtering %08u \r',calday(m))

	
	eval(['save -append ' [spath num2str(jdays(m))] ' lat lon'])	

end

