
load eddy_argo_prof_index
load /matlab/data/eddy/V4/full_tracks/pCC_lat_lon_tracks.mat

uid=unique(id);
same_prof=sames(uid,eddy_id);
eddy_pfile=eddy_pfile(same_prof);
eddy_pjday_round=eddy_pjday_round(same_prof);
eddy_id=eddy_id(same_prof);
eddy_scale=eddy_efold(same_prof);
eddy_dist_x=eddy_dist_x(same_prof);
eddy_dist_y=eddy_dist_y(same_prof);
eddy_x=eddy_x(same_prof);
eddy_y=eddy_y(same_prof);
eddy_plon=eddy_plon(same_prof);
eddy_plat=eddy_plat(same_prof);

load rwp.pal
load chelle.pal
FRAME_DIR='/matlab/matlab/argo/frames/eddies_and_floats/';
ff=1;
load /matlab/data/eddy/V4/mat/AVISO_25_W_2453530 lat lon
slat=interp2(lat);
slon=interp2(lon);
jdays=[2451675:7:2454489];
load /matlab/matlab/domains/pCC_lat_lon
[r,c]=imap(min(lat),max(lat),min(lon),max(lon),slat,slon);
	
for m=1:length(jdays)
	load(['/matlab/data/eddy/V4/mat/AVISO_25_W_',num2str(jdays(m))],'ssh','mask')
	ssh=interp2(ssh);
	mask=interp2(mask,'linear');
	figure(1)
	clf
	pmap(slon(r,c),slat(r,c),ssh(r,c))
	hold on
	m_contourf(slon(r,c),slat(r,c),ssh(r,c),[-100:5:-100],'color', [.5 .5 .5])
	caxis([-15 15])
	hold on
	%m_contour(slon(r,c),slat(r,c),ssh(r,c),[-100:5:-2],'color', [.5 .5 .5])
	%m_contour(slon(r,c),slat(r,c),ssh(r,c),[2:5:100],'color', [.5 .5 .5])
	[year,month,day]=jd2jdate(jdays(m));
	title(['SSH with Argo Floats and Eddy Tracks  ' num2str(year) '-' num2str(month) '-' num2str(day) '   '])
	colorbar
	colormap(chelle)
	
	%tracks
	d=find(track_jday==jdays(m));
	p=find(track_jday<=jdays(m));
	m_plot(x(d),y(d),'*','markerfacecolor','w','markeredgecolor','w','markersize',3);
	tmp_ids=id(d);
	time_ids=id(p);
	time_xs=x(p);
	time_ys=y(p);;
	for b=1:length(tmp_ids)
		tmp=tmp_ids(b);
		e=find(time_ids==tmp);
		m_plot(time_xs(e),time_ys(e),'color',[.5 .5 .5], ...
		  'linewidth',.1);
	end
	
	%floats
	d=find(eddy_pjday_round==jdays(m));
	p=find(eddy_pjday_round<jdays(m) & eddy_pjday_round>=min(jdays) & eddy_pjday_round>=jdays(m)-365);
	m_plot(eddy_plon(d),eddy_plat(d),'.','markerfacecolor','k','markeredgecolor','k','markersize',10);
	m_plot(eddy_plon(p),eddy_plat(p),'.','markerfacecolor',[.5 .5 .5],'markeredgecolor',[.5 .5 .5],'markersize',10);
	drawnow
	eval(['print -dpng -r300 ',FRAME_DIR,'/frame_' num2str(ff) '.png'])
	ff=ff+1;
	clear w_ek
end
	
pp=pwd;
cd(FRAME_DIR)
png2mpg
cd(pp)