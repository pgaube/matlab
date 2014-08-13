spath='/matlab/data/QuickScat/new_mat/QSCAT_30_25km_'

%Set range of dates

jdays=[2451381+7:7:2455154-7];

[year,month,day]=jd2jdate(jdays);
%loess filter

for m=1:length(jdays)
	yearday(m) = year(m)*1000+julian(month(m),day(m),year(m));
	calday(m) =  year(m)*10000+month(m)*100+day(m);
	fprintf('\r   filtering %08u \r',calday(m))
	
	load([spath num2str(jdays(m))],'v_week','u_week')
	
	wspd_week=sqrt(u_week.^2+v_week.^2);
	sm=linx_smooth2d_f(wspd_week,2,2);
	lp=linx_smooth2d_f(sm,6,6);
	bp26_wspd=sm-lp;
	hp66_wspd=wspd_week-lp;
	
	sm_u_week=linx_smooth2d_f(u_week,6,6);
	%sm_v_week=linx_smooth2d_f(v_week,6,6);
	
	
	eval(['save -append ' [spath num2str(jdays(m))] ' bp26_* hp* sm_*'])	
	%eval(['save -append ' [spath num2str(jdays(m))] ' sm_*'])	
	clear *_week lp sm bp* hp*
end

