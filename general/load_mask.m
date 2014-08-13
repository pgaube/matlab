%this routine will load Schlax's masks

pp = '/Volumes/matlab/data/eddy/V3/'
load /Volumes/matlab/matlab/domains/LW_lat_lon.mat
max_lat=max(lat(:));
min_lat=min(lat(:));
max_lon=max(lon(:));
min_lon=min(lon(:));

%Set range of dates
startyear = 1992;
startmonth = 10;
startday = 14;
endyear = 2008;
endmonth = 01;
endday = 23;

%make lat lon
j=[1:640];
i=[1:1440];
dy=.25;
dx=.25;
lat= -80+dy/2+(j*dy);
lon= 0+dx/2+(i*dx);

%create indecies and subset lat lon
r=find(lat>=min_lat & lat<=max_lat);
c=find(lon>=min_lon & lon<=max_lon);
lat=lat(r);
lon=lon(c);


%construct date vector
startjd=date2jd(startyear,startmonth,startday)+.5;
endjd=date2jd(endyear,endmonth,endday)+.5;
jdays=[startjd:7:endjd];
[year,month,day]=jd2jdate(jdays);

%make maticies
ssh=nan(length(lat),length(lon),length(jdays));
idmask=ssh;
mask=ssh;

for m=1:length(jdays)
	yearday(m) = year(m)*1000+julian(month(m),day(m),year(m));
	calday(m) =  year(m)*10000+month(m)*100+day(m);
	ssh_file = [pp 'ssh/aviso_' num2str(calday(m)) '.20x10_hp'];
	mask_file = [pp 'masks/closed_090206.' num2str(calday(m))];
	
	stmp=read_ssh(ssh_file);
	ssh(:,:,m) = stmp(r,c);
	
	[mtmp,mlon]=read_mask(mask_file);
	mc=find(mlon>=min_lon & mlon<=max_lon);
	idmask(:,:,m)=mtmp(r,mc);
	mtmp(~isnan(mtmp))=1;
	mask(:,:,m)=mtmp(r,mc);
	
end

