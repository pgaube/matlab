clear
set_advect
lags=[-40:40];


for m=1:length(lat)
	load(['line_',num2str(m),'_hov'],'chov','slon','shov')
	
	
	cc=nan(length(lags),length(slon));
	cs=cc;
	ss=cc;
	
	
	for n=1:length(slon)
		cc(:,n)=pcor(chov(:,n),chov(:,n),lags);
		cs(:,n)=pcor(shov(:,n),chov(:,n),lags);
		ss(:,n)=pcor(shov(:,n),shov(:,n),lags);
	end
	
	
	
	%{
	figure(1)
	clf
	pcolor(slon,lags,ss);shading interp
	hold on
	contour(slon,lags,ss,[.2:.1:1],'k')
	contour(slon,lags,ss,[-1:.1:-.2],'k--')
	title({'SSH-SSH   ', ...
			['line ' num2str(m) '  Central lat ' num2str(lat(m)) ...
			'   Longitudes ' num2str(wlon(m)) '-' num2str(elon(m)) '    ']})
	
	xlabel('Longitude   ')
	ylabel('Lag (weeks)   ')
	colormap(chelle)
    caxis([-.5 .5])
    line([0 1000],[0 0],'color','w','linewidth',1)
   
    %colorbar('horiz')
    eval(['print -dpng -r300 figs/cor_ss_' num2str(m)])
		
	figure(2)
	clf
	pcolor(slon,lags,cc);shading interp
	hold on
	contour(slon,lags,cc,[.2:.1:1],'k')
	contour(slon,lags,cc,[-1:.1:-.2],'k--')
	title({'CHL-CHL   ', ...
			['line ' num2str(m) '  Central lat ' num2str(lat(m)) ...
			'   Longitudes ' num2str(wlon(m)) '-' num2str(elon(m)) '    ']})
	
	xlabel('Longitude   ')
	ylabel('Lag (weeks)   ')
	colormap(chelle)
    caxis([-.5 .5])
    line([0 1000],[0 0],'color','w','linewidth',1)
   
	%colorbar('horiz')
	eval(['print -dpng -r300 figs/cor_cc_' num2str(m)])
	%}
	figure(3)
	clf
	pcolor(slon,lags,cs);shading interp
	hold on
	contour(slon,lags,cs,[.2:.1:1],'k')
	contour(slon,lags,cs,[-1:.1:-.2],'k--')
	title({'SSH-CHL   ', ...
			['line ' num2str(m) '  Central lat ' num2str(lat(m)) ...
			'   Longitudes ' num2str(wlon(m)) '-' num2str(elon(m)) '    ']})
	
	xlabel('Longitude   ')
	ylabel('Lag (weeks)   ')
	colormap(chelle)
    caxis([-.5 .5])
    %colorbar('horiz')
    line([0 1000],[0 0],'color','w','linewidth',1)
   
    eval(['print -dpng -r300 figs/cor_ssh_chl_' num2str(m)])
    
    eval(['save -append line_' num2str(m) '_hov cs cc ss'])
end
