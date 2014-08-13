clear all
load chelle.pal
load bwr.pal
curs = {'new_SP',...
    'AGR',...
    'HAW',...
    'EIO',...
    'CAR',...
    'AGU',...
    'new_EIO',...
    'new_SEA',...
    'SP'};

load GAUBE_region_comps
    
    %			sst		crl	    W_E		W_Ec	W_T		W_Tc
cranges= [	.35		.4		10		2		2		.25		%SP		1
            .8		.7		35		5		15		2		%AGR	2
            .16		.5		20		5		2		.2		%HAW	3
            .4		.8		15		3		3		.5		%EIO	4
            .07		.5		35		7		3		.5   	%CAR	5
            1		1		20		5		10		1       %SEA	6
            .4		.7		12		2		2		.25     %newEIO 7
            1		1		15		2		7		1       %SEA2	8
            .3		.4		10		2		1		.25];	%old SP 9
        
        
cname={'South Pacific Ocean','Agulhas Return Current','Hawaiian Ridge','South Indian Ocean','Caribbean Sea','Southeast Atlantic Ocean'};


load region_crlstr_dtdn_coupling_coeff alpha_n
alpha_n_round=-round(10000*alpha_n)/10000;



for mm=1:6
    
ysz=10;
xsz=16;
xspan=2.5;
dx=0.3;
dy=0.5;
xofst=1.5;
yofst=6.5;


figure(1)
clf
set(gcf,'PaperPosition',[1 1 xsz ysz])
hold on

%crl and ssh
ax=subplot(361);
eval(['tmp=interp2(',curs{mm},'_crlg_a.mean);'])
eval(['tmp2=interp2(',curs{mm},'_ssh_a.mean);'])

x=linspace(-2,2,length(tmp(1,:)));
y=x';
loc_x=xofst;
set(ax,'units','inches','position',[loc_x yofst xspan xspan],'linewidth',1.5)
pcolor(x,y,tmp);shading interp;colormap(chelle);
caxis([-1e-5*cranges(mm,2) 1e-5*cranges(mm,2)]);freezeColors
hold on

[cs,h]=contour(x,y,tmp2,[-100:2:-2],'k--','linewidth',1);
if any(cs)
    clabel(cs,h,'LabelSpacing',1000)
end
clear cs h
[cs,h]=contour(x,y,tmp2,[2:2:100],'k','linewidth',1);
if any(cs)
    clabel(cs,h,'LabelSpacing',1000)
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
text(.1,2.4,'Anticyclones','HorizontalAlignment','center','fontsize',20,'color','red')
ylabel('$\zeta$ and $SSH$','HorizontalAlignment','center','fontsize',20,'interpreter','latex')
text(xspan,-2.2,'C.I. 2 cm','HorizontalAlignment','center','fontsize',12)
text(-1.85,2.3,'a)','HorizontalAlignment','center','fontsize',16,'fontweight','bold')

ax=subplot(362);
eval(['tmp=interp2(',curs{mm},'_crlg_c.mean);'])
eval(['tmp2=interp2(',curs{mm},'_ssh_c.mean);'])

x=linspace(-2,2,length(tmp(1,:)));
y=x';
loc_x=loc_x+xspan+dx;
set(ax,'units','inches','position',[loc_x yofst xspan xspan],'linewidth',1.5)
pcolor(x,y,tmp);shading interp;colormap(chelle);
caxis([-1e-5*cranges(mm,2) 1e-5*cranges(mm,2)]);freezeColors
hold on

[cs,h]=contour(x,y,tmp2,[-100:2:-1],'k--','linewidth',1);
if any(cs)
    clabel(cs,h,'LabelSpacing',100)
end
clear cs h
[cs,h]=contour(x,y,tmp2,[2:2:100],'k','linewidth',1);
if any(cs)
    clabel(cs,h,'LabelSpacing',100)
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
text(.05,2.4,'Cyclones','HorizontalAlignment','center','fontsize',20,'color','blue')
text(4,3.2,cname{mm},'HorizontalAlignment','center','fontsize',40)

ax=subplot(363);
set(ax,'visible','off')
caxis([-cranges(mm,2) cranges(mm,2)]);
cc=cbfreeze;
loc_x=loc_x+xspan+.2;
set(cc,'units','inches','position',[loc_x yofst .2 xspan],'LineWidth',1.5)
ylabel(cc,{'m s^{-1} per 100 km'},'fontsize',13,'HorizontalAlignment','center')

%w_cur
ax=subplot(364);
eval(['tmp = ',curs{mm},'_wek_total_a.mean;'])

