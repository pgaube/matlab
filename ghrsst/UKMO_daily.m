%construct date vector
endjd=2455890;
startjd=endjd-10;

jdays=[startjd:endjd];


alon=60:90;
alat=-6:6;

minlat=-4;
maxlat=+4;
minlon=75;
maxlon=85;
%Set path and region
save_path = '/matlab/data/ghrsst/mat/'
ff=1;
load chelle.pal
for m=1:length(jdays)
    [yea,mon,day]=jd2jdate(jdays(m));
    date=(yea*10000)+(mon*100)+day;
    base_url=['http://data.ncof.co.uk/data/ostia/' num2str(yea) '/sst/'];
	if mon<10 & day<10
		fname=[base_url num2str(yea) '0' num2str(mon) '0' num2str(day) '-UKMO-L4HRfnd-GLOB-v01-fv02-OSTIA.nc.bz2'];
	elseif mon<10 & day>=10
		fname=[base_url num2str(yea) '0' num2str(mon)  num2str(day) '-UKMO-L4HRfnd-GLOB-v01-fv02-OSTIA.nc.bz2'];
	elseif mon>=10 & day<10
		fname=[base_url num2str(yea) num2str(mon) '0' num2str(day) '-UKMO-L4HRfnd-GLOB-v01-fv02-OSTIA.nc.bz2'];
	elseif mon>=10 & day>=10
		fname=[base_url num2str(yea) num2str(mon) num2str(day) '-UKMO-L4HRfnd-GLOB-v01-fv02-OSTIA.nc.bz2'];
	end
	fname
	eval(['!/usr/local/bin/wget -q -Oghrsst.nc.bz2 ' char(39) fname char(39)])
	
	!bunzip2 ghrsst.nc.bz2
	if exist('ghrsst.nc')
	sst_id = netcdf.open(['ghrsst.nc'], 'NC_NOWRITE');
	lat=double(squeeze(netcdf.getvar(sst_id,...
       	    		 netcdf.inqvarid(sst_id,'lat'))));
	lon=double(squeeze(netcdf.getvar(sst_id,...
       	    		 netcdf.inqvarid(sst_id,'lon'))));
	sst=double(squeeze(netcdf.getvar(sst_id,...
       	    		 netcdf.inqvarid(sst_id,'analysed_sst'))));
	
	netcdf.close(sst_id);
	sst(sst<1000)=nan;
	sst=.01*(sst'+273.15);
	[r,c]=imap(minlat,maxlat,minlon,maxlon,lat,lon);
	lon=lon(c);
	lat=lat(r);
	sst=sst(r,c);
	dtdx=dfdx(lat,sst,.054);
	dtdy=dfdy(sst,.054);
	gradt=sqrt(dtdx.^2+dtdy.^2);
	jday=jdays(m);
	
	
	figure(1)
	clf
	subplot(311)
	pmap(lon,lat,sst)
	ran=caxis;
	hold on
	colorbar
	m_contour(lon,lat,sst,[10:.3:40],'k')
	caxis([30.5 33.2])%caxis(ran)%caxis([23 33])
	%draw_domain(alon,alat)
	title([num2str(yea),'-',num2str(mon),'-',num2str(day)])
	m_plot(80,0,'k*')

	subplot(312)
	pmap(lon,lat,1e5*gradt)
	hold on
	m_contour(lon,lat,sst,[10:.3:40],'k')
	caxis([0 .8])
	%draw_domain(alon,alat)
	m_plot(80,0,'k*')
	colorbar
	title('\mid \nabla T \mid, c^\circ per 100 km')
	
	subplot(313)
	pmap(lon,lat,1e5*dtdx)
	hold on
	m_contour(lon,lat,sst,[10:.3:40],'k')
	caxis([-.5 .5])
	colorbar
	m_plot(80,0,'k*')
	title('dT/dx, c^\circ per 100 km')
	%draw_domain(alon,alat)
	colormap(chelle)
	drawnow
	
	eval(['print -dpng -r150 frames/sst/frame_',num2str(ff)])
	%}
	eval(['save ' save_path 'TROUBLE_SST_' num2str(jdays(m)) ...
	      ' gradt dtdx dtdy sst lat lon jdays date jday']); 
	clear sst lat lon dtdx dtdy gradt 
	ff=ff+1;
	!rm -r ghrsst.nc
end
end