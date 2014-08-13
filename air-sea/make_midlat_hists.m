clear all

load tracks/midlat_tracks
%{
figure(10)
clf
ii=find(track_jday>=2451556 & track_jday<=2454797);
lat=-60:60;
lon=0:360;

pmap(lon,lat,[x(ii) y(ii) id(ii) cyc(ii) track_jday(ii) k(ii)],'new_track_dots')
print -depsc figs/midlat_tracks
%}
%%%%%
%scale
%%%%%
[na,bins]=hist(scale(cyc==1),60);
nc=hist(scale(cyc==-1),bins);
cnc=fliplr(cumsum(fliplr(nc)));
cna=fliplr(cumsum(fliplr(na)));
figure(1)
clf
set(gcf,'PaperPosition',[1 1 20 12])
subplot(346)
stairs(bins,100*(nc./nansum(nc)),'b','linewidth',2)
hold on
stairs(bins,100*(na./nansum(na)),'r','linewidth',2)
axis tight
D=axis;
axis([0 250 D(3) D(4)+2])
set(gca,'xtick',[0 100 200])
set(gca,'fontsize',25,'fontweight','bold','LineWidth',5,'TickLength',[.05 .1],'layer','top')

subplot(342)
stairs(bins,100*(cnc./cnc(1)),'b','linewidth',2)
hold on
stairs(bins,100*(cna./cna(1)),'r','linewidth',2)
axis tight
D=axis;
axis([0 250 D(3) D(4)+5])
set(gca,'xtick',[0 100 200])
set(gca,'fontsize',25,'fontweight','bold','LineWidth',5,'TickLength',[.05 .1],'layer','top')

%na=na./sum(na);
%nc=nc./sum(nc);
subplot(3,4,10)
plot(bins,nc./na,'k','linewidth',2)
D=axis;
axis([0 250 0 2]) 
text(0,-.75,'eddy scale, L_S (km)','fontsize',25,'fontweight','bold')
line([D(1) D(2)],[1 1],'color','k','LineWidth',2)
set(gca,'fontsize',25,'fontweight','bold','LineWidth',5,'TickLength',[.05 .1],'layer','top')
text(20,.3,'cyclonic/anticyclonic','fontsize',15)
set(gca,'xtick',[0 100 200])

%%%%%
%amp
%%%%%
[na,bins]=hist(amp(cyc==1),60);
nc=hist(amp(cyc==-1),bins);
cnc=fliplr(cumsum(fliplr(nc)));
cna=fliplr(cumsum(fliplr(na)));

subplot(345)
stairs(bins,100*(nc./nansum(nc)),'b','linewidth',2)
hold on
stairs(bins,100*(na./nansum(na)),'r','linewidth',2)
axis tight
D=axis;
axis([0 30 D(3) D(4)+2])
set(gca,'xtick',[0 10 20 30])
set(gca,'fontsize',25,'fontweight','bold','LineWidth',5,'TickLength',[.05 .1],'layer','top')
text(-8.3,3,'percentage of observations','Rotation',90,'fontsize',25,'fontweight','bold')
 
subplot(341)
stairs(bins,100*(cnc./cnc(1)),'b','linewidth',2)
hold on
stairs(bins,100*(cna./cna(1)),'r','linewidth',2)
axis tight
D=axis;
axis([0 30 D(3) D(4)+5])
set(gca,'xtick',[0 10 20 30])
set(gca,'fontsize',25,'fontweight','bold','LineWidth',5,'TickLength',[.05 .1],'layer','top')

%na=na./sum(na);
%nc=nc./sum(nc);
subplot(3,4,9)
plot(bins,nc./na,'k','linewidth',2)
D=axis;
axis([0 30 0 2])
text(0,-.65,'eddy amplitude (cm)','fontsize',25,'fontweight','bold')
line([D(1) D(2)],[1 1],'color','k','LineWidth',2)
set(gca,'fontsize',25,'fontweight','bold','LineWidth',5,'TickLength',[.05 .1],'layer','top')
text(3,.3,'cyclonic/anticyclonic','fontsize',15)
set(gca,'xtick',[0 10 20 30])
text(-6.3,.65,'ratio','Rotation',90,'fontsize',25,'fontweight','bold')
%text(20,.3,'cyclonic/anticyclonic','fontsize',15)



