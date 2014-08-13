load LW_offshore_obs_comps.mat
ochl_a=winter_chl_a;
ochl_c=winter_chl_c;
ossh_a=winter_ssh_a;
ossh_c=winter_ssh_c;

load LW_offshore_comps.mat
pchl_a=winter_chl_a;
pchl_c=winter_chl_c;
pssh_a=winter_ssh_a;
pssh_c=winter_ssh_c;

load chelle.pal
figure(1)
clf
set(gcf,'PaperPosition',[1 1 13 13])
xi=-2:.125:2;
[x,y]=meshgrid(xi,xi);


pcax=[-.015 .015];
ocax=[-.005 .005];

[rr,ff,gg]=deal(1);


subplot1(2,2,'Gap',[.03 .03])
subplot1(1)
pcolor(x,y,ochl_a.mean);shading interp;colormap(chelle);
caxis(ocax)
hold on
contour(x,y,ossh_a.mean,[1.5:1.5:100],'k','linewidth',2)
contour(x,y,ossh_a.mean,[-100:1.5:-1.5],'k--','linewidth',2)
dd=['-2';'  ';'-1';'  ';' 0';'  ';' 1';'  ';' 2'];
set(gca,'xtick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2],'ytick',...
    [-2 -1.5 -1 -.5 0 .5 1 1.5 2]','yticklabel',dd,'xticklabel',[],...
    'fontsize',18,'LineWidth',2,'TickLength',[.01 .01],'layer','top')

line([-2 2],[0 0],'color','k','LineWidth',1.5)
line([0 0],[-2 2],'color','k','LineWidth',1.5)

line([.5 .5],[-.05 .05],'color','k','LineWidth',1.5)
line([1 1],[-.05 .05],'color','k','LineWidth',1.5)
line([1.5 1.5],[-.05 .05],'color','k','LineWidth',1.5)

line([-.5 -.5],[-.05 .05],'color','k','LineWidth',1.5)
line([-1 -1],[-.05 .05],'color','k','LineWidth',1.5)
line([-1.5 -1.5],[-.05 .05],'color','k','LineWidth',1.5)

line([-.05 .05],[.5 .5],'color','k','LineWidth',1.5)
line([-.05 .05],[1 1],'color','k','LineWidth',1.5)
line([-.05 .05],[1.5 1.5],'color','k','LineWidth',1.5)

line([-.05 .05],[-.5 -.5],'color','k','LineWidth',1.5)
line([-.05 .05],[-1 -1],'color','k','LineWidth',1.5)
line([-.05 .05],[-1.5 -1.5],'color','k','LineWidth',1.5)


axis([-2 2 -2 2])
text(1.25,2.15,['N=',num2str(ochl_a.n_max_sample)],'fontweight','bold','fontsize',18)

text(-1.35,2.5,'AVISO-SeaWiFS','color','k','fontsize',40)
ylabel('Anticyclones','color','r','fontsize',35)


subplot1(2)
pcolor(x,y,pchl_a.mean);shading interp;colormap(chelle);
caxis(pcax)
hold on
contour(x,y,pssh_a.mean,[1.5:1.5:100],'k','linewidth',2)
contour(x,y,pssh_a.mean,[-100:1.5:-1.5],'k--','linewidth',2)
dd=['-2';'  ';'-1';'  ';' 0';'  ';' 1';'  ';' 2'];
set(gca,'xtick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2],'ytick',...
    [-2 -1.5 -1 -.5 0 .5 1 1.5 2]','yticklabel',[],'xticklabel',[],...
    'fontsize',18,'LineWidth',2,'TickLength',[.01 .01],'layer','top')

line([-2 2],[0 0],'color','k','LineWidth',1.5)
line([0 0],[-2 2],'color','k','LineWidth',1.5)

line([.5 .5],[-.05 .05],'color','k','LineWidth',1.5)
line([1 1],[-.05 .05],'color','k','LineWidth',1.5)
line([1.5 1.5],[-.05 .05],'color','k','LineWidth',1.5)

line([-.5 -.5],[-.05 .05],'color','k','LineWidth',1.5)
line([-1 -1],[-.05 .05],'color','k','LineWidth',1.5)
line([-1.5 -1.5],[-.05 .05],'color','k','LineWidth',1.5)

line([-.05 .05],[.5 .5],'color','k','LineWidth',1.5)
line([-.05 .05],[1 1],'color','k','LineWidth',1.5)
line([-.05 .05],[1.5 1.5],'color','k','LineWidth',1.5)

line([-.05 .05],[-.5 -.5],'color','k','LineWidth',1.5)
line([-.05 .05],[-1 -1],'color','k','LineWidth',1.5)
line([-.05 .05],[-1.5 -1.5],'color','k','LineWidth',1.5)


axis([-2 2 -2 2])
text(1.25,2.15,['N=',num2str(pchl_a.n_max_sample)],'fontweight','bold','fontsize',18)

