spath='/matlab/data/eddy/V5/AVISO_25_W_'

%Set range of dates

jdays=[2448910:7:2454832];
[year,month,day]=jd2jdate(jdays);
%loess filter

for m=1:length(jdays)
	yearday(m) = year(m)*1000+julian(month(m),day(m),year(m));
	calday(m) =  year(m)*10000+month(m)*100+day(m);
	fprintf('\r   filtering %08u \r',calday(m))
	
	load([spath num2str(jdays(m))],'crl')
	
	%sm=linx_smooth2d_f(crl,2,2);
	lp=linx_smooth2d_f(sm,6,6);
	%bp26_crlg=sm-lp;
	hp66_crlg=crl-lp;
	clear crl lp
	eval(['save -append ' [spath num2str(jdays(m))] ' hp*'])	
end

