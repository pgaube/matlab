load chelle.pal
lat=[-45 -40 -38 -35 33 -33 30 -30 -3 24 -24 24 -24 -24 21 -14];
wlon=[210 80 230 40 180 310 290 170 60 125 160 300 320 50 130 70];
elon=[250 110 260 85 230 360 320 240 100 165 225 330 350 100 190 120];
dy=.5;

lat=-22
wlon=0
elon=360
%map lines
%{
figure(101)
clf
pmap(0:360,-60:60,nan(length(-60:60),length(0:360)))
title('Locations of Hovmoller Transects  ')
hold on

for m=1:length(lat)
	m_plot([wlon(m) elon(m)],[lat(m) lat(m)],'k')
	m_text(elon(m)+(wlon(m)-elon(m))/2,lat(m)+2,num2str(m))
end
print -dpng -r300 figs/map_hov_locations
%}
load /Volumes/matlab/data/eddy/V4/global_tracks_V4

for m=1:length(lat)
	ii=find(x>=wlon(m) & x<=elon(m) & y>=lat(m)-dy & y<=lat(m)+dy);
	hx=x(ii);
	hy=y(ii);
	hid=id(ii);
	
	[shov,slon,syear_day]=hovmoller('ssh',[wlon(m) elon(m)],lat(m),dy);
	mask=nan*shov;
	mask(~isnan(shov))=1;
	
	sm=loess2d(shov,4,4,1,1); 
	lp=loess2d(sm,40,3,1,1);
	hp=sm-lp;
	fn=loess2d(hp,10,10,1,1);
	v=dfdy(fn,.25);
	fn(v>0)=0;
	fn=loess2d(fn,10,10,1,1);
	fn=fn.*mask;
	
	figure(1)
	clf
	pcolor(slon,1:length(syear_day),fn);shading flat
	caxis([-10 10])
	hold on
	iy=find(syear_day==1);
	set(gca,'ytick',[1:80:length(syear_day)]','yticklabel',...
		{int2str(syear_day(1:80:length(syear_day))')},'tickdir',...
		'out','layer','top','clipping','off')
	daspect([1 7 1])
	shading interp
	title({['High Pass Filtered SSH Anomaly - Line ',num2str(m),'   ']})
	xlabel('Longitude   ')
	ai=find(hid>=nneg);
	plot(hx(ai),hy(ai),'k')
	ci=find(hid<nneg);
	plot(hx(ci),hy(ci),'k--')
	colormap(chelle)
	c=colorbar;
	axes(c);
	ylabel('cm')
	eval(['print -dpng -r300 figs/ssh_' num2str(lat(m)) '_' num2str(wlon(m)) '_' num2str(elon(m))])
	
	
	[chov,clon,cyear_day]=hovmoller('gschl',[wlon(m) elon(m)],lat(m),dy);
	
	fill_chov=fillnans(chov).*mask;
	sm=loess2d(fill_chov,4,4,1,1); 
	lp=loess2d(sm,40,3,1,1);
	hp=sm-lp;
	fn=loess2d(hp,10,10,1,1);
	v=dfdy(fn,.25);
	fn(v>0)=0;
	fn=loess2d(fn,10,10,1,1);
	fn=fn.*mask;
	
	figure(2)
	clf
	pcolor(clon,1:length(cyear_day),fn);shading flat
	caxis([-.05 .05])
	hold on
	iy=find(cyear_day==1);
	set(gca,'ytick',[1:60:length(cyear_day)]','yticklabel',...
		{int2str(cyear_day(1:60:length(cyear_day))')},'tickdir',...
		'out','layer','top','clipping','off')
	daspect([1 7 1])
	shading interp
	title({['SeaWiFS CHL Anomaly - Line ',num2str(m),'   ']})
	xlabel('Longitude   ')
	colormap(chelle)
	c=colorbar;
	axes(c);
	ylabel('log_{10}(CHL)')
	eval(['print -dpng -r300 figs/schl_' num2str(lat(m)) '_' num2str(wlon(m)) '_' num2str(elon(m))])
	
	save(['line_',num2str(m),'_hov'],'shov','slon','syear_day','chov','clon','cyear_day','hx','hy','hid')

	%{
	[hov,lon,year_day]=hovmoller('mchl_anom',[wlon(m) elon(m)],lat(m),dy);

	figure(3)
	clf
	pcolor(lon,1:length(year_day),hov);shading flat
	caxis([-.25 .25])
	hold on
	iy=find(year_day==1);
	set(gca,'ytick',[1:40:length(year_day)]','yticklabel',...
		{int2str(year_day(1:40:length(year_day))')},'tickdir',...
		'out','layer','top','clipping','off')
	daspect([1 4 1])
	shading interp
	title({'MODIS-Aqua CHL Anomaly  ',[num2str(lat(m)) '^\circ Latitude']})
	xlabel('Longitude   ')
	colormap(chelle)
	c=colorbar;
	axes(c);
	ylabel('log_{10}(CHL)')
	eval(['print -dpng -r300 figs/mchl_' num2str(lat(m)) '_' num2str(wlon(m)) '_' num2str(elon(m))])
	%}

end
