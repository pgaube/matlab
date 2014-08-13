spath='~/data/QuickScat/new_mat/QSCAT_30_25km_'

%Set range of dates

jdays=[2451388:7:2455147];

[year,month,day]=jd2jdate(jdays);
%loess filter
load([spath num2str(jdays(30))],'lat','lon')
ff=f_cor(lat);
[r,c]=imap(-40,-20,60,120,lat,lon);
for m=1:length(jdays)
	yearday(m) = year(m)*1000+julian(month(m),day(m),year(m));
	calday(m) =  year(m)*10000+month(m)*100+day(m);
	fprintf('\r   filtering %08u \r',calday(m))
	
	load([spath num2str(jdays(m))],'hp66_crlstr')
	
	wek=(1./((ff*1020))).*hp66_crlstr.*86400;
% 	figure(1)
% 	clf
% 	pmap(lon(r,c),lat(r,c),w_ek(r,c))
% 	caxis([-.15 .15])
% 	drawnow
	eval(['save -append ' [spath num2str(jdays(m))] ' wek'])	
	clear wek hp66_crlstr
end

