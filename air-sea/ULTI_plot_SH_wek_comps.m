clear all
load bwr.pal

load ULTI_wind_SH_comps

ysz=14.3;
xsz=14;
xspan=2.5;
dx=0.3;
dy=0.3;
xofst=.7;
yofst=10;


figure(1)
clf
set(gcf,'PaperPosition',[1 1 xsz ysz])
hold on


%%WSST rot
ax=subplot(641);
tmp=interp2((0.013/0.01)*w_ek_sst_fixed_a.mean);
x=linspace(-2,2,length(tmp(1,:)));
y=x';

loc_x=xofst;
set(ax,'units','inches','position',[loc_x yofst xspan xspan],'linewidth',1.5)
pcolor(x,y,tmp);shading interp;colormap(bwr);
caxis([-10 10]);
hold on

[cs,h]=contour(x,y,tmp,[-100:1:-1],'k--','linewidth',1);
if any(cs)
    clabel(cs,h,'LabelSpacing',1000,'fontsize',9)
end
clear cs h
[cs,h]=contour(x,y,tmp,[1:1:100],'k','linewidth',1);
if any(cs)
    clabel(cs,h,'LabelSpacing',1000,'fontsize',9)
end

dd=['-2';'  ';'-1';'  ';' 0';'  ';' 1';'  ';' 2'];
set(gca,'xtick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2],'ytick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2]','yticklabel',dd,'xticklabel',[],'fontsize',12,'LineWidth',1.5,'TickLength',[.01 .01],'layer','top')
line([-2 2],[0 0],'color','k','LineWidth',1)
line([0 0],[-2 2],'color','k','LineWidth',1)
line([.5 .5],[-.05 .05],'color','k','LineWidth',1)
line([1 1],[-.05 .05],'color','k','LineWidth',1)
line([1.5 1.5],[-.05 .05],'color','k','LineWidth',1)
line([-.5 -.5],[-.05 .05],'color','k','LineWidth',1)
line([-1 -1],[-.05 .05],'color','k','LineWidth',1)
line([-1.5 -1.5],[-.05 .05],'color','k','LineWidth',1)
line([-.05 .05],[.5 .5],'color','k','LineWidth',1)
line([-.05 .05],[1 1],'color','k','LineWidth',1)
line([-.05 .05],[1.5 1.5],'color','k','LineWidth',1)
line([-.05 .05],[-.5 -.5],'color','k','LineWidth',1)
line([-.05 .05],[-1 -1],'color','k','LineWidth',1)
line([-.05 .05],[-1.5 -1.5],'color','k','LineWidth',1)
axis([-2 2 -2 2])
box('on')
text(.1,2.4,'Anticyclones N=74,354','HorizontalAlignment','center','fontsize',15,'color','red')
ylabel('$W_{SST}$','HorizontalAlignment','center','fontsize',20,'interpreter','latex')
text(-1.85,2.3,'a)','HorizontalAlignment','center','fontsize',16,'fontweight','bold')
text(2.25,3.15,'Rotated','HorizontalAlignment','center','fontsize',24)

loc_x=loc_x+xspan+dx;

ax=subplot(642);
tmp=interp2((0.013/0.01)*w_ek_sst_fixed_c.mean);
set(ax,'units','inches','position',[loc_x yofst xspan xspan],'linewidth',1.5)
pcolor(x,y,tmp);shading interp;colormap(bwr);
caxis([-10 10]);
hold on

[cs,h]=contour(x,y,tmp,[-100:1:-1],'k--','linewidth',1);
if any(cs)
    clabel(cs,h,'LabelSpacing',1000,'fontsize',9)
end
clear cs h
[cs,h]=contour(x,y,tmp,[1:1:100],'k','linewidth',1);
if any(cs)
    clabel(cs,h,'LabelSpacing',1000,'fontsize',9)
end

dd=['-2';'  ';'-1';'  ';' 0';'  ';' 1';'  ';' 2'];
set(gca,'xtick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2],'ytick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2]','yticklabel',[],'xticklabel',[],'fontsize',12,'LineWidth',1.5,'TickLength',[.01 .01],'layer','top')
line([-2 2],[0 0],'color','k','LineWidth',1)
line([0 0],[-2 2],'color','k','LineWidth',1)
line([.5 .5],[-.05 .05],'color','k','LineWidth',1)
line([1 1],[-.05 .05],'color','k','LineWidth',1)
line([1.5 1.5],[-.05 .05],'color','k','LineWidth',1)
line([-.5 -.5],[-.05 .05],'color','k','LineWidth',1)
line([-1 -1],[-.05 .05],'color','k','LineWidth',1)
line([-1.5 -1.5],[-.05 .05],'color','k','LineWidth',1)
line([-.05 .05],[.5 .5],'color','k','LineWidth',1)
line([-.05 .05],[1 1],'color','k','LineWidth',1)
line([-.05 .05],[1.5 1.5],'color','k','LineWidth',1)
line([-.05 .05],[-.5 -.5],'color','k','LineWidth',1)
line([-.05 .05],[-1 -1],'color','k','LineWidth',1)
line([-.05 .05],[-1.5 -1.5],'color','k','LineWidth',1)
axis([-2 2 -2 2])
box('on')
text(.05,2.4,'Cyclones N=75,905','HorizontalAlignment','center','fontsize',15,'color','blue')
text(2.9,4,'Southern Hemisphere Composite Averages','HorizontalAlignment','center','fontsize',38)


