TYPE='msst_contour'

load bwr.pal
load chelle.pal
load bwy.pal
figure(1);
ff=1;
prev_x=[];
prev_y=[];
prev_id=[];

switch TYPE

case {'logmchl_tracks'}
warning('off','all')
figure(1)

load /Volumes/matlab/matlab/domains/LW_lat_lon.mat
max_lat=max(lat(:));
min_lat=min(lat(:));
max_lon=max(lon(:));
min_lon=min(lon(:));
load /Volumes/matlab/matlab/timor/modis_chl_4km/CHL_4_W_2452459 lat lon mid_week_jdays
r=find(lat(:,1)>=min_lat & lat(:,1)<=max_lat);
c=find(lon(1,:)>=min_lon & lon(1,:)<=max_lon);
rssh=find(ssh_lat(:,1)>=min_lat & ssh_lat(:,1)<=max_lat);
cssh=find(ssh_lon(1,:)>=min_lon & ssh_lon(1,:)<=max_lon);
match_time=find(mid_week_jdays>= min(track_jday) & mid_week_jdays<=max(track_jday));



for m=match_time
clf
[yea,mon,day]=jd2jdate(mid_week_jdays(m));
dd=(yea*1000)+julian(mon,day,yea,yea)
qq=find(jdays==mid_week_jdays(m));
eval(['load /Volumes/matlab/matlab/timor/modis_chl_4km/CHL_4_W_' ...
      num2str(mid_week_jdays(m)) '.mat chl_week jt lon lat']);
pmap(lon(r,c),lat(r,c),chl_week(r,c),'logmchl',num2str(dd))
hold on
m_contour(ssh_lon(rssh,cssh),ssh_lat(rssh,cssh),filtered_ssh(rssh,cssh,qq),[-40:2:-2],'k--')
m_contour(ssh_lon(rssh,cssh),ssh_lat(rssh,cssh),filtered_ssh(rssh,cssh,qq),[-2:2:40],'k')
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
load /Volumes/matlab/matlab/domains/LW_lat_lon.mat
max_lat=max(lat(:));
min_lat=min(lat(:));
max_lon=max(lon(:));
min_lon=min(lon(:));
load /Volumes/matlab/matlab/timor/modis_chl_4km/CHL_4_W_2454440 lat lon mid_week_jdays

unid = unique(id);
for ee=1:length(unid)
	itid=find(id==unid(ee));
	tid=id(itid);
	for n=1:length(tid)
	pp=find(mid_week_jdays==track_jday(itid(n)));
	qq=find(jdays==track_jday(itid(n)));
	if any(qq)
	eval(['load /Volumes/matlab/matlab/timor/modis_chl_4km/CHL_4_W_' ...
      num2str(mid_week_jdays(pp)) '.mat chl_anom jt lon lat']);
	r=find(lat(:,1)>=y(itid(n))-3 & lat(:,1)<=y(itid(n))+3);
	c=find(lon(1,:)>=x(itid(n))-3 & lon(1,:)<=x(itid(n))+3);
	rssh=find(ssh_lat(:,1)>=y(itid(n))-3 & ssh_lat(:,1)<=y(itid(n))+3);
	cssh=find(ssh_lon(1,:)>=x(itid(n))-3 & ssh_lon(1,:)<=x(itid(n))+3);
	if length(rssh)>20 & length(cssh)>20
		clf
		[yea,mon,day]=jd2jdate(jdays(pp));
		dd=(yea*1000)+julian(mon,day,yea,yea)
		pmap(lon(r,c),lat(r,c),chl_anom(r,c),'mchlanom',num2str(dd))
		hold on
		m_contour(ssh_lon(rssh,cssh),ssh_lat(rssh,cssh),filtered_ssh(rssh,cssh,qq),[-40:2:-2],'--','color',[.5 .5 .5])
		m_contour(ssh_lon(rssh,cssh),ssh_lat(rssh,cssh),filtered_ssh(rssh,cssh,qq),[-2:2:40],'color',[.5 .5 .5])
		xlabel(['ID = ', num2str(id(itid(n))), '  k = ',num2str(k(itid(n))), ' of ' , num2str(max(k(itid)))...
				'  U/c = ',num2str(axial_speed(itid(n))/prop_speed(itid(n))),'  Amp = ',num2str(amp(itid(n)))],'color','w')
		d=find(track_jday(itid)==jdays(pp));
		p=find(track_jday(itid)<=jdays(pp));
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
		eval(['!convert -trim frame_' num2str(ff) '.png frame_' num2str(ff) ...
      			'.png'])
		ff=ff+1;
		else 
		end
		end
	end	
end
!ffmpeg -r 5 -sameq -i frame_%d.png -y lw_mchl_track_trans_box.mp4


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
!ffmpeg -r 5 -sameq -i frame_%d.png -y lw_ssh_track_trans_box.mp4


