clear all
TYPE='dual_chl'

load bwr.pal
load chelle.pal
load bwy.pal
figure(1);
ff=1;
prev_x=[];
prev_y=[];
prev_id=[];
!toast *.png

switch TYPE


case {'eac_chl'}
	spath='~/data/gsm/mat/GSM_9_21_';
	mpath='~/data/mu/mat/MU_25_30_';
	asave='~/data/eddy/V5/mat/AVISO_25_W_';
	load([spath '2450884'],'glon','glat','jdays')
	load([asave '2454769'],'lon','lat','ssh')
	slon=interp2(lon);
	slat=interp2(lat);
	rlat=lat;
	rlon=lon;
	startjd=2451962-42%2450884;
	endjd=2454832-100;
	jdays=[startjd:7:endjd];
	
	load ~/matlab/domains/new_eac_lat_lon
    rrlat=lat;
    rrlon=lon;
	load ~/data/eddy/V5/new_eac_lat_lon_tight_orgin_tracks
    x=ext_x;
    y=ext_y;
    lat=min(lat)-6:max(lat)+6;
    lon=min(lon)-10:max(lon)+10;
	nlat=min(lat):max(lat);
	nlon=min(lon):max(lon);
	
	[r,c]=imap(min(nlat),max(nlat),min(nlon),max(nlon),glat,glon);
	[rssh,cssh]=imap(min(nlat),max(nlat),min(nlon),max(nlon),slat,slon);
	[rspsh,cspsh]=imap(min(nlat),max(nlat),min(nlon),max(nlon),rlat,rlon);
	%[r,c]=imap(-45,45,200,350,glat,glon);
	%[r,c]=imap(-60,60,0,360,glat,glon);
	%[rr,cc]=imap(-45,45,200,350,lat,lon);
	%[rr,cc]=imap(min(lat),max(lat),min(lon),max(lon),lat,lon);
	mask=nan*ssh(rspsh,cspsh);
	mask(find(~isnan(ssh(rspsh,cspsh))))=1;
	mask=flipud(mask);
	for m=1:200
		load([spath num2str(jdays(m))],'bp26_chl','gchl_week')
		%load([mpath num2str(jdays(m))],'bp21_mu')
		load([asave num2str(jdays(m))],'ssh')
		ssh=interp2(ssh);
		
		figure(1)
		clf
		pmap(glon(r,c),glat(r,c),gchl_week(r,c).*mask)
		hold on
		m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[-100:6:-6],'k--')
		m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[6:6:100],'k')		
		d=find(track_jday==jdays(m));
		p=find(track_jday<=jdays(m));
		m_plot(x(d),y(d),'o','markerfacecolor', ...
         'k','markeredgecolor','k','markersize',7);
		tmp_ids=id(d);
		time_ids=id(p);
		time_xs=x(p);
		time_ys=y(p);;
		for b=1:length(tmp_ids)
    		tmp=tmp_ids(b);
    		e=find(time_ids==tmp);
    		m_plot(time_xs(e),time_ys(e),'k', ...
              'linewidth',2);
		end
		draw_domain(rrlon,rrlat)
		caxis([-.1 .1])
		caxis([-1.3 -.1])

        [year,month,day]=jd2jdate(jdays(m));
		title([' CHL  ' num2str(year) '-' num2str(month) '-' num2str(day) '   '])
		colormap(chelle)
		colorbar
		
   		eval(['print -dpng frame_' num2str(ff) '.png'])
   		%eval(['crop(',char(39),'frame_' num2str(ff) '.png',char(39),')'])
       	%eval(['!convert -trim frame_' num2str(ff) '.png frame_' num2str(ff) ...
        %      '.png'])
       	ff=ff+1;
       	clear bp26_mu sm_gchl_week gchl_week nbp26_chl
    end
    
    
case {'sm_glon_dcdy'}
	spath='/matlab/data/gsm/mat/GSM_9_21_';
	mpath='/matlab/data/mu/mat/MU_25_30_';
	asave='/matlab/data/eddy/V4/mat/AVISO_25_W_';
	load([spath '2450884'],'glon','glat','jdays')
	load([asave '2454769'],'lon','lat','ssh')
	slon=lon;
	slat=lat;
	startjd=2450884;
	endjd=2454832;
	jdays=[startjd:7:endjd];
	[r,c]=imap(-60,60,0,360,glat,glon);
	load /matlab/matlab/domains/air-sea_lw_lat_lon
	nlat=min(lat):max(lat)+15;
	nlon=min(lon)-20:max(lon);
	
	[r,c]=imap(min(nlat),max(nlat),min(nlon),max(nlon),glat,glon);
	for m=1:length(jdays)
		load([spath num2str(jdays(m))],'sm_dchldy_200_day','sm_gchl_200_day')
		
		figure(1)
		clf
		pmap(glon(r,c),glat(r,c),1e5*sm_dchldy_200_day(r,c),'schl')
		caxis([-.02 .02])
		colorbar
		[year,month,day]=jd2jdate(jdays(m));
		title([' dCHL/dy  ' num2str(year) '-' num2str(month) '-' num2str(day) '   '])
		colormap(chelle)
		shading flat
		hold on
		m_contour(glon(r,c),glat(r,c),10.^sm_gchl_200_day(r,c),[.05],'k')
		m_contour(glon(r,c),glat(r,c),10.^sm_gchl_200_day(r,c),[.2],'r')
        return
   		eval(['print -dpng frame_' num2str(ff) '.png'])
       	%eval(['!convert -trim frame_' num2str(ff) '.png frame_' num2str(ff) ...
        %      '.png'])
       	ff=ff+1;
       	clear bp26_mu sm_gchl_week gchl_week nbp26_chl sm_dchldy_200_day sm_gchl_200_day
	end
	
	case {'sm_glon_chl'}
	spath='/matlab/data/gsm/mat/GSM_9_21_';
	mpath='/matlab/data/mu/mat/MU_25_30_';
	asave='/matlab/data/eddy/V4/mat/AVISO_25_W_';
	load([spath '2450884'],'glon','glat','jdays')
	load([asave '2454769'],'lon','lat','ssh')
	slon=lon;
	slat=lat;
	startjd=2450884;
	endjd=2454832;
	jdays=[startjd:7:endjd];
	[r,c]=imap(-60,60,0,360,glat,glon);
	for m=1:length(jdays)
		load([spath num2str(jdays(m))],'sm_gchl_200_day')
		
		figure(1)
		clf
		pmap(glon(r,c),glat(r,c),sm_gchl_200_day(r,c),'schl')
		caxis([-1.7 .8])
		[year,month,day]=jd2jdate(jdays(m));
		title([' CHL  ' num2str(year) '-' num2str(month) '-' num2str(day) '   '])
		colormap(chelle)
		shading flat
		hold on
		m_contour(glon(r,c),glat(r,c),10.^sm_gchl_200_day(r,c),[.05],'k')
		m_contour(glon(r,c),glat(r,c),10.^sm_gchl_200_day(r,c),[.2],'r')
   		eval(['print -dpng frame_' num2str(ff) '.png'])
       	%eval(['!convert -trim frame_' num2str(ff) '.png frame_' num2str(ff) ...
        %      '.png'])
       	ff=ff+1;
       	clear bp26_mu sm_gchl_week gchl_week nbp26_chl
	end
	
	
	
	
	case {'dual_chl'}
	spath='~/data/gsm/mat/GSM_9_21_';
	mpath='~/data/mu/mat/MU_25_30_';
	asave='~/data/eddy/V5/mat/AVISO_25_W_';
	load([spath '2450884'],'glon','glat','jdays')
	load([asave '2454769'],'lon','lat','ssh')
	slon=interp2(lon);
	slat=interp2(lat);
	rlat=lat;
	rlon=lon;
	startjd=2451962%2450884;
	endjd=2454832-100;
	jdays=[startjd:7:endjd];
	
	load ~/matlab/domains/maurtitus_lat_lon
    rrlat=lat;
    rrlon=lon;
	
    lat=min(lat)-10:max(lat)+10;
    lon=min(lon)-10:max(lon)+20;
	nlat=min(lat):max(lat);
	nlon=min(lon):max(lon);
	
	[r,c]=imap(min(nlat),max(nlat),min(nlon),max(nlon),glat,glon);
	[rssh,cssh]=imap(min(nlat),max(nlat),min(nlon),max(nlon),slat,slon);
	[rspsh,cspsh]=imap(min(nlat),max(nlat),min(nlon),max(nlon),rlat,rlon);
	%[r,c]=imap(-45,45,200,350,glat,glon);
	%[r,c]=imap(-60,60,0,360,glat,glon);
	%[rr,cc]=imap(-45,45,200,350,lat,lon);
	%[rr,cc]=imap(min(lat),max(lat),min(lon),max(lon),lat,lon);
	mask=nan*ssh(rspsh,cspsh);
	mask(find(~isnan(ssh(rspsh,cspsh))))=1;
	mask=flipud(mask);
	for m=1:200
		load([spath num2str(jdays(m))],'bp26_chl','gchl_week')
		%load([mpath num2str(jdays(m))],'bp21_mu')
		load([asave num2str(jdays(m))],'ssh')
		ssh=interp2(ssh);
		
		figure(1)
		clf
		subplot(212)
		pmap(glon(r,c),glat(r,c),bp26_chl(r,c).*mask)
		hold on
		m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[-100:4:-4],'k--')
		m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[4:4:100],'k')		
		
		draw_domain(rrlon,rrlat)
		%caxis([-.02 .005])
		%caxis([.5 1.5])
		caxis([-.1 .1])
		[year,month,day]=jd2jdate(jdays(m));
		title([' Filtered CHL  ' num2str(year) '-' num2str(month) '-' num2str(day) '   '])
		colormap(chelle)
		colorbar
		
		subplot(211)
		pmap(glon(r,c),glat(r,c),gchl_week(r,c).*mask)
		hold on
		m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[-100:4:-2],'k--')
		m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[2:4:100],'k')		
		
		draw_domain(rrlon,rrlat)
		%caxis([-.02 .005])
		caxis([-1.5 -.08])
		%caxis([-3 3])
		[year,month,day]=jd2jdate(jdays(m));
		title(['  CHL  '])
		colormap(chelle)
		colorbar
        
   		
   		eval(['print -dpng frame_' num2str(ff) '.png'])
   		%eval(['crop(',char(39),'frame_' num2str(ff) '.png',char(39),')'])
       	%eval(['!convert -trim frame_' num2str(ff) '.png frame_' num2str(ff) ...
        %      '.png'])
       	ff=ff+1;
       	clear bp26_mu sm_gchl_week gchl_week nbp26_chl
	end
	
	
	
	
