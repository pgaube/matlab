tend=12
dft=1:tend;
xp=[dft dft(end) fliplr(dft) dft(1)];

load pop_rings_amp_weeks_comps


%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%
%% PP
%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%
%%%%
% Small PP
%%%%
ts_a=smooth1d_loess(small_pp_a.ks_c,1:length(small_pp_a.ks_c),6,1:tend);
std_ts_a=smooth1d_loess(small_pp_a.ks_std_05,1:1:length(small_pp_a.ks_c),6,1:tend);
n_ts_a=small_pp_a.ks_n(1:tend);

ts_c=smooth1d_loess(small_pp_c.ks_c,1:length(small_pp_c.ks_c),6,1:tend);
std_ts_c=smooth1d_loess(small_pp_c.ks_std_05,1:1:length(small_pp_c.ks_c),6,1:tend);
n_ts_c=small_pp_c.ks_n(1:tend);

ci_a=abs(std_ts_a.*tinv((.05)/2,n_ts_a-1)./sqrt(n_ts_a-1));
ci_c=abs(std_ts_c.*tinv((.05)/2,n_ts_c-1)./sqrt(n_ts_c-1));
xts_a=[ts_a-ci_a ts_a(end)+ci_a(end) fliplr(ts_a+ci_a) ts_a(1)-ci_a(1)];
xts_c=[ts_c-ci_c ts_c(end)+ci_c(end) fliplr(ts_c+ci_c) ts_c(1)-ci_c(1)];

figure(3)
clf
set(gcf,'PaperPosition',[1 1 10 5.5])
patch(xp,xts_a,[.8 .8 .8])
patch(xp,xts_c,[.8 .8 .8])
hold on
plot(dft,ts_a,'r','linewidth',4)
hold on
plot(dft,ts_c,'b','linewidth',4)
axis tight

xlabel('eddy age (weeks)','fontsize',20,'fontweight','bold')
ylabel(['mg m^{-3} per second?'],'fontsize',20,'fontweight','bold')
line([1 40],[0 0],'color','k','LineWidth',2)
set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top')
set(gca,'xtick',[0:2:20])
box
title(['Small PP',' GS rings'])
print -dpng -r300 figs/small_pp_ts

%%%%
% Diaz SS
%%%%
ts_a=smooth1d_loess(diaz_pp_a.ks_c,1:length(diaz_pp_a.ks_c),6,1:tend);
std_ts_a=smooth1d_loess(diaz_pp_a.ks_std_05,1:1:length(diaz_pp_a.ks_c),6,1:tend);
n_ts_a=diaz_pp_a.ks_n(1:tend);

ts_c=smooth1d_loess(diaz_pp_c.ks_c,1:length(diaz_pp_c.ks_c),6,1:tend);
std_ts_c=smooth1d_loess(diaz_pp_c.ks_std_05,1:1:length(diaz_pp_c.ks_c),6,1:tend);
n_ts_c=diaz_pp_c.ks_n(1:tend);

ci_a=abs(std_ts_a.*tinv((.05)/2,n_ts_a-1)./sqrt(n_ts_a-1));
ci_c=abs(std_ts_c.*tinv((.05)/2,n_ts_c-1)./sqrt(n_ts_c-1));
xts_a=[ts_a-ci_a ts_a(end)+ci_a(end) fliplr(ts_a+ci_a) ts_a(1)-ci_a(1)];
xts_c=[ts_c-ci_c ts_c(end)+ci_c(end) fliplr(ts_c+ci_c) ts_c(1)-ci_c(1)];

figure(3)
clf
set(gcf,'PaperPosition',[1 1 10 5.5])
patch(xp,xts_a,[.8 .8 .8])
patch(xp,xts_c,[.8 .8 .8])
hold on
plot(dft,ts_a,'r','linewidth',4)
hold on
plot(dft,ts_c,'b','linewidth',4)
axis tight

xlabel('eddy age (weeks)','fontsize',20,'fontweight','bold')
ylabel(['mg m^{-3} per second?'],'fontsize',20,'fontweight','bold')
line([1 40],[0 0],'color','k','LineWidth',2)
set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top')
set(gca,'xtick',[0:2:20])
box
title(['Diaz PP',' GS rings'])
print -dpng -r300 figs/diaz_pp_ts

%%%%
% Diat SS
%%%%
ts_a=smooth1d_loess(diat_pp_a.ks_c,1:length(diat_pp_a.ks_c),6,1:tend);
std_ts_a=smooth1d_loess(diat_pp_a.ks_std_05,1:1:length(diat_pp_a.ks_c),6,1:tend);
n_ts_a=diat_pp_a.ks_n(1:tend);

ts_c=smooth1d_loess(diat_pp_c.ks_c,1:length(diat_pp_c.ks_c),6,1:tend);
std_ts_c=smooth1d_loess(diat_pp_c.ks_std_05,1:1:length(diat_pp_c.ks_c),6,1:tend);
n_ts_c=diat_pp_c.ks_n(1:tend);

