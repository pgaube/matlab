%load eddies
load chelle.pal
ff=1;
dy=.25;
SCENE_RAD   = 5;
BOX = floor(2*SCENE_RAD/dy);

warning('off','all')
figure(1)
load /Volumes/matlab/matlab/domains/LW_lat_lon
max_lat=max(lat(:));
min_lat=min(lat(:));
max_lon=max(lon(:));
min_lon=min(lon(:))-15;

load /Volumes/matlab/data/AMSRE/mat/AMSRE_25_W_2452480
r=find(lat(:,1)>=min_lat & lat(:,1)<=max_lat);
c=find(lon(1,:)>=min_lon & lon(1,:)<=max_lon);

load /Volumes/matlab/data/eddy/V3/mat/AVISO_25_W_2452480
slat=lat;
slon=lon;
rs=find(slat>=min_lat & slat<=max_lat);
cs=find(slon>=min_lon & slon<=max_lon);

unid = [116177 46746];
cors = [.7806 .5650];

ianti=find(id==unid(1));
icycl=find(id==unid(2));

fir=min(cat(1,track_jday(ianti),track_jday(icycl)));
las=max(cat(1,track_jday(ianti),track_jday(icycl)));
tmp_jday=(fir:7:las);

atmp=nan(BOX+1,BOX+1,length(tmp_jday));
ctmp=nan(BOX+1,BOX+1,length(tmp_jday));
cbar=ctmp(:,:,1);
abar=atmp(:,:,1);

