%histo of midlat scale
load tracks/midlat_tracks

%%%%%
%scale
%%%%%
[na,bins]=hist(scale,15);
figure(1)
clf
set(gcf,'PaperPosition',[1 1 15 10])
stairs(bins,100*(na./nansum(na)),'k','linewidth',5)
axis tight
axis([40 200 0 30])

set(gca,'xtick',[0:50:250])
set(gca,'fontsize',35,'TickLength',[.01 .01],'layer','top','linewidth',1)
xlabel('Observed speed-based eddy radius scale Ls (km)','fontsize',45)
ylabel('% of observations','fontsize',45)

print -dpng -r300 /Users/new_gaube/Documents/Publications/gaube_chelton_sst_wind_eddies/figs/scam/FINAL/scale_hist

%%%%%
%amp
%%%%%
[na,bins]=hist(amp,40);
figure(1)
clf
set(gcf,'PaperPosition',[1 1 15 10])
stairs(bins,100*(na./nansum(na)),'k','linewidth',5)
axis tight

axis([3 35 0 45])
set(gca,'xtick',[0:5:40])
set(gca,'fontsize',35,'TickLength',[.01 .01],'layer','top','linewidth',1)
xlabel('Observed eddy amplitude (cm)','fontsize',45)
ylabel('% of observations','fontsize',45)
print -dpng -r300 /Users/new_gaube/Documents/Publications/gaube_chelton_sst_wind_eddies/figs/scam/FINAL/amp_hist

%%%%%
%SST
%%%%%
% clear all
% load tracks/midlat_tracks.mat
% [sst_a,sst_c]=comps_output_full_comp(x,y,cyc,k,id,track_jday,scale,'bp26_sst','~/data/ReynoldsSST/mat/OI_25_30_','n');
% save midlat_sst_comps_all sst_a sst_c
% return
return
load midlat_sst_comps_all
zgrid_grid
dist=sqrt(xi.^2+yi.^2);
mask=nan*dist;
mask(dist<=1)=1;

for m=1:length(sst_a(1,1,:))
    sst_a(:,:,m)=sst_a(:,:,m).*mask;
end

for m=1:length(sst_c(1,1,:))
    sst_c(:,:,m)=sst_c(:,:,m).*mask;
end

% pmean(sst_a(17,17,:))
% pmean(sst_c(17,17,:))
% return

tbins=0:.07:1.7;
[b,na]=phist(sst_a(:),tbins);
[b,nc]=phist(sst_c(:),tbins);
n_sst=na+nc

figure(1)
clf
set(gcf,'PaperPosition',[1 1 15 10])
stairs(tbins(1:end-1),100*(n_sst./nansum(n_sst)),'k','linewidth',5)
axis tight
axis([0 1.5 0 25])
set(gca,'xtick',[0:.25:1.5])
set(gca,'fontsize',35,'TickLength',[.01 .01],'layer','top','linewidth',1)
xlabel('Observed eddy SST anomaly (^\circ C)','fontsize',45)
ylabel('% of observations','fontsize',45)
print -dpng -r300 /Users/new_gaube/Documents/Publications/gaube_chelton_sst_wind_eddies/figs/scam/FINAL/sst_hist