%%W_sst noro
loc_x=loc_x+xspan+dx+dx;

ax=subplot(643);
tmp=interp2((0.013/0.01)*noro_w_ek_sst_fixed_a.mean);
set(ax,'units','inches','position',[loc_x yofst xspan xspan],'linewidth',1.5)
pcolor(x,y,tmp);shading interp;colormap(bwr);
caxis([-10 10]);
hold on

[cs,h]=contour(x,y,tmp,[-100:1:-1],'k--','linewidth',1);
if any(cs)
    clabel(cs,h,'LabelSpacing',1000,'fontsize',9)
end
clear cs h
[cs,h]=contour(x,y,tmp,[1:1:100],'k','linewidth',1);
if any(cs)
    clabel(cs,h,'LabelSpacing',1000,'fontsize',9)
end

dd=['-2';'  ';'-1';'  ';' 0';'  ';' 1';'  ';' 2'];
set(gca,'xtick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2],'ytick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2]','yticklabel',[],'xticklabel',[],'fontsize',12,'LineWidth',1.5,'TickLength',[.01 .01],'layer','top')
line([-2 2],[0 0],'color','k','LineWidth',1)
line([0 0],[-2 2],'color','k','LineWidth',1)
line([.5 .5],[-.05 .05],'color','k','LineWidth',1)
line([1 1],[-.05 .05],'color','k','LineWidth',1)
line([1.5 1.5],[-.05 .05],'color','k','LineWidth',1)
line([-.5 -.5],[-.05 .05],'color','k','LineWidth',1)
line([-1 -1],[-.05 .05],'color','k','LineWidth',1)
line([-1.5 -1.5],[-.05 .05],'color','k','LineWidth',1)
line([-.05 .05],[.5 .5],'color','k','LineWidth',1)
line([-.05 .05],[1 1],'color','k','LineWidth',1)
line([-.05 .05],[1.5 1.5],'color','k','LineWidth',1)
line([-.05 .05],[-.5 -.5],'color','k','LineWidth',1)
line([-.05 .05],[-1 -1],'color','k','LineWidth',1)
line([-.05 .05],[-1.5 -1.5],'color','k','LineWidth',1)
axis([-2 2 -2 2])
box('on')
text(.1,2.4,'Anticyclones N=74,354','HorizontalAlignment','center','fontsize',15,'color','red')
text(2.25,3.15,'Not Rotated','HorizontalAlignment','center','fontsize',24)

loc_x=loc_x+xspan+dx;

ax=subplot(644);
tmp=interp2((0.013/0.01)*noro_w_ek_sst_fixed_a.mean);
set(ax,'units','inches','position',[loc_x yofst xspan xspan],'linewidth',1.5)
pcolor(x,y,tmp);shading interp;colormap(bwr);
caxis([-10 10]);
hold on

[cs,h]=contour(x,y,tmp,[-100:1:-1],'k--','linewidth',1);
if any(cs)
    clabel(cs,h,'LabelSpacing',1000,'fontsize',9)
end
clear cs h
[cs,h]=contour(x,y,tmp,[1:1:100],'k','linewidth',1);
if any(cs)
    clabel(cs,h,'LabelSpacing',1000,'fontsize',9)
end

dd=['-2';'  ';'-1';'  ';' 0';'  ';' 1';'  ';' 2'];
set(gca,'xtick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2],'ytick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2]','yticklabel',[],'xticklabel',[],'fontsize',12,'LineWidth',1.5,'TickLength',[.01 .01],'layer','top')
line([-2 2],[0 0],'color','k','LineWidth',1)
line([0 0],[-2 2],'color','k','LineWidth',1)
line([.5 .5],[-.05 .05],'color','k','LineWidth',1)
line([1 1],[-.05 .05],'color','k','LineWidth',1)
line([1.5 1.5],[-.05 .05],'color','k','LineWidth',1)
line([-.5 -.5],[-.05 .05],'color','k','LineWidth',1)
line([-1 -1],[-.05 .05],'color','k','LineWidth',1)
line([-1.5 -1.5],[-.05 .05],'color','k','LineWidth',1)
line([-.05 .05],[.5 .5],'color','k','LineWidth',1)
line([-.05 .05],[1 1],'color','k','LineWidth',1)
line([-.05 .05],[1.5 1.5],'color','k','LineWidth',1)
line([-.05 .05],[-.5 -.5],'color','k','LineWidth',1)
line([-.05 .05],[-1 -1],'color','k','LineWidth',1)
line([-.05 .05],[-1.5 -1.5],'color','k','LineWidth',1)
axis([-2 2 -2 2])
box('on')
text(.05,2.4,'Cyclones N=75,905','HorizontalAlignment','center','fontsize',15,'color','blue')


