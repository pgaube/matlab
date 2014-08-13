data_dir='/home/bettong/data2/data/QuickScat/gridded_week/'
out_dir='/Volumes/matlab/data/QuickScat/mat/'
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

missing_m=[];
qq=1;
%make matircies

for m=1:length(jdays)
	yearday(m) = year(m)*1000+julian(month(m),day(m),year(m));
	calday(m) =  year(m)*10000+month(m)*100+day(m);
	fprintf('\r   Reading %08u \r',calday(m))
	if exist([data_dir 'global_' num2str(jdays(m)) '.mat'])
		data_file = [data_dir 'global_' num2str(jdays(m))];
		save_file = [out_dir out_head num2str(jdays(m))];
	
	%load(data_file,'Wustr', 'Wvstr')
	load(data_file,'Wstrm', 'Wwspd','Wcrlstr','Wcrl')
	
	
	lp=linx_smooth2d_f(Wstrm,20,10);
	hp_strm=Wstrm-lp;
	lp=linx_smooth2d_f(Wwspd,20,10);
	hp_wspd=Wwspd-lp;
	lp=linx_smooth2d_f(Wcrlstr,20,10);
	hp_crlstr=Wcrlstr-lp;
	%lp=linx_smooth2d_f(Wcrl,3,3);
	%hp33_crl=Wcrl-lp;
	lp66_crl=linx_smooth2d_f(Wcrl,6,6);
	hp66_crl=Wcrl-lp66_crl;
	
	
	
	if exist([save_file, '.mat'])
    %eval(['save -append ' save_file ' W*'])
    eval(['save -append ' save_file ' hp* W* lat lon'])
    else
    %eval(['save ' save_file ' W* lat lon'])
    eval(['save ' save_file ' hp* W* lat lon'])
    end
	end
	
end

save missing_gridd_week missing_m
