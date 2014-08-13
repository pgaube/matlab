
jdays=[2450821:2454489];



%Set path and region
spath = '/Volumes/matlab/data/SeaWiFS/mat/SCHL_9_D_';

[year,month,day]=jd2jdate(jdays);
%loess filter

for m=315:length(jdays)
	yearday(m) = year(m)*1000+julian(month(m),day(m),year(m));
	calday(m) =  year(m)*10000+month(m)*100+day(m);
	fprintf('\r   filtering %08u \r',calday(m))
	
	if exist([spath num2str(jdays(m)) '.mat'])
	load([spath num2str(jdays(m))],'gchl_day')
	
	
	lp22_chl=10.^(linx_smooth2d_f(log10(gchl_day),2,2));
	%lp22_chl=10.^(smooth2d_f(log10(gchl_day),2,2));
	eval(['save -append ' [spath num2str(jdays(m))] ' lp*'])
	end
end

