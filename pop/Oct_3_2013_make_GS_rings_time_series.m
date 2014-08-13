dft=1:12;
xp=[dft dft(end) fliplr(dft) dft(1)];

load pop_rings_12_weeks_comps


ts_a=smooth1d_loess(norm_hp66_chl_a.ks_05,1:length(norm_hp66_chl_a.ks_05),6,1:12);
std_ts_a=smooth1d_loess(norm_hp66_chl_a.ks_std_05,1:1:length(norm_hp66_chl_a.ks_05),6,1:12);
n_ts_a=norm_hp66_chl_a.ks_n(1:12);

ts_c=smooth1d_loess(norm_hp66_chl_c.ks_05,1:length(norm_hp66_chl_c.ks_05),6,1:12);
std_ts_c=smooth1d_loess(norm_hp66_chl_c.ks_std_05,1:1:length(norm_hp66_chl_c.ks_05),6,1:12);
n_ts_c=norm_hp66_chl_c.ks_n(1:12);

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

ts_a=smooth1d_loess(ssh_a.ks_05,1:length(ssh_a.ks_05),6,1:12);
std_ts_a=smooth1d_loess(ssh_a.ks_std_05,1:1:length(ssh_a.ks_05),6,1:12);
n_ts_a=ssh_a.ks_n(1:12);

ts_c=smooth1d_loess(ssh_c.ks_05,1:length(ssh_c.ks_05),6,1:12);
std_ts_c=smooth1d_loess(ssh_c.ks_std_05,1:1:length(ssh_c.ks_05),6,1:12);
n_ts_c=ssh_c.ks_n(1:12);

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

return


%%%%now normalized biomass propoportions
a_small_na=smooth1d_loess(sp_c_a.ks_05,1:length(sp_c_a.ks_05),5,dft)./max(sp_c_a.ks_05);
a_diat_na=smooth1d_loess(diat_c_a.ks_05,1:length(diat_c_a.ks_05),5,dft)./max(diat_c_a.ks_05);
a_diaz_na=smooth1d_loess(diaz_c_a.ks_05,1:length(diaz_c_a.ks_05),5,dft)./max(diaz_c_a.ks_05);

a_sum_all=a_small_na+a_diat_na+a_diaz_na;
a_prop_small=a_small_na./a_sum_all;
a_prop_diat=a_diat_na./a_sum_all;
a_prop_diaz=a_diaz_na./a_sum_all;

c_small_na=smooth1d_loess(sp_c_c.ks_05,1:length(sp_c_c.ks_05),5,dft)./max(sp_c_c.ks_05);
c_diat_na=smooth1d_loess(diat_c_c.ks_05,1:length(diat_c_c.ks_05),5,dft)./max(diat_c_c.ks_05);
c_diaz_na=smooth1d_loess(diaz_c_c.ks_05,1:length(diaz_c_c.ks_05),5,dft)./max(diaz_c_c.ks_05);

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
set(gca,'ylim',[.2 .4],'xlim',[1 16],'fontsize',10,'fontweight','bold','LineWidth',.5,'TickLength',[.01 .05],'layer','top')


subplot(212)
hold on
plot(1:length(a_prop_diat),c_prop_diat,'k-*')
plot(1:length(a_prop_diat),c_prop_small,'k')
plot(1:length(a_prop_diat),c_prop_diaz,'k--')
legend('diat','small','diaz')
title('cyclones')
set(gca,'ylim',[.2 .4],'xlim',[1 16],'fontsize',10,'fontweight','bold','LineWidth',.5,'TickLength',[.01 .05],'layer','top')
xlabel('weeks')
print -dpng -r300 figs/rings_diveristy_ks_05_L

