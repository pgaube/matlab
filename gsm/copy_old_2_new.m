
startjd=2450849;
endjd=2454832;
jdays=[startjd:7:endjd];


load /Volumes/matlab/data/gsm/mean_gchl mask
%Set path and region
ipath = '/Volumes/matlab/data/gsm/mat/GSM_9_21_';
spath = '/Volumes/matlab/data/gsm/new_mat/GSM_9_21_';
[year,month,day]=jd2jdate(jdays);
load([ipath num2str(jdays(2))],'glon','glat')
%loess filter

for m=1:length(jdays)
	yearday(m) = year(m)*1000+julian(month(m),day(m),year(m));
	calday(m) =  year(m)*10000+month(m)*100+day(m);
	fprintf('\r  load and save of %08u \r',calday(m))
	
	load([ipath num2str(jdays(m))],'gcc_week','gcar_week')
	eval(['save -append ' [spath num2str(jdays(m))] ' gcc_week gcar_week'])	
	clear gcc_week gcar_week
end