x=linspace(-2,2,length(tmp(1,:)));
y=x';
loc_x=loc_x+dx+dx+dx+dx+dx+dx;
set(ax,'units','inches','position',[loc_x yofst xspan xspan],'linewidth',1.5)
pcolor(x,y,tmp);shading interp;colormap(bwr);
caxis([-cranges(mm,3) cranges(mm,3)]);freezeColors
hold on

[cs,h]=contour(x,y,tmp,[-100:cranges(mm,4):-cranges(mm,4)],'k--','linewidth',1);
if any(cs)
    clabel(cs,h,'LabelSpacing',100)
end
clear cs h
[cs,h]=contour(x,y,tmp,[cranges(mm,4):cranges(mm,4):100],'k','linewidth',1);
if any(cs)
    clabel(cs,h,'LabelSpacing',100)
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
text(.1,2.4,'Anticyclones','HorizontalAlignment','center','fontsize',20,'color','red')
ylabel('$W_{cur}$','HorizontalAlignment','center','fontsize',20,'interpreter','latex')
text(xspan,-2.2,['C.I. ',num2str(cranges(mm,4)),' cm day^{-1}'],'HorizontalAlignment','center','fontsize',12)
text(-1.85,2.3,'d)','HorizontalAlignment','center','fontsize',16,'fontweight','bold')


ax=subplot(365);
eval(['tmp = ',curs{mm},'_wek_total_c.mean;'])


x=linspace(-2,2,length(tmp(1,:)));
y=x';
loc_x=loc_x+xspan+dx;
set(ax,'units','inches','position',[loc_x yofst xspan xspan],'linewidth',1.5)
pcolor(x,y,tmp);shading interp;colormap(bwr);
caxis([-cranges(mm,3) cranges(mm,3)]);freezeColors
hold on

[cs,h]=contour(x,y,tmp,[-100:cranges(mm,4):-cranges(mm,4)],'k--','linewidth',1);
if any(cs)
    clabel(cs,h,'LabelSpacing',100)
end
clear cs h
[cs,h]=contour(x,y,tmp,[cranges(mm,4):cranges(mm,4):100],'k','linewidth',1);
if any(cs)
    clabel(cs,h,'LabelSpacing',100)
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
text(.05,2.4,'Cyclones','HorizontalAlignment','center','fontsize',20,'color','blue')

ax=subplot(366);
set(ax,'visible','off')
caxis([-cranges(mm,3) cranges(mm,3)]);freezeColors
cc=cbfreeze;
loc_x=loc_x+xspan+.2;
if cranges(mm,3)==35
    set(cc,'units','inches','position',[loc_x yofst .2 xspan],'LineWidth',1.5,'ytick',[-35 -15 0 15 35])
else
    set(cc,'units','inches','position',[loc_x yofst .2 xspan],'LineWidth',1.5)
end
ylabel(cc,{'cm day^{-1}'},'fontsize',13,'HorizontalAlignment','center')


%SST and ssh
ax=subplot(367);
eval(['tmp=interp2(',curs{mm},'_sst_a.mean);'])
eval(['tmp2=interp2(',curs{mm},'_ssh_a.mean);'])

x=linspace(-2,2,length(tmp(1,:)));
y=x';
yofst=yofst-xspan-dy;
loc_x=xofst;
set(ax,'units','inches','position',[loc_x yofst xspan xspan],'linewidth',1.5)
pcolor(x,y,tmp);shading interp;colormap(chelle);
caxis([-cranges(mm,1) cranges(mm,1)]);freezeColors
hold on

[cs,h]=contour(x,y,tmp2,[-100:2:-2],'k--','linewidth',1);
if any(cs)
    clabel(cs,h,'LabelSpacing',1000)
end
clear cs h
[cs,h]=contour(x,y,tmp2,[2:2:100],'k','linewidth',1);
if any(cs)
    clabel(cs,h,'LabelSpacing',1000)
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
ylabel('$SST$ and $SSH$','HorizontalAlignment','center','fontsize',20,'interpreter','latex')
text(xspan,-2.2,'C.I. 2 cm','HorizontalAlignment','center','fontsize',12)
text(-1.85,2.3,'b)','HorizontalAlignment','center','fontsize',16,'fontweight','bold')

ax=subplot(368);
eval(['tmp=interp2(',curs{mm},'_sst_c.mean);'])
eval(['tmp2=interp2(',curs{mm},'_ssh_c.mean);'])

x=linspace(-2,2,length(tmp(1,:)));
y=x';
loc_x=loc_x+xspan+dx;
set(ax,'units','inches','position',[loc_x yofst xspan xspan],'linewidth',1.5)
pcolor(x,y,tmp);shading interp;colormap(chelle);
caxis([-cranges(mm,1) cranges(mm,1)]);freezeColors
hold on

[cs,h]=contour(x,y,tmp2,[-100:2:-1],'k--','linewidth',1);
if any(cs)
    clabel(cs,h,'LabelSpacing',100)
