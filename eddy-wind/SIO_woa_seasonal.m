%
%12    24   180   360
%
%clear all
%
load chelle.pal
load pgray.pal
load ~/matlab/woa/woa05
wlat=lat;
wlon=lon;
load ~/matlab/domains/EK_lat_lon
zz=0:200;
[r,c]=imap(min(lat),max(lat),min(lon),max(lon),wlat,wlon);

rl=r(1:4:end);

%r=65
%c=102
%
load chelle.pal

pgray=flipud(colormap(gray));
st=squeeze(nanmean(ST(:,:,rl,c),3));
n=squeeze(nanmean(N(:,:,rl,c),3));
tt=squeeze(nanmean(T(:,:,rl,c),3));
ss=squeeze(nanmean(S(:,:,rl,c),3));

%mask bad data in N
%n(8,1:10,2:40)=0;
%
figure(10)
clf
set(gcf,'PaperPosition',[1 1 15 10])
st_w=squeeze(nanmean(st(5:10,:,:),1));
n_w=squeeze(nanmean(n(5:10,:,:),1));
mask=nan*n_w;
mask(~isnan(n_w))=1;
sm_n_w=smoothn(n_w,40).*mask;
mask=nan*st_w;
mask(~isnan(st_w))=1;
sm_st_w=smoothn(st_w,4).*mask;
pcolor(wlon(c),-z_n,sm_n_w);
shading interp
colormap(chelle)
set(gca,'ylim',[-200 0])
title('Winter \sigma_\theta')
caxis([0 4])
cc=colorbar;
hold on
%contour(wlon(c),-z_n,n_w,[1:7],'k')
  contour(wlon(c),-z,sm_st_w,[24:.5:26],'k','linewidth',2)
set(gca,'fontsize',30,'fontweight','bold','LineWidth',3,'TickLength',[.01 .01],'layer','top')
set(gca,'xtick',[70:10:120],'ytick',[-200:25:0])
print -dpng -r300 figs/winter_sig_n
%
mean_n_w=interp1(z_n,nanmean(n_w,2),zz,'cubic');
mean_st_w=interp1(z,nanmean(st_w,2),zz,'cubic');

%
xx=wlon(c)';
in_w=interp2(xx,z_n,n_w,xx,z);
figure(1)
clf
scatter(st_w(:),in_w(:),'g.')

figure(12)
clf
set(gcf,'PaperPosition',[1 1 15 10])
st_s=squeeze(nanmean(st([1 2 3 4 11 12],:,:),1));
n_s=squeeze(nanmean(n([1 2 3 4 11 12],:,:),1));
mask=nan*n_s;
mask(~isnan(n_s))=1;
sm_n_s=smoothn(n_s,20).*mask;
mask=nan*st_s;
mask(~isnan(st_s))=1;
sm_st_s=smoothn(st_s,4).*mask;
pcolor(wlon(c),-z_n,sm_n_s);
shading interp
colormap(chelle)
set(gca,'ylim',[-200 0])
title('Summer \sigma_\theta')
caxis([0 4])
cc=colorbar;
hold on
%contour(wlon(c),-z_n,n_w,[1:7],'k')
contour(wlon(c),-z,sm_st_s,[24:.5:26],'k','linewidth',2)
set(gca,'fontsize',30,'fontweight','bold','LineWidth',3,'TickLength',[.01 .01],'layer','top')
set(gca,'xtick',[70:10:120],'ytick',[-200:25:0])
print -dpng -r300 figs/summer_sig_n
%
mean_n_s=interp1(z_n,nanmean(sm_n_s,2),zz,'cubic');
mean_st_s=interp1(z,nanmean(st_s,2),zz,'cubic');

%
in_s=interp2(xx,z_n,n_s,xx,z);
figure(1)
hold on
scatter(st_s(:),in_s(:),'b.')
%axis ij
axis([23.5 26 0 6])

figure(3)
clf
set(gcf,'PaperPosition',[1 1 5 10])
hold on
plot(mean_st_w,mean_n_w,'g','linewidth',5)
plot(mean_st_s,mean_n_s,'b','linewidth',5)
%scatter(st_s(:),in_s(:),'b.','linewidth',4)
%scatter(st_w(:),in_w(:),'g.','linewidth',4)
axis([24.5 26.25 0 5])
axis ij
set(gca,'fontsize',25,'LineWidth',4,'TickLength',[.025 .5],'layer','top','YAxisLocation','right')
ylabel('mmol m^{-3}','fontsize',25,'fontweight','bold')
xlabel('kg m^{-3}','fontsize',25,'fontweight','bold')

