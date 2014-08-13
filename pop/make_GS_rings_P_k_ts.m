clear all
tend=12
dft=1:tend;
xp=[dft dft(end) fliplr(dft) dft(1)];

load old_pop_rings_jan_5

% 

%%now normalized biomass propoportions
tend=16
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


%biomass
ab=diat_c_a.ks_c+diaz_c_a.ks_c+sp_c_a.ks_c;
a_biomass=smooth1d_loess(ab,1:length(ab),5,dft);
ab=diat_c_c.ks_c+diaz_c_c.ks_c+sp_c_c.ks_c;
c_biomass=smooth1d_loess(ab,1:length(ab),10,dft);

figure(1)
clf
set(gcf,'PaperPosition',[1 1 8 8])
subplot(211)
hold on
XXX=[1:length(a_prop_diat);1:length(a_prop_diat);1:length(a_prop_diat)];
YYY=[a_prop_diat;a_prop_small;a_prop_diaz];
[ax,h1,h2]=plotyy(XXX',YYY',1:length(a_prop_diat),a_biomass);
set(h1(1),'color','g','linewidth',2)
set(h1(2),'color','b','linewidth',2)
set(h1(3),'color','r','linewidth',2)
% set(h1(4),'color','k','linewidth',3)
set(h2,'color',[.5 .5 .5],'linestyle','--','linewidth',2)
set(ax(2),'ycolor',[.5 .5 .5])

legend('diat','small','diaz','total biomass','location','northwest')
title('anticyclones')
set(ax(1),'ylim',[.2 .5],'ytick',[.2:.1:.5],'xlim',[1 14],'fontsize',10,'fontweight','bold','LineWidth',.5,'TickLength',[.01 .05],'layer','top')
set(ax(2),'ylim',[90 130],'xlim',[1 14],'fontsize',10,'fontweight','bold','LineWidth',.5,'TickLength',[.01 .05],'layer','top')



subplot(212)
hold on
hold on
XXX=[1:length(a_prop_diat);1:length(a_prop_diat);1:length(a_prop_diat)];
YYY=[c_prop_diat;c_prop_small;c_prop_diaz];
[ax2,h1,h2]=plotyy(XXX',YYY',1:length(a_prop_diat),c_biomass);
set(h1(1),'color','g','linewidth',2)
set(h1(2),'color','b','linewidth',2)
set(h1(3),'color','r','linewidth',2)
% set(h1(4),'color','k','linewidth',3)
set(h2,'color',[.5 .5 .5],'linestyle','--','linewidth',2)
set(ax2(2),'ycolor',[.5 .5 .5])

legend('diat','small','diaz','total biomass','location','northwest')
title('cyclones')
set(ax2(1),'ylim',[.2 .5],'ytick',[.2:.1:.5],'xlim',[1 14],'fontsize',10,'fontweight','bold','LineWidth',.5,'TickLength',[.01 .05],'layer','top')
set(ax2(2),'ylim',[140 180],'ytick',[140:10:180],'xlim',[1 14],'fontsize',10,'fontweight','bold','LineWidth',.5,'TickLength',[.01 .05],'layer','top')
xlabel('weeks')
print -dpng -r300 figs/rings_diveristy_ks_c_L_2

% figure(1)
% clf
% set(gcf,'PaperPosition',[1 1 8 8])
% subplot(211)
% hold on
% plot(1:length(a_prop_diat),a_prop_diat,'k-*')
% plot(1:length(a_prop_diat),a_prop_small,'k')
% plot(1:length(a_prop_diat),a_prop_diaz,'k--')
% legend('diat','small','diaz')
% title('anticyclones')
% set(gca,'ylim',[.2 .5],'xlim',[1 16],'fontsize',10,'fontweight','bold','LineWidth',.5,'TickLength',[.01 .05],'layer','top')
% 
% 
% subplot(212)
% hold on
% plot(1:length(a_prop_diat),c_prop_diat,'k-*')
% plot(1:length(a_prop_diat),c_prop_small,'k')
% plot(1:length(a_prop_diat),c_prop_diaz,'k--')
% legend('diat','small','diaz')
% title('cyclones')
% set(gca,'ylim',[.2 .5],'xlim',[1 16],'fontsize',10,'fontweight','bold','LineWidth',.5,'TickLength',[.01 .05],'layer','top')
% xlabel('weeks')
% print -dpng -r300 figs/rings_diveristy_ks_c_L