end
clear cs h
[cs,h]=contour(x,y,tmp2,[2:2:100],'k','linewidth',1);
if any(cs)
    clabel(cs,h,'LabelSpacing',100)
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

ax=subplot(369);
set(ax,'visible','off')
caxis([-cranges(mm,1) cranges(mm,1)]);
cc=cbfreeze;
loc_x=loc_x+xspan+.2;
set(cc,'units','inches','position',[loc_x yofst .2 xspan],'LineWidth',1.5)
ylabel(cc,{'^\circ C'},'fontsize',13,'HorizontalAlignment','center')

%w_sst
ax=subplot(3,6,10);
eval(['tmp = interp2(alpha_n_round(mm).*',curs{mm},'_dtdn_a.mean);'])

x=linspace(-2,2,length(tmp(1,:)));
y=x';
loc_x=loc_x+dx+dx+dx+dx+dx+dx;
set(ax,'units','inches','position',[loc_x yofst xspan xspan],'linewidth',1.5)
pcolor(x,y,tmp);shading interp;colormap(bwr);
caxis([-cranges(mm,5) cranges(mm,5)]);freezeColors
hold on

[cs,h]=contour(x,y,tmp,[-100:cranges(mm,4):-cranges(mm,4)],'k--','linewidth',1);
if any(cs)
    clabel(cs,h,'LabelSpacing',100)
end
clear cs h
[cs,h]=contour(x,y,tmp,[cranges(mm,4):cranges(mm,4):100],'k','linewidth',1);
if any(cs)
    clabel(cs,h,'LabelSpacing',100)
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
ylabel('$W_{SST}$','HorizontalAlignment','center','fontsize',20,'interpreter','latex')
text(xspan,-2.2,['C.I. ',num2str(cranges(mm,4)),' cm day^{-1}'],'HorizontalAlignment','center','fontsize',12)
text(-1.85,2.3,'e)','HorizontalAlignment','center','fontsize',16,'fontweight','bold')


ax=subplot(3,6,11);
eval(['tmp = interp2(alpha_n_round(mm).*',curs{mm},'_dtdn_c.mean);'])


x=linspace(-2,2,length(tmp(1,:)));
y=x';
loc_x=loc_x+xspan+dx;
set(ax,'units','inches','position',[loc_x yofst xspan xspan],'linewidth',1.5)
pcolor(x,y,tmp);shading interp;colormap(bwr);
caxis([-cranges(mm,5) cranges(mm,5)]);freezeColors
hold on

[cs,h]=contour(x,y,tmp,[-100:cranges(mm,4):-cranges(mm,4)],'k--','linewidth',1);
if any(cs)
    clabel(cs,h,'LabelSpacing',100)
end
clear cs h
[cs,h]=contour(x,y,tmp,[cranges(mm,4):cranges(mm,4):100],'k','linewidth',1);
if any(cs)
    clabel(cs,h,'LabelSpacing',100)
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

ax=subplot(3,6,12);
set(ax,'visible','off')
caxis([-cranges(mm,5) cranges(mm,5)]);freezeColors
cc=cbfreeze;
loc_x=loc_x+xspan+.2;
set(cc,'units','inches','position',[loc_x yofst .2 xspan],'LineWidth',1.5)
ylabel(cc,{'cm day^{-1}'},'fontsize',13,'HorizontalAlignment','center')


%W_tot
ax=subplot(3,6,13);
eval(['tmp=interp2(',curs{mm},'_wek_total_qscat_a.mean);'])

x=linspace(-2,2,length(tmp(1,:)));
y=x';
yofst=yofst-xspan-dy;
loc_x=xofst;
set(ax,'units','inches','position',[loc_x yofst xspan xspan],'linewidth',1.5)
pcolor(x,y,tmp);shading interp;colormap(bwr);
caxis([-cranges(mm,3) cranges(mm,3)]);freezeColors
hold on

[cs,h]=contour(x,y,tmp,[-100:cranges(mm,4):-cranges(mm,4)],'k--','linewidth',1);
if any(cs)
    clabel(cs,h,'LabelSpacing',100)
end
clear cs h
[cs,h]=contour(x,y,tmp,[cranges(mm,4):cranges(mm,4):100],'k','linewidth',1);
if any(cs)
    clabel(cs,h,'LabelSpacing',100)
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
text(xspan,-2.5,['C.I. ',num2str(cranges(mm,4)),' cm day^{-1}'],'HorizontalAlignment','center','fontsize',12)
text(-1.85,2.3,'c)','HorizontalAlignment','center','fontsize',16,'fontweight','bold')

ax=subplot(3,6,14);
eval(['tmp=interp2(',curs{mm},'_wek_total_qscat_c.mean);'])


