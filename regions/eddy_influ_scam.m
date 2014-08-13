clear all
load ~/matlab/hovmuller/new_mgrad_rot_comps rot_all_bp21_chl_N_cc rot_all_bp21_chl_N_c
load bwr.pal
x=linspace(-2,2,65);
y=x;
[lon_h,lat_h]=meshgrid(x,y);

a=.2; %m
L=.9; %deg
xo=0; 
yo=0;
dist=sqrt((lon_h-xo).^2+(lat_h-yo).^2);

h=a*exp((-dist.^2)/(L^2));

[lon,lat]=meshgrid(x,y);
alpha=.32;
wind_speed=10; %ms
wind_dir=0;
comp_wek=nan(length(x),length(x),length(wind_dir));
[u_w,v_w]=pol2cart(degtorad(wind_dir),wind_speed);
ff=f_cor(30);
g = 9.81; %ms^-2
denom=1020*sqrt(abs(ff));

Az=0.014;
De=pi*sqrt(2*Az./abs(ff));
rho=1000;


sst=smoothn(double(rot_all_bp21_chl_N_c.median),10); %deg c
sst=sst./max(abs(sst(:)));
sst=2*sst;

% 
% %crlg
% u = (-g./ff).*dfdy(h,.06);
% v = (g./ff).*dfdx_abs(h,.06);
% crl=dfdx_abs(v,.06)-dfdy(u,.06);
% spd_o=sqrt(u.^2+v.^2);
% u_rel=u_w-u;
% v_rel=v_w-v;
% crl_rel=dfdx_abs(v_rel,.06)-dfdy(u_rel,.06);
% [tau_x,tau_y] = wind2stress_comp(u_rel,v_rel);
% crl_tau=dfdx_abs(tau_y,.06)-dfdy(tau_x,.06);
% w_ek=1./(1020*ff).*crl_tau.*8640000;
% 
% tt=2*h+(linspace(0,.22,length(h(:,1)))'*ones(1,length(h(1,:))));
% figure(1)
% clf
% set(gcf,'PaperPosition',[1 1 8.5 8.5])
% pcolor(x,y,tt');shading interp;colormap(bwr);caxis([-.1 .5])
% hold on
% contour(x,y,-h,[-1:.04:-.04],'k--','linewidth',2)
% dd=['-2 ';'-1 ';' 0 ';' 1 ';' 2 '];
% %set(gca,'xtick',[-2 -1 0 1 2],'ytick',[-2 -1 0 1 2]','yticklabel',dd,'fontsize',20,'LineWidth',2,'TickLength',[0 0],'layer','top')
% set(gca,'xtick',[],'ytick',[]','yticklabel',[],'fontsize',20,'LineWidth',2,'TickLength',[0 0],'layer','top')
% line([-2 2],[0 0],'color','k','LineWidth',1.5)
% line([0 0],[-2 2],'color','k','LineWidth',1.5)
% %[x,y]=cylinder(1,100);
% %plot(x(1,:),y(1,:),'k','linewidth',1.5)
% box
% axis([-2 2 -2 2])
% box
% print -dpng -r300 figs/scam_ent_cc
% 
% 
% tt=-2*h+(linspace(0,.22,length(h(:,1)))'*ones(1,length(h(1,:))));
% figure(1)
% clf
% set(gcf,'PaperPosition',[1 1 8.5 8.5])
% pcolor(x,y,tt');shading interp;colormap(bwr);caxis([-.16 .5])
% hold on
% contour(x,y,h,[.04:.04:1],'k','linewidth',2)
% dd=['-2 ';'-1 ';' 0 ';' 1 ';' 2 '];
% %set(gca,'xtick',[-2 -1 0 1 2],'ytick',[-2 -1 0 1 2]','yticklabel',dd,'fontsize',20,'LineWidth',2,'TickLength',[0 0],'layer','top')
% set(gca,'xtick',[],'ytick',[]','yticklabel',[],'fontsize',20,'LineWidth',2,'TickLength',[0 0],'layer','top')
% line([-2 2],[0 0],'color','k','LineWidth',1.5)
% line([0 0],[-2 2],'color','k','LineWidth',1.5)
% %[x,y]=cylinder(1,100);
% %plot(x(1,:),y(1,:),'k','linewidth',1.5)
% box
% axis([-2 2 -2 2])
% box
% print -dpng -r300 figs/scam_ent_ac
% 
% 
% figure(1)
% clf
% set(gcf,'PaperPosition',[1 1 8.5 8.5])
% pcolor(x,y,h);shading interp;colormap(bwr);caxis([-.2 .2])
% hold on
% contour(x,y,h,[-1:.04:-.04],'k--','linewidth',2)
% contour(x,y,-h,[-1:.04:-.04],'k--','linewidth',2)
% 
% dd=['-2 ';'-1 ';' 0 ';' 1 ';' 2 '];
% %set(gca,'xtick',[-2 -1 0 1 2],'ytick',[-2 -1 0 1 2]','yticklabel',dd,'fontsize',20,'LineWidth',2,'TickLength',[0 0],'layer','top')
% set(gca,'xtick',[],'ytick',[]','yticklabel',[],'fontsize',20,'LineWidth',2,'TickLength',[0 0],'layer','top')
% line([-2 2],[0 0],'color','k','LineWidth',1.5)
% line([0 0],[-2 2],'color','k','LineWidth',1.5)
% %[x,y]=cylinder(1,100);
% %plot(x(1,:),y(1,:),'k','linewidth',1.5)
% box
% axis([-2 2 -2 2])
% box
% print -dpng -r300 figs/scam_ints_ac
% 
% figure(1)
% clf
% set(gcf,'PaperPosition',[1 1 8.5 8.5])
% pcolor(x,y,-h);shading interp;colormap(bwr);caxis([-.2 .2])
% hold on
% contour(x,y,h,[.04:.04:1],'k','linewidth',2)
% dd=['-2 ';'-1 ';' 0 ';' 1 ';' 2 '];
% %set(gca,'xtick',[-2 -1 0 1 2],'ytick',[-2 -1 0 1 2]','yticklabel',dd,'fontsize',20,'LineWidth',2,'TickLength',[0 0],'layer','top')
% set(gca,'xtick',[],'ytick',[]','yticklabel',[],'fontsize',20,'LineWidth',2,'TickLength',[0 0],'layer','top')
% line([-2 2],[0 0],'color','k','LineWidth',1.5)
% line([0 0],[-2 2],'color','k','LineWidth',1.5)
% %[x,y]=cylinder(1,100);
% %plot(x(1,:),y(1,:),'k','linewidth',1.5)
% box
% axis([-2 2 -2 2])
% box
% print -dpng -r300 figs/scam_ints_cc
% 
% 
% figure(1)
% clf
% set(gcf,'PaperPosition',[1 1 8.5 8.5])
% pcolor(x,y,w_ek);shading interp;colormap(bwr);caxis([-30 30])
% hold on
% %contour(x,y,w_ek,[-100:4:-2],'k--','linewidth',2)
% contour(x,y,h,[.04:.04:1],'k','linewidth',2)
% dd=['-2 ';'-1 ';' 0 ';' 1 ';' 2 '];
% %set(gca,'xtick',[-2 -1 0 1 2],'ytick',[-2 -1 0 1 2]','yticklabel',dd,'fontsize',20,'LineWidth',2,'TickLength',[0 0],'layer','top')
% set(gca,'xtick',[],'ytick',[]','yticklabel',[],'fontsize',20,'LineWidth',2,'TickLength',[0 0],'layer','top')
% line([-2 2],[0 0],'color','k','LineWidth',1.5)
% line([0 0],[-2 2],'color','k','LineWidth',1.5)
% %[x,y]=cylinder(1,100);
% %plot(x(1,:),y(1,:),'k','linewidth',1.5)
% box
% axis([-2 2 -2 2])
% box
% print -dpng -r300 figs/scam_wek_ac
% 
% figure(1)
% clf
% set(gcf,'PaperPosition',[1 1 8.5 8.5])
% pcolor(x,y,-w_ek);shading interp;colormap(bwr);caxis([-30 30])
% hold on
% contour(x,y,-h,[-1:.04:-.04],'k--','linewidth',2)
% dd=['-2 ';'-1 ';' 0 ';' 1 ';' 2 '];
% %set(gca,'xtick',[-2 -1 0 1 2],'ytick',[-2 -1 0 1 2]','yticklabel',dd,'fontsize',20,'LineWidth',2,'TickLength',[0 0],'layer','top')
% set(gca,'xtick',[],'ytick',[]','yticklabel',[],'fontsize',20,'LineWidth',2,'TickLength',[0 0],'layer','top')
% line([-2 2],[0 0],'color','k','LineWidth',1.5)
% line([0 0],[-2 2],'color','k','LineWidth',1.5)
% %[x,y]=cylinder(1,100);
% %plot(x(1,:),y(1,:),'k','linewidth',1.5)
% box
% axis([-2 2 -2 2])
% box
% print -dpng -r300 figs/scam_wek_cc


sst=smoothn(double(rot_all_bp21_chl_N_cc.median),10); %deg c
sst=sst./max(abs(sst(:)));
sst=(2*sst)+(9*h);

sst=-flipud(sst);

figure(1)
clf
set(gcf,'PaperPosition',[1 1 8.5 8.5])
pcolor(x,y,sst);shading interp;colormap(bwr);caxis([-1.4 2])
hold on
contour(x,y,h,[.04:.04:1],'k','linewidth',2)
dd=['-2 ';'-1 ';' 0 ';' 1 ';' 2 '];
%set(gca,'xtick',[-2 -1 0 1 2],'ytick',[-2 -1 0 1 2]','yticklabel',dd,'fontsize',20,'LineWidth',2,'TickLength',[0 0],'layer','top')
set(gca,'xtick',[],'ytick',[]','yticklabel',[],'fontsize',20,'LineWidth',2,'TickLength',[0 0],'layer','top')
line([-2 2],[0 0],'color','k','LineWidth',1.5)
line([0 0],[-2 2],'color','k','LineWidth',1.5)
%[x,y]=cylinder(1,100);
%plot(x(1,:),y(1,:),'k','linewidth',1.5)
box
axis([-2 2 -2 2])
box
print -dpng -r300 figs/scam_az_ac


sst=smoothn(double(rot_all_bp21_chl_N_cc.median),10); %deg c
sst=sst./max(abs(sst(:)));
sst=2*sst+(9*h);

figure(1)
clf
set(gcf,'PaperPosition',[1 1 8.5 8.5])
pcolor(x,y,sst);shading interp;colormap(bwr);caxis([-1.6 2])
hold on
contour(x,y,-h,[-1:.04:-.04],'k--','linewidth',2)
dd=['-2 ';'-1 ';' 0 ';' 1 ';' 2 '];
%set(gca,'xtick',[-2 -1 0 1 2],'ytick',[-2 -1 0 1 2]','yticklabel',dd,'fontsize',20,'LineWidth',2,'TickLength',[0 0],'layer','top')
set(gca,'xtick',[],'ytick',[]','yticklabel',[],'fontsize',20,'LineWidth',2,'TickLength',[0 0],'layer','top')
line([-2 2],[0 0],'color','k','LineWidth',1.5)
line([0 0],[-2 2],'color','k','LineWidth',1.5)
%[x,y]=cylinder(1,100);
%plot(x(1,:),y(1,:),'k','linewidth',1.5)
box
axis([-2 2 -2 2])
box
print -dpng -r300 figs/scam_az_cc
