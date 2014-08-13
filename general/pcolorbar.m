function pcolobar(minc,maxc,pal)

load chelle.pal
load bwr.pal


figure(198)
clf
set(gcf,'PaperPosition',[1 1 3 8.5])
caxis([minc maxc])
colorbar
text(-.66,-2.26,'normalized distance','fontsize',20)
h=text(-2.32,-.66,'normalized distance','fontsize',20);
set(h,'Rotation',90)
colormap(pal)