ci_a=abs(std_ts_a.*tinv((.05)/2,n_ts_a-1)./sqrt(n_ts_a-1));
ci_c=abs(std_ts_c.*tinv((.05)/2,n_ts_c-1)./sqrt(n_ts_c-1));
xts_a=[ts_a-ci_a ts_a(end)+ci_a(end) fliplr(ts_a+ci_a) ts_a(1)-ci_a(1)];
xts_c=[ts_c-ci_c ts_c(end)+ci_c(end) fliplr(ts_c+ci_c) ts_c(1)-ci_c(1)];

figure(3)
clf
set(gcf,'PaperPosition',[1 1 10 5.5])
patch(xp,xts_a,[.8 .8 .8])
patch(xp,xts_c,[.8 .8 .8])
hold on
plot(dft,ts_a,'r','linewidth',4)
hold on
plot(dft,ts_c,'b','linewidth',4)
axis tight

xlabel('eddy age (weeks)','fontsize',20,'fontweight','bold')
ylabel(['mg m^{-3} per second?'],'fontsize',20,'fontweight','bold')
line([1 40],[0 0],'color','k','LineWidth',2)
set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top')
set(gca,'xtick',[0:2:20])
box
title(['Diat PP',' GS rings'])
print -dpng -r300 figs/diat_pp_ts




%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%
%% Vertical Advection
%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%
%%%%
% Small
%%%%
ts_a=smooth1d_loess(small_vadv_a.ks_c,1:length(small_vadv_a.ks_c),6,1:tend);
std_ts_a=smooth1d_loess(small_vadv_a.ks_std_05,1:1:length(small_vadv_a.ks_c),6,1:tend);
n_ts_a=small_vadv_a.ks_n(1:tend);

ts_c=smooth1d_loess(small_vadv_c.ks_c,1:length(small_vadv_c.ks_c),6,1:tend);
std_ts_c=smooth1d_loess(small_vadv_c.ks_std_05,1:1:length(small_vadv_c.ks_c),6,1:tend);
n_ts_c=small_vadv_c.ks_n(1:tend);

ci_a=abs(std_ts_a.*tinv((.05)/2,n_ts_a-1)./sqrt(n_ts_a-1));
ci_c=abs(std_ts_c.*tinv((.05)/2,n_ts_c-1)./sqrt(n_ts_c-1));
xts_a=[ts_a-ci_a ts_a(end)+ci_a(end) fliplr(ts_a+ci_a) ts_a(1)-ci_a(1)];
xts_c=[ts_c-ci_c ts_c(end)+ci_c(end) fliplr(ts_c+ci_c) ts_c(1)-ci_c(1)];

figure(3)
clf
set(gcf,'PaperPosition',[1 1 10 5.5])
patch(xp,xts_a,[.8 .8 .8])
patch(xp,xts_c,[.8 .8 .8])
hold on
plot(dft,ts_a,'r','linewidth',4)
hold on
plot(dft,ts_c,'b','linewidth',4)
axis tight

xlabel('eddy age (weeks)','fontsize',20,'fontweight','bold')
ylabel(['mg m^{-3} per second?'],'fontsize',20,'fontweight','bold')
line([1 40],[0 0],'color','k','LineWidth',2)
set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top')
set(gca,'xtick',[0:2:20])
box
title(['Small Phyto Vertical Adv',' GS rings'])
print -dpng -r300 figs/small_vadv_ts

%%%%
% Diaz
%%%%
ts_a=smooth1d_loess(diaz_vadv_a.ks_c,1:length(diaz_vadv_a.ks_c),6,1:tend);
std_ts_a=smooth1d_loess(diaz_vadv_a.ks_std_05,1:1:length(diaz_vadv_a.ks_c),6,1:tend);
n_ts_a=diaz_vadv_a.ks_n(1:tend);

ts_c=smooth1d_loess(diaz_vadv_c.ks_c,1:length(diaz_vadv_c.ks_c),6,1:tend);
std_ts_c=smooth1d_loess(diaz_vadv_c.ks_std_05,1:1:length(diaz_vadv_c.ks_c),6,1:tend);
n_ts_c=diaz_vadv_c.ks_n(1:tend);

ci_a=abs(std_ts_a.*tinv((.05)/2,n_ts_a-1)./sqrt(n_ts_a-1));
ci_c=abs(std_ts_c.*tinv((.05)/2,n_ts_c-1)./sqrt(n_ts_c-1));
xts_a=[ts_a-ci_a ts_a(end)+ci_a(end) fliplr(ts_a+ci_a) ts_a(1)-ci_a(1)];
xts_c=[ts_c-ci_c ts_c(end)+ci_c(end) fliplr(ts_c+ci_c) ts_c(1)-ci_c(1)];

figure(3)
clf
set(gcf,'PaperPosition',[1 1 10 5.5])
patch(xp,xts_a,[.8 .8 .8])
patch(xp,xts_c,[.8 .8 .8])
hold on
plot(dft,ts_a,'r','linewidth',4)
hold on
plot(dft,ts_c,'b','linewidth',4)
axis tight

