clear
set_hovs

for m=14%:length(lat)
	
	load(['gline_',num2str(m),'_hov'],'c*','h*','fn','nneg','chov')
	new_clon=clon;
	new_clon(new_clon>180)=180+(180-new_clon(new_clon>180));
	%make year_day vector
	clear cyear_day
	[year,mon,day]=jd2jdate(cjdays);
	for qq=1:length(cjdays)
		cyear_day(qq)=(year(qq)*1000)+julian(mon(qq),day(qq),year(qq),year(qq));
	end	
	%make map indices
	load([save_path save_head num2str(cjdays(10))],'glat','glon')
	load([asave_path asave_head num2str(cjdays(10))],'lon','lat')
	slon=lon;
	slat=lat;
	load([qsave_path qsave_head num2str(cjdays(200))],'lon','lat')
	qlon=lon;
	qlat=lat;
	set_hovs
	[r,c]=imap(lat(m)-5,lat(m)+5,wlon(m)-2,elon(m)+2,glat,glon);
	[rssh,cssh]=imap(lat(m)-5,lat(m)+5,wlon(m)-2,elon(m)+2,slat,slon);
	[rq,cq]=imap(lat(m)-5,lat(m)+5,wlon(m)-2,elon(m)+2,qlat,qlon);
	for n=1:length(cjdays)
		load([save_path save_head num2str(cjdays(n))],'gchl_week','gchl_anom')
		load([asave_path asave_head num2str(cjdays(n))],'ssh')
		load([qsave_path qsave_head num2str(cjdays(n))],'w_ek')
		
		figure(1)
		clf
		subplot(221)
		pmap(qlon(rq,cq),qlat(rq,cq),w_ek(rq,cq))
		caxis([-.2 .2])
		%set(gca,'Clim',log10([0.01 10]))
		hold on
		m_plot([wlon(m) elon(m)],[lat(m) lat(m)],'k','linewidth',2)
		m_plot([wlon(m) elon(m) elon(m) elon(m) elon(m) wlon(m) wlon(m) wlon(m)],...
		[lat(m)-dy lat(m)-dy lat(m)-dy lat(m)+dy lat(m)+dy lat(m)+dy lat(m)+dy lat(m)-dy],'k--','linewidth',1)
		m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[-82:1:-1],'color', [.5 .5 .5])
		m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[1:1:82],'k')
		title('QuickSCAT Ekman Pumping 21-day rolling average   ')
		
		subplot(223)
		pmap(glon(r,c),glat(r,c),hp21_chl(r,c))
		caxis([-.3 .3])
		hold on
		m_plot([wlon(m) elon(m)],[lat(m) lat(m)],'k','linewidth',2)
		m_plot([wlon(m) elon(m) elon(m) elon(m) elon(m) wlon(m) wlon(m) wlon(m)],...
		[lat(m)-dy lat(m)-dy lat(m)-dy lat(m)+dy lat(m)+dy lat(m)+dy lat(m)+dy lat(m)-dy],'k--','linewidth',1)
		m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[-82:1:-1],'color', [.5 .5 .5])
		m_contour(slon(rssh,cssh),slat(rssh,cssh),ssh(rssh,cssh),[1:1:82],'k')
		title({'SeaWiFS anomaly 21-day rolling average   ','Contours of SSH overlaid   '})
		
		subplot(2,2,[2 4])
		mask=nan*chov;
		mask(1:n,:)=1;
		pcolor(1:length(clon),1:length(cjdays),fn.*mask);shading flat
		set(gca,'ytick',[1:52:length(cyear_day)-5]','yticklabel',...
		{int2str(cyear_day(1:52:length(cyear_day)-5)')},...
		'xtick',[1:20:length(new_clon)],'xticklabel',...
		{int2str(new_clon(1:20:length(new_clon))')},'tickdir',...
		'out','layer','top','clipping','off')
		%rotateticklabel(gca);
		daspect([1 2 1])
		shading interp
		title({['BP Filtered SeaWiFS CHL Anomaly - Line ',num2str(m),'   ']})
		xlabel('Longitude   ')
		colormap(chelle)
		caxis([-.1 .1])
		
		eval(['print -dpng frames/dud_hov/frame_' num2str(qq) '.png'])
		%eval(['!convert -trim frames/dud_hov/frame_' num2str(qq) '.png frames/dud_hov/frame_' num2str(qq) '.png'])
		qq=qq+1;
	end	
	eval(['!ffmpeg -r 5 -sameq -s hd1080 -i frames/dud_hov/frame_%d.png -y ' num2str(m) '_ek_out.mp4'])
	!toast frames/dud_hov/frame_*
	qq=1;
end

