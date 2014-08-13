clear all
tend=12
sm_tspan=6
dft=1:tend+1;
xp=[dft dft(end) fliplr(dft) dft(1)];

load pop_stream_run33
vars={'ssh','norm_hp66_chl','hp66_chl','norm_hp66_c','w','tno3',...
    'diat_c','diaz_c','sp_c','vadv_no3'};

    figure(1)
    clf
    set(gcf,'PaperPosition',[1 1 10 5.5])
%     patch(xp,xts_a,[.8 .8 .8])
%     patch(xp,xts_c,[.8 .8 .8])
    hold on
    plot(dft,norm_hp66_chl_a.ks_n(1:tend+1),'r','linewidth',4)
    hold on
    plot(dft,norm_hp66_chl_c.ks_n(1:tend+1),'b','linewidth',4)
    
    xlabel('eddy age (weeks)','fontsize',20,'fontweight','bold')
    % ylabel(['mg m^{-3} per second?'],'fontsize',20,'fontweight','bold')
    line([1 tend+1],[0 0],'color','k','LineWidth',2)
    set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top')
    set(gca,'xtick',[0:2:20],'xlim',[1 tend+.5])
    box
    print -dpng -r300 figs/stream_ts_run33/n_ts
    
for m=2%length(vars)
    
    eval(['ts_a=',vars{m},'_a.ks_05(1:tend+1);'])
    eval(['std_ts_a=',vars{m},'_a.ks_std_05(1:tend+1);'])
    eval(['n_ts_a=',vars{m},'_a.ks_n(1:tend+1);'])
    
    eval(['ts_c=',vars{m},'_c.ks_05(1:tend+1);'])
    eval(['std_ts_c=',vars{m},'_c.ks_std_05(1:tend+1);'])
    eval(['n_ts_c=',vars{m},'_c.ks_n(1:tend+1);'])
    
      
    ci_a=abs(std_ts_a./sqrt(n_ts_a-1));
    ci_c=abs(std_ts_c./sqrt(n_ts_c-1));

    
    %%%smooth them a bit
    ts_a=smooth1d_loess(ts_a,1:tend+1,sm_tspan,1:tend+1);
    ts_c=smooth1d_loess(ts_c,1:tend+1,sm_tspan,1:tend+1);
    ci_a=smooth1d_loess(ci_a,1:tend+1,sm_tspan,1:tend+1);
    ci_c=smooth1d_loess(ci_c,1:tend+1,sm_tspan,1:tend+1);
%     
    
    xts_a=[ts_a-ci_a ts_a(end)+ci_a(end) fliplr(ts_a+ci_a) ts_a(1)-ci_a(1)];
    xts_c=[ts_c-ci_c ts_c(end)+ci_c(end) fliplr(ts_c+ci_c) ts_c(1)-ci_c(1)];
    
    
    figure(1)
    clf
    set(gcf,'PaperPosition',[1 1 10 5.5])
%         patch(xp,xts_a,[.8 .8 .8])
%         patch(xp,xts_c,[.8 .8 .8])
    hold on
    plot(dft,ts_a,'r','linewidth',5)
    for dd=1:tend
        plot([dft(dd)-.1 dft(dd)-.1],[ts_a(dd)-ci_a(dd) ts_a(dd)+ci_a(dd)],'r','linewidth',5)
    end
    plot(dft,ts_c,'b','linewidth',5)
        for dd=1:tend
        plot([dft(dd)+.1 dft(dd)+.1],[ts_c(dd)-ci_c(dd) ts_c(dd)+ci_c(dd)],'b','linewidth',5)
    end
    
    xlabel('eddy age (weeks)','fontsize',20,'fontweight','bold')
    % ylabel(['mg m^{-3} per second?'],'fontsize',20,'fontweight','bold')
    line([1 tend+1],[0 0],'color','k','LineWidth',2)
    set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top')
    set(gca,'xtick',[0:2:20],'xlim',[1 tend+.5])
    box
    title(vars{m})
    
    if m==2
        set(gca,'ylim',[-1 1],'ytick',[-1:.25:1])
    end
    
    eval(['print -dpng -r300 figs/stream_ts_run33/',vars{m},'_ts'])
