clear all

% xp=1:20;
% xx=linspace(0,3.5,length(xp));
% atten=linspace(1,1,length(xx));
% 
% ya=(8*(.25-(0.22 + ( 0.045 - 0.022).*exp(-7*xx))))-0.0560;
% yc=(8*(-.25+(0.22 + ( 0.045 - 0.022).*exp(-7*xx))))+0.0560;
% xp=interp(xp,5);
% ya=interp(ya,5);
% yc=interp(yc,5);
% % ya_p=nan*ya;ya_p(xp<=2)=ya(xp<=2);ya(xp<=2)=nan;
% % yc_p=nan*ya;yc_p(xp<=2)=yc(xp<=2);yc(xp<=2)=nan;
% figure(1)
% clf
% set(gcf,'PaperPosition',[1 1 5 2.5])
% hold on
% line([1 40],[0 0],'color','k','LineWidth',1)
% line([2 2],[-.3 .3],'color','k','LineWidth',1)
% plot(xp,ya,'r','linewidth',2)
% % plot(xp,ya_p,'r.','linewidth',2)
% hold on
% plot(xp,yc,'b','linewidth',2)
% % plot(xp,yc_p,'b.','linewidth',2)
% p=patch([1 2 2 1],[-.3 -.3 .3 .3],'k');
% set(p,'FaceAlpha',0.25);
% axis tight
% set(gca,'ytick',[-.3:.1:.3])
% axis([1 13 -.3 .3])
% % xlabel('eddy age (weeks)','fontsize',13)
% ylabel(['CHL',char(39),char(39)],'fontsize',13)
% set(gca,'fontsize',10,'LineWidth',1,'TickLength',[.01 .02],'layer','top')
% set(gca,'xtick',[1:20],'xticklabel','','yticklabel',[])
% box
% daspect([10 1 3])
% print -dpng -r300 figs/scam_ts_stir
% return
% 

xp=1:.3:20
ya=linspace(-.2,-.05,length(xp));
yc=linspace(.2,.05,length(xp));

atten=linspace(1,0,length(ya));
figure(1)
clf
set(gcf,'PaperPosition',[1 1 5 2.5])
hold on
line([1 40],[0 0],'color','k','LineWidth',1)
line([2 2],[-.3 .3],'color','k','LineWidth',1)
plot(xp,ya,'r','linewidth',2)
% plot(xp,ya_p,'r.','linewidth',2)
hold on
plot(xp,yc,'b','linewidth',2)
% plot(xp,yc_p,'b.','linewidth',2)
p=patch([1 2 2 1],[-.3 -.3 .3 .3],'k');
set(p,'FaceAlpha',0.25);
axis tight
set(gca,'ytick',[-.3:.1:.3])
axis([1 13 -.3 .3])
% xlabel('eddy age (weeks)','fontsize',13)
ylabel(['CHL',char(39),char(39)],'fontsize',13)
set(gca,'fontsize',10,'LineWidth',1,'TickLength',[.01 .02],'layer','top')
set(gca,'xtick',[1:20],'xticklabel','','yticklabel',[])
box
daspect([10 1 3])
print -dpng -r300 figs/scam_ts_trapp
return
% % 
% % 
% xp=1:20;
% ya=(.0004*(-4.^xp*exp(4)./factorial(round(xp))))+linspace(0.0874,-0.0875,length(xp));
% ya(10:end)=0;
% yc=(.0004*(4.^xp*exp(4)./factorial(round(xp))))-linspace(0.0874,-0.0874,length(xp));
% yc(10:end)=0;
% 
% xp=interp(xp,5);
% ya=interp(ya,5);
% yc=interp(yc,5);
% 
% % xp=linspace(1,40,100);
% figure(1)
% clf
% set(gcf,'PaperPosition',[1 1 5 2.5])
% hold on
% line([1 40],[0 0],'color','k','LineWidth',1)
% line([2 2],[-.3 .3],'color','k','LineWidth',1)
% plot(xp,ya,'r','linewidth',2)
% % plot(xp,ya_p,'r.','linewidth',2)
% hold on
% plot(xp,yc,'b','linewidth',2)
% % plot(xp,yc_p,'b.','linewidth',2)
% p=patch([1 2 2 1],[-.3 -.3 .3 .3],'k');
% set(p,'FaceAlpha',0.25);
% axis tight
% set(gca,'ytick',[-.3:.1:.3])
% axis([1 13 -.3 .3])
% % xlabel('eddy age (weeks)','fontsize',13)
% ylabel(['CHL',char(39),char(39)],'fontsize',13)
% set(gca,'fontsize',10,'LineWidth',1,'TickLength',[.01 .02],'layer','top')
% set(gca,'xtick',[1:20],'xticklabel','','yticklabel',[])
% box
% daspect([10 1 3])
% print -dpng -r300 figs/scam_ts_intens
% return


