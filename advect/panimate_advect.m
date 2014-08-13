clear
set_advect


for m=28%:length(lat)
	
	!toast frames/work_panimate/frame_*
	spath='/Volumes/matlab/data/gsm/mat/GSM_9_21_';
	asave='/Volumes/matlab/data/eddy/V4/mat/AVISO_25_W_';
	load([spath '2454769'],'glon','glat','jdays')
	load([asave '2454769'],'lon','lat')
	slon=lon;
	slat=lat;
	startjd=2450849;
	endjd=2454832;
	jdays=[startjd:7:endjd];
	%make map indices
	set_advect
	[r,c]=imap(lat(m)-5,lat(m)+5,wlon(m)-2,elon(m)+2,glat,glon);
	[rssh,cssh]=imap(lat(m)-5,lat(m)+5,wlon(m)-2,elon(m)+2,slat,slon);
	for n=1:length(jdays)
		load([spath num2str(jdays(n))],'gchl_week','nbp21_chl')
		load([asave num2str(jdays(n))],'ssh')
		
		[yea,mon,day]=jd2jdate(jdays(n));
		figure(1)
		clf
		subplot(211)
		pmap(glon(r,c),glat(r,c),gchl_week(r,c))
		%caxis([-.12 .12])
		%caxis([-1.4 -.8])
		caxis([-2 -.9])
		hold on
		m_plot([wlon(m) elon(m)],[lat(m) lat(m)],'k','linewidth',2)
		m_plot([wlon(m) elon(m) elon(m) elon(m) elon(m) wlon(m) wlon(m) wlon(m)],...
		[lat(m)-dy lat(m)-dy lat(m)-dy lat(m)+dy lat(m)+dy lat(m)+dy lat(m)+dy lat(m)-dy],'k--','linewidth',1)
		m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[-82:2:-2],'color', [.5 .5 .5])
		m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[2:2:82],'k')
		title({'SeaWiFS 30-day interpolated   '})
		colormap(chelle)
		xlabel([num2str(jdays(n))])
		
		subplot(212)
		pmap(glon(r,c),glat(r,c),nbp21_chl(r,c))
		caxis([-.12 .12])
		hold on
		m_plot([wlon(m) elon(m)],[lat(m) lat(m)],'k','linewidth',2)
		m_plot([wlon(m) elon(m) elon(m) elon(m) elon(m) wlon(m) wlon(m) wlon(m)],...
		[lat(m)-dy lat(m)-dy lat(m)-dy lat(m)+dy lat(m)+dy lat(m)+dy lat(m)+dy lat(m)-dy],'k--','linewidth',1)
		m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[-82:2:-2],'color', [.5 .5 .5])
		m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[2:2:82],'k')
		title({'SeaWiFS 30day , 2x2 by 20x10   '})
		colormap(chelle)
		xlabel({['line ' num2str(m)]})
				
		eval(['print -dpng frames/work_panimate/frame_' num2str(qq) '.png'])
		eval(['!convert -trim frames/work_panimate/frame_' num2str(qq) '.png frames/work_panimate/frame_' num2str(qq) '.png'])
		qq=qq+1;
	end	
	eval(['!ffmpeg -sameq -i frames/work_panimate/frame_%d.png -y ani_chl_bp26_' num2str(m) '.mpg'])
	%!toast frames/dud_hov/frame_*
	qq=1;
end