xlabel('eddy age (weeks)','fontsize',20,'fontweight','bold')
ylabel(['mg m^{-3} per second?'],'fontsize',20,'fontweight','bold')
line([1 40],[0 0],'color','k','LineWidth',2)
set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top')
set(gca,'xtick',[0:2:20])
box
title(['Diaz Vertical Adv',' GS rings'])
print -dpng -r300 figs/diaz_vadv_ts

%%%%
% Diat
%%%%
ts_a=smooth1d_loess(diat_vadv_a.ks_c,1:length(diat_vadv_a.ks_c),6,1:tend);
std_ts_a=smooth1d_loess(diat_vadv_a.ks_std_05,1:1:length(diat_vadv_a.ks_c),6,1:tend);
n_ts_a=diat_vadv_a.ks_n(1:tend);

ts_c=smooth1d_loess(diat_vadv_c.ks_c,1:length(diat_vadv_c.ks_c),6,1:tend);
std_ts_c=smooth1d_loess(diat_vadv_c.ks_std_05,1:1:length(diat_vadv_c.ks_c),6,1:tend);
n_ts_c=diat_vadv_c.ks_n(1:tend);

ci_a=abs(std_ts_a.*tinv((.05)/2,n_ts_a-1)./sqrt(n_ts_a-1));
ci_c=abs(std_ts_c.*tinv((.05)/2,n_ts_c-1)./sqrt(n_ts_c-1));
xts_a=[ts_a-ci_a ts_a(end)+ci_a(end) fliplr(ts_a+ci_a) ts_a(1)-ci_a(1)];
xts_c=[ts_c-ci_c ts_c(end)+ci_c(end) fliplr(ts_c+ci_c) ts_c(1)-ci_c(1)];

figure(3)
clf
set(gcf,'PaperPosition',[1 1 10 5.5])
patch(xp,xts_a,[.8 .8 .8])
patch(xp,xts_c,[.8 .8 .8])
hold on
plot(dft,ts_a,'r','linewidth',4)
hold on
plot(dft,ts_c,'b','linewidth',4)
axis tight

xlabel('eddy age (weeks)','fontsize',20,'fontweight','bold')
ylabel(['mg m^{-3} per second?'],'fontsize',20,'fontweight','bold')
line([1 40],[0 0],'color','k','LineWidth',2)
set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top')
set(gca,'xtick',[0:2:20])
box
title(['Diat Vertical Adv',' GS rings'])
print -dpng -r300 figs/diat_vadv_ts




%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%
%% Upwelling
%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%

ts_a=smooth1d_loess(w_a.ks_c,1:length(w_a.ks_c),6,1:tend);
std_ts_a=smooth1d_loess(w_a.ks_std_05,1:1:length(w_a.ks_c),6,1:tend);
n_ts_a=w_a.ks_n(1:tend);

ts_c=smooth1d_loess(w_c.ks_c,1:length(w_c.ks_c),6,1:tend);
std_ts_c=smooth1d_loess(w_c.ks_std_05,1:1:length(w_c.ks_c),6,1:tend);
n_ts_c=w_c.ks_n(1:tend);

ci_a=abs(std_ts_a.*tinv((.05)/2,n_ts_a-1)./sqrt(n_ts_a-1));
ci_c=abs(std_ts_c.*tinv((.05)/2,n_ts_c-1)./sqrt(n_ts_c-1));
xts_a=[ts_a-ci_a ts_a(end)+ci_a(end) fliplr(ts_a+ci_a) ts_a(1)-ci_a(1)];
xts_c=[ts_c-ci_c ts_c(end)+ci_c(end) fliplr(ts_c+ci_c) ts_c(1)-ci_c(1)];

figure(3)
clf
set(gcf,'PaperPosition',[1 1 10 5.5])
patch(xp,xts_a,[.8 .8 .8])
patch(xp,xts_c,[.8 .8 .8])
hold on
plot(dft,ts_a,'r','linewidth',4)
hold on
plot(dft,ts_c,'b','linewidth',4)
axis tight

xlabel('eddy age (weeks)','fontsize',20,'fontweight','bold')
ylabel(['m per second?'],'fontsize',20,'fontweight','bold')
line([1 40],[0 0],'color','k','LineWidth',2)
set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top')
set(gca,'xtick',[0:2:20])
box
title(['Vertical velocity',' GS rings'])
print -dpng -r300 figs/w_ts

%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%
%% Sorces/Sinks
%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%
%%%%
% Small SS
%%%%
ts_a=smooth1d_loess(small_bio_a.ks_c,1:length(small_bio_a.ks_c),6,1:tend);
std_ts_a=smooth1d_loess(small_bio_a.ks_std_05,1:1:length(small_bio_a.ks_c),6,1:tend);
n_ts_a=small_bio_a.ks_n(1:tend);

ts_c=smooth1d_loess(small_bio_c.ks_c,1:length(small_bio_c.ks_c),6,1:tend);
std_ts_c=smooth1d_loess(small_bio_c.ks_std_05,1:1:length(small_bio_c.ks_c),6,1:tend);
n_ts_c=small_bio_c.ks_n(1:tend);

