% %histo of midlat scale
% load tracks/midlat_tracks
% 
% %%%%%
% %scale
% %%%%%
% [na,bins]=hist(scale,15);
% figure(1)
% clf
% set(gcf,'PaperPosition',[1 1 15 10])
% stairs(bins,100*(na./nansum(na)),'k','linewidth',2)
% axis tight
% axis([40 200 0 30])
% 
% set(gca,'xtick',[0:50:250])
% set(gca,'fontsize',25,'TickLength',[.01 .01],'layer','top')
% xlabel('Observed speed-based eddy radial scale Ls (km)','fontsize',35)
% ylabel('% of observations','fontsize',35)
% 
% print -dpng -r300 /Users/new_gaube/Documents/Publications/gaube_chelton_sst_wind_eddies/figs/scam/FINAL/scale_hist
% 
% %%%%%
% %amp
% %%%%%
% [na,bins]=hist(amp,40);
% figure(1)
% clf
% set(gcf,'PaperPosition',[1 1 15 10])
% stairs(bins,100*(na./nansum(na)),'k','linewidth',2)
% axis tight
% 
% axis([3 35 0 40])
% set(gca,'xtick',[0:5:40])
% set(gca,'fontsize',25,'TickLength',[.01 .01],'layer','top')
% xlabel('Observed eddy amplitude (cm)','fontsize',35)
% ylabel('% of observations','fontsize',35)
% print -dpng -r300 /Users/new_gaube/Documents/Publications/gaube_chelton_sst_wind_eddies/figs/scam/FINAL/amp_hist

%%%%%
%SST
%%%%%
load sst_ssh_joint_comps



na=[big_sst_a.na_05 big_sst_c.nc_1 med_sst_a.na_05 med_sst_c.nc_1 small_sst_a.na_05 small_sst_c.nc_1]
bins=[big_sst_a.bins big_sst_a.bins med_sst_a.bins med_sst_a.bins small_sst_a.bins small_sst_a.bins]

tbins=0:.07:1.5
for m=1:length(tbins)-1
    ii=find(abs(bins)>=tbins(m) & abs(bins)<tbins(m+1))
    n_sst(m)=sum(na(ii));
end

figure(1)
clf
set(gcf,'PaperPosition',[1 1 15 10])
stairs(tbins(1:end-1),100*(n_sst./nansum(n_sst)),'k','linewidth',2)
axis tight
axis([0 1.5 0 40])
return
set(gca,'xtick',[0:5:40])
set(gca,'fontsize',25,'TickLength',[.01 .01],'layer','top')
xlabel('Observed eddy SST anomaly (^\circ C)','fontsize',35)
ylabel('% of observations','fontsize',35)
print -dpng -r300 /Users/new_gaube/Documents/Publications/gaube_chelton_sst_wind_eddies/figs/scam/FINAL/sst_hist

