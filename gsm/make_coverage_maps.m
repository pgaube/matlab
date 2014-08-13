
startjd=2450821
endjd=2454461

jdays=[startjd:7:endjd];


load /matlab/data/gsm/mask mask
%Set path and region
spath = '/matlab/data/gsm/mat/GSM_9_21_';
[year,month,day]=jd2jdate(jdays);
%loess filter


for m=1:length(jdays)
	yearday(m) = year(m)*1000+julian(month(m),day(m),year(m));
	calday(m) =  year(m)*10000+month(m)*100+day(m);
	fprintf('\r   flagging %08u \r',calday(m))
	
	load([spath num2str(jdays(m))],'gchl_week')
	
	
	
	flag_good=zeros(size(gchl_week));
	flag_good(find(~isnan(gchl_week)))=1;
	

	eval(['save -append ' [spath num2str(jdays(m))] ' flag_good'])	
	clear gchl_*  flag_good
end

