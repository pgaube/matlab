TYPE='ssh_tracks'

load bwr.pal
load chelle.pal
load bwy.pal
load rwp.pal
load pgray.pal

figure(1);
ff=1;
prev_x=[];
prev_y=[];
prev_id=[];

!toast *.png
!toast *.pnm
switch TYPE

    
    case {'ssh_tracks'}
	spath='~/data/eddy/V5/mat/AVISO_25_W_';
	load ~/data/eddy/V5/global_tracks_V5
	startjd=2448924;
	endjd=2454832;
	jdays=[startjd:7:endjd];
	load ~/matlab/domains/famke_lat_lon

	alat=lat;
	alon=lon;
	dlon=lon;
	dlat=lat;
	dlat=min(lat):max(lat);
	dlon=min(lon):max(lon);
	max_lat=max(dlat(:)); 
	min_lat=min(dlat(:)); 
	max_lon=max(dlon(:)); 
	min_lon=min(dlon(:));
	lat_step=10;
	lon_step=20;
	load([spath '2454713'],'lat','lon')
	[r,c]=imap(min(dlat),max(dlat),min(dlon),max(dlon),lat,lon);
	%[r,c]=imap(-60,60,0,360,lat,lon);
	ii=find(x>min(dlon) & x<max(dlon) & y>min(dlat) & y<max(dlat));
	x=x(ii);
	y=y(ii);
	id=id(ii);
	k=k(ii);
	track_jday=track_jday(ii);
	ilon=interp2(lon(r,c),2);
	ilat=interp2(lat(r,c),2);
    
	aviobj = VideoWriter('Femke_SSH_and_eddies.avi'); 
    
    aviobj.FrameRate=10;
    aviobj.Quality=100;
    
    open(aviobj)
    figure(1)
	clf
	m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);   
	m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick',[round(min_lat):lat_step:round(max_lat)],'tickdir','in','color','k','lineweight',1.5);  
	m_gshhs_f('save','gumby');
	[xx,yy]=m_ll2xy(ilon,ilat);
    for m=1:length(jdays)
		load([spath num2str(jdays(m))],'ssh','mdt')
		ssh=interp2(ssh(r,c),2);
        mdt=interp2(mdt(r,c),2);
        
        figure(2);
        %set(gcf,'Resize','off')
        rect = get(gcf,'Position');
        rect(1:2) = [0 0];
		clf
        fr=gcf;
		m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);   
		m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick',[round(min_lat):lat_step:round(max_lat)],'tickdir','in','color','k','lineweight',1.5);  
		hold on
		m_pcolor(ilon,ilat,double(ssh))
		shading flat
		colormap(chelle)
%       [cs,h]=m_contour(ilon,ilat,mdt,[-200:8:-3],'k--');
%      	[cs,h]=m_contour(ilon,ilat,mdt,[3:8:200],'k');
        %return
		%h=streamline([verts averts]);
        %set(h,'color','k','linewidth',1)
		grid
		[year,month,day]=jd2jdate(jdays(m));
		title(['AVISO SSH  ' num2str(year) '-' num2str(month) '-' num2str(day) '   '])
% 		xlabel('contour interval 4 cm, starting at +/- 3cm')
		hold on
		ii=find(track_jday==jdays(m) & x>min(dlon) & x<max(dlon) & y>min(dlat) & y<max(dlat));
		d=find(track_jday==jdays(m));
		p=find(track_jday<=jdays(m));
		if k(d)==1
			m_plot(x(d),y(d),'o','markerfacecolor', ...
         	'c','markeredgecolor','c','markersize',5);
        else
        	m_plot(x(d),y(d),'o','markerfacecolor', ...
         	'k','markeredgecolor','k','markersize',5);
        end 	
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
		%draw_domain(alon,alat)
		m_usercoast('gumby','patch','k');
        caxis([-10 10])
		colormap(chelle)
		cc=colorbar;
		axes(cc)
		xlabel('cm')
        pause(.1)
        writeVideo(aviobj,getframe(fr,rect));
        %eval(['print -dpng -r300 frame_' num2str(ff) '.png'])
		
        %}
        ff=ff+1;
    end
    close(aviobj);
    
    
    
    case {'mdt'}
	spath='~/data/eddy/V5/mat/AVISO_25_W_';
	load ~/data/eddy/V5/global_tracks_V5
	startjd=2448924;
	endjd=2454832;
	jdays=[startjd:7:endjd];
	load ~/matlab/domains/AGR_lat_lon

	alat=lat;
	alon=lon;
	dlon=lon;
	dlat=lat;
	dlat=min(lat):max(lat)+10;
	dlon=min(lon)+10:max(lon)-20;
	max_lat=max(dlat(:)); 
	min_lat=min(dlat(:)); 
	max_lon=max(dlon(:)); 
	min_lon=min(dlon(:));
	lat_step=10;
	lon_step=20;
	load([spath '2454713'],'lat','lon')
	[r,c]=imap(min(dlat),max(dlat),min(dlon),max(dlon),lat,lon);
	%[r,c]=imap(-60,60,0,360,lat,lon);
	ii=find(x>min(dlon) & x<max(dlon) & y>min(dlat) & y<max(dlat));
	x=x(ii);
	y=y(ii);
	id=id(ii);
	k=k(ii);
	track_jday=track_jday(ii);
	ilon=interp2(lon(r,c),2);
	ilat=interp2(lat(r,c),2);
    
	aviobj = VideoWriter('ARC_MDT_and_eddies.avi'); 
    
    aviobj.FrameRate=15;
    aviobj.Quality=100;
    
    open(aviobj)
    figure(1)
	clf
	m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);   
	m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick',[round(min_lat):lat_step:round(max_lat)],'tickdir','in','color','k','lineweight',1.5);  
	m_gshhs_f('save','gumby');
	[xx,yy]=m_ll2xy(ilon,ilat);
    for m=1:300%length(jdays)
		load([spath num2str(jdays(m))],'ssh','mdt')
		ssh=interp2(ssh(r,c),2);
        mdt=interp2(mdt(r,c),2);
        %v=dfdx(ilat,mdt,.25);
        %u=dfdy(mdt,.25);
        
        %[verts averts] = streamslice(xx,yy,u,v,10); 
 
        %{
		figure(1)
		clf
		m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);   
		m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick',[round(min_lat):lat_step:round(max_lat)],'tickdir','in','color','k','lineweight',1.5);  
		hold on
		m_pcolor(ilon,ilat,double(ssh))
		shading flat
		colormap(chelle)
		[cs,h]=m_contour(ilon,ilat,ssh,[-200:6:-3],'k');
     	[cs,h]=m_contour(ilon,ilat,ssh,[3:6:200],'k');
		caxis([-25 25])
		colormap(chelle)
		grid
		[year,month,day]=jd2jdate(jdays(m));
		title(['High-pass Filtered AVISO MDT  ' num2str(year) '-' num2str(month) '-' num2str(day) '   '])
		xlabel('contour interval 4 cm, starting at +/- 3cm')
		hold on
		ii=find(track_jday==jdays(m) & x>min(dlon) & x<max(dlon) & y>min(dlat) & y<max(dlat));
		d=find(track_jday==jdays(m));
		p=find(track_jday<=jdays(m));
		if k(d)==1
			m_plot(x(d),y(d),'o','markerfacecolor', ...
         	'c','markeredgecolor','c','markersize',5);
        else
        	m_plot(x(d),y(d),'o','markerfacecolor', ...
         	'k','markeredgecolor','k','markersize',3);
        end 	
		tmp_ids=id(d);
		time_ids=id(p);
		time_xs=x(p);
		time_ys=y(p);;
		for b=1:length(tmp_ids)
    		tmp=tmp_ids(b);
    		e=find(time_ids==tmp);
    		m_plot(time_xs(e),time_ys(e),'k', ...
              'linewidth',1);
		end
		%draw_domain(alon,alat)
		m_usercoast('gumby','patch','k');
		cc=colorbar;
		axes(cc)
		xlabel('cm')
		eval(['print -dpng -r300 frame_' num2str(ff) '.png'])
        
        %}
        figure(2);
        %set(gcf,'Resize','off')
        rect = get(gcf,'Position');
        rect(1:2) = [0 0];
		clf
        fr=gcf;
		m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);   
		m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick',[round(min_lat):lat_step:round(max_lat)],'tickdir','in','color','k','lineweight',1.5);  
		hold on
		m_pcolor(ilon,ilat,double(mdt))
		shading flat
		colormap(chelle)
        [cs,h]=m_contour(ilon,ilat,mdt,[-200:8:-3],'k--');
     	[cs,h]=m_contour(ilon,ilat,mdt,[3:8:200],'k');
        %return
		%h=streamline([verts averts]);
        %set(h,'color','k','linewidth',1)
		grid
		[year,month,day]=jd2jdate(jdays(m));
		title(['AVISO MDT  ' num2str(year) '-' num2str(month) '-' num2str(day) '   '])
		xlabel('contour interval 4 cm, starting at +/- 3cm')
		hold on
		ii=find(track_jday==jdays(m) & x>min(dlon) & x<max(dlon) & y>min(dlat) & y<max(dlat));
		d=find(track_jday==jdays(m));
		p=find(track_jday<=jdays(m));
		if k(d)==1
			m_plot(x(d),y(d),'o','markerfacecolor', ...
         	'c','markeredgecolor','c','markersize',5);
        else
        	m_plot(x(d),y(d),'o','markerfacecolor', ...
         	'k','markeredgecolor','k','markersize',5);
        end 	
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
		%draw_domain(alon,alat)
		m_usercoast('gumby','patch','k');
        caxis([-120 150])
		colormap(chelle)
		cc=colorbar;
		axes(cc)
		xlabel('cm')
        pause(.1)
        writeVideo(aviobj,getframe(fr,rect));
        %eval(['print -dpng -r300 frame_' num2str(ff) '.png'])
		
        %}
        ff=ff+1;
    end
    close(aviobj);

    
