clear all
GSM_HEAD   = 'GSM_9_21_';
GSM_PATH   = '~/data/gsm/mat/';
wdays=2451395:7:2454461;
load chelle.pal

load([GSM_PATH GSM_HEAD num2str(wdays(10))],'glon','glat')
[rg1,cg1]=imap(-27,-23,79,81,glat,glon);
[rg2,cg2]=imap(-27,-23,99,101,glat,glon);
[rg3,cg3]=imap(-27,-23,113,115,glat,glon);

%%make map

load ~/matlab/domains/EK_lat_lon.mat
elat=lat;
elon=lon;
max_lat=max(lat);
min_lat=min(lat);
max_lon=max(lon);
min_lon=min(lon);
[rb,cb]=imap(min_lat-20,max_lat+20,min_lon-40,max_lon+40,glat,glon);
load ~/data/gsm/mean_gchl.mat mean_gchl

figure(1)
clf
set(gcf,'PaperPosition',[1 1 15 10])
m_proj('Equidistant cylindrical','lon',[min_lon-40 max_lon+40],'lat',[-40 -10]);   
m_grid('xtick',[50:20:150],'ytick',[-40:10:-10],'tickdir','in','color','k','lineweight',1.5,'fontsize',18);  
hold on
m_pcolor(glon(rb,cb),glat(rb,cb),double(mean_gchl(rb,cb)))
caxis([-1.3 .1])
alpha(.5)
colormap(chelle)
shading flat
m_coast('patch',[0 0 0]);
grid
m_plot(80,-25,'b.','markersize',30)
m_plot(100,-25,'g.','markersize',30)
m_plot(113,-25,'r.','markersize',30)
m_text(69,-21,'$25^\circ$S, $80^\circ$E','color','b','fontweight','bold','fontsize',18,'Interpreter', 'Latex')
m_text(90,-30,'$25^\circ$S, $100^\circ$E','color','g','fontweight','bold','fontsize',18,'Interpreter', 'Latex')
m_text(98,-18,'$25^\circ$S, $113^\circ$E','color','r','fontweight','bold','fontsize',18,'Interpreter', 'Latex')
set(gca,'fontsize',250)
print -dpng -r300 ~/Documents/Publications/gaube_chelton_eddy_wind/figures/tmp/histo_chl_points
!open ~/Documents/Publications/gaube_chelton_eddy_wind/figures/tmp/histo_chl_points.png


weekly1=nan(length(rg1),length(cg1),length(wdays));
weekly2=nan(length(rg2),length(cg2),length(wdays));
weekly3=nan(length(rg3),length(cg3),length(wdays));


for m=1:length(wdays)
    display(wdays(m))
	load([GSM_PATH GSM_HEAD num2str(wdays(m))],'gchl_week')
	weekly1(:,:,m)=10.^gchl_week(rg1,cg1);
	weekly2(:,:,m)=10.^gchl_week(rg2,cg2);
	weekly3(:,:,m)=10.^gchl_week(rg3,cg3);
end	

save log_or_not2 weekly*

load log_or_not2
tbins=0:.006:.5;

[bw,nw1]=phist(weekly1(:),tbins);
[bw,nw2]=phist(weekly2(:),tbins);
[bw,nw3]=phist(weekly3(:),tbins);
cc=tbins(1:end-1);

figure(1)
clf
set(gcf,'PaperPosition',[1 1 8.5 11])

subplot(211)
stairs(tbins(1:end-1),100*(nw1./sum(nw1)),'b','linewidth',2)
hold on
stairs(tbins(1:end-1),100*(nw2./sum(nw2)),'g','linewidth',2)
stairs(tbins(1:end-1),100*(nw3./sum(nw3)),'r','linewidth',2)
set(gca,'xtick',[.05 .15 .25 .35 .45],'fontsize',15,'LineWidth',2,'TickLength',[.02 .02],'layer','top','YAxisLocation','left')
xlabel('mg m^{-3}','fontsize',15,'fontweight','bold')
ylabel('% of observation','fontsize',15,'fontweight','bold')
title('a)   histograms of $CHL$ at three locations','fontsize',22,'fontweight','bold','Interpreter', 'Latex')

