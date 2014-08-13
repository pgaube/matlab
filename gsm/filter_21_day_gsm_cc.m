
%Set range of dates
startyear = 1998;
startmonth = 01;
startday = 07;
endyear= 2008;
endmonth = 12;
endday = 31;

%construct date vector
%startjd=date2jd(startyear,startmonth,startday)+.5;
endjd=date2jd(endyear,endmonth,endday)+.5;
startjd=2453334;
jdays=[startjd:7:endjd];



%Set path and region
spath = '/Volumes/matlab/data/gsm/mat/GSM_9_21_';

[year,month,day]=jd2jdate(jdays);
%loess filter

for m=1:length(jdays)
	yearday(m) = year(m)*1000+julian(month(m),day(m),year(m));
	calday(m) =  year(m)*10000+month(m)*100+day(m);
	fprintf('\r   filtering %08u \r',calday(m))
	
	load([spath num2str(jdays(m))],'gchl_week','gcar_week')
	
	%sm=linx_smooth2d_f(gchl_week./gcar_week,2,2);
	sm=linx_smooth2d_f(gchl_week,2,2);
	lp=linx_smooth2d_f(sm,6,6);
	bp26_cc=sm-lp;
	eval(['save -append ' [spath num2str(jdays(m))] ' bp* sm'])	
	clear sm lp gchl_week gcar_week
end