case {'geovel'}
	spath='/matlab/data/eddy/V5/mat/AVISO_25_W_';
	startjd=2448910;
	endjd=2454832;
	jdays=[startjd:7:endjd];
	load /matlab/matlab/domains/new_CC_lat_lon
	load /matlab/matlab/regions/tracks/tight/cc_tracks x y id cyc k track_jday
	alat=lat;
	alon=lon;
	dlon=lon;
	dlat=lat;
	dlat=min(lat)-2:max(lat)+2;
	dlon=min(lon)-10:max(lon)+0;
	max_lat=max(dlat(:)); 
	min_lat=min(dlat(:)); 
	max_lon=max(dlon(:)); 
	min_lon=min(dlon(:));
	lat_step=10;
	lon_step=20;
	load([spath '2454713'],'lat','lon')
	[r,c]=imap(min(dlat),max(dlat),min(dlon),max(dlon),lat,lon);
	%[r,c]=imap(-60,60,0,360,lat,lon);

	ilon=interp2(lon(r,c),2);
	ilat=interp2(lat(r,c),2);
	figure(1)
	clf
	m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);   
	m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick',[round(min_lat):lat_step:round(max_lat)],'tickdir','in','color','k','lineweight',1.5);  
	%m_gshhs_l('save','gumby');
	for m=1:length(jdays)
		load([spath num2str(jdays(m))],'ssh','u','v')
		cu=100*sqrt(u(r,c).^2+v(r,c).^2);
		spd=interp2(cu,2);
		ssh=interp2(ssh(r,c),2);
		figure(1)
		clf
		m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);   
		m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick',[round(min_lat):lat_step:round(max_lat)],'tickdir','in','color','k','lineweight',1.5);  
		hold on
		m_pcolor(ilon,ilat,double(spd))
		shading flat
		colormap(pgray)
		%[cs,h]=m_contour(ilon,ilat,ssh,[-200:4:-3],'k');
     	%[cs,h]=m_contour(ilon,ilat,ssh,[3:4:200],'k');
		caxis([0 20])
		grid
		[year,month,day]=jd2jdate(jdays(m));
		title([{'Eddies of the California Current System  '},{[num2str(day) '-' num2str(month) '-' num2str(year) '   ']}])
		xlabel Longitude
		ylabel Latitude
		%xlabel('contour interval 4 cm, starting at +/- 3cm')
		hold on
		ii=find(track_jday==jdays(m));
		uid=unique(id(ii));
		for b=1:length(uid)
    		jj=find(id==uid(b) & track_jday<=jdays(m));
    		if cyc(jj(1))==1
    			m_plot(x(jj),y(jj),'r','linewidth',2);
    			m_plot(x(jj(end)),y(jj(end)),'r.','markersize',15);	
    		else	
    			m_plot(x(jj),y(jj),'b','linewidth',2);
    			m_plot(x(jj(end)),y(jj(end)),'b.','markersize',15);
    		end
    	end	
		%m_usercoast('gumby','patch','k');
		m_coast('patch',[0 0 0]);
		%draw_domain(alon,alat);
		%cc=colorbar;
		%axes(cc)
		%xlabel('cm s^{-1}')
		%return
		eval(['print -dpng -r200 frame_' num2str(ff) '.png'])
		ff=ff+1;
		clear u v spd ssh
	end
	
	
	case {'ssh_and_chl'}
	load /matlab/data/gsm/mask
	spath='~/data/eddy/V5/mat/AVISO_25_W_';
	gpath='/matlab/data/gsm/mat/GSM_9_21_';
	load /matlab/data/eddy/V4/global_tracks_V4
	startjd=2450821;
	endjd=2454832;
	jdays=[startjd:7:endjd];
	load /matlab/matlab/domains/MAD_lat_lon

	alat=lat;
	alon=lon;
	dlon=lon;
	dlat=lat;
	%dlat=min(lat)-10:max(lat)+10;
	%dlon=min(lon)-10:max(lon)+10;
	max_lat=max(dlat(:)); 
	min_lat=min(dlat(:)); 
	max_lon=max(dlon(:)); 
	min_lon=min(dlon(:));
	lat_step=5;
	lon_step=20;
	load([gpath '2450821'],'glat','glon')
	load([spath '2454713'],'lat','lon')
	[r,c]=imap(min(dlat),max(dlat),min(dlon),max(dlon),lat,lon);
	[rg,cg]=imap(min(dlat),max(dlat),min(dlon),max(dlon),glat,glon);	
	%[r,c]=imap(-60,60,0,360,lat,lon);
	ii=find(x>min(dlon) & x<max(dlon) & y>min(dlat) & y<max(dlat));
	x=x(ii);
	y=y(ii);
	id=id(ii);
	k=k(ii);
	track_jday=track_jday(ii);
	ilon=interp2(lon(r,c),2);
	ilat=interp2(lat(r,c),2);
	figure(1)
	clf
	m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);   
	m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick',[round(min_lat):lat_step:round(max_lat)],'tickdir','in','color','k','lineweight',1.5);  
	m_gshhs_f('save','gumby');
	for m=30:length(jdays)
		load([spath num2str(jdays(m))],'ssh')
		load([gpath num2str(jdays(m))],'bp26_chl')
		ssh=interp2(ssh(r,c),2);
		figure(1)
		clf
		subplot(211)
		m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);   
		m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick',[round(min_lat):lat_step:round(max_lat)],'tickdir','in','color','k','lineweight',1.5);  
		hold on
		m_pcolor(ilon,ilat,double(ssh))
		shading flat
		colormap(chelle)
		[cs,h]=m_contour(ilon,ilat,ssh,[-200:2:-3],'k--');
     	[cs,h]=m_contour(ilon,ilat,ssh,[3:2:200],'k');
		caxis([-15 15])
		colormap(chelle)
		grid
		[year,month,day]=jd2jdate(jdays(m));
		title(['High-pass Filtered AVISO SSH  ' num2str(year) '-' num2str(month) '-' num2str(day) '   '])
		hold on
		ii=find(track_jday==jdays(m) & x>min(dlon) & x<max(dlon) & y>min(dlat) & y<max(dlat));
		d=find(track_jday==jdays(m));
		p=find(track_jday<=jdays(m));
		if k(d)==1
			m_plot(x(d),y(d),'o','markerfacecolor', ...
         	'c','markeredgecolor','c','markersize',5);
        else
        	m_plot(x(d),y(d),'o','markerfacecolor', ...
         	'k','markeredgecolor','k','markersize',3);
        end 	
		tmp_ids=id(d);
		time_ids=id(p);
		time_xs=x(p);
		time_ys=y(p);;
		for b=1:length(tmp_ids)
    		tmp=tmp_ids(b);
    		e=find(time_ids==tmp);
    		m_plot(time_xs(e),time_ys(e),'c', ...
              'linewidth',1);
		end
		draw_domain(alon,alat)
		m_usercoast('gumby','patch','k');
		cc=colorbar;
		axes(cc)
		xlabel('cm')
		
		subplot(212)
		m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);   
		m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick',[round(min_lat):lat_step:round(max_lat)],'tickdir','in','color','k','lineweight',1.5);  
		hold on
		m_pcolor(glon(rg,cg),glat(rg,cg),double(bp26_chl(rg,cg).*mask(rg,cg)))
		shading flat
		colormap(chelle)
		[cs,h]=m_contour(ilon,ilat,ssh,[-200:2:-3],'k--');
     	[cs,h]=m_contour(ilon,ilat,ssh,[3:2:200],'k');
		caxis([-.1 .1])
		colormap(chelle)
		grid
		[year,month,day]=jd2jdate(jdays(m));
		title(['Band-pass Filtered SeaWiFS CHL '])
		xlabel('contour interval 2cm, starting at +/- 3cm')
		hold on
		ii=find(track_jday==jdays(m) & x>min(dlon) & x<max(dlon) & y>min(dlat) & y<max(dlat));
		d=find(track_jday==jdays(m));
		p=find(track_jday<=jdays(m));
		draw_domain(alon,alat)
		m_usercoast('gumby','patch','k');
		cc=colorbar;
		axes(cc)
		xlabel('log_{10}(mg m^{-3})')
		eval(['print -dpng -r200 frame_' num2str(ff) '.png'])
		ff=ff+1;
	end
	

case {'ssh'}
	spath='~/data/eddy/V5/mat/AVISO_25_W_';
	load /matlab/data/eddy/V4/global_tracks_V4
	startjd=2448910;
	endjd=2454832;
	jdays=[startjd:7:endjd];
	load /matlab/matlab/domains/steve_lat_lon

	alat=lat;
	alon=lon;
	dlon=lon;
	dlat=lat;
	%dlat=min(lat)-10:max(lat)+10;
	%dlon=min(lon)-10:max(lon)+10;
	max_lat=max(dlat(:)); 
	min_lat=min(dlat(:)); 
	max_lon=max(dlon(:)); 
	min_lon=min(dlon(:));
	lat_step=5;
	lon_step=5;
	load([spath '2454713'],'lat','lon')
	[r,c]=imap(min(dlat),max(dlat),min(dlon),max(dlon),lat,lon);
	%[r,c]=imap(-60,60,0,360,lat,lon);
	ii=find(x>min(dlon) & x<max(dlon) & y>min(dlat) & y<max(dlat));
	x=x(ii);
	y=y(ii);
	id=id(ii);
	k=k(ii);
	track_jday=track_jday(ii);
	ilon=interp2(lon(r,c),2);
	ilat=interp2(lat(r,c),2);
	figure(1)
	clf
	m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);   
	m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick',[round(min_lat):lat_step:round(max_lat)],'tickdir','in','color','k','lineweight',1.5);  
	m_gshhs_f('save','gumby');
	for m=1:length(jdays)
		load([spath num2str(jdays(m))],'ssh')
		ssh=interp2(ssh(r,c),2);
		figure(1)
		clf
		m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);   
		m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick',[round(min_lat):lat_step:round(max_lat)],'tickdir','in','color','k','lineweight',1.5);  
		hold on
		m_pcolor(ilon,ilat,double(ssh))
		shading flat
		colormap(chelle)
		[cs,h]=m_contour(ilon,ilat,ssh,[-200:4:-3],'k');
     	[cs,h]=m_contour(ilon,ilat,ssh,[3:4:200],'k');
		caxis([-25 25])
		colormap(chelle)
		grid
		[year,month,day]=jd2jdate(jdays(m));
		title(['High-pass Filtered AVISO SSH  ' num2str(year) '-' num2str(month) '-' num2str(day) '   '])
		xlabel('contour interval 4 cm, starting at +/- 3cm')
		hold on
		ii=find(track_jday==jdays(m) & x>min(dlon) & x<max(dlon) & y>min(dlat) & y<max(dlat));
		d=find(track_jday==jdays(m));
		p=find(track_jday<=jdays(m));
		if k(d)==1
			m_plot(x(d),y(d),'o','markerfacecolor', ...
         	'c','markeredgecolor','c','markersize',5);
        else
        	m_plot(x(d),y(d),'o','markerfacecolor', ...
         	'k','markeredgecolor','k','markersize',3);
        end 	
		tmp_ids=id(d);
		time_ids=id(p);
		time_xs=x(p);
		time_ys=y(p);;
		for b=1:length(tmp_ids)
    		tmp=tmp_ids(b);
    		e=find(time_ids==tmp);
    		m_plot(time_xs(e),time_ys(e),'k', ...
              'linewidth',1);
		end
		m_text(8,-41,'*')
		draw_domain(alon,alat)
		m_usercoast('gumby','patch','k');
		cc=colorbar;
		axes(cc)
		xlabel('cm')
		eval(['print -dpng -r200 frame_' num2str(ff) '.png'])
		ff=ff+1;
	end
	
	