box
legend('winter','summer','location',[.3 .1 .1 .2])
legend boxoff
print -dpng -r300 figs/mean_st_n
!open figs/mean_st_n.png
%
dtdz_w=smoothn(squeeze(dfdy(mean_st_w,1)),40);
dtdz_s=smoothn(squeeze(dfdy(mean_st_s,1)),200);

figure(4)
clf
set(gcf,'PaperPosition',[1 1 7 7])
subplot(122)
hold on
plot(mean_n_w,zz,'g','linewidth',5)
plot(mean_n_s,zz,'b','linewidth',5)
plot(2e7*dtdz_w,zz,'g--','linewidth',2)
plot(2e7*dtdz_s,zz,'b--','linewidth',2)
%scatter(st_s(:),in_s(:),'b.','linewidth',4)
%scatter(st_w(:),in_w(:),'g.','linewidth',4)
axis([ 0 5 0 210])
set(gca,'fontsize',15,'LineWidth',3,'TickLength',[.025 .5],'layer','top','YAxisLocation','left','xtick',[0:5],'yticklabel',[])
xlabel('mmol m^{-3} or 2 x 10^{-7}kg m^{-4}','fontsize',15,'fontweight','bold')
%ylabel('m','fontsize',25,'fontweight','bold')
text(-.4,-12,'b)   [$NO_3^-$] and $\frac{\partial\sigma_\theta}{\partial z}$','fontsize',22,'fontweight','bold','Interpreter', 'Latex')
box
axis ij
subplot(121)
hold on
plot(mean_st_w,zz,'g','linewidth',5)
plot(mean_st_s,zz,'b','linewidth',5)
%scatter(st_s(:),in_s(:),'b.','linewidth',4)
%scatter(st_w(:),in_w(:),'g.','linewidth',4)
axis([ 24 26 0 210])
set(gca,'fontsize',15,'LineWidth',3,'TickLength',[.025 .5],'layer','top','YAxisLocation','left','xtick',[24:.5:26],'yticklabel',[0:20:200])
xlabel('kg m^{-3}','fontsize',15,'fontweight','bold')
ylabel('m','fontsize',15,'fontweight','bold')
text(23.8,-12,'a)    $\sigma_\theta$','fontsize',22,'fontweight','bold','Interpreter', 'Latex')
box
axis ij
legend('winter','summer','location',[.3 .16 .07 .15])
legend boxoff

print -depsc /Users/new_gaube/Documents/Publications/gaube_chelton_eddy_wind/figures/mean_n_s_profile.eps
fixPSlinestyle('/Users/new_gaube/Documents/Publications/gaube_chelton_eddy_wind/figures/mean_n_s_profile.eps','/Users/new_gaube/Documents/Publications/gaube_chelton_eddy_wind/figures/mean_n_s_profile2.eps')
!open /Users/new_gaube/Documents/Publications/gaube_chelton_eddy_wind/figures/mean_n_s_profile.eps
!open /Users/new_gaube/Documents/Publications/gaube_chelton_eddy_wind/figures/mean_n_s_profile2.eps
return



figure(4)
clf
set(gcf,'PaperPosition',[1 1 10 10])
subplot(122)
hold on
plot(1e7*dtdz_w,zz,'g','linewidth',5)
plot(1e7*dtdz_s,zz,'b','linewidth',5)
%scatter(st_s(:),in_s(:),'b.','linewidth',4)
%scatter(st_w(:),in_w(:),'g.','linewidth',4)
axis([ 0 2 0 210])
set(gca,'fontsize',25,'LineWidth',4,'TickLength',[.025 .5],'layer','top','YAxisLocation','left','xtick',[0:5],'yticklabel',[])
xlabel('kg m^{-4}','fontsize',25,'fontweight','bold')
%ylabel('m','fontsize',25,'fontweight','bold')
title('b)   10^{-7} \times d[$NO_3^-$]/dz','fontsize',35,'fontweight','bold','Interpreter', 'Latex')
box
axis ij
subplot(121)
hold on
plot(mean_st_w,zz,'g','linewidth',5)
plot(mean_st_s,zz,'b','linewidth',5)
%scatter(st_s(:),in_s(:),'b.','linewidth',4)
%scatter(st_w(:),in_w(:),'g.','linewidth',4)
axis([ 24 26 0 210])
set(gca,'fontsize',25,'LineWidth',4,'TickLength',[.025 .5],'layer','top','YAxisLocation','left','xtick',[24:.5:26],'yticklabel',[0:20:200])
xlabel('kg m^{-3}','fontsize',25,'fontweight','bold')
ylabel('m','fontsize',25,'fontweight','bold')
title('a)    $\sigma_\theta$','fontsize',35,'fontweight','bold','Interpreter', 'Latex')
box
axis ij
legend('winter','summer','location',[.2 .16 .1 .2])
legend boxoff

