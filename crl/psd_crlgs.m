cd /matlab/matlab/advect
set_advect
cd /matlab/matlab/crl


for m=4:7%length(lat)
	load(['/matlab/matlab/advect/line_',num2str(m),'_hov'],'nahov','cghov','qshov')
	dx=111.11*cosd(lat(m))*.25;
	x=1e5*cghov;
	y=1e5*qshov;
	z=1e5*nahov;
	x(isnan(x))=0;
	y(isnan(y))=0;
	z(isnan(z))=0;
	clear Sx Sy Sz
	for n=1:length(y(:,1))
		[Sx(n,:),f]=ppsd(x(n,:),dx,4,'tri');
		[Sy(n,:),f]=ppsd(y(n,:),dx,4,'tri');
		[Sz(n,:),f]=ppsd(z(n,:),dx,4,'tri');
	end
	mean_Sx=nanmean(Sx,1);
	mean_Sy=nanmean(Sy,1);
	mean_Sz=nanmean(Sz,1);
	
	figure(1)
	clf
	loglog(f,mean_Sx,'k')
	hold on
	loglog(f,mean_Sy,'b')
	loglog(f,mean_Sz,'r')
	legend('crlg','crl','crlna')
	axis([4e-4 3e-2 10^-3 10^3])
	line([1/250 1/250],[10^-3 10^3],'color',[.5 .5 .5],'linestyle','--')
	line([1/200 1/200],[10^-3 10^3],'color',[.5 .5 .5],'linestyle','--')
	text(1/190,2e2,'200 km','color',[.5 .5 .5])
	text(1/400,2e2,'250 km','color',[.5 .5 .5])
	title(['PSD along line ',num2str(m)])
	ylabel('m s^{-1} per 100 km per cycle/km')
	xlabel('cycles/km')
	eval(['print -dpng -r300 figs/psd_line_',num2str(m)])
end	