case {'raw_chl'}
	asave='/matlab/data/eddy/V4/mat/AVISO_25_W_';
	load([asave '2454769'],'lon','lat','ssh')
	slon=lon;
	slat=lat;
	spath='/matlab/data/gsm/mat/GSM_9_D_';
	load([spath '2454745'],'lon','lat')
	jdays=[2454735:2454765];
	[r,c]=imap(-25,-15,50,70,lat,lon);
	[rs,cs]=imap(-25,-15,50,70,slat,slon);
	
	all_chl=nan(length(r),length(c),length(jdays));
	all_ssh=nan(length(rs),length(cs),length(jdays));
	chl_day=nan*lat;
	for m=1:length(jdays)
		if exist([spath,num2str(jdays(m)),'.mat'])
			load([spath num2str(jdays(m))],'chl_day')
		end	
		if exist([asave,num2str(jdays(m)),'.mat'])
			load([asave num2str(jdays(m))],'ssh')
		end	
		all_chl(:,:,ff)=log10(chl_day(r,c));
		all_ssh(:,:,ff)=(ssh(rs,cs));
		figure(1)
		clf
		subplot(211)
		pmap(lon(r,c),lat(r,c),log10(chl_day(r,c)),'schl')
		caxis([-1.4 -.7])
		hold on
		m_contour(slon(rs,cs),slat(rs,cs),ssh(rs,cs),[-100:3:-3],'k--')
		m_contour(slon(rs,cs),slat(rs,cs),ssh(rs,cs),[3:3:100],'k')	
		%caxis([-.1 .1])
		[year,month,day]=jd2jdate(jdays(m));
		title(['9km SeaWiFS CHL  ' num2str(year) '-' num2str(month) '-' num2str(day) '   '])
		shading flat
		subplot(212)
		pmap(slon(rs,cs),slat(rs,cs),ssh(rs,cs),'schl')
		colormap(chelle)
		caxis([-10 10])
   		
   		eval(['print -dpng frame_' num2str(ff) '.png'])
       	%eval(['!convert -trim frame_' num2str(ff) '.png frame_' num2str(ff) ...
        %      '.png'])
       	ff=ff+1;
       	clear chl_Day
	end
	mean_chl=nanmean(all_chl,3);
	load([asave num2str(2454741)],'ssh')
	mean_ssh=nanmean(all_ssh,3);
	figure(1)
	clf
	pmap(lon(r,c),lat(r,c),mean_chl,'schl')
	caxis([-1.4 -.7])
	hold on
	m_contour(slon(rs,cs),slat(rs,cs),ssh(rs,cs),[-100:3:-3],'color',[.5 .5 .5])
	m_contour(slon(rs,cs),slat(rs,cs),ssh(rs,cs),[3:3:100],'k')	
	%caxis([-.1 .1])
	title(['9km SeaWiFS CHL 30-Day Composite  '])
	xlabel('contour interval 3 cm   ')
	set(gca,'xcolor','w')
	c=colorbar
	set(c,'Clim',log10([0.01 10]))
    Tick=[.001 .01 .02 .03 .1 .5 1 10];
    set(c,'YTick',log10(Tick),...
          'YTickLabel', Tick,'xcolor','w','ycolor','w');
    axes(c)
    xlabel('mg m^{-3}','color','w')
	colormap(chelle)
	shading flat

   		
   		eval(['print -dpng frame_' num2str(ff) '.png'])
	
	
case {'sm_chl'}
	spath='/matlab/data/gsm/mat/GSM_9_21_';
	mpath='/matlab/data/mu/mat/MU_25_30_';
	asave='/matlab/data/eddy/V4/mat/AVISO_25_W_';
	load([spath '2450884'],'glon','glat','jdays')
	load([asave '2454769'],'lon','lat','ssh')
	slon=lon;
	slat=lat;
	startjd=2450884;
	endjd=2454832;
	jdays=[startjd:7:endjd];
	load /matlab/matlab/domains/section_30_lat_lon.mat
	load /matlab/matlab/hovmuller/tracks//section_30_tracks.mat
	nlat=min(lat)-5:max(lat)+5;
	nlon=min(lon)-10:max(lon)+35;
	
	[r,c]=imap(min(nlat),max(nlat),min(nlon),max(nlon),glat,glon);
	[rssh,cssh]=imap(min(nlat),max(nlat),min(nlon),max(nlon),slat,slon);
	%[r,c]=imap(-45,45,200,350,glat,glon);
	%[r,c]=imap(-60,60,0,360,glat,glon);
	%[rr,cc]=imap(-45,45,200,350,lat,lon);
	%[rr,cc]=imap(min(lat),max(lat),min(lon),max(lon),lat,lon);
	mask=nan*ssh(rssh,cssh);
	mask(find(~isnan(ssh(rssh,cssh))))=1;
	mask=flipud(mask);
	for m=1:length(jdays)
		load([spath num2str(jdays(m))],'nbp21_chl','sm_gchl_week','sm_gchl_200_day')
		%load([mpath num2str(jdays(m))],'bp21_mu')
		load([asave num2str(jdays(m))],'ssh')
		
		figure(1)
		clf
		subplot(211)
		pmap(glon(r,c),glat(r,c),sm_gchl_week(r,c).*mask,'schl')
		hold on
		m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[-100:1:-2],'color', [.5 .5 .5])
		m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[2:1:100],'k')		
		d=find(track_jday==jdays(m));
		p=find(track_jday<=jdays(m));
		m_plot(x(d),y(d),'o','markerfacecolor', ...
         'k','markeredgecolor','k','markersize',5);
		tmp_ids=id(d);
		time_ids=id(p);
		time_xs=x(p);
		time_ys=y(p);;
		for b=1:length(tmp_ids)
    		tmp=tmp_ids(b);
    		e=find(time_ids==tmp);
    		m_plot(time_xs(e),time_ys(e),'k', ...
              'linewidth',.1);
		end
		draw_domain(lon,lat)
		%caxis([-.02 .005])
		caxis([-1.7 -.5])
		%caxis([-.1 .1])
		[year,month,day]=jd2jdate(jdays(m));
		title([' CHL  ' num2str(year) '-' num2str(month) '-' num2str(day) '   '])
		colormap(chelle)
		shading flat
		
		subplot(212)
		pmap(glon(r,c),glat(r,c),sm_gchl_200_day(r,c).*mask,'schl')
		hold on
		m_contour(glon(r,c),glat(r,c),sm_gchl_200_day(r,c).*mask,[-2:.1:1],'k')	
		%caxis([-.02 .005])
		draw_domain(lon,lat)		
		caxis([-1.7 -.5])
		%caxis([-.1 .1])
		[year,month,day]=jd2jdate(jdays(m));
		title([' 200-day Smoothed CHL  ' num2str(year) '-' num2str(month) '-' num2str(day) '   '])
		colormap(chelle)
		shading flat

   		
   		eval(['print -dpng frame_' num2str(ff) '.png'])
       	%eval(['!convert -trim frame_' num2str(ff) '.png frame_' num2str(ff) ...
        %      '.png'])
       	ff=ff+1;
       	clear bp26_mu sm_gchl_week gchl_week nbp26_chl
	end
	
	

case {'chls'}
	spath='/matlab/data/gsm/mat/GSM_9_21_';
	mpath='/matlab/data/mu/mat/MU_25_30_';
	asave='/matlab/data/eddy/V4/mat/AVISO_25_W_';
	load([spath '2450884'],'glon','glat','jdays')
	load([asave '2454769'],'lon','lat','ssh')
	slon=lon;
	slat=lat;
	startjd=2450884;
	endjd=2454832;
	jdays=[startjd:7:endjd];
	load /matlab/matlab/domains/DJM_lat_lon.mat
	[r,c]=imap(min(lat),max(lat),min(lon),max(lon),glat,glon);
	[rssh,cssh]=imap(min(lat),max(lat),min(lon),max(lon),slat,slon);
	%[r,c]=imap(-45,45,200,350,glat,glon);
	%[r,c]=imap(-60,60,0,360,glat,glon);
	%[rr,cc]=imap(-45,45,200,350,lat,lon);
	%[rr,cc]=imap(min(lat),max(lat),min(lon),max(lon),lat,lon);
	mask=nan*ssh(rssh,cssh);
	mask(find(~isnan(ssh(rssh,cssh))))=1;
	mask=flipud(mask);
	for m=1:length(jdays)
		load([spath num2str(jdays(m))],'nbp21_chl','sm_gchl_week')
		%load([mpath num2str(jdays(m))],'bp21_mu')
		load([asave num2str(jdays(m))],'ssh')
		
		figure(1)
		clf
		subplot(211)
		pmap(glon(r,c),glat(r,c),sm_gchl_week(r,c).*mask,'schl')
		hold on
		m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[-100:3:-3],'color', [.5 .5 .5])
		m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[3:3:100],'k')		
		%caxis([-.02 .005])
		caxis([-1.8 .5])
		%caxis([-.1 .1])
		[year,month,day]=jd2jdate(jdays(m));
		title([' CHL  ' num2str(year) '-' num2str(month) '-' num2str(day) '   '])
		colormap(chelle)
		shading flat
		
		
		subplot(212)
		pmap(glon(r,c),glat(r,c),nbp21_chl(r,c).*mask,'schl')
		hold on
		m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[-100:3:-3],'color', [.5 .5 .5])
		m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[3:3:100],'k')		
		caxis([-.2 .2])
		%caxis([-1.8 .5])
		%caxis([.0003 .03])
		%caxis([-1.6 .3])
		%caxis([0 2])
		[year,month,day]=jd2jdate(jdays(m));
		title([' Filtered CHL  ' ])
		colormap(chelle)
		shading flat
		
   		
   		
   		eval(['print -dpng frame_' num2str(ff) '.png'])
       	%eval(['!convert -trim frame_' num2str(ff) '.png frame_' num2str(ff) ...
        %      '.png'])
       	ff=ff+1;
       	clear bp26_mu sm_gchl_week gchl_week nbp26_chl
	end
	
	