yofst=yofst-xspan-dy;


%%Wcur rot
ax=subplot(645);
tmp=interp2(w_ek_total_a.mean);
x=linspace(-2,2,length(tmp(1,:)));
y=x';

loc_x=xofst;
set(ax,'units','inches','position',[loc_x yofst xspan xspan],'linewidth',1.5)
pcolor(x,y,tmp);shading interp;colormap(bwr);
caxis([-10 10]);
hold on

[cs,h]=contour(x,y,tmp,[-100:2:-1],'k--','linewidth',1);
[cs,h]=contour(x,y,tmp,[-101:2:-1],'k--','linewidth',1);
if any(cs)
    clabel(cs,h,'LabelSpacing',1000,'fontsize',9)
end
clear cs h
[cs,h]=contour(x,y,tmp,[1:2:100],'k','linewidth',1);
[cs,h]=contour(x,y,tmp,[2:2:100],'k','linewidth',1);
if any(cs)
    clabel(cs,h,'LabelSpacing',1000,'fontsize',9)
end

dd=['-2';'  ';'-1';'  ';' 0';'  ';' 1';'  ';' 2'];
set(gca,'xtick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2],'ytick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2]','yticklabel',dd,'xticklabel',[],'fontsize',12,'LineWidth',1.5,'TickLength',[.01 .01],'layer','top')
line([-2 2],[0 0],'color','k','LineWidth',1)
line([0 0],[-2 2],'color','k','LineWidth',1)
line([.5 .5],[-.05 .05],'color','k','LineWidth',1)
line([1 1],[-.05 .05],'color','k','LineWidth',1)
line([1.5 1.5],[-.05 .05],'color','k','LineWidth',1)
line([-.5 -.5],[-.05 .05],'color','k','LineWidth',1)
line([-1 -1],[-.05 .05],'color','k','LineWidth',1)
line([-1.5 -1.5],[-.05 .05],'color','k','LineWidth',1)
line([-.05 .05],[.5 .5],'color','k','LineWidth',1)
line([-.05 .05],[1 1],'color','k','LineWidth',1)
line([-.05 .05],[1.5 1.5],'color','k','LineWidth',1)
line([-.05 .05],[-.5 -.5],'color','k','LineWidth',1)
line([-.05 .05],[-1 -1],'color','k','LineWidth',1)
line([-.05 .05],[-1.5 -1.5],'color','k','LineWidth',1)
axis([-2 2 -2 2])
box('on')
ylabel('$W_{cur}$','HorizontalAlignment','center','fontsize',20,'interpreter','latex')
text(-1.85,2.3,'b)','HorizontalAlignment','center','fontsize',16,'fontweight','bold')

loc_x=loc_x+xspan+dx;

ax=subplot(646);
tmp=interp2(w_ek_total_c.mean);
set(ax,'units','inches','position',[loc_x yofst xspan xspan],'linewidth',1.5)
pcolor(x,y,tmp);shading interp;colormap(bwr);
caxis([-10 10]);
hold on

[cs,h]=contour(x,y,tmp,[-100:2:-1],'k--','linewidth',1);
[cs,h]=contour(x,y,tmp,[-101:2:-1],'k--','linewidth',1);
if any(cs)
    clabel(cs,h,'LabelSpacing',1000,'fontsize',9)
end
clear cs h
[cs,h]=contour(x,y,tmp,[1:2:100],'k','linewidth',1);
[cs,h]=contour(x,y,tmp,[2:2:100],'k','linewidth',1);
if any(cs)
    clabel(cs,h,'LabelSpacing',1000,'fontsize',9)
end


dd=['-2';'  ';'-1';'  ';' 0';'  ';' 1';'  ';' 2'];
set(gca,'xtick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2],'ytick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2]','yticklabel',[],'xticklabel',[],'fontsize',12,'LineWidth',1.5,'TickLength',[.01 .01],'layer','top')
line([-2 2],[0 0],'color','k','LineWidth',1)
line([0 0],[-2 2],'color','k','LineWidth',1)
line([.5 .5],[-.05 .05],'color','k','LineWidth',1)
line([1 1],[-.05 .05],'color','k','LineWidth',1)
line([1.5 1.5],[-.05 .05],'color','k','LineWidth',1)
line([-.5 -.5],[-.05 .05],'color','k','LineWidth',1)
line([-1 -1],[-.05 .05],'color','k','LineWidth',1)
line([-1.5 -1.5],[-.05 .05],'color','k','LineWidth',1)
line([-.05 .05],[.5 .5],'color','k','LineWidth',1)
line([-.05 .05],[1 1],'color','k','LineWidth',1)
line([-.05 .05],[1.5 1.5],'color','k','LineWidth',1)
line([-.05 .05],[-.5 -.5],'color','k','LineWidth',1)
line([-.05 .05],[-1 -1],'color','k','LineWidth',1)
line([-.05 .05],[-1.5 -1.5],'color','k','LineWidth',1)
axis([-2 2 -2 2])
box('on')


