%construct date vector

endjd=2455890;
startjd=startjd-10;

jdays=[startjd:endjd];

alon=-155:-120;
alon=180+(180+alon);
alat=-4:4;


minlat=-10;
maxlat=+10;
minlon=-200;
maxlon=-100;
save_path = '/matlab/data/ghrsst/mat/'
ff=1365;
load chelle.pal
for m=1:length(jdays)
clf
[yea,mon,day]=jd2jdate(jdays(m));
dd=(yea*1000)+julian(mon,day,yea,yea)
if exist(['/matlab/data/ReynoldsSST/mat/OI_25_D_',num2str(jdays(m)) '.mat'])
load(['/matlab/data/ReynoldsSST/mat/OI_25_D_',num2str(jdays(m))],'sst_oi','lat','lon')
[r,c]=imap(minlat,maxlat,180+(180+minlon),180+(180+maxlon),lat,lon);
lon=lon(r,c);
lat=lat(r,c);
sst=sst_oi(r,c);
dtdx=dfdx(lat,sst,.25);
figure(1)
clf
pmap(lon,lat,1e5*abs(dtdx))
hold on
m_contour(lon,lat,sst,[10:1:40],'k')
caxis([.1 1.5])
colormap(chelle)
draw_domain(alon,alat)
colorbar
title(['Reyonld 0.25 degree \mid dt/dx \mid, c^\circ per 100 km   ',num2str(dd)])
niceplot
drawnow
eval(['print -dpng -r150 frames/re_dtdx/frame_' num2str(ff) '.png'])
ff=ff+1;
end
end


return
for m=1:length(jdays)
   if exist([save_path 'TROUBLE_SST_' num2str(jdays(m)) '.mat'])
   eval(['load ' save_path 'TROUBLE_SST_' num2str(jdays(m)) ...
	      ' dtdx sst lat lon date']); 

	figure(1)
	clf
	%{
	subplot(212)
	pmap(lon,lat,sst)
	ran=caxis;
	hold on
	colorbar
	m_contour(lon,lat,sst,[10:1:40],'k')
	caxis([0 .4])
	draw_domain(alon,alat)
	title(num2str(date))
	
	subplot(212)
	dtdx=dfdx(lat,sst,.054);
	dtdy=dfdy(sst,.054);
	gradt=sqrt(dtdx.^2+dtdy.^2);
	%}
	pmap(lon,lat,1e5*abs(dtdx))
	hold on
	m_contour(lon,lat,sst,[10:1:40],'k')
	caxis([.1 1.5])
	colormap(chelle)
	draw_domain(alon,alat)
	colorbar
	title(['\mid dt/dx \mid, c^\circ per 100 km   ',num2str(date)])
	niceplot
	drawnow
	eval(['print -dpng frames/dtdx/frame_',num2str(ff)])
	%eval(['save -append ' save_path 'TROUBLE_SST_' num2str(jdays(m)) ...
	%      ' dtdx dtdy gradt']); 
	      
	ff=ff+1;
end
end
