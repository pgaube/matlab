function pcomps(imag,cont,cax,mincont,conti,maxcont,tit,pal_code,fsize)

load chelle.pal
load bwr.pal
if pal_code==1
    pal=chelle;
elseif pal_code==2
    pal=bwr;
end

xi=linspace(-2,2,length(imag(1,:)));
yi=xi';
imag=double(interp2(imag));
x=linspace(-2,2,length(imag(1,:)));
y=x';


  
figure(199)
clf
set(gcf,'PaperPosition',[1 1 8.5 8.5])
pcolor(x,y,imag);shading interp;colormap(chelle);
caxis(cax)
hold on
contour(xi,yi,cont,[conti:conti:maxcont],'k','linewidth',2)
contour(xi,yi,cont,[mincont:conti:-conti],'k--','linewidth',2)
dd=['-2';'  ';'-1';'  ';' 0';'  ';' 1';'  ';' 2'];
set(gca,'xtick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2],'ytick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2]','yticklabel',[],'xticklabel',[],'fontsize',20,'LineWidth',2,'TickLength',[.01 .01],'layer','top')
% set(gca,'xtick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2],'ytick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2]','yticklabel',dd,'xticklabel',dd,'fontsize',20,'LineWidth',2,'TickLength',[.01 .01],'layer','top')

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

text(-1.95,2.2,tit,'fontsize',fsize,'fontweight','bold')

% text(-.66,-2.26,'normalized distance','fontsize',20)
% h=text(-2.32,-.66,'normalized distance','fontsize',20);
% set(h,'Rotation',90)
box
box
colormap(pal)