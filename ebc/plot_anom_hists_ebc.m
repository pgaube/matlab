t_bins=[-1:.05:1];
nneg=71893;




load /Volumes/matlab/matlab/ebc/ebc_samps/ak_anom_samps


[bar_amp,num_amp]=phist(ak_anom_bar(ci),t_bins);
h = num_amp./sum(num_amp);
%pdf = h/.5;
cpdf = h*100;

[bar_amp,num_amp]=phist(ak_anom_bar(ai),t_bins);
h = num_amp./sum(num_amp);
%pdf = h/.5;
apdf = h*100;

figure(1)
clf
stairs(cpdf,'b','linewidth',2)

hold on
stairs(apdf,'r','linewidth',2)
set(gca,'xticklabel',{int2str(t_bins(1:4:41)'*10)})
set(gca,'xtick',1:4:41)
set(gca,'xlim',[7 33])
set(gca,'ylim',[0 30])


xlabel({'CHL Anomaly (mg m^{-3}) x 10'})
ylabel('Percent of Total')
title('Alaska Current')

eval(['print -dpng /Users/gaube/Documents/OSU/figures/ebc/hists/AK_anom.png']) 




load /Volumes/matlab/matlab/ebc/ebc_samps/ccns_anom_samps

ci=find(ccns_ids<nneg);
ai=find(ccns_ids>=nneg);

[bar_amp,num_amp]=phist(ccns_anom_bar(ci),t_bins);
h = num_amp./sum(num_amp);
%pdf = h/.5;
cpdf = h*100;

[bar_amp,num_amp]=phist(ccns_anom_bar(ai),t_bins);
h = num_amp./sum(num_amp);
%pdf = h/.5;
apdf = h*100;

figure(1)
clf
stairs(cpdf,'b','linewidth',2)

hold on
stairs(apdf,'r','linewidth',2)
set(gca,'xticklabel',{int2str(t_bins(1:4:41)'*10)})
set(gca,'xtick',1:4:41)
set(gca,'xlim',[7 33])
set(gca,'ylim',[0 30])


xlabel({'CHL Anomaly (mg m^{-3}) x 10'})
ylabel('Percent of Total')
title('California Current')

eval(['print -dpng /Users/gaube/Documents/OSU/figures/ebc/hists/ccns_anom.png']) 



load /Volumes/matlab/matlab/ebc/ebc_samps/pc_anom_samps

ci=find(pc_ids<nneg);
ai=find(pc_ids>=nneg);

[bar_amp,num_amp]=phist(pc_anom_bar(ci),t_bins);
h = num_amp./sum(num_amp);
%pdf = h/.5;
cpdf = h*100;

[bar_amp,num_amp]=phist(pc_anom_bar(ai),t_bins);
h = num_amp./sum(num_amp);
%pdf = h/.5;
apdf = h*100;

figure(1)
clf
stairs(cpdf,'b','linewidth',2)

hold on
stairs(apdf,'r','linewidth',2)
set(gca,'xticklabel',{int2str(t_bins(1:4:41)'*10)})
set(gca,'xtick',1:4:41)
set(gca,'xlim',[7 33])
set(gca,'ylim',[0 30])


xlabel({'CHL Anomaly (mg m^{-3}) x 10'})
ylabel('Percent of Total')
title('Peru-Chile Current')

eval(['print -dpng /Users/gaube/Documents/OSU/figures/ebc/hists/pc_anom.png']) 



load /Volumes/matlab/matlab/ebc/ebc_samps/cc_anom_samps

ci=find(cc_ids<nneg);
ai=find(cc_ids>=nneg);

[bar_amp,num_amp]=phist(cc_anom_bar(ci),t_bins);
h = num_amp./sum(num_amp);
%pdf = h/.5;
cpdf = h*100;

[bar_amp,num_amp]=phist(cc_anom_bar(ai),t_bins);
h = num_amp./sum(num_amp);
%pdf = h/.5;
apdf = h*100;

figure(1)
clf
stairs(cpdf,'b','linewidth',2)

hold on
stairs(apdf,'r','linewidth',2)
set(gca,'xticklabel',{int2str(t_bins(1:4:41)'*10)})
set(gca,'xtick',1:4:41)
set(gca,'xlim',[7 33])
set(gca,'ylim',[0 30])


xlabel({'CHL Anomaly (mg m^{-3}) x 10'})
ylabel('Percent of Total')
title('Canary Current')

eval(['print -dpng /Users/gaube/Documents/OSU/figures/ebc/hists/cc_anom.png']) 



load /Volumes/matlab/matlab/ebc/ebc_samps/bg_anom_samps

ci=find(bg_ids<nneg);
ai=find(bg_ids>=nneg);

[bar_amp,num_amp]=phist(bg_anom_bar(ci),t_bins);
h = num_amp./sum(num_amp);
%pdf = h/.5;
cpdf = h*100;

[bar_amp,num_amp]=phist(bg_anom_bar(ai),t_bins);
h = num_amp./sum(num_amp);
%pdf = h/.5;
apdf = h*100;

figure(1)
clf
stairs(cpdf,'b','linewidth',2)

hold on
stairs(apdf,'r','linewidth',2)
set(gca,'xticklabel',{int2str(t_bins(1:4:41)'*10)})
set(gca,'xtick',1:4:41)
set(gca,'xlim',[7 33])
set(gca,'ylim',[0 30])


xlabel({'CHL Anomaly (mg m^{-3}) x 10'})
ylabel('Percent of Total')
title('Benguela Current')

eval(['print -dpng /Users/gaube/Documents/OSU/figures/ebc/hists/bg_anom.png']) 



load /Volumes/matlab/matlab/ebc/ebc_samps/lw_anom_samps

ci=find(lw_ids<nneg);
ai=find(lw_ids>=nneg);

[bar_amp,num_amp]=phist(lw_anom_bar(ci),t_bins);
h = num_amp./sum(num_amp);
%pdf = h/.5;
cpdf = h*100;

[bar_amp,num_amp]=phist(lw_anom_bar(ai),t_bins);
h = num_amp./sum(num_amp);
%pdf = h/.5;
apdf = h*100;

figure(1)
clf
stairs(cpdf,'b','linewidth',2)

hold on
stairs(apdf,'r','linewidth',2)
set(gca,'xticklabel',{int2str(t_bins(1:4:41)'*10)})
set(gca,'xtick',1:4:41)
set(gca,'xlim',[7 33])
set(gca,'ylim',[0 30])


xlabel({'CHL Anomaly (mg m^{-3}) x 10'})
ylabel('Percent of Total')
title('Leeuwin Current')

eval(['print -dpng /Users/gaube/Documents/OSU/figures/ebc/hists/lw_anom.png']) 