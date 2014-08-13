function pcomps(dat,cont,cax,mincont,conti,maxcont,tit,pal_code,fsize)

load chelle.pal
load bwr.pal
load zissou

if pal_code==1
    pal=chelle;
elseif pal_code==2
    pal=bwr;
elseif pal_code==3
    pal=zissou;
end

imag_org=dat.mean;
imag=dat.mean;
xi=linspace(-2,2,length(imag(1,:)));
yi=xi';
imag=interp2(imag,2);
x=linspace(-2,2,length(imag(1,:)));
y=x';
std=dat.std;

n=round(dat.n_eddies);
ci=abs(std.*tinv((.05)/2,n-1)./sqrt(n));
ci=smoothn(ci,30);
mask=zeros(size(imag_org));

ii=find(abs((imag_org))>ci);
mask(ii)=1;
[r,c]=find(mask'==0);

  
       
figure(198)
clf
set(gcf,'PaperPosition',[1 1 4 4])
pcolor(x,y,imag);shading interp;axis equal

hold on
contour(xi,yi,cont,[conti:conti:maxcont],'k','linewidth',.5)
contour(xi,yi,cont,[mincont:conti:-conti],'k--','linewidth',.5)
dd=['-2';'  ';'-1';'  ';' 0';'  ';' 1';'  ';' 2'];
set(gca,'xtick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2],'ytick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2]','yticklabel',dd,'xticklabel',dd,'fontsize',10,'LineWidth',1,'TickLength',[.01 .01],'layer','top')
line([-2 2],[0 0],'color','k','LineWidth',.75)
line([0 0],[-2 2],'color','k','LineWidth',.75)

line([.5 .5],[-.05 .05],'color','k','LineWidth',.75)
line([1 1],[-.05 .05],'color','k','LineWidth',.75)
line([1.5 1.5],[-.05 .05],'color','k','LineWidth',.75)

line([-.5 -.5],[-.05 .05],'color','k','LineWidth',.75)
line([-1 -1],[-.05 .05],'color','k','LineWidth',.75)
line([-1.5 -1.5],[-.05 .05],'color','k','LineWidth',.75)

line([-.05 .05],[.5 .5],'color','k','LineWidth',.75)
line([-.05 .05],[1 1],'color','k','LineWidth',.75)
line([-.05 .05],[1.5 1.5],'color','k','LineWidth',.75)

line([-.05 .05],[-.5 -.5],'color','k','LineWidth',.75)
line([-.05 .05],[-1 -1],'color','k','LineWidth',.75)
line([-.05 .05],[-1.5 -1.5],'color','k','LineWidth',.75)


axis([-2 2 -2 2])

text(-1.95,2.18,tit,'fontsize',fsize,'fontweight','bold')
% text(-.66,-2.26,'','fontsize',20)
% h=text(-2.32,-.66,'','fontsize',20);
% set(h,'Rotation',90)
% text(-.66,-2.26,'normalized distance','fontsize',20)
% h=text(-2.32,-.66,'normalized distance','fontsize',20);
% set(h,'Rotation',90)
box
box
colormap(pal)
plot(xi(r),yi(c),'w.','markersize',8)
caxis(cax)
