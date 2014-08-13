clear all
fnames={'obs_stream_sla2','pop_stream_sla2','pop_stream_run33_sla2','obs_meanders_sla2','pop_meanders_sla2','pop_meanders_run33_sla2'};
vars={'norm_hp66_chl','hp66_chl'};
tend=12
sm_tspan=6
dft=1:tend+1;

for drap=1:length(fnames)
    clearallbut fnames drap vars tend sm_tspan dft
    load(fnames{drap})
    
    for m=1:length(vars)
        
        %%first ks
        %assign data to variables
        eval(['ts_a=',vars{m},'_a.ks_05_median(1:tend+1);'])
        if drap==1
            eval(['std_ts_a=',vars{m},'_a.ks_std2_05(1:tend+1);'])
        else
            eval(['std_ts_a=',vars{m},'_a.ks_std_05(1:tend+1);'])
        end
        eval(['n_ts_a=',vars{m},'_a.ks_n(1:tend+1);'])
        
        eval(['ts_c=',vars{m},'_c.ks_05_median(1:tend+1);'])
        if drap==1
            eval(['std_ts_c=',vars{m},'_c.ks_std2_05(1:tend+1);'])
        else
            eval(['std_ts_c=',vars{m},'_c.ks_std_05(1:tend+1);'])
        end
        eval(['n_ts_c=',vars{m},'_c.ks_n(1:tend+1);'])
        
        ci_a=abs(std_ts_a./sqrt(n_ts_a-1));
        ci_c=abs(std_ts_c./sqrt(n_ts_c-1));
        
        %%%%smooth them a bit
        ts_a=smooth1d_loess(ts_a,1:tend+1,sm_tspan,1:tend+1);
        ts_c=smooth1d_loess(ts_c,1:tend+1,sm_tspan,1:tend+1);
        ci_a=smooth1d_loess(ci_a,1:tend+1,sm_tspan,1:tend+1);
        ci_c=smooth1d_loess(ci_c,1:tend+1,sm_tspan,1:tend+1);
        
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
        
        axis tight
        
        xlabel('eddy age (weeks)','fontsize',20,'fontweight','bold')
        line([1 tend+1],[0 0],'color','k','LineWidth',2)
        set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top')
        set(gca,'xtick',[0:2:20],'xlim',[1 tend+.5],'ytick',[-2:.2:2])
        D=axis;
        md=max(abs(D(3:4)));
        set(gca,'ylim',[-md md])
        box
        title(vars{m})
        
        eval(['print -dpng -r300 figs/',fnames{drap},'/',vars{m},'_ks'])
        
        %%now org ks
        %assign data to variables
        eval(['ts_a=',vars{m},'_a.ks_orgin_05_median(1:tend+1);'])
        eval(['std_ts_a=',vars{m},'_a.ks_orgin_std(1:tend+1);'])
        eval(['n_ts_a=',vars{m},'_a.ks_orgin_n(1:tend+1)+40;'])
        
        eval(['ts_c=',vars{m},'_c.ks_orgin_05_median(1:tend+1);'])
        eval(['std_ts_c=',vars{m},'_c.ks_orgin_std(1:tend+1);'])
        eval(['n_ts_c=',vars{m},'_c.ks_orgin_n(1:tend+1)+20;'])
        
        ci_a=abs(std_ts_a./sqrt(n_ts_a-1));
        ci_c=abs(std_ts_c./sqrt(n_ts_c-1));
        
        %%%%smooth them a bit
        ts_a=smooth1d_loess(ts_a,1:tend+1,sm_tspan,1:tend+1);
        ts_c=smooth1d_loess(ts_c,1:tend+1,sm_tspan,1:tend+1);
        ci_a=smooth1d_loess(ci_a,1:tend+1,sm_tspan,1:tend+1);
        ci_c=smooth1d_loess(ci_c,1:tend+1,sm_tspan,1:tend+1);
        
        figure(2)
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
        
        axis tight
        
        xlabel('eddy age (weeks)','fontsize',20,'fontweight','bold')
        line([1 tend+1],[0 0],'color','k','LineWidth',2)
        set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top')
        set(gca,'xtick',[0:2:20],'xlim',[1 tend+.5],'ytick',[-1:.02:1])
        D=axis;
        md=max(abs(D(3:4)));
        set(gca,'ylim',[-md md])
        box
        title(vars{m})
        
        eval(['print -dpng -r300 figs/',fnames{drap},'/',vars{m},'_oks'])
        
    end
    
    
end