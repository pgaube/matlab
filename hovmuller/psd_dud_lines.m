set_hovs

xlim=[-4+.015 0.1];
ylim=[0 .015];

for m=[24]%:length(lat)
	load(['gline_' num2str(m) '_hov'])
	dt=7; %days
	dx=111.11*cosd(lat(m))*.25;
	[ff,bb]=f_cor(lat(m));
	load tracks/section_24_tracks prop_speed
	gg=pmean(prop_speed)/100/1000*86400;
	%gg=4.8
	lambda=get_rossby([wlon(m):elon(m)],lat(m)).*1000;
	kr=linspace(-3/lambda,0,100);
	theta=-(bb.*kr)./((kr.^2)+(lambda.^-2)); %s-1
	
	figure(2)
	clf

	[S,f,k]=ppsd2d(chov,dt,dx);
	[r,c]=imap(ylim(1),ylim(2),xlim(1),xlim(2),f,k);
	S=S(r,c);
	k=1e3*k(r,c);
	f=f(r,c);
	S=log10(S);
	r=find(f(:,1)==0);
	c=find(k(1,:)>=-0.1 & k(1,:)<0.1);
	S(r,:)=nan;
	S(:,c)=nan;
	pcolor(k,f,S);shading flat
	caxis([0 2.3])
	colormap(chelle)
	line([0 0],[-.015 .015])
	line([-4 4],[0 0])
	%{
	line([-2 -2],[-.015 .015])
	line([-3 -3],[-.015 .015])
	line([-1 -1],[-.015 .015])
	line([-4 4],[.01 .01])
	line([-2 -2],[-.015 .015])
	line([-4 4],[.005 .005])
	%}
	x=f(:,1)/-gg;
	
	hold on
	
	plot(1e3*x,f(:,1),'k','linewidth',2)
	plot(1e6*kr/2/pi,theta.*86400/2/pi,'k','linewidth',2)
	axis square
	set(gca,'xlim',xlim,'ylim',ylim)
	%

	title({['PSD CHL line ',num2str(m)],['lat = ',num2str(lat(m)),'  lon = ',num2str(wlon(m)),' to ',num2str(elon(m))]})
	niceplot
	%eval(['print -dpng -r300 figs/psd_chl_line_',num2str(m)])
	
	figure(5)
	clf

	
	
	%S=smoothn(S,10);
	S=interp2(S,1);
	k=interp2(k,1);
	f=interp2(f,1);
	r=find(f(:,1)==0);
	c=find(k(1,:)>=-0.1 & k(1,:)<0.1);
	S(r,:)=nan;
	S(:,c)=nan;
	pcolor(k,f,S);shading flat
	caxis([0 2.3])
	colormap(chelle)
	line([0 0],[-.015 .015])
	line([-4 4],[0 0])
	%{
	line([-2 -2],[-.015 .015])
	line([-3 -3],[-.015 .015])
	line([-1 -1],[-.015 .015])
	line([-4 4],[.01 .01])
	line([-2 -2],[-.015 .015])
	line([-4 4],[.005 .005])
	%}
	x=f(:,1)/-gg;
	
	hold on
	
	plot(1e3*x,f(:,1),'k','linewidth',2)
	plot(1e6*kr/2/pi,theta.*86400/2/pi,'k','linewidth',2)
	axis square
	set(gca,'xlim',xlim,'ylim',ylim)
	%

	title({['PSD CHL line ',num2str(m)],['lat = ',num2str(lat(m)),'  lon = ',num2str(wlon(m)),' to ',num2str(elon(m))]})
	niceplot
	%eval(['print -dpng -r300 figs/psd_chl_line_',num2str(m)])
	
	
	figure(3)
	clf
	
	[S,f,k]=ppsd2d(full_shov,dt,dx);
	[r,c]=imap(ylim(1),ylim(2),xlim(1),xlim(2),f,k);
	S=S(r,c);
	k=1e3*k(r,c);
	f=f(r,c);
	S=log10(S);
	r=find(f(:,1)==0);
	c=find(k(1,:)>=-0.1 & k(1,:)<0.1);
	S(r,:)=nan;
	S(:,c)=nan;
	pcolor(k,f,S);shading flat
	caxis([2 5.5])
	set(gca,'xlim',xlim,'ylim',ylim)
	colormap(chelle)
	line([0 0],[-.015 .015])
	line([-4 4],[0 0])
	%{
	line([-2 -2],[-.015 .015])
	line([-3 -3],[-.015 .015])
	line([-1 -1],[-.015 .015])
	line([-4 4],[.01 .01])
	line([-2 -2],[-.015 .015])
	line([-4 4],[.005 .005])
	%}
	hold on
	x=f(:,1)/-gg;
	plot(1e3*x,f(:,1),'k','linewidth',2)
	plot(1e6*kr/2/pi,theta.*86400/2/pi,'k','linewidth',2)
	axis square
	title({['PSD SSH line ',num2str(m)],['lat = ',num2str(lat(m)),'  lon = ',num2str(wlon(m)),' to ',num2str(elon(m))]})
	niceplot
	%eval(['print -dpng -r300 figs/psd_ssh_line_',num2str(m)])
	
	figure(4)
	clf
	
	%S=smoothn(S,10);
	S=interp2(S,1);
	k=interp2(k,1);
	f=interp2(f,1);
	r=find(f(:,1)==0);
	c=find(k(1,:)>=-0.1 & k(1,:)<0.1);
	S(r,:)=nan;
	S(:,c)=nan;
	pcolor(k,f,S);shading flat
	caxis([2 5.5])
	set(gca,'xlim',xlim,'ylim',ylim)
	colormap(chelle)
	line([0 0],[-.015 .015])
	line([-4 4],[0 0])
	%{
	line([-2 -2],[-.015 .015])
	line([-3 -3],[-.015 .015])
	line([-1 -1],[-.015 .015])
	line([-4 4],[.01 .01])
	line([-2 -2],[-.015 .015])
	line([-4 4],[.005 .005])
	%}
	hold on
	x=f(:,1)/-gg;
	plot(1e3*x,f(:,1),'k','linewidth',2)
	plot(1e6*kr/2/pi,theta.*86400/2/pi,'k','linewidth',2)
	axis square
	title({['PSD SSH line ',num2str(m)],['lat = ',num2str(lat(m)),'  lon = ',num2str(wlon(m)),' to ',num2str(elon(m))]})
	niceplot
	%eval(['print -dpng -r300 figs/psd_ssh_line_',num2str(m)])
	
	
	%{
	figure(2)
	clf

	[S,f,k]=ppsd2d(chov,dt,dx);
	[r,c]=imap(ylim(1),ylim(2),xlim(1),xlim(2),f,k);
	S=S(r,c);
	k=k(r,c);
	f=f(r,c);
	S=smoothn(log10(S),10);
	S=interp2(S,1);
	k=1e3*interp2(k,1);
	f=interp2(f,1);
	r=find(f(:,1)==0);
	c=find(k(1,:)>=-0.1 & k(1,:)<0.1);
	S(r,:)=nan;
	S(:,c)=nan;
	pcolor(k,f,S);shading interp
	caxis([0 1.7])
	set(gca,'xlim',xlim,'ylim',ylim)
	colormap(chelle)
	line([0 0],[-.015 .015])
	line([-4 4],[0 0])
	line([-2 -2],[-.015 .015])
	line([-3 -3],[-.015 .015])
	line([-1 -1],[-.015 .015])
	line([-4 4],[.01 .01])
	line([-2 -2],[-.015 .015])
	line([-4 4],[.005 .005])
	
	hold on
	theta=-(bb.*kk)./((kk.^2)+(lambda.^-2));
	x=f(:,1)/-m;
	plot(1e3*x,f(:,1),'k','linewidth',2)
	plot(1e6*kk/(2*pi),60*60*24*theta/(2*pi),'k','linewidth',2)
	axis square
	%
	
	figure(3)
	clf
	
	[S,f,k]=ppsd2d(full_shov,dt,dx);
	[r,c]=imap(ylim(1),ylim(2),xlim(1),xlim(2),f,k);
	S=S(r,c);
	k=k(r,c);
	f=f(r,c);
	S=smoothn(log10(S),10);
	S=interp2(S,1);
	k=1e3*interp2(k,1);
	f=interp2(f,1);
	r=find(f(:,1)==0);
	c=find(k(1,:)>=-0.1 & k(1,:)<0.1);
	S(r,:)=nan;
	S(:,c)=nan;
	pcolor(k,f,S);shading interp
	caxis([2 5])
	set(gca,'xlim',xlim,'ylim',ylim)
	colormap(chelle)
	line([0 0],[-.015 .015])
	line([-4 4],[0 0])
	line([-2 -2],[-.015 .015])
	line([-3 -3],[-.015 .015])
	line([-1 -1],[-.015 .015])
	line([-4 4],[.01 .01])
	line([-2 -2],[-.015 .015])
	line([-4 4],[.005 .005])
	
	hold on
	
	theta=-(bb.*kk)./((kk.^2)+(lambda.^-2));
	x=f(:,1)/-m;
	plot(1e3*x,f(:,1),'k','linewidth',2)
	plot(1e6*kk,60*60*24*theta,'k','linewidth',2)
	axis square
	%eval(['print -dpng -r300 figs/' num2str(m) 'psd_chl'])
	%}
end	
	
	
