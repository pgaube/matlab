%this routine will load Schlax's masks, ssh and calculate u,v and crl

pp = '/Volumes/matlab/data/eddy/V4/'
sp = '/Volumes/matlab/data/eddy/V4/mat/'

%Set range of dates


startyear = 1992;
startmonth = 10;
startday = 14;

endyear = 2008;
endmonth = 12;
endday = 31;


%make lat lon



%construct date vector
startjd=date2jd(startyear,startmonth,startday)+.5;
endjd=date2jd(endyear,endmonth,endday)+.5;
jdays=[startjd:7:endjd];
[year,month,day]=jd2jdate(jdays);

%make maticies

%ii=find(jdays==2452879)
for m=1:length(jdays)
	yearday(m) = year(m)*1000+julian(month(m),day(m),year(m));
	calday(m) =  year(m)*10000+month(m)*100+day(m);
	fprintf('\r   Reading %08u \r',calday(m))
	ssh_file = [pp 'quarter_regrid_ssmi_mask/aviso_' num2str(calday(m)) '.raw'];
	save_file = [sp 'AVISO_25_W_' num2str(jdays(m))];
	
	[raw_ssh,lon,lat]=read_ssh(ssh_file);

	eval(['save -append ' save_file ' raw_ssh'])
	
	
end

fprintf('\n')



