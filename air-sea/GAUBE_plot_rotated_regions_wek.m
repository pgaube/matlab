clear all
load bwr.pal
curs2 = {'SPAC',...
    'AGUL',...
    'HAW',...
    'SIO',...
    'CAR',...
    'SATL',...
    'new_EIO',...
    'new_SEA',...
    'SP'};



%			sst		crl	    W_E		W_Ec	W_T		W_Tc
cranges= [	.3		.4		10		2		1		.25		%SP		1
            .7		.7		35		5		15		2		%AGR	2
            .15		.5		20		5		2		.2		%HAW	3
            .4		.7		15		3		3		.5		%EIO	4
            .06		.5		35		5		3		.5   	%CAR	5
            1		1		20		5		10		1       %SEA	6
            .4		.7		12		2		2		.25     %newEIO 7
            1		1		15		2		7		1       %SEA2	8
            .3		.4		10		2		1		.25];	%old SP 9



%The regional plots are 2in on a side, x and y spacing is 0.5 and 0.35, 
%respectively and the bottom left corner of the upper left panel is at 
%1.5 and 8.0 inches from the lower left corner of an assumed 8.5x 11 inch page.
 
ysz=11;
xsz=8.5
xspan=2;
dx=0.5;
dy=.35
ofst=1.5;
ofst2=8;

load GAUBE_region_comps

for mm=1:6
eval(['w_tot_a=interp2(',curs{mm},'_wek_total_qscat_a.mean);'])
eval(['w_tot_c=interp2(',curs{mm},'_wek_total_qscat_c.mean);'])

eval(['w_cur_a=interp2(',curs{mm},'_wek_total_a.mean);'])
eval(['w_cur_c=interp2(',curs{mm},'_wek_total_c.mean);'])

eval(['w_sst_a=interp2((.013/.01)*',curs{mm},'_fixed_wek_sst_a.mean);'])
eval(['w_sst_c=interp2((.013/.01)*',curs{mm},'_fixed_wek_sst_c.mean);'])

x=linspace(-2,2,length(w_tot_a(1,:)));
y=x';

figure(1)
clf
set(gcf,'PaperPosition',[1 1 xsz ysz])

%%w_tot_ac

ax=subplot(421);
tit='QSCAT Pumping';
set(ax,'units','inches','position',[ofst ofst2 xspan xspan],'linewidth',1.5)
pcolor(x,y,w_tot_a);shading interp;colormap(bwr);
caxis([-cranges(mm,3) cranges(mm,3)])
hold on
[cs,h]=contour(x,y,w_tot_a,[cranges(mm,4):cranges(mm,4):100],'k','linewidth',2);
if any(cs)
    clabel(cs,h,'LabelSpacing',1000)
end
clear cs h
[cs,h]=contour(x,y,w_tot_a,[-100:cranges(mm,4):-cranges(mm,4)],'k--','linewidth',2);
if any(cs)
    clabel(cs,h,'LabelSpacing',1000)
end

dd=['-2';'  ';'-1';'  ';' 0';'  ';' 1';'  ';' 2'];
set(gca,'xtick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2],'ytick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2]','yticklabel',dd,'xticklabel',dd,'fontsize',12,'LineWidth',3,'fontweight','bold','TickLength',[.01 .01],'layer','top')

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

ylabel(tit,'fontsize',12,'fontweight','bold') 

box
box

%%w_add_ac

ax=subplot(423);
tit='Current+SST Pumping';
set(ax,'units','inches','position',[ofst ofst2-dy-xspan xspan xspan],'linewidth',1.5)
pcolor(x,y,w_cur_a+w_sst_a);shading interp;colormap(bwr);
caxis([-cranges(mm,3) cranges(mm,3)])
hold on
[cs,h]=contour(x,y,w_cur_a+w_sst_a,[cranges(mm,4):cranges(mm,4):100],'k','linewidth',2);
if any(cs)
    clabel(cs,h,'LabelSpacing',1000)
end
clear cs h
[cs,h]=contour(x,y,w_cur_a+w_sst_a,[-100:cranges(mm,4):-cranges(mm,4)],'k--','linewidth',2);
if any(cs)
    clabel(cs,h,'LabelSpacing',1000)
end

dd=['-2';'  ';'-1';'  ';' 0';'  ';' 1';'  ';' 2'];
set(gca,'xtick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2],'ytick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2]','yticklabel',dd,'xticklabel',dd,'fontsize',12,'LineWidth',3,'fontweight','bold','TickLength',[.01 .01],'layer','top')

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

