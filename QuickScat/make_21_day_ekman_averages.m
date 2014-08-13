out_dir='/matlab/data/QuickScat/mat/'
out_head='QSCAT_30_25km_'
aout_dir='/matlab/data/eddy/V4/mat/'
aout_head='AVISO_25_W_'

%Set range of dates



jdays=[2451556:7:2454797];

%make f
load([aout_dir aout_head num2str(jdays(1))],'lat','lon')
lat=lat(41:600,:);
lon=lon(41:600,:);
ff=f_cor(lat);

for m=1:length(jdays)
	m
	load([out_dir out_head num2str(jdays(m))],'crlstr_week','bp26_crlstr')
	load([aout_dir aout_head num2str(jdays(m))],'bp26_crlg')
	bp26_crlg=bp26_crlg(41:600,:);
 	w_ek=(1./((ff+bp26_crlg)*1020)).*bp26_crlstr.*86400;
 	w_ek_full=(1./((ff+bp26_crlg)*1020)).*crlstr_week.*86400;
 	%w_ek_nl=(1./(1020*((ff+bp26_crlg).^2)).*((hp_ustr.*dfdy(ff+bp26_crlg,.25))-(hp_vstr.*dfdx(lat,ff+bp26_crlg,.25)))).*86400;
	%w_ek_tot=(dfdx(lat,(hp_vstr./(1020*(ff+bp26_crlg))),.25)-dfdy((hp_ustr./(1020*(ff+bp26_crlg))),.25)).*86400;
 	eval(['save -append ' out_dir out_head num2str(jdays(m))  ' lat lon w_ek*'])
 	clear *_week bp26_* w_ek*
end

