

%
%MIDLAT
% %%%%
% load tracks/midlat_tracks k x y id cyc track_jday age scale
% ii=find(track_jday>=2452427 & track_jday<=2452427+300 & age>=12);
% x=x(ii);
% y=y(ii);
% k=k(ii);
% id=id(ii);
% track_jday=track_jday(ii);
% cyc=cyc(ii);
% scale=scale(ii);
% 
% num_a=length(find(cyc==1))
% num_c=length(find(cyc==-1))
% 
% 
% %%Estimated
% 
% % [w_ek_total_a,w_ek_total_c]=comps(x,y,cyc,k,id,track_jday,scale,'hp_total_wek_est2','~/data/QuickScat/ULTI_mat5/QSCAT_30_25km_','n');
% [w_ek_bg_a,w_ek_bg_c]=comps(x,y,cyc,k,id,track_jday,scale,'background_wek_tot_est','~/data/QuickScat/ULTI_mat5/QSCAT_30_25km_','n');
% 
% save test_background_wek
load test_background_wek
figure(1)
clf
ax=subplot(121)
tmp=interp2(w_ek_bg_a.median);
x=linspace(-2,2,length(tmp(1,:)));
y=x';

loc_x=xofst;
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

ax=subplot(122)
tmp=interp2(w_ek_bg_c.median);
x=linspace(-2,2,length(tmp(1,:)));
y=x';

loc_x=xofst;
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
return




