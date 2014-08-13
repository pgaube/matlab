clear all
% 
% load ~/matlab/regions/tracks/tight/lw_tracks x y cyc id track_jday scale k
% [yeaa,mona,daya]=jd2jdate(track_jday);
% 
% ii=find(track_jday>=2451911 & track_jday<=2455137 & mona>4 & mona<11);
% x=x(ii);
% y=y(ii);
% cyc=cyc(ii);
% id=id(ii);
% track_jday=track_jday(ii);
% scale=scale(ii);
% k=k(ii);
% 
% [lw_chl_a,lw_chl_c]=comps(x,y,cyc,k,id,track_jday,scale,'sp66_chl','~/data/gsm/mat/GSM_9_21_','ddw');
% % [lw_wek_a,lw_wek_c]=comps(x,y,cyc,k,id,track_jday,scale,'w_ek','~/data/QuickScat/mat/QSCAT_30_25km_','w');
% 
% save EK_time_series lw_*_*
% return
% %%now plot

load EK_time_series

ci_a=abs(lw_chl_a.ks_std_05.*tinv((.05)/2,lw_chl_a.ks_n-1)./sqrt(lw_chl_a.ks_n-1))
ci_c=abs(lw_chl_c.ks_std_05.*tinv((.05)/2,lw_chl_c.ks_n-1)./sqrt(lw_chl_c.ks_n-1))


figure(1)
clf
set(gcf,'PaperPosition',[1 1 10 5.5])
errorbar(1:40,smooth1d_loess(lw_chl_a.ks_05,1:40,3,1:40),ci_a,'r','linewidth',4)
hold on
errorbar(1:40,smooth1d_loess(lw_chl_c.ks_05,1:40,3,1:40),ci_c,'b','linewidth',4)
axis tight
axis([1 40 -.2 .2])
xlabel('eddy age (weeks)','fontsize',20,'fontweight','bold')
% ylabel('unitless','fontsize',20,'fontweight','bold')
line([1 40],[0 0],'color','k','LineWidth',2)
set(gca,'fontsize',18,'fontweight','bold','LineWidth',2,'TickLength',[.01 .02],'layer','top')
set(gca,'xtick',[0:5:40])

print -dpng -r300 figs/ts_chl_winter