text(-.92,2.5,'POP-BEC','color','k','fontsize',40)


subplot1(3)
pcolor(x,y,ochl_c.mean);shading interp;colormap(chelle);
caxis(ocax)
hold on
contour(x,y,ossh_c.mean,[1.5:1.5:100],'k','linewidth',2)
contour(x,y,ossh_c.mean,[-100:1.5:-1.5],'k--','linewidth',2)
dd=['-2';'  ';'-1';'  ';' 0';'  ';' 1';'  ';' 2'];
set(gca,'xtick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2],'ytick',...
    [-2 -1.5 -1 -.5 0 .5 1 1.5 2]','yticklabel',dd,'xticklabel',dd,...
    'fontsize',18,'LineWidth',2,'TickLength',[.01 .01],'layer','top')

line([-2 2],[0 0],'color','k','LineWidth',1.5)
line([0 0],[-2 2],'color','k','LineWidth',1.5)

line([.5 .5],[-.05 .05],'color','k','LineWidth',1.5)
line([1 1],[-.05 .05],'color','k','LineWidth',1.5)
line([1.5 1.5],[-.05 .05],'color','k','LineWidth',1.5)

line([-.5 -.5],[-.05 .05],'color','k','LineWidth',1.5)
line([-1 -1],[-.05 .05],'color','k','LineWidth',1.5)
line([-1.5 -1.5],[-.05 .05],'color','k','LineWidth',1.5)

line([-.05 .05],[.5 .5],'color','k','LineWidth',1.5)
line([-.05 .05],[1 1],'color','k','LineWidth',1.5)
line([-.05 .05],[1.5 1.5],'color','k','LineWidth',1.5)

line([-.05 .05],[-.5 -.5],'color','k','LineWidth',1.5)
line([-.05 .05],[-1 -1],'color','k','LineWidth',1.5)
line([-.05 .05],[-1.5 -1.5],'color','k','LineWidth',1.5)


axis([-2 2 -2 2])
text(1.25,2.15,['N=',num2str(ochl_c.n_max_sample)],'fontweight','bold','fontsize',18)

ylabel('Cyclones','color','b','fontsize',35)
cc1=colorbar('horiz');
set(cc1,'Position',[0.15 0.049 0.3 0.015],'xtick',[-5e-3 -2.5e-3 0 2.5e-3 5e-3])
axes(cc1)
xlabel('mg m^{-3}')

subplot1(4)
pcolor(x,y,pchl_c.mean);shading interp;colormap(chelle);
caxis(pcax)
hold on
contour(x,y,pssh_c.mean,[1.5:1.5:100],'k','linewidth',2)
contour(x,y,pssh_c.mean,[-100:1.5:-1.5],'k--','linewidth',2)
dd=['-2';'  ';'-1';'  ';' 0';'  ';' 1';'  ';' 2'];
set(gca,'xtick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2],'ytick',...
    [-2 -1.5 -1 -.5 0 .5 1 1.5 2]','yticklabel',[],'xticklabel',dd,...
    'fontsize',18,'LineWidth',2,'TickLength',[.01 .01],'layer','top')

line([-2 2],[0 0],'color','k','LineWidth',1.5)
line([0 0],[-2 2],'color','k','LineWidth',1.5)

line([.5 .5],[-.05 .05],'color','k','LineWidth',1.5)
line([1 1],[-.05 .05],'color','k','LineWidth',1.5)
line([1.5 1.5],[-.05 .05],'color','k','LineWidth',1.5)

line([-.5 -.5],[-.05 .05],'color','k','LineWidth',1.5)
line([-1 -1],[-.05 .05],'color','k','LineWidth',1.5)
line([-1.5 -1.5],[-.05 .05],'color','k','LineWidth',1.5)

line([-.05 .05],[.5 .5],'color','k','LineWidth',1.5)
line([-.05 .05],[1 1],'color','k','LineWidth',1.5)
line([-.05 .05],[1.5 1.5],'color','k','LineWidth',1.5)

line([-.05 .05],[-.5 -.5],'color','k','LineWidth',1.5)
line([-.05 .05],[-1 -1],'color','k','LineWidth',1.5)
line([-.05 .05],[-1.5 -1.5],'color','k','LineWidth',1.5)


axis([-2 2 -2 2])
text(1.25,2.15,['N=',num2str(pchl_c.n_max_sample)],'fontweight','bold','fontsize',18)


% 
% 
text(-2.66,-2.33,'C.I. 1.5 cm','fontweight','bold','fontsize',17)
cc=colorbar('horiz');
set(cc,'Position',[0.57 0.049 0.3 0.015],'xtick',[-.015 -.007 0 .007 .015])
axes(cc)
xlabel('mg m^{-3}')

print -dpng -r300 LW_winter_comps
!open LW_winter_comps.png
%