case {'chl_mu'}
	spath='/matlab/data/gsm/mat/GSM_9_21_';
	mpath='/matlab/data/mu/mat/MU_25_30_';
	asave='/matlab/data/eddy/V4/mat/AVISO_25_W_';
	load([spath '2450884'],'glon','glat','jdays')
	load([asave '2454769'],'lon','lat','ssh')
	slon=lon;
	slat=lat;
	startjd=2450884;
	endjd=2454832;
	jdays=[startjd:7:endjd];
	load /matlab/matlab/domains/DJM_lat_lon.mat
	[r,c]=imap(min(lat),max(lat),min(lon),max(lon),glat,glon);
	[rssh,cssh]=imap(min(lat),max(lat),min(lon),max(lon),slat,slon);
	%[r,c]=imap(-45,45,200,350,glat,glon);
	%[r,c]=imap(-60,60,0,360,glat,glon);
	%[rr,cc]=imap(-45,45,200,350,lat,lon);
	%[rr,cc]=imap(min(lat),max(lat),min(lon),max(lon),lat,lon);
	mask=nan*ssh(rssh,cssh);
	mask(find(~isnan(ssh(rssh,cssh))))=1;
	mask=flipud(mask);
	for m=1:length(jdays)
		load([spath num2str(jdays(m))],'bp21_chl','gchl_week')
		load([mpath num2str(jdays(m))],'bp21_mu')
		load([asave num2str(jdays(m))],'ssh')
		
		figure(1)
		clf
		subplot(211)
		pmap(glon(r,c),glat(r,c),bp21_chl(r,c).*mask,'schl')
		hold on
		m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[-100:3:-3],'color', [.5 .5 .5])
		m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[3:3:100],'k')		
		%caxis([-.02 .005])
		%caxis([-1.8 .5])
		caxis([-.1 .1])
		[year,month,day]=jd2jdate(jdays(m));
		title([' CHL  ' num2str(year) '-' num2str(month) '-' num2str(day) '   '])
		colormap(chelle)
		shading flat
		
		
		subplot(212)
		pmap(glon(r,c),glat(r,c),bp21_mu(r,c).*mask,'schl')
		hold on
		m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[-100:3:-3],'color', [.5 .5 .5])
		m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[3:3:100],'k')		
		caxis([-.2 .2])
		%caxis([-1.8 .5])
		%caxis([.0003 .03])
		%caxis([-1.6 .3])
		%caxis([0 2])
		[year,month,day]=jd2jdate(jdays(m));
		title([' \mu  ' ])
		colormap(chelle)
		shading flat
		
   		
   		
   		eval(['print -dpng frame_' num2str(ff) '.png'])
       	%eval(['!convert -trim frame_' num2str(ff) '.png frame_' num2str(ff) ...
        %      '.png'])
       	ff=ff+1;
       	clear bp26_mu sm_gchl_week gchl_week nbp26_chl
	end
	
	
	
	case {'chl_car'}
	spath='/matlab/data/gsm/mat/GSM_9_21_';
	asave='/matlab/data/eddy/V4/mat/AVISO_25_W_';
	load([spath '2450884'],'glon','glat','jdays')
	load([asave '2454769'],'lon','lat','ssh')
	slon=lon;
	slat=lat;
	startjd=2450884;
	endjd=2454832;
	jdays=[startjd:7:endjd];
	load /matlab/matlab/domains/EK_lat_lon.mat
	[r,c]=imap(min(lat),max(lat),min(lon),max(lon),glat,glon);
	[rssh,cssh]=imap(min(lat),max(lat),min(lon),max(lon),slat,slon);
	%[r,c]=imap(-45,45,200,350,glat,glon);
	%[r,c]=imap(-60,60,0,360,glat,glon);
	%[rr,cc]=imap(-45,45,200,350,lat,lon);
	%[rr,cc]=imap(min(lat),max(lat),min(lon),max(lon),lat,lon);
	mask=nan*ssh(rssh,cssh);
	mask(find(~isnan(ssh(rssh,cssh))))=1;
	mask=flipud(mask);
	for m=1:length(jdays)
		load([spath num2str(jdays(m))],'bp21_chl','bp21_car')
		load([asave num2str(jdays(m))],'ssh')
		
		
		figure(1)
		clf
		subplot(211)
		pmap(glon(r,c),glat(r,c),bp21_chl(r,c).*mask,'schl')
		hold on
		m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[-100:3:-3],'color', [.5 .5 .5])
		m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[3:3:100],'k')		
		%caxis([-.02 .005])
		%caxis([-1.8 .5])
		caxis([-.13 .13])
		[year,month,day]=jd2jdate(jdays(m));
		title([' CHL  ' num2str(year) '-' num2str(month) '-' num2str(day) '   '])
		colormap(chelle)
		shading flat
		
		
		subplot(212)
		pmap(glon(r,c),glat(r,c),bp21_car(r,c).*mask,'schl')
		hold on
		m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[-100:3:-3],'color', [.5 .5 .5])
		m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[3:3:100],'k')		
		%caxis([-.08 .08])
		%caxis([-1.8 .5])
		%caxis([.0003 .03])
		%caxis([-1.6 .3])
		caxis([-.15 .15])
		[year,month,day]=jd2jdate(jdays(m));
		title([' CAR  ' ])
		colormap(chelle)
		shading flat
		
   		
   		
   		eval(['print -dpng frame_' num2str(ff) '.png'])
       	%eval(['!convert -trim frame_' num2str(ff) '.png frame_' num2str(ff) ...
        %      '.png'])
       	ff=ff+1;
       	clear bp26_mu sm_gchl_week gchl_week nbp26_chl
	end
	
case {'agu'}
	spath='/matlab/data/gsm/mat/GSM_9_21_';
	asave='/matlab/data/eddy/V4/mat/AVISO_25_W_';
	load /matlab/matlab/hovmuller/tracks/agu_cor_masked_orgin_tracks x y id track_jday
	ii=find(x>=360);
	x(ii)=x(ii)+360;
	load([spath '2450884'],'glon','glat','jdays')
	load([asave '2454769'],'lon','lat')
	glon=cat(2,glon,glon+360);
	glat=cat(2,glat,glat);
	slon=cat(2,lon,lon+360);
	slat=cat(2,lat,lat);
	startjd=2450884;
	endjd=2454832;
	jdays=[startjd:7:endjd];
	[r,c]=imap(-43,-20,320,390,glat,glon);
	[rssh,cssh]=imap(-43,-20,320,390,slat,slon);
	%[r,c]=imap(-60,60,0,360,glat,glon);
	%[rr,cc]=imap(-45,45,200,350,lat,lon);
	%[rr,cc]=imap(min(lat),max(lat),min(lon),max(lon),lat,lon);
	
	for m=1:length(jdays)
		load([spath num2str(jdays(m))],'bp21_chl','sm_gchl_week')
		load([asave num2str(jdays(m))],'ssh')
		bp21_chl=cat(2,bp21_chl,bp21_chl);
		ssh=cat(2,ssh,ssh);
		sm_gchl_week=cat(2,sm_gchl_week,sm_gchl_week);
		figure(1)
		clf
		subplot(211)
		pmap(glon(r,c),glat(r,c),bp21_chl(r,c),'schl')
		hold on
		m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[-100:3:-3],'color', [.5 .5 .5])
		m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[3:3:100],'k')		
		%caxis([-.02 .005])
		%caxis([-1.8 .5])
		caxis([-.1 .1])
		[year,month,day]=jd2jdate(jdays(m));
		title([' Filtered CHL  ' num2str(year) '-' num2str(month) '-' num2str(day) '   '])
		colormap(chelle)
		shading flat
		d=find(track_jday==jdays(m));
		p=find(track_jday<=jdays(m));
		m_plot(x(d),y(d),'o','markerfacecolor', ...
         'k','markeredgecolor','k','markersize',3);
		tmp_ids=id(d);
		time_ids=id(p);
		time_xs=x(p);
		time_ys=y(p);;
		for b=1:length(tmp_ids)
    		tmp=tmp_ids(b);
    		e=find(time_ids==tmp);
    		m_plot(time_xs(e),time_ys(e),'k.', ...
              'linewidth',.1);
		end
		
		subplot(212)
		pmap(glon(r,c),glat(r,c),sm_gchl_week(r,c),'schl')
		hold on
		m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[-100:3:-3],'color', [.5 .5 .5])
		m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[3:3:100],'k')		
		%caxis([-.08 .08])
		%caxis([-1.8 .5])
		%caxis([.0003 .03])
		%caxis([-1.6 .3])
		%caxis([-1.5 -.8])
		[year,month,day]=jd2jdate(jdays(m));
		title([' 2x2 gchl-week from GSM  ' ])
		colormap(chelle)
		shading flat
		for b=1:length(tmp_ids)
    		tmp=tmp_ids(b);
    		e=find(time_ids==tmp);
    		m_plot(time_xs(e),time_ys(e),'k.', ...
              'linewidth',.1);
		end
   		eval(['print -dpng frame_' num2str(ff) '.png'])
       	%eval(['!convert -trim frame_' num2str(ff) '.png frame_' num2str(ff) ...
        %      '.png'])
       	ff=ff+1;
       	clear bp26_mu sm_gchl_week gchl_week nbp26_chl
	end
	
	
	