ylabel(tit,'fontsize',12,'fontweight','bold') 

%%w_cur_ac


box
box

ax=subplot(425);
tit='Current Pumping';
set(ax,'units','inches','position',[ofst ofst2-dy-xspan-dy-xspan xspan xspan],'linewidth',1.5)
pcolor(x,y,w_cur_a);shading interp;colormap(bwr);
caxis([-cranges(mm,3) cranges(mm,3)])
hold on
[cs,h]=contour(x,y,w_cur_a,[cranges(mm,4):cranges(mm,4):100],'k','linewidth',2);
if any(cs)
    clabel(cs,h,'LabelSpacing',1000)
end
clear cs h
[cs,h]=contour(x,y,w_cur_a,[-100:cranges(mm,4):-cranges(mm,4)],'k--','linewidth',2);
if any(cs)
    clabel(cs,h,'LabelSpacing',1000)
end

dd=['-2';'  ';'-1';'  ';' 0';'  ';' 1';'  ';' 2'];
set(gca,'xtick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2],'ytick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2]','yticklabel',dd,'xticklabel',dd,'fontsize',12,'LineWidth',3,'fontweight','bold','TickLength',[.01 .01],'layer','top')

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

ylabel(tit,'fontsize',12,'fontweight','bold') 

box
box

%%w_sst_ac

ax=subplot(427);
tit='SST Pumping';
set(ax,'units','inches','position',[ofst ofst2-dy-xspan-dy-xspan-dy-xspan xspan xspan],'linewidth',1.5)
pcolor(x,y,w_sst_a);shading interp;colormap(bwr);
caxis([-cranges(mm,5) cranges(mm,5)])
hold on
[cs,h]=contour(x,y,w_sst_a,[cranges(mm,6):cranges(mm,6):100],'k','linewidth',2);
if any(cs)
    clabel(cs,h,'LabelSpacing',1000)
end
clear cs h
[cs,h]=contour(x,y,w_sst_a,[-100:cranges(mm,6):-cranges(mm,6)],'k--','linewidth',2);
if any(cs)
    clabel(cs,h,'LabelSpacing',1000)
end

dd=['-2';'  ';'-1';'  ';' 0';'  ';' 1';'  ';' 2'];
set(gca,'xtick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2],'ytick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2]','yticklabel',dd,'xticklabel',dd,'fontsize',12,'LineWidth',3,'fontweight','bold','TickLength',[.01 .01],'layer','top')

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

ylabel(tit,'fontsize',12,'fontweight','bold') 

%%w_tot_cc

ax=subplot(422);
tit='QSCAT Pumping';
set(ax,'units','inches','position',[ofst+xspan+dx ofst2 xspan xspan],'linewidth',1.5)
pcolor(x,y,w_tot_c);shading interp;colormap(bwr);
caxis([-cranges(mm,3) cranges(mm,3)])
hold on
[cs,h]=contour(x,y,w_tot_c,[cranges(mm,4):cranges(mm,4):100],'k','linewidth',2);
if any(cs)
    clabel(cs,h,'LabelSpacing',1000)
end
clear cs h
[cs,h]=contour(x,y,w_tot_c,[-100:cranges(mm,4):-cranges(mm,4)],'k--','linewidth',2);
if any(cs)
    clabel(cs,h,'LabelSpacing',1000)
end

dd=['-2';'  ';'-1';'  ';' 0';'  ';' 1';'  ';' 2'];
set(gca,'xtick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2],'ytick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2]','yticklabel',dd,'xticklabel',dd,'fontsize',12,'LineWidth',3,'fontweight','bold','TickLength',[.01 .01],'layer','top')

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

% ylabel(tit,'fontsize',12,'fontweight','bold') 

box
box
% 
%w_add_cc

ax=subplot(424);
tit='Current+SST Pumping';
set(ax,'units','inches','position',[ofst+xspan+dx ofst2-dy-xspan xspan xspan],'linewidth',1.5)
pcolor(x,y,w_cur_c+w_sst_c);shading interp;colormap(bwr);
caxis([-cranges(mm,3) cranges(mm,3)])
hold on
[cs,h]=contour(x,y,w_cur_c+w_sst_c,[cranges(mm,4):cranges(mm,4):100],'k','linewidth',2);
if any(cs)
    clabel(cs,h,'LabelSpacing',1000)
