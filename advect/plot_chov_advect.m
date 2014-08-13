clear
set_advect
jdays=[2450821:2454489];
[ryear,rmon,rday]=jd2jdate(jdays);
for qq=1:length(jdays)
	ryear_day(qq)=(ryear(qq)*1000)+julian(rmon(qq),rday(qq),ryear(qq),ryear(qq));
end	
	
ll=1:16;
pc=nan*ll;
	
for m=1:length(lat)
	load(['line_',num2str(m),'_hov'],'clon','cjdays','hp_chov','slon','sjdays','hp_shov')
	
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
	subplot(121)
	pcolor(clon,1:length(cjdays),hp_chov);shading flat
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
    caxis([-.12 .12])

	
	subplot(122)
	pcolor(slon,1:length(sjdays),hp_shov);shading flat
	hold on
	iy=find(ryear_day==1);
	daspect([1 5 1])
	shading flat
	title({['Zonaly HP Filtered SSH Anomaly - Line ',num2str(m),'   ']})
	xlabel('Longitude   ')
	colormap(chelle)
	caxis([-20 20])
	eval(['print -dpng -r300 figs/hov_chl_ssh_' num2str(m)])

end
