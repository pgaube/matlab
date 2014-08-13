%loads NetCDF data using the mexcdf.m command

%Set range of dates
%
% Use the following for match up with CLS SSH
%

startyear = 2002;
startmonth = 07;
startday = 03;  %must be mid-week day from aviso SSH -3

endyear = 2008;
endmonth = 1;
endday = 23;

%construct date vector
startjd=date2jd(startyear,startmonth,startday)+.5;
endjd=date2jd(endyear,endmonth,endday)+.5;
jdays=[startjd-3:endjd+3];

%construct date vector for mid-week day
mid_week_jdays=[startjd:7:endjd];
%mid_week_jdays=2454055;


%Set path and region
save_path = '/Volumes/matlab/data/ReynoldsSST/mat/'
path ='/Volumes/matlab/data/ReynoldsSST/netcdf_v2/'
n=length(mid_week_jdays)
for m=1:length(mid_week_jdays)
	m
    eval(['load ' save_path 'OI_25_W_' num2str(mid_week_jdays(m)), ' lon lat sst_oi'])
 	gradt=sqrt(dfdx(lon,sst_oi,.25).^2+dfdy(sst_oi,.25).^2).*1e5;
    eval(['save -append ' save_path 'OI_25_W_' num2str(mid_week_jdays(m)) ' gradt']);
end
