clear
set_hovs

%do topo

for m=26:length(lat)
	tmp_lon=[wlon(m)-10 elon(m)+10];
	tmp_lat=[lat(m)-10 lat(m)+10];
	
	[bath,topo,blon,blat]=get_topo(tmp_lon,tmp_lat);
	figure(10)
	clf
	subplot(211)
	pmap(blon,blat,bath)
	hold on
	m_plot([wlon(m) elon(m)],[lat(m) lat(m)],'k','linewidth',2)
	m_plot([wlon(m) elon(m) elon(m) elon(m) elon(m) wlon(m) wlon(m) wlon(m)],...
		   [lat(m)-dy lat(m)-dy lat(m)-dy lat(m)+dy lat(m)+dy lat(m)+dy ...
		   lat(m)+dy lat(m)-dy],'k--','linewidth',1)
	title(['Bathymetry of line ' num2str(m) '   '])	   
	subplot(212)
	ii=find(blat(:,1)==lat(m));
	plot(blon(1,:),bath(ii,:))
	ylabel('z')
	xlabel('Longitude (degrees East)   ')
	eval(['print -dpng -r300 figs/bath_lin_' num2str(m)])
		
end
return

for m=1:length(lat)
	load(['gline_',num2str(m),'_hov'])
	
	%make year_day vector
	clear cyear_day
	[year,mon,day]=jd2jdate(cjdays);
	for qq=1:length(cjdays)
		cyear_day(qq)=(year(qq)*1000)+julian(mon(qq),day(qq),year(qq),year(qq));
	end	
	
	%{
	
	fn=filter_fft2d(shov,7,.25*111.11*cosd(lat(m)));
	figure(1)
	clf
	pcolor(slon,1:length(syear_day),fn);shading flat
	caxis([-10 10])
	hold on
	iy=find(syear_day==1);
	set(gca,'ytick',[1:80:length(syear_day)]','yticklabel',...
		{int2str(syear_day(1:80:length(syear_day))')},'tickdir',...
		'out','layer','top','clipping','off')
	daspect([1 7 1])
	shading interp
	title({['New Westward Filtered SSH Anomaly - Line ',num2str(m),'   ']})
	xlabel('Longitude   ')
	colormap(kill)
	c=colorbar;
	axes(c);
	ylabel('cm')
	eval(['print -dpng -r300 figs/ssh_' num2str(lat(m)) '_' num2str(wlon(m)) '_' num2str(elon(m))])

	fn=filter_fft2d(ehov,7,.25*111.11*cosd(lat(m)));
	figure(1)
	clf
	pcolor(elon,1:length(eyear_day),fn);shading flat
	caxis([-1 1])
	hold on
	iy=find(syear_day==1);
	set(gca,'ytick',[1:80:length(syear_day)]','yticklabel',...
		{int2str(syear_day(1:80:length(syear_day))')},'tickdir',...
		'out','layer','top','clipping','off')
	daspect([1 7 1])
	shading interp
	title({['Westward Filtered Ekman Pumping Anomaly - Line ',num2str(m),'   ']})
	xlabel('Longitude   ')
	colormap(kill)
	c=colorbar;
	axes(c);
	ylabel('cm')
	eval(['print -dpng -r300 figs/ek_' num2str(lat(m)) '_' num2str(wlon(m)) '_' num2str(elon(m))])

	figure(1)
	clf
	pcolor(clon,1:length(cjdays),chov);shading flat
	hold on
	iy=find(cyear_day==1);
	set(gca,'ytick',[1:52:length(cyear_day)-5]','yticklabel',...
		{int2str(cyear_day(1:52:length(cyear_day)-5)')},'tickdir',...
		'out','layer','top','clipping','off')
	daspect([1 5 1])
	shading interp
	title({['Filled SeaWiFS CHL Anomaly - Line ',num2str(m),'   ']})
	xlabel('Longitude   ')
	colormap(chelle)
	c=colorbar;
	set(gca,'Clim',log10([0.05 5]))
    Tick=[.05 .1 .5 1 5];
    axes(c);
    set(c,'YTick',log10(Tick),'YTickLabel', Tick)
    ylabel('mg m^{-3}')
	eval(['print -dpng -r300 figs/schl_' num2str(lat(m)) '_' num2str(wlon(m)) '_' num2str(elon(m))])
	
		
	length(find(isnan(chov)))
	%fn=filter_fft2d(fillnans(chov),7,.25);
	fn=filter_fft2d(fillnans(chov),7,.25*111.11*cosd(lat(m)));
	
	figure(2)
	clf
	pcolor(clon,1:length(cjdays),real(fn));shading flat
	caxis([-.11 .11])
	hold on
	
	iy=find(cyear_day==1);
		set(gca,'ytick',[1:52:length(cyear_day)-5]','yticklabel',...
		{int2str(cyear_day(1:52:length(cyear_day)-5)')},'tickdir',...
		'out','layer','top','clipping','off')
	daspect([1 5 1])
	shading interp
	title({['BP Filtered SeaWiFS CHL Anomaly - Line ',num2str(m),'   ']})
	xlabel('Longitude   ')
	colormap(kill)
	c=colorbar;
	axes(c);
	ylabel('log_{10}(CHL)')
	eval(['print -dpng -r300 figs/schl_fill_' num2str(lat(m)) '_' num2str(wlon(m)) '_' num2str(elon(m))])
	%eval(['print -dpng -r300 figs/schl_pghp_' num2str(lat(m)) '_' num2str(wlon(m)) '_' num2str(elon(m))])
	
	
	figure(3)
	clf
	pcolor(clon,cjdays,real(fn));shading flat
	caxis([-.11 .11])
	hold on
	ai=find(hid>=nneg);
	uai=unique(hid(ai));
	numit=length(uai);
	for p=1:numit
		pi=sames(uai(p),hid);
		plot(hx(pi),htrack_jday(pi),'k','linewidth',1)
	end
	ci=find(hid<nneg);
	uci=unique(hid(ci));
	numit=length(uci);
	for p=1:numit
		pi=sames(uci(p),hid);
		plot(hx(pi),htrack_jday(pi),'w','linewidth',1)
	end
	
	iy=find(cyear_day==1);
	set(gca,'ytick',[1:52:length(cyear_day)]','yticklabel',...
		{int2str(cyear_day(1:52:length(cyear_day))')},'tickdir',...
		'out','layer','top','clipping','off')
	daspect([1 37 1])
	shading interp
	title({['BP Filtered SeaWiFS CHL Anomaly - Line ',num2str(m),'   ']})
	xlabel('Longitude   ')
	colormap(kill)
	c=colorbar;
	axes(c);
	ylabel('log_{10}(CHL)')
	eval(['print -dpng -r300 figs/schl_pghp_' num2str(lat(m)) '_' num2str(wlon(m)) '_' num2str(elon(m))])
	%}
	
	fn_poc=filter_fft2d(fillnans(phov),7,.25*111.11*cosd(lat(m)));
	figure(5)
	clf
	pcolor(clon,cjdays,fn_poc);shading flat
	caxis([-.11 .11])
	hold on
	ai=find(hid>=nneg);
	uai=unique(hid(ai));
	numit=length(uai);
	for p=1:numit
		pi=sames(uai(p),hid);
		plot(hx(pi),htrack_jday(pi),'k','linewidth',1)
	end
	ci=find(hid<nneg);
	uci=unique(hid(ci));
	numit=length(uci);
	for p=1:numit
		pi=sames(uci(p),hid);
		plot(hx(pi),htrack_jday(pi),'w','linewidth',1)
	end
	
	iy=find(cyear_day==1);
	set(gca,'ytick',[1:52:length(cyear_day)]','yticklabel',...
		{int2str(cyear_day(1:52:length(cyear_day))')},'tickdir',...
		'out','layer','top','clipping','off')
	daspect([1 37 1])
	shading interp
	title({['WW Filtered SeaWiFS POC Anomaly - Line ',num2str(m),'   ']})
	xlabel('Longitude   ')
	colormap(kill)
	c=colorbar;
	eval(['print -dpng -r300 figs/' num2str(m) '_ww_poc'])
	clearallbut lat wlon elon kill

end