%%%%%
%U
%%%%%
[na,bins]=hist(axial_speed(cyc==1),60);
nc=hist(axial_speed(cyc==-1),bins);
cnc=fliplr(cumsum(fliplr(nc)));
cna=fliplr(cumsum(fliplr(na)));


subplot(347)
stairs(bins,100*(nc./nansum(nc)),'b','linewidth',2)
hold on
stairs(bins,100*(na./nansum(na)),'r','linewidth',2)
axis tight
D=axis;
axis([0 50 D(3) D(4)+2])
set(gca,'xtick',[0 10 20 30 40 50])
set(gca,'fontsize',25,'fontweight','bold','LineWidth',5,'TickLength',[.05 .1],'layer','top')

subplot(343)
stairs(bins,100*(cnc./cnc(1)),'b','linewidth',2)
hold on
stairs(bins,100*(cna./cna(1)),'r','linewidth',2)
axis tight
D=axis;
axis([0 50 D(3) D(4)+5])
set(gca,'xtick',[0 10 20 30 40 50])
set(gca,'fontsize',25,'fontweight','bold','LineWidth',5,'TickLength',[.05 .1],'layer','top')

%na=na./sum(na);
%nc=nc./sum(nc);
subplot(3,4,11)
plot(bins,nc./na,'k','linewidth',2)
D=axis;
axis([0 50 0 2])
text(-10,-.65,'rotational speed, U (cm s^{-1})','fontsize',25,'fontweight','bold')
line([D(1) D(2)],[1 1],'color','k','LineWidth',2)
set(gca,'fontsize',25,'fontweight','bold','LineWidth',5,'TickLength',[.05 .1],'layer','top')
text(7,.3,'cyclonic/anticyclonic','fontsize',15)
set(gca,'xtick',[0 10 20 30 40 50])

load new_wind_midlat_rot_comps wek_*
na=wek_a.na_cent;
nc=wek_c.nc_cent;
binsa=100*wek_a.bins_cent;
binsc=100*wek_c.bins_cent;
nc=round(interp1(binsc,nc,binsa));
nc(isnan(nc))=0;
cnc=fliplr(cumsum(fliplr(nc)));
cna=fliplr(cumsum(fliplr(na)));

subplot(348)
stairs(binsa,100*(nc./nansum(nc)),'b','linewidth',2)
hold on
stairs(binsa,100*(na./nansum(na)),'r','linewidth',2)
axis tight
D=axis;
axis([-20 20 D(3) D(4)+2])
set(gca,'xtick',[-20 -10 0 10 20])
set(gca,'ytick',[5 10 15 20])
set(gca,'fontsize',25,'fontweight','bold','LineWidth',5,'TickLength',[.05 .1],'layer','top')

subplot(344)
stairs(binsa,100*(cnc./cnc(1)),'b','linewidth',2)
hold on
stairs(binsa,100*(cna./cna(1)),'r','linewidth',2)
axis tight
D=axis;
axis([-20 20 D(3) D(4)+5])
set(gca,'xtick',[-20 -10 0 10 20])
set(gca,'ytick',[20 40 60 80 100])
set(gca,'fontsize',25,'fontweight','bold','LineWidth',5,'TickLength',[.05 .1],'layer','top')

subplot(3,4,12)
plot(binsa,nc./na,'k','linewidth',2)
D=axis;
axis([-20 20 0 2])
text(-18,-.65,'Ekman pumping, (cm d^{-1})','fontsize',25,'fontweight','bold')
line([D(1) D(2)],[1 1],'color','k','LineWidth',2)
set(gca,'fontsize',25,'fontweight','bold','LineWidth',5,'TickLength',[.05 .1],'layer','top')
text(-15,.3,'cyclonic/anticyclonic','fontsize',15)
set(gca,'xtick',[-20 -10 0 10 20])
print -depsc figs/midlat_hists
!open figs/midlat_hists.eps