case {'upd2'}
	spath='/matlab/data/UPD/mat/UPD_25_W_';
	opath='~/data/eddy/V5/mat/AVISO_25_W_';
	
	load /matlab/data/UPD/upd_tracks
	startjd=2452550;
	endjd=2453642;
	jdays=[startjd:7:endjd];
	load /matlab/matlab/domains/EK_lat_lon
	alat=lat;
	alon=lon;
	dlat=min(lat)-10:max(lat)+10;
	dlon=min(lon)-10:max(lon)+10;
	max_lat=max(dlat(:)); 
	min_lat=min(dlat(:)); 
	max_lon=max(dlon(:)); 
	min_lon=min(dlon(:));
	lat_step=5;
	lon_step=10;
	load([spath '2453628'],'lat','lon')
	[r,c]=imap(min(dlat),max(dlat),min(dlon),max(dlon),lat,lon);
	%[r,c]=imap(-60,60,0,360,lat,lon);
	ii=find(x>min(dlon) & x<max(dlon) & y>min(dlat) & y<max(dlat));
	x=x(ii);
	y=y(ii);
	id=id(ii);
	k=k(ii);
	track_jday=track_jday(ii);
	ilon=interp2(lon(r,c),2);
	ilat=interp2(lat(r,c),2);
	figure(1)
	clf
	m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);   
	m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick',[round(min_lat):lat_step:round(max_lat)],'tickdir','in','color','k','lineweight',1.5);  
	m_gshhs_f('save','gumby');
	%[tout,lonout,latout]=get_topo(dlon,dlat);
	for m=1:length(jdays)
		load([spath num2str(jdays(m))],'crl','ssh')
		%ussh=interp2(ssh(r,c),2);
		ussh=ssh;
		ucrl=1e5*crl;
		load([opath num2str(jdays(m))],'crl','ssh')
		%ssh=interp2(ssh(r,c),2);
		crl=1e5*crl;
		dff_c=ucrl-crl;
		dff=ussh-ssh;
		figure(1)
		clf
		set(gcf,'color','k')
	    set(gcf, 'InvertHardCopy', 'off');
		m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);   
		m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick',[round(min_lat):lat_step:round(max_lat)],'tickdir','in','color','w','lineweight',1.5);  
		hold on
		m_pcolor(lon(r,c),lat(r,c),double(ussh(r,c)))
		shading interp
		colormap(chelle)
		%[cs,h]=m_contour(ilon,ilat,ssh,[-200:5:-5],'k');
     	%[cs,h]=m_contour(ilon,ilat,ssh,[5:5:200],'k');
		caxis([-25 25])
		grid
		[year,month,day]=jd2jdate(jdays(m));
		title(['High-pass filtered merged SSH ' num2str(year) '-' num2str(month) '-' num2str(day) '   '],'color','w')
		hold on
		ii=find(track_jday==jdays(m) & x>min(dlon) & x<max(dlon) & y>min(dlat) & y<max(dlat));
		d=find(track_jday==jdays(m));
		p=find(track_jday<=jdays(m));
		
		ddi=find(k(d)==1)
       	m_plot(x(d),y(d),'o','markerfacecolor', ...
        	'k','markeredgecolor','k','markersize',3);
		tmp_ids=id(d);
		time_ids=id(p);
		time_xs=x(p);
		time_ys=y(p);;
		for b=1:length(tmp_ids)
    		tmp=tmp_ids(b);
    		e=find(time_ids==tmp);
    		m_plot(time_xs(e),time_ys(e),'k', ...
              'linewidth',1);
		end
		%}
		%draw_domain(alon,alat)
		m_usercoast('gumby','patch','k');
		cc=colorbar;
		axes(cc)
		xlabel(['cm'],'color','w')
		set(cc,'xcolor','w','ycolor','w');
		niceplot
		eval(['print -dpng -r200 frame_' num2str(ff) '.png'])
		ff=ff+1;
		eval(['print -dpng -r200 frame_' num2str(ff) '.png'])
		ff=ff+1;
		eval(['print -dpng -r200 frame_' num2str(ff) '.png'])
		ff=ff+1;
		eval(['print -dpng -r200 frame_' num2str(ff) '.png'])
		ff=ff+1;
	end
	
case {'upd'}
	spath='/matlab/data/UPD/mat/UPD_25_W_';
	opath='~/data/eddy/V5/mat/AVISO_25_W_';
	
	load /matlab/data/UPD/upd_tracks
	startjd=2452550;
	endjd=2453642;
	jdays=[startjd:7:endjd];
	load /matlab/matlab/domains/EK_lat_lon
	alat=lat;
	alon=lon;
	dlon=60:150;
	dlat=-40:-20;
	%dlat=min(lat)-10:max(lat)+10;
	%dlon=min(lon)-10:max(lon)+10;
	max_lat=max(dlat(:)); 
	min_lat=min(dlat(:)); 
	max_lon=max(dlon(:)); 
	min_lon=min(dlon(:));
	lat_step=5;
	lon_step=20;
	load([spath '2453628'],'lat','lon')
	[r,c]=imap(min(dlat),max(dlat),min(dlon),max(dlon),lat,lon);
	%[r,c]=imap(-60,60,0,360,lat,lon);
	ii=find(x>min(dlon) & x<max(dlon) & y>min(dlat) & y<max(dlat));
	x=x(ii);
	y=y(ii);
	id=id(ii);
	k=k(ii);
	track_jday=track_jday(ii);
	ilon=interp2(lon(r,c),2);
	ilat=interp2(lat(r,c),2);
	figure(1)
	clf
	m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);   
	m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick',[round(min_lat):lat_step:round(max_lat)],'tickdir','in','color','k','lineweight',1.5);  
	m_gshhs_f('save','gumby');
	%[tout,lonout,latout]=get_topo(dlon,dlat);
	for m=1:length(jdays)
		load([spath num2str(jdays(m))],'crl','ssh')
		%ussh=interp2(ssh(r,c),2);
		ussh=ssh;
		ucrl=1e5*crl;
		load([opath num2str(jdays(m))],'crl','ssh')
		%ssh=interp2(ssh(r,c),2);
		crl=1e5*crl;
		dff_c=ucrl-crl;
		dff=ussh-ssh;
		figure(1)
		clf
		subplot(211)
		m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);   
		m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick',[round(min_lat):lat_step:round(max_lat)],'tickdir','in','color','k','lineweight',1.5);  
		hold on
		m_pcolor(lon(r,c),lat(r,c),double(ucrl(r,c)))
		shading flat
		colormap(chelle)
		%[cs,h]=m_contour(ilon,ilat,ssh,[-200:5:-5],'k');
     	%[cs,h]=m_contour(ilon,ilat,ssh,[5:5:200],'k');
		caxis([-2 2])
		grid
		[year,month,day]=jd2jdate(jdays(m));
		title(['High-pass filtered 4 altimeter merged \nabla \times u_g  ' num2str(year) '-' num2str(month) '-' num2str(day) '   '])
		hold on
		ii=find(track_jday==jdays(m) & x>min(dlon) & x<max(dlon) & y>min(dlat) & y<max(dlat));
		d=find(track_jday==jdays(m));
		p=find(track_jday<=jdays(m));
		%{
		ddi=find(k(d)==1)
       	m_plot(x(d),y(d),'o','markerfacecolor', ...
        	'k','markeredgecolor','k','markersize',3);
        m_plot(x(ddi),y(ddi),'o','markerfacecolor', ...
         	'c','markeredgecolor','c','markersize',5);	
		tmp_ids=id(d);
		time_ids=id(p);
		time_xs=x(p);
		time_ys=y(p);;
		for b=1:length(tmp_ids)
    		tmp=tmp_ids(b);
    		e=find(time_ids==tmp);
    		m_plot(time_xs(e),time_ys(e),'k', ...
              'linewidth',1);
		end
		%}
		%draw_domain(alon,alat)
		m_usercoast('gumby','patch','k');
		cc=colorbar;
		axes(cc)
		ylabel(['m s^{-1} per 100km'])
		
		%{
		subplot(211)
		m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);   
		m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick',[round(min_lat):lat_step:round(max_lat)],'tickdir','in','color','k','lineweight',1.5);  
		hold on
		m_pcolor(lon(r,c),lat(r,c),double(crl(r,c)))
		shading flat
		colormap(chelle)
		%[cs,h]=m_contour(ilon,ilat,ssh,[-200:5:-5],'k');
     	%[cs,h]=m_contour(ilon,ilat,ssh,[5:5:200],'k');
		caxis([-2 2])
		grid
		[year,month,day]=jd2jdate(jdays(m));
		title(['High-pass filtered 2 altimeter merged \nabla \times u_g  ' num2str(year) '-' num2str(month) '-' num2str(day) '   '])
		%xlabel('contour interval 5cm, starting at +/- 5cm')
		hold on
		ii=find(track_jday==jdays(m) & x>min(dlon) & x<max(dlon) & y>min(dlat) & y<max(dlat));
		d=find(track_jday==jdays(m));
		p=find(track_jday<=jdays(m));
		%{
		ddi=find(k(d)==1)
       	m_plot(x(d),y(d),'o','markerfacecolor', ...
        	'k','markeredgecolor','k','markersize',3);
        m_plot(x(ddi),y(ddi),'o','markerfacecolor', ...
         	'c','markeredgecolor','c','markersize',5);	
		tmp_ids=id(d);
		time_ids=id(p);
		time_xs=x(p);
		time_ys=y(p);;
		for b=1:length(tmp_ids)
    		tmp=tmp_ids(b);
    		e=find(time_ids==tmp);
    		m_plot(time_xs(e),time_ys(e),'k', ...
              'linewidth',1);
		end
		%}
		%draw_domain(alon,alat)
		m_usercoast('gumby','patch','k');
		%cc=colorbar;
		%axes(cc)
		%xlabel('cm')
		m_usercoast('gumby','patch','k');
		%}
		subplot(212)
		m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);   
		m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick',[round(min_lat):lat_step:round(max_lat)],'tickdir','in','color','k','lineweight',1.5);  
		hold on
		m_pcolor(lon(r,c),lat(r,c),double(dff(r,c)))
		shading flat
		colormap(chelle)
		[cs,h]=m_contour(lon(r,c),lat(r,c),ssh(r,c),[-200:5:-5],'k');
     	[cs,h]=m_contour(lon(r,c),lat(r,c),ssh(r,c),[5:5:200],'k');
		caxis([-5 5])
		grid
		[year,month,day]=jd2jdate(jdays(m));
		title(['Differance of SSH (UPD-REF)  ' num2str(year) '-' num2str(month) '-' num2str(day) '   '])
		xlabel('contour interval 5cm, starting at +/- 5cm')
		hold on
		ii=find(track_jday==jdays(m) & x>min(dlon) & x<max(dlon) & y>min(dlat) & y<max(dlat));
		d=find(track_jday==jdays(m));
		p=find(track_jday<=jdays(m));
		%{
		ddi=find(k(d)==1)
       	m_plot(x(d),y(d),'o','markerfacecolor', ...
        	'k','markeredgecolor','k','markersize',3);
        m_plot(x(ddi),y(ddi),'o','markerfacecolor', ...
         	'c','markeredgecolor','c','markersize',5);	
		tmp_ids=id(d);
		time_ids=id(p);
		time_xs=x(p);
		time_ys=y(p);;
		for b=1:length(tmp_ids)
    		tmp=tmp_ids(b);
    		e=find(time_ids==tmp);
    		m_plot(time_xs(e),time_ys(e),'k', ...
              'linewidth',1);
		end
		%}
		%draw_domain(alon,alat)
		m_usercoast('gumby','patch','k');
		cc=colorbar;
		axes(cc)
		xlabel('cm')
		eval(['print -dpng -r200 frame_' num2str(ff) '.png'])
		ff=ff+1;
		eval(['print -dpng -r200 frame_' num2str(ff) '.png'])
		ff=ff+1;
		eval(['print -dpng -r200 frame_' num2str(ff) '.png'])
		ff=ff+1;
		eval(['print -dpng -r200 frame_' num2str(ff) '.png'])
		ff=ff+1;
	end
	