case {'all_gsm'}
	spath='/matlab/data/gsm/mat/GSM_9_21_';
	asave='/matlab/data/eddy/V4/mat/AVISO_25_W_';
	load([spath '2450884'],'glon','glat','jdays')
	load([asave '2454769'],'lon','lat')
	slon=lon;
	slat=lat;
	startjd=2450884;
	endjd=2454832;
	jdays=[startjd:7:endjd];
	load /matlab/matlab/domains/HAWAII_lat_lon.mat
	[r,c]=imap(min(lat),max(lat),min(lon),max(lon),glat,glon);
	[rssh,cssh]=imap(min(lat),max(lat),min(lon),max(lon),slat,slon);
	%[r,c]=imap(-45,45,200,350,glat,glon);
	%[r,c]=imap(-60,60,0,360,glat,glon);
	%[rr,cc]=imap(-45,45,200,350,lat,lon);
	%[rr,cc]=imap(min(lat),max(lat),min(lon),max(lon),lat,lon);
	for m=1:length(jdays)
		load([spath num2str(jdays(m))],'bp26_mu')	
		load([spath num2str(jdays(m))],'bp26_mu','sm_gchl_week','gchl_week','nbp26_chl','sm_mu')
		load([asave num2str(jdays(m))],'ssh')
		figure(1)
		clf
		subplot(223)
		pmap(glon(r,c),glat(r,c),bp26_mu(r,c),'schl')
		hold on
		m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[-100:3:-3],'color', [.5 .5 .5])
		m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[3:3:100],'k')		
		%caxis([-.02 .005])
		%caxis([-1.8 .5])
		caxis([-.1 .1])
		[year,month,day]=jd2jdate(jdays(m));
		title([' nbp26-\mu  ' num2str(year) '-' num2str(month) '-' num2str(day) '   '])
		colormap(chelle)
		shading flat
		
		
		subplot(222)
		pmap(glon(r,c),glat(r,c),sm_gchl_week(r,c),'schl')
		hold on
		m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[-100:3:-3],'color', [.5 .5 .5])
		m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[3:3:100],'k')		
		%caxis([-.08 .08])
		%caxis([-1.8 .5])
		%caxis([.0003 .03])
		%caxis([-1.6 .3])
		caxis([-1.5 -.8])
		[year,month,day]=jd2jdate(jdays(m));
		title([' 2x2 gchl-week from GSM  ' ])
		colormap(chelle)
		shading flat
		
		subplot(224)
		pmap(glon(r,c),glat(r,c),nbp26_chl(r,c),'schl')
		hold on
		m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[-100:3:-3],'color', [.5 .5 .5])
		m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[3:3:100],'k')		
		caxis([-.06 .06])
		%caxis([-1.8 .5])
		%caxis([.0003 .03])
		[year,month,day]=jd2jdate(jdays(m));
		title([' nbp26-gchl from GSM  ' ])
		colormap(chelle)
		shading flat
		
		
	
		subplot(221)
		pmap(glon(r,c),glat(r,c),sm_mu(r,c),'schl')
		hold on
		m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[-100:3:-3],'color', [.5 .5 .5])
		m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[3:3:100],'k')		
		%caxis([-.003 .003])
		caxis([-.4 .4])
		[year,month,day]=jd2jdate(jdays(m));
		title([' 500day 2x2 \mu  ' num2str(year) '-' num2str(month) '-' num2str(day) '   '])
		colormap(chelle)
		shading flat
		
   		
   		
   		eval(['print -dpng frame_' num2str(ff) '.png'])
       	%eval(['!convert -trim frame_' num2str(ff) '.png frame_' num2str(ff) ...
        %      '.png'])
       	ff=ff+1;
       	clear bp26_mu sm_gchl_week gchl_week nbp26_chl
	end
	
case {'bp_schl'}
	spath='/matlab/data/SeaWiFS/mat/SCHL_9_21_';
	asave='/matlab/data/eddy/V4/mat/AVISO_25_W_';
	load([spath '2454769'],'glon','glat','jdays')
	load([asave '2454769'],'lon','lat')
	slon=lon;
	slat=lat;
	jdays=[2450821:7:2454832];
	load /matlab/matlab/domains/AGU_lat_lon
	[r,c]=imap(min(lat),max(lat),min(lon),max(lon),glat,glon);
	[rssh,cssh]=imap(min(lat),max(lat),min(lon),max(lon),slat,slon);
	%[r,c]=imap(-45,45,200,350,glat,glon);
	%[r,c]=imap(-60,60,0,360,glat,glon);
	%[rr,cc]=imap(-45,45,200,350,lat,lon);
	%[rr,cc]=imap(min(lat),max(lat),min(lon),max(lon),lat,lon);
	for m=10:length(jdays)-150
		load([spath num2str(jdays(m))],'nbp26_chl')
		load([asave num2str(jdays(m))],'ssh')
		figure(1)
		clf
		pmap(glon(r,c),glat(r,c),nbp26_chl(r,c),'schl')
		hold on
		m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[-200:3:-5],'color', [.5 .5 .5])
		m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[5:3:200],'k')		
		caxis([-.13 .13])
		%caxis([-1.8 .5])
		[year,month,day]=jd2jdate(jdays(m));
		title(['25km 35day nbp26-chl SeaWiFS  ' num2str(year) '-' num2str(month) '-' num2str(day) '   '])
		colormap(chelle)
		shading interp
   		eval(['print -dpng -r300 frame_' num2str(ff) '.png'])
       	eval(['!convert -trim frame_' num2str(ff) '.png frame_' num2str(ff) ...
              '.png'])
       	ff=ff+1;
	end
	
	
	
	case {'dud_chl'}
	save_path='/matlab/data/SeaWiFS/mat/';
	save_head='SCHL_9_21_';
	asave_path='/matlab/data/eddy/V4/mat/';
	asave_head='AVISO_25_W_';
	jdays=[2450821:7:2454832];
	dy=1.5;
	load([save_path 'SCHL_9_21_2450905'],'glat','glon')
	load([asave_path 'AVISO_25_W_2450905'],'lon','lat')
	slon=lon;
	slat=lat;
	
	%{
	[r,c]=imap(-40,-5,170,300,glat,glon);
	[rssh,cssh]=imap(-40,-5,170,300,slat,slon);
	for n=10:200%length(jdays)-50
		load([save_path save_head num2str(jdays(n))],'gchl_week','nbp26_chl')
		load([asave_path asave_head num2str(jdays(n))],'ssh')
		[yea,mon,day]=jd2jdate(jdays(n));
		
		figure(1)
		clf
		subplot(211)
		pmap(glon(r,c),glat(r,c),gchl_week(r,c))
		%caxis([-.15 .15])
		caxis([-1.7 .1])
		%caxis([-.4 1.4])
		hold on
		m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[-82:3:-1],'color', [.5 .5 .5])
		m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[1:3:82],'k')
		m_plot([220 280],[-17 -17],'k','linewidth',2)
		m_plot([220 280 280 280 280 220 220 220],...
		[-17-dy -17-dy -17-dy -17+dy -17+dy -17+dy -17+dy -17-dy],'k--','linewidth',1)
		m_plot([220 280],[-33.5 -33.5],'k','linewidth',2)
		m_plot([220 280 280 280 280 220 220 220],...
		[-33.5-dy -33.5-dy -33.5-dy -33.5+dy -33.5+dy -33.5+dy -33.5+dy -33.5-dy],'k--','linewidth',1)
		title(['SeaWiFS CHL 35-Day loess   ',[num2str(yea) '-' num2str(mon) '-' num2str(day) '    ']])
		colormap(chelle)
		
		subplot(212)
		pmap(glon(r,c),glat(r,c),nbp26_chl(r,c))
		caxis([-.15 .15])
		%caxis([-1.5 .1])
		hold on
		m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[-82:3:-1],'color', [.5 .5 .5])
		m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[1:3:82],'k')
		m_plot([220 280],[-17 -17],'k','linewidth',2)
		m_plot([220 280 280 280 280 220 220 220],...
		[-17-dy -17-dy -17-dy -17+dy -17+dy -17+dy -17+dy -17-dy],'k--','linewidth',1)
		m_plot([220 280],[-33.5 -33.5],'k','linewidth',2)
		m_plot([220 280 280 280 280 220 220 220],...
		[-33.5-dy -33.5-dy -33.5-dy -33.5+dy -33.5+dy -33.5+dy -33.5+dy -33.5-dy],'k--','linewidth',1)
		title({'SeaWiFS Bandpass '})
		colormap(chelle)
   		eval(['print -dpng frame_' num2str(ff) '.png'])
       	eval(['!convert -trim frame_' num2str(ff) '.png frame_' num2str(ff) ...
              '.png'])
       	ff=ff+1;
	end
	
	%}
	[r,c]=imap(10,40,280,350,glat,glon);
	[rssh,cssh]=imap(10,40,280,350,slat,slon);
	for n=3:length(jdays)-50
		load([save_path save_head num2str(jdays(n))],'gchl_week','nbp26_chl')
		load([asave_path asave_head num2str(jdays(n))],'ssh')
		[yea,mon,day]=jd2jdate(jdays(n));
		
		figure(1)
		clf
		subplot(211)
		pmap(glon(r,c),glat(r,c),gchl_week(r,c))
		%caxis([-.15 .15])
		caxis([-1.5 .1])
		%caxis([-.4 1.4])
		hold on
		m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[-82:4:-2],'color', [.5 .5 .5])
		m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[2:4:82],'k')
		m_plot([290 340],[25 25],'k','linewidth',2)
		m_plot([290 340 340 340 340 290 290 290],...
		[25-dy 25-dy 25-dy 25+dy 25+dy 25+dy 25+dy 25-dy],'k--','linewidth',1)
		m_plot([290 340],[35 35],'k','linewidth',2)
		m_plot([290 340 340 340 340 290 290 290],...
		[35-dy 35-dy 35-dy 35+dy 35+dy 35+dy 35+dy 35-dy],'k--','linewidth',1)
		title(['SeaWiFS CHL 35-Day loess   ',[num2str(yea) '-' num2str(mon) '-' num2str(day) '    ']])
		colormap(chelle)
		
		subplot(212)
		pmap(glon(r,c),glat(r,c),nbp26_chl(r,c))
		caxis([-.15 .15])
		%caxis([-1.5 .1])
		hold on
		m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[-82:4:-2],'color', [.5 .5 .5])
		m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[2:4:82],'k')
		m_plot([290 340],[25 25],'k','linewidth',2)
		m_plot([290 340 340 340 340 290 290 290],...
		[25-dy 25-dy 25-dy 25+dy 25+dy 25+dy 25+dy 25-dy],'k--','linewidth',1)
		m_plot([290 340],[35 35],'k','linewidth',2)
		m_plot([290 340 340 340 340 290 290 290],...
		[35-dy 35-dy 35-dy 35+dy 35+dy 35+dy 35+dy 35-dy],'k--','linewidth',1)
		title({'SeaWiFS Bandpass '})
		colormap(chelle)
   		eval(['print -dpng -r300 frame_' num2str(ff) '.png'])
       	eval(['!convert -trim frame_' num2str(ff) '.png frame_' num2str(ff) ...
              '.png'])
       	ff=ff+1;
	end
	%}
	
	
