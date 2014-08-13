%this routine will load Schlax's masks

pp = '/Volumes/matlab/data/eddy/V3/'
domain='reg_lat_lon.mat'
eval(['load /Volumes/matlab/matlab/domains/' domain])
max_lat=max(lat(:));
min_lat=min(lat(:));
max_lon=max(lon(:));
min_lon=min(lon(:));

%Set range of dates

%{
startyear = 2005;
startmonth = 8;
startday = 17;
endyear = 2007;
endmonth = 05;
endday = 30;
%}

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
lat= -80+dy/2+(j-1)*dy;
lon= 0+dx/2+(i-1)*dx;

%create indecies and subset lat lon
r=find(lat>=min_lat & lat<=max_lat);
c=find(lon>=min_lon & lon<=max_lon);
lat=lat(r);
lon=lon(c);
lat=lat'*ones(1,length(lon));
lon=ones(length(lat(:,1)),1)*lon;


%construct date vector
startjd=date2jd(startyear,startmonth,startday)+.5;
endjd=date2jd(endyear,endmonth,endday)+.5;
jdays=[startjd:7:endjd];
[year,month,day]=jd2jdate(jdays);

%make maticies
ssh=single(nan(length(lat(:,1)),length(lon(1,:)),length(jdays)));
idmask=ssh;
mask=ssh;

for m=1:length(jdays)
	yearday(m) = year(m)*1000+julian(month(m),day(m),year(m));
	calday(m) =  year(m)*10000+month(m)*100+day(m);
	fprintf('\r   Reading %08u \r',calday(m))
	ssh_file = [pp 'ssh/aviso_' num2str(calday(m)) '.20x10_hp'];
	mask_file = [pp 'masks/closed_090206.' num2str(calday(m))];
	
	stmp=read_ssh(ssh_file);
	ssh(:,:,m) = stmp(r,c);
	
	[mtmp,mlon]=read_mask(mask_file);
	mc=find(mlon>=min_lon & mlon<=max_lon);
	idmask(:,:,m)=(mtmp(r,mc));
	mtmp(~isnan(mtmp))=1;
	mask(:,:,m)=mtmp(r,mc);
	
end

clear pp max_* min_* start* end* j i dy dx r c year month day and m mc mlon mtmp stmp ssh_file mask_file

%now test it


return
figure(1)
load test_track
for m=1:length(jdays)
clf
%pcolor(lon,lat,double(idmask(:,:,m)));shading flat
pmap(lon,lat,idmask(:,:,m),'idmask')
shading interp
hold on
m_contour(lon,lat,ssh(:,:,m),[-50:2:-4],'k--')
m_contour(lon,lat,ssh(:,:,m),[4:2:50],'k')
ii=find(track_jday==jdays(m));
p=find(track_jday<=jdays(m));
for b=1:length(ii)
	ttt=idmask(find(lat(:,1)>=y(ii(b))-.25 & lat(:,1)<=y(ii(b))+.25),find(lon(1,:)>=x(ii(b))-.25 & lon(1,:)<=x(ii(b))+.25),m);
	tt=max(abs(ttt(:)));
    m_plot(x(ii(b)),y(ii(b)),'ko','markerfacecolor','k','markersize',6);
    m_text(x(ii(b)),y(ii(b))+.5,num2str(tt),'color','k','fontsize',18,'fontweight','bold');
end
m_plot(x(p),y(p),'k','linewidth',2)
hold off
drawnow
eval(['print -dpng frames/frame_' num2str(m)]);
end

figure(1)
load test_track
for m=1:length(jdays)
clf
%pcolor(lon,lat,double(idmask(:,:,m)));shading flat
pmap(lon,lat,test(:,:,m),'hpssh_med',num2str(yearday(m)))
hold on
m_contour(lon,lat,ssh(:,:,m),[-50:2:-4],'k--')
m_contour(lon,lat,ssh(:,:,m),[4:2:50],'k')
ii=find(track_jday==jdays(m));
p=find(track_jday<=jdays(m));
for b=1:length(ii)
	ttt=idmask(find(lat(:,1)>=y(ii(b))-.25 & lat(:,1)<=y(ii(b))+.25),find(lon(1,:)>=x(ii(b))-.25 & lon(1,:)<=x(ii(b))+.25),m);
	tt=max(abs(ttt(:)));
    m_plot(x(ii(b)),y(ii(b)),'ko','markerfacecolor','k','markersize',6);
    m_text(x(ii(b)),y(ii(b))+.5,num2str(tt),'color','k','fontsize',18,'fontweight','bold');
end
m_plot(x(p),y(p),'k','linewidth',2)
hold off
drawnow
eval(['print -dpng frames/pframe_' num2str(m)]);
end