tbins=linspace(log10(.03),log10(.6),length(tbins));
[bw,nw1]=phist(log10(weekly1(:)),tbins);
[bw,nw2]=phist(log10(weekly2(:)),tbins);
[bw,nw3]=phist(log10(weekly3(:)),tbins);
subplot(212)
stairs(tbins(1:end-1),100*(nw1./sum(nw1)),'b','linewidth',2)
hold on
stairs(tbins(1:end-1),100*(nw2./sum(nw2)),'g','linewidth',2)
stairs(tbins(1:end-1),100*(nw3./sum(nw3)),'r','linewidth',2)
set(gca,'xtick',[-1.5 -1.25 -1 -.75 -.5 -.25],'fontsize',15,'LineWidth',2,'TickLength',[.02 .02],'layer','top','YAxisLocation','left')
xlabel('log_{10}(mg m^{-3})','fontsize',15,'fontweight','bold')
ylabel('% of observations','fontsize',15,'fontweight','bold')
title('b)   histograms of $log_{10}(CHL)$ at three locations','fontsize',22,'fontweight','bold','Interpreter', 'Latex')
print -dpng -r300 ~/Documents/Publications/gaube_chelton_eddy_wind/figures/tmp/histo_chl.png
!open ~/Documents/Publications/gaube_chelton_eddy_wind/figures/tmp/histo_chl.png
return

cd /Users/gaube/Documents/Publications/gaube_chelton_eddy_wind/figures/calcom_data

save -ascii histo_chl.txt cc
cc=nd2./sum(nd2);
save -ascii histo_costal_day.txt cc
cc=nw2./sum(nw2);
save -ascii histo_costal_week.txt cc
cc=nd1./sum(nd1);
save -ascii histo_pelagic_day.txt cc
cc=nw1m./sum(nw1m);
save -ascii histo_pelagic_week_mask.txt cc
cc=nw1./sum(nw1);
save -ascii histo_pelagic_week.txt cc

tbins=linspace(-1.8,-.2,length(tbins));

[bd,nd1]=phist(log10(daily1(:)),tbins);
[bw,nw1]=phist(log10(weekly1(:)),tbins);
[bw,nw1m]=phist(log10(weekly1m(:)),tbins);
[bd,nd2]=phist(log10(daily2(:)),tbins);
[bw,nw2]=phist(log10(weekly2(:)),tbins);
cc=tbins(1:end-1);

save -ascii histo_log_chl.txt cc
cc=nd2./sum(nd2);
save -ascii histo_log_costal_day.txt cc
cc=nw2./sum(nw2);
save -ascii histo_log_costal_week.txt cc
cc=nd1./sum(nd1);
save -ascii histo_log_pelagic_day.txt cc
cc=nw1m./sum(nw1m);
save -ascii histo_log_pelagic_week_mask.txt cc
cc=nw1./sum(nw1);
save -ascii histo_log_pelagic_week.txt cc

cd /matlab/matlab/eddy-wind

figure(2)
clf
stairs(tbins(1:end-1),nd1./sum(nd1),'g')
hold on
stairs(tbins(1:end-1),nw1./sum(nw1),'b')
stairs(tbins(1:end-1),nd2./sum(nd2),'g--')
stairs(tbins(1:end-1),nw2./sum(nw2),'b--')
legend('daily pelagic','weekly pelagic','daily coastal','weekly coastal')

return

tbins=-.2:.001:.2;

[bl,nl1]=phist(log_anom1(:),tbins);
[br,nr1]=phist(raw_anom1(:),tbins);
[bl,nl2]=phist(log_anom2(:),tbins);
[br,nr2]=phist(raw_anom2(:),tbins);

figure(3)
clf
stairs(tbins(1:end-1),nl1./sum(nl1),'r')
hold on
stairs(tbins(1:end-1),nr1./sum(nr1),'b')
stairs(tbins(1:end-1),nl2./sum(nl2),'r--')
stairs(tbins(1:end-1),nr2./sum(nr2),'b--')
legend('log pelagic','raw pelgic','log coastal','raw coastal')