ci_a=abs(std_ts_a.*tinv((.05)/2,n_ts_a-1)./sqrt(n_ts_a-1));
ci_c=abs(std_ts_c.*tinv((.05)/2,n_ts_c-1)./sqrt(n_ts_c-1));
xts_a=[ts_a-ci_a ts_a(end)+ci_a(end) fliplr(ts_a+ci_a) ts_a(1)-ci_a(1)];
xts_c=[ts_c-ci_c ts_c(end)+ci_c(end) fliplr(ts_c+ci_c) ts_c(1)-ci_c(1)];

figure(3)
clf
set(gcf,'PaperPosition',[1 1 10 5.5])
patch(xp,xts_a,[.8 .8 .8])
patch(xp,xts_c,[.8 .8 .8])
hold on
plot(dft,ts_a,'r','linewidth',4)
hold on
plot(dft,ts_c,'b','linewidth',4)
axis tight

xlabel('eddy age (weeks)','fontsize',20,'fontweight','bold')
ylabel(['mg m^{-3} per second?'],'fontsize',20,'fontweight','bold')
line([1 40],[0 0],'color','k','LineWidth',2)
set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top')
set(gca,'xtick',[0:2:20])
box
title(['Small biological sources/sinks',' GS rings'])
print -dpng -r300 figs/small_bio_ts

%%%%
% Diaz SS
%%%%
ts_a=smooth1d_loess(diaz_bio_a.ks_c,1:length(diaz_bio_a.ks_c),6,1:tend);
std_ts_a=smooth1d_loess(diaz_bio_a.ks_std_05,1:1:length(diaz_bio_a.ks_c),6,1:tend);
n_ts_a=diaz_bio_a.ks_n(1:tend);

ts_c=smooth1d_loess(diaz_bio_c.ks_c,1:length(diaz_bio_c.ks_c),6,1:tend);
std_ts_c=smooth1d_loess(diaz_bio_c.ks_std_05,1:1:length(diaz_bio_c.ks_c),6,1:tend);
n_ts_c=diaz_bio_c.ks_n(1:tend);

ci_a=abs(std_ts_a.*tinv((.05)/2,n_ts_a-1)./sqrt(n_ts_a-1));
ci_c=abs(std_ts_c.*tinv((.05)/2,n_ts_c-1)./sqrt(n_ts_c-1));
xts_a=[ts_a-ci_a ts_a(end)+ci_a(end) fliplr(ts_a+ci_a) ts_a(1)-ci_a(1)];
xts_c=[ts_c-ci_c ts_c(end)+ci_c(end) fliplr(ts_c+ci_c) ts_c(1)-ci_c(1)];

figure(3)
clf
set(gcf,'PaperPosition',[1 1 10 5.5])
patch(xp,xts_a,[.8 .8 .8])
patch(xp,xts_c,[.8 .8 .8])
hold on
plot(dft,ts_a,'r','linewidth',4)
hold on
plot(dft,ts_c,'b','linewidth',4)
axis tight

xlabel('eddy age (weeks)','fontsize',20,'fontweight','bold')
ylabel(['mg m^{-3} per second?'],'fontsize',20,'fontweight','bold')
line([1 40],[0 0],'color','k','LineWidth',2)
set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top')
set(gca,'xtick',[0:2:20])
box
title(['Diaz biological sources/sink',' GS rings'])
print -dpng -r300 figs/diaz_bio_ts

%%%%
% Diat SS
%%%%
ts_a=smooth1d_loess(diat_bio_a.ks_c,1:length(diat_bio_a.ks_c),6,1:tend);
std_ts_a=smooth1d_loess(diat_bio_a.ks_std_05,1:1:length(diat_bio_a.ks_c),6,1:tend);
n_ts_a=diat_bio_a.ks_n(1:tend);

ts_c=smooth1d_loess(diat_bio_c.ks_c,1:length(diat_bio_c.ks_c),6,1:tend);
std_ts_c=smooth1d_loess(diat_bio_c.ks_std_05,1:1:length(diat_bio_c.ks_c),6,1:tend);
n_ts_c=diat_bio_c.ks_n(1:tend);

ci_a=abs(std_ts_a.*tinv((.05)/2,n_ts_a-1)./sqrt(n_ts_a-1));
ci_c=abs(std_ts_c.*tinv((.05)/2,n_ts_c-1)./sqrt(n_ts_c-1));
xts_a=[ts_a-ci_a ts_a(end)+ci_a(end) fliplr(ts_a+ci_a) ts_a(1)-ci_a(1)];
xts_c=[ts_c-ci_c ts_c(end)+ci_c(end) fliplr(ts_c+ci_c) ts_c(1)-ci_c(1)];

figure(3)
clf
set(gcf,'PaperPosition',[1 1 10 5.5])
patch(xp,xts_a,[.8 .8 .8])
patch(xp,xts_c,[.8 .8 .8])
hold on
plot(dft,ts_a,'r','linewidth',4)
hold on
plot(dft,ts_c,'b','linewidth',4)
axis tight

