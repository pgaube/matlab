clear all
tend=12
dft=1:tend;
xp=[dft dft(end) fliplr(dft) dft(1)];


vars={'ssh','norm_hp66_chl','norm_hp66_c','w',...
    'diat_c','diaz_c','sp_c',...
    'norm_hp66_diaz_c','norm_hp66_diat_c','norm_hp66_sp_c',...
    'small_bio','diaz_bio','diat_bio',...
    'nh4','no3','po4',...
    'tnh4','tno3','tpo4',...
    'small_vadv','diaz_vadv','diat_vadv',...
    'small_pp','diaz_pp','diat_pp'};

orgin_vars={'chl_orgin','ssh_orgin','small_c_orgin','diat_c_orgin','diaz_c_orgin',...
    'nh4_orgin','no3_orgin','po4_orgin','bio_small_orgin','bio_diat_orgin','bio_diaz_orgin'};
% 
% for m=1:length(vars)
%     load('pop_stream_12_weeks',[vars{m},'*'])
%     eval(['ts_a=',vars{m},'_a.ks_c(1:tend);'])
%     eval(['std_ts_a=',vars{m},'_a.ks_std_05(1:tend);'])
%     eval(['n_ts_a=',vars{m},'_a.ks_n(1:tend);'])
%     
%     eval(['ts_c=',vars{m},'_c.ks_c(1:tend);'])
%     eval(['std_ts_c=',vars{m},'_c.ks_std_05(1:tend);'])
%     eval(['n_ts_c=',vars{m},'_c.ks_n(1:tend);'])
%     
%     ci_a=abs(std_ts_a./sqrt(n_ts_a-1));
%     ci_c=abs(std_ts_c./sqrt(n_ts_c-1));
%     xts_a=[ts_a-ci_a ts_a(end)+ci_a(end) fliplr(ts_a+ci_a) ts_a(1)-ci_a(1)];
%     xts_c=[ts_c-ci_c ts_c(end)+ci_c(end) fliplr(ts_c+ci_c) ts_c(1)-ci_c(1)];
%     
%     load('case_study_pop_comps',[vars{m},'*'])
%     eval(['cs_ts_a=',vars{m},'_a.ks_c(1:tend);'])
%     eval(['cs_ts_c=',vars{m},'_c.ks_c(1:tend);'])
% 
%     
%     figure(1)
%     clf
%     set(gcf,'PaperPosition',[1 1 10 5.5])
%     patch(xp,xts_a,[.8 .8 .8])
%     patch(xp,xts_c,[.8 .8 .8])
%     hold on
%     plot(dft,ts_a,'r','linewidth',4)
%     hold on
%     plot(dft,ts_c,'b','linewidth',4)
%     plot(dft,cs_ts_a,'r','linewidth',1)
%     plot(dft,cs_ts_c,'b','linewidth',1)
%     axis tight
%     
%     xlabel('eddy age (weeks)','fontsize',20,'fontweight','bold')
%     % ylabel(['mg m^{-3} per second?'],'fontsize',20,'fontweight','bold')
%     line([1 12],[0 0],'color','k','LineWidth',2)
%     set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top')
%     set(gca,'xtick',[0:2:20],'xlim',[1 12])
%     box
%     title(vars{m})
%     eval(['print -dpng -r300 figs/stream_ts/',vars{m},'_ts'])
% end


for m=1:length(orgin_vars)
    load('pop_stream_12_weeks',[orgin_vars{m},'*'])
    eval(['ts_a=',orgin_vars{m},'_a.ks_orgin(1:tend);'])
    eval(['std_ts_a=',orgin_vars{m},'_a.ks_orgin_std(1:tend);'])
    eval(['n_ts_a=',orgin_vars{m},'_a.ks_orgin(1:tend);'])
    
    eval(['ts_c=',orgin_vars{m},'_c.ks_orgin(1:tend);'])
    eval(['std_ts_c=',orgin_vars{m},'_c.ks_orgin_std(1:tend);'])
    eval(['n_ts_c=',orgin_vars{m},'_c.ks_orgin(1:tend);'])
    
    ci_a=abs(std_ts_a./sqrt(n_ts_a-1));
    ci_c=abs(std_ts_c./sqrt(n_ts_c-1));
    
    xts_a=[ts_a-ci_a ts_a(end)+ci_a(end) fliplr(ts_a+ci_a) ts_a(1)-ci_a(1)];
    xts_c=[ts_c-ci_c ts_c(end)+ci_c(end) fliplr(ts_c+ci_c) ts_c(1)-ci_c(1)];
    
    load('case_study_pop_comps',[orgin_vars{m},'*'])
    eval(['cs_ts_a=',orgin_vars{m},'_a.ks_orgin(1:tend);'])
    eval(['cs_ts_c=',orgin_vars{m},'_c.ks_orgin(1:tend);'])
    
    figure(1)
    clf
        set(gcf,'PaperPosition',[1 1 10 5.5])
%     patch(xp,xts_a,[.8 .8 .8])
%     patch(xp,xts_c,[.8 .8 .8])
    hold on
    plot(dft,ts_a,'r','linewidth',4)
    hold on
    plot(dft,ts_c,'b','linewidth',4)
    plot(dft,cs_ts_a,'r','linewidth',1)
    plot(dft,cs_ts_c,'b','linewidth',1)
    axis tight
    
    xlabel('eddy age (weeks)','fontsize',20,'fontweight','bold')
    % ylabel(['mg m^{-3} per second?'],'fontsize',20,'fontweight','bold')
    line([1 12],[0 0],'color','k','LineWidth',2)
    set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top')
    set(gca,'xtick',[0:2:20],'xlim',[1 12])
    box
    title(orgin_vars{m})
    eval(['print -dpng -r300 figs/stream_ts/',orgin_vars{m},'_ts'])
end
return

%%now normalized biomass propoportions
tend=12
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
set(gca,'ylim',[.1 .7],'xlim',[1 12],'fontsize',10,'fontweight','bold','LineWidth',.5,'TickLength',[.01 .05],'layer','top')