%%W_cur noro
loc_x=loc_x+xspan+dx+dx;

ax=subplot(647);
tmp=interp2(noro_w_ek_total_a.mean);
set(ax,'units','inches','position',[loc_x yofst xspan xspan],'linewidth',1.5)
pcolor(x,y,tmp);shading interp;colormap(bwr);
caxis([-10 10]);
hold on

[cs,h]=contour(x,y,tmp,[-100:2:-1],'k--','linewidth',1);
[cs,h]=contour(x,y,tmp,[-101:2:-1],'k--','linewidth',1);
if any(cs)
    clabel(cs,h,'LabelSpacing',1000,'fontsize',9)
end
clear cs h
[cs,h]=contour(x,y,tmp,[1:2:100],'k','linewidth',1);
[cs,h]=contour(x,y,tmp,[2:2:100],'k','linewidth',1);
if any(cs)
    clabel(cs,h,'LabelSpacing',1000,'fontsize',9)
end

dd=['-2';'  ';'-1';'  ';' 0';'  ';' 1';'  ';' 2'];
set(gca,'xtick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2],'ytick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2]','yticklabel',[],'xticklabel',[],'fontsize',12,'LineWidth',1.5,'TickLength',[.01 .01],'layer','top')
line([-2 2],[0 0],'color','k','LineWidth',1)
line([0 0],[-2 2],'color','k','LineWidth',1)
line([.5 .5],[-.05 .05],'color','k','LineWidth',1)
line([1 1],[-.05 .05],'color','k','LineWidth',1)
line([1.5 1.5],[-.05 .05],'color','k','LineWidth',1)
line([-.5 -.5],[-.05 .05],'color','k','LineWidth',1)
line([-1 -1],[-.05 .05],'color','k','LineWidth',1)
line([-1.5 -1.5],[-.05 .05],'color','k','LineWidth',1)
line([-.05 .05],[.5 .5],'color','k','LineWidth',1)
line([-.05 .05],[1 1],'color','k','LineWidth',1)
line([-.05 .05],[1.5 1.5],'color','k','LineWidth',1)
line([-.05 .05],[-.5 -.5],'color','k','LineWidth',1)
line([-.05 .05],[-1 -1],'color','k','LineWidth',1)
line([-.05 .05],[-1.5 -1.5],'color','k','LineWidth',1)
axis([-2 2 -2 2])
box('on')

loc_x=loc_x+xspan+dx;

ax=subplot(648);
tmp=interp2(noro_w_ek_total_c.mean);
set(ax,'units','inches','position',[loc_x yofst xspan xspan],'linewidth',1.5)
pcolor(x,y,tmp);shading interp;colormap(bwr);
caxis([-10 10]);
hold on

[cs,h]=contour(x,y,tmp,[-100:2:-1],'k--','linewidth',1);
[cs,h]=contour(x,y,tmp,[-101:2:-1],'k--','linewidth',1);
if any(cs)
    clabel(cs,h,'LabelSpacing',1000,'fontsize',9)
end
clear cs h
[cs,h]=contour(x,y,tmp,[1:2:100],'k','linewidth',1);
[cs,h]=contour(x,y,tmp,[2:2:100],'k','linewidth',1);
if any(cs)
    clabel(cs,h,'LabelSpacing',1000,'fontsize',9)
end

dd=['-2';'  ';'-1';'  ';' 0';'  ';' 1';'  ';' 2'];
set(gca,'xtick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2],'ytick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2]','yticklabel',[],'xticklabel',[],'fontsize',12,'LineWidth',1.5,'TickLength',[.01 .01],'layer','top')
line([-2 2],[0 0],'color','k','LineWidth',1)
line([0 0],[-2 2],'color','k','LineWidth',1)
line([.5 .5],[-.05 .05],'color','k','LineWidth',1)
line([1 1],[-.05 .05],'color','k','LineWidth',1)
line([1.5 1.5],[-.05 .05],'color','k','LineWidth',1)
line([-.5 -.5],[-.05 .05],'color','k','LineWidth',1)
line([-1 -1],[-.05 .05],'color','k','LineWidth',1)
line([-1.5 -1.5],[-.05 .05],'color','k','LineWidth',1)
line([-.05 .05],[.5 .5],'color','k','LineWidth',1)
line([-.05 .05],[1 1],'color','k','LineWidth',1)
line([-.05 .05],[1.5 1.5],'color','k','LineWidth',1)
line([-.05 .05],[-.5 -.5],'color','k','LineWidth',1)
line([-.05 .05],[-1 -1],'color','k','LineWidth',1)
line([-.05 .05],[-1.5 -1.5],'color','k','LineWidth',1)
axis([-2 2 -2 2])
box('on')

yofst=yofst-xspan-dy;


%%Wtot_est rot
ax=subplot(649);
tmp=interp2((0.013/0.01)*w_ek_sst_fixed_a.mean+w_ek_total_a.mean);
x=linspace(-2,2,length(tmp(1,:)));
y=x';

