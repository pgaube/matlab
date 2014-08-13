clear all
% load AVISO_GS_rings_cor_tracks_jan_5
% 
% [obs_ssh_a,obs_ssh_c]=comps(x,y,cyc,k,id,track_jday,radius,'ssh','~/data/eddy/V5/mat/AVISO_25_W_','n');
% [obs_chl_a,obs_chl_c]=comps(x,y,cyc,k,id,track_jday,radius,'sp66_chl','~/data/gsm/mat/GSM_9_21_','dd');
% save obs_rings_comps
% 
% % clear
% load GS_rings_cor_tracks_jan_5
% % % 
% [ssh_a,dd,ssh_c,rr]=pop_comps_mat(x,y,cyc,k,id,track_jday,radius,adens,'hp21_ssh',1,'n');
% [norm_hp66_chl_a,dd,norm_hp66_chl_c,rr]=pop_comps_mat(x,y,cyc,k,id,track_jday,radius,adens,'hp66_chl',1,'dd');
% save -append pop_rings_comps


% % plot comps
% load obs_rings_comps
% pcomps_raw2(obs_chl_a.mean,obs_ssh_a.mean,[-.3 .3],-100,5,100,'Observed CHL AC',2,20)
% print -dpng -r300 figs/observed_GS_rings_chl_ssh_a
% pcomps_raw2(obs_chl_c.mean,obs_ssh_c.mean,[-.3 .3],-100,5,100,'Observed CHL CC',2,20)
% print -dpng -r300 figs/observed_GS_rings_chl_ssh_c
% 
% 
% pcomps_raw2(obs_ssh_a.mean,obs_ssh_a.mean,[-50 50],-100,5,100,'Observed SSH AC',2,20)
% print -dpng -r300 figs/observed_GS_rings_ssh_ssh_a
% pcomps_raw2(obs_ssh_c.mean,obs_ssh_c.mean,[-50 50],-100,5,100,'Observed SSH CC',2,20)
% print -dpng -r300 figs/observed_GS_rings_ssh_ssh_c
% 
% load pop_rings_comps
% pcomps_raw2(norm_hp66_chl_a.mean,ssh_a.mean,[-.3 .3],-100,5,100,'POP CHL AC',2,20)
% print -dpng -r300 figs/pop_GS_rings_chl_ssh_a
% pcomps_raw2(norm_hp66_chl_c.mean,ssh_c.mean,[-.3 .3],-100,5,100,'POP CHL CC',2,20)
% print -dpng -r300 figs/pop_GS_rings_chl_ssh_c
% 
% pcomps_raw2(norm_hp66_chl_a.mean,ssh_a.mean,[-.5 .5],-100,5,100,'POP CHL AC',2,20)
% print -dpng -r300 figs/pop_GS_rings_chl2_ssh_a
% pcomps_raw2(norm_hp66_chl_c.mean,ssh_c.mean,[-.5 .5],-100,5,100,'POP CHL CC',2,20)
% print -dpng -r300 figs/pop_GS_rings_chl2_ssh_c
% 
% pcomps_raw2(ssh_a.mean,ssh_a.mean,[-50 50],-100,5,100,'POP SSH AC',2,20)
% print -dpng -r300 figs/pop_GS_rings_ssh_ssh_a
% pcomps_raw2(ssh_c.mean,ssh_c.mean,[-50 50],-100,5,100,'POP SSH CC',2,20)
% print -dpng -r300 figs/pop_GS_rings_ssh_ssh_c
% 

% % % % % plot time series
dft=5:5:60;
adft=linspace(7,60,12);
xp=[dft dft(end) fliplr(dft) dft(1)];
axp=[adft adft(end) fliplr(adft) dft(1)];
load obs_rings_comps

ts_a=obs_chl_a.ks_05(1:12);
std_ts_a=obs_chl_a.ks_std_05(1:12);
n_ts_a=obs_chl_a.ks_n(1:12);