case {'ssh_bath'}
	spath='~/data/eddy/V5/mat/AVISO_25_W_';
	load /matlab/data/eddy/V4/global_tracks_V4
	startjd=2448910;
	endjd=2454832;
	jdays=[startjd:7:endjd];
	load /matlab/matlab/domains/bearing_sea_lat_lon
	alat=lat;
	alon=lon;
	dlon=lon;
	dlat=lat;
	%dlat=min(lat)-10:max(lat)+10;
	%dlon=min(lon)-10:max(lon)+10;
	max_lat=max(dlat(:)); 
	min_lat=min(dlat(:)); 
	max_lon=max(dlon(:)); 
	min_lon=min(dlon(:));
	lat_step=2;
	lon_step=6;
	load([spath '2454713'],'lat','lon')
	[r,c]=imap(min(dlat),max(dlat),min(dlon),max(dlon),lat,lon);
	%[r,c]=imap(-60,60,0,360,lat,lon);
	ii=find(x>min(dlon) & x<max(dlon) & y>min(dlat) & y<max(dlat));
	x=x(ii);
	y=y(ii);
	id=id(ii);
	k=k(ii);
	track_jday=track_jday(ii);
	ilon=interp2(lon(r,c),2);
	ilat=interp2(lat(r,c),2);
	figure(1)
	clf
	m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);   
	m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick',[round(min_lat):lat_step:round(max_lat)],'tickdir','in','color','k','lineweight',1.5);  
	m_gshhs_f('save','gumby');
	[tout,lonout,latout]=get_topo(dlon,dlat);
	for m=1:length(jdays)
		load([spath num2str(jdays(m))],'ssh')
		ssh=interp2(ssh(r,c),2);
		figure(1)
		clf
		m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);   
		m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick',[round(min_lat):lat_step:round(max_lat)],'tickdir','in','color','k','lineweight',1.5);  
		hold on
		m_pcolor(ilon,ilat,double(ssh))
		shading flat
		colormap(chelle)
		[cs,h]=m_contour(ilon,ilat,ssh,[-200:2:-3],'k');
     	[cs,h]=m_contour(ilon,ilat,ssh,[3:2:200],'k');
     	m_contour(lonout,latout,tout,[-200 -200],'color',[.5 .5 .5],'linewidth',2);
		caxis([-15 15])
		colormap(rwp)
		grid
		[year,month,day]=jd2jdate(jdays(m));
		title(['High-pass Filtered AVISO SSH  ' num2str(year) '-' num2str(month) '-' num2str(day) '   '])
		xlabel('contour interval 2cm, starting at +/- 3cm')
		hold on
		ii=find(track_jday==jdays(m) & x>min(dlon) & x<max(dlon) & y>min(dlat) & y<max(dlat));
		d=find(track_jday==jdays(m));
		p=find(track_jday<=jdays(m));
		if k(d)==1
			m_plot(x(d),y(d),'o','markerfacecolor', ...
         	'c','markeredgecolor','c','markersize',5);
        else
        	m_plot(x(d),y(d),'o','markerfacecolor', ...
         	'k','markeredgecolor','k','markersize',3);
        end 	
		tmp_ids=id(d);
		time_ids=id(p);
		time_xs=x(p);
		time_ys=y(p);;
		for b=1:length(tmp_ids)
    		tmp=tmp_ids(b);
    		e=find(time_ids==tmp);
    		m_plot(time_xs(e),time_ys(e),'c', ...
              'linewidth',1);
		end
		draw_domain(alon,alat)
		m_usercoast('gumby','patch','k');
		cc=colorbar;
		axes(cc)
		xlabel('cm')
		eval(['print -dpng -r300 frame_' num2str(ff) '.png'])
		ff=ff+1;
	end
	
	
	
case {'ac'}
	spath='~/data/eddy/V5/mat/AVISO_25_W_';
	load /matlab/data/eddy/V4/global_tracks_V4
	startjd=2450884;
	endjd=2454832;
	jdays=[startjd:7:endjd];
	load /matlab/matlab/domains/EK_lat_lon
	alat=lat;
	alon=lon;
	dlon=lon;
	dlat=lat;
	%dlat=min(lat)-10:max(lat)+10;
	%dlon=min(lon)-10:max(lon)+10;
	max_lat=max(dlat(:)); 
	min_lat=min(dlat(:)); 
	max_lon=max(dlon(:)); 
	min_lon=min(dlon(:));
	lat_step=4;
	lon_step=8;
	load([spath '2454713'],'lat','lon')
	[r,c]=imap(min(dlat),max(dlat),min(dlon),max(dlon),lat,lon);
	%[r,c]=imap(-60,60,0,360,lat,lon);
	ii=find(x>min(dlon) & x<max(dlon) & y>min(dlat) & y<max(dlat));
	x=x(ii);
	y=y(ii);
	id=id(ii);
	k=k(ii);
	track_jday=track_jday(ii);
	ilon=interp2(lon(r,c),2);
	ilat=interp2(lat(r,c),2);
	figure(1)
	clf
	m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);   
	m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick',[round(min_lat):lat_step:round(max_lat)],'tickdir','in','color','k','lineweight',1.5);  
	m_gshhs_f('save','gumby');
	for m=1:length(jdays)
		load([spath num2str(jdays(m))],'ssh')
		ssh=interp2(ssh(r,c),2);
		mask=nan*ssh;
		mask(ssh>0)=1;
		figure(1)
		clf
		m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);   
		m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick',[round(min_lat):lat_step:round(max_lat)],'tickdir','in','color','k','lineweight',1.5);  
		hold on
		m_pcolor(ilon,ilat,double(ssh.*mask))
		shading flat
		colormap(chelle)
		[cs,h]=m_contour(ilon,ilat,ssh,[-200:3:-3],'k--');
     	[cs,h]=m_contour(ilon,ilat,ssh,[3:3:200],'k');
		caxis([-20 20])
		colormap(rwp)
		grid
		[year,month,day]=jd2jdate(jdays(m));
		title(['High-pass Filtered AVISO SSH  ' num2str(year) '-' num2str(month) '-' num2str(day) '   '])
		hold on
		ii=find(track_jday==jdays(m) & x>min(dlon) & x<max(dlon) & y>min(dlat) & y<max(dlat));
		d=find(track_jday==jdays(m));
		p=find(track_jday<=jdays(m));
		%{
		if k(d)==1
			m_plot(x(d),y(d),'o','markerfacecolor', ...
         	'c','markeredgecolor','c','markersize',5);
        else
        	m_plot(x(d),y(d),'o','markerfacecolor', ...
         	'k','markeredgecolor','k','markersize',3);
        end 	
		tmp_ids=id(d);
		time_ids=id(p);
		time_xs=x(p);
		time_ys=y(p);;
		for b=1:length(tmp_ids)
    		tmp=tmp_ids(b);
    		e=find(time_ids==tmp);
    		m_plot(time_xs(e),time_ys(e),'c', ...
              'linewidth',.1);
		end
		%}
		draw_domain(alon,alat)
		m_usercoast('gumby','patch','k');
		cc=colorbar;
		axes(cc)
		xlabel('cm')
		eval(['print -dpng -r150 frame_' num2str(ff) '.png'])
		ff=ff+1;
	end
	
	
	
	
case {'ssh_mld'}
	spath='~/data/eddy/V5/mat/AVISO_25_W_';
	mpath='/matlab/data/mld/mat/MLD_25_30_';
	jdays=[2450884:7:2454832];
	jdays=[2454244-14:7:2454244+600];
	load /matlab/matlab/domains/EK_lat_lon
	dlat=lat;
	dlon=lon;
	load([spath '2454713'],'lat','lon')
	lat=lat(41:600,:);
	lon=lon(41:600,:);
	[r,c]=imap(min(dlat),max(dlat),min(dlon),max(dlon),lat,lon);
	%[r,c]=imap(-60,60,0,360,lat,lon);
	for m=1:length(jdays)
		load([spath num2str(jdays(m))],'ssh')
		load([mpath num2str(jdays(m))],'bp21_mld')
		mld_week=cat(1,nan(40,1440),bp21_mld,nan(40,1440));	
		mld=mld_week(81:640,:);
		ssh=ssh(41:600,:);
		figure(1)
		clf
		pmap(lon(r,c),lat(r,c),mld(r,c))
		caxis([-20 20])
		[year,month,day]=jd2jdate(jdays(m));
		title(['High-pass Filtered MLD overlaid with AVISO SSH  ' num2str(year) '-' num2str(month) '-' num2str(day) '   '])
		hold on
		m_contour(lon(r,c),lat(r,c),ssh(r,c),[-20:3:-3],'k--')
		m_contour(lon(r,c),lat(r,c),ssh(r,c),[3:3:20],'k')
		eval(['print -dpsc -r300 frame_' num2str(ff) '.png'])
       	eval(['!convert -trim frame_' num2str(ff) '.png frame_' num2str(ff) ...
              '.png'])
       	ff=ff+1;
	end
	
	