loc_x=xofst;
set(ax,'units','inches','position',[loc_x yofst xspan xspan],'linewidth',1.5)
pcolor(x,y,tmp);shading interp;colormap(bwr);
caxis([-10 10]);
hold on

[cs,h]=contour(x,y,tmp,[-100:2:-1],'k--','linewidth',1);
[cs,h]=contour(x,y,tmp,[-101:2:-1],'k--','linewidth',1);
if any(cs)
    clabel(cs,h,'LabelSpacing',1000,'fontsize',9)
end
clear cs h
[cs,h]=contour(x,y,tmp,[1:2:100],'k','linewidth',1);
[cs,h]=contour(x,y,tmp,[2:2:100],'k','linewidth',1);
if any(cs)
    clabel(cs,h,'LabelSpacing',1000,'fontsize',9)
end


dd=['-2';'  ';'-1';'  ';' 0';'  ';' 1';'  ';' 2'];
set(gca,'xtick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2],'ytick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2]','yticklabel',dd,'xticklabel',[],'fontsize',12,'LineWidth',1.5,'TickLength',[.01 .01],'layer','top')
line([-2 2],[0 0],'color','k','LineWidth',1)
line([0 0],[-2 2],'color','k','LineWidth',1)
line([.5 .5],[-.05 .05],'color','k','LineWidth',1)
line([1 1],[-.05 .05],'color','k','LineWidth',1)
line([1.5 1.5],[-.05 .05],'color','k','LineWidth',1)
line([-.5 -.5],[-.05 .05],'color','k','LineWidth',1)
line([-1 -1],[-.05 .05],'color','k','LineWidth',1)
line([-1.5 -1.5],[-.05 .05],'color','k','LineWidth',1)
line([-.05 .05],[.5 .5],'color','k','LineWidth',1)
line([-.05 .05],[1 1],'color','k','LineWidth',1)
line([-.05 .05],[1.5 1.5],'color','k','LineWidth',1)
line([-.05 .05],[-.5 -.5],'color','k','LineWidth',1)
line([-.05 .05],[-1 -1],'color','k','LineWidth',1)
line([-.05 .05],[-1.5 -1.5],'color','k','LineWidth',1)
axis([-2 2 -2 2])
box('on')
ylabel('$\tilde{W}_{tot}$','HorizontalAlignment','center','fontsize',20,'interpreter','latex')
text(-1.85,2.3,'d)','HorizontalAlignment','center','fontsize',16,'fontweight','bold')

loc_x=loc_x+xspan+dx;

ax=subplot(6,4,10);
tmp=interp2((0.013/0.01)*w_ek_sst_fixed_c.mean+w_ek_total_c.mean);
set(ax,'units','inches','position',[loc_x yofst xspan xspan],'linewidth',1.5)
pcolor(x,y,tmp);shading interp;colormap(bwr);
caxis([-10 10]);
hold on

[cs,h]=contour(x,y,tmp,[-100:2:-1],'k--','linewidth',1);
[cs,h]=contour(x,y,tmp,[-101:2:-1],'k--','linewidth',1);
if any(cs)
    clabel(cs,h,'LabelSpacing',1000,'fontsize',9)
end
clear cs h
[cs,h]=contour(x,y,tmp,[1:2:100],'k','linewidth',1);
[cs,h]=contour(x,y,tmp,[2:2:100],'k','linewidth',1);
if any(cs)
    clabel(cs,h,'LabelSpacing',1000,'fontsize',9)
end


dd=['-2';'  ';'-1';'  ';' 0';'  ';' 1';'  ';' 2'];
set(gca,'xtick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2],'ytick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2]','yticklabel',[],'xticklabel',[],'fontsize',12,'LineWidth',1.5,'TickLength',[.01 .01],'layer','top')
line([-2 2],[0 0],'color','k','LineWidth',1)
line([0 0],[-2 2],'color','k','LineWidth',1)
line([.5 .5],[-.05 .05],'color','k','LineWidth',1)
line([1 1],[-.05 .05],'color','k','LineWidth',1)
line([1.5 1.5],[-.05 .05],'color','k','LineWidth',1)
line([-.5 -.5],[-.05 .05],'color','k','LineWidth',1)
line([-1 -1],[-.05 .05],'color','k','LineWidth',1)
line([-1.5 -1.5],[-.05 .05],'color','k','LineWidth',1)
line([-.05 .05],[.5 .5],'color','k','LineWidth',1)
line([-.05 .05],[1 1],'color','k','LineWidth',1)
line([-.05 .05],[1.5 1.5],'color','k','LineWidth',1)
line([-.05 .05],[-.5 -.5],'color','k','LineWidth',1)
line([-.05 .05],[-1 -1],'color','k','LineWidth',1)
line([-.05 .05],[-1.5 -1.5],'color','k','LineWidth',1)
axis([-2 2 -2 2])
box('on')


%%W_tot_est noro
loc_x=loc_x+xspan+dx+dx;

