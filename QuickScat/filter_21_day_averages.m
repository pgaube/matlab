spath='/matlab/data/QuickScat/mat/QSCAT_30_25km_'

%Set range of dates

jdays=[2451556:7:2454797];

[year,month,day]=jd2jdate(jdays);
%loess filter

for m=1:290%length(jdays)
	yearday(m) = year(m)*1000+julian(month(m),day(m),year(m));
	calday(m) =  year(m)*10000+month(m)*100+day(m);
	fprintf('\r   filtering %08u \r',calday(m))
	
	load([spath num2str(jdays(m))],'crlstr_week')
	
	sm=linx_smooth2d_f('crlstr_week',2,2);
	lp=linx_smooth2d_f(sm,6,6);
	bp26_crlstr=sm-lp;
	eval(['save -append ' [spath num2str(jdays(m))] ' bp*'])	
	clear crlstr_week lp sm bp26_crlstr
end

