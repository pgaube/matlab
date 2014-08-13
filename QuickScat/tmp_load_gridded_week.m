data_dir='/home/bettong/data2/data/QuickScat/gridded_week/'
out_dir='/Volumes/matlab/data/QuickScat/gridded_mstr_week/'
out_head='QSCAT_W_25km_'

%Set range of dates


startyear = 2002;
startmonth = 7;
startday = 3;
endyear = 2008;
endmonth = 01;
endday = 23;


%make lat lon
lat = -69.875:0.25:69.875;
lon = 0.125:0.25:359.875;


%construct date vector
startjd=date2jd(startyear,startmonth,startday)+.5;
endjd=date2jd(endyear,endmonth,endday)+.5;
jdays=[startjd:7:endjd];
[year,month,day]=jd2jdate(jdays);

%make matircies

st=find(jdays==2454370);
ed=find(jdays==2454489);
for m=226:250%st:ed
	yearday(m) = year(m)*1000+julian(month(m),day(m),year(m));
	calday(m) =  year(m)*10000+month(m)*100+day(m);
	fprintf('\r   Reading %08u \r',calday(m))
	if exist([data_dir 'global_' num2str(jdays(m)) '.mat'])
		data_file = [data_dir 'global_' num2str(jdays(m))];
		save_file = [out_dir out_head num2str(jdays(m))];
	
	load(data_file,'Wstrm', 'Wwspd','Wdivstr','Wdiv','Wcrlstr','Wcrl')
	lp=linx_smooth2d_f(Wstrm,20,10);
	hp_strm=Wstrm-lp;
	lp=linx_smooth2d_f(Wwspd,20,10);
	hp_wspd=Wwspd-lp;
	lp=linx_smooth2d_f(Wdivstr,20,10);
	hp_divstr=Wdivstr-lp;
	lp=linx_smooth2d_f(Wdiv,20,10);
	hp_div=Wdiv-lp;
	lp=linx_smooth2d_f(Wcrlstr,20,10);
	hp_crlstr=Wcrlstr-lp;
	lp=linx_smooth2d_f(Wcrl,20,10);
	hp_crl=Wcrl-lp;
	
	eval(['save ' save_file ' hp_div hp_crlstr hp_crl Wstrm hp_strm Wwspd Wdivstr Wdiv Wcrlstr Wcrl hp_wspd hp_divstr lat lon'])
	else
	fprintf('\r   missing %08u %07u\r',calday(m),jdays(m))
	end
	
end




