load SCHLAX_wind_NH_comps
load bewr.pal

xsz=11;
ysz=8.5
xspan=2.5;
dx=0.5; 
ofst=1.25;
ofst2=4.5;
%the bottom left corner of the
%upper left panel is at 1.25 and 4.5 inches 
%from the lower left corner of an assumed 8.5 x 11 inch page.

imag=double(interp2(w_ek_total_a));
x=linspace(-2,2,length(imag(1,:)));
y=x';

figure(1)
set(gcf,'PaperPosition',[1 1 xsz ysz])

imag=double(interp2(w_ek_total_a));
tit=['W_tot AC N=',num2str(w_ek_total_a.n_max_sample)];
ax=subplot(231)
set(ax,'position','units','inches',[ofst ofst2 dx dx])
pcolor(x,y,imag);shading interp;colormap(bwr);
caxis([-10 10)
hold on
[cs,h]=contour(x,y,cont,[1:1:100],'k','linewidth',2);
if any(cs)
    clabel(cs,h,'LabelSpacing',1000)
end
clear cs h
[cs,h]=contour(x,y,cont,[-100:1:-1],'k--','linewidth',2);
if any(cs)
    clabel(cs,h,'LabelSpacing',1000)
end

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

text(-1.95,2.18,tit,'fontsize',fsize,'fontweight','bold')

% text(-.66,-2.26,'normalized distance','fontsize',20)
% h=text(-2.32,-.66,'normalized distance','fontsize',20);
% set(h,'Rotation',90)
box
box
colormap(pal)
