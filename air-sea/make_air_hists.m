curs = {'new_SP',...
		'AGR',...
		'HAW',...
		'EIO',...
		'CAR',...
		'AGU'};
		
curs_names = {'South Pacific',...
		'Agulhas Return',...
		'Hawaii',...
		'South Indian',...
		'Caribbean',...
		'Southeast Atlantic'};
				

for m=1:length(curs)
	load(['~/data/eddy/V6/',curs{m},'_lat_lon_tracks_V6'])
	ii=find(track_jday>=2452466 & track_jday<=2455159 & age>=12);
	amp=amp(ii);
	cyc=cyc(ii);
	scale=scale(ii);
	axial_speed=axial_speed(ii);

	%%%%%
	%amp
	%%%%%
	[na,bins]=hist(amp(cyc==1),15);
	nc=hist(amp(cyc==-1),bins);
	cnc=fliplr(cumsum(fliplr(nc)));
	cna=fliplr(cumsum(fliplr(na)));
	figure(1)
	clf
	set(gcf,'PaperPosition',[1 1 6 20])
	subplot(311)
	stairs(bins,100*(nc./nansum(nc)),'b','linewidth',2)
	hold on
	stairs(bins,100*(na./nansum(na)),'r','linewidth',2)
	axis tight
	D=axis;
% 	axis([5 50 0 40])
    if D(2)>60
        axis([D(1) 60 D(3) D(4)+5])
    else
        axis([D(1) D(2) D(3) D(4)+5])
    end            
	if m==1 | m==3
        set(gca,'xtick',[0 5 10 15 20])
    else
        set(gca,'xtick',[0 10 20 30 40 50])
    end
	set(gca,'fontsize',25,'fontweight','bold','LineWidth',5,'TickLength',[.02 .02],'layer','top')
	xlabel('eddy amplitude (cm)','fontsize',25,'fontweight','bold')
	title(curs_names{m},'fontsize',35,'fontweight','bold')
	
    %%%%%
	%scale
	%%%%%
	[na,bins]=hist(scale(cyc==1),15);
	nc=hist(scale(cyc==-1),bins);
	cnc=fliplr(cumsum(fliplr(nc)));
	cna=fliplr(cumsum(fliplr(na)));

	subplot(312)
	stairs(bins,100*(nc./nansum(nc)),'b','linewidth',2)
	hold on
	stairs(bins,100*(na./nansum(na)),'r','linewidth',2)
	axis tight
	D=axis;
	axis([0 250 0 35])
	set(gca,'xtick',[0 50 100 150 200 250])
	set(gca,'fontsize',25,'fontweight','bold','LineWidth',5,'TickLength',[.02 .02],'layer','top')
	text(-37,-8,'percentage of observations','Rotation',90,'fontsize',25,'fontweight','bold')
	text(55,-3.2,{'','eddy scale, L_S (km)'},'fontsize',25,'fontweight','bold')

	%%%%%
	%U
	%%%%%
	[na,bins]=hist(axial_speed(cyc==1),15);
	nc=hist(axial_speed(cyc==-1),bins);
	cnc=fliplr(cumsum(fliplr(nc)));
	cna=fliplr(cumsum(fliplr(na)));
	
	subplot(313)
	stairs(bins,100*(nc./nansum(nc)),'b','linewidth',2)
	hold on
	stairs(bins,100*(na./nansum(na)),'r','linewidth',2)
	axis tight
	D=axis;
    set(gca,'xtick',[0 10 20 30 40 50 60 70 80 90 100])
	if D(2)>80
        set(gca,'xtick',[0 20 40 60 80 100])
    end
	axis([D(1) D(2) D(3) D(4)+5])
	set(gca,'fontsize',25,'fontweight','bold','LineWidth',5,'TickLength',[.02 .02],'layer','top')
	xlabel('rotational speed, U (cm s^{-1})','fontsize',25,'fontweight','bold')
	
	eval(['print -depsc figs/hito_',curs{m}])
	%return
end	