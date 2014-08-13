%SeaWiFS seasonal cycle based on .25x.25 monthly composites (Sep 99 - Dec 07).

clear all
close all

load seawifs_clima.mat beta_values
load /Volumes/matlab/matlab/domains/SEP_lat_lon
load /Volumes/matlab/matlab/VOCALS/chl_merged_ls_filtered mid_week_jdays

max_lat=max(lat);
min_lat=min(lat);
max_lon=max(lon);
min_lon=min(lon);
STEP=.25;
LON=[0.125:STEP:359.875];
LON=[LON(721:1440),LON(1:720)];
LAT=[69.875:-STEP:-69.875];
max_lat=max(lat(:));
min_lat=min(lat(:));
max_lon=max(lon(:));
min_lon=min(lon(:));
r=find(LAT>=min_lat&LAT<=max_lat);
c=find(LON>=min_lon&LON<=max_lon);
lat=LAT(r);
lon=LON(c);

beta_values=beta_values(r,c,:);

seasonal_cycle = repmat(nan,[length(lat) length(lon) length(mid_week_jdays)]);

new_t=0:1:length(mid_week_jdays)-1;
f=7/365;

for i = 1:length(lat),

	for j = 1:length(lon),
	
	T=(beta_values(i,j,1)+beta_values(i,j,2)*sin(2*pi*f*new_t)+beta_values(i,j,3)*cos(2*pi*f*new_t)...
	+beta_values(i,j,4)*sin(4*pi*f*new_t)+beta_values(i,j,5)*cos(4*pi*f*new_t));
		
	seasonal_cycle(i,j,:) = T;  %day one of the seasonal cycle is 1 September, day 365 is 31 August

	end

end

%fix seasonal cycle to start on Jan 1.
[y,m,d]=jd2jdate(mid_week_jdays(1));
startjd=julian(m,d,y);
janfirst=123;
offset=janfirst+startjd;

tmp=cat(3,seasonal_cycle(:,:,offset:length(seasonal_cycle(1,1,:))),seasonal_cycle(:,:,1:offset-1));
seasonal_cycle=tmp;

clear tmp i j f beta_values ans T new_t LAT LON max* min*