ax=subplot(6,4,11);
tmp=interp2((0.013/0.01)*noro_w_ek_sst_fixed_a.mean+noro_w_ek_total_a.mean);
set(ax,'units','inches','position',[loc_x yofst xspan xspan],'linewidth',1.5)
pcolor(x,y,tmp);shading interp;colormap(bwr);
caxis([-10 10]);
hold on

[cs,h]=contour(x,y,tmp,[-100:2:-1],'k--','linewidth',1);
[cs,h]=contour(x,y,tmp,[-101:2:-1],'k--','linewidth',1);
if any(cs)
    clabel(cs,h,'LabelSpacing',1000,'fontsize',9)
end
clear cs h
[cs,h]=contour(x,y,tmp,[1:2:100],'k','linewidth',1);
[cs,h]=contour(x,y,tmp,[2:2:100],'k','linewidth',1);
if any(cs)
    clabel(cs,h,'LabelSpacing',1000,'fontsize',9)
end


dd=['-2';'  ';'-1';'  ';' 0';'  ';' 1';'  ';' 2'];
set(gca,'xtick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2],'ytick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2]','yticklabel',[],'xticklabel',[],'fontsize',12,'LineWidth',1.5,'TickLength',[.01 .01],'layer','top')
line([-2 2],[0 0],'color','k','LineWidth',1)
line([0 0],[-2 2],'color','k','LineWidth',1)
line([.5 .5],[-.05 .05],'color','k','LineWidth',1)
line([1 1],[-.05 .05],'color','k','LineWidth',1)
line([1.5 1.5],[-.05 .05],'color','k','LineWidth',1)
line([-.5 -.5],[-.05 .05],'color','k','LineWidth',1)
line([-1 -1],[-.05 .05],'color','k','LineWidth',1)
line([-1.5 -1.5],[-.05 .05],'color','k','LineWidth',1)
line([-.05 .05],[.5 .5],'color','k','LineWidth',1)
line([-.05 .05],[1 1],'color','k','LineWidth',1)
line([-.05 .05],[1.5 1.5],'color','k','LineWidth',1)
line([-.05 .05],[-.5 -.5],'color','k','LineWidth',1)
line([-.05 .05],[-1 -1],'color','k','LineWidth',1)
line([-.05 .05],[-1.5 -1.5],'color','k','LineWidth',1)
axis([-2 2 -2 2])
box('on')

loc_x=loc_x+xspan+dx;

ax=subplot(6,4,12);
tmp=interp2((0.013/0.01)*noro_w_ek_sst_fixed_c.mean+noro_w_ek_total_c.mean);
set(ax,'units','inches','position',[loc_x yofst xspan xspan],'linewidth',1.5)
pcolor(x,y,tmp);shading interp;colormap(bwr);
caxis([-10 10]);
hold on

[cs,h]=contour(x,y,tmp,[-100:2:-1],'k--','linewidth',1);
[cs,h]=contour(x,y,tmp,[-101:2:-1],'k--','linewidth',1);
if any(cs)
    clabel(cs,h,'LabelSpacing',1000,'fontsize',9)
end
clear cs h
[cs,h]=contour(x,y,tmp,[1:2:100],'k','linewidth',1);
[cs,h]=contour(x,y,tmp,[2:2:100],'k','linewidth',1);
if any(cs)
    clabel(cs,h,'LabelSpacing',1000,'fontsize',9)
end


dd=['-2';'  ';'-1';'  ';' 0';'  ';' 1';'  ';' 2'];
set(gca,'xtick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2],'ytick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2]','yticklabel',[],'xticklabel',[],'fontsize',12,'LineWidth',1.5,'TickLength',[.01 .01],'layer','top')
line([-2 2],[0 0],'color','k','LineWidth',1)
line([0 0],[-2 2],'color','k','LineWidth',1)
line([.5 .5],[-.05 .05],'color','k','LineWidth',1)
line([1 1],[-.05 .05],'color','k','LineWidth',1)
line([1.5 1.5],[-.05 .05],'color','k','LineWidth',1)
line([-.5 -.5],[-.05 .05],'color','k','LineWidth',1)
line([-1 -1],[-.05 .05],'color','k','LineWidth',1)
line([-1.5 -1.5],[-.05 .05],'color','k','LineWidth',1)
line([-.05 .05],[.5 .5],'color','k','LineWidth',1)
line([-.05 .05],[1 1],'color','k','LineWidth',1)
line([-.05 .05],[1.5 1.5],'color','k','LineWidth',1)
line([-.05 .05],[-.5 -.5],'color','k','LineWidth',1)
line([-.05 .05],[-1 -1],'color','k','LineWidth',1)
line([-.05 .05],[-1.5 -1.5],'color','k','LineWidth',1)
axis([-2 2 -2 2])
box('on')

yofst=yofst-xspan-dy;


%%Wtot rot
ax=subplot(6,4,17);
tmp=interp2(w_ek_total_qscat_a.mean);
x=linspace(-2,2,length(tmp(1,:)));
y=x';

loc_x=xofst;
set(ax,'units','inches','position',[loc_x yofst xspan xspan],'linewidth',1.5)
pcolor(x,y,tmp);shading interp;colormap(bwr);
caxis([-10 10]);
hold on