xlabel('eddy age (weeks)','fontsize',20,'fontweight','bold')
ylabel(['mg m^{-3} per second?'],'fontsize',20,'fontweight','bold')
line([1 40],[0 0],'color','k','LineWidth',2)
set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top')
set(gca,'xtick',[0:2:20])
box
title(['Diat biological sources/sink',' GS rings'])
print -dpng -r300 figs/diat_bio_ts




%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%
%% NUTS
%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%


%%%%
% PO4
%%%%
ts_a=smooth1d_loess(po4_a.ks_c,1:length(po4_a.ks_c),6,1:tend);
std_ts_a=smooth1d_loess(po4_a.ks_std_05,1:1:length(po4_a.ks_c),6,1:tend);
n_ts_a=po4_a.ks_n(1:tend);

ts_c=smooth1d_loess(po4_c.ks_c,1:length(po4_c.ks_c),6,1:tend);
std_ts_c=smooth1d_loess(po4_c.ks_std_05,1:1:length(po4_c.ks_c),6,1:tend);
n_ts_c=po4_c.ks_n(1:tend);

ci_a=abs(std_ts_a.*tinv((.05)/2,n_ts_a-1)./sqrt(n_ts_a-1));
ci_c=abs(std_ts_c.*tinv((.05)/2,n_ts_c-1)./sqrt(n_ts_c-1));
xts_a=[ts_a-ci_a ts_a(end)+ci_a(end) fliplr(ts_a+ci_a) ts_a(1)-ci_a(1)];
xts_c=[ts_c-ci_c ts_c(end)+ci_c(end) fliplr(ts_c+ci_c) ts_c(1)-ci_c(1)];

figure(3)
clf
set(gcf,'PaperPosition',[1 1 10 5.5])
patch(xp,xts_a,[.8 .8 .8])
patch(xp,xts_c,[.8 .8 .8])
hold on
plot(dft,ts_a,'r','linewidth',4)
hold on
plot(dft,ts_c,'b','linewidth',4)
axis tight

xlabel('eddy age (weeks)','fontsize',20,'fontweight','bold')
ylabel(['??'],'fontsize',20,'fontweight','bold')
line([1 40],[0 0],'color','k','LineWidth',2)
set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top')
set(gca,'xtick',[0:2:20])
box
title(['PO_4 anomaly',' GS rings'])
print -dpng -r300 figs/po4_ts


%%%%
% NH4
%%%%
ts_a=smooth1d_loess(nh4_a.ks_c,1:length(nh4_a.ks_c),6,1:tend);
std_ts_a=smooth1d_loess(nh4_a.ks_std_05,1:1:length(nh4_a.ks_c),6,1:tend);
n_ts_a=nh4_a.ks_n(1:tend);

ts_c=smooth1d_loess(nh4_c.ks_c,1:length(nh4_c.ks_c),6,1:tend);
std_ts_c=smooth1d_loess(nh4_c.ks_std_05,1:1:length(nh4_c.ks_c),6,1:tend);
n_ts_c=nh4_c.ks_n(1:tend);

ci_a=abs(std_ts_a.*tinv((.05)/2,n_ts_a-1)./sqrt(n_ts_a-1));
ci_c=abs(std_ts_c.*tinv((.05)/2,n_ts_c-1)./sqrt(n_ts_c-1));
xts_a=[ts_a-ci_a ts_a(end)+ci_a(end) fliplr(ts_a+ci_a) ts_a(1)-ci_a(1)];
xts_c=[ts_c-ci_c ts_c(end)+ci_c(end) fliplr(ts_c+ci_c) ts_c(1)-ci_c(1)];

figure(3)
clf
set(gcf,'PaperPosition',[1 1 10 5.5])
patch(xp,xts_a,[.8 .8 .8])
patch(xp,xts_c,[.8 .8 .8])
hold on
plot(dft,ts_a,'r','linewidth',4)
hold on
plot(dft,ts_c,'b','linewidth',4)
axis tight

xlabel('eddy age (weeks)','fontsize',20,'fontweight','bold')
ylabel(['??'],'fontsize',20,'fontweight','bold')
line([1 40],[0 0],'color','k','LineWidth',2)
set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top')
set(gca,'xtick',[0:2:20])
box
title(['NH_4 anomaly',' GS rings'])
print -dpng -r300 figs/nh4_ts


%%%%
% NO3
%%%%
ts_a=smooth1d_loess(no3_a.ks_c,1:length(no3_a.ks_c),6,1:tend);
std_ts_a=smooth1d_loess(no3_a.ks_std_05,1:1:length(no3_a.ks_c),6,1:tend);
n_ts_a=no3_a.ks_n(1:tend);

ts_c=smooth1d_loess(no3_c.ks_c,1:length(no3_c.ks_c),6,1:tend);
std_ts_c=smooth1d_loess(no3_c.ks_std_05,1:1:length(no3_c.ks_c),6,1:tend);
n_ts_c=no3_c.ks_n(1:tend);

