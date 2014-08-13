out_dir='/Volumes/matlab/data/QuickScat/new_mat/'
out_head='QSCAT_21_25km_'

%Set range of dates



jdays=[2451395:7:2454811];

%make lat lon
lat = -69.875:0.25:69.875;
lon = 0.125:0.25:359.875;
[lon,lat]=meshgrid(lon,lat);

[year,month,day]=jd2jdate(jdays);
%loess filter

for m=432:length(jdays)
	yearday(m) = year(m)*1000+julian(month(m),day(m),year(m));
	calday(m) =  year(m)*10000+month(m)*100+day(m);
	fprintf('\r   filtering %08u \r',calday(m))
	
	load([out_dir out_head num2str(jdays(m))])
	
	lp=nan(size(crl_21));
	
	lp66_crl=nan*lp;
	lp66_crl=linx_smooth2d_f(crl_21,6,6);
	hp66_crl=crl_21-lp66_crl;

	lp=nan*lp;
	lp=linx_smooth2d_f(wspd_21,20,10);
	hp_wspd=wspd_21-lp;
	
	%{
	lp=nan*lp;
	lp=linx_smooth2d_f(crlstr_21,6,6);
	hp66_crlstr=crlstr_21-lp;
	%}
	eval(['save -append ' [out_dir out_head num2str(jdays(m))] ' hp* lp*'])
	
end

