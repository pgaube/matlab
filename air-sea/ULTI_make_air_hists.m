curs = {'CAR','EIO','HAW','new_SP','AGU','AGR','MID'};
colors=('mcrgbkk');







%%%%%
%amp
%%%%%
bins=5:1.5:40;
clear na nc
for m=1:length(curs)
    load(['~/data/eddy/V6/',curs{m},'_lat_lon_tracks_V6'])
    ii=find(track_jday>=2452466 & track_jday<=2455159 & age>=12);
    amp=amp(ii);
    cyc=cyc(ii);
    
    [dd,na(m,:)]=phist(amp(cyc==1),bins);
    [dd,nc(m,:)]=phist(amp(cyc==-1),bins);
end

figure(1)
clf
set(gcf,'PaperPosition',[1 1 10 10])
hold on
for m=1:6
    stairs(bins(1:end-1),100*(na(m,:)./nansum(na(m,:))),colors(m),'linewidth',2)
end
stairs(bins(1:end-1),100*(na(7,:)./nansum(na(7,:))),colors(7),'linewidth',8)
cc=legend('CAR','SIO','HAW','SPO','SEA','ARC','MID')
set(gca,'fontsize',25,'fontweight','bold','LineWidth',5,'TickLength',[.02 .02],'layer','top','xlim',[5 bins(end-1)],'ylim',[0 60])
xlabel('eddy amplitude (cm)','fontsize',25,'fontweight','bold')

set(cc,'box','off')
box
print -dpng -r300 figs/histo_amp_ac

figure(1)
clf
set(gcf,'PaperPosition',[1 1 10 10])
hold on
for m=1:6
    stairs(bins(1:end-1),100*(nc(m,:)./nansum(nc(m,:))),colors(m),'linewidth',2)
end
stairs(bins(1:end-1),100*(nc(7,:)./nansum(nc(7,:))),colors(7),'linewidth',8)
cc=legend('CAR','SIO','HAW','SPO','SEA','ARC','MID')
set(gca,'fontsize',25,'fontweight','bold','LineWidth',5,'TickLength',[.02 .02],'layer','top','xlim',[5 bins(end-1)],'ylim',[0 60])
xlabel('eddy amplitude (cm)','fontsize',25,'fontweight','bold')

set(cc,'box','off')
box
print -dpng -r300 figs/histo_amp_cc




%%%%
%scale
%%%%%
bins=40:10:250;
clear na nc
for m=1:length(curs)
    load(['~/data/eddy/V6/',curs{m},'_lat_lon_tracks_V6'])
    ii=find(track_jday>=2452466 & track_jday<=2455159 & age>=12);
    scale=scale(ii);
    cyc=cyc(ii);
    
    [dd,na(m,:)]=phist(scale(cyc==1),bins);
    [dd,nc(m,:)]=phist(scale(cyc==-1),bins);
end

figure(1)
clf
set(gcf,'PaperPosition',[1 1 10 10])
hold on
for m=1:6
    stairs(bins(1:end-1),100*(na(m,:)./nansum(na(m,:))),colors(m),'linewidth',2)
end
stairs(bins(1:end-1),100*(na(7,:)./nansum(na(7,:))),colors(7),'linewidth',8)
cc=legend('CAR','SIO','HAW','SPO','SEA','ARC','MID')
set(gca,'fontsize',25,'fontweight','bold','LineWidth',5,'TickLength',[.02 .02],'layer','top','xlim',[40 bins(end-1)],'ylim',[0 20])
xlabel('radius scale (km)','fontsize',25,'fontweight','bold')

set(cc,'box','off')
box
print -dpng -r300 figs/histo_scale_ac

figure(1)
clf
set(gcf,'PaperPosition',[1 1 10 10])
hold on
for m=1:6
    stairs(bins(1:end-1),100*(nc(m,:)./nansum(nc(m,:))),colors(m),'linewidth',2)
end
stairs(bins(1:end-1),100*(nc(7,:)./nansum(nc(7,:))),colors(7),'linewidth',8)
cc=legend('CAR','SIO','HAW','SPO','SEA','ARC','MID')
set(gca,'fontsize',25,'fontweight','bold','LineWidth',5,'TickLength',[.02 .02],'layer','top','xlim',[40 bins(end-1)],'ylim',[0 20])
xlabel('radius scale (km)','fontsize',25,'fontweight','bold')

set(cc,'box','off')
box

print -dpng -r300 figs/histo_scale_cc

%%%%%
%U
%%%%%
bins=5:2:70;
clear na nc
for m=1:length(curs)
    load(['~/data/eddy/V6/',curs{m},'_lat_lon_tracks_V6'])
    ii=find(track_jday>=2452466 & track_jday<=2455159 & age>=12);
    scale=axial_speed(ii);
    cyc=cyc(ii);
    
    [dd,na(m,:)]=phist(scale(cyc==1),bins);
    [dd,nc(m,:)]=phist(scale(cyc==-1),bins);
end

figure(1)
clf
set(gcf,'PaperPosition',[1 1 10 10])
hold on
for m=1:6
    stairs(bins(1:end-1),100*(na(m,:)./nansum(na(m,:))),colors(m),'linewidth',2)
end
stairs(bins(1:end-1),100*(na(7,:)./nansum(na(7,:))),colors(7),'linewidth',8)
cc=legend('CAR','SIO','HAW','SPO','SEA','ARC','MID')
set(gca,'fontsize',25,'fontweight','bold','LineWidth',5,'TickLength',[.02 .02],'layer','top','xlim',[bins(1) bins(end-1)])
xlabel('axial speed (cm s^{-1})','fontsize',25,'fontweight','bold')

set(cc,'box','off')
box
print -dpng -r300 figs/histo_u_ac

figure(1)
clf
set(gcf,'PaperPosition',[1 1 10 10])
hold on
for m=1:6
    stairs(bins(1:end-1),100*(nc(m,:)./nansum(nc(m,:))),colors(m),'linewidth',2)
end
stairs(bins(1:end-1),100*(nc(7,:)./nansum(nc(7,:))),colors(7),'linewidth',8)
cc=legend('CAR','SIO','HAW','SPO','SEA','ARC','MID')
set(gca,'fontsize',25,'fontweight','bold','LineWidth',5,'TickLength',[.02 .02],'layer','top','xlim',[bins(1) bins(end-1)])
xlabel('axial speed (cm s^{-1})','fontsize',25,'fontweight','bold')

set(cc,'box','off')
box
print -dpng -r300 figs/histo_u_cc