ci_a=abs(std_ts_a.*tinv((.05)/2,n_ts_a-1)./sqrt(n_ts_a-1));
ci_c=abs(std_ts_c.*tinv((.05)/2,n_ts_c-1)./sqrt(n_ts_c-1));
xts_a=[ts_a-ci_a ts_a(end)+ci_a(end) fliplr(ts_a+ci_a) ts_a(1)-ci_a(1)];
xts_c=[ts_c-ci_c ts_c(end)+ci_c(end) fliplr(ts_c+ci_c) ts_c(1)-ci_c(1)];

figure(3)
clf
set(gcf,'PaperPosition',[1 1 10 5.5])
patch(xp,xts_a,[.8 .8 .8])
patch(xp,xts_c,[.8 .8 .8])
hold on
plot(dft,ts_a,'r','linewidth',4)
hold on
plot(dft,ts_c,'b','linewidth',4)
axis tight

xlabel('eddy age (weeks)','fontsize',20,'fontweight','bold')
ylabel(['??'],'fontsize',20,'fontweight','bold')
line([1 40],[0 0],'color','k','LineWidth',2)
set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top')
set(gca,'xtick',[0:2:20])
box
title(['NO_3 anomaly',' GS rings'])
print -dpng -r300 figs/no3_ts


%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%
%% BIOMASS
%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%
%%%%
% Small biomass
%%%%
ts_a=smooth1d_loess(norm_hp66_sp_c_a.ks_c,1:length(norm_hp66_sp_c_a.ks_c),6,1:tend);
std_ts_a=smooth1d_loess(norm_hp66_sp_c_a.ks_std_05,1:1:length(norm_hp66_sp_c_a.ks_c),6,1:tend);
n_ts_a=norm_hp66_sp_c_a.ks_n(1:tend);

ts_c=smooth1d_loess(norm_hp66_sp_c_c.ks_c,1:length(norm_hp66_sp_c_c.ks_c),6,1:tend);
std_ts_c=smooth1d_loess(norm_hp66_sp_c_c.ks_std_05,1:1:length(norm_hp66_sp_c_c.ks_c),6,1:tend);
n_ts_c=norm_hp66_sp_c_c.ks_n(1:tend);

ci_a=abs(std_ts_a.*tinv((.05)/2,n_ts_a-1)./sqrt(n_ts_a-1));
ci_c=abs(std_ts_c.*tinv((.05)/2,n_ts_c-1)./sqrt(n_ts_c-1));
xts_a=[ts_a-ci_a ts_a(end)+ci_a(end) fliplr(ts_a+ci_a) ts_a(1)-ci_a(1)];
xts_c=[ts_c-ci_c ts_c(end)+ci_c(end) fliplr(ts_c+ci_c) ts_c(1)-ci_c(1)];

figure(3)
clf
set(gcf,'PaperPosition',[1 1 10 5.5])
patch(xp,xts_a,[.8 .8 .8])
patch(xp,xts_c,[.8 .8 .8])
hold on
plot(dft,ts_a,'r','linewidth',4)
hold on
plot(dft,ts_c,'b','linewidth',4)
axis tight

xlabel('eddy age (weeks)','fontsize',20,'fontweight','bold')
ylabel(['mg m^{-3}'],'fontsize',20,'fontweight','bold')
line([1 40],[0 0],'color','k','LineWidth',2)
set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top')
set(gca,'xtick',[0:2:20])
box
title(['Small biomass anomaly',' GS rings'])
print -dpng -r300 figs/norm_hp66_sp_c_ts


%%%%
% Diaz biomass
%%%%
ts_a=smooth1d_loess(norm_hp66_diaz_c_a.ks_c,1:length(norm_hp66_diaz_c_a.ks_c),6,1:tend);
std_ts_a=smooth1d_loess(norm_hp66_diaz_c_a.ks_std_05,1:1:length(norm_hp66_diaz_c_a.ks_c),6,1:tend);
n_ts_a=norm_hp66_diaz_c_a.ks_n(1:tend);

ts_c=smooth1d_loess(norm_hp66_diaz_c_c.ks_c,1:length(norm_hp66_diaz_c_c.ks_c),6,1:tend);
std_ts_c=smooth1d_loess(norm_hp66_diaz_c_c.ks_std_05,1:1:length(norm_hp66_diaz_c_c.ks_c),6,1:tend);
n_ts_c=norm_hp66_diaz_c_c.ks_n(1:tend);

ci_a=abs(std_ts_a.*tinv((.05)/2,n_ts_a-1)./sqrt(n_ts_a-1));
ci_c=abs(std_ts_c.*tinv((.05)/2,n_ts_c-1)./sqrt(n_ts_c-1));
xts_a=[ts_a-ci_a ts_a(end)+ci_a(end) fliplr(ts_a+ci_a) ts_a(1)-ci_a(1)];
xts_c=[ts_c-ci_c ts_c(end)+ci_c(end) fliplr(ts_c+ci_c) ts_c(1)-ci_c(1)];

figure(3)
clf
set(gcf,'PaperPosition',[1 1 10 5.5])
patch(xp,xts_a,[.8 .8 .8])
patch(xp,xts_c,[.8 .8 .8])
hold on
plot(dft,ts_a,'r','linewidth',4)
hold on
plot(dft,ts_c,'b','linewidth',4)
axis tight