[cs,h]=contour(x,y,tmp,[-100:2:-1],'k--','linewidth',1);
[cs,h]=contour(x,y,tmp,[-101:2:-1],'k--','linewidth',1);
if any(cs)
    clabel(cs,h,'LabelSpacing',1000,'fontsize',9)
end
clear cs h
[cs,h]=contour(x,y,tmp,[1:2:100],'k','linewidth',1);
[cs,h]=contour(x,y,tmp,[2:2:100],'k','linewidth',1);
if any(cs)
    clabel(cs,h,'LabelSpacing',1000,'fontsize',9)
end


dd=['-2';'  ';'-1';'  ';' 0';'  ';' 1';'  ';' 2'];
set(gca,'xtick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2],'ytick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2]','yticklabel',dd,'xticklabel',dd,'fontsize',12,'LineWidth',1.5,'TickLength',[.01 .01],'layer','top')
line([-2 2],[0 0],'color','k','LineWidth',1)
line([0 0],[-2 2],'color','k','LineWidth',1)
line([.5 .5],[-.05 .05],'color','k','LineWidth',1)
line([1 1],[-.05 .05],'color','k','LineWidth',1)
line([1.5 1.5],[-.05 .05],'color','k','LineWidth',1)
line([-.5 -.5],[-.05 .05],'color','k','LineWidth',1)
line([-1 -1],[-.05 .05],'color','k','LineWidth',1)
line([-1.5 -1.5],[-.05 .05],'color','k','LineWidth',1)
line([-.05 .05],[.5 .5],'color','k','LineWidth',1)
line([-.05 .05],[1 1],'color','k','LineWidth',1)
line([-.05 .05],[1.5 1.5],'color','k','LineWidth',1)
line([-.05 .05],[-.5 -.5],'color','k','LineWidth',1)
line([-.05 .05],[-1 -1],'color','k','LineWidth',1)
line([-.05 .05],[-1.5 -1.5],'color','k','LineWidth',1)
axis([-2 2 -2 2])
box('on')
ylabel('$W_{tot}$','HorizontalAlignment','center','fontsize',20,'interpreter','latex')
text(-1.85,2.3,'e)','HorizontalAlignment','center','fontsize',16,'fontweight','bold')

loc_x=loc_x+xspan+dx;

ax=subplot(6,4,18);
tmp=interp2(w_ek_total_qscat_c.mean);
set(ax,'units','inches','position',[loc_x yofst xspan xspan],'linewidth',1.5)
pcolor(x,y,tmp);shading interp;colormap(bwr);
caxis([-10 10]);
hold on

[cs,h]=contour(x,y,tmp,[-100:2:-1],'k--','linewidth',1);
[cs,h]=contour(x,y,tmp,[-101:2:-1],'k--','linewidth',1);
if any(cs)
    clabel(cs,h,'LabelSpacing',1000,'fontsize',9)
end
clear cs h
[cs,h]=contour(x,y,tmp,[1:2:100],'k','linewidth',1);
[cs,h]=contour(x,y,tmp,[2:2:100],'k','linewidth',1);
if any(cs)
    clabel(cs,h,'LabelSpacing',1000,'fontsize',9)
end


dd=['-2';'  ';'-1';'  ';' 0';'  ';' 1';'  ';' 2'];
set(gca,'xtick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2],'ytick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2]','yticklabel',[],'xticklabel',dd,'fontsize',12,'LineWidth',1.5,'TickLength',[.01 .01],'layer','top')
line([-2 2],[0 0],'color','k','LineWidth',1)
line([0 0],[-2 2],'color','k','LineWidth',1)
line([.5 .5],[-.05 .05],'color','k','LineWidth',1)
line([1 1],[-.05 .05],'color','k','LineWidth',1)
line([1.5 1.5],[-.05 .05],'color','k','LineWidth',1)
line([-.5 -.5],[-.05 .05],'color','k','LineWidth',1)
line([-1 -1],[-.05 .05],'color','k','LineWidth',1)
line([-1.5 -1.5],[-.05 .05],'color','k','LineWidth',1)
line([-.05 .05],[.5 .5],'color','k','LineWidth',1)
line([-.05 .05],[1 1],'color','k','LineWidth',1)
line([-.05 .05],[1.5 1.5],'color','k','LineWidth',1)
line([-.05 .05],[-.5 -.5],'color','k','LineWidth',1)
line([-.05 .05],[-1 -1],'color','k','LineWidth',1)
line([-.05 .05],[-1.5 -1.5],'color','k','LineWidth',1)
axis([-2 2 -2 2])
box('on')


%%W_tot_est noro
loc_x=loc_x+xspan+dx+dx;

ax=subplot(6,4,19);
tmp=interp2(noro_w_ek_total_qscat_a.mean);
set(ax,'units','inches','position',[loc_x yofst xspan xspan],'linewidth',1.5)
pcolor(x,y,tmp);shading interp;colormap(bwr);
caxis([-10 10]);
hold on

