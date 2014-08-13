function pcomps_scatter(x,y,z,cax,tit)

load chelle.pal



figure(199)
clf
set(gcf,'PaperPosition',[1 1 8.5 8.5])
hold on
scatter(x,y,3,z,'filled')
colormap(chelle);
caxis(cax)
hold on
dd=['-2';'  ';'-1';'  ';' 0';'  ';' 1';'  ';' 2'];
set(gca,'xtick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2],'ytick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2]','yticklabel',dd,'xticklabel',dd,'fontsize',20,'LineWidth',2,'TickLength',[.01 .01],'layer','top')
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

text(-1.95,2.12,tit,'fontsize',20,'fontweight','bold')
text(-.66,-2.26,'normalized distance','fontsize',20)
h=text(-2.32,-.66,'normalized distance','fontsize',20);
set(h,'Rotation',90)
box
box