for m=1:length(tmp_jday)
	load(['/Volumes/matlab/data/AMSRE/mat/AMSRE_25_W_',num2str(tmp_jday(m))])
	iaa=find(track_jday(ianti)==tmp_jday(m));
	icc=find(track_jday(icycl)==tmp_jday(m));
	clf
	[yea,mon,day]=jd2jdate(tmp_jday(m));
	dd=(yea*1000)+julian(mon,day,yea,yea);
	subplot(2,2,[1:2])
	pmap(lon(r,c),lat(r,c),filtered_sst_amsre(r,c),'amsrehp',num2str(dd))
	hold on
	load(['/Volumes/matlab/data/eddy/V3/mat/AVISO_25_W_',num2str(tmp_jday(m))],'ssh','mtmp')
	if any(iaa)
		tra=find(lat(:,1)>=y(ianti(iaa))-(SCENE_RAD + dy/2) & lat(:,1)<=y(ianti(iaa))+(SCENE_RAD + dy/2));
		tca=find(lon(1,:)>=x(ianti(iaa))-(SCENE_RAD + dy/2) & lon(1,:)<=x(ianti(iaa))+(SCENE_RAD + dy/2));
		sra=find(slat>=y(ianti(iaa))-(SCENE_RAD + dy/2) & slat<=y(ianti(iaa))+(SCENE_RAD + dy/2));
		sca=find(slon>=x(ianti(iaa))-(SCENE_RAD + dy/2) & slon<=x(ianti(iaa))+(SCENE_RAD + dy/2));
		pa=find(track_jday(ianti)<=track_jday(ianti(iaa)));
		emask = mtmp;
    	emask(abs(emask) ~= eid(ianti(iaa)))=nan;
    	mask=emask;
    	mask(~isnan(mask))=1;
		m_contour(slon(cs),slat(rs),ssh(rs,cs).*mask(rs,cs),[2:2:40],'k')
		m_plot(x(ianti(iaa)),y(ianti(iaa)),'ko','markerfacecolor', ...
         			'k','markersize',4);
        m_plot(x(ianti(pa)),y(ianti(pa)),'k','linewidth',2); 		
        if length(tra) == BOX+1 & length(tca) == BOX+1
        atmp(:,:,m)=filtered_sst_amsre(tra,tca).*mask(sra,sca);
        end
        abar=nanmean(atmp,3);
   	end
	
	if any(icc)
		trc=find(lat(:,1)>=y(icycl(icc))-(SCENE_RAD + dy/2) & lat(:,1)<=y(icycl(icc))+(SCENE_RAD + dy/2));
		tcc=find(lon(1,:)>=x(icycl(icc))-(SCENE_RAD + dy/2) & lon(1,:)<=x(icycl(icc))+(SCENE_RAD + dy/2));
		src=find(slat>=y(icycl(icc))-(SCENE_RAD + dy/2) & slat<=y(icycl(icc))+(SCENE_RAD + dy/2));
		scc=find(slon>=x(icycl(icc))-(SCENE_RAD + dy/2) & slon<=x(icycl(icc))+(SCENE_RAD + dy/2));
		pc=find(track_jday(icycl)<=track_jday(icycl(icc)));
		emask = mtmp;
    	emask(abs(emask) ~= eid(icycl(icc)))=nan;
    	mask=emask;
    	mask(~isnan(mask))=1;
		m_contour(slon(cs),slat(rs),ssh(rs,cs).*mask(rs,cs),[-40:2:-2],'w')
		m_plot(x(icycl(icc)),y(icycl(icc)),'color','w','markerfacecolor', ...
         			'w','markersize',4);
        m_plot(x(icycl(pc)),y(icycl(pc)),'color','w','linewidth',2); 
        if length(trc) == BOX+1 & length(tcc) == BOX+1
        ctmp(:,:,m)=filtered_sst_amsre(trc,tcc).*mask(src,scc);
        end
        cbar=nanmean(ctmp,3);
   	end
	hax=subplot(2,2,3);
	pcolor(cbar);shading flat
	axis equal
	
	set(hax,'xtick',1:8:41,'ytick',1:8:41,'xticklabel',[],'yticklabel',[],'xminortick','on','yminortick','on','ticklength',[.06 .06],'linewidth',1)
	%set(hax,'xtick',1:8:41,'ytick',1:8:41,'xticklabel',abs(-5:2:5),'yticklabel',abs(-5:2:5),'xminortick','on','yminortick','on')
	%ylabel({'Distance from Eddy Center','(100 km)',''})
	%xlabel({'Distance from Eddy Center','(100 km)',''})
	%rotateticklabel(hax,90);
	caxis([-1.1 1.1])
	colormap(chelle)
	hold on
	line([0 41],[21 21],'color','k')
	line([21 21],[0 41],'color','k')
	axis([1 41 1 41])
	title({'Cyclonic Eddy 46746'})
	qw=colorbar;
	axes(qw)
	set(qw,'position',[.515 .14 .02 .3])
    xlabel('^{\circ}C')
    
	hax=subplot(2,2,4);
	pcolor(abar);shading flat
	axis equal
	set(hax,'xtick',1:8:41,'ytick',1:8:41,'xticklabel',[],'yticklabel',[],'xminortick','on','yminortick','on','ticklength',[.06 .06],'linewidth',1)
	%set(hax,'xtick',1:8:41,'ytick',1:8:41,'xticklabel',abs(-5:2:5),'yticklabel',abs(-5:2:5),'xminortick','on','yminortick','on')
	%ylabel({'Distance from Eddy Center','(100 km)',''})
	%xlabel({'Distance from Eddy Center','(100 km)',''})
	set(hax,'yaxislocation','right')
	%rotateticklabel(hax,90);
	caxis([-1.1 1.1])
	colormap(chelle)
	hold on
	line([0 41],[21 21],'color','k')
	line([21 21],[0 41],'color','k')
	axis([1 41 1 41])
	title({'Anticyclonic Eddy 116177'})
	%qw=colorbar;
	%axes(qw)
	%set(qw,'yaxislocation','right')
    %ylabel('^{\circ}C')
	%xlabel(['ID = ', num2str(id(itid(n))), '  cor = ' num2str(cors(ee))  '  k = ',num2str(k(itid(n))), ' of ' , num2str(max(k(itid)))...
	%			'  U/c = ',num2str(axial_speed(itid(n))/prop_speed(itid(n))),'  Amp = ',num2str(amp(itid(n)))],'color','k')
	eval(['print -dpng frames/famsre_trans_boc/frame_' num2str(ff) '.png'])
	%eval(['!convert -trim frame_' num2str(ff) '.png frame_' num2str(ff) ...
    %		'.png'])
	ff=ff+1;
	drawnow
		
end	
!ffmpeg -r 5 -sameq -i frames/famsre_trans_boc/frame_%d.png -y lw_famsre_composite.mp4
