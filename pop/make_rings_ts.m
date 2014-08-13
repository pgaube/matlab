dft=linspace(1,5*40,40);
xp=[dft dft(end) fliplr(dft) dft(1)];
mm=5
eval(['load ',curs{mm},'_new_comps_3d'])
set_pop
ds_a=smooth1d_loess(ssh_a.ks_1,dft,50,dft);
ds_c=smooth1d_loess(ssh_c.ks_1,dft,50,dft);

figure(1)
clf
set(gcf,'PaperPosition',[1 1 8 4])
set(gca,'fontsize',10,'fontweight','bold','LineWidth',.5,'TickLength',[.01 .05],'layer','top')

hold on
plot(dft,ds_a,'r','LineWidth',2)
plot(dft,ds_c,'b','LineWidth',2)
set(gca,'XLim',[1 180])
xlabel('eddy age (days)','fontsize',15,'fontweight','bold')
ylabel('cm per week','fontsize',15,'fontweight','bold')
line([dft(1) dft(end)],[0 0],'color','k','LineWidth',.1)
title('Eddy SSH intensification ','fontsize',15,'fontweight','bold')
set(gca,'fontsize',10,'fontweight','bold','LineWidth',.5,'TickLength',[.01 .05],'layer','top')
box
eval(['print -dpng -r300 figs/',curs{mm},'_amp_ks'])

ts_a=smooth1d_loess(diat_chl_a.ks_1,dft,50,dft);
ts_c=smooth1d_loess(diat_chl_c.ks_1,dft,50,dft);
ss_a=smooth1d_loess(diat_chl_a.ks_std_1,dft,50,dft);
ss_c=smooth1d_loess(diat_chl_c.ks_std_1,dft,50,dft);

ci_c=abs(ss_c.*tinv((.1)/2,diat_chl_c.ks_n-1)./sqrt(diat_chl_c.ks_n));
ci_a=abs(ss_a.*tinv((.1)/2,diat_chl_a.ks_n-1)./sqrt(diat_chl_a.ks_n));

x_c=[ts_c-ci_c ts_c(end)+ci_c(end) fliplr(ts_c+ci_c) ts_c(1)-ci_c(1)];
x_a=[ts_a-ci_a ts_a(end)+ci_a(end) fliplr(ts_a+ci_a) ts_a(1)-ci_a(1)];

figure(1)
clf
set(gcf,'PaperPosition',[1 1 8 4])
set(gca,'fontsize',10,'fontweight','bold','LineWidth',.5,'TickLength',[.01 .05],'layer','top')
patch(xp,x_c,[.8 .8 .8])
hold on
patch(xp,x_a,[.8 .8 .8])
plot(dft,ts_c,'b','LineWidth',2)
hold on
plot(dft,ts_a,'r','LineWidth',2)
set(gca,'XLim',[1 180])
xlabel('eddy age (days)','fontsize',15,'fontweight','bold')
ylabel('mg m^{-3}','fontsize',15,'fontweight','bold')
line([dft(1) dft(end)],[0 0],'color','k','LineWidth',.1)
title('Diatom CHL anomaly','fontsize',15,'fontweight','bold')
set(gca,'fontsize',10,'fontweight','bold','LineWidth',.5,'TickLength',[.01 .05],'layer','top')
box
eval(['print -dpng -r300 figs/',curs{mm},'_diat_chl_ks'])

ts_a=smooth1d_loess(diaz_chl_a.ks_1,dft,50,dft);
ts_c=smooth1d_loess(diaz_chl_c.ks_1,dft,50,dft);
ss_a=smooth1d_loess(diaz_chl_a.ks_std_1,dft,50,dft);
ss_c=smooth1d_loess(diaz_chl_c.ks_std_1,dft,50,dft);

ci_c=abs(ss_c.*tinv((.1)/2,diaz_chl_c.ks_n-1)./sqrt(diaz_chl_c.ks_n));
ci_a=abs(ss_a.*tinv((.1)/2,diaz_chl_a.ks_n-1)./sqrt(diaz_chl_a.ks_n));

x_c=[ts_c-ci_c ts_c(end)+ci_c(end) fliplr(ts_c+ci_c) ts_c(1)-ci_c(1)];
x_a=[ts_a-ci_a ts_a(end)+ci_a(end) fliplr(ts_a+ci_a) ts_a(1)-ci_a(1)];

figure(1)
clf
set(gcf,'PaperPosition',[1 1 8 4])
set(gca,'fontsize',10,'fontweight','bold','LineWidth',.5,'TickLength',[.01 .05],'layer','top')
patch(xp,x_c,[.8 .8 .8])
hold on
patch(xp,x_a,[.8 .8 .8])
plot(dft,ts_c,'b','LineWidth',2)
hold on
plot(dft,ts_a,'r','LineWidth',2)
set(gca,'XLim',[1 180])
xlabel('eddy age (days)','fontsize',15,'fontweight','bold')
ylabel('mg m^{-3}','fontsize',15,'fontweight','bold')
line([dft(1) dft(end)],[0 0],'color','k','LineWidth',.1)
title('Diaz CHL anomaly','fontsize',15,'fontweight','bold')
set(gca,'fontsize',10,'fontweight','bold','LineWidth',.5,'TickLength',[.01 .05],'layer','top')
box
eval(['print -dpng -r300 figs/',curs{mm},'_diaz_chl_ks'])

