

startjd=2450884
endjd=2454832

jdays=[startjd:7:endjd];


load /matlab/data/gsm/mean_gchl mask
load /matlab/data/gsm/mat/GSM_9_21_2450821 glon glat
%Set path and region
spath = '/matlab/data/mu/mat/MU_25_30_';
[year,month,day]=jd2jdate(jdays);
%loess filter


for m=1:100%length(jdays)
	yearday(m) = year(m)*1000+julian(month(m),day(m),year(m));
	calday(m) =  year(m)*10000+month(m)*100+day(m);
	fprintf('\r   filtering %08u \r',calday(m))
	
	load([spath num2str(jdays(m))],'hp_mu_week','mu_week')
	
	cc=hp_mu_week;
	cc(isnan(cc))=1e35;
	cc=cc.*mask;
	s=linx_smooth2d_fill_f(cc,2,2);
	lp=linx_smooth2d_f(s,20,10);
	bp21_mu=s-lp;
	
	cc=mu_week;
	cc(isnan(cc))=1e35;
	cc=cc.*mask;
	sm_mu_week=linx_smooth2d_fill_f(cc,2,2);

	eval(['save -append ' [spath num2str(jdays(m))] ' sm* bp*'])	
	clear raw_* sm* lp gchl_* hp* cc glon glat
end