ts_c=obs_chl_c.ks_05(1:12);
std_ts_c=obs_chl_c.ks_std_05(1:12);
n_ts_c=obs_chl_c.ks_n(1:12);

ci_a=abs(std_ts_a./sqrt(n_ts_a-1));
ci_c=abs(std_ts_c./sqrt(n_ts_c-1));

ts_a=interp1(adft,ts_a,dft,'linear','extrap');
ts_c=interp1(adft,ts_c,dft,'linear','extrap');
ci_a=interp1(adft,ci_a,dft,'linear','extrap');
ci_c=interp1(adft,ci_c,dft,'linear','extrap');

xts_a=[ts_a-ci_a ts_a(end)+ci_a(end) fliplr(ts_a+ci_a) ts_a(1)-ci_a(1)];
xts_c=[ts_c-ci_c ts_c(end)+ci_c(end) fliplr(ts_c+ci_c) ts_c(1)-ci_c(1)];

figure(1)
clf
set(gcf,'PaperPosition',[1 1 10 5.5])
patch(xp/5,xts_a,[.8 .8 .8])
patch(xp/5,xts_c,[.8 .8 .8])
hold on
plot(dft/5,ts_a,'r','linewidth',4)
hold on
plot(dft/5,ts_c,'b','linewidth',4)
axis tight

xlabel('eddy age (weeks)','fontsize',20,'fontweight','bold')
ylabel(['CHL',char(39),char(39)],'fontsize',20,'fontweight','bold')
line([1 40],[0 0],'color','k','LineWidth',2)
set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top')
set(gca,'xtick',[0:2:12],'ylim',[-.6 .6])
box
title(['Observed CHL',char(39),char(39),' GS rings'])
print -dpng -r300 figs/Obs_CHL_ts


ts_a=smooth1d_loess(obs_ssh_a.ks_05,1:length(obs_ssh_a.ks_05),6,1:12);
std_ts_a=smooth1d_loess(obs_ssh_a.ks_std_05,1:1:length(obs_ssh_a.ks_05),6,1:12);
n_ts_a=obs_ssh_a.ks_n(1:12);

ts_c=smooth1d_loess(obs_ssh_c.ks_05,1:length(obs_ssh_c.ks_05),6,1:12);
std_ts_c=smooth1d_loess(obs_ssh_c.ks_std_05,1:1:length(obs_ssh_c.ks_05),6,1:12);
n_ts_c=obs_ssh_c.ks_n(1:12);

ci_a=abs(std_ts_a./sqrt(n_ts_a-1));
ci_c=abs(std_ts_c./sqrt(n_ts_c-1));

ts_a=interp1(adft,ts_a,dft,'linear','extrap');
ts_c=interp1(adft,ts_c,dft,'linear','extrap');
ci_a=interp1(adft,ci_a,dft,'linear','extrap');
ci_c=interp1(adft,ci_c,dft,'linear','extrap');


xts_a=[ts_a-ci_a ts_a(end)+ci_a(end) fliplr(ts_a+ci_a) ts_a(1)-ci_a(1)];
xts_c=[ts_c-ci_c ts_c(end)+ci_c(end) fliplr(ts_c+ci_c) ts_c(1)-ci_c(1)];

figure(1)
clf
set(gcf,'PaperPosition',[1 1 10 5.5])
patch(xp/5,xts_a,[.8 .8 .8])
patch(xp/5,xts_c,[.8 .8 .8])
hold on
plot(dft/5,ts_a,'r','linewidth',4)
hold on
plot(dft/5,ts_c,'b','linewidth',4)
axis tight

xlabel('eddy age (weeks)','fontsize',20,'fontweight','bold')
ylabel(['SSH',char(39),char(39)],'fontsize',20,'fontweight','bold')
line([1 40],[0 0],'color','k','LineWidth',2)
set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top')
set(gca,'xtick',[0:2:12])
box
title(['Observed SSH',char(39),char(39),' GS rings'])
print -dpng -r300 figs/Obs_SSH_ts

