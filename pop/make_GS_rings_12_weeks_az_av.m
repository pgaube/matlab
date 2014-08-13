
load pop_rings_amp_weeks_comps
%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%
% Upwelling
%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%

ts_a=smooth1d_loess(w_a.az_av,w_a.rbins,1,w_a.rbins);
std_ts_a=smooth1d_loess(w_a.az_av_std,w_a.rbins,1,w_a.rbins);
n_ts_a=w_a.ax_av_n;

ts_c=smooth1d_loess(w_c.az_av,w_c.rbins,1,w_c.rbins);
std_ts_c=smooth1d_loess(w_c.az_av_std,w_c.rbins,1,w_c.rbins);
n_ts_c=w_c.ax_av_n;

ci_a=abs(std_ts_a.*tinv((.05)/2,n_ts_a-1)./sqrt(n_ts_a-1))/10;
ci_c=abs(std_ts_c.*tinv((.05)/2,n_ts_c-1)./sqrt(n_ts_c-1))/10;

figure(3)
clf
set(gcf,'PaperPosition',[1 1 10 5.5])
hold on
errorbar(w_a.rbins,ts_a,ci_a,'r','linewidth',4)
hold on
errorbar(w_a.rbins,ts_c,ci_c,'b','linewidth',4)
axis tight

xlabel('radial distance (L_{eff})','fontsize',20,'fontweight','bold')
ylabel(['m per second?'],'fontsize',20,'fontweight','bold')
line([0 2],[0 0],'color','k','LineWidth',2)
set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top')
set(gca,'xtick',[0:.25:2])
box
title(['Vertical velocity',' GS rings'])
print -dpng -r300 figs/w_az_av


%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%
%% Vertical advection
%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%

% %%%%
% % Small 
% %%%%
ts_a=smooth1d_loess(small_vadv_a.az_av,small_vadv_a.rbins,1,small_vadv_a.rbins);
std_ts_a=smooth1d_loess(small_vadv_a.az_av_std,small_vadv_a.rbins,1,small_vadv_a.rbins);
n_ts_a=small_vadv_a.ax_av_n;

ts_c=smooth1d_loess(small_vadv_c.az_av,small_vadv_c.rbins,1,small_vadv_c.rbins);
std_ts_c=smooth1d_loess(small_vadv_c.az_av_std,small_vadv_c.rbins,1,small_vadv_c.rbins);
n_ts_c=small_vadv_c.ax_av_n;

ci_a=abs(std_ts_a.*tinv((.05)/2,n_ts_a-1)./sqrt(n_ts_a-1))/10;
ci_c=abs(std_ts_c.*tinv((.05)/2,n_ts_c-1)./sqrt(n_ts_c-1))/10;

figure(3)
clf
set(gcf,'PaperPosition',[1 1 10 5.5])
hold on
errorbar(small_vadv_a.rbins,ts_a,ci_a,'r','linewidth',4)
hold on
errorbar(small_vadv_a.rbins,ts_c,ci_c,'b','linewidth',4)
axis tight

xlabel('radial distance (L_{eff})','fontsize',20,'fontweight','bold')
ylabel(['mg m^{-3} per s?'],'fontsize',20,'fontweight','bold')
line([0 2],[0 0],'color','k','LineWidth',2)
set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top')
set(gca,'xtick',[0:.25:2])
box
title(['Vertical Advection of Small Phyto',' GS rings'])
print -dpng -r300 figs/small_vadv_az_av


% %%%%
% % diaz 
% %%%%
ts_a=smooth1d_loess(diaz_vadv_a.az_av,diaz_vadv_a.rbins,1,diaz_vadv_a.rbins);
std_ts_a=smooth1d_loess(diaz_vadv_a.az_av_std,diaz_vadv_a.rbins,1,diaz_vadv_a.rbins);
n_ts_a=diaz_vadv_a.ax_av_n;

ts_c=smooth1d_loess(diaz_vadv_c.az_av,diaz_vadv_c.rbins,1,diaz_vadv_c.rbins);
std_ts_c=smooth1d_loess(diaz_vadv_c.az_av_std,diaz_vadv_c.rbins,1,diaz_vadv_c.rbins);
n_ts_c=diaz_vadv_c.ax_av_n;

ci_a=abs(std_ts_a.*tinv((.05)/2,n_ts_a-1)./sqrt(n_ts_a-1))/10;
ci_c=abs(std_ts_c.*tinv((.05)/2,n_ts_c-1)./sqrt(n_ts_c-1))/10;

figure(3)
clf
set(gcf,'PaperPosition',[1 1 10 5.5])
hold on
errorbar(diaz_vadv_a.rbins,ts_a,ci_a,'r','linewidth',4)
hold on
errorbar(diaz_vadv_a.rbins,ts_c,ci_c,'b','linewidth',4)
axis tight

xlabel('radial distance (L_{eff})','fontsize',20,'fontweight','bold')
ylabel(['mg m^{-3} per s?'],'fontsize',20,'fontweight','bold')
line([0 2],[0 0],'color','k','LineWidth',2)
set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top')
set(gca,'xtick',[0:.25:2])
box
title(['Vertical Advection of diazoms Phyto',' GS rings'])
print -dpng -r300 figs/diaz_vadv_az_av

%%%%
% Diaz 
%%%%
ts_a=smooth1d_loess(diaz_vadv_a.az_av,diaz_vadv_a.rbins,1,diaz_vadv_a.rbins);
std_ts_a=smooth1d_loess(diaz_vadv_a.az_av_std,diaz_vadv_a.rbins,1,diaz_vadv_a.rbins);
n_ts_a=diaz_vadv_a.ax_av_n;

ts_c=smooth1d_loess(diaz_vadv_c.az_av,diaz_vadv_c.rbins,1,diaz_vadv_c.rbins);
std_ts_c=smooth1d_loess(diaz_vadv_c.az_av_std,diaz_vadv_c.rbins,1,diaz_vadv_c.rbins);
n_ts_c=diaz_vadv_c.ax_av_n;

ci_a=abs(std_ts_a.*tinv((.05)/2,n_ts_a-1)./sqrt(n_ts_a-1))/10;
ci_c=abs(std_ts_c.*tinv((.05)/2,n_ts_c-1)./sqrt(n_ts_c-1))/10;

figure(3)
clf
set(gcf,'PaperPosition',[1 1 10 5.5])
hold on
errorbar(diaz_vadv_a.rbins,ts_a,ci_a,'r','linewidth',4)
hold on
errorbar(diaz_vadv_a.rbins,ts_c,ci_c,'b','linewidth',4)
axis tight

xlabel('radial distance (L_{eff})','fontsize',20,'fontweight','bold')
ylabel(['mg m^{-3} per s?'],'fontsize',20,'fontweight','bold')
line([0 2],[0 0],'color','k','LineWidth',2)
set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top')
set(gca,'xtick',[0:.25:2])
box
title(['Vertical Advection of Diaz Phyto',' GS rings'])
print -dpng -r300 figs/diaz_vadv_az_av





% %%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%
% %% Sorces/Sinks
% %%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%
% %%%%
% % Small SS
% %%%%


% %%%%
% % Diaz SS
% %%%%

% %%%%
% % diaz SS
% %%%%