case {'sewifs_dateline'}
jdays=[2450821:2454489];
loN=[0:8640]/24;
LON=loN(2:2:8640);
laT=[2160:-1:-2160]/24;
LAT=laT(2:2:4320); 
lat=single(LAT);
lon=single(LON);
lon=ones(length(lat),1)*lon;
lat=lat'*ones(1,length(lon(1,:)));
glat=biggrid(lat,9,25);
glon=biggrid(lon,9,25);
[r,c]=imap(-60,60,0,360,glat,glon);

for m=1:length(jdays)
	load(['/matlab/data/SeaWiFS/mat/SCHL_9_D_' num2str(jdays(m))],'gchl_day')
	figure(1)
	clf
	pmap(glon(r,c),glat(r,c),log10(gchl_day(r,c)));
	colormap(chelle)
	title('SeaWiFS daily L3 SMI   ')
	eval(['print -dpng -r300 frame_' num2str(ff) '.png'])
    eval(['!convert -trim frame_' num2str(ff) '.png frame_' num2str(ff) '.png'])
    ff=ff+1;                                                       
end


case {'gsm_21'}
	spath='/matlab/data/gsm/mat/GSM_9_21_';
	load([spath '2454769'],'glon','glat','jdays')
	jdays=[2450821:7:2454832];
	load /matlab/matlab/domains/AGU_lat_lon
	[r,c]=imap(min(lat),max(lat),min(lon),max(lon),glat,glon);
	%[r,c]=imap(-45,45,200,350,glat,glon);
	%[r,c]=imap(-60,60,0,360,glat,glon);
	%[rr,cc]=imap(-45,45,200,350,lat,lon);
	%[rr,cc]=imap(min(lat),max(lat),min(lon),max(lon),lat,lon);
	for m=1:length(jdays)
		load([spath num2str(jdays(m))],'nbp26_chl')
		figure(1)
		clf
		pmap(glon(r,c),glat(r,c),nbp26_chl(r,c),'schl')
		%pmap(glon(r,c),glat(r,c),bp28_chl(r,c).*mask_6_6(rr,cc),'schl')
		caxis([-.13 .13])
		%caxis([-1.8 .5])
		[year,month,day]=jd2jdate(jdays(m));
		title(['25km 35day nbp26_chl GSM  ' num2str(year) '-' num2str(month) '-' num2str(day) '   '])
		colormap(chelle)
   		eval(['print -dpng -r300 frame_' num2str(ff) '.png'])
       	eval(['!convert -trim frame_' num2str(ff) '.png frame_' num2str(ff) ...
              '.png'])
       	ff=ff+1;
	end
	
	
case {'gsm_21_cc'}
	spath='/matlab/data/gsm/mat/GSM_9_21_';
	load([spath '2454769'],'glon','glat','jdays')
	load /matlab/data/SeaWiFS/mat/mean_schl mask_6_6 lat lon
	jdays=[2450821:7:2454832];
	%load /matlab/matlab/domains/EK_lat_lon
	%[r,c]=imap(min(lat),max(lat),min(lon),max(lon),glat,glon);
	[r,c]=imap(-60,60,0,360,glat,glon);
	[rr,cc]=imap(-60,60,0,360,lat,lon);
	for m=10:length(jdays)-52
		load([spath num2str(jdays(m))],'gchl_week','gcar_week')
		figure(1)
		clf
		cc=(10.^(gchl_week))./(10.^(gcar_week));
		pmap(glon(r,c),glat(r,c),cc(r,c),'cc')
		%pmap(glon(r,c),glat(r,c),bp28_chl(r,c).*mask_6_6(rr,cc),'schl')
		[year,month,day]=jd2jdate(jdays(m));
		title(['25km 35day GSM CHL:C  ' num2str(year) '-' num2str(month) '-' num2str(day) '   '])
		colormap(chelle)
   		eval(['print -dpng -r300 frame_' num2str(ff) '.png'])
       	eval(['!convert -trim frame_' num2str(ff) '.png frame_' num2str(ff) ...
              '.png'])
       	ff=ff+1;
	end
	
case {'schl'}
	spath='/matlab/data/SeaWiFS/mat/SCHL_9_21_';
	load([spath '2454769'],'glon','glat','jdays')
	load /matlab/data/SeaWiFS/mat/mean_schl mask_6_6 lat lon
	jdays=[2450821:7:2454832];
	%load /matlab/matlab/domains/EK_lat_lon
	%[r,c]=imap(min(lat),max(lat),min(lon),max(lon),glat,glon);
	[r,c]=imap(-45,45,200,350,glat,glon);
	%[r,c]=imap(-60,60,0,360,glat,glon);
	[rr,cc]=imap(-45,45,200,350,lat,lon);
	for m=1:length(jdays)
		load([spath num2str(jdays(m))],'gchl_week')
		figure(1)
		clf
		%pmap(glon(r,c),glat(r,c),bp26_chl(r,c).*mask_6_6(rr,cc),'schl')
		pmap(glon(r,c),glat(r,c),gchl_week(r,c),'schl')
		%caxis([-.13 .13])
		[year,month,day]=jd2jdate(jdays(m));
		title(['25km 35day loess SeaWiFS 2x2 and 6x6  ' num2str(year) '-' num2str(month) '-' num2str(day) '   '])
		colormap(chelle)
   		eval(['print -dpng -r300 frame_' num2str(ff) '.png'])
       	eval(['!convert -trim frame_' num2str(ff) '.png frame_' num2str(ff) ...
              '.png'])
       	ff=ff+1;
	end
	