end


for m=3%:length(orgin_vars)
    
    eval(['ts_a=',vars{m},'_a.ks_orgin_05(1:tend+1);'])
    eval(['std_ts_a=',vars{m},'_a.ks_orgin_std(1:tend+1);'])
    eval(['n_ts_a=',vars{m},'_a.ks_orgin_n(1:tend+1);'])
    
    eval(['ts_c=',vars{m},'_c.ks_orgin_05(1:tend+1);'])
    eval(['std_ts_c=',vars{m},'_c.ks_orgin_std(1:tend+1);'])
    eval(['n_ts_c=',vars{m},'_c.ks_orgin_n(1:tend+1);'])
    
    ci_a=abs(std_ts_a./sqrt(n_ts_a-1));
    ci_c=abs(std_ts_c./sqrt(n_ts_c-1));
 
       %%%smooth them a bit
    ts_a=smooth1d_loess(ts_a,1:tend+1,sm_tspan,1:tend+1);
    ts_c=smooth1d_loess(ts_c,1:tend+1,sm_tspan,1:tend+1);
    ci_a=smooth1d_loess(ci_a,1:tend+1,sm_tspan,1:tend+1);
    ci_c=smooth1d_loess(ci_c,1:tend+1,sm_tspan,1:tend+1);
    
    %%rest orgin to 0
    ts_a(1)=0;
    ts_c(1)=0;
    
    xts_a=[ts_a-ci_a ts_a(end)+ci_a(end) fliplr(ts_a+ci_a) ts_a(1)-ci_a(1)];
    xts_c=[ts_c-ci_c ts_c(end)+ci_c(end) fliplr(ts_c+ci_c) ts_c(1)-ci_c(1)];
    
    figure(1)
    clf
    set(gcf,'PaperPosition',[1 1 10 5.5])
%         patch(xp,xts_a,[.8 .8 .8])
%         patch(xp,xts_c,[.8 .8 .8])
    hold on
    plot(dft,ts_a,'r','linewidth',5)
    for dd=1:tend
        plot([dft(dd)-.1 dft(dd)-.1],[ts_a(dd)-ci_a(dd) ts_a(dd)+ci_a(dd)],'r','linewidth',5)
    end
    plot(dft,ts_c,'b','linewidth',5)
        for dd=1:tend
        plot([dft(dd)+.1 dft(dd)+.1],[ts_c(dd)-ci_c(dd) ts_c(dd)+ci_c(dd)],'b','linewidth',5)
    end
    
    xlabel('eddy age (weeks)','fontsize',20,'fontweight','bold')
    % ylabel(['mg m^{-3} per second?'],'fontsize',20,'fontweight','bold')
    line([1 tend+1],[0 0],'color','k','LineWidth',2)
    set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top')
    set(gca,'xtick',[0:2:20],'xlim',[1 tend+.5])
    box
    title(vars{m})
    
    if m==2
        set(gca,'ylim',[-.4 .4])
    end
    
    eval(['print -dpng -r300 figs/stream_ts_run33/orgin_',vars{m},'_ts'])
end
return
% 
% %%now normalized biomass propoportions
tend=16
dft=1:tend+1;

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
set(gca,'ylim',[.1 .5],'xlim',[1 tend+1],'fontsize',10,'fontweight','bold','LineWidth',.5,'TickLength',[.01 .05],'layer','top')


subplot(212)
hold on
plot(1:length(a_prop_diat),c_prop_diat,'k-*')
plot(1:length(a_prop_diat),c_prop_small,'k')
plot(1:length(a_prop_diat),c_prop_diaz,'k--')
legend('diat','small','diaz')
title('cyclones')
set(gca,'ylim',[.1 .5],'xlim',[1 tend+1],'fontsize',10,'fontweight','bold','LineWidth',.5,'TickLength',[.01 .05],'layer','top')
xlabel('weeks')
print -dpng -r300 figs/stream_ts/rings_diveristy_ks_05_L_run33
return