ts_a=smooth1d_loess(small_chl_a.ks_1,dft,50,dft);
ts_c=smooth1d_loess(small_chl_c.ks_1,dft,50,dft);
ss_a=smooth1d_loess(small_chl_a.ks_std_1,dft,50,dft);
ss_c=smooth1d_loess(small_chl_c.ks_std_1,dft,50,dft);

ci_c=abs(ss_c.*tinv((.1)/2,small_chl_c.ks_n-1)./sqrt(small_chl_c.ks_n));
ci_a=abs(ss_a.*tinv((.1)/2,small_chl_a.ks_n-1)./sqrt(small_chl_a.ks_n));

x_c=[ts_c-ci_c ts_c(end)+ci_c(end) fliplr(ts_c+ci_c) ts_c(1)-ci_c(1)];
x_a=[ts_a-ci_a ts_a(end)+ci_a(end) fliplr(ts_a+ci_a) ts_a(1)-ci_a(1)];

figure(1)
clf
set(gcf,'PaperPosition',[1 1 8 4])
set(gca,'fontsize',10,'fontweight','bold','LineWidth',.5,'TickLength',[.01 .05],'layer','top')
patch(xp,x_c,[.8 .8 .8])
hold on
patch(xp,x_a,[.8 .8 .8])
plot(dft,ts_c,'b','LineWidth',2)
hold on
plot(dft,ts_a,'r','LineWidth',2)
set(gca,'XLim',[1 180])
xlabel('eddy age (days)','fontsize',15,'fontweight','bold')
ylabel('mg m^{-3}','fontsize',15,'fontweight','bold')
line([dft(1) dft(end)],[0 0],'color','k','LineWidth',.1)
title('Small CHL anomaly','fontsize',15,'fontweight','bold')
set(gca,'fontsize',10,'fontweight','bold','LineWidth',.5,'TickLength',[.01 .05],'layer','top')
box
eval(['print -dpng -r300 figs/',curs{mm},'_small_chl_ks'])



a_small_na=smooth1d_loess(small_full_a.ks_1,dft,50,dft)./max(small_full_a.ks_1);
a_diat_na=smooth1d_loess(diat_full_a.ks_1,dft,50,dft)./max(diat_full_a.ks_1);
a_diaz_na=smooth1d_loess(diaz_full_a.ks_1,dft,50,dft)./max(diaz_full_a.ks_1);

a_sum_all=a_small_na+a_diat_na+a_diaz_na;
a_prop_small=a_small_na./a_sum_all;
a_prop_diat=a_diat_na./a_sum_all;
a_prop_diaz=a_diaz_na./a_sum_all;

c_small_na=smooth1d_loess(small_full_c.ks_1,dft,50,dft)./max(small_full_c.ks_1);
c_diat_na=smooth1d_loess(diat_full_c.ks_1,dft,50,dft)./max(diat_full_c.ks_1);
c_diaz_na=smooth1d_loess(diaz_full_c.ks_1,dft,50,dft)./max(diaz_full_c.ks_1);

c_sum_all=c_small_na+c_diat_na+c_diaz_na;
c_prop_small=c_small_na./c_sum_all;
c_prop_diat=c_diat_na./c_sum_all;
c_prop_diaz=c_diaz_na./c_sum_all;

% m_small_na=smooth1d_loess(small_full_m.ks_1,dft,50,dft)./max(small_full_m.ks_1);
% m_diat_na=smooth1d_loess(diat_full_m.ks_1,dft,50,dft)./max(diat_full_m.ks_1);
% m_diaz_na=smooth1d_loess(diaz_full_m.ks_1,dft,50,dft)./max(diaz_full_m.ks_1);
% 
% m_sum_all=m_small_na+m_diat_na+m_diaz_na;
% m_prop_small=m_small_na./m_sum_all;
% m_prop_diat=m_diat_na./m_sum_all;
% m_prop_diaz=m_diaz_na./m_sum_all;



figure(1)
clf
set(gcf,'PaperPosition',[1 1 8 8])
subplot(211)
hold on
plot(1:40,a_prop_diat,'k-*')
plot(1:40,a_prop_small,'k')
plot(1:40,a_prop_diaz,'k--')
legend('diat','small','diaz')
title('anticyclones')
set(gca,'xlim',[1 20],'fontsize',10,'fontweight','bold','LineWidth',.5,'TickLength',[.01 .05],'layer','top')


subplot(212)
hold on
plot(1:40,c_prop_diat,'k-*')
plot(1:40,c_prop_small,'k')
plot(1:40,c_prop_diaz,'k--')
legend('diat','small','diaz')
title('cyclones')
set(gca,'xlim',[1 20],'fontsize',10,'fontweight','bold','LineWidth',.5,'TickLength',[.01 .05],'layer','top')

% subplot(313)
% plot(1:length(m_prop_small),m_prop_small,'k-*')
% hold on
% plot(1:length(m_prop_small),m_prop_diat,'k--')
% plot(1:length(m_prop_small),m_prop_diaz,'k')
% legend('small','diat','diaz')
% title('MWE')
set(gca,'xlim',[1 20],'fontsize',10,'fontweight','bold','LineWidth',.5,'TickLength',[.01 .05],'layer','top')
xlabel('weeks')
print -dpng -r300 figs/rings_diveristy_ks