figure(1)
clf
set(gcf,'PaperPosition',[1 1 10 5.5])
plot(dft/5,dfdx_abs(ts_a,1/5),'r','linewidth',4)
hold on
plot(dft/5,dfdx_abs(ts_c,1/5),'b','linewidth',4)
axis tight

xlabel('eddy age (weeks)','fontsize',20,'fontweight','bold')
ylabel(['dSSH/dt',char(39),char(39)],'fontsize',20,'fontweight','bold')
line([1 40],[0 0],'color','k','LineWidth',2)
set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top')
set(gca,'xtick',[0:2:12])
box
title(['Observed dSSHdt GS rings'])
print -dpng -r300 figs/Obs_dSSHdt_ts



load pop_rings_comps
ts_a=norm_hp66_chl_a.ks_05(1:12);
std_ts_a=norm_hp66_chl_a.ks_std_05(1:12);
n_ts_a=norm_hp66_chl_a.ks_n(1:12);

ts_c=norm_hp66_chl_c.ks_05(1:12);
std_ts_c=norm_hp66_chl_c.ks_std_05(1:12);
n_ts_c=norm_hp66_chl_c.ks_n(1:12);

ci_a=abs(std_ts_a./sqrt(n_ts_a-1));
ci_c=abs(std_ts_c./sqrt(n_ts_c-1));
xts_a=[ts_a-ci_a ts_a(end)+ci_a(end) fliplr(ts_a+ci_a) ts_a(1)-ci_a(1)];
xts_c=[ts_c-ci_c ts_c(end)+ci_c(end) fliplr(ts_c+ci_c) ts_c(1)-ci_c(1)];

figure(1)
clf
set(gcf,'PaperPosition',[1 1 10 5.5])
patch(xp/5,xts_a,[.8 .8 .8])
patch(xp/5,xts_c,[.8 .8 .8])
hold on
plot(dft/5,ts_a,'r','linewidth',4)
hold on
plot(dft/5,ts_c,'b','linewidth',4)
axis tight

xlabel('eddy age (weeks)','fontsize',20,'fontweight','bold')
ylabel(['CHL',char(39),char(39)],'fontsize',20,'fontweight','bold')
line([1 40],[0 0],'color','k','LineWidth',2)
set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top')
set(gca,'xtick',[0:2:20],'ylim',[-.6 .6])
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
patch(xp/5,xts_a,[.8 .8 .8])
patch(xp/5,xts_c,[.8 .8 .8])
hold on
plot(dft/5,ts_a,'r','linewidth',4)
hold on
plot(dft/5,ts_c,'b','linewidth',4)
axis tight

xlabel('eddy age (weeks)','fontsize',20,'fontweight','bold')
ylabel(['SSH',char(39),char(39)],'fontsize',20,'fontweight','bold')
line([1 40],[0 0],'color','k','LineWidth',2)
set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top')
set(gca,'xtick',[0:2:20])
box
title(['POP SSH',char(39),char(39),' GS rings'])
print -dpng -r300 figs/ssh_ts

figure(1)
clf
set(gcf,'PaperPosition',[1 1 10 5.5])
plot(dft/5,dfdx_abs(ts_a,1/5),'r','linewidth',4)
hold on
plot(dft/5,dfdx_abs(ts_c,1/5),'b','linewidth',4)
axis tight

xlabel('eddy age (weeks)','fontsize',20,'fontweight','bold')
ylabel(['dSSH/dt',char(39),char(39)],'fontsize',20,'fontweight','bold')
line([1 40],[0 0],'color','k','LineWidth',2)
set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top')
set(gca,'xtick',[0:2:12])
box
title(['POP dSSHdt GS rings'])
print -dpng -r300 figs/POP_dSSHdt_ts
