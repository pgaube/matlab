
startjd=2450884%2450849
endjd=2454797%2454832

jdays=[startjd:7:endjd];


load /matlab/data/gsm/mask mask
%Set path and region
spath = '/matlab/data/gsm/mat/GSM_9_21_';
[year,month,day]=jd2jdate(jdays);
%loess filter


for m=1:length(jdays)
	yearday(m) = year(m)*1000+julian(month(m),day(m),year(m));
	calday(m) =  year(m)*10000+month(m)*100+day(m);
	fprintf('\r   filtering %08u \r',calday(m))
	
	load([spath num2str(jdays(m))],'gchl_week','glon','glat')
	
	
	
	%raw filter
	cc=10.^gchl_week.*mask;
	%bd=find(cc>=20);
	%cc(bd)=nan;
	%cc=cc.*mask;
	sm=linx_smooth2d_fill_f(cc,2,2);
	lp=linx_smooth2d_f(sm,20,10);
	raw_bp21_chl=(sm-lp).*mask;
	ii=find(abs(raw_bp21_chl)>.5);
	raw_bp21_chl(ii)=nan;
	
	%ii=find(abs(raw_bp26_car)>.3);
	%raw_bp26_car(ii)=nan;
	figure(1)
	clf
	pcolor(glon,glat,raw_bp21_chl);shading flat
	caxis([-.05 .05])
	

	eval(['save -append ' [spath num2str(jdays(m))] ' raw_bp21_chl'])	
	clear raw_* sm* lp gchl_* hp* cc
end