xlabel('eddy age (weeks)','fontsize',20,'fontweight','bold')
ylabel(['mg m^{-3}'],'fontsize',20,'fontweight','bold')
line([1 40],[0 0],'color','k','LineWidth',2)
set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top')
set(gca,'xtick',[0:2:20])
box
title(['Diaz biomass anomaly',' GS rings'])
print -dpng -r300 figs/norm_hp66_diaz_c_ts

%%%%
% Diat biomass
%%%%
ts_a=smooth1d_loess(norm_hp66_diat_c_a.ks_c,1:length(norm_hp66_diat_c_a.ks_c),6,1:tend);
std_ts_a=smooth1d_loess(norm_hp66_diat_c_a.ks_std_05,1:1:length(norm_hp66_diat_c_a.ks_c),6,1:tend);
n_ts_a=norm_hp66_diat_c_a.ks_n(1:tend);

ts_c=smooth1d_loess(norm_hp66_diat_c_c.ks_c,1:length(norm_hp66_diat_c_c.ks_c),6,1:tend);
std_ts_c=smooth1d_loess(norm_hp66_diat_c_c.ks_std_05,1:1:length(norm_hp66_diat_c_c.ks_c),6,1:tend);
n_ts_c=norm_hp66_diat_c_c.ks_n(1:tend);

ci_a=abs(std_ts_a.*tinv((.05)/2,n_ts_a-1)./sqrt(n_ts_a-1));
ci_c=abs(std_ts_c.*tinv((.05)/2,n_ts_c-1)./sqrt(n_ts_c-1));
xts_a=[ts_a-ci_a ts_a(end)+ci_a(end) fliplr(ts_a+ci_a) ts_a(1)-ci_a(1)];
xts_c=[ts_c-ci_c ts_c(end)+ci_c(end) fliplr(ts_c+ci_c) ts_c(1)-ci_c(1)];

figure(3)
clf
set(gcf,'PaperPosition',[1 1 10 5.5])
patch(xp,xts_a,[.8 .8 .8])
patch(xp,xts_c,[.8 .8 .8])
hold on
plot(dft,ts_a,'r','linewidth',4)
hold on
plot(dft,ts_c,'b','linewidth',4)
axis tight

xlabel('eddy age (weeks)','fontsize',20,'fontweight','bold')
ylabel(['mg m^{-3}'],'fontsize',20,'fontweight','bold')
line([1 40],[0 0],'color','k','LineWidth',2)
set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top')
set(gca,'xtick',[0:2:20])
box
title(['Diat biomass anomaly',' GS rings'])
print -dpng -r300 figs/norm_hp66_diat_c_ts



%%%%
% CHL
%%%%
ts_a=smooth1d_loess(norm_hp66_chl_a.ks_c,1:length(norm_hp66_chl_a.ks_c),6,1:tend);
std_ts_a=smooth1d_loess(norm_hp66_chl_a.ks_std_05,1:1:length(norm_hp66_chl_a.ks_c),6,1:tend);
n_ts_a=norm_hp66_chl_a.ks_n(1:tend);

ts_c=smooth1d_loess(norm_hp66_chl_c.ks_c,1:length(norm_hp66_chl_c.ks_c),6,1:tend);
std_ts_c=smooth1d_loess(norm_hp66_chl_c.ks_std_05,1:1:length(norm_hp66_chl_c.ks_c),6,1:tend);
n_ts_c=norm_hp66_chl_c.ks_n(1:tend);

ci_a=abs(std_ts_a.*tinv((.05)/2,n_ts_a-1)./sqrt(n_ts_a-1));
ci_c=abs(std_ts_c.*tinv((.05)/2,n_ts_c-1)./sqrt(n_ts_c-1));
xts_a=[ts_a-ci_a ts_a(end)+ci_a(end) fliplr(ts_a+ci_a) ts_a(1)-ci_a(1)];
xts_c=[ts_c-ci_c ts_c(end)+ci_c(end) fliplr(ts_c+ci_c) ts_c(1)-ci_c(1)];

figure(3)
clf
set(gcf,'PaperPosition',[1 1 10 5.5])
patch(xp,xts_a,[.8 .8 .8])
patch(xp,xts_c,[.8 .8 .8])
hold on
plot(dft,ts_a,'r','linewidth',4)
hold on
plot(dft,ts_c,'b','linewidth',4)
axis tight

xlabel('eddy age (weeks)','fontsize',20,'fontweight','bold')
ylabel(['CHL',char(39),char(39)],'fontsize',20,'fontweight','bold')
line([1 40],[0 0],'color','k','LineWidth',2)
set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top')
set(gca,'xtick',[0:2:20])
box
title(['POP CHL',char(39),char(39),' GS rings'])
print -dpng -r300 figs/norm_hp66_chl_ts


%%%
SSH
%%%
ts_a=smooth1d_loess(ssh_a.ks_c,1:length(ssh_a.ks_c),6,1:tend);
std_ts_a=smooth1d_loess(ssh_a.ks_std_05,1:1:length(ssh_a.ks_c),6,1:tend);
n_ts_a=ssh_a.ks_n(1:tend);