case {'crlg'}
	spath='/Volumes~/data/eddy/V5/mat/AVISO_25_W_';
	load([spath '2454713'],'lat','lon')
	jdays=[2451395:7:2454811];
	jdays=[2454244-14:7:2454244+600];
	load /Volumes/matlab/matlab/domains/SOUTH_INDIAN_ATL_PAC_lat_lon
	[r,c]=imap(min(lat),max(lat),min(lon),max(lon),glat,glon);
	[r,c]=imap(-60,60,0,360,lat,lon);
	for m=1:length(jdays)
		load([spath num2str(jdays(m))],'hp66_crlg')
		figure(1)
		clf
		pmap(lon(r,c),lat(r,c),1e5*hp66_crlg(r,c))
		caxis([-1 1])
		[year,month,day]=jd2jdate(jdays(m));
		title(['25km AVISO crl_g 6x6  ' num2str(year) '-' num2str(month) '-' num2str(day) '   '])
		colormap(chelle)
		m_plot(97,-26,'k+','linewidth',5)
   		eval(['print -dpsc -r300 frame_' num2str(ff) '.png'])
       	eval(['!convert -trim frame_' num2str(ff) '.png frame_' num2str(ff) ...
              '.png'])
       	ff=ff+1;
	end
	
	
	
case {'ssh'}
	spath='~/data/eddy/V5/mat/AVISO_25_W_';
	load /matlab/data/eddy/V4/global_tracks_V4
	startjd=2450884;
	endjd=2454832;
	jdays=[startjd:7:endjd];
	load /matlab/matlab/domains/bearing_sea_lat_lon
	alat=lat;
	alon=lon;
	dlon=lon;
	dlat=lat;
	%dlat=min(lat)-10:max(lat)+10;
	%dlon=min(lon)-10:max(lon)+10;
	max_lat=max(dlat(:)); 
	min_lat=min(dlat(:)); 
	max_lon=max(dlon(:)); 
	min_lon=min(dlon(:));
	lat_step=4;
	lon_step=8;
	load([spath '2454713'],'lat','lon')
	[r,c]=imap(min(dlat),max(dlat),min(dlon),max(dlon),lat,lon);
	%[r,c]=imap(-60,60,0,360,lat,lon);
	ii=find(x>min(dlon) & x<max(dlon) & y>min(dlat) & y<max(dlat));
	x=x(ii);
	y=y(ii);
	id=id(ii);
	k=k(ii);
	track_jday=track_jday(ii);
	ilon=interp2(lon(r,c),2);
	ilat=interp2(lat(r,c),2);
	figure(1)
	clf
	m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);   
	m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick',[round(min_lat):lat_step:round(max_lat)],'tickdir','in','color','k','lineweight',1.5);  
	m_gshhs_f('save','gumby');
	for m=1:length(jdays)
		load([spath num2str(jdays(m))],'ssh')
		ssh=interp2(ssh(r,c),2);
		figure(1)
		clf
		m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);   
		m_grid('xtick',[round(min_lon):lon_step:round(max_lon)],'ytick',[round(min_lat):lat_step:round(max_lat)],'tickdir','in','color','k','lineweight',1.5);  
		hold on
		m_pcolor(ilon,ilat,double(ssh))
		shading flat
		colormap(chelle)
		[cs,h]=m_contour(ilon,ilat,ssh,[-200:2:-3],'k--');
     	[cs,h]=m_contour(ilon,ilat,ssh,[3:2:200],'k');
		caxis([-15 15])
		colormap(rwp)
		grid
		[year,month,day]=jd2jdate(jdays(m));
		title(['High-pass Filtered AVISO SSH  ' num2str(year) '-' num2str(month) '-' num2str(day) '   '])
		xlabel('contour interval 2cm')
		hold on
		ii=find(track_jday==jdays(m) & x>min(dlon) & x<max(dlon) & y>min(dlat) & y<max(dlat));
		d=find(track_jday==jdays(m));
		p=find(track_jday<=jdays(m));
		if k(d)==1
			m_plot(x(d),y(d),'o','markerfacecolor', ...
         	'c','markeredgecolor','c','markersize',5);
        else
        	m_plot(x(d),y(d),'o','markerfacecolor', ...
         	'k','markeredgecolor','k','markersize',3);
        end 	
		tmp_ids=id(d);
		time_ids=id(p);
		time_xs=x(p);
		time_ys=y(p);;
		for b=1:length(tmp_ids)
    		tmp=tmp_ids(b);
    		e=find(time_ids==tmp);
    		m_plot(time_xs(e),time_ys(e),'c', ...
              'linewidth',.1);
		end
		draw_domain(alon,alat)
		m_usercoast('gumby','patch','k');
		cc=colorbar;
		axes(cc)
		xlabel('cm')
		eval(['print -dpng -r100 frame_' num2str(ff) '.png'])
		ff=ff+1;
	end
	
	
	
case {'chl_ssh'}
ff=1;
jdays=[2452459:7:2454489];

warning('off','all')
figure(1)
load /matlab/matlab/domains/EK_lat_lon.mat
load /matlab/data/gsm/mask
max_lat=max(lat(:));
min_lat=min(lat(:));
max_lon=max(lon(:));
min_lon=min(lon(:));
load ~/data/eddy/V5/mat/AVISO_25_W_2453530 lat lon
slon=lon;
slat=lat;
rssh=find(slat(:,1)>=min_lat & slat(:,1)<=max_lat);
cssh=find(slon(1,:)>=min_lon & slon(1,:)<=max_lon);
load /matlab/data/gsm/mat/GSM_9_21_2452459 glat glon bp26_chl
clat=glat;
clon=glon;
rchl=find(clat(:,1)>=min_lat & clat(:,1)<=max_lat);
cchl=find(clon(1,:)>=min_lon & clon(1,:)<=max_lon);

for m=1:length(jdays)
clf
subplot(211)
[yea,mon,day]=jd2jdate(jdays(m));
dd=(yea*1000)+julian(mon,day,yea,yea)

load(['/matlab/data/gsm/mat/GSM_9_21_',num2str(jdays(m))],'bp26_chl','sm_gchl_week')
load(['~/data/eddy/V5/mat/AVISO_25_W_',num2str(jdays(m))],'ssh')
pmap(clon(rchl,cchl),clat(rchl,cchl),sm_gchl_week(rchl,cchl))
title(['SeaWiFS Chl overlaid with SSH contours  ' num2str(yea) '-' num2str(mon) '-' num2str(day) '  '])
hold on
m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[-80:4:-2],'w')
m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[2:4:80],'k')
c=colorbar;
colormap(chelle)
caxis([-1.5 -.5])
Tick=[.04 .06 .1 .2 .3 .5 1 7];


subplot(212)
%pmap(clon(rchl,cchl),clat(rchl,cchl),bp26_chl(rchl,cchl))
pmap(clon(rchl,cchl),clat(rchl,cchl),bp26_chl(rchl,cchl).*mask(rchl,cchl))
title(['Filtered SeaWiFS Chl overlaid with SSH contours  '])
hold on
m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[-80:4:-2],'w')
m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[2:4:80],'k')
cc=colorbar;
colormap(chelle)
caxis([-.1 .1])
axes(cc);
xlabel({'','log_{10} (mg m^{-3})'})
axes(c);
set(c,'YTick',log10(Tick),'YTickLabel',Tick);
xlabel('mg m^{-3}')

eval(['print -dpng -r300 frame_' num2str(ff) '.png'])
%eval(['!convert -trim frame_' num2str(ff) '.png frame_' num2str(ff) ...
%      '.png'])
ff=ff+1;
end

case {'gchl_ssh'}
ff=1;
jdays=[2450821:7:2454804];

warning('off','all')
figure(1)
load /Volumes/matlab/matlab/domains/LW_lat_lon.mat
max_lat=max(lat(:));
min_lat=min(lat(:));
max_lon=max(lon(:));
min_lon=min(lon(:));
load /Volumes~/data/eddy/V5/mat/AVISO_25_W_2453530 lat lon
slon=lon;
slat=lat;
rssh=find(slat(:,1)>=min_lat & slat(:,1)<=max_lat);
cssh=find(slon(1,:)>=min_lon & slon(1,:)<=max_lon);
load /Volumes/data2/data/seawifs/mat/SCHL_4_W_2452459 glat glon gchl_anom
clat=glat;
clon=glon;
rchl=find(clat(:,1)>=min_lat & clat(:,1)<=max_lat);
cchl=find(clon(1,:)>=min_lon & clon(1,:)<=max_lon);
load /Volumes/matlab/data/QuickScat/mat/QSCAT_21_25km_2452606 lat lon hp66_crl_21
[lon,lat]=meshgrid(lon,lat);
lat=interp2(lat);
lon=interp2(lon);
r=find(lat(:,1)>=min_lat & lat(:,1)<=max_lat);
c=find(lon(1,:)>=min_lon & lon(1,:)<=max_lon);




for m=3:length(jdays)
clf
[yea,mon,day]=jd2jdate(jdays(m));
dd=(yea*1000)+julian(mon,day,yea,yea)

load(['/Volumes/data2/data/seawifs/mat/SCHL_4_W_',num2str(jdays(m))],'gchl_week')
load(['/Volumes~/data/eddy/V5/mat/AVISO_25_W_',num2str(jdays(m))],'mask','hp66_crlg','ssh')
pmap(clon(rchl,cchl),clat(rchl,cchl),gchl_week(rchl,cchl),'logmchl')
title(['SeaWiFS Chl overlaid with SSH contours  ' num2str(yea) '-' num2str(mon) '-' num2str(day) '  '])
hold on
m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[-80:4:-2],'w')
m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[2:4:80],'k')
c=colorbar('horiz');
Tick=[.04 .1 .5 1 7];
axes(c);
set(c,'position',[.15 .01 .74 .01],'XTick',log10(Tick),...
    'XTickLabel', Tick,'xcolor','w','ycolor','w');
xlabel('mg m^{-3}','color','w')
shading flat
m_coast('patch',[0 0 0],'edgecolor','k');


