%SeaWiFS seasonal cycle based on .25x.25 monthly composites (Sep 99 - Dec 07).

clear all
close all

load seawifs_clima.mat beta_values
load ~/data/SeaWiFS/mat/SCHL_9_21_2450821.mat glat glon
[r,c]=imap(-70,70,0,360,glat,glon);
glat=glat(r,c);
glon=glon(r,c);
load ~/matlab/vocals/V2/chl_merged mid*

seasonal_cycle = repmat(nan,[length(glat(:,1)) length(glon(1,:)) length(mid_week_jdays)]);

new_t=0:1:length(mid_week_jdays)-1;
f=7/365;

for i = 1:length(glat(:,1)),

	for j = 1:length(glon(1,:)),
	
	T=(beta_values(i,j,1)+beta_values(i,j,2)*sin(2*pi*f*new_t)+beta_values(i,j,3)*cos(2*pi*f*new_t)...
	+beta_values(i,j,4)*sin(4*pi*f*new_t)+beta_values(i,j,5)*cos(4*pi*f*new_t));
		
	seasonal_cycle(i,j,:) = T;  %day one of the seasonal cycle is 1 September, day 365 is 31 August

	end

end

%fix chl
seasonal_cycle = single([seasonal_cycle(:,721:1440,:),seasonal_cycle(:,1:720,:)]);

%fix seasonal cycle to start on Jan 1.
[y,m,d]=jd2jdate(mid_week_jdays(1));
startjd=julian(m,d,y);
janfirst=123;
offset=startjd;

tmp=cat(3,seasonal_cycle(:,:,offset:length(seasonal_cycle(1,1,:))),seasonal_cycle(:,:,1:offset-1));
seasonal_cycle=tmp;

clear tmp i j f beta_values ans T new_t LAT LON max* min*

figure(1)
for m=1:length(seasonal_cycle(1,1,:))
    pmap(glon,glat,seasonal_cycle(:,:,m))
    title(num2str(m))
    eval(['print -dpng -r150 frames/ss/frame_',num2str(m)])
end