case {'logmchl_contour_box_tracks'}
warning('off','all')
figure(1)
load /Volumes/matlab/matlab/domains/LW_lat_lon.mat
max_lat=max(lat(:));
min_lat=min(lat(:));
max_lon=max(lon(:));
min_lon=min(lon(:));
load /Volumes/matlab/matlab/timor/modis_chl_4km/CHL_4_W_2454440 lat lon mid_week_jdays

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
	eval(['load /Volumes/matlab/matlab/timor/modis_chl_4km/CHL_4_W_' ...
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
load /Volumes/matlab/matlab/domains/LW_lat_lon.mat
max_lat=max(lat(:));
min_lat=min(lat(:));
max_lon=max(lon(:));
min_lon=min(lon(:));
load /Volumes/matlab/matlab/timor/modis_chl_4km/CHL_4_W_2454440 lat lon mid_week_jdays
unid = unique(id);



for ee=1:length(unid)
	itid=find(id==unid(ee));
	tid=id(itid);
	for n=1:length(tid)
	pp=find(mid_week_jdays==track_jday(itid(n)));
	qq=find(jdays==track_jday(itid(n)));
	if any(qq)
	eval(['load /Volumes/matlab/matlab/timor/modis_chl_4km/CHL_4_W_' ...
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






case {'masked_ssh_tracks'}
warning('off','all')
figure(1)
max_lat=max(lat(:));
min_lat=min(lat(:));
max_lon=max(lon(:));
min_lon=min(lon(:));

match_time=find(jdays>= min(track_jday) & jdays<=max(track_jday));


for m=match_time
clf
[yea,mon,day]=jd2jdate(jdays(m));
dd=(yea*1000)+julian(mon,day,yea,yea)
pmap(lon,lat,masked_ssh(:,:,m),'hpssh_med',num2str(dd))
set(gca,'clipping','off')
hold on
d=find(track_jday==jdays(m));
p=find(track_jday<=jdays(m));
m_plot(x(d),y(d),'o','markerfacecolor', ...
         'k','markeredgecolor','k','markersize',4);
%m_text(qx(dq),qy(dq),num2str(qid(dq)),'fontsize',12)
tmp_ids=id(d);
time_ids=id(p);
time_xs=x(p);
time_ys=y(p);;
for b=1:length(tmp_ids)
    tmp=tmp_ids(b);
    e=find(time_ids==tmp);
    m_plot(time_xs(e),time_ys(e),'k', ...
              'linewidth',.5);
end

eval(['print -dpng -r300 frame_' num2str(ff) '.png'])
eval(['!convert -trim frame_' num2str(ff) '.png frame_' num2str(ff) ...
      '.png'])
ff=ff+1;
end
!ffmpeg -r 5 -sameq -i frame_%d.png -y lw_masked_ssh_tracks.mp4

case {'ssh_tracks_contours'}
warning('off','all')
figure(1)
max_lat=max(lat(:));
min_lat=min(lat(:));
max_lon=max(lon(:));
min_lon=min(lon(:));

match_time=find(jdays>= min(track_jday) & jdays<=max(track_jday));


for m=match_time
clf
[yea,mon,day]=jd2jdate(jdays(m));
dd=(yea*1000)+julian(mon,day,yea,yea)
pmap(lon,lat,filtered_ssh(:,:,m),'hpssh_small',num2str(dd))
set(gca,'clipping','off')
hold on
m_contour(lon,lat,filtered_ssh(:,:,m),[-100:1:-1],'w')
m_contour(lon,lat,filtered_ssh(:,:,m),[1:1:100],'k')


eval(['print -dpng -r300 frame_' num2str(ff) '.png'])
eval(['!convert -trim frame_' num2str(ff) '.png frame_' num2str(ff) ...
      '.png'])
ff=ff+1;
end
!ffmpeg -r 5 -sameq -i frame_%d.png -y timor_ssh_tracks_id.mp4

case {'amsre'}
warning('off','all')
figure(1)
max_lat=max(lat(:));
min_lat=min(lat(:));
max_lon=max(lon(:));
min_lon=min(lon(:));


for m=7:length(mid_week_jdays)
clf
[yea,mon,day]=jd2jdate(mid_week_jdays(m));
dd=(yea*1000)+julian(mon,day,yea,yea)
pmap(sst_lon,sst_lat,sst_week(:,:,m),'amsre',num2str(dd))
eval(['print -dpng frame_' num2str(ff) '.png'])
eval(['!convert -trim frame_' num2str(ff) '.png frame_' num2str(ff) ...
      '.png'])
clf
ff=ff+1;
end
!ffmpeg -r 10 -sameq -i frame_%d.png -y timor_amsre.mp4

case {'msst_contour'}
warning('off','all')
figure(1)
load /Volumes/matlab/matlab/domains/reg_lat_lon.mat
max_lat=max(lat(:));
min_lat=min(lat(:));
max_lon=max(lon(:));
min_lon=min(lon(:));
load /Volumes/matlab/matlab/vocals/modis_sst_4km/SST_4_W_2452459 lat lon mid_week_jdays
r=find(lat(:,1)>=min_lat & lat(:,1)<=max_lat);
c=find(lon(1,:)>=min_lon & lon(1,:)<=max_lon);
rssh=find(ssh_lat(:,1)>=min_lat & ssh_lat(:,1)<=max_lat);
cssh=find(ssh_lon(1,:)>=min_lon & ssh_lon(1,:)<=max_lon);


for m=100:152
clf
[yea,mon,day]=jd2jdate(mid_week_jdays(m));
dd=(yea*1000)+julian(mon,day,yea,yea)
qq=find(jdays==mid_week_jdays(m));
eval(['load /Volumes/matlab/matlab/vocals/modis_sst_4km/SST_4_W_' ...
      num2str(mid_week_jdays(m)) '.mat sst_week jt lon lat']);
pmap(lon(r,c),lat(r,c),sst_week(r,c),'msst',num2str(dd))
hold on
m_contour(ssh_lon(rssh,cssh),ssh_lat(rssh,cssh),ssh(rssh,cssh,qq),[-40:-2],'k--')
m_contour(ssh_lon(rssh,cssh),ssh_lat(rssh,cssh),ssh(rssh,cssh,qq),[-2:40],'k')

eval(['print -dpng -r300 frame_' num2str(ff) '.png'])
eval(['!convert -trim frame_' num2str(ff) '.png frame_' num2str(ff) ...
      '.png'])
ff=ff+1;
end
!ffmpeg -r 5 -sameq -i frame_%d.png -y lw_msst_contours.mp4



case {'oi_hp_contour'}
warning('off','all')
figure(1)
ff=1;

for m=100:152
clf
[yea,mon,day]=jd2jdate(mid_week_jdays(m));
dd=(yea*1000)+julian(mon,day,yea,yea)
pmap(lon,lat,filtered_sst(:,:,m),'oihp',num2str(dd))
hold on
ii=find(jdays==mid_week_jdays(m));
%m_text(75,-62,{'Cyclones are white and anticyclones are black.',...
%'Contour interval if 4 cm with a max at +/- 20 cm'})
m_contour(lon,lat,ssh(:,:,ii),[-20:2:-2],'w');
m_contour(lon,lat,ssh(:,:,ii),[2:2:20],'k');
drawnow
%eval(['print -dpng frame_' num2str(ff) '.png'])
%eval(['!convert -trim frame_' num2str(ff) '.png frame_' num2str(ff) ...
%      '.png'])
%ff=ff+1;
end
!ffmpeg -r 10 -sameq -i frame_%d.png -y timor_oi_contour.mp4


case {'amsre_hp_contour'}
warning('off','all')
figure(1)
ff=1;

for m=100:152
clf
[yea,mon,day]=jd2jdate(mid_week_jdays(m));
dd=(yea*1000)+julian(mon,day,yea,yea)
pmap(lon,lat,filtered_sst(:,:,m),'amsrehp',num2str(dd))
hold on
ii=find(jdays==mid_week_jdays(m));
%m_text(75,-62,{'Cyclones are white and anticyclones are black.',...
%'Contour interval if 4 cm with a max at +/- 20 cm'})
m_contour(lon,lat,ssh(:,:,ii),[-20:2:-2],'w');
m_contour(lon,lat,ssh(:,:,ii),[2:2:20],'k');
drawnow
%eval(['print -dpng frame_' num2str(ff) '.png'])
%eval(['!convert -trim frame_' num2str(ff) '.png frame_' num2str(ff) ...
%      '.png'])
%ff=ff+1;
end
!ffmpeg -r 10 -sameq -i frame_%d.png -y timor_amsre_contour.mp4



case {'amsre_contour'}
warning('off','all')
figure(1)
ff=1;

for m=100:152
clf
[yea,mon,day]=jd2jdate(mid_week_jdays(m));
dd=(yea*1000)+julian(mon,day,yea,yea)
pmap(lon,lat,sst_week(:,:,m),'amsre',num2str(dd))
hold on
ii=find(jdays==mid_week_jdays(m));
%m_text(75,-62,{'Cyclones are white and anticyclones are black.',...
%'Contour interval if 4 cm with a max at +/- 20 cm'})
m_contour(lon,lat,ssh(:,:,ii),[-20:2:-2],'w');
m_contour(lon,lat,ssh(:,:,ii),[2:2:20],'k');
drawnow
%eval(['print -dpng frame_' num2str(ff) '.png'])
%eval(['!convert -trim frame_' num2str(ff) '.png frame_' num2str(ff) ...
%      '.png'])
%ff=ff+1;
end
!ffmpeg -r 10 -sameq -i frame_%d.png -y timor_amsre_contour.mp4


case {'amsre_ssthp_tracks_contour'}
warning('off','all')
figure(1)
max_lat=max(lat(:));
min_lat=min(lat(:));
max_lon=max(lon(:));
min_lon=min(lon(:));



match_time=find(mid_week_jdays>= min(track_jday) & mid_week_jdays<=max(track_jday));
match_time(1:7)=[];

for m=match_time
clf
[yea,mon,day]=jd2jdate(mid_week_jdays(m));
dd=(yea*1000)+julian(mon,day,yea,yea)
pmap(sst_lon,sst_lat,filtered_sst(:,:,m),'amsrehp',num2str(dd))
hold on
m_text(75,-62,{'Cyclones are white and anticyclones are black.',...
'Contour interval if 4 cm with a max at +/- 20 cm'})
m_contour(lon,lat,filtered_ssh(:,:,m),[-20:4:-2],'w');
m_contour(lon,lat,filtered_ssh(:,:,m),[2:4:20],'k');

da=find(track_jday==jdays(m) & id>=nneg);
dc=find(track_jday==jdays(m) & id<nneg);
p=find(track_jday<=jdays(m));
h=m_plot(x(dc),y(dc),'o','markerfacecolor', ...
         'w','markersize',2);
h=m_plot(x(da),y(da),'o','markersize',2);         
set(h,'clipping','off')
tmp_ids_a=id(da);
tmp_ids_c=id(dc);
time_ids=id(p);
time_xs=x(p);
time_ys=y(p);
for b=1:length(tmp_ids_a)
    tmp=tmp_ids_a(b);
    e=find(time_ids==tmp);
    h=m_plot(time_xs(e),time_ys(e),'k', ...
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
!ffmpeg -r 10 -sameq -i frame_%d.png -y timor_amsrehp_tracks_contour.mp4






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
!ffmpeg -r 7 -sameq -i frame_%d.png imet_tracks_w_ids.mp4





case {'ssh_tracks_id'}
warning('off','all')
figure(1)
max_lat=max(lat(:));
min_lat=min(lat(:));
max_lon=max(lon(:));
min_lon=min(lon(:));

match_time=find(jdays>= min(track_jday) & jdays<=max(track_jday));


for m=match_time
clf
[yea,mon,day]=jd2jdate(jdays(m));
dd=(yea*1000)+julian(mon,day,yea,yea)
pmap(lon,lat,ssh(:,:,m),'hpssh_med',num2str(dd))
hold on
da=find(track_jday==jdays(m) & id>=nneg);
dc=find(track_jday==jdays(m) & id<nneg);
p=find(track_jday<=jdays(m));
m_plot(x(dc),y(dc),'o','markerfacecolor', ...
         'w','markeredgecolor','w','markersize',4);
m_plot(x(da),y(da),'o','markersize',4); 
m_text(x(dc),y(dc),num2str(id(dc)),'fontsize',12)
m_text(x(da),y(da),num2str(id(da)),'fontsize',12)
tmp_ids_a=id(da);
tmp_ids_c=id(dc);
time_ids=id(p);
time_xs=x(p);
time_ys=y(p);
for b=1:length(tmp_ids_a)
    tmp=tmp_ids_a(b);
    e=find(time_ids==tmp);
    m_plot(time_xs(e),time_ys(e),'k', ...
              'linewidth',.5);
end
for b=1:length(tmp_ids_c)
    tmp=tmp_ids_c(b);
    e=find(time_ids==tmp);
       m_plot(time_xs(e),time_ys(e),'w', ...
               'linewidth',.5);
end

eval(['print -dpng -r300 frame_' num2str(ff) '.png'])
eval(['!convert -trim frame_' num2str(ff) '.png frame_' num2str(ff) ...
      '.png'])
ff=ff+1;
end
!ffmpeg -r 5 -sameq -i frame_%d.png -y timor_ssh_tracks_id.mp4




case {'ssh_tracks_cycl'}
warning('off','all')
figure(1)
max_lat=max(lat(:));
min_lat=min(lat(:));
max_lon=max(lon(:));
min_lon=min(lon(:));

match_time=find(jdays>= min(track_jday) & jdays<=max(track_jday));


for m=match_time
clf
[yea,mon,day]=jd2jdate(jdays(m));
dd=(yea*1000)+julian(mon,day,yea,yea)
pmap(lon,lat,filtered_ssh(:,:,m),'hpssh_med',num2str(dd))
set(gca,'clipping','off')
hold on
da=find(track_jday==jdays(m) & id>=nneg);
dc=find(track_jday==jdays(m) & id<nneg);
p=find(track_jday<=jdays(m));
h=m_plot(x(dc),y(dc),'o','markerfacecolor', ...
         'k','markersize',4);
set(h,'clipping','off')
tmp_ids_c=id(dc);
time_ids=id(p);
time_xs=x(p);
time_ys=y(p);

for b=1:length(tmp_ids_c)
    tmp=tmp_ids_c(b);
    e=find(time_ids==tmp);
       h=m_plot(time_xs(e),time_ys(e),'k', ...
               'linewidth',.5);
       set(h,'clipping','off')
end

eval(['print -dpng -r300 frame_' num2str(ff) '.png'])
eval(['!convert -trim frame_' num2str(ff) '.png frame_' num2str(ff) ...
      '.png'])
ff=ff+1;
end
!ffmpeg -r 5 -sameq -i frame_%d.png -y timor_ssh_cycl_tracks.mp4

case {'ssh_tracks_anti'}
warning('off','all')
figure(1)
max_lat=max(lat(:));
min_lat=min(lat(:));
max_lon=max(lon(:));
min_lon=min(lon(:));

match_time=find(jdays>= min(track_jday) & jdays<=max(track_jday));


for m=match_time
clf
[yea,mon,day]=jd2jdate(jdays(m));
dd=(yea*1000)+julian(mon,day,yea,yea)
pmap(lon,lat,filtered_ssh(:,:,m),'hpssh_med',num2str(dd))
set(gca,'clipping','off')
hold on
da=find(track_jday==jdays(m) & id>=nneg);
p=find(track_jday<=jdays(m));
h=m_plot(x(da),y(da),'o','markerfacecolor','k','markersize',4);         
set(h,'clipping','off')
tmp_ids_a=id(da);
time_ids=id(p);
time_xs=x(p);
time_ys=y(p);

for b=1:length(tmp_ids_a)
    tmp=tmp_ids_a(b);
    e=find(time_ids==tmp);
    h=m_plot(time_xs(e),time_ys(e),'k', ...
              'linewidth',.5);
    set(h,'clipping','off')
end

eval(['print -dpng -r300 frame_' num2str(ff) '.png'])
eval(['!convert -trim frame_' num2str(ff) '.png frame_' num2str(ff) ...
      '.png'])
ff=ff+1;
end
!ffmpeg -r 5 -sameq -i frame_%d.png -y timor_ssh_anti_tracks.mp4



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
eval(['load /Volumes/matlab/matlab/timor/modis_chl_4km/CHL_4_W_' ...
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
eval(['load /Volumes/matlab/matlab/timor/merged_chl_mat/CHL_X_W_' ...
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
        eval(['load /Volumes/matlab/matlab/hawaii/merged_chl_mat/CHL_X_W_' ...
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
        eval(['load /Volumes/matlab/matlab/timor/modis_chl_4km/CHL_4_W_' ...
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
eval(['load /Volumes/matlab/matlab/hawaii/modis_chl_4km/CHL_4_W_' ...
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
eval(['load /Volumes/matlab/matlab/hawaii/modis_chl_4km/CHL_4_W_' ...
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

case {'mchlss'}
warning('off','all')
figure(1)
for m=1:length(mid_week_jdays)
clf
eval(['load /Volumes/matlab/matlab/hawaii/modis_chl_4km/CHL_4_W_' ...
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
    %!convert -trim -density 200x200 -delay '20' fram* ssh_comp_2007.mpg
    
    
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
%eval(['!convert -rotate 90 -density 150x150 frame_*.pdf hawaii_tracks_ids.mpeg'])



case {'ctt_day_comparison'}
load /Volumes/matlab/matlab/agulhas/ctt_day_comparison
max_lat=max(GRIDY(:)); 
min_lat=min(GRIDY(:)); 
max_lon=max(GRIDX(:)); 
min_lon=min(GRIDX(:));
p=2007001;

    for d=1:365
        figure(1)
        clf
        subplot(211)
		m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);  
		m_pcolor(GRIDX,GRIDY,ctt_day(:,:,d)); 
		colormap('jet');
		m_grid('xtick',[round(min_lon):5:round(max_lon)],'ytick',[round(min_lat):3:round(max_lat)],'tickdir','out','color','k');  
		shading flat 
		caxis([210 310])
     	c=colorbar;
     	m_coast('color','k')
    	grid
     	title({'Cloud Top Temperature from MODIS Aqua','Tri-Cubic Gridding Span = 80 km',num2str(p)});
        subplot(212)
		m_proj('Miller Cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);  
		m_pcolor(LON,LAT,ctt_1_deg(:,:,d)); 
		colormap('jet');
		m_grid('xtick',[round(min_lon):5:round(max_lon)],'ytick',[round(min_lat):3:round(max_lat)],'tickdir','out','color','k');  
		shading flat 
		caxis([210 310])
     	c=colorbar;
     	m_coast('color','k')
    	grid
     	title({'Cloud Top Temperature from MODIS Aqua','NASA Produced 1 Degree Grid',num2str(p)});
     	axis image
     	land
     	print -dpsc temp.ps
        eval(['!cp temp.ps ' num2str(frame) '.ps']);
        eval(['!convert -quality 100 '...
              num2str(frame) '.ps frame_' num2str(frame) '.pdf']);
        eval(['!toast ' num2str(frame) '.ps']);
        frame = frame+1;
        p=p+1;
        d=d+1;
    end
%eval(['!convert -density 150x150 -trim frame_*.pdf ctt_day_comp.mpg'])
    

case {'track_ssh'}

  max_lat=max(lat(:));
  min_lat=min(lat(:));
  max_lon=max(lon(:));
  min_lon=min(lon(:));
  match_time=find(jdays>= min(track_jday) & jdays<=max(track_jday));
        filtered_ssh=filtered_ssh(:,:,match_time);
       	ssh=ssh(:,:,match_time);
        
        for m=1:length(filtered_ssh(1,1,:))
            proccesing_frame=frame-99
            clf;
            cla;
            colormap(bwy)
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
            caxis([-20 20]);
            m_contour(lon,lat,filtered_ssh(:,:,m),[-30:3:-5],'k--');
            m_contour(lon,lat,filtered_ssh(:,:,m),[5:3:30],'k');
            m_coast('patch',[0 0 0],'edgecolor','k','EraseMode','background');
            %m_plot(295.9102,31.90667,'k+','markersize',12,'linewidth',2);
            %m_plot(297.0067,31.4987,'b+','markersize',12,'linewidth',2);
            %m_plot(296.6367,31.4204,'r+','markersize',12,'linewidth',2);
            title({'AVISO Merged T/P-Jason 1 & ERS 1,2-EnviSat',...
                   'SSH High-Pass Filtered',dlabel});
            %xlabel({'Black = 4.22.2006, Blue = 4.19.2007, Red = 4.25.2007','Contour interval 5 cm','Negative Contours Dashed','Eddy IDs >96005 are Anticyclones'});
            d=find(track_jday==jdays(m));
            p=find(track_jday<=jdays(m));
            h=m_plot(x(d),y(d),'ko','markerfacecolor', ...
                   'k','markersize',2,'clip','off');
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
                            h=m_plot(time_xs(e),time_ys(e),'k-.','linewidth',.5);
                            set(h,'clipping','off')
                        else
                             h=m_plot(time_xs(e),time_ys(e),'k','linewidth',.5);
                             set(h,'clipping','off')
                        end
                    end
%             c=colorbar('horiz');
%             axes(c);
%        	 set(c,'position',[.33 .49 .38 .04]);
%        	 xlabel('cm');
             hold off
             %             c=colorbar;
             %axes(c)
             %ylabel('cm')
            
			land
            eval(['print -dpng frame_' num2str(frame) '.png']) 
            %print -dpsc temp.ps
            %!sed 's/6 dpi2point mul] 0 setdash/1 dpi2point mul] 0 setdash/' temp.ps > tmp.ps
            %eval(['!cp tmp.ps ' num2str(frame) '.ps']);
            %eval(['!convert -density 400x400 ' ...
            %num2str(frame) '.ps frame_' num2str(frame) '.png']);
            %eval(['!toast ' num2str(frame) '.ps']);
             frame = frame+1;
 end
eval(['!convert -trim -rotate 90 -density 200x200 -delay 2 frame_*.png hawaii_tracks_d200.mpeg'])


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
eval(['!convert -rotate 90 -density 150x150 frame_*.pdf sargo_tracks_ids.mpeg'])


case {'ctt_hp'}
load /Volumes/matlab/matlab/AGULHAS/agu_modis
for m=1:12
    clf
    d=julian(m,1,2007);
    dat=[num2str(2007*1000+d)];
    pmap(GRIDX,GRIDY,ctt_hp(:,:,m),'ctthp',dat);
    print -dpsc temp.ps
    eval(['!cp temp.ps ' num2str(frame) '.ps']);
    eval(['!convert -quality 100 '...
          num2str(frame) '.ps frame_' num2str(frame) '.pdf']);
    eval(['!toast ' num2str(frame) '.ps']);
    frame = frame+1;
end
eval(['!convert -density 150x150 -trim frame_*.pdf ' ...
      'ctt_hp_week.mpg'])


case {'ctp_week'}
for m=1:7:358
    fname = ['/Volumes/matlab/data/modisa/L2/avg_fields/weekly/ctp_agulhas_W_',num2str(2007*1000+m),'.mat'];
    load(fname)
    pmap(GRIDX,GRIDY,Wctp,'ctp',num2str(2007*1000+m));
    print -dpsc temp.ps
    eval(['!cp temp.ps ' num2str(frame) '.ps']);
    eval(['!convert -quality 100 '...
          num2str(frame) '.ps frame_' num2str(frame) '.pdf']);
    eval(['!toast ' num2str(frame) '.ps']);
    frame = frame+1;
end
eval(['!convert -density 150x150 -trim frame_*.pdf ctp_week.mpg'])
      
case {'ctt_week'}
for m=1:7:358
    fname = ['/Volumes/matlab/data/modisa/L2/avg_fields/weekly/ctt_agulhas_W_',num2str(2007*1000+m),'.mat'];
    load(fname)
    pmap(GRIDX,GRIDY,Wctt,'ctt',num2str(2007*1000+m));
    print -dpsc temp.ps
    eval(['!cp temp.ps ' num2str(frame) '.ps']);
    eval(['!convert -quality 100 '...
          num2str(frame) '.ps frame_' num2str(frame) '.pdf']);
    eval(['!toast ' num2str(frame) '.ps']);
    frame = frame+1;
end
eval(['!convert -density 150x150 -trim frame_*.pdf ' ...
      'ctt_week.mpg'])

case {'track_imet_sample'}
		global STEP
		BOX=16;
		sample_sst=nan(BOX+1,BOX+1);
		sample_ssh=nan(BOX+1,BOX+1);
        load /Volumes/matlab/matlab/VOCALS/ssh_ls_filtered filtered_ssh jdays reg_lat reg_lon
        load /Volumes/matlab/matlab/domains/VOCALS_REx_lat_lon
        load /Volumes/matlab/matlab/VOCALS/eddy_tracks_vocals
        load /Volumes/matlab/matlab/IMET/imet_temperature
        set_track_param
        min_jday=min(imet_jdayss);
        max_jday=max(imet_jdays);
        match_time=find(jdays>= min_jday & jdays<=max_jday);
        max_lat=max(lat(:));
        min_lat=min(lat(:));
        max_lon=max(lon(:));
        min_lon=min(lon(:));
		r=find(reg_lat(:,1)>=min_lat&reg_lat(:,1)<=max_lat);
		c=find(reg_lon(1,:)>=min_lon&reg_lon(1,:)<=max_lon);
        lat=reg_lat(r,c);
        lon=reg_lon(r,c);
%       lon=ones(length(lat),1)*lon;
%	lat=lat'*ones(1,length(lon(1,:))); 
	filtered_ssh=filtered_ssh(r,c,match_time);
%{
        load /Volumes/matlab/matlab/VOCALS/chl_merged_raw chl grid_lat grid_lon
        grid_lat=grid_lat-.125;
        grid_lon=grid_lon-.125;
        r=find(grid_lat(:,1)>=min_lat&grid_lat(:,1)<=max_lat);
	c=find(grid_lon(1,:)>=min_lon&grid_lon(1,:)<=max_lon);
	chl=chl(r,c,match_time);
        load /Volumes/matlab/matlab/VOCALS/sst_amsre_ls_filtered filtered_sst amsre_lat amsre_lon
        r=find(amsre_lat(:,1)>=min_lat&amsre_lat(:,1)<=max_lat);
	c=find(amsre_lon(1,:)>=min_lon&amsre_lon(1,:)<=max_lon);
	filtered_sst=filtered_sst(r,c,match_time);
%}      
        load /Volumes/matlab/matlab/VOCALS/sst_oi_ls_filtered filtered_sst oi_lat oi_lon
        r=find(oi_lat(:,1)>=min_lat&oi_lat(:,1)<=max_lat);
        c=find(oi_lon(1,:)>=min_lon&oi_lon(1,:)<=max_lon);
        filtered_sst=filtered_sst(r,c,match_time);
        


      	bor_lon=border_domain(lon,BOX,'lon');
		bor_lat=border_domain(lat,BOX,'lat');
		bor_ssh=border_domain(filtered_ssh,BOX,'data');
		bor_sst=border_domain(filtered_sst,BOX,'data');
                %		bor_chl=border_domain(chl,BOX,'data');
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
        est_radius=est_radius(fl);
        %BOX = 4*round((max(est_radius)/(111.11)))*RAD_MULT;
        
        
        for m=1:length(match_time)
            clf
            proccesing_frame=frame-99
            [year,month,day] = jd2jdate(jdays(m));
            dlabel = [num2str(month) '-' num2str(day) '-' num2str(year)];
            subplot(4,4,[1:8])
            m_proj('Miller Cylindrical','lon',[min_lon ...
                     max_lon],'lat',[min_lat max_lat]);
            
            m_pcolor(lon,lat,filtered_ssh(:,:,m));
            
            shading flat;
            hold on
            m_grid('xtick',[round(min_reg_lon):5:round(max_reg_lon)], ...
                   'ytick',[round(min_reg_lat): ...
                            5:round(max_reg_lat)],'tickdir','out', ...
                   'color','k');
            caxis([-15 15]);
            h=m_contour(lon,lat,filtered_ssh(:,:,m),[-10:2:-2], ...
                        'k--');
            [cs,h]=m_contour(lon,lat,filtered_ssh(:,:,m),[2:2: ...
                                10],'k');
            m_coast('patch',[.5 .5 .5],'edgecolor','k');
            m_plot(274.8500,-20.15,'k*','markersize',10);
            title({'CLS Merged SSH High-Pass',dlabel});
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
%             m_text(294,-20,'Contour range [-10:2:2][2:2:10] cm   ','fontsize',10);
%             m_text(294,-21,'Negative contours dashed   ','fontsize',10);
             hold off
            
            if length(d)>=1
            	if length(d)>1
            	if id(d(2))>nneg
		            subplot(4,4,9)
		            [sample_sshc,N_ssh]=workfun_trans_sample(x(d(1)),y(d(1)),bor_lat,bor_lon,bor_ssh(:,:,m),BOX);
                            pcolor(sample_sshc)
            		caxis([-14 14])
            		shading flat
            		title({'Cyclonic SSH Sample',num2str(id(d(1)))})
            		subplot(4,4,10)
            		[sample_ssha,N_ssh]=workfun_trans_sample(x(d(2)),y(d(2)),bor_lat,bor_lon,bor_ssh(:,:,m),BOX);
            		pcolor(sample_ssha)
           			caxis([-14 14])
      		        shading flat
        		    title({'Anticyclonic SSH Sample',num2str(id(d(2)))})
        		    
        		    subplot(4,4,11)
        		    [sample_sst,N_sst]=workfun_trans_sample(x(d(1)),y(d(1)),bor_lat,bor_lon,bor_sst(:,:,m),BOX);
            		pcolor(sample_sst)
            		caxis([-1 1])
                        %caxis([-.08 .08])
            		hold on
            		%contour(sample_sshc,'k')
            		shading flat
            		title({'Cyclonic SST Sample',num2str(id(d(1)))}) 
            		subplot(4,4,12)
            		[sample_sst,N_sst]=workfun_trans_sample(x(d(2)),y(d(2)),bor_lat,bor_lon,bor_sst(:,:,m),BOX);
            		pcolor(sample_sst)
      		        caxis([-1 1])
                        %caxis([-.08 .08])
            		hold on
            		%contour(sample_ssha,'k')
            		shading flat
        		    title({'Anticyclonic SST Sample',num2str(id(d(2)))})
        		    
        		 else
        		    subplot(4,4,9)
		            [sample_sshc1,N_ssh]=workfun_trans_sample(x(d(1)),y(d(1)),bor_lat,bor_lon,bor_ssh(:,:,m),BOX);
            		pcolor(sample_sshc1)
            		caxis([-14 14])
            		shading flat
            		title({'Cyclonic SSH Sample',num2str(id(d(1)))})
            		subplot(4,4,10)
            		[sample_sshc2,N_ssh]=workfun_trans_sample(x(d(2)),y(d(2)),bor_lat,bor_lon,bor_ssh(:,:,m),BOX);
              		pcolor(sample_sshc2)
           			caxis([-14 14])
      		        shading flat
        		    title({'Cyclonic SSH Sample',num2str(id(d(2)))})
        		    subplot(4,4,11)
		            [sample_sst,N_sst]=workfun_trans_sample(x(d(1)),y(d(1)),bor_lat,bor_lon,bor_sst(:,:,m),BOX);
            		pcolor(sample_sst)
            		caxis([-1 1])
                        %caxis([-.08 .08])
            		hold on
            		%contour(sample_sshc1,'k')
            		shading flat
            		title({'Cyclonic SST Sample',num2str(id(d(1)))})
            		subplot(4,4,12)
              		[sample_sst,N_sst]=workfun_trans_sample(x(d(2)),y(d(2)),bor_lat,bor_lon,bor_sst(:,:,m),BOX);
            		pcolor(sample_sst)
            		caxis([-1 1])
                        %caxis([-.08 .08])
            		hold on
            		%contour(sample_sshc2,'k')
            		shading flat
            		title({'Cyclonic SST Sample',num2str(id(d(2)))})
        		    
        		  end
        	 elseif id(d)<nneg
            
		            subplot(4,4,9)
		            [sample_sshc,N_ssh]=workfun_trans_sample(x(d(1)),y(d(1)),bor_lat,bor_lon,bor_ssh(:,:,m),BOX);
            		pcolor(sample_sshc)
            		caxis([-14 14])
            		shading flat
            		title({'Cyclonic SSH Sample',num2str(id(d(1)))})
            		subplot(4,4,10)
            		
            		pcolor(nan*sample_ssh)
       		        shading flat
        		    title({'Anticyclonic SSH Sample'})
        		    
        		    subplot(4,4,11)
        		    [sample_sst,N_sst]=workfun_trans_sample(x(d(1)),y(d(1)),bor_lat,bor_lon,bor_sst(:,:,m),BOX);
            		pcolor(sample_sst)
            		shading flat
            		caxis([-1 1])
            		hold on
            		%contour(sample_sshc,'k')
            		title({'Cyclonic SST Sample',num2str(id(d(1)))}) 
            		subplot(4,4,12)
            		
            		pcolor(nan*sample_ssh)
      		        caxis([-1 1])
                        shading flat
        		    title({'Anticyclonic SST Sample'})
        		   
        	else
        			subplot(4,4,9)
            		pcolor(nan*sample_ssh)
            		
            		shading flat
            		title({'Cyclonic SSH Sample'})
            		subplot(4,4,10)
            		
            		[sample_ssha,N_ssh]=workfun_trans_sample(x(d(1)),y(d(1)),bor_lat,bor_lon,bor_ssh(:,:,m),BOX);
            		pcolor(sample_ssha)
            		caxis([-14 14])

      		        shading flat
        		    title({'Anticyclonic SSH Sample',num2str(id(d(1)))})
        		    
        		    subplot(4,4,11)
            		pcolor(nan*sample_sst)
            		shading flat
            		title({'Cyclonic SST Sample'}) 
            		subplot(4,4,12)
            		
					[sample_sst,N_sst]=workfun_trans_sample(x(d(1)),y(d(1)),bor_lat,bor_lon,bor_sst(:,:,m),BOX);
            		pcolor(sample_sst)      		        
            		caxis([-1 1])
                        %caxis([-.08 .08])
            		hold on
            		%contour(sample_ssha,'k')
            		shading flat
        		    title({'Anticyclonic SST Sample',num2str(id(d(1)))})
       end
       else
       		        subplot(4,4,9)
		            
            		pcolor(nan*sample_ssh)
            		caxis([-14 14])
            		shading flat
            		title({'Cyclonic SSH Sample'})
            		subplot(4,4,10)
            		
            		pcolor(nan*sample_ssh)

      		        shading flat
        		    title({'Anticyclonic SSH Sample'})
        		    
        		    subplot(4,4,11)
        		    
            		pcolor(nan*sample_sst)
            		shading flat
            		title({'Cyclonic SST Sample'}) 
            		subplot(4,4,12)
            		
            		pcolor(nan*sample_ssh)
      		        shading flat
        		    title({'Anticyclonic SST Sample'})
        		    
        		    end
        		    
         
            
            
            
                     
%{
            subplot(3,3,5)
            [sample_chl,N_chl]=workfun_trans_sample(x(d(1)),y(d(1)),bor_lat,bor_lon,bor_chl(:,:,m),BOX);
            pcolor(sample_chl)
            shading flat
            title({'CHL Sample',num2str(id(d))})
%}
            subplot(4,4,[13:16])
         	o=find(imet_jdays<=jdays(m));
         	axis([2451850     2454027        -450           0])
            pcolor(imet_jdays(o),-g_depth,g_temp_1d(:,o));
		    axis([2451850     2454027        -450           0])
		    set(gca,'xtick',[2451850:200:2454027],'xticklabel',[],...
		    		'tickdir','in','layer','top','clipping','off')
		    shading interp
		   	title({'Temperature from IMET Mooring'})
%		   	xlabel('Time (jdays)')
		   	ylabel('Depth')
%		   	c=colorbar;
%		   	axes(c)
%		   	ylabel('C')
			land
		    print -dpsc tmp.ps
%		    print -dpsc temp.ps
%             !sed 's/6 dpi2point mul] 0 setdash/3 dpi2point mul] 0 setdash/' temp.ps > tmp.ps
             eval(['!cp tmp.ps ' num2str(frame) '.ps']);
             eval(['!convert -quality 100 ' ...
             		num2str(frame) '.ps frame_' num2str(frame) '.pdf']);
             eval(['!toast ' num2str(frame) '.ps']);
             frame = frame+1;
 end
  %eval(['!convert -density 70x70 -rotate 90 -trim frame_*.pdf trans_sample_imet_d70.mpeg'])
  eval(['!convert -density 150x150 -rotate 90 -trim frame_*.pdf trans_sample_imet_d150.mpeg'])

case {'track_imet_ssh_id_ls'}

        load /Volumes/matlab/matlab/VOCALS/ssh_ls_filtered
        load /Volumes/matlab/matlab/VOCALS/eddy_tracks_vocals
        load /Volumes/matlab/matlab/IMET/imet_temperature_match_ssh
        load /Volumes/matlab/matlab/domains/VOCALS_REx_lat_lon
        min_jday=min(imet_jdays);
        max_jday=max(imet_jdays);
        match_time=find(jdays>= min_jday & jdays<=max_jday);
        max_lat=max(lat(:));
        min_lat=min(lat(:));
        max_lon=max(lon(:));
        min_lon=min(lon(:));
        r=sames(lat,reg_lat(:,1));
        c=sames(lon',reg_lon(1,:)');
        filtered_ssh=filtered_ssh(r,c,match_time);
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
        
        for m=1:length(match_time)
            proccesing_frame=frame-99
            clf;
            cla;
            [year,month,day] = jd2jdate(jdays(m));
            dlabel = [num2str(month) '-' num2str(day) '-' num2str(year)];
            subplot(311)
            m_proj('Miller Cylindrical','lon',[min_lon ...
                     max_lon],'lat',[min_lat max_lat]);
            m_pcolor(lon,lat,filtered_ssh(:,:,m));
            shading flat;
            hold on
            m_grid('xtick',[round(min_reg_lon):10:round(max_reg_lon)], ...
                   'ytick',[round(min_reg_lat): ...
                            5:round(max_reg_lat)],'tickdir','out', ...
                   'color','k');
            caxis([-20 20]);
            h=m_contour(lon,lat,filtered_ssh(:,:,m),[-10:2:-2], ...
                        'k--');
            [cs,h]=m_contour(lon,lat,filtered_ssh(:,:,m),[2:2: ...
                                10],'k');
            m_coast('patch',[.5 .5 .5],'edgecolor','k');
            m_plot(274.8500,-20.15,'k*','markersize',10);
            title({'CLS Merged SSH High-Pass',dlabel});
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
             m_text(294,-20,'Contour range [-10:2:2][2:2:10] cm   ','fontsize',10);
             m_text(294,-21,'Negative contours dashed   ','fontsize',10);
             hold off
            subplot(312)
         	o=find(imet_jdays<=jdays(m));
         	axis([2451850     2454027        -450           0])
            pcolor(imet_jdays(o),-g_depth,band_pass_30_100(:,o));
		    axis([2451850     2454027        -450           0])
		    set(gca,'xtick',[2451850:200:2454027],'xticklabel',[],'tickdir','in','layer','top','clipping','off')
		    rotateticklabel(gca,90);	
		    shading interp
		   	title({'Band-Pass Temperature from IMET Mooring (Span = 30-100 Days)'})
%		   	xlabel('Time (jdays)')
		   	ylabel('Depth')
%		   	c=colorbar;
%		   	axes(c)
%		   	ylabel('C')

            subplot(313)
         	o=find(imet_jdays<=jdays(m));
         	axis([2451850     2454027        -450           0])
            pcolor(imet_jdays(o),-g_depth,g_temp_1d(:,o));
		    axis([2451850     2454027        -450           0])
		    set(gca,'xtick',[2451850:200:2454027],'xticklabel',[],...
		    		'tickdir','in','layer','top','clipping','off')
		    shading interp
		   	title({'Temperature from IMET Mooring'})
%		   	xlabel('Time (jdays)')
		   	ylabel('Depth')
%		   	c=colorbar;
%		   	axes(c)
%		   	ylabel('C')
			land
		    print -dpsc temp.ps
             !sed 's/6 dpi2point mul] 0 setdash/3 dpi2point mul] 0 setdash/' temp.ps > tmp.ps
             eval(['!cp tmp.ps ' num2str(frame) '.ps']);
             eval(['!convert -quality 100 ' ...
             num2str(frame) '.ps frame_' num2str(frame) '.pdf']);
             eval(['!toast ' num2str(frame) '.ps']);
             frame = frame+1;
 end
eval(['!convert -density 150x150 frame_*.pdf tracks_imet_bp_d150.mpeg'])
%eval(['!convert -density 90x90 -trim frame_*.pdf tracks_imet_id_d90.mpeg'])

case {'track_imet_ssh_id'}

        load /Volumes/matlab/matlab/VOCALS/ssh_ls_filtered
        load /Volumes/matlab/matlab/VOCALS/eddies_v2_vocals_rex_all
        load /Volumes/matlab/matlab/IMET/imet_temperature
        load /Volumes/matlab/matlab/domains/VOCALS_REx_lat_lon
        max_reg_lat=max(reg_lat(:));
   		min_reg_lat=min(reg_lat(:));
   		max_reg_lon=max(reg_lon(:));
   		min_reg_lon=min(reg_lon(:));
   		prev_x=[];
   		prev_y=[];
   		prev_id=[];
        min_jday=min(imet_jdays);
        max_jday=max(imet_jdays);
        match_time=find(jdays>= min_jday & jdays<=max_jday);
        max_lat=max(lat(:));
        min_lat=min(lat(:));
        max_lon=max(lon(:));
        min_lon=min(lon(:));
        r=sames(lat,reg_lat(:,1));
        c=sames(lon',reg_lon(1,:)');
        filtered_ssh=filtered_ssh(r,c,match_time);
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
        
        for m=1:length(match_time)
            proccesing_frame=frame-99
            clf;
            cla;
            [year,month,day] = jd2jdate(jdays(m));
            dlabel = [num2str(month) '-' num2str(day) '-' num2str(year)];
            subplot(211)
            m_proj('Miller Cylindrical','lon',[min_lon ...
                     max_lon],'lat',[min_lat max_lat]);
            m_pcolor(lon,lat,filtered_ssh(:,:,m));
            shading flat;
            colormap(chelle)
            hold on
            m_grid('xtick',[round(min_reg_lon):10:round(max_reg_lon)], ...
                   'ytick',[round(min_reg_lat): ...
                            5:round(max_reg_lat)],'tickdir','out', ...
                   'color','k');
            caxis([-15 15]);
            h=m_contour(lon,lat,filtered_ssh(:,:,m),[-10:2:-2], ...
                        'k..');
            [cs,h]=m_contour(lon,lat,filtered_ssh(:,:,m),[2:2: ...
                                10],'k');
            m_coast('patch',[0 0 0],'edgecolor','k');
            m_plot(274.8500,-20.15,'k*','markersize',10);
            title({'AVISO Merged Filtered SSH',dlabel});
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
		    print -dpsc temp.ps
             !sed 's/6 dpi2point mul] 0 setdash/3 dpi2point mul] 0 setdash/' temp.ps > tmp.ps
             eval(['!cp tmp.ps ' num2str(frame) '.ps']);
             eval(['!convert -quality 100 ' ...
             num2str(frame) '.ps frame_' num2str(frame) '.pdf']);
             eval(['!toast ' num2str(frame) '.ps']);
             frame = frame+1;
 end
%eval(['!convert -trim -density 150x150 frame_*.pdf tracks_imet_id_d150.mpeg'])
%eval(['!convert -trim -density 90x90 frame_*.pdf tracks_imet_id_d90.mpeg'])
%eval(['!convert -trim -density 70x70 frame_*.pdf tracks_imet_id_d70.mpeg'])
             
case {'track_imet_ssh'}

        load /Volumes/matlab/matlab/VOCALS/ssh_ls_filtered
        load /Volumes/matlab/matlab/VOCALS/eddy_tracks_vocals
        load /Volumes/matlab/matlab/IMET/imet_temperatures
        load /Volumes/matlab/matlab/domains/VOCALS_REx_lat_lon
        min_jday=min(imet_jdays);
        max_jday=max(imet_jdays);
        match_time=find(jdays>= min_jday & jdays<=max_jday);
        max_lat=max(lat(:));
        min_lat=min(lat(:));
        max_lon=max(lon(:));
        min_lon=min(lon(:));
        r=sames(lat,reg_lat(:,1));
        c=sames(lon',reg_lon(1,:)');
        filtered_ssh=filtered_ssh(r,c,match_time);
        fl=find(x>=min_lon & x<=max_lon & y>=min_lat & y<=max_lat);
        x=x(fl);
        y=y(fl);
        track_jday=track_jday(fl);
        id=id(fl);
        
        for m=1:length(match_time)
            proccesing_frame=frame-99
            clf;
            cla;
            [year,month,day] = jd2jdate(jdays(m));
            dlabel = [num2str(month) '-' num2str(day) '-' num2str(year)];
            subplot(212)
         	o=find(imet_jdays<=jdays(m));
                p=find(imet_jdays==jdays(m));
         	axis([2451850     2454027        -450           0])
            pcolor(imet_jdays(o),-g_depth,g_temp_1d(:,o));
		    axis([2451850     2454027        -450           0])
		    shading interp
		   	title({'Temperature from IMET Mooring',num2str(imet_jdays(p))})
		   	xlabel('Time (jdays)')
		   	ylabel('Depth')
		   	colorbar
		    %hold on
		    subplot(211)
            m_proj('Miller Cylindrical','lon',[min_lon ...
                     max_lon],'lat',[min_lat max_lat]);
            m_pcolor(lon,lat,filtered_ssh(:,:,m));
            shading flat;
            hold on
            m_grid('xtick',[round(min_reg_lon):10:round(max_reg_lon)], ...
                   'ytick',[round(min_reg_lat): ...
                            5:round(max_reg_lat)],'tickdir','out', ...
                   'color','k');
            caxis([-20 20]);
            h=m_contour(lon,lat,filtered_ssh(:,:,m),[-10:2:-2], ...
                        'k--','linewidth',1);
            [cs,h]=m_contour(lon,lat,filtered_ssh(:,:,m),[2:2: ...
                                10],'k');
            m_coast('patch',[.5 .5 .5],'edgecolor','k');
            m_plot(274.8500,-20.15,'k*','markersize',10);
            title({'CLS Merged SSH High-Pass Contours',dlabel});
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
%             m_text(770,84,'Contour range [-10:2:2][2:2:10] cm   ','fontsize',8);
%             m_text(922,94,'Negative contours dashed   ','fontsize',8);
             hold off
             print -dpsc temp.ps
             !sed 's/6 dpi2point mul 0 setdash/1 dpi2point mul 0 setdash/' temp.ps > tmp.ps
             eval(['!cp tmp.ps ' num2str(frame) '.ps']);
             eval(['!convert -quality 100 ' ...
             num2str(frame) '.ps frame_' num2str(frame) '.pdf']);
             eval(['!toast ' num2str(frame) '.ps']);
             frame = frame+1;
 end
eval(['!convert -trim -density 150x150 frame_*.pdf tracks_imet_d150.mpeg'])
eval(['!convert -trim -density 90x90 frame_*.pdf tracks_imet_d90.mpeg'])
eval(['!convert -trim -density 70x70 frame_*.pdf tracks_imet_d70.mpeg'])
             
                    
            
 case {'track_sst'}
    for m=1:295
        proccesing_frame=frame-99
        clf;
        cla;
        [year,month,day] = jd2jdate(jdays(m));
        dlabel = [num2str(month) '-' num2str(day) '-' num2str(year)];
        m_proj('Miller Cylindrical','reg_lon',[min_reg_lon max_reg_lon],'reg_lat',[min_reg_lat ...
                            ...
                         max_reg_lat]);
        m_pcolor(reg_lon,reg_lat,filtered_sst(:,:,m));
        colormap(bwr)
        shading flat;
        m_grid('xtick',[round(min_reg_lon):10:round(max_reg_lon)],'ytick', ...
               [round(min_reg_lat): ...
                            5:round(max_reg_lat)],'tickdir','out','color', ...
               'k');
        caxis([-.05 .05]);
        hold on
        m_plot([292 272 272 292],[-16 -16 -25 -25],'color','k', ...
               'linewidth',1);
        h=m_contour(reg_lon,reg_lat,filtered_ssh(:,:,m),[-10:2:-2],'k--', ...
                    'linewidth',1);
        [cs,h]=m_contour(reg_lon,reg_lat,filtered_ssh(:,:,m),[2:2:10],'k');
        m_coast('patch',[.5 .5 .5],'edgecolor','k');
        m_plot(275,-20,'k+');
        m_plot(285,-20,'k+');
        title({'Reynolds OI SST High-Pass with Contours of Filtered SSH',dlabel});
        %m_text(1045,84,'Contour interval 1 cm','fontsize',8);
        %m_text(922,94,'Negative Contours Dashed   ','fontsize',8);
        d=find(track_jday==jdays(m));
        p=find(track_jday<=jdays(m));
        m_plot(x(d),y(d),'ko','markerfacecolor','k','markersize',1, ...
               'clip','off');
        tmp_ids=id(d);
        time_ids=id(p);
        time_xs=x(p);
        time_ys=y(p);
        for b=1:length(tmp_ids)
            tmp=tmp_ids(b);
            e=find(time_ids==tmp);
            if tmp>96005
                m_plot(time_xs(e),time_ys(e),'k--','linewidth',.5, ...
                       'clip','off');
            else
                m_plot(time_xs(e),time_ys(e),'k','linewidth',.5, ...
                       'clip','off');
            end
        end
        c=colorbar('horiz');
        axes(c);
        set(c,'position',[.15 .09 .74 .04]);
        xlabel('C');
        %m_text(770,84,'Contour range [-10:2:2][2:2:10] cm     ', ...
        %       'fontsize',8);
               %m_text(922,94,'Negative contours dashed   ','fontsize',8);
        hold off
        print -dpsc temp.ps
        !sed 's/6 dpi2point mul] 0 setdash/1 dpi2point mul] 0 setdash/' temp.ps > tmp.ps
        eval(['!cp tmp.ps ' num2str(frame) '.ps']);
        eval(['!convert -quality 100 ' num2str(frame) '.ps frame_' ...
              num2str(frame) '.pdf']);
        eval(['!toast ' num2str(frame) '.ps']);
        frame = frame+1;
    end
    !toast frames_100*
    eval(['!convert -trim -density 150x150 frame_*.pdf ' ...
          'tracks_sst_d150.mpeg'])
    eval(['!convert -trim -density 90x90 frame_*.pdf ' ...
          'tracks_sst_d90.mpeg'])
    eval(['!convert -trim -density 70x70 frame_*.pdf ' ...
          'tracks_sst_d70.mpeg'])

  case {'track_chl'}
    load /Volumes/matlab/matlab/VOCALS/chl_merged
    load /Volumes/matlab/matlab/VOCALS/ssh_ls_filtered
    load /Volumes/matlab/matlab/VOCALS/eddies_v2_vocals_all
    r=sames(reg_lat(:,1),grid_lat(:,1)-0.125);
    c=sames(reg_lon(1,:)',grid_lon(1,:)'-0.125);
    chl_anom=chl_anom(r,c,:);
    for m=8:240
        proccesing_frame=frame-99
        clf;
        cla;
        [year,month,day] = jd2jdate(mid_week_jdays(m));
        dlabel = [num2str(month) '-' num2str(day) '-' num2str(year)];
        m_proj('Miller Cylindrical','lon',[min_reg_lon max_reg_lon], ...
               'lat',[min_reg_lat max_reg_lat]);
        m_pcolor(reg_lon(:,1:240),reg_lat(:,1:240),chl_anom(:,:,m));
        shading flat;
        m_grid('xtick',[round(min_reg_lon):10:round(max_reg_lon)],'ytick',[round(min_reg_lat): ...
                5:round(max_reg_lat)],'tickdir','out','color','k');
        caxis([0 .1]);
        hold on
        m_plot([292 272 272 292],[-16 -16 -25 -25], ...
               'color','k','linewidth',1);
        % h=m_contour(reg_lon,reg_lat,filtered_ssh(:,:,m),[-10:2:-1],'k--','linewidth',1);
        %[cs,h]=m_contour(reg_lon,reg_lat,filtered_ssh(:,:,m),[1:2:10],'k');
        m_coast('patch',[.5 .5 .5],'edgecolor','k');
        m_plot(275,-20,'k+');
        m_plot(285,-20,'k+');
        title({'Merged Aqua-SeaWiFS CHL Anomaly with',['Eddy Tracks from ' ...
                            'Chelton Schlax V2'],dlabel});
        d=find(track_jday==jdays(m));
        p=find(track_jday<=jdays(m));
        m_plot(x(d),y(d),'ko','markerfacecolor', ...
               'k','markersize',2,'clip','off');
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
        xlabel('mg l^{-3}');
        %m_text(770,84,'Contour range [-10:2:2][2:2:10] cm     ','fontsize',8);
        %m_text(922,94,'Negative contours dashed   ','fontsize',8);
        hold off
        print -dpsc temp.ps
        !sed 's/6 dpi2point mul] 0 setdash/1 dpi2point mul] 0 setdash/' temp.ps > tmp.ps
        eval(['!cp tmp.ps ' num2str(frame) '.ps']);
        eval(['!convert -quality 100 ' num2str(frame) '.ps frame_' num2str(frame) '.pdf']);
        eval(['!toast ' num2str(frame) '.ps']);
        frame = frame+1;
    end 
    eval(['!convert -trim -density 150x150 frame_*.pdf tracks_chl_d150.mpeg'])
    %eval(['!convert -trim -density 90x90 frame_*.pdf tracks_chl_d90.mpeg'])
    %eval(['!convert -trim -density 70x70 frame_*.pdf tracks_chl_d70.mpeg'])
    
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