eval(['print -dpng frame_' num2str(ff) '.png'])
%eval(['!convert -trim frame_' num2str(ff) '.png frame_' num2str(ff) ...
%      '.png'])
ff=ff+1;
end

case {'oi_foi'}
warning('off','all')
figure(1)
load /Volumes/matlab/matlab/domains/GS_lat_lon.mat
max_lat=max(lat(:));
min_lat=min(lat(:));
max_lon=max(lon(:));
min_lon=min(lon(:));
load /Volumes/matlab/data/ReynoldsSST/mat/OI_25_W_2452459 lat lon mid_week_jdays
r=find(lat(:,1)>=min_lat & lat(:,1)<=max_lat);
c=find(lon(1,:)>=min_lon & lon(1,:)<=max_lon);
load /Volumes/matlab/data/eddy/V3/mat/AVISO_25_W_2452459 lat lon
slat=lat;
slon=lon;
rssh=find(slat(:,1)>=min_lat & slat(:,1)<=max_lat);
cssh=find(slon(1,:)>=min_lon & slon(1,:)<=max_lon);

for m=1:length(mid_week_jdays)
clf
[yea,mon,day]=jd2jdate(mid_week_jdays(m));
dd=(yea*1000)+julian(mon,day,yea,yea)
load(['/Volumes/matlab/data/ReynoldsSST/mat/OI_25_W_',num2str(mid_week_jdays(m))])
load(['/Volumes/matlab/data/eddy/V3/mat/AVISO_25_W_',num2str(mid_week_jdays(m))],'mask','ssh')
subplot(121)
%cstep = (length(jet)-1)/(26-15);
%X1 = round((sst_oi(r,c)+26)*cstep+1);
%X1(X1>256)=256;
%X1(X1<1)=1;
pmap(lon(r,c),lat(r,c),sst_oi(r,c),'oi',num2str(dd))
caxis([15 29])
title(['OI SST ' num2str(dd) '  '])
hold on
m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[-80:4:-2],'color', [.5 .5 .5])
m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[2:4:80],'k')
shading interp
m_coast('patch',[0 0 0],'edgecolor','k');

subplot(122)
cstep = (length(rwp)-1)/(26-15);
%Xtmp  = round((filtered_sst_oi(r,c)+26)*cstep+1)
%Xtmp(Xtmp>256)=256;
%Xtmp(X1<1)=1;
%X2=Xtmp+256;
pmap(lon(r,c),lat(r,c),filtered_sst_oi(r,c),'oihp',num2str(dd))
title(['HP Filtered OI SST ' num2str(dd) '  '])
%ax = findobj(gcf,'Type','axes');
%set(ax,'CLim', [min(X1(:)) max(X2(:))])
colormap(chelle)
hold on
load(['/Volumes/matlab/data/eddy/V3/mat/AVISO_25_W_',num2str(mid_week_jdays(m))])
m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[-80:4:-2],'color', [.5 .5 .5])
m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[2:4:80],'k')
shading interp
m_coast('patch',[0 0 0],'edgecolor','k');

eval(['print -dpng frame_' num2str(ff) '.png'])
eval(['!convert -trim frame_' num2str(ff) '.png frame_' num2str(ff) ...
      '.png'])
ff=ff+1;
end


case {'ssh_trans_box_tracks'}
warning('off','all')
figure(1)
max_lat=max(lat(:));
min_lat=min(lat(:));
max_lon=max(lon(:));
min_lon=min(lon(:));

unid = unique(id);
for ee=1:length(unid)
	itid=find(id==unid(ee));
	tid=id(itid);
	for n=1:length(tid)
	pp=find(jdays==track_jday(itid(n)));
	if any(pp)
	r=find(lat(:,1)>=y(itid(n))-3 & lat(:,1)<=y(itid(n))+3);
	c=find(lon(1,:)>=x(itid(n))-3 & lon(1,:)<=x(itid(n))+3);
	if length(r)>20 & length(c)>20
		clf
		[yea,mon,day]=jd2jdate(jdays(pp));
		dd=(yea*1000)+julian(mon,day,yea,yea)
		pmap(lon(r,c),lat(r,c),filtered_ssh(r,c,pp),'hpssh_med',num2str(dd))
		hold on
		m_contour(lon(r,c),lat(r,c),filtered_ssh(r,c,pp),[-40:-1],'k--')
		m_contour(lon(r,c),lat(r,c),filtered_ssh(r,c,pp),[1:40],'k')
		xlabel(['ID = ', num2str(id(itid(n))), '  k = ',num2str(k(itid(n))), ' of ' , num2str(max(k(itid)))...
				'  \theta = ',num2str(theta(itid(n))),'  tflag = ',num2str(tflag(ee))])
		d=find(track_jday(itid)==jdays(pp));
		p=find(track_jday(itid)<=jdays(pp));
		h=m_plot(x(itid(d)),y(itid(d)),'ko','markerfacecolor', ...
         			'k','markersize',4);
		tmp_ids=id(itid(d));
		time_ids=id(itid(p));
		time_xs=x(itid(p));
		time_ys=y(itid(p));
		for b=1:length(tmp_ids)
  		  	tmp=tmp_ids(b);
   		 	e=find(time_ids==tmp);
   		 	h=m_plot(time_xs(e),time_ys(e),'k', ...
              		'linewidth',2);
    		set(h,'clipping','off')
		end

		eval(['print -dpng frame_' num2str(ff) '.png'])
		eval(['!convert -trim frame_' num2str(ff) '.png frame_' num2str(ff) ...
      			'.png'])
		ff=ff+1;
		else 
		end
		end
	end	
end


case {'ssh_tracks_contours'}
warning('off','all')
figure(1)
load /Volumes~/data/eddy/V5/mat/AVISO_25_W_2454433.mat
slat=lat;
slon=lon;
jdays=[2451395:7:2454811];
load /Volumes/matlab/matlab/domains/TROPAC_lat_lon.mat
max_lat=max(lat(:));
min_lat=min(lat(:));
max_lon=max(lon(:));
min_lon=min(lon(:));
r=find(slat(:,1)>=min_lat & slat(:,1)<=max_lat);
c=find(slon(1,:)>=min_lon & slon(1,:)<=max_lon);
load /Volumes/matlab/matlab/eddy-wind/indian_tracks.mat


for m=1:length(jdays)
clf
[yea,mon,day]=jd2jdate(jdays(m));
dd=(yea*1000)+julian(mon,day,yea,yea)
load(['/Volumes~/data/eddy/V5/mat/AVISO_25_W_',num2str(jdays(m)), '.mat'],'ssh','lon','lat')
pmap(slon(r,c),slat(r,c),ssh(r,c))
caxis([-20 20])
[year,month,day]=jd2jdate(jdays(m));
title(['High-pass Filtered AVISO SSH  ' num2str(year) '-' num2str(month) '-' num2str(day) '   '])
hold on
%m_plot(97,-26,'k*','linewidth',10)
%m_text(93,-24,'26S, 97E','fontsize',15)
m_contour(slon(r,c),slat(r,c),ssh(r,c),[-40:5:-5],'k--')
m_contour(slon(r,c),slat(r,c),ssh(r,c),[5:5:40],'k')
%m_line([0 360],[0 0])
d=find(track_jday==jdays(m));
p=find(track_jday<=jdays(m));
m_plot(x(d),y(d),'o','markerfacecolor', ...
         'k','markeredgecolor','k','markersize',3);
%m_text(x(d),y(d),num2str(id(d)),'fontsize',12)
tmp_ids=id(d);
time_ids=id(p);
time_xs=x(p);
time_ys=y(p);;
for b=1:length(tmp_ids)
    tmp=tmp_ids(b);
    e=find(time_ids==tmp);
    m_plot(time_xs(e),time_ys(e),'k', ...
              'linewidth',.7);
end
eval(['print -dpng frame_' num2str(ff) '.png'])
eval(['!convert -trim frame_' num2str(ff) '.png frame_' num2str(ff) ...
      '.png'])
ff=ff+1;
end


case {'track_imet_ssh_id'}

        
        load /Volumes/matlab/matlab/domains/VOCALS_REx_lat_lon
        max_lat=max(lat(:));
   		min_lat=min(lat(:));
   		max_lon=max(lon(:));
   		min_lon=min(lon(:));
   		load /Volumes/matlab/matlab/VOCALS/ssh_ls_filtered
        load /Volumes/matlab/matlab/VOCALS/eddies_v2_vocals_rex_all
        load /Volumes/matlab/matlab/IMET/imet_temperature g_* imet_jdays imet_ids
        min_jday=min(imet_jdays);
        max_jday=max(imet_jdays);
        match_time=find(jdays>= min_jday & jdays<=max_jday);
        r=find(lat(:,1)>=min_lat & lat(:,1)<=max_lat);
        c=find(lon(1,:)>=min_lon & lon(1,:)<=max_lon);
        lat=lat(r,c);
        lon=lon(r,c);
        filtered_ssh=filtered_ssh(r,c,match_time);
        jdays=jdays(match_time);
       	fr = sames(imet_ids,id);
        x=x(fr);
        y=y(fr);
        track_jday=track_jday(fr);
        id=id(fr);
        fl=find(x>=min_lon & x<=max_lon & y>=min_lat & y<=max_lat);
        x=x(fl);
        y=y(fl);
        track_jday=track_jday(fl);
        id=id(fl);
        
        for m=1:length(jdays)
            proccesing_frame=ff
            clf;
            cla;
            [year,month,day] = jd2jdate(jdays(m));
            dlabel = [num2str(month) '-' num2str(day) '-' num2str(year)];
            subplot(211)
            m_proj('Miller Cylindrical','lon',[min_lon ...
                     max_lon],'lat',[min_lat max_lat]);
            m_pcolor(lon,lat,filtered_ssh(:,:,m));
            shading interp;
            colormap(chelle)
            hold on
            m_grid('xtick',[round(min_lon):10:round(max_lon)], ...
                   'ytick',[round(min_lat): ...
                            5:round(max_lat)],'tickdir','out', ...
                   'color','k');
            caxis([-10 10]);
            m_contour(lon,lat,filtered_ssh(:,:,m),[-10:2:-2],'k');
            m_contour(lon,lat,filtered_ssh(:,:,m),[2:2:10],'k');
            m_coast('patch',[0 0 0],'edgecolor','k');
            m_plot(274.8500,-20.15,'k*','markersize',10);
            title({'AVISO Merged Filtered SSH',dlabel});
            d=find(track_jday==jdays(m));
            p=find(track_jday<=jdays(m));
            m_plot(x(d),y(d),'ko','markerfacecolor', ...
                   'k','markersize',2,'clip','off');
            %m_text(x(d),y(d),num2str(id(d)));
            tmp_ids=id(d);
            time_ids=id(p);
            time_xs=x(p);
            time_ys=y(p);
                    for b=1:length(tmp_ids)
                        tmp=tmp_ids(b);
                        e=find(time_ids==tmp);
                        if tmp>96005
                            m_plot(time_xs(e),time_ys(e),'k-.', ...
                                   'linewidth',.5,'clip','off');
                        else
                             m_plot(time_xs(e),time_ys(e), ...
                                     'k','linewidth',.5,'clip','off');
                        end
                    end
