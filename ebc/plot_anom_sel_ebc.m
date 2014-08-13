%load data
load ebc_binned_samps/ak_chl_anom_binned tbins bar_anom_a bar_anom_c

figure(1);clf
%subplot(321)
plot(tbins,smooth1d_loess(bar_anom_a,1:length(tbins),5,1:length(tbins)),'r','linewidth',2);
hold on
plot(tbins,smooth1d_loess(bar_anom_c,1:length(tbins),5,1:length(tbins)),'b','linewidth',2);
scatter(tbins,bar_anom_a,'.r')
scatter(tbins,bar_anom_c,'.b')
hold off
line([1 52],[0 0],'color','k')
axis([1 52 -.15 .15])
xlabel('eddy age (weeks)  ')
ylabel('mean log_{10}(CHL) anomaly [mg/m^3]  ')
title('Alaska')
print -dpng ~/Documents/OSU/figures/ebc/chl_anom_binned_ts/ak_chl_anom_trapped.png

load ebc_binned_samps/lw_chl_anom_binned tbins bar_anom_a bar_anom_c

figure(1);clf
%subplot(326)
plot(tbins,smooth1d_loess(bar_anom_a,1:length(tbins),5,1:length(tbins)),'r','linewidth',2);
hold on
plot(tbins,smooth1d_loess(bar_anom_c,1:length(tbins),5,1:length(tbins)),'b','linewidth',2);
scatter(tbins,bar_anom_a,'.r')
scatter(tbins,bar_anom_c,'.b')
hold off
line([1 52],[0 0],'color','k')
axis([1 52 -.15 .15])
xlabel('eddy age (weeks)  ')
ylabel('mean log_{10}(CHL) anomaly [mg/m^3]  ')
title('Leeuwin')
print -dpng ~/Documents/OSU/figures/ebc/chl_anom_binned_ts/lw_chl_anom_trapped.png

load ebc_binned_samps/ccns_chl_anom_binned tbins bar_anom_a bar_anom_c
%subplot(323)
plot(tbins,smooth1d_loess(bar_anom_a,1:length(tbins),5,1:length(tbins)),'r','linewidth',2);
hold on
plot(tbins,smooth1d_loess(bar_anom_c,1:length(tbins),5,1:length(tbins)),'b','linewidth',2);
scatter(tbins,bar_anom_a,'.r')
scatter(tbins,bar_anom_c,'.b')
hold off
line([1 52],[0 0],'color','k')
axis([1 52 -.15 .15])
xlabel('eddy age (weeks)  ')
ylabel('mean log_{10}(CHL) anomaly [mg/m^3]  ')
title('California')
print -dpng ~/Documents/OSU/figures/ebc/chl_anom_binned_ts/ccns_chl_anom_trapped.png

load ebc_binned_samps/pc_chl_anom_binned tbins bar_anom_a bar_anom_c
%subplot(325)
plot(tbins,smooth1d_loess(bar_anom_a,1:length(tbins),5,1:length(tbins)),'r','linewidth',2);
hold on
plot(tbins,smooth1d_loess(bar_anom_c,1:length(tbins),5,1:length(tbins)),'b','linewidth',2);
scatter(tbins,bar_anom_a,'.r')
scatter(tbins,bar_anom_c,'.b')
hold off
line([1 52],[0 0],'color','k')
axis([1 52 -.15 .15])
xlabel('eddy age (weeks)  ')
ylabel('mean log_{10}(CHL) anomaly [mg/m^3]  ')
title('Peru-Chile')
print -dpng ~/Documents/OSU/figures/ebc/chl_anom_binned_ts/pc_chl_anom_trapped.png

load ebc_binned_samps/cc_chl_anom_binned tbins bar_anom_a bar_anom_c
%subplot(322)
plot(tbins,smooth1d_loess(bar_anom_a,1:length(tbins),5,1:length(tbins)),'r','linewidth',2);
hold on
plot(tbins,smooth1d_loess(bar_anom_c,1:length(tbins),5,1:length(tbins)),'b','linewidth',2);
scatter(tbins,bar_anom_a,'.r')
scatter(tbins,bar_anom_c,'.b')
hold off
line([1 52],[0 0],'color','k')
axis([1 52 -.15 .15])
xlabel('eddy age (weeks)  ')
ylabel('mean log_{10}(CHL) anomaly [mg/m^3]  ')
title('Canary')
print -dpng ~/Documents/OSU/figures/ebc/chl_anom_binned_ts/cc_chl_anom_trapped.png


load ebc_binned_samps/bg_chl_anom_binned tbins bar_anom_a bar_anom_c
%subplot(324)
plot(tbins,smooth1d_loess(bar_anom_a,1:length(tbins),5,1:length(tbins)),'r','linewidth',2);
hold on
plot(tbins,smooth1d_loess(bar_anom_c,1:length(tbins),5,1:length(tbins)),'b','linewidth',2);
scatter(tbins,bar_anom_a,'.r')
scatter(tbins,bar_anom_c,'.b')
hold off
line([1 52],[0 0],'color','k')
axis([1 52 -.15 .15])
title('Benguela')
xlabel('eddy age (weeks)  ')
ylabel('mean log_{10}(CHL) anomaly [mg/m^3]  ')
print -dpng ~/Documents/OSU/figures/ebc/chl_anom_binned_ts/bg_chl_anom_trapped.png