xp=1:20;
xx=linspace(0,3.5,length(xp));
atten=linspace(1,1.2,length(xx));
yc=atten.*(8*(.25-(0.22 + ( 0.045 - 0.022).*exp(-3*xx))))-0.0560;
ya=atten.*(8*(-.25+(0.22 + ( 0.045 - 0.022).*exp(-3*xx))))+0.0560;
xp=interp(xp,5);
ya=interp(ya,5);
yc=interp(yc,5);
% ya_p=nan*ya;ya_p(xp<=2)=ya(xp<=2);ya(xp<=2)=nan;
% yc_p=nan*ya;yc_p(xp<=2)=yc(xp<=2);yc(xp<=2)=nan;
figure(1)
clf
set(gcf,'PaperPosition',[1 1 5 2.5])
hold on
line([1 40],[0 0],'color','k','LineWidth',1)
line([2 2],[-.3 .3],'color','k','LineWidth',1)
plot(xp,ya,'r','linewidth',2)
% plot(xp,ya_p,'r.','linewidth',2)
hold on
plot(xp,yc,'b','linewidth',2)
% plot(xp,yc_p,'b.','linewidth',2)
p=patch([1 2 2 1],[-.3 -.3 .3 .3],'k');
set(p,'FaceAlpha',0.25);
axis tight
set(gca,'ytick',[-.3:.1:.3])
axis([1 13 -.3 .3])
% xlabel('eddy age (weeks)','fontsize',13)
ylabel(['CHL',char(39),char(39)],'fontsize',13)
set(gca,'fontsize',10,'LineWidth',1,'TickLength',[.01 .02],'layer','top')
set(gca,'xtick',[1:20],'xticklabel','','yticklabel',[])
box
daspect([10 1 3])
print -dpng -r300 figs/scam_ts_new_intens


xp=1:20;
xx=linspace(0,3.5,length(xp));
% atten=linspace(1,.7,length(xx));
atten=linspace(1,1.5,length(xx));
ya=atten.*(8*(.25-(0.22 + ( 0.045 - 0.022).*exp(-3*xx))))-0.0560;
yc=atten.*(8*(-.25+(0.22 + ( 0.045 - 0.022).*exp(-3*xx))))+0.0560;
xp=interp(xp,5);
ya=interp(ya,5);
yc=interp(yc,5);
% ya_p=nan*ya;ya_p(xp<=2)=ya(xp<=2);ya(xp<=2)=nan;
% yc_p=nan*ya;yc_p(xp<=2)=yc(xp<=2);yc(xp<=2)=nan;
figure(1)
clf
set(gcf,'PaperPosition',[1 1 5 2.5])
hold on
line([1 40],[0 0],'color','k','LineWidth',1)
line([2 2],[-.3 .3],'color','k','LineWidth',1)
plot(xp,ya,'r','linewidth',2)
% plot(xp,ya_p,'r.','linewidth',2)
hold on
plot(xp,yc,'b','linewidth',2)
% plot(xp,yc_p,'b.','linewidth',2)
p=patch([1 2 2 1],[-.3 -.3 .3 .3],'k');
set(p,'FaceAlpha',0.25);
axis tight
set(gca,'ytick',[-.3:.1:.3])
axis([1 13 -.3 .3])
% xlabel('eddy age (weeks)','fontsize',13)
ylabel(['CHL',char(39),char(39)],'fontsize',13)
set(gca,'fontsize',10,'LineWidth',1,'TickLength',[.01 .02],'layer','top')
set(gca,'xtick',[1:20],'xticklabel','','yticklabel',[])
box
daspect([10 1 3])
print -dpng -r300 figs/scam_ts_ekman