clear
set_hovs
jdays=[2450821:2454489];
[ryear,rmon,rday]=jd2jdate(jdays);
for qq=1:length(jdays)
	ryear_day(qq)=(ryear(qq)*1000)+julian(rmon(qq),rday(qq),ryear(qq),ryear(qq));
end	
	
ll=1:16;
pc=nan*ll;
	
for m=[24]%length(lat)
	load(['gline_',num2str(m),'_hov'],'clon','cjdays','full_chov','chov')
	
	%{
	%make percent cov bar graph
	figure(2)
	clf
	hold on
	pc(m)=(length(find(~isnan(raw_chov(:))))/length(raw_chov(:)))*100;
	bar(ll,pc)
	title('Percent Coverage of the raw SeaWiFS CHL Time-longitude Section  ')
	axis([0 17 0 45])
	%}
	
	%make year_day vector
	clear cyear_day
	[year,mon,day]=jd2jdate(cjdays);
	for qq=1:length(cjdays)
		cyear_day(qq)=(year(qq)*1000)+julian(mon(qq),day(qq),year(qq),year(qq));
	end	

	
	
	figure(30)
	clf
	chov=fillnans(chov);
	%subplot(121)
	h=axes;
	pcolor(clon,1:length(cjdays),chov);shading flat
	hold on
	iy=find(cyear_day==1);
	set(gca,'ytick',[1:52:length(cyear_day)]','yticklabel',...
		{int2str(cyear_day(1:52:length(cyear_day))')},'tickdir',...
		'out','layer','top','clipping','off')
	daspect([1 5 1])
	shading interp
	bb=cell2mat(basin(basin_id(m)));
	title({'Interpolated Zonaly HP Filtered SeaWiFS Chl   ', ...
			['line ' num2str(m) '  Central lat ' num2str(lat(m)) ...
			'   Longitudes ' num2str(wlon(m)) '-' num2str(elon(m)) '    ']})
	%title({['Filled SeaWiFS CHL Anomaly - Line ',num2str(m),'   ']})
	xlabel('Longitude   ')
	colormap(chelle)
	c=colorbar;
	%set(gca,'Clim',log10([0.02 5]))
	%set(gca,'Clim',log10([0.005 .7]))
    caxis([-.15 .15])
    %Tick=[.02 .1 .5 1 5];
    %Tick=[.4 .5 .6 .7 .8 .9 1 2 3];
    axes(c);
    %set(c,'YTick',log10(Tick),'YTickLabel', Tick)
    ylabel('mg m^{-3}')
	%eval(['print -dpng -r300 figs/schl_' num2str(lat(m)) '_' num2str(wlon(m)) '_' num2str(elon(m))])
	eval(['print -dpng -r300 figs/zonal_bp_schl_' num2str(m)])
	
	figure(31)
	clf
	chov=fillnans(full_chov);
	%subplot(121)
	h=axes;
	pcolor(clon,1:length(cjdays),chov);shading flat
	hold on
	iy=find(cyear_day==1);
	set(gca,'ytick',[1:52:length(cyear_day)]','yticklabel',...
		{int2str(cyear_day(1:52:length(cyear_day))')},'tickdir',...
		'out','layer','top','clipping','off')
	daspect([1 5 1])
	shading interp
	bb=cell2mat(basin(basin_id(m)));
	title({'Interpolated 2x2 Smoothed SeaWiFS Chl   ', ...
			['line ' num2str(m) '  Central lat ' num2str(lat(m)) ...
			'   Longitudes ' num2str(wlon(m)) '-' num2str(elon(m)) '    ']})
	%title({['Filled SeaWiFS CHL Anomaly - Line ',num2str(m),'   ']})
	xlabel('Longitude   ')
	colormap(chelle)
	c=colorbar;
	%set(gca,'Clim',log10([0.02 5]))
	%set(gca,'Clim',log10([0.005 .7]))
    caxis([-2 1])
    %Tick=[.02 .1 .5 1 5];
    %Tick=[.4 .5 .6 .7 .8 .9 1 2 3];
    axes(c);
    %set(c,'YTick',log10(Tick),'YTickLabel', Tick)
    ylabel('mg m^{-3}')
    
    
	%{
	subplot(122)
	pcolor(raw_clon,1:length(jdays),raw_chov);shading flat
	hold on
	iy=find(ryear_day==1);
	set(gca,'ytick',[1:365:length(ryear_day)]','yticklabel',...
		{int2str(ryear_day(1:365:length(ryear_day))')},'tickdir',...
		'out','layer','top','clipping','off')
	daspect([1 35 1])
	shading flat
	title({['Raw SeaWiFS CHL Anomaly - Line ',num2str(m),'   ']})
	xlabel('Longitude   ')
	colormap(chelle)
	%c=colorbar;
	%set(gca,'Clim',log10([0.02 5]))
	%set(gca,'Clim',log10([0.005 .7]))
    %Tick=[.02 .1 .5 1 5];
    %axes(c);
    %set(c,'YTick',log10(Tick),'YTickLabel', Tick)
    %ylabel('mg m^{-3}')
	%}
	eval(['print -dpng -r300 figs/full_schl_' num2str(m)])
	%}

end