[cs,h]=contour(x,y,tmp,[-100:2:-1],'k--','linewidth',1);
[cs,h]=contour(x,y,tmp,[-101:2:-1],'k--','linewidth',1);
if any(cs)
    clabel(cs,h,'LabelSpacing',1000,'fontsize',9)
end
clear cs h
[cs,h]=contour(x,y,tmp,[1:2:100],'k','linewidth',1);
[cs,h]=contour(x,y,tmp,[2:2:100],'k','linewidth',1);
if any(cs)
    clabel(cs,h,'LabelSpacing',1000,'fontsize',9)
end


dd=['-2';'  ';'-1';'  ';' 0';'  ';' 1';'  ';' 2'];
set(gca,'xtick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2],'ytick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2]','yticklabel',[],'xticklabel',dd,'fontsize',12,'LineWidth',1.5,'TickLength',[.01 .01],'layer','top')
line([-2 2],[0 0],'color','k','LineWidth',1)
line([0 0],[-2 2],'color','k','LineWidth',1)
line([.5 .5],[-.05 .05],'color','k','LineWidth',1)
line([1 1],[-.05 .05],'color','k','LineWidth',1)
line([1.5 1.5],[-.05 .05],'color','k','LineWidth',1)
line([-.5 -.5],[-.05 .05],'color','k','LineWidth',1)
line([-1 -1],[-.05 .05],'color','k','LineWidth',1)
line([-1.5 -1.5],[-.05 .05],'color','k','LineWidth',1)
line([-.05 .05],[.5 .5],'color','k','LineWidth',1)
line([-.05 .05],[1 1],'color','k','LineWidth',1)
line([-.05 .05],[1.5 1.5],'color','k','LineWidth',1)
line([-.05 .05],[-.5 -.5],'color','k','LineWidth',1)
line([-.05 .05],[-1 -1],'color','k','LineWidth',1)
line([-.05 .05],[-1.5 -1.5],'color','k','LineWidth',1)
axis([-2 2 -2 2])
box('on')

loc_x=loc_x+xspan+dx;

ax=subplot(6,4,20);
tmp=interp2(noro_w_ek_total_qscat_c.mean);
set(ax,'units','inches','position',[loc_x yofst xspan xspan],'linewidth',1.5)
pcolor(x,y,tmp);shading interp;colormap(bwr);
caxis([-10 10]);
hold on
[cs,h]=contour(x,y,tmp,[-100:2:-1],'k--','linewidth',1);
[cs,h]=contour(x,y,tmp,[-101:2:-1],'k--','linewidth',1);
if any(cs)
    clabel(cs,h,'LabelSpacing',1000,'fontsize',9)
end
clear cs h
[cs,h]=contour(x,y,tmp,[1:2:100],'k','linewidth',1);
[cs,h]=contour(x,y,tmp,[2:2:100],'k','linewidth',1);
if any(cs)
    clabel(cs,h,'LabelSpacing',1000,'fontsize',9)
end

dd=['-2';'  ';'-1';'  ';' 0';'  ';' 1';'  ';' 2'];
set(gca,'xtick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2],'ytick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2]','yticklabel',[],'xticklabel',dd,'fontsize',12,'LineWidth',1.5,'TickLength',[.01 .01],'layer','top')
line([-2 2],[0 0],'color','k','LineWidth',1)
line([0 0],[-2 2],'color','k','LineWidth',1)
line([.5 .5],[-.05 .05],'color','k','LineWidth',1)
line([1 1],[-.05 .05],'color','k','LineWidth',1)
line([1.5 1.5],[-.05 .05],'color','k','LineWidth',1)
line([-.5 -.5],[-.05 .05],'color','k','LineWidth',1)
line([-1 -1],[-.05 .05],'color','k','LineWidth',1)
line([-1.5 -1.5],[-.05 .05],'color','k','LineWidth',1)
line([-.05 .05],[.5 .5],'color','k','LineWidth',1)
line([-.05 .05],[1 1],'color','k','LineWidth',1)
line([-.05 .05],[1.5 1.5],'color','k','LineWidth',1)
line([-.05 .05],[-.5 -.5],'color','k','LineWidth',1)
line([-.05 .05],[-1 -1],'color','k','LineWidth',1)
line([-.05 .05],[-1.5 -1.5],'color','k','LineWidth',1)
axis([-2 2 -2 2])
box('on')
text(0.3,-2.6,'contour inteval 1 cm day^{-1}','HorizontalAlignment','center','fontsize',14)


%%colorbar
yofst=yofst-dy-dy-dy/2;

ax=subplot(6,4,24)
set(ax,'visible','off')
cc=colorbar('horiz');
caxis([-10 10])
set(cc,'units','inches','position',[3.5+dx yofst 2*xspan .3],'LineWidth',1.5)
xlabel(cc,{'cm day^{-1}'},'fontsize',13,'HorizontalAlignment','center')

print -dpng -r300 ~/Documents/Publications/gaube_chelton_sst_wind_eddies/figs/SH_wek_comps
    
    
    
    
    
    
    






