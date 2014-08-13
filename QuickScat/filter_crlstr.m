spath='/matlab/data/QuickScat/new_mat/QSCAT_30_25km_'

%Set range of dates

jdays=[2451381+7:7:2455154-7];

[year,month,day]=jd2jdate(jdays);
%loess filter

for m=1:length(jdays)
	yearday(m) = year(m)*1000+julian(month(m),day(m),year(m));
	calday(m) =  year(m)*10000+month(m)*100+day(m);
	fprintf('\r   filtering %08u \r',calday(m))
	
	load([spath num2str(jdays(m))],'crlstr_week')
	
	sm=linx_smooth2d_f(crlstr_week,2,2);
	lp=linx_smooth2d_f(sm,6,6);
	bp26_crlstr=sm-lp;
	hp66_crlstr=crlstr_week-lp;
	
	eval(['save -append ' [spath num2str(jdays(m))] ' bp26_* hp*'])	
	clear *_week lp sm bp* hp*
end