case {'good_eddies'}
	sc=10:41-10;
	sr=sc;	
	rgrid_grid
	load /matlab/matlab/north/new_north_south_comps r c
	load /matlab/matlab/track/good_chl_eddies
	load /matlab/data/eddy/V4/global_tracks_V4 nneg
	ii=find(per_cov>=98);
	ujday=unique(per_cov_jday(ii));
	pjday=per_cov_jday(ii);
	pid=per_cov_id(ii);
	pcov=per_cov(ii);
	
	for m=1:length(ujday)
		fname=['/matlab/matlab/global/new_trans_4km/TRANS_W_4km_',num2str(ujday(m))];
		load(fname,'chl_full_sample','lat_sample','lon_sample','nranom_sample','id_index')
		chl_id_index=id_index;
		clon=lon_sample;
		clat=lat_sample;
		fname=['/matlab/matlab/global/new_trans_samp/TRANS_W_',num2str(ujday(m))];
		load(fname,'nrfoi_sample','nrssh_sample','nrcrl66_sample','ssh_sample','lon_sample','lat_sample','*_index')
		sub=find(pjday==ujday(m));
		stmp=sames(pid(sub),id_index);
		tmp=sames(pid(sub),chl_id_index);
		for p=1:min(length(tmp),length(stmp))
			figure(1)
			clf
			subplot(231)
			pcolor(X(r,c),Y(r,c),double(nranom_sample(r,c,tmp(p))));shading interp;axis tight
			%caxis([-.4 .4])
			%title('NR Anom Masked  '
			text(-4,-4,['\mu = ',num2str(pmean(nranom_sample(r,c,tmp(p))))]);
			text(-4,4,'chl anom')
			
			subplot(234)
			pcolor(clon(:,:,tmp(p)),clat(:,:,tmp(p)),double(chl_full_sample(:,:,tmp(p))));
			hold on
			contour(lon_sample(:,:,stmp(p)),lat_sample(:,:,stmp(p)),ssh_sample(:,:,stmp(p)),[1:2:31],'k')
			contour(lon_sample(:,:,stmp(p)),lat_sample(:,:,stmp(p)),ssh_sample(:,:,stmp(p)),[-31:2:-1],'color',[.5 .5 .5])
			shading interp;axis tight
			caxis([-.4 .4])
			plot(x_index(tmp(p)),y_index(tmp(p)),'k*')
			%title('Full Anom Sample  ')
			title(['efold = ' num2str(efold_index(stmp(p))),' km'])
			
			
			subplot(232)
			pcolor(X(r,c),Y(r,c),double(nrcrl66_sample(r,c,stmp(p))).*1e5);axis tight;shading interp
			caxis([-3 3])
			text(-4,4,'wind crl')
			title(['id ' num2str(chl_id_index(tmp(p)))])
			text(-4,-4,['\mu = ',num2str(pmean(nrcrl66_sample(r,c,tmp(p))).*1e5)]);
			%text(-4,-4,['nneg = ' num2str(nneg)])
			
			subplot(236)
			pcolor(X(r,c),Y(r,c),double(nrssh_sample(r,c,stmp(p))));axis tight;shading interp
			caxis([-1 1])
			text(-4,4,'ssh')
			text(-4,-4,['amp = ' num2str(amp_index(stmp(p)))])
			title(['k = ' num2str(k_index(stmp(p)))])
			
			subplot(233)
			pcolor(X(r,c),Y(r,c),double(nrfoi_sample(r,c,stmp(p))));axis tight;shading interp
			caxis([-1 1])
			text(-4,4,'sst anom')
			text(-4,-4,['\mu = ',num2str(pmean(nrfoi_sample(r,c,tmp(p))))]);
			
			subplot(235)
			min_lat=floor(y_index(tmp(p)));
			max_lat=ceil(y_index(tmp(p)));
			min_lon=floor(x_index(tmp(p)));
			max_lon=ceil(x_index(tmp(p)));
			llon=min_lon-50:max_lon+50;
			llat=min_lat-30:max_lat+30;
			pmap(llon,llat,nan(length(llat),length(llon)),'nolab');axis tight
			hold on
			m_plot(x_index(tmp(p)),y_index(tmp(p)),'r*')
			title(['frame ',num2str(ff)])
			xlabel(['jday = ',num2str(ujday(m))])
			
			hold off
			colormap(chelle)
    		eval(['print -dpng -r300 frame_' num2str(ff) '.png'])
        	eval(['!convert -trim frame_' num2str(ff) '.png frame_' num2str(ff) ...
              '.png'])
        	ff=ff+1;
        end
        clear *_sample *_index
   end     	
			
			
			
			
			
			
		



case {'SS'}
    warning('off','all')
    figure(1)
    load /matlab/matlab/domains/LW_lat_lon.mat
	max_lat=max(lat(:));
	min_lat=min(lat(:));
	max_lon=max(lon(:));
	min_lon=min(lon(:));

	load /matlab/matlab/global/modis_chl_4km/CHL_4_W_2454489.mat lat lon
	%rs=find(lat(:,1)>=min_lat & lat(:,1)<=max_lat);
	%cs=find(lon(1,:)>=min_lon & lon(1,:)<=max_lon);
	%lat=biggrid(lat,4,25);
	%lon=biggrid(lon,4,25);
	r=find(lat(:,1)>=min_lat & lat(:,1)<=max_lat);
	c=find(lon(1,:)>=min_lon & lon(1,:)<=max_lon);
	jdays=[2452459:7:2454489];
	
	
	for m=26:length(jdays)
        eval(['load /matlab/matlab/global/modis_chl_4km/CHL_4_W_' ...
              num2str(jdays(m)) '.mat SS']);
        %ss=biggrid(SS(rs,cs),4,25);      
        [y,m,d]=jd2jdate(jdays(m));
        dd=(y*1000)+julian(m,d,y,y);
        clf
    	m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat ...
                        max_lat]);
    	m_grid('xtick',[round(min_lon):10:round(max_lon)],'ytick', ...
           	[round(min_lat):3:round(max_lat)],'tickdir','out', ...
           'color','w');
    	grid off
   		hold on
    	m_pcolor(lon(r,c),lat(r,c),double(SS(r,c)));
    	set(gcf,'color','k')
    	set(gcf, 'InvertHardCopy', 'off');
    	shading flat
    	colormap(chelle)
	    caxis([-2 1])
    	%c=colorbar('horiz');
		m_coast('color','w');
    	grid
    	title({'Seasonal Cycle of Chlorophyll Concentration',...
           'MODIS-Aqua 4km',['year day ' num2str(julian(m,d,y,y))]},'color','w')
    	Tick=[.01 .05 .1 .2 .5 1 2.5 5 10];
    	axes(c);
    	set(c,'position',[.15 .15 .74 .025],'XTick',log10(Tick),...
    	      'XTickLabel', Tick,'xcolor','w','ycolor','w');
   		xlabel('mg m^{-3}','color','w')
    	hold off
    	eval(['print -dpng frame_' num2str(ff) '.png'])
        eval(['!convert -trim frame_' num2str(ff) '.png frame_' num2str(ff) ...
              '.png'])
        ff=ff+1;
    end
    !ffmpeg -r 10 -sameq -i frame_%d.png -y LW_SS.mp4
    
    
case {'logmchl_tracks'}
warning('off','all')
figure(1)

load /matlab/matlab/domains/LW_lat_lon.mat
max_lat=max(lat(:));
min_lat=min(lat(:));
max_lon=max(lon(:));
min_lon=min(lon(:));
load /matlab/matlab/timor/modis_chl_4km/CHL_4_W_2452459 lat lon mid_week_jdays
r=find(lat(:,1)>=min_lat & lat(:,1)<=max_lat);
c=find(lon(1,:)>=min_lon & lon(1,:)<=max_lon);
rssh=find(ssh_lat(:,1)>=min_lat & ssh_lat(:,1)<=max_lat);
cssh=find(ssh_lon(1,:)>=min_lon & ssh_lon(1,:)<=max_lon);
match_time=find(mid_week_jdays>= min(track_jday) & mid_week_jdays<=max(track_jday));



for m=match_time
clf
[yea,mon,day]=jd2jdate(mid_week_jdays(m));
dd=(yea*1000)+julian(mon,day,yea,yea)
eval(['load /matlab/matlab/timor/modis_chl_4km/CHL_4_W_' ...
      num2str(mid_week_jdays(m)) '.mat chl_week jt lon lat']);
pmap(lon(r,c),lat(r,c),chl_week(r,c),'logmchl',num2str(dd))
hold on
m_contour(ssh_lon(rssh,cssh),ssh_lat(rssh,cssh),filtered_ssh(rssh,cssh),[-40:2:-2],'k--')
m_contour(ssh_lon(rssh,cssh),ssh_lat(rssh,cssh),filtered_ssh(rssh,cssh),[-2:2:40],'k')
da=find(track_jday==mid_week_jdays(m) & id>=nneg);
dc=find(track_jday==mid_week_jdays(m) & id<nneg);
p=find(track_jday<=mid_week_jdays(m));
h=m_plot(x(dc),y(dc),'wo','markerfacecolor', ...
         'w','markersize',6);
h=m_plot(x(da),y(da),'wo','markersize',6);         
set(h,'clipping','off')
tmp_ids_a=id(da);
tmp_ids_c=id(dc);
time_ids=id(p);
time_xs=x(p);
time_ys=y(p);
for b=1:length(tmp_ids_a)
    tmp=tmp_ids_a(b);
    e=find(time_ids==tmp);
    h=m_plot(time_xs(e),time_ys(e),'w-.', ...
              'linewidth',4);
    set(h,'clipping','off')
end
for b=1:length(tmp_ids_c)
    tmp=tmp_ids_c(b);
    e=find(time_ids==tmp);
       h=m_plot(time_xs(e),time_ys(e),'w', ...
               'linewidth',4);
       set(h,'clipping','off')
end


eval(['print -dpng -r300 frame_' num2str(ff) '.png'])
eval(['!convert -trim frame_' num2str(ff) '.png frame_' num2str(ff) ...
      '.png'])
ff=ff+1;
end

!ffmpeg -r 5 -sameq -i frame_%d.png -y lw_mchl_tracks_4km.mp4




case {'logmchl_trans_box_tracks'}
warning('off','all')
figure(1)
load /matlab/matlab/domains/LW_lat_lon.mat
load /matlab/matlab/leeuwin/leeuwin_orgin_tracks_16_weeks.mat

f1=find(id == 124643);
id=id(f1);
eid=eid(f1);
x=x(f1);
y=y(f1);
amp=amp(f1);
axial_speed=axial_speed(f1);
efold=efold(f1);
radius=radius(f1);
track_jday=track_jday(f1);
prop_speed=prop_speed(f1);
k=k(f1);


max_lat=max(lat(:));
min_lat=min(lat(:));
max_lon=max(lon(:));
min_lon=min(lon(:));
load /matlab/matlab/global/modis_chl_4km/CHL_4_W_2454440 lat lon mid_week_jdays
clat=lat;
clon=lon;