end
clear cs h
[cs,h]=contour(x,y,w_cur_c+w_sst_c,[-100:cranges(mm,4):-cranges(mm,4)],'k--','linewidth',2);
if any(cs)
    clabel(cs,h,'LabelSpacing',1000)
end

dd=['-2';'  ';'-1';'  ';' 0';'  ';' 1';'  ';' 2'];
set(gca,'xtick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2],'ytick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2]','yticklabel',dd,'xticklabel',dd,'fontsize',12,'LineWidth',3,'fontweight','bold','TickLength',[.01 .01],'layer','top')

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

% ylabel(tit,'fontsize',12,'fontweight','bold') 

%%w_cur_cc


box
box

ax=subplot(426);
tit='Current Pumping';
set(ax,'units','inches','position',[ofst+xspan+dx ofst2-dy-xspan-dy-xspan xspan xspan],'linewidth',1.5)
pcolor(x,y,w_cur_c);shading interp;colormap(bwr);
caxis([-cranges(mm,3) cranges(mm,3)])
hold on
[cs,h]=contour(x,y,w_cur_c,[cranges(mm,4):cranges(mm,4):100],'k','linewidth',2);
if any(cs)
    clabel(cs,h,'LabelSpacing',1000)
end
clear cs h
[cs,h]=contour(x,y,w_cur_c,[-100:cranges(mm,4):-cranges(mm,4)],'k--','linewidth',2);
if any(cs)
    clabel(cs,h,'LabelSpacing',1000)
end

dd=['-2';'  ';'-1';'  ';' 0';'  ';' 1';'  ';' 2'];
set(gca,'xtick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2],'ytick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2]','yticklabel',dd,'xticklabel',dd,'fontsize',12,'LineWidth',3,'fontweight','bold','TickLength',[.01 .01],'layer','top')

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

% ylabel(tit,'fontsize',12,'fontweight','bold') 

box
box

%%w_sst_cc

ax=subplot(428);
tit='SST Pumping';
set(ax,'units','inches','position',[ofst+xspan+dx ofst2-dy-xspan-dy-xspan-dy-xspan xspan xspan],'linewidth',1.5)
pcolor(x,y,w_sst_c);shading interp;colormap(bwr);
caxis([-cranges(mm,5) cranges(mm,5)])
hold on
[cs,h]=contour(x,y,w_sst_c,[cranges(mm,6):cranges(mm,6):100],'k','linewidth',2);
if any(cs)
    clabel(cs,h,'LabelSpacing',1000)
end
clear cs h
[cs,h]=contour(x,y,w_sst_c,[-100:cranges(mm,6):-cranges(mm,6)],'k--','linewidth',2);
if any(cs)
    clabel(cs,h,'LabelSpacing',1000)
end

dd=['-2';'  ';'-1';'  ';' 0';'  ';' 1';'  ';' 2'];
set(gca,'xtick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2],'ytick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2]','yticklabel',dd,'xticklabel',dd,'fontsize',12,'LineWidth',3,'fontweight','bold','TickLength',[.01 .01],'layer','top')

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

% ylabel(tit,'fontsize',12,'fontweight','bold') 

box
box

%%w_sst_ac

ax=subplot(524);
tit='SST Pumping';
set(ax,'units','inches','position',[ofst ofst2-dy-xspan-dy-xspan-dy-xspan xspan xspan],'linewidth',1.5)
pcolor(x,y,w_sst_a);shading interp;colormap(bwr);
caxis([-cranges(mm,5) cranges(mm,5)])
hold on
[cs,h]=contour(x,y,w_sst_a,[cranges(mm,6):cranges(mm,6):100],'k','linewidth',2);
if any(cs)
    clabel(cs,h,'LabelSpacing',1000)
end
clear cs h
[cs,h]=contour(x,y,w_sst_a,[-100:cranges(mm,6):-cranges(mm,6)],'k--','linewidth',2);
if any(cs)
    clabel(cs,h,'LabelSpacing',1000)
end

dd=['-2';'  ';'-1';'  ';' 0';'  ';' 1';'  ';' 2'];
set(gca,'xtick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2],'ytick',[-2 -1.5 -1 -.5 0 .5 1 1.5 2]','yticklabel',dd,'xticklabel',dd,'fontsize',12,'LineWidth',3,'fontweight','bold','TickLength',[.01 .01],'layer','top')

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

ylabel(tit,'fontsize',12,'fontweight','bold')
eval(['print -dpng -r300 ~/Desktop/unrotated_',curs2{mm},'_comps'])

end