x=linspace(-2,2,length(tmp(1,:)));
y=x';
loc_x=loc_x+xspan+dx;
set(ax,'units','inches','position',[loc_x yofst xspan xspan],'linewidth',1.5)
pcolor(x,y,tmp);shading interp;colormap(bwr);
caxis([-cranges(mm,3) cranges(mm,3)]);freezeColors
hold on

[cs,h]=contour(x,y,tmp,[-100:cranges(mm,4):-cranges(mm,4)],'k--','linewidth',1);
if any(cs)
    clabel(cs,h,'LabelSpacing',100)
end
clear cs h
[cs,h]=contour(x,y,tmp,[cranges(mm,4):cranges(mm,4):100],'k','linewidth',1);
if any(cs)
    clabel(cs,h,'LabelSpacing',100)
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

ax=subplot(3,6,15);
set(ax,'visible','off')
caxis([-cranges(mm,3) cranges(mm,3)]);
cc=cbfreeze;
loc_x=loc_x+xspan+.2;
if cranges(mm,3)==35
    set(cc,'units','inches','position',[loc_x yofst .2 xspan],'LineWidth',1.5,'ytick',[-35 -15 0 15 35])
else
    set(cc,'units','inches','position',[loc_x yofst .2 xspan],'LineWidth',1.5)
end
ylabel(cc,{'cm day^{-1}'},'fontsize',13,'HorizontalAlignment','center')

%w_tot_est
ax=subplot(3,6,16);
eval(['tmp=interp2(',curs{mm},'_wek_total_a.mean)+interp2(alpha_n_round(mm).*',curs{mm},'_dtdn_a.mean);'])

x=linspace(-2,2,length(tmp(1,:)));
y=x';
loc_x=loc_x+dx+dx+dx+dx+dx+dx;
set(ax,'units','inches','position',[loc_x yofst xspan xspan],'linewidth',1.5)
pcolor(x,y,tmp);shading interp;colormap(bwr);
caxis([-cranges(mm,3) cranges(mm,3)]);freezeColors
hold on

[cs,h]=contour(x,y,tmp,[-100:cranges(mm,4):-cranges(mm,4)],'k--','linewidth',1);
if any(cs)
    clabel(cs,h,'LabelSpacing',100)
end
clear cs h
[cs,h]=contour(x,y,tmp,[cranges(mm,4):cranges(mm,4):100],'k','linewidth',1);
if any(cs)
    clabel(cs,h,'LabelSpacing',100)
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
ylabel('$\tilde{W}_{tot}=W_{cur}+W_{SST}$','HorizontalAlignment','center','fontsize',20,'interpreter','latex')
text(xspan,-2.5,['C.I. ',num2str(cranges(mm,4)),' cm day^{-1}'],'HorizontalAlignment','center','fontsize',12)
text(-1.85,2.3,'f)','HorizontalAlignment','center','fontsize',16,'fontweight','bold')


ax=subplot(3,6,17);
eval(['tmp=interp2(',curs{mm},'_wek_total_c.mean)+interp2(alpha_n_round(mm).*',curs{mm},'_dtdn_c.mean);'])


x=linspace(-2,2,length(tmp(1,:)));
y=x';
loc_x=loc_x+xspan+dx;
set(ax,'units','inches','position',[loc_x yofst xspan xspan],'linewidth',1.5)
pcolor(x,y,tmp);shading interp;colormap(bwr);
caxis([-cranges(mm,3) cranges(mm,3)]);freezeColors
hold on

[cs,h]=contour(x,y,tmp,[-100:cranges(mm,4):-cranges(mm,4)],'k--','linewidth',1);
if any(cs)
    clabel(cs,h,'LabelSpacing',100)
end
clear cs h
[cs,h]=contour(x,y,tmp,[cranges(mm,4):cranges(mm,4):100],'k','linewidth',1);
if any(cs)
    clabel(cs,h,'LabelSpacing',100)
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

ax=subplot(3,6,18);
set(ax,'visible','off')
caxis([-cranges(mm,3) cranges(mm,3)]);freezeColors
cc=cbfreeze;
loc_x=loc_x+xspan+.2;
if cranges(mm,3)==35
    set(cc,'units','inches','position',[loc_x yofst .2 xspan],'LineWidth',1.5,'ytick',[-35 -15 0 15 35])
else
    set(cc,'units','inches','position',[loc_x yofst .2 xspan],'LineWidth',1.5)
end
ylabel(cc,{'cm day^{-1}'},'fontsize',13,'HorizontalAlignment','center')



eval(['print -dpng -r300 ~/Documents/Publications/gaube_chelton_sst_wind_eddies/figs/FINAL_region_comps/',curs{mm}])

end





    
    
    
    
    
    
    






