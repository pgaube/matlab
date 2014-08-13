out_dir='/Volumes/matlab/data/QuickScat/mat/'
out_head='QSCAT_W_25km_'
out_head2='QSCAT_35_25km_'

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

%%% LOOK HERE
jdays=[startjd+14:7:endjd-14];
%%%

[year,month,day]=jd2jdate(jdays);


%make matircies

for m=1:length(jdays)
	[t_hp66_crl, t_hp_wspd, t_hp_strm] = deal(nan(560,1440,5));
	yearday(m) = year(m)*1000+julian(month(m),day(m),year(m));
	calday(m) =  year(m)*10000+month(m)*100+day(m);
	fprintf('\r   Reading %08u \r',calday(m))
	
	save_file1 = [out_dir out_head num2str(jdays(m)-14)];
	save_file2 = [out_dir out_head num2str(jdays(m)-7)];
	save_file3 = [out_dir out_head num2str(jdays(m))];
	save_file4 = [out_dir out_head num2str(jdays(m)+7)];
	save_file5 = [out_dir out_head num2str(jdays(m)+14)];
	save_file_new = [out_dir out_head2 num2str(jdays(m))];
	
	load(save_file1,'hp66_crl','hp_wspd','hp_strm')
	t_hp66_crl(:,:,1)=hp66_crl;
	t_hp_wspd(:,:,1)=hp_wspd;
	t_hp_strm(:,:,1)=hp_strm;
	load(save_file2,'hp_wspd','hp_strm')
	t_hp66_crl(:,:,2)=hp66_crl;
	t_hp_wspd(:,:,2)=hp_wspd;
	t_hp_strm(:,:,2)=hp_strm;
	load(save_file3,'hp_wspd','hp_strm')
	t_hp66_crl(:,:,3)=hp66_crl;
	t_hp_wspd(:,:,3)=hp_wspd;
	t_hp_strm(:,:,3)=hp_strm;
	load(save_file4,'hp_wspd','hp_strm')
	t_hp66_crl(:,:,4)=hp66_crl;
	t_hp_wspd(:,:,4)=hp_wspd;
	t_hp_strm(:,:,4)=hp_strm;
	load(save_file5,'hp_wspd','hp_strm')
	t_hp66_crl(:,:,5)=hp66_crl;
	t_hp_wspd(:,:,5)=hp_wspd;
	t_hp_strm(:,:,5)=hp_strm;
	
	hp66_crl=nanmean(t_hp66_crl,3);
	hp_wspd=nanmean(t_hp_wspd,3);
	hp_strm=nanmean(t_hp_strm,3);
	eval(['save ' save_file_new  ' hp* lat lon'])
	
	
end