subplot(212)
hold on
plot(1:length(a_prop_diat),c_prop_diat,'k-*')
plot(1:length(a_prop_diat),c_prop_small,'k')
plot(1:length(a_prop_diat),c_prop_diaz,'k--')
legend('diat','small','diaz')
title('cyclones')
set(gca,'ylim',[.1 .7],'xlim',[1 12],'fontsize',10,'fontweight','bold','LineWidth',.5,'TickLength',[.01 .05],'layer','top')
xlabel('weeks')
print -dpng -r300 figs/stream_ts/rings_diveristy_ks_c_L
return
% 
% %%%%
% % Diaz SS
% %%%%
% ts_a=smooth1d_loess(diaz_pp_a.ks_c,1:length(diaz_pp_a.ks_c),6,1:tend);
% std_ts_a=smooth1d_loess(diaz_pp_a.ks_std_05,1:1:length(diaz_pp_a.ks_c),6,1:tend);
% n_ts_a=diaz_pp_a.ks_n(1:tend);
% 
% ts_c=smooth1d_loess(diaz_pp_c.ks_c,1:length(diaz_pp_c.ks_c),6,1:tend);
% std_ts_c=smooth1d_loess(diaz_pp_c.ks_std_05,1:1:length(diaz_pp_c.ks_c),6,1:tend);
% n_ts_c=diaz_pp_c.ks_n(1:tend);
% 
% ci_a=abs(std_ts_a./sqrt(n_ts_a-1));
% ci_c=abs(std_ts_c./sqrt(n_ts_c-1));
% xts_a=[ts_a-ci_a ts_a(end)+ci_a(end) fliplr(ts_a+ci_a) ts_a(1)-ci_a(1)];
% xts_c=[ts_c-ci_c ts_c(end)+ci_c(end) fliplr(ts_c+ci_c) ts_c(1)-ci_c(1)];
% 
% figure(3)
% clf
% set(gcf,'PaperPosition',[1 1 10 5.5])
% patch(xp,xts_a,[.8 .8 .8])
% patch(xp,xts_c,[.8 .8 .8])
% hold on
% plot(dft,ts_a,'r','linewidth',4)
% hold on
% plot(dft,ts_c,'b','linewidth',4)
% axis tight
% 
% xlabel('eddy age (weeks)','fontsize',20,'fontweight','bold')
% ylabel(['mg m^{-3} per second?'],'fontsize',20,'fontweight','bold')
% line([1 40],[0 0],'color','k','LineWidth',2)
% set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top')
% set(gca,'xtick',[0:2:20])
% box
% title(['Diaz PP',' GS rings'])
% print -dpng -r300 figs/diaz_pp_ts
% 
% %%%%
% % Diat SS
% %%%%
% ts_a=smooth1d_loess(diat_pp_a.ks_c,1:length(diat_pp_a.ks_c),6,1:tend);
% std_ts_a=smooth1d_loess(diat_pp_a.ks_std_05,1:1:length(diat_pp_a.ks_c),6,1:tend);
% n_ts_a=diat_pp_a.ks_n(1:tend);
% 
% ts_c=smooth1d_loess(diat_pp_c.ks_c,1:length(diat_pp_c.ks_c),6,1:tend);
% std_ts_c=smooth1d_loess(diat_pp_c.ks_std_05,1:1:length(diat_pp_c.ks_c),6,1:tend);
% n_ts_c=diat_pp_c.ks_n(1:tend);
% 
% ci_a=abs(std_ts_a./sqrt(n_ts_a-1));
% ci_c=abs(std_ts_c./sqrt(n_ts_c-1));
% xts_a=[ts_a-ci_a ts_a(end)+ci_a(end) fliplr(ts_a+ci_a) ts_a(1)-ci_a(1)];
% xts_c=[ts_c-ci_c ts_c(end)+ci_c(end) fliplr(ts_c+ci_c) ts_c(1)-ci_c(1)];
% 
% figure(3)
% clf
% set(gcf,'PaperPosition',[1 1 10 5.5])
% patch(xp,xts_a,[.8 .8 .8])
% patch(xp,xts_c,[.8 .8 .8])
% hold on
% plot(dft,ts_a,'r','linewidth',4)
% hold on
% plot(dft,ts_c,'b','linewidth',4)
% axis tight
% 
% xlabel('eddy age (weeks)','fontsize',20,'fontweight','bold')
% ylabel(['mg m^{-3} per second?'],'fontsize',20,'fontweight','bold')
% line([1 40],[0 0],'color','k','LineWidth',2)
% set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top')
% set(gca,'xtick',[0:2:20])
% box
% title(['Diat PP',' GS rings'])
% print -dpng -r300 figs/diat_pp_ts
% 
% 
% 
% 
% %%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%
% %% Vertical Advection
% %%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%
% %%%%
% % Small
% %%%%
% ts_a=smooth1d_loess(small_vadv_a.ks_c,1:length(small_vadv_a.ks_c),6,1:tend);
% std_ts_a=smooth1d_loess(small_vadv_a.ks_std_05,1:1:length(small_vadv_a.ks_c),6,1:tend);
% n_ts_a=small_vadv_a.ks_n(1:tend);
% 
% ts_c=smooth1d_loess(small_vadv_c.ks_c,1:length(small_vadv_c.ks_c),6,1:tend);
% std_ts_c=smooth1d_loess(small_vadv_c.ks_std_05,1:1:length(small_vadv_c.ks_c),6,1:tend);
% n_ts_c=small_vadv_c.ks_n(1:tend);
% 
% ci_a=abs(std_ts_a./sqrt(n_ts_a-1));
% ci_c=abs(std_ts_c./sqrt(n_ts_c-1));
% xts_a=[ts_a-ci_a ts_a(end)+ci_a(end) fliplr(ts_a+ci_a) ts_a(1)-ci_a(1)];
% xts_c=[ts_c-ci_c ts_c(end)+ci_c(end) fliplr(ts_c+ci_c) ts_c(1)-ci_c(1)];
% 
% figure(3)
% clf
% set(gcf,'PaperPosition',[1 1 10 5.5])
% patch(xp,xts_a,[.8 .8 .8])
% patch(xp,xts_c,[.8 .8 .8])
% hold on
% plot(dft,ts_a,'r','linewidth',4)
% hold on
% plot(dft,ts_c,'b','linewidth',4)
% axis tight
% 
% xlabel('eddy age (weeks)','fontsize',20,'fontweight','bold')
% ylabel(['mg m^{-3} per second?'],'fontsize',20,'fontweight','bold')
% line([1 40],[0 0],'color','k','LineWidth',2)
% set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top')
% set(gca,'xtick',[0:2:20])
% box
% title(['Small Phyto Vertical Adv',' GS rings'])
% print -dpng -r300 figs/small_vadv_ts
% 
% %%%%
% % Diaz
% %%%%
% ts_a=smooth1d_loess(diaz_vadv_a.ks_c,1:length(diaz_vadv_a.ks_c),6,1:tend);
% std_ts_a=smooth1d_loess(diaz_vadv_a.ks_std_05,1:1:length(diaz_vadv_a.ks_c),6,1:tend);
% n_ts_a=diaz_vadv_a.ks_n(1:tend);
% 
% ts_c=smooth1d_loess(diaz_vadv_c.ks_c,1:length(diaz_vadv_c.ks_c),6,1:tend);
% std_ts_c=smooth1d_loess(diaz_vadv_c.ks_std_05,1:1:length(diaz_vadv_c.ks_c),6,1:tend);
% n_ts_c=diaz_vadv_c.ks_n(1:tend);
% 
% ci_a=abs(std_ts_a./sqrt(n_ts_a-1));
% ci_c=abs(std_ts_c./sqrt(n_ts_c-1));
% xts_a=[ts_a-ci_a ts_a(end)+ci_a(end) fliplr(ts_a+ci_a) ts_a(1)-ci_a(1)];
% xts_c=[ts_c-ci_c ts_c(end)+ci_c(end) fliplr(ts_c+ci_c) ts_c(1)-ci_c(1)];
% 
% figure(3)
% clf
% set(gcf,'PaperPosition',[1 1 10 5.5])
% patch(xp,xts_a,[.8 .8 .8])
% patch(xp,xts_c,[.8 .8 .8])
% hold on
% plot(dft,ts_a,'r','linewidth',4)
% hold on
% plot(dft,ts_c,'b','linewidth',4)
% axis tight
% 
% xlabel('eddy age (weeks)','fontsize',20,'fontweight','bold')
% ylabel(['mg m^{-3} per second?'],'fontsize',20,'fontweight','bold')
% line([1 40],[0 0],'color','k','LineWidth',2)
% set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top')
% set(gca,'xtick',[0:2:20])
% box
% title(['Diaz Vertical Adv',' GS rings'])
% print -dpng -r300 figs/diaz_vadv_ts
% 
% %%%%
% % Diat
% %%%%
% ts_a=smooth1d_loess(diat_vadv_a.ks_c,1:length(diat_vadv_a.ks_c),6,1:tend);
% std_ts_a=smooth1d_loess(diat_vadv_a.ks_std_05,1:1:length(diat_vadv_a.ks_c),6,1:tend);
% n_ts_a=diat_vadv_a.ks_n(1:tend);
% 
% ts_c=smooth1d_loess(diat_vadv_c.ks_c,1:length(diat_vadv_c.ks_c),6,1:tend);
% std_ts_c=smooth1d_loess(diat_vadv_c.ks_std_05,1:1:length(diat_vadv_c.ks_c),6,1:tend);
% n_ts_c=diat_vadv_c.ks_n(1:tend);
% 
% ci_a=abs(std_ts_a./sqrt(n_ts_a-1));
% ci_c=abs(std_ts_c./sqrt(n_ts_c-1));
% xts_a=[ts_a-ci_a ts_a(end)+ci_a(end) fliplr(ts_a+ci_a) ts_a(1)-ci_a(1)];
% xts_c=[ts_c-ci_c ts_c(end)+ci_c(end) fliplr(ts_c+ci_c) ts_c(1)-ci_c(1)];
% 
% figure(3)
% clf
% set(gcf,'PaperPosition',[1 1 10 5.5])
% patch(xp,xts_a,[.8 .8 .8])
% patch(xp,xts_c,[.8 .8 .8])
% hold on
% plot(dft,ts_a,'r','linewidth',4)
% hold on
% plot(dft,ts_c,'b','linewidth',4)
% axis tight
% 
% xlabel('eddy age (weeks)','fontsize',20,'fontweight','bold')
% ylabel(['mg m^{-3} per second?'],'fontsize',20,'fontweight','bold')
% line([1 40],[0 0],'color','k','LineWidth',2)
% set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top')
% set(gca,'xtick',[0:2:20])
% box
% title(['Diat Vertical Adv',' GS rings'])
% print -dpng -r300 figs/diat_vadv_ts
% 
% 
% 
% 
% %%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%
% %% Upwelling
% %%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%
% 
% ts_a=smooth1d_loess(w_a.ks_c,1:length(w_a.ks_c),6,1:tend);
% std_ts_a=smooth1d_loess(w_a.ks_std_05,1:1:length(w_a.ks_c),6,1:tend);
% n_ts_a=w_a.ks_n(1:tend);
% 
% ts_c=smooth1d_loess(w_c.ks_c,1:length(w_c.ks_c),6,1:tend);
% std_ts_c=smooth1d_loess(w_c.ks_std_05,1:1:length(w_c.ks_c),6,1:tend);
% n_ts_c=w_c.ks_n(1:tend);
% 
% ci_a=abs(std_ts_a./sqrt(n_ts_a-1));
% ci_c=abs(std_ts_c./sqrt(n_ts_c-1));
% xts_a=[ts_a-ci_a ts_a(end)+ci_a(end) fliplr(ts_a+ci_a) ts_a(1)-ci_a(1)];
% xts_c=[ts_c-ci_c ts_c(end)+ci_c(end) fliplr(ts_c+ci_c) ts_c(1)-ci_c(1)];
% 
% figure(3)
% clf
% set(gcf,'PaperPosition',[1 1 10 5.5])
% patch(xp,xts_a,[.8 .8 .8])
% patch(xp,xts_c,[.8 .8 .8])
% hold on
% plot(dft,ts_a,'r','linewidth',4)
% hold on
% plot(dft,ts_c,'b','linewidth',4)
% axis tight
% 
% xlabel('eddy age (weeks)','fontsize',20,'fontweight','bold')
% ylabel(['m per second?'],'fontsize',20,'fontweight','bold')
% line([1 40],[0 0],'color','k','LineWidth',2)
% set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top')
% set(gca,'xtick',[0:2:20])
% box
% title(['Vertical velocity',' GS rings'])
% print -dpng -r300 figs/w_ts
% 
% %%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%
% %% Sorces/Sinks
% %%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%
% %%%%
% % Small SS
% %%%%
% ts_a=smooth1d_loess(small_bio_a.ks_c,1:length(small_bio_a.ks_c),6,1:tend);
% std_ts_a=smooth1d_loess(small_bio_a.ks_std_05,1:1:length(small_bio_a.ks_c),6,1:tend);
% n_ts_a=small_bio_a.ks_n(1:tend);
% 
% ts_c=smooth1d_loess(small_bio_c.ks_c,1:length(small_bio_c.ks_c),6,1:tend);
% std_ts_c=smooth1d_loess(small_bio_c.ks_std_05,1:1:length(small_bio_c.ks_c),6,1:tend);
% n_ts_c=small_bio_c.ks_n(1:tend);
% 
% ci_a=abs(std_ts_a.*tinv((.05)/2,n_ts_a-1)./sqrt(n_ts_a-1));
% ci_c=abs(std_ts_c.*tinv((.05)/2,n_ts_c-1)./sqrt(n_ts_c-1));
% xts_a=[ts_a-ci_a ts_a(end)+ci_a(end) fliplr(ts_a+ci_a) ts_a(1)-ci_a(1)];
% xts_c=[ts_c-ci_c ts_c(end)+ci_c(end) fliplr(ts_c+ci_c) ts_c(1)-ci_c(1)];
% 
% figure(3)
% clf
% set(gcf,'PaperPosition',[1 1 10 5.5])
% patch(xp,xts_a,[.8 .8 .8])
% patch(xp,xts_c,[.8 .8 .8])
% hold on
% plot(dft,ts_a,'r','linewidth',4)
% hold on
% plot(dft,ts_c,'b','linewidth',4)
% axis tight
% 
% xlabel('eddy age (weeks)','fontsize',20,'fontweight','bold')
% ylabel(['mg m^{-3} per second?'],'fontsize',20,'fontweight','bold')
% line([1 40],[0 0],'color','k','LineWidth',2)
% set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top')
% set(gca,'xtick',[0:2:20])
% box
% title(['Small biological sources/sinks',' GS rings'])
% print -dpng -r300 figs/small_bio_ts
% 
% %%%%
% % Diaz SS
% %%%%
% ts_a=smooth1d_loess(diaz_bio_a.ks_c,1:length(diaz_bio_a.ks_c),6,1:tend);
% std_ts_a=smooth1d_loess(diaz_bio_a.ks_std_05,1:1:length(diaz_bio_a.ks_c),6,1:tend);
% n_ts_a=diaz_bio_a.ks_n(1:tend);
% 
% ts_c=smooth1d_loess(diaz_bio_c.ks_c,1:length(diaz_bio_c.ks_c),6,1:tend);
% std_ts_c=smooth1d_loess(diaz_bio_c.ks_std_05,1:1:length(diaz_bio_c.ks_c),6,1:tend);
% n_ts_c=diaz_bio_c.ks_n(1:tend);
% 
% ci_a=abs(std_ts_a.*tinv((.05)/2,n_ts_a-1)./sqrt(n_ts_a-1));
% ci_c=abs(std_ts_c.*tinv((.05)/2,n_ts_c-1)./sqrt(n_ts_c-1));
% xts_a=[ts_a-ci_a ts_a(end)+ci_a(end) fliplr(ts_a+ci_a) ts_a(1)-ci_a(1)];
% xts_c=[ts_c-ci_c ts_c(end)+ci_c(end) fliplr(ts_c+ci_c) ts_c(1)-ci_c(1)];
% 
% figure(3)
% clf
% set(gcf,'PaperPosition',[1 1 10 5.5])
% patch(xp,xts_a,[.8 .8 .8])
% patch(xp,xts_c,[.8 .8 .8])
% hold on
% plot(dft,ts_a,'r','linewidth',4)
% hold on
% plot(dft,ts_c,'b','linewidth',4)
% axis tight
% 
% xlabel('eddy age (weeks)','fontsize',20,'fontweight','bold')
% ylabel(['mg m^{-3} per second?'],'fontsize',20,'fontweight','bold')
% line([1 40],[0 0],'color','k','LineWidth',2)
% set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top')
% set(gca,'xtick',[0:2:20])
% box
% title(['Diaz biological sources/sink',' GS rings'])
% print -dpng -r300 figs/diaz_bio_ts
% 
% %%%%
% % Diat SS
% %%%%
% ts_a=smooth1d_loess(diat_bio_a.ks_c,1:length(diat_bio_a.ks_c),6,1:tend);
% std_ts_a=smooth1d_loess(diat_bio_a.ks_std_05,1:1:length(diat_bio_a.ks_c),6,1:tend);
% n_ts_a=diat_bio_a.ks_n(1:tend);
% 
% ts_c=smooth1d_loess(diat_bio_c.ks_c,1:length(diat_bio_c.ks_c),6,1:tend);
% std_ts_c=smooth1d_loess(diat_bio_c.ks_std_05,1:1:length(diat_bio_c.ks_c),6,1:tend);
% n_ts_c=diat_bio_c.ks_n(1:tend);
% 
% ci_a=abs(std_ts_a.*tinv((.05)/2,n_ts_a-1)./sqrt(n_ts_a-1));
% ci_c=abs(std_ts_c.*tinv((.05)/2,n_ts_c-1)./sqrt(n_ts_c-1));
% xts_a=[ts_a-ci_a ts_a(end)+ci_a(end) fliplr(ts_a+ci_a) ts_a(1)-ci_a(1)];
% xts_c=[ts_c-ci_c ts_c(end)+ci_c(end) fliplr(ts_c+ci_c) ts_c(1)-ci_c(1)];
% 
% figure(3)
% clf
% set(gcf,'PaperPosition',[1 1 10 5.5])
% patch(xp,xts_a,[.8 .8 .8])
% patch(xp,xts_c,[.8 .8 .8])
% hold on
% plot(dft,ts_a,'r','linewidth',4)
% hold on
% plot(dft,ts_c,'b','linewidth',4)
% axis tight
% 
% xlabel('eddy age (weeks)','fontsize',20,'fontweight','bold')
% ylabel(['mg m^{-3} per second?'],'fontsize',20,'fontweight','bold')
% line([1 40],[0 0],'color','k','LineWidth',2)
% set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top')
% set(gca,'xtick',[0:2:20])
% box
% title(['Diat biological sources/sink',' GS rings'])
% print -dpng -r300 figs/diat_bio_ts
% 
% 
% 
% 
% %%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%
% %% NUTS total
% %%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%
% 
% 
% %%%%
% % PO4
% %%%%
% ts_a=tpo4_a.ks_c(1:tend);
% std_ts_a=tpo4_a.ks_std_1(1:tend);
% n_ts_a=tpo4_a.ks_n(1:tend);
% 
% ts_c=tpo4_c.ks_c(1:tend);
% std_ts_c=tpo4_c.ks_std_1(1:tend);
% n_ts_c=tpo4_c.ks_n(1:tend);
% 
% ci_a=abs(std_ts_a./sqrt(n_ts_a-1));
% ci_c=abs(std_ts_c./sqrt(n_ts_c-1));
% xts_a=[ts_a-ci_a ts_a(end)+ci_a(end) fliplr(ts_a+ci_a) ts_a(1)-ci_a(1)];
% xts_c=[ts_c-ci_c ts_c(end)+ci_c(end) fliplr(ts_c+ci_c) ts_c(1)-ci_c(1)];
% 
% figure(3)
% clf
% set(gcf,'PaperPosition',[1 1 10 5.5])
% patch(xp,xts_a,[.8 .8 .8])
% patch(xp,xts_c,[.8 .8 .8])
% hold on
% plot(dft,ts_a,'r','linewidth',4)
% hold on
% plot(dft,ts_c,'b','linewidth',4)
% axis tight
% 
% xlabel('eddy age (weeks)','fontsize',20,'fontweight','bold')
% ylabel(['\mu mol'],'fontsize',20,'fontweight','bold')
% line([1 40],[0 0],'color','k','LineWidth',2)
% set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top')
% set(gca,'xtick',[0:2:20])
% box
% title(['Total PO_4',' GS rings'])
% print -dpng -r300 figs/total_po4_ts
% 
% 
% %%%%
% % NH4
% %%%%
% ts_a=tnh4_a.ks_c(1:tend);
% std_ts_a=tnh4_a.ks_std_1(1:tend);
% n_ts_a=tnh4_a.ks_n(1:tend);
% 
% ts_c=tnh4_c.ks_c(1:tend);
% std_ts_c=tnh4_c.ks_std_1(1:tend);
% n_ts_c=tnh4_c.ks_n(1:tend);
% 
% ci_a=abs(std_ts_a./sqrt(n_ts_a-1));
% ci_c=abs(std_ts_c./sqrt(n_ts_c-1));
% xts_a=[ts_a-ci_a ts_a(end)+ci_a(end) fliplr(ts_a+ci_a) ts_a(1)-ci_a(1)];
% xts_c=[ts_c-ci_c ts_c(end)+ci_c(end) fliplr(ts_c+ci_c) ts_c(1)-ci_c(1)];
% 
% figure(3)
% clf
% set(gcf,'PaperPosition',[1 1 10 5.5])
% patch(xp,xts_a,[.8 .8 .8])
% patch(xp,xts_c,[.8 .8 .8])
% hold on
% plot(dft,ts_a,'r','linewidth',4)
% hold on
% plot(dft,ts_c,'b','linewidth',4)
% axis tight
% 
% xlabel('eddy age (weeks)','fontsize',20,'fontweight','bold')
% ylabel(['\mu mol'],'fontsize',20,'fontweight','bold')
% line([1 40],[0 0],'color','k','LineWidth',2)
% set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top')
% set(gca,'xtick',[0:2:20])
% box
% title(['Total NH_4',' GS rings'])
% print -dpng -r300 figs/total_nh4_ts
% 
% 
% %%%%
% % NO3
% %%%%
% ts_a=tno3_a.ks_c(1:tend);
% std_ts_a=tno3_a.ks_std_1(1:tend);
% n_ts_a=tno3_a.ks_n(1:tend);
% 
% ts_c=tno3_c.ks_c(1:tend);
% std_ts_c=tno3_c.ks_std_1(1:tend);
% n_ts_a=tno3_c.ks_n(1:tend);
% 
% ci_a=abs(std_ts_a./sqrt(n_ts_a-1));
% ci_c=abs(std_ts_c./sqrt(n_ts_c-1));
% xts_a=[ts_a-ci_a ts_a(end)+ci_a(end) fliplr(ts_a+ci_a) ts_a(1)-ci_a(1)];
% xts_c=[ts_c-ci_c ts_c(end)+ci_c(end) fliplr(ts_c+ci_c) ts_c(1)-ci_c(1)];
% 
% figure(3)
% clf
% set(gcf,'PaperPosition',[1 1 10 5.5])
% patch(xp,xts_a,[.8 .8 .8])
% patch(xp,xts_c,[.8 .8 .8])
% hold on
% plot(dft,ts_a,'r','linewidth',4)
% hold on
% plot(dft,ts_c,'b','linewidth',4)
% axis tight
% 
% xlabel('eddy age (weeks)','fontsize',20,'fontweight','bold')
% ylabel(['\mu mol'],'fontsize',20,'fontweight','bold')
% line([1 40],[0 0],'color','k','LineWidth',2)
% set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top')
% set(gca,'xtick',[0:2:20])
% box
% title(['Total NO_3',' GS rings'])
% print -dpng -r300 figs/total_no3_ts
% 
% 
% %%%N
% ts_a=tno3_a.ks_n(1:tend);
% 
% 
% ts_c=tno3_c.ks_n(1:tend);
% 
% 
% figure(3)
% clf
% set(gcf,'PaperPosition',[1 1 10 5.5])
% hold on
% plot(dft,ts_a,'r','linewidth',4)
% hold on
% plot(dft,ts_c,'b','linewidth',4)
% axis tight
% 
% xlabel('eddy age (weeks)','fontsize',20,'fontweight','bold')
% ylabel(['N'],'fontsize',20,'fontweight','bold')
% line([1 40],[0 0],'color','k','LineWidth',2)
% set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top','ylim',[0 275])
% set(gca,'xtick',[0:2:20])
% box
% title(['Number of Eddies',' GS rings'])
% print -dpng -r300 figs/N_ts
% return
% 
% 
% %%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%
% %% NUTS anonmaly
% %%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%
% 
% 
% %%%%
% % PO4
% %%%%
% ts_a=po4_a.ks_05(1:tend);
% std_ts_a=po4_a.ks_std_05(1:tend);
% n_ts_a=po4_a.ks_n(1:tend);
% 
% ts_c=po4_c.ks_05(1:tend);
% std_ts_c=po4_c.ks_std_05(1:tend);
% n_ts_c=po4_c.ks_n(1:tend);
% 
% ci_a=abs(std_ts_a.*tinv((.05)/2,n_ts_a-1)./sqrt(n_ts_a-1));
% ci_c=abs(std_ts_c.*tinv((.05)/2,n_ts_c-1)./sqrt(n_ts_c-1));
% xts_a=[ts_a-ci_a ts_a(end)+ci_a(end) fliplr(ts_a+ci_a) ts_a(1)-ci_a(1)];
% xts_c=[ts_c-ci_c ts_c(end)+ci_c(end) fliplr(ts_c+ci_c) ts_c(1)-ci_c(1)];
% 
% figure(3)
% clf
% set(gcf,'PaperPosition',[1 1 10 5.5])
% patch(xp,xts_a,[.8 .8 .8])
% patch(xp,xts_c,[.8 .8 .8])
% hold on
% plot(dft,ts_a,'r','linewidth',4)
% hold on
% plot(dft,ts_c,'b','linewidth',4)
% axis tight
% 
% xlabel('eddy age (weeks)','fontsize',20,'fontweight','bold')
% ylabel(['??'],'fontsize',20,'fontweight','bold')
% line([1 40],[0 0],'color','k','LineWidth',2)
% set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top')
% set(gca,'xtick',[0:2:20])
% box
% title(['PO_4 anomaly',' GS rings'])
% print -dpng -r300 figs/po4_ts
% 
% 
% %%%%
% % NH4
% %%%%
% ts_a=nh4_a.ks_05(1:tend);
% std_ts_a=nh4_a.ks_std_05(1:tend);
% n_ts_a=nh4_a.ks_n(1:tend);
% 
% ts_c=nh4_c.ks_05(1:tend);
% std_ts_c=nh4_c.ks_std_05(1:tend);
% n_ts_c=nh4_c.ks_n(1:tend);
% 
% ci_a=abs(std_ts_a.*tinv((.05)/2,n_ts_a-1)./sqrt(n_ts_a-1));
% ci_c=abs(std_ts_c.*tinv((.05)/2,n_ts_c-1)./sqrt(n_ts_c-1));
% xts_a=[ts_a-ci_a ts_a(end)+ci_a(end) fliplr(ts_a+ci_a) ts_a(1)-ci_a(1)];
% xts_c=[ts_c-ci_c ts_c(end)+ci_c(end) fliplr(ts_c+ci_c) ts_c(1)-ci_c(1)];
% 
% figure(3)
% clf
% set(gcf,'PaperPosition',[1 1 10 5.5])
% patch(xp,xts_a,[.8 .8 .8])
% patch(xp,xts_c,[.8 .8 .8])
% hold on
% plot(dft,ts_a,'r','linewidth',4)
% hold on
% plot(dft,ts_c,'b','linewidth',4)
% axis tight
% 
% xlabel('eddy age (weeks)','fontsize',20,'fontweight','bold')
% ylabel(['??'],'fontsize',20,'fontweight','bold')
% line([1 40],[0 0],'color','k','LineWidth',2)
% set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top')
% set(gca,'xtick',[0:2:20])
% box
% title(['NH_4 anomaly',' GS rings'])
% print -dpng -r300 figs/nh4_ts
% 
% 
% %%%%
% % NO3
% %%%%
% ts_a=no3_a.ks_05(1:tend);
% std_ts_a=no3_a.ks_std_05(1:tend);
% n_ts_a=no3_a.ks_n(1:tend);
% 
% ts_c=no3_c.ks_05(1:tend);
% std_ts_c=no3_c.ks_std_05(1:tend);
% n_ts_c=no3_c.ks_n(1:tend);
% 
% ci_a=abs(std_ts_a.*tinv((.05)/2,n_ts_a-1)./sqrt(n_ts_a-1));
% ci_c=abs(std_ts_c.*tinv((.05)/2,n_ts_c-1)./sqrt(n_ts_c-1));
% xts_a=[ts_a-ci_a ts_a(end)+ci_a(end) fliplr(ts_a+ci_a) ts_a(1)-ci_a(1)];
% xts_c=[ts_c-ci_c ts_c(end)+ci_c(end) fliplr(ts_c+ci_c) ts_c(1)-ci_c(1)];
% 
% figure(3)
% clf
% set(gcf,'PaperPosition',[1 1 10 5.5])
% patch(xp,xts_a,[.8 .8 .8])
% patch(xp,xts_c,[.8 .8 .8])
% hold on
% plot(dft,ts_a,'r','linewidth',4)
% hold on
% plot(dft,ts_c,'b','linewidth',4)
% axis tight
% 
% xlabel('eddy age (weeks)','fontsize',20,'fontweight','bold')
% ylabel(['??'],'fontsize',20,'fontweight','bold')
% line([1 40],[0 0],'color','k','LineWidth',2)
% set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top')
% set(gca,'xtick',[0:2:20])
% box
% title(['NO_3 anomaly',' GS rings'])
% print -dpng -r300 figs/no3_ts
% return
% 
% % % 
% % % %%%%%%%%%%%%%%%%
% % % %%%%%%%%%%%%%%%%
% % % %% BIOMASS
% % % %%%%%%%%%%%%%%%%
% % % %%%%%%%%%%%%%%%%
% % % %%%%
% % % % Small biomass
% % % %%%%
% % % ts_a=smooth1d_loess(norm_hp66_sp_c_a.ks_c,1:length(norm_hp66_sp_c_a.ks_c),6,1:tend);
% % % std_ts_a=smooth1d_loess(norm_hp66_sp_c_a.ks_std_05,1:1:length(norm_hp66_sp_c_a.ks_c),6,1:tend);
% % % n_ts_a=norm_hp66_sp_c_a.ks_n(1:tend);
% % % 
% % % ts_c=smooth1d_loess(norm_hp66_sp_c_c.ks_c,1:length(norm_hp66_sp_c_c.ks_c),6,1:tend);
% % % std_ts_c=smooth1d_loess(norm_hp66_sp_c_c.ks_std_05,1:1:length(norm_hp66_sp_c_c.ks_c),6,1:tend);
% % % n_ts_c=norm_hp66_sp_c_c.ks_n(1:tend);
% % % 
% % % ci_a=abs(std_ts_a.*tinv((.05)/2,n_ts_a-1)./sqrt(n_ts_a-1));
% % % ci_c=abs(std_ts_c.*tinv((.05)/2,n_ts_c-1)./sqrt(n_ts_c-1));
% % % xts_a=[ts_a-ci_a ts_a(end)+ci_a(end) fliplr(ts_a+ci_a) ts_a(1)-ci_a(1)];
% % % xts_c=[ts_c-ci_c ts_c(end)+ci_c(end) fliplr(ts_c+ci_c) ts_c(1)-ci_c(1)];
% % % 
% % % figure(3)
% % % clf
% % % set(gcf,'PaperPosition',[1 1 10 5.5])
% % % patch(xp,xts_a,[.8 .8 .8])
% % % patch(xp,xts_c,[.8 .8 .8])
% % % hold on
% % % plot(dft,ts_a,'r','linewidth',4)
% % % hold on
% % % plot(dft,ts_c,'b','linewidth',4)
% % % axis tight
% % % 
% % % xlabel('eddy age (weeks)','fontsize',20,'fontweight','bold')
% % % ylabel(['mg m^{-3}'],'fontsize',20,'fontweight','bold')
% % % line([1 40],[0 0],'color','k','LineWidth',2)
% % % set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top')
% % % set(gca,'xtick',[0:2:20])
% % % box
% % % title(['Small biomass anomaly',' GS rings'])
% % % print -dpng -r300 figs/norm_hp66_sp_c_ts
% % % 
% % % 
% % % %%%%
% % % % Diaz biomass
% % % %%%%
% % % ts_a=smooth1d_loess(norm_hp66_diaz_c_a.ks_c,1:length(norm_hp66_diaz_c_a.ks_c),6,1:tend);
% % % std_ts_a=smooth1d_loess(norm_hp66_diaz_c_a.ks_std_05,1:1:length(norm_hp66_diaz_c_a.ks_c),6,1:tend);
% % % n_ts_a=norm_hp66_diaz_c_a.ks_n(1:tend);
% % % 
% % % ts_c=smooth1d_loess(norm_hp66_diaz_c_c.ks_c,1:length(norm_hp66_diaz_c_c.ks_c),6,1:tend);
% % % std_ts_c=smooth1d_loess(norm_hp66_diaz_c_c.ks_std_05,1:1:length(norm_hp66_diaz_c_c.ks_c),6,1:tend);
% % % n_ts_c=norm_hp66_diaz_c_c.ks_n(1:tend);
% % % 
% % % ci_a=abs(std_ts_a.*tinv((.05)/2,n_ts_a-1)./sqrt(n_ts_a-1));
% % % ci_c=abs(std_ts_c.*tinv((.05)/2,n_ts_c-1)./sqrt(n_ts_c-1));
% % % xts_a=[ts_a-ci_a ts_a(end)+ci_a(end) fliplr(ts_a+ci_a) ts_a(1)-ci_a(1)];
% % % xts_c=[ts_c-ci_c ts_c(end)+ci_c(end) fliplr(ts_c+ci_c) ts_c(1)-ci_c(1)];
% % % 
% % % figure(3)
% % % clf
% % % set(gcf,'PaperPosition',[1 1 10 5.5])
% % % patch(xp,xts_a,[.8 .8 .8])
% % % patch(xp,xts_c,[.8 .8 .8])
% % % hold on
% % % plot(dft,ts_a,'r','linewidth',4)
% % % hold on
% % % plot(dft,ts_c,'b','linewidth',4)
% % % axis tight
% % % 
% % % xlabel('eddy age (weeks)','fontsize',20,'fontweight','bold')
% % % ylabel(['mg m^{-3}'],'fontsize',20,'fontweight','bold')
% % % line([1 40],[0 0],'color','k','LineWidth',2)
% % % set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top')
% % % set(gca,'xtick',[0:2:20])
% % % box
% % % title(['Diaz biomass anomaly',' GS rings'])
% % % print -dpng -r300 figs/norm_hp66_diaz_c_ts
% % % 
% % % %%%%
% % % % Diat biomass
% % % %%%%
% % % ts_a=smooth1d_loess(norm_hp66_diat_c_a.ks_c,1:length(norm_hp66_diat_c_a.ks_c),6,1:tend);
% % % std_ts_a=smooth1d_loess(norm_hp66_diat_c_a.ks_std_05,1:1:length(norm_hp66_diat_c_a.ks_c),6,1:tend);
% % % n_ts_a=norm_hp66_diat_c_a.ks_n(1:tend);
% % % 
% % % ts_c=smooth1d_loess(norm_hp66_diat_c_c.ks_c,1:length(norm_hp66_diat_c_c.ks_c),6,1:tend);
% % % std_ts_c=smooth1d_loess(norm_hp66_diat_c_c.ks_std_05,1:1:length(norm_hp66_diat_c_c.ks_c),6,1:tend);
% % % n_ts_c=norm_hp66_diat_c_c.ks_n(1:tend);
% % % 
% % % ci_a=abs(std_ts_a.*tinv((.05)/2,n_ts_a-1)./sqrt(n_ts_a-1));
% % % ci_c=abs(std_ts_c.*tinv((.05)/2,n_ts_c-1)./sqrt(n_ts_c-1));
% % % xts_a=[ts_a-ci_a ts_a(end)+ci_a(end) fliplr(ts_a+ci_a) ts_a(1)-ci_a(1)];
% % % xts_c=[ts_c-ci_c ts_c(end)+ci_c(end) fliplr(ts_c+ci_c) ts_c(1)-ci_c(1)];
% % % 
% % % figure(3)
% % % clf
% % % set(gcf,'PaperPosition',[1 1 10 5.5])
% % % patch(xp,xts_a,[.8 .8 .8])
% % % patch(xp,xts_c,[.8 .8 .8])
% % % hold on
% % % plot(dft,ts_a,'r','linewidth',4)
% % % hold on
% % % plot(dft,ts_c,'b','linewidth',4)
% % % axis tight
% % % 
% % % xlabel('eddy age (weeks)','fontsize',20,'fontweight','bold')
% % % ylabel(['mg m^{-3}'],'fontsize',20,'fontweight','bold')
% % % line([1 40],[0 0],'color','k','LineWidth',2)
% % % set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top')
% % % set(gca,'xtick',[0:2:20])
% % % box
% % % title(['Diat biomass anomaly',' GS rings'])
% % % print -dpng -r300 figs/norm_hp66_diat_c_ts
% % % 
% % % 
% % % 
% % % %%%%
% % % % CHL
% % % %%%%
% % % ts_a=smooth1d_loess(norm_hp66_chl_a.ks_c,1:length(norm_hp66_chl_a.ks_c),6,1:tend);
% % % std_ts_a=smooth1d_loess(norm_hp66_chl_a.ks_std_05,1:1:length(norm_hp66_chl_a.ks_c),6,1:tend);
% % % n_ts_a=norm_hp66_chl_a.ks_n(1:tend);
% % % 
% % % ts_c=smooth1d_loess(norm_hp66_chl_c.ks_c,1:length(norm_hp66_chl_c.ks_c),6,1:tend);
% % % std_ts_c=smooth1d_loess(norm_hp66_chl_c.ks_std_05,1:1:length(norm_hp66_chl_c.ks_c),6,1:tend);
% % % n_ts_c=norm_hp66_chl_c.ks_n(1:tend);
% % % 
% % % ci_a=abs(std_ts_a.*tinv((.05)/2,n_ts_a-1)./sqrt(n_ts_a-1));
% % % ci_c=abs(std_ts_c.*tinv((.05)/2,n_ts_c-1)./sqrt(n_ts_c-1));
% % % xts_a=[ts_a-ci_a ts_a(end)+ci_a(end) fliplr(ts_a+ci_a) ts_a(1)-ci_a(1)];
% % % xts_c=[ts_c-ci_c ts_c(end)+ci_c(end) fliplr(ts_c+ci_c) ts_c(1)-ci_c(1)];
% % % 
% % % figure(3)
% % % clf
% % % set(gcf,'PaperPosition',[1 1 10 5.5])
% % % patch(xp,xts_a,[.8 .8 .8])
% % % patch(xp,xts_c,[.8 .8 .8])
% % % hold on
% % % plot(dft,ts_a,'r','linewidth',4)
% % % hold on
% % % plot(dft,ts_c,'b','linewidth',4)
% % % axis tight
% % % 
% % % xlabel('eddy age (weeks)','fontsize',20,'fontweight','bold')
% % % ylabel(['CHL',char(39),char(39)],'fontsize',20,'fontweight','bold')
% % % line([1 40],[0 0],'color','k','LineWidth',2)
% % % set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top')
% % % set(gca,'xtick',[0:2:20])
% % % box
% % % title(['POP CHL',char(39),char(39),' GS rings'])
% % % print -dpng -r300 figs/norm_hp66_chl_ts
% % % 
% % % 
% % % %%%
% % % SSH
% % % %%%
% % % ts_a=smooth1d_loess(ssh_a.ks_c,1:length(ssh_a.ks_c),6,1:tend);
% % % std_ts_a=smooth1d_loess(ssh_a.ks_std_05,1:1:length(ssh_a.ks_c),6,1:tend);
% % % n_ts_a=ssh_a.ks_n(1:tend);
% % % 
% % % ts_c=smooth1d_loess(ssh_c.ks_c,1:length(ssh_c.ks_c),6,1:tend);
% % % std_ts_c=smooth1d_loess(ssh_c.ks_std_05,1:1:length(ssh_c.ks_c),6,1:tend);
% % % n_ts_c=ssh_c.ks_n(1:tend);
% % % 
% % % ci_a=abs(std_ts_a.*tinv((.05)/2,n_ts_a-1)./sqrt(n_ts_a-1));
% % % ci_c=abs(std_ts_c.*tinv((.05)/2,n_ts_c-1)./sqrt(n_ts_c-1));
% % % xts_a=[ts_a-ci_a ts_a(end)+ci_a(end) fliplr(ts_a+ci_a) ts_a(1)-ci_a(1)];
% % % xts_c=[ts_c-ci_c ts_c(end)+ci_c(end) fliplr(ts_c+ci_c) ts_c(1)-ci_c(1)];
% % % 
% % % figure(1)
% % % clf
% % % set(gcf,'PaperPosition',[1 1 10 5.5])
% % % patch(xp,xts_a,[.8 .8 .8])
% % % patch(xp,xts_c,[.8 .8 .8])
% % % hold on
% % % plot(dft,ts_a,'r','linewidth',4)
% % % hold on
% % % plot(dft,ts_c,'b','linewidth',4)
% % % axis tight
% % % 
% % % xlabel('eddy age (weeks)','fontsize',20,'fontweight','bold')
% % % ylabel(['SSH',char(39),char(39)],'fontsize',20,'fontweight','bold')
% % % line([1 40],[0 0],'color','k','LineWidth',2)
% % % set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top')
% % % set(gca,'xtick',[0:2:20])
% % % box
% % % title(['POP SSH',char(39),char(39),' GS rings'])
% % % print -dpng -r300 figs/ssh_ts
% % % 
% % % figure(2)
% % % clf
% % % set(gcf,'PaperPosition',[1 1 10 5.5])
% % % plot(dft,dfdx_abs(ts_a,1),'r','linewidth',4)
% % % hold on
% % % plot(dft,dfdx_abs(ts_c,1),'b','linewidth',4)
% % % axis tight
% % % 
% % % xlabel('eddy age (weeks)','fontsize',20,'fontweight','bold')
% % % ylabel(['dSSH/dt',char(39),char(39)],'fontsize',20,'fontweight','bold')
% % % line([1 40],[0 0],'color','k','LineWidth',2)
% % % set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top')
% % % set(gca,'xtick',[0:2:12])
% % % box
% % % title(['POP dSSHdt GS rings'])
% % % print -dpng -r300 figs/POP_dSSHdt_ts
% % 
% % 
% % 
% % %%now normalized biomass propoportions
% % tend=16
% % dft=1:tend;
% % 
% % a_small_na=smooth1d_loess(sp_c_a.ks_c,1:length(sp_c_a.ks_c),5,dft)./max(sp_c_a.ks_c);
% % a_diat_na=smooth1d_loess(diat_c_a.ks_c,1:length(diat_c_a.ks_c),5,dft)./max(diat_c_a.ks_c);
% % a_diaz_na=smooth1d_loess(diaz_c_a.ks_c,1:length(diaz_c_a.ks_c),5,dft)./max(diaz_c_a.ks_c);
% % 
% % a_sum_all=a_small_na+a_diat_na+a_diaz_na;
% % a_prop_small=a_small_na./a_sum_all;
% % a_prop_diat=a_diat_na./a_sum_all;
% % a_prop_diaz=a_diaz_na./a_sum_all;
% % 
% % c_small_na=smooth1d_loess(sp_c_c.ks_c,1:length(sp_c_c.ks_c),5,dft)./max(sp_c_c.ks_c);
% % c_diat_na=smooth1d_loess(diat_c_c.ks_c,1:length(diat_c_c.ks_c),5,dft)./max(diat_c_c.ks_c);
% % c_diaz_na=smooth1d_loess(diaz_c_c.ks_c,1:length(diaz_c_c.ks_c),5,dft)./max(diaz_c_c.ks_c);
% % 
% % c_sum_all=c_small_na+c_diat_na+c_diaz_na;
% % c_prop_small=c_small_na./c_sum_all;
% % c_prop_diat=c_diat_na./c_sum_all;
% % c_prop_diaz=c_diaz_na./c_sum_all;
% % 
% % 
% % 
% % 
% % figure(1)
% % clf
% % set(gcf,'PaperPosition',[1 1 8 8])
% % subplot(211)
% % hold on
% % plot(1:length(a_prop_diat),a_prop_diat,'k-*')
% % plot(1:length(a_prop_diat),a_prop_small,'k')
% % plot(1:length(a_prop_diat),a_prop_diaz,'k--')
% % legend('diat','small','diaz')
% % title('anticyclones')
% % set(gca,'ylim',[.2 .5],'xlim',[1 16],'fontsize',10,'fontweight','bold','LineWidth',.5,'TickLength',[.01 .05],'layer','top')
% % 
% % 
% % subplot(212)
% % hold on
% % plot(1:length(a_prop_diat),c_prop_diat,'k-*')
% % plot(1:length(a_prop_diat),c_prop_small,'k')
% % plot(1:length(a_prop_diat),c_prop_diaz,'k--')
% % legend('diat','small','diaz')
% % title('cyclones')
% % set(gca,'ylim',[.2 .5],'xlim',[1 16],'fontsize',10,'fontweight','bold','LineWidth',.5,'TickLength',[.01 .05],'layer','top')
% % xlabel('weeks')
% % print -dpng -r300 figs/rings_diveristy_ks_c_L