%             c=colorbar('horiz');
%             axes(c);
%        	 set(c,'position',[.33 .49 .38 .04]);
%        	 xlabel('cm');
%             m_text(288,-27,'Contour range [-10:2:2][2:2:10] cm   ','fontsize',10);
%             m_text(288,-27.5,'Negative contours dashed   ','fontsize',10);
            hold off
            subplot(212)
         	o=find(imet_jdays<=jdays(m));
         	p=find(imet_jdays==jdays(m));
            pcolor(imet_jdays(o),-g_depth,g_temp_1d(:,o));
		    axis([2452428     2454023        -450           0])
		    set(gca,'xtick',[2452428:200:2454023],'xticklabel','',...
		    		'tickdir','in','layer','top','clipping','off')
		    rotateticklabel(gca,90);	
		    shading interp
		   	title({'Temperature from IMET Mooring',num2str(imet_jdays(p))})
		   	%xlabel('Time (jdays)')
		   	ylabel('Depth')
		   	c=colorbar;
		   	axes(c)
		   	ylabel('C')
		    eval(['print -dpng frame_' num2str(ff)]);
            ff = ff+1;
 end





case {'track_ssh_id'}
%load tracks
load /Volumes/matlab/matlab/domains/EK_lat_lon
max_lat=max(lat(:));
min_lat=min(lat(:));
max_lon=max(lon(:));
min_lon=min(lon(:));
load /Volumes/matlab/matlab/eddy-wind/tracks/EK_lat_lon_tracks_16_weeks
ssh_path='/Volumes/matlab/data/eddy/V4/mat/';
%jdays=min(track_jday):7:max(track_jday);
jdays=2451822-(60*7):7:2452578;
load([ssh_path 'AVISO_25_W_2454475'])
r=find(lat(:,1)>=min_lat & lat(:,1)<=max_lat);
c=find(lon(1,:)>=min_lon & lon(1,:)<=max_lon);

        
        for m=1:length(jdays)
            
            clf;
            cla;
            [yea,mon,day]=jd2jdate(jdays(m));
			dd=(yea*1000)+julian(mon,day,yea,yea);
            load([ssh_path 'AVISO_25_W_' num2str(jdays(m))],'ssh','mask' )
            data=ssh(r,c).*mask(r,c);
            pmap(lon(r,c),lat(r,c),data,'hpssh',num2str(dd))
            caxis([-20 20])
            hold on
            p=find(track_jday<=jdays(m));
            d=find(track_jday==jdays(m));
            m_plot(x(d),y(d),'ko','markerfacecolor', ...
                   'k','markersize',4,'clip','off');
            m_text(x(d),y(d),num2str(id(d)),'fontsize',10);
            tmp_ids=id(d);
            time_ids=id(p);
            time_xs=x(p);
            time_ys=y(p);
                    for b=1:length(tmp_ids)
                        tmp=tmp_ids(b);
                        e=find(time_ids==tmp);
                        if tmp>=nneg
                            h=m_plot(time_xs(e),time_ys(e),'k','linewidth',2);
                            set(h,'clipping','off')
                        else
                             h=m_plot(time_xs(e),time_ys(e),'k','linewidth',2);
                             set(h,'clipping','off')
                        end
                    end
             hold off
            eval(['print -dpng frame_' num2str(ff) '.png']) 
            %eval(['!convert -trim frame_' num2str(ff) '.png frame_' num2str(ff) ...
      	    % 		'.png'])
             ff = ff+1;
 end

case {'ssh_comp'}
load /Volumes/matlab/matlab/VOCALS/ams_talk/aviso_ssh_2007 alat alon filtered_ssh yearday
load /Volumes/matlab/matlab/VOCALS/ams_talk/nrt_ssh_2007 nrt_week_filtered nlat nlon

max_lat=max(alat(:)); 
min_lat=min(alat(:)); 
max_lon=max(alon(:)); 
min_lon=min(alon(:));

m=1

    for d=1:length(yearday)
        figure(1)
        clf
        subplot(211)
		m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);  
		m_pcolor(alon,alat,filtered_ssh(:,:,d)); 
		colormap(chelle);
		m_grid('xtick',[round(min_lon):5:round(max_lon)],'ytick',[round(min_lat):3:round(max_lat)],'tickdir','out','color','k');  
		shading flat 
		hold on
     	caxis([-15 15]);
        h=m_contour(alon,alat,filtered_ssh(:,:,d),[-10:2:-2],'k--');
        [cs,h]=m_contour(alon,alat,filtered_ssh(:,:,d),[2:2:10],'k');
        c=colorbar;
		m_coast('patch',[0 0 0],'edgecolor','k','EraseMode','background');    	
		grid
     	title({'HP Filtered SSH from AVISO Merged T/P and Jason-1','7 Day Composite Centered on',num2str(yearday(m))});
     	axes(c)
     	set(c,'yaxislocation','right')
     	ylabel('cm')
        subplot(212)
		m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);  
		m_pcolor(nlon,nlat,nrt_week_filtered(:,:,d)); 
		colormap(chelle);
		m_grid('xtick',[round(min_lon):5:round(max_lon)],'ytick',[round(min_lat):3:round(max_lat)],'tickdir','out','color','k');  
		shading flat 
		hold on
     	caxis([-15 15]);
        m_contour(nlon,nlat,nrt_week_filtered(:,:,d),[-10:2:-2],'k--');
        m_contour(nlon,nlat,nrt_week_filtered(:,:,d),[2:2:10],'k');
        c=colorbar;
		m_coast('patch',[0 0 0],'edgecolor','k','EraseMode','background');    	
		grid
     	title({'HP Filtered SSH from CCAR Near Real-Time Altimetry','7 Day Composite Centered on',num2str(yearday(m))});
     	axes(c)
     	set(c,'yaxislocation','right')
     	ylabel('cm')
     	axis image
     	land
     	print -dpsc temp.ps
     	!sed 's/6 dpi2point mul] 0 setdash/2 dpi2point mul] 0 setdash/' temp.ps > tmp.ps
        eval(['!cp tmp.ps ' num2str(frame) '.ps']);
        eval(['!convert -quality 100 '...
              num2str(frame) '.ps frame_' num2str(frame) '.pdf']);
        eval(['!toast ' num2str(frame) '.ps']);
        frame = frame+1;
        m=m+1;
    end
    
    
    case {'tracks_f_over_h'}


        load /Volumes/matlab/matlab/VOCALS/topo_vocals_rex
        load /Volumes/matlab/matlab/VOCALS/eddies_v2_vocals_rex_all
        load /Volumes/matlab/matlab/domains/VOCALS_REx_lat_lon
                
       	max_lat=max(lat(:));
        min_lat=min(lat(:));
        max_lon=max(lon(:));
        min_lon=min(lon(:));
        
        jdays=min(track_jday):7:max(track_jday);
        for m=1:length(jdays)
            figure(1)
            proccesing_frame=frame-99
            clf;
            cla;
            colormap(chelle)
            [year,month,day] = jd2jdate(jdays(m));
            dlabel = [num2str(month) '-' num2str(day) '-' num2str(year)];
            m_proj('Miller Cylindrical','lon',[min_lon ...
                     max_lon],'lat',[min_lat max_lat]);
            hold on
            m_contour(LON_topo,LAT_topo,ff./TOPO,[6e-9:1e-9:1.5e-8],'k')
            m_grid('xtick',[round(min_lon):5:round(max_lon)], ...
                   'ytick',[round(min_lat): ...
                            3:round(max_lat)],'tickdir','out', ...
                   'color','k');
           
            m_coast('patch',[0 0 0],'edgecolor','k','EraseMode','background');
            title({'f/h with Eddy Tracks',dlabel});
            d=find(track_jday==jdays(m));
            p=find(track_jday<=jdays(m));
            m_plot(x(d),y(d),'ko','markerfacecolor', ...
                   'g','markersize',2,'clip','off');
            m_text(x(d),y(d),num2str(id(d)));
            tmp_ids=id(d);
            time_ids=id(p);
            time_xs=x(p);
            time_ys=y(p);
                    for b=1:length(tmp_ids)
                        tmp=tmp_ids(b);
                        e=find(time_ids==tmp);
                        if tmp>96005
                            m_plot(time_xs(e),time_ys(e),'r', ...
                                   'linewidth',.5,'clip','off');
                        else
                             m_plot(time_xs(e),time_ys(e), ...
                                     'b','linewidth',.5,'clip','off');
                        end
                    end
%             c=colorbar('horiz');
%             axes(c);
%        	 set(c,'position',[.33 .49 .38 .04]);
%        	 xlabel('cm');
             hold off
            land
		    print -dpsc temp.ps
             !sed 's/6 dpi2point mul] 0 setdash/3 dpi2point mul] 0 setdash/' temp.ps > tmp.ps
             eval(['!cp tmp.ps ' num2str(frame) '.ps']);
             eval(['!convert -density 150x150 ' ...
             num2str(frame) '.ps frame_' num2str(frame) '.pdf']);
             eval(['!toast ' num2str(frame) '.ps']);
             frame = frame+1;
 end



