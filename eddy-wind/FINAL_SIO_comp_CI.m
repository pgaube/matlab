clear all
load ~/matlab/eddy-wind/FINAL_ddw_comps lw_*_ddwchl_*
zgrid_grid
mon={'January';'February';'March';'April';'May';'June';'July';'August';'September';'October';'November';'December'};

for m=1:12
  eval(['mean_a=lw_',num2str(m),'_ddwchl_a.mean;'])
  eval(['std_a=smoothn(lw_',num2str(m),'_ddwchl_a.std,5);'])
  eval(['n_a=round(lw_',num2str(m),'_ddwchl_a.n_eddies);'])
  ci_a=abs(std_a.*tinv((.05)/2,n_a-1)./sqrt(n_a));

  eval(['mean_c=lw_',num2str(m),'_ddwchl_c.mean;'])
  eval(['std_c=smoothn(lw_',num2str(m),'_ddwchl_c.std,5);'])
  eval(['n_c=round(lw_',num2str(m),'_ddwchl_c.n_eddies);'])
  ci_c=abs(std_c.*tinv((.05)/2,n_c-1)./sqrt(n_c));

  figure(1)
  clf
set(gcf,'PaperPosition',[1 1 15 10])  
    line([-2 2],[0 0],'color','k','linewidth',2)
hold on
errorbar(diag(xi),diag(mean_a),diag(ci_a),'r','linewidth',3)
errorbar(diag(xi),diag(mean_c),diag(ci_c),'b','linewidth',3)
set(gca,'xtick',[-1.5:.5:1.5],'xlim',[-2 2],'ylim',[-.18 .18])
set(gca,'fontsize',35,'fontweight','bold','LineWidth',3,'TickLength',[.01 .01],'layer','top')
box
%grid 
title(mon{m},'fontsize',50)
      text(-1.5,.15,['N^*=',num2str(n_a)],'fontsize',32,'color','r')
    text(1,.15,['N^*=',num2str(n_c)],'fontsize',32,'color','b')
 eval(['print -depsc figs/comps_chl_CI_',num2str(m)])
 fixPSlinestyle(['figs/comps_chl_CI_',num2str(m),'.eps'],['figs/comps_chl_CI_',num2str(m),'.eps'])

%    eval(['!open figs/comps_chl_CI_',num2str(m),'.eps'])    
sig_a=mean_a;
sig_a(abs(mean_a)-ci_a<0)=nan;
sig_c=mean_c;
sig_c(abs(mean_c)-ci_c<0)=nan;
% 
% figure(2)
% clf
% subplot(121)
% pcolor(sig_a);shading flat;axis image;caxis([-.004 .004])
% subplot(122)
% pcolor(sig_c);shading flat;axis image;caxis([-.004 .004])
%  eval(['print -dpng -r300 figs/comps_chl_CI_masked_',num2str(m)])
end
