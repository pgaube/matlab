clear all
load ULTI_wind_SH_comps w*
load bwr.pal

xsz=11;
ysz=8.5
xspan=2.5;
dx=0.5; 
ofst=1.25;
ofst2=4.5;
%the bottom left corner of the
%upper left panel is at 1.25 and 4.5 inches 
%from the lower left corner of an assumed 8.5 x 11 inch page.

imag=double(interp2(w_ek_total_a.mean));
x=linspace(-2,2,length(imag(1,:)));
y=x';

figure(1)
clf
set(gcf,'PaperPosition',[1 1 xsz ysz])

%%w_tot_ac
imag=double(interp2(w_ek_total_qscat_a.mean));
tit=['W_{tot} AC N=',num2str(w_ek_sst_fixed_a.n_max_sample)];
ax=subplot(231);
set(ax,'units','inches','position',[ofst ofst2 xspan xspan],'linewidth',1.5)
pcolor(x,y,imag);shading interp;colormap(bwr);
caxis([-10 10])
hold on
[cs,h]=contour(x,y,imag,[1:1:100],'k','linewidth',2);
if any(cs)
    clabel(cs,h,'LabelSpacing',1000)
end
clear cs h
[cs,h]=contour(x,y,imag,[-100:1:-1],'k--','linewidth',2);
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

text(-1.95,2.18,tit,'fontsize',12,'fontweight','bold') 

box
box

%%w_cur_ac
imag=double(interp2(w_ek_total_a.mean));
tit=['W_{cur} AC N=',num2str(w_ek_sst_fixed_a.n_max_sample)];

ax=subplot(232);
set(ax,'units','inches','position',[ofst+xspan+dx ofst2 xspan xspan],'linewidth',1.5)
pcolor(x,y,imag);shading interp;colormap(bwr);
caxis([-10 10])
hold on
[cs,h]=contour(x,y,imag,[1:1:100],'k','linewidth',2);
if any(cs)
    clabel(cs,h,'LabelSpacing',1000)
end
clear cs h
[cs,h]=contour(x,y,imag,[-100:1:-1],'k--','linewidth',2);
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

text(-1.95,2.18,tit,'fontsize',12,'fontweight','bold') 

box
box

%%w_sst_ac
imag=double(interp2((.013/.01)*w_ek_sst_fixed_a.mean));
tit=['W_{SST} AC N=',num2str(w_ek_sst_fixed_a.n_max_sample)];

ax=subplot(233);
set(ax,'units','inches','position',[ofst+xspan+dx+xspan+dx ofst2 xspan xspan],'linewidth',1.5)
pcolor(x,y,imag);shading interp;colormap(bwr);
caxis([-1 1])
hold on
[cs,h]=contour(x,y,imag,[.1:.1:100],'k','linewidth',2);
if any(cs)
    clabel(cs,h,'LabelSpacing',1000)
end
clear cs h
[cs,h]=contour(x,y,imag,[-100:.1:-.1],'k--','linewidth',2);
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

text(-1.95,2.18,tit,'fontsize',12,'fontweight','bold') 

box
box

%%w_tot_ac
imag=double(interp2(w_ek_total_qscat_c.mean));
tit=['W_{tot} CC N=',num2str(w_ek_sst_fixed_c.n_max_sample)];
ax=subplot(232);
set(ax,'units','inches','position',[ofst ofst2-dx-xspan xspan xspan],'linewidth',1.5)
pcolor(x,y,imag);shading interp;colormap(bwr);
caxis([-10 10])
hold on
[cs,h]=contour(x,y,imag,[1:1:100],'k','linewidth',2);
if any(cs)
    clabel(cs,h,'LabelSpacing',1000)
end
clear cs h
[cs,h]=contour(x,y,imag,[-100:1:-1],'k--','linewidth',2);
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

text(-1.95,2.18,tit,'fontsize',12,'fontweight','bold') 

box
box

%%w_cur_ac
imag=double(interp2(w_ek_total_c.mean));
tit=['W_{cur} CC N=',num2str(w_ek_sst_fixed_c.n_max_sample)];

ax=subplot(235);
set(ax,'units','inches','position',[ofst+xspan+dx ofst2-dx-xspan xspan xspan],'linewidth',1.5)
pcolor(x,y,imag);shading interp;colormap(bwr);
caxis([-10 10])
hold on
[cs,h]=contour(x,y,imag,[1:1:100],'k','linewidth',2);
if any(cs)
    clabel(cs,h,'LabelSpacing',1000)
end
clear cs h
[cs,h]=contour(x,y,imag,[-100:1:-1],'k--','linewidth',2);
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

text(-1.95,2.18,tit,'fontsize',12,'fontweight','bold') 

box
box

%%w_sst_ac
imag=double(interp2((.013/.01)*w_ek_sst_fixed_c.mean));
tit=['W_{SST} CC N=',num2str(w_ek_sst_fixed_c.n_max_sample)];

ax=subplot(236);
set(ax,'units','inches','position',[ofst+xspan+dx+xspan+dx ofst2-dx-xspan xspan xspan],'linewidth',1.5)
pcolor(x,y,imag);shading interp;colormap(bwr);
caxis([-1 1])
hold on
[cs,h]=contour(x,y,imag,[.1:.1:100],'k','linewidth',2);
if any(cs)
    clabel(cs,h,'LabelSpacing',1000)
end
clear cs h
[cs,h]=contour(x,y,imag,[-100:.1:-.1],'k--','linewidth',2);
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

text(-1.95,2.18,tit,'fontsize',12,'fontweight','bold') 

box
box
text(-7,8,'GAUBE SH ROTATED')

print -dpng -r300 /Users/new_gaube/Documents/Publications/gaube_chelton_sst_wind_eddies/figs/schalx_compare/gaube_final_figs/GAUBE_wind_SH_comps
