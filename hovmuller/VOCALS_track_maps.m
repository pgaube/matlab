load ~/matlab/domains/new_VOCALS_lat_lon
max_lat=max(lat);
min_lat=min(lat);
max_lon=max(lon);
min_lon=min(lon);
load ~/data/eddy/V5/new_VOCALS_lat_lon_tight_orgin_tracks.mat x y id track_jday cyc k

[track_jday,is]=sort(track_jday);
x=x(is);
y=y(is);
id=id(is);
cyc=cyc(is);
k=k(is);
ujd=unique(track_jday);

figure(1)
clf
set(gcf,'PaperPosition',[1 1 10 10])
m_proj('Equidistant cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);   
m_grid('xtick',[min_lon:20:max_lon],'ytick',[min_lat:5:max_lat],'tickdir','in','color','k','lineweight',1.5,'fontsize',18);  
hold on
for qq=1:length(ujd)
	dd=find(track_jday==ujd(qq) & k==1);
	uid=unique(id(dd));
	for m=1:length(uid)
   		ii=find(id==uid(m));
        if cyc(ii(1))>=1
        	%m_plot(x(ii),y(ii),'r','linewidth',.5)
        else
        	m_plot(x(ii),y(ii),'b','linewidth',.7)
        end
        if y(ii)>-33
        if cyc(ii(1))>=1
        	%m_plot(x(ii(1)),y(ii(1)),'k.','markersize',7)
        	%m_plot(x(ii(1)),y(ii(1)),'ko','markersize',2)
        else
        	m_plot(x(ii(1)),y(ii(1)),'b.','markersize',12)
        	%m_plot(x(ii(1)),y(ii(1)),'ko','markersize',2)
        end
        end
   	end
end  	
%m_contour(lon(rb,cb),lat(rb,cb),double(smoothn(r0(rb,cg,9),350)),[.19 .19],'color',[.5 .5 .5],'linewidth',4)
m_coast('patch',[0 0 0]);
grid
set(gca,'fontsize',18)
daspect([2 1 1])
print -depsc figs/VOCLAS_cyclones


figure(1)
clf
m_proj('Equidistant cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);   
m_grid('xtick',[min_lon:20:max_lon],'ytick',[min_lat:5:max_lat],'tickdir','in','color','k','lineweight',1.5,'fontsize',18);  
hold on
for qq=1:length(ujd)
	dd=find(track_jday==ujd(qq) & k==1);
	uid=unique(id(dd));
	for m=1:length(uid)
   		ii=find(id==uid(m));
        if cyc(ii(1))>=1
        	m_plot(x(ii),y(ii),'r','linewidth',.7)
        end
        if y(ii)>-33
        if cyc(ii(1))>=1
        	m_plot(x(ii(1)),y(ii(1)),'r.','markersize',12)
        	%m_plot(x(ii(1)),y(ii(1)),'ko','markersize',2)
      
        end
        end
   	end
end  	
%m_contour(lon(rb,cb),lat(rb,cb),double(smoothn(r0(rb,cg,9),350)),[.19 .19],'color',[.5 .5 .5],'linewidth',4)
m_coast('patch',[0 0 0]);
grid
set(gca,'fontsize',18)
daspect([2 1 1])
print -depsc figs/VOCLAS_anticyclones

   		