return
figure(4)
clf
set(gcf,'PaperPosition',[1 1 15 10])
subplot(132)
hold on
plot(mean_n_w,-z,'g','linewidth',5)
plot(mean_n_s,-z,'b','linewidth',5)
%scatter(st_s(:),in_s(:),'b.','linewidth',4)
%scatter(st_w(:),in_w(:),'g.','linewidth',4)
axis([ 0 5 -200 0])
set(gca,'fontsize',25,'LineWidth',4,'TickLength',[.025 .5],'layer','top','YAxisLocation','left','xtick',[0:5],'yticklabel',[])
xlabel('mmol m^{-3}','fontsize',25,'fontweight','bold')
%ylabel('m','fontsize',25,'fontweight','bold')
title('a)   [$NO_3^-$] profile','fontsize',35,'fontweight','bold','Interpreter', 'Latex')
box

subplot(131)
hold on
plot(mean_st_w,-z,'g','linewidth',5)
plot(mean_st_s,-z,'b','linewidth',5)
%scatter(st_s(:),in_s(:),'b.','linewidth',4)
%scatter(st_w(:),in_w(:),'g.','linewidth',4)
axis([ 24 26 -200 0])
set(gca,'fontsize',25,'LineWidth',4,'TickLength',[.025 .5],'layer','top','YAxisLocation','left','xtick',[24:.5:26])
xlabel('kg m^{-3}','fontsize',25,'fontweight','bold')
ylabel('m','fontsize',25,'fontweight','bold')
title('b)    $\sigma_\theta$ profile','fontsize',35,'fontweight','bold','Interpreter', 'Latex')
box

subplot(133)
hold on
plot(mean_n_w,mean_st_w,'g','linewidth',5)
plot(mean_n_s,mean_st_w,'b','linewidth',5)
%scatter(st_s(:),in_s(:),'b.','linewidth',4)
%scatter(st_w(:),in_w(:),'g.','linewidth',4)
axis([0 5 24.8 26])
set(gca,'fontsize',25,'LineWidth',4,'TickLength',[.025 .5],'layer','top','YAxisLocation','right','xtick',[0:5])
ylabel('kg m^{-3}','fontsize',25,'fontweight','bold')
xlabel('mmol m^{-3}','fontsize',25,'fontweight','bold')
title('c)    $[NO_3^-] - \sigma_\theta$','fontsize',35,'fontweight','bold','Interpreter', 'Latex')
box
axis ij
legend('winter','summer','location',[.45 .16 .1 .2])
legend boxoff

print -dpng -r300 /Users/new_gaube/Documents/Publications/gaube_chelton_eddy_wind/figures/mean_n_profile
!open /Users/new_gaube/Documents/Publications/gaube_chelton_eddy_wind/figures/mean_n_profile.png

figure(1)
clf
pmap(lon,lat,nan(length(lat),length(lon)))
hold on
title('Locations of WOA transects ')

for m=1:length(rl)
	figure(1)
	m_line([wlon(c(1)) wlon(c(length(c)))],[wlat(rl(m)) wlat(rl(m))])
	m_text(wlon(c(15)),wlat(rl(m))+1,num2str(m))
	mld=squeeze(nanmean(MLD(:,rl(m),c)));
	ncd=squeeze(nanmean(NC(:,rl(m),c)));
	for pp=1:12
		figure(m+1)
		clf
		subplot(211)
		pcolor(wlon(c),-z_n,squeeze(N(pp,:,rl(m),c)));
		hold on
		shading flat
		colormap(chelle)
		caxis([0 5])
		title(['WOA [N0_3] for line ',num2str(m),' month = ',num2str(pp)])
		cc=colorbar;
		%axes(cc)
		%ylabel('\mu mol m^{-3}')
		set(gca,'ylim',[-200 0])
		subplot(212)
		st=sw_dens(squeeze(S(pp,:,rl(m),c)),sw_ptmp(squeeze(S(pp,:,rl(m),c)),squeeze(T(pp,:,rl(m),c)),z,0),0)-1000;
		pcolor(wlon(c),-z,st);
		hold on
		shading flat
		colormap(chelle)
		%caxis([22 30])
		set(gca,'ylim',[-200 0])
		title(['WOA annual \sigma_T for line ',num2str(m),' month = ',num2str(pp)])
		cc=colorbar;
		eval(['print -dpng -r300 /matlab/matlab/eddy-wind/figs/show_dud/WOA/N_',num2str(m),'_',num2str(pp)])
	end	
end	
	