case {'track_ssh'}
%load tracks
load /Volumes/matlab/matlab/domains/CC_lat_lon
max_lat=max(lat(:));
min_lat=min(lat(:));
max_lon=max(lon(:));
min_lon=min(lon(:));
ssh_path='/Volumes/matlab/data/eddy/V3/mat/'
jdays=min(track_jday):7:max(track_jday);
load([ssh_path 'AVISO_25_W_2454475'])
r=find(lat>=min_lat & lat<=max_lat);
c=find(lon>=min_lon-10 & lon<=max_lon);

        
        for m=1:length(jdays)
            
            clf;
            cla;
            [yea,mon,day]=jd2jdate(jdays(m));
			dd=(yea*1000)+julian(mon,day,yea,yea)
            load([ssh_path 'AVISO_25_W_' num2str(jdays(m))],'ssh','mask' )
            data=cat(3,ssh(r,c),mask(r,c));
            pmap(lon(c),lat(r),data,'ssh_mask_cont',num2str(dd))
            hold on
            p=find(track_jday<=jdays(m));
            d=find(track_jday==jdays(m));
            h=m_plot(x(d),y(d),'ko','markerfacecolor', ...
                   'k','markersize',4,'clip','off');
            set(h,'clipping','off')
            %m_text(x(d),y(d),num2str(id(d)));
            tmp_ids=id(d);
            time_ids=id(p);
            time_xs=x(p);
            time_ys=y(p);
                    for b=1:length(tmp_ids)
                        tmp=tmp_ids(b);
                        e=find(time_ids==tmp);
                        if tmp>=nneg
                            h=m_plot(time_xs(e),time_ys(e),'k','linewidth',2);
                            set(h,'clipping','off')
                        else
                             h=m_plot(time_xs(e),time_ys(e),'k','linewidth',2);
                             set(h,'clipping','off')
                        end
                    end
             hold off
            eval(['print -dpng frame_' num2str(ff) '.png']) 
            eval(['!convert -trim frame_' num2str(ff) '.png frame_' num2str(ff) ...
      	     		'.png'])
             ff = ff+1;
 end

case {'track_sargo_ssh_id'}

        load /Volumes/matlab/matlab/sargaso/sargo
        %match_time=find(jdays>= startjd & jdays<=endjd);
        max_lat=max(lat(:));
        min_lat=min(lat(:));
        max_lon=max(lon(:));
        min_lon=min(lon(:));
        %filtered_ssh=filtered_ssh(:,:,match_time);
       	%fr = sames(imet_ids,id);
        %x=x(fr);
        %y=y(fr);
        %track_jday=track_jday(fr);
        %id=id(fr);
        %fl=find(x>=min_lon & x<=max_lon & y>=min_lat & y<=max_lat);
        %x=x(fl);
        %y=y(fl);
        %track_jday=track_jday(fl);
        %id=id(fl);
        
        for m=1:length(ssh(1,1,:))
            proccesing_frame=frame-99
            clf;
            cla;
            colormap(chelle)
            [year,month,day] = jd2jdate(jdays(m));
            dlabel = [num2str(month) '-' num2str(day) '-' num2str(year)];
            m_proj('Miller Cylindrical','lon',[min_lon ...
                     max_lon],'lat',[min_lat max_lat]);
            m_pcolor(lon,lat,filtered_ssh(:,:,m));
            shading interp;
            hold on
            m_grid('xtick',[round(min_lon):10:round(max_lon)], ...
                   'ytick',[round(min_lat): ...
                            5:round(max_lat)],'tickdir','out', ...
                   'color','k');
            caxis([-30 30]);
            h=m_contour(lon,lat,filtered_ssh(:,:,m),[-30:5:-1], ...
                        'k--');
            [cs,h]=m_contour(lon,lat,filtered_ssh(:,:,m),[1:5:30],'k');
            m_coast('patch',[0 0 0],'edgecolor','k','EraseMode','background');
            m_plot(295.9102,31.90667,'k+','markersize',12,'linewidth',2);
            m_plot(297.0067,31.4987,'b+','markersize',12,'linewidth',2);
            m_plot(296.6367,31.4204,'r+','markersize',12,'linewidth',2);
            title({'CLS Merged SSH High-Pass',dlabel});
            xlabel({'Black = 4.22.2006, Blue = 4.19.2007, Red = 4.25.2007','Contour interval 5 cm','Negative Contours Dashed','Eddy IDs >96005 are Anticyclones'});
            d=find(track_jday==jdays(m));
            p=find(track_jday<=jdays(m));
            m_plot(x(d),y(d),'ko','markerfacecolor', ...
                   'k','markersize',2,'clip','off');
            m_text(x(d),y(d),num2str(id(d)));
            tmp_ids=id(d);
            time_ids=id(p);
            time_xs=x(p);
            time_ys=y(p);
                    for b=1:length(tmp_ids)
                        tmp=tmp_ids(b);
                        e=find(time_ids==tmp);
                        if tmp>96005
                            m_plot(time_xs(e),time_ys(e),'k-.', ...
                                   'linewidth',.5,'clip','off');
                        else
                             m_plot(time_xs(e),time_ys(e), ...
                                     'k','linewidth',.5,'clip','off');
                        end
                    end
%             c=colorbar('horiz');
%             axes(c);
%        	 set(c,'position',[.33 .49 .38 .04]);
%        	 xlabel('cm');
             hold off
             c=colorbar;
             axes(c)
             ylabel('cm')
            
			land
		    print -dpsc temp.ps
             !sed 's/6 dpi2point mul] 0 setdash/3 dpi2point mul] 0 setdash/' temp.ps > tmp.ps
             eval(['!cp tmp.ps ' num2str(frame) '.ps']);
             eval(['!convert -quality 100 ' ...
             num2str(frame) '.ps frame_' num2str(frame) '.pdf']);
             eval(['!toast ' num2str(frame) '.ps']);
             frame = frame+1;
 end


 case {'track_ssh'}
   colormap(chelle)
    for m=1:length(filtered_ssh(:,:,1))
        proccesing_frame=frame-99
        clf;
        cla;
        [year,month,day] = jd2jdate(jdays(m));
        dlabel = [num2str(month) '-' num2str(day) '-' num2str(year)];
        m_proj('Miller Cylindrical','reg_lon',[min_reg_lon max_reg_lon],'reg_lat',[min_reg_lat ...
                         max_reg_lat]);
        m_pcolor(reg_lon,reg_lat,filtered_ssh(:,:,m));
        shading flat;
        m_grid('xtick',[round(min_reg_lon):10:round(max_reg_lon)],'ytick',[round(min_reg_lat): ...
                            5:round(max_reg_lat)],'tickdir','out','color','k');
        caxis([-20 20]);
        hold on
        m_plot([292 272 272 292],[-16 -16 -25 -25],'color','k','linewidth',1);
        h=m_contour(reg_lon,reg_lat,filtered_ssh(:,:,m),[-10:2:-2],'k--','linewidth',1);
        [cs,h]=m_contour(reg_lon,reg_lat,filtered_ssh(:,:,m),[2:2:10],'k');
        m_coast('patch',[.5 .5 .5],'edgecolor','k');
        m_plot(275,-20,'k+');
        m_plot(285,-20,'k+');
        title({'AVISO Merged SSH High-Pass',dlabel});
        m_text(1045,84,'Contour interval 1 cm','fontsize',8);
        m_text(922,94,'Negative Contours Dashed   ','fontsize',8);
        d=find(track_jday==jdays(m));
        p=find(track_jday<=jdays(m));
        m_plot(x(d),y(d),'ko','markerfacecolor','k','markersize',1,'clip','off');
        tmp_ids=id(d);
        time_ids=id(p);
        time_xs=x(p);
        time_ys=y(p);
        for b=1:length(tmp_ids)
            tmp=tmp_ids(b);
            e=find(time_ids==tmp);
            if tmp>96005
                m_plot(time_xs(e),time_ys(e),'k--','linewidth',.5,'clip','off');
            else
                m_plot(time_xs(e),time_ys(e),'k','linewidth',.5, ...
                       'clip','off');
            end
        end
        c=colorbar('horiz');
        axes(c);
        set(c,'position',[.15 .09 .74 .04]);
        xlabel('cm');
        m_text(770,84,'Contour range [-10:2:2][2:2:10] cm     ','fontsize',8);
        m_text(922,94,'Negative contours dashed   ','fontsize',8);
        hold off
        print -dpsc temp.ps
        !sed 's/6 dpi2point mul] 0 setdash/1 dpi2point mul] 0 setdash/' temp.ps > tmp.ps
        eval(['!cp tmp.ps ' num2str(frame) '.ps']);
        eval(['!convert -quality 100 ' num2str(frame) '.ps frame_' ...
              num2str(frame) '.pdf']);
        eval(['!toast ' num2str(frame) '.ps']);
        frame = frame+1;
    end
    eval(['!convert -trim -density 150x150 frame_*.pdf tracks_ssh_d150.mpeg'])
    eval(['!convert -trim -density 90x90 frame_*.pdf tracks_ssh_d90.mpeg'])
    eval(['!convert -trim -density 70x70 frame_*.pdf tracks_ssh_d70.mpeg'])
  case {'ssh'}
    for m=1:length(ssh(:,:,1))
        proccesing_frame=frame-99
        clf;
        cla;
        [year,month,day] = jd2jdate(jdays(m));
        dlabel = [num2str(month) '-' num2str(day) '-' num2str(year)];
        m_proj('Miller Cylindrical','reg_lon',[min_reg_lon max_reg_lon],'reg_lat',[min_reg_lat ...
                         max_reg_lat]);
        m_pcolor(reg_lon,reg_lat,ssh(:,:,m));
        shading flat;
        m_grid('xtick',[round(min_reg_lon):10:round(max_reg_lon)],'ytick', ...
               [round(min_reg_lat):5:round(max_reg_lat)],'tickdir','out','color','k');
        caxis([-20 20]);
        hold on
        m_plot([292 272 272 292],[-16 -16 -25 -25],'color','k','linewidth',1);
        h=m_contour(reg_lon,reg_lat,ssh(:,:,m),[-20:2:-1],'k--', ...
                    'linewidth',1);
        [cs,h]=m_contour(reg_lon,reg_lat,ssh(:,:,m),[1:2:20],'k');
        m_coast('patch',[.5 .5 .5],'edgecolor','k');
        m_plot(275,-20,'k+');
        m_plot(285,-20,'k+');
        title({'CLS Merged SSH',dlabel});
        c=colorbar('horiz');
        axes(c);
        set(c,'position',[.15 .09 .74 .04]);
        xlabel('cm');
        m_text(1045,84,'Contour interval 2 cm','fontsize',8);
        m_text(922,94,'Negative Contours Dashed   ','fontsize',8);
        print -dpsc temp.ps 
        !sed 's/6 dpi2point mul] 0 setdash/1 dpi2point mul] 0 setdash/' temp.ps > tmp.ps
        eval(['!cp tmp.ps ' num2str(frame) '.ps']);
        eval(['!convert -density 90x90 ' num2str(frame) '.ps frame_' num2str(frame) '.pdf']);
        eval(['!toast ' num2str(frame) '.ps']);
        frame = frame+1;
        
    end
    eval(['!convert -trim -density 150x150 ' ...
          'frame_*.pdf raw_ssh_d150.mpeg'])
end
png2mpg