ts_c=smooth1d_loess(ssh_c.ks_c,1:length(ssh_c.ks_c),6,1:tend);
std_ts_c=smooth1d_loess(ssh_c.ks_std_05,1:1:length(ssh_c.ks_c),6,1:tend);
n_ts_c=ssh_c.ks_n(1:tend);

ci_a=abs(std_ts_a.*tinv((.05)/2,n_ts_a-1)./sqrt(n_ts_a-1));
ci_c=abs(std_ts_c.*tinv((.05)/2,n_ts_c-1)./sqrt(n_ts_c-1));
xts_a=[ts_a-ci_a ts_a(end)+ci_a(end) fliplr(ts_a+ci_a) ts_a(1)-ci_a(1)];
xts_c=[ts_c-ci_c ts_c(end)+ci_c(end) fliplr(ts_c+ci_c) ts_c(1)-ci_c(1)];

figure(1)
clf
set(gcf,'PaperPosition',[1 1 10 5.5])
patch(xp,xts_a,[.8 .8 .8])
patch(xp,xts_c,[.8 .8 .8])
hold on
plot(dft,ts_a,'r','linewidth',4)
hold on
plot(dft,ts_c,'b','linewidth',4)
axis tight

xlabel('eddy age (weeks)','fontsize',20,'fontweight','bold')
ylabel(['SSH',char(39),char(39)],'fontsize',20,'fontweight','bold')
line([1 40],[0 0],'color','k','LineWidth',2)
set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top')
set(gca,'xtick',[0:2:20])
box
title(['POP SSH',char(39),char(39),' GS rings'])
print -dpng -r300 figs/ssh_ts

figure(2)
clf
set(gcf,'PaperPosition',[1 1 10 5.5])
plot(dft,dfdx_abs(ts_a,1),'r','linewidth',4)
hold on
plot(dft,dfdx_abs(ts_c,1),'b','linewidth',4)
axis tight

xlabel('eddy age (weeks)','fontsize',20,'fontweight','bold')
ylabel(['dSSH/dt',char(39),char(39)],'fontsize',20,'fontweight','bold')
line([1 40],[0 0],'color','k','LineWidth',2)
set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top')
set(gca,'xtick',[0:2:12])
box
title(['POP dSSHdt GS rings'])
print -dpng -r300 figs/POP_dSSHdt_ts



%%now normalized biomass propoportions
tend=16
dft=1:tend;

a_small_na=smooth1d_loess(sp_c_a.ks_c,1:length(sp_c_a.ks_c),5,dft)./max(sp_c_a.ks_c);
a_diat_na=smooth1d_loess(diat_c_a.ks_c,1:length(diat_c_a.ks_c),5,dft)./max(diat_c_a.ks_c);
a_diaz_na=smooth1d_loess(diaz_c_a.ks_c,1:length(diaz_c_a.ks_c),5,dft)./max(diaz_c_a.ks_c);

a_sum_all=a_small_na+a_diat_na+a_diaz_na;
a_prop_small=a_small_na./a_sum_all;
a_prop_diat=a_diat_na./a_sum_all;
a_prop_diaz=a_diaz_na./a_sum_all;

c_small_na=smooth1d_loess(sp_c_c.ks_c,1:length(sp_c_c.ks_c),5,dft)./max(sp_c_c.ks_c);
c_diat_na=smooth1d_loess(diat_c_c.ks_c,1:length(diat_c_c.ks_c),5,dft)./max(diat_c_c.ks_c);
c_diaz_na=smooth1d_loess(diaz_c_c.ks_c,1:length(diaz_c_c.ks_c),5,dft)./max(diaz_c_c.ks_c);

c_sum_all=c_small_na+c_diat_na+c_diaz_na;
c_prop_small=c_small_na./c_sum_all;
c_prop_diat=c_diat_na./c_sum_all;
c_prop_diaz=c_diaz_na./c_sum_all;




figure(1)
clf
set(gcf,'PaperPosition',[1 1 8 8])
subplot(211)
hold on
plot(1:length(a_prop_diat),a_prop_diat,'k-*')
plot(1:length(a_prop_diat),a_prop_small,'k')
plot(1:length(a_prop_diat),a_prop_diaz,'k--')
legend('diat','small','diaz')
title('anticyclones')
set(gca,'ylim',[.2 .5],'xlim',[1 16],'fontsize',10,'fontweight','bold','LineWidth',.5,'TickLength',[.01 .05],'layer','top')


subplot(212)
hold on
plot(1:length(a_prop_diat),c_prop_diat,'k-*')
plot(1:length(a_prop_diat),c_prop_small,'k')
plot(1:length(a_prop_diat),c_prop_diaz,'k--')
legend('diat','small','diaz')
title('cyclones')
set(gca,'ylim',[.2 .5],'xlim',[1 16],'fontsize',10,'fontweight','bold','LineWidth',.5,'TickLength',[.01 .05],'layer','top')
xlabel('weeks')
print -dpng -r300 figs/rings_diveristy_ks_c_L