unid = unique(id);
for ee=1:length(unid)
	itid=find(id==unid(ee));
	tid=id(itid);
	for n=1:length(tid)
	pp=find(mid_week_jdays==track_jday(itid(n)));
	if any(pp)
	eval(['load /matlab/matlab/global/modis_chl_4km/CHL_4_W_' ...
      num2str(mid_week_jdays(pp)) '.mat chl_anom jt']);
	r=find(clat(:,1)>=y(itid(n))-3 & clat(:,1)<=y(itid(n))+3);
	c=find(clon(1,:)>=x(itid(n))-3 & clon(1,:)<=x(itid(n))+3);
	load(['/matlab/data/eddy/V3/mat/AVISO_25_W_',num2str(track_jday(itid(n)))])
	rssh=find(lat>=y(itid(n))-3 & lat<=y(itid(n))+3);
	cssh=find(lon>=x(itid(n))-3 & lon<=x(itid(n))+3);
	if length(rssh)>20 & length(cssh)>20
		clf
		[yea,mon,day]=jd2jdate(mid_week_jdays(pp));
		dd=(yea*1000)+julian(mon,day,yea,yea)
		pmap(clon(r,c),clat(r,c),chl_anom(r,c),'mchlanom',num2str(dd))
		hold on
		m_contour(lon(cssh),lat(rssh),ssh(rssh,cssh),[-90:2:-2],'--','color',[.5 .5 .5])
		m_contour(lon(cssh),lat(rssh),ssh(rssh,cssh),[-2:2:90],'color',[.5 .5 .5])
		xlabel(['ID = ', num2str(id(itid(n))), '  k = ',num2str(k(itid(n))), ' of ' , num2str(max(k(itid)))...
				'  U/c = ',num2str(axial_speed(itid(n))/prop_speed(itid(n))),'  Amp = ',num2str(amp(itid(n)))],'color','w')
		d=find(track_jday(itid)==mid_week_jdays(pp));
		p=find(track_jday(itid)<=mid_week_jdays(pp));
		h=m_plot(x(itid(d)),y(itid(d)),'wo','markerfacecolor', ...
         			'w','markersize',4);
		tmp_ids=id(itid(d));
		time_ids=id(itid(p));
		time_xs=x(itid(p));
		time_ys=y(itid(p));
		for b=1:length(tmp_ids)
  		  	tmp=tmp_ids(b);
   		 	e=find(time_ids==tmp);
   		 	h=m_plot(time_xs(e),time_ys(e),'w', ...
              		'linewidth',2);
    		set(h,'clipping','off')
		end

		eval(['print -dpng frame_' num2str(ff) '.png'])
		%eval(['!convert -trim frame_' num2str(ff) '.png frame_' num2str(ff) ...
      	%		'.png'])
		ff=ff+1;
		else 
		end
		end
	end	
end
!ffmpeg -r 5 -sameq -i frame_%d.png -y lw_mchl_track_trans_box_cycl.mp4

case {'logmchl_contour_box_tracks'}
warning('off','all')
figure(1)
load /matlab/matlab/domains/LW_lat_lon.mat
max_lat=max(lat(:));
min_lat=min(lat(:));
max_lon=max(lon(:));
min_lon=min(lon(:));
load /matlab/matlab/timor/modis_chl_4km/CHL_4_W_2454440 lat lon mid_week_jdays

tt = find(track_jday>=min(mid_week_jdays) & track_jday<=max(mid_week_jdays) & id<nneg);
id=id(tt);
x=x(tt);
y=y(tt);
track_jday=track_jday(tt);
k=k(tt);

unid = unique(id);
for ee=1:length(unid)
	itid=find(id==unid(ee));
	tid=id(itid);
	for n=1:length(tid)
	pp=find(mid_week_jdays==track_jday(itid(n)));
	qq=find(jdays==track_jday(itid(n)));
	if any(qq)
	eval(['load /matlab/matlab/timor/modis_chl_4km/CHL_4_W_' ...
      num2str(mid_week_jdays(pp)) '.mat chl_anom jt lon lat']);
	r=find(lat(:,1)>=y(itid(n))-3 & lat(:,1)<=y(itid(n))+3);
	c=find(lon(1,:)>=x(itid(n))-3 & lon(1,:)<=x(itid(n))+3);
	rssh=find(ssh_lat(:,1)>=y(itid(n))-3 & ssh_lat(:,1)<=y(itid(n))+3);
	cssh=find(ssh_lon(1,:)>=x(itid(n))-3 & ssh_lon(1,:)<=x(itid(n))+3);
	if length(rssh)>20 & length(cssh)>20
		clf
		[yea,mon,day]=jd2jdate(track_jday(pp));
		dd=(yea*1000)+julian(mon,day,yea,yea)
		d=find(track_jday(itid)==jdays(qq));
		p=find(track_jday(itid)<=jdays(qq));
		tmp_ids=id(itid(d));
		time_ids=id(itid(p));
		time_xs=x(itid(p));
		time_ys=y(itid(p));
		
		pmap(lon(r,c),lat(r,c),chl_anom(r,c),'mchlanom',num2str(dd))
		hold on
		m_contour(ssh_lon(rssh,cssh),ssh_lat(rssh,cssh),ssh(rssh,cssh,qq),[-40:2:-2],'--','color',[.5 .5 .5])
		m_contour(ssh_lon(rssh,cssh),ssh_lat(rssh,cssh),ssh(rssh,cssh,qq),[-2:2:40],'color',[.5 .5 .5])
		xlabel(['ID = ', num2str(id(itid(n))), '  k = ',num2str(k(itid(n))), ' of ' , num2str(max(k(itid)))],'color','w')
		h=m_plot(x(itid(d)),y(itid(d)),'wo','markerfacecolor', ...
         			'w','markersize',4);
		
		for b=1:length(tmp_ids)
  		  	tmp=tmp_ids(b);
   		 	e=find(time_ids==tmp);
   		 	h=m_plot(time_xs(e),time_ys(e),'w', ...
              		'linewidth',2);
    		set(h,'clipping','off')
		end
		
		eval(['print -dpng frame_' num2str(ff) '.png'])
		eval(['!convert -trim frame_' num2str(ff) '.png frame_' num2str(ff) ...
      			'.png'])
		ff=ff+1;
		clf
		else 
		end
		end
	end	
end
!ffmpeg -r 5 -sameq -i frame_%d.png contour_box.mp4


case {'logmchl_ssh_box_tracks'}
warning('off','all')
figure(1)
load /matlab/matlab/domains/LW_lat_lon.mat
max_lat=max(lat(:));
min_lat=min(lat(:));
max_lon=max(lon(:));
min_lon=min(lon(:));
load /matlab/matlab/timor/modis_chl_4km/CHL_4_W_2454440 lat lon mid_week_jdays
unid = unique(id);



for ee=1:length(unid)
	itid=find(id==unid(ee));
	tid=id(itid);
	for n=1:length(tid)
	pp=find(mid_week_jdays==track_jday(itid(n)));
	qq=find(jdays==track_jday(itid(n)));
	if any(qq)
	eval(['load /matlab/matlab/timor/modis_chl_4km/CHL_4_W_' ...
      num2str(mid_week_jdays(pp)) '.mat chl_anom jt lon lat']);
	r=find(lat(:,1)>=y(itid(n))-3 & lat(:,1)<=y(itid(n))+3);
	c=find(lon(1,:)>=x(itid(n))-3 & lon(1,:)<=x(itid(n))+3);
	rssh=find(ssh_lat(:,1)>=y(itid(n))-3 & ssh_lat(:,1)<=y(itid(n))+3);
	cssh=find(ssh_lon(1,:)>=x(itid(n))-3 & ssh_lon(1,:)<=x(itid(n))+3);
	if length(rssh)>20 & length(cssh)>20
		clf
		[yea,mon,day]=jd2jdate(jdays(pp));
		dd=(yea*1000)+julian(mon,day,yea,yea)
		d=find(track_jday(itid)==jdays(pp));
		p=find(track_jday(itid)<=jdays(pp));
		tmp_ids=id(itid(d));
		time_ids=id(itid(p));
		time_xs=x(itid(p));
		time_ys=y(itid(p));
		
		
		subplot(121)
		pmap(lon(r,c),lat(r,c),chl_anom(r,c),'mchlanom',num2str(dd))
		hold on
		m_contour(ssh_lon(rssh,cssh),ssh_lat(rssh,cssh),ssh(rssh,cssh,qq),[-40:2:-2],'--','color',[.5 .5 .5])
		m_contour(ssh_lon(rssh,cssh),ssh_lat(rssh,cssh),ssh(rssh,cssh,qq),[-2:2:40],'color',[.5 .5 .5])
		xlabel(['ID = ', num2str(id(itid(n))), '  k = ',num2str(k(itid(n))), ' of ' , num2str(max(k(itid)))],'color','w')
		h=m_plot(x(itid(d)),y(itid(d)),'wo','markerfacecolor', ...
         			'w','markersize',4);
		
		for b=1:length(tmp_ids)
  		  	tmp=tmp_ids(b);
   		 	e=find(time_ids==tmp);
   		 	h=m_plot(time_xs(e),time_ys(e),'w', ...
              		'linewidth',2);
    		set(h,'clipping','off')
		end
		
		hold off
		subplot(122)
		pmap(ssh_lon(rssh,cssh),ssh_lat(rssh,cssh),filtered_ssh(rssh,cssh,qq),'hpssh_med_w',num2str(dd))
		hold on
		m_contour(ssh_lon(rssh,cssh),ssh_lat(rssh,cssh),filtered_ssh(rssh,cssh,qq),[-40:2:-2],'w--')
		m_contour(ssh_lon(rssh,cssh),ssh_lat(rssh,cssh),filtered_ssh(rssh,cssh,qq),[-2:2:40],'w')
		xlabel(['  \theta = ',num2str(theta(itid(n))),'  tflag = ',num2str(tflag(ee))],'color','w')
		h=m_plot(x(itid(d)),y(itid(d)),'ko','markerfacecolor', ...
         			'k','markersize',4);
		
		for b=1:length(tmp_ids)
  		  	tmp=tmp_ids(b);
   		 	e=find(time_ids==tmp);
   		 	h=m_plot(time_xs(e),time_ys(e),'k', ...
              		'linewidth',2);
    		set(h,'clipping','off')
		end
		hold off
		

		eval(['print -dpng frame_' num2str(ff) '.png'])
		eval(['!convert -trim frame_' num2str(ff) '.png frame_' num2str(ff) ...
      			'.png'])
		ff=ff+1;
		clf
		else 
		end
		end
	end	
end
!ffmpeg -r 5 -sameq -i frame_%d.png lw_mchl_track_trans_box.mp4


case {'mchlanom_tracks'}
warning('off','all')
figure(1)

startyear = 2002;
startmonth = 07;
startday = 3;
endyear = 2008;
endmonth = 06;
endday = 11;

%construct date vector
startjd=date2jd(startyear,startmonth,startday)-2.5;
endjd=date2jd(endyear,endmonth,endday)+3.5;
jdays=[startjd:endjd];

%construct date vector for mid-week day
mid_week_jdays=[startjd+6:7:endjd];

