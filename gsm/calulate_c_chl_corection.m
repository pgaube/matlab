
startjd=2450849;
endjd=2454832;
jdays=[startjd:7:endjd];


load /Volumes/matlab/data/gsm/mean_gchl mask
%Set path and region
spath = '/Volumes/matlab/data/gsm/new_mat/GSM_9_21_';
[year,month,day]=jd2jdate(jdays);
load([ipath num2str(jdays(2))],'glon','glat')
%loess filter

for m=1:length(jdays)
	yearday(m) = year(m)*1000+julian(month(m),day(m),year(m));
	calday(m) =  year(m)*10000+month(m)*100+day(m);
	fprintf('\r  calculating grad and theta of %08u \r',calday(m))
	
	load([spath num2str(jdays(m))],'gchl_100_day')
	
	sm_gchl_100_day=sm=linx_smooth2d_f(gchl_100_day,2,2);
	dcdy=single(-dfdy(sm_gchl_100_day,.25).*1e5);
	dcdx=single(dfdx(glon,sm_gchl_100_day,.25).*1e5);
	theta=single(rad2deg(cart2pol(dcdx,dcdy)));
	

	eval(['save -append ' [spath num2str(jdays(m))] ' sm_gchl_100_day dcdx dcdy theta'])	
	clear sm*
end

