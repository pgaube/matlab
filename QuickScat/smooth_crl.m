%this routine will load Schlax's masks, ssh and calculate u,v and crl


sp = '/Volumes/matlab/data/QuickScat/mat/'

%Set range of dates


startyear = 2002;
startmonth = 7;
startday = 3;
endyear = 2008;
endmonth = 12;
endday = 31;
%{
startyear = 1992;
startmonth = 10;
startday = 14;

endyear = 2008;
endmonth = 12;
endday = 03;
%}


%make lat lon



%construct date vector
startjd=date2jd(startyear,startmonth,startday)+.5;
endjd=date2jd(endyear,endmonth,endday)+.5;
jdays=[startjd:7:endjd];
[year,month,day]=jd2jdate(jdays);

%make maticies

%ii=find(jdays==2452879)
for m=83:length(jdays)
	save_file = [sp 'QSCAT_W_25km_' num2str(jdays(m))];
	load(save_file, 'hp66_crl')
	lp=linx_smooth2d_f(hp66_crl,2,2);
	sm66_crl=hp66_crl-lp;
	eval(['save -append ' save_file ' sm66_crl'])
	
	
end

fprintf('\n')