max_lat=max(lat(:));
min_lat=min(lat(:));
max_lon=max(lon(:));
min_lon=min(lon(:));
match_time=find(mid_week_jdays>= min(track_jday) & mid_week_jdays<=max(track_jday));

for m=match_time
clf
eval(['load /matlab/matlab/timor/modis_chl_4km/CHL_4_W_' ...
      num2str(mid_week_jdays(m)-3) '.mat chl_anom jt']);
[yea,mon,day]=jd2jdate(jt);
dd=(yea*1000)+julian(mon,day,yea,yea)
pmap(lon,lat,chl_anom,'mchlanom',num2str(dd))
hold on
da=find(track_jday==mid_week_jdays(m)-3 & id>=nneg);
dc=find(track_jday==mid_week_jdays(m)-3 & id<nneg);
p=find(track_jday<=mid_week_jdays(m)-3);
h=m_plot(x(dc),y(dc),'wo','markerfacecolor', ...
         'w','markersize',2);
h=m_plot(x(da),y(da),'wo','markersize',2);         
set(h,'clipping','off')
tmp_ids_a=id(da);
tmp_ids_c=id(dc);
time_ids=id(p);
time_xs=x(p);
time_ys=y(p);
for b=1:length(tmp_ids_a)
    tmp=tmp_ids_a(b);
    e=find(time_ids==tmp);
    h=m_plot(time_xs(e),time_ys(e),'w-.', ...
              'linewidth',.5);
    set(h,'clipping','off')
end
for b=1:length(tmp_ids_c)
    tmp=tmp_ids_c(b);
    e=find(time_ids==tmp);
       h=m_plot(time_xs(e),time_ys(e),'w', ...
               'linewidth',.5);
       set(h,'clipping','off')
end

eval(['print -dpng frame_' num2str(ff) '.png'])
eval(['!convert -trim frame_' num2str(ff) '.png frame_' num2str(ff) ...
      '.png'])
ff=ff+1;
end
!ffmpeg -r 5 -sameq -i frame_%d.png -y timor_chl_tracks_4km.mp4



case {'logmerchl_tracks'}
warning('off','all')
figure(1)

startyear = 2002;
startmonth = 07;
startday = 3;
endyear = 2008;
endmonth = 01;
endday = 23;

%construct date vector
startjd=date2jd(startyear,startmonth,startday)-2.5;
endjd=date2jd(endyear,endmonth,endday)+3.5;
jdays=[startjd:endjd];

%construct date vector for mid-week day
mid_week_jdays=[startjd+6:7:endjd];

max_lat=max(lat(:));
min_lat=min(lat(:));
max_lon=max(lon(:));
min_lon=min(lon(:));
match_time=find(mid_week_jdays>= min(track_jday) & mid_week_jdays<=max(track_jday));

for m=match_time
clf
eval(['load /matlab/matlab/timor/merged_chl_mat/CHL_X_W_' ...
      num2str(mid_week_jdays(m)-3) '.mat merged_chl_week jt']);
[yea,mon,day]=jd2jdate(jt);
dd=(yea*1000)+julian(mon,day,yea,yea)
pmap(lon,lat,merged_chl_week,'logmerchl',num2str(dd))
hold on
da=find(track_jday==mid_week_jdays(m)-3 & id>=nneg);
dc=find(track_jday==mid_week_jdays(m)-3 & id<nneg);
p=find(track_jday<=mid_week_jdays(m)-3);
h=m_plot(x(dc),y(dc),'wo','markerfacecolor', ...
         'w','markersize',2);
h=m_plot(x(da),y(da),'wo','markersize',2);         
set(h,'clipping','off')
tmp_ids_a=id(da);
tmp_ids_c=id(dc);
time_ids=id(p);
time_xs=x(p);
time_ys=y(p);
for b=1:length(tmp_ids_a)
    tmp=tmp_ids_a(b);
    e=find(time_ids==tmp);
    h=m_plot(time_xs(e),time_ys(e),'w-.', ...
              'linewidth',.5);
    set(h,'clipping','off')
end
for b=1:length(tmp_ids_c)
    tmp=tmp_ids_c(b);
    e=find(time_ids==tmp);
       h=m_plot(time_xs(e),time_ys(e),'w', ...
               'linewidth',.5);
       set(h,'clipping','off')
end

eval(['print -dpng frame_' num2str(ff) '.png'])
eval(['!convert -trim frame_' num2str(ff) '.png frame_' num2str(ff) ...
      '.png'])
ff=ff+1;
end
!ffmpeg -r 5 -sameq -i frame_%d.png -y timor_chl_tracks_merged.mp4



  case {'merchl_filled'}
    warning('off','all')
    figure(1)
    for m=1:length(mid_week_jdays)
        clf
        eval(['load /matlab/matlab/hawaii/merged_chl_mat/CHL_X_W_' ...
              ...
              num2str(mid_week_jdays(m)-3) '.mat']);
        [y,m,d]=jd2jdate(jt);
        dd=(y*1000)+julian(m,d,y,y);
        pmap(lon,lat,chl_filled,'merchl_filled',num2str(dd))
        eval(['print -dpng frame_' num2str(ff) '.png'])
        eval(['!convert -trim frame_' num2str(ff) '.png frame_' num2str(ff) ...
              '.png'])
        ff=ff+1;
    end
    !ffmpeg -r 3 -sameq -i frame_%d.png -y timor_merged_chl_filled.mov
    
      case {'mchl_filled'}
    warning('off','all')
    figure(1)
    for m=1:length(mid_week_jdays)
        clf
        eval(['load /matlab/matlab/timor/modis_chl_4km/CHL_4_W_' ...
              num2str(mid_week_jdays(m)-3) '.mat']);
        [y,m,d]=jd2jdate(jt);
        dd=(y*1000)+julian(m,d,y,y);
        pmap(lon,lat,chl_filled,'mchl_filled',num2str(dd))
        eval(['print -dpng frame_' num2str(ff) '.png'])
        eval(['!convert -trim frame_' num2str(ff) '.png frame_' num2str(ff) ...
              '.png'])
        ff=ff+1;
    end
    !ffmpeg -r 3 -sameq -i frame_%d.png -y timor_modis_chl_filled.mov
    


case {'logmchl'}
warning('off','all')
figure(1)
for m=1:length(mid_week_jdays)
clf
eval(['load /matlab/matlab/hawaii/modis_chl_4km/CHL_4_W_' ...
      num2str(mid_week_jdays(m)-3) '.mat']);
[y,m,d]=jd2jdate(jt);
dd=(y*1000)+julian(m,d,y,y);
pmap(lon,lat,chl_week,'logmchl',num2str(dd))
eval(['print -dpng frame_' num2str(ff) '.png'])      
eval(['!convert -trim frame_' num2str(ff) '.png frame_' num2str(ff) '.png']) 
ff=ff+1;
end
!ffmpeg -r 3 -sameq -i frame_%d.png -y hawaii_chl_4km.mov

case {'mchlanom'}
warning('off','all')
figure(1)
for m=1:length(mid_week_jdays)
clf
eval(['load /matlab/matlab/hawaii/modis_chl_4km/CHL_4_W_' ...
      num2str(mid_week_jdays(m)-3) '.mat']);
[y,m,d]=jd2jdate(jt);
dd=(y*1000)+julian(m,d,y,y);
pmap(lon,lat,chl_anom,'mchlanom',num2str(dd))
eval(['print -dpng frame_' num2str(ff) '.png'])
eval(['!convert -trim frame_' num2str(ff) '.png frame_' num2str(ff) ...
      '.png'])
ff=ff+1;
end
!ffmpeg -r 3 -sameq -i frame_%d.png -y hawaii_chl_anom_4km.mov

case {'schlanom'}
warning('off','all')
figure(1)
for m=1:length(mid_week_jdays)
clf

[yea,mon,day]=jd2jdate(mid_week_jdays(m));
dd=(yea*1000)+julian(mon,day,yea,yea);
pmap(grid_lon,grid_lat,chl_anom(:,:,m),'schlanom',num2str(dd))
eval(['print -dpng frame_' num2str(ff) '.png'])
eval(['!convert -trim frame_' num2str(ff) '.png frame_' num2str(ff) ...
      '.png'])
ff=ff+1;
end
!ffmpeg -r 3 -sameq -i frame_%d.png -y tropac_chl_anom.mp4


case {'mchlss'}
warning('off','all')
figure(1)
for m=1:length(mid_week_jdays)
clf
eval(['load /matlab/matlab/hawaii/modis_chl_4km/CHL_4_W_' ...
      num2str(mid_week_jdays(m)-3) '.mat']);
[y,m,d]=jd2jdate(jt);
dd=(y*1000)+julian(m,d,y,y);
pmap(lon,lat,SS,'mchlss',num2str(dd))
eval(['print -dpng frame_' num2str(ff) '.png'])
eval(['!convert -trim frame_' num2str(ff) '.png frame_' num2str(ff) ...
      '.png'])
ff=ff+1;
end
!ffmpeg -r 3 -sameq -i frame_%d.png -y hawaii_chl_seasonal_cycle_4km.mov



   case {'chl_ss'}
	d=2007001
	for m=1:365
		pmap(lon,lat,seasonal_cycle(:,:,m),'chlss',num2str(d))
	print -dpsc temp.ps
             !sed 's/6 dpi2point mul] 0 setdash/3 dpi2point mul] 0 setdash/' temp.ps > tmp.ps
             eval(['!cp tmp.ps ' num2str(frame) '.ps']);
             eval(['!convert -density 150x150 ' ...
             num2str(frame) '.ps frame_' num2str(frame) '.pdf']);
             eval(['!toast ' num2str(frame) '.ps']);
             frame = frame+1;
             d=d+1
     end
     !convert -trim -density 90x90 frame*.pdf seawifs_seasonal_cycl.mpg

end

png2mpg

