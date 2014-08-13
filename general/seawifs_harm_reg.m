%SeaWiFS seasonal cycle based on .25x.25 monthly composites (Sep 99 - Dec 07).

clear all
close all

load seawifs_regression_output_smooth.mat beta_values
load /Volumes/matlab/matlab/domains/SEP_lat_lon

%subset betas
startyear = 2002;
startmonth = 06;
startday = 05;
endyear = 2008;
endmonth = 01;
endday = 23;


%construct date vector
startjd=date2jd(startyear,startmonth,startday)+.5;
endjd=date2jd(endyear,endmonth,endday)+5;
jdays=[startjd:7:endjd];
[year,month,day]=jd2jdate(jdays);
yearday=(year)*1000+julian(month,day,year,year);
max_lat=max(lat);
min_lat=min(lat);
max_lon=max(lon);
min_lon=min(lon);
STEP=.25;
LON=[0.125:STEP:359.875];
LAT=[-89.875:STEP:89.875];
r=find(LAT>=min_lat&LAT<=max_lat);
c=find(LON>=min_lon&LON<=max_lon);
lat=LAT(r);
lon=LON(c);
beta_values=beta_values(r,c,:);
lon=ones(length(lat),1)*lon;
lat=lat'*ones(1,length(lon(1,:)));


%adjust coefficents so that seasonal cycle starts on June 6th
new_t=[156:7:365 1:7:1850];
f=7/365;


seawifs_seasonal_cycle = nan(length(r),length(c),295);



for i = 1:length(lat(:,1))

	for j = 1:length(lon(1,:))
	
	T=(beta_values(i,j,1)+beta_values(i,j,2)*sin(2*pi*f*new_t)+beta_values(i,j,3)*cos(2*pi*f*new_t)...
	+beta_values(i,j,4)*sin(4*pi*f*new_t)+beta_values(i,j,5)*cos(4*pi*f*new_t));
		
	seawifs_seasonal_cycle(i,j,:) = T;  %day one of the seasonal cycle is 1 September, day 365 is 31 August

	end

end
