clear all
load bwr.pal
load chelle.pal

load midlat_comps bp26_sst*
x=1000*[-400:10:400];
y=1000*[-400:10:400];
sst_x=1000*100*linspace(-2,2,65);
sst_y=sst_x;
[lon,lat]=meshgrid(x,y);
[sst_lon,sst_lat]=meshgrid(sst_x,sst_y);

real_lat=(lat./1000./111.11);
real_lon=(lon./1000./111.11);
real_lat=lat./1000./100;
real_lon=lon./1000./100;
a=[.22 .1 .03]; %m
L=100e3; %m
alpha=0.48;
xo=0; 
yo=0;
dist=sqrt((lon-xo).^2+(lat-yo).^2);
scale_sst=[0.8];
wind_speed=7; %ms
ff=f_cor(-30);
g = 9.81; %ms^-2

sst=smoothn(double(bp26_sst_N_cc.mean),5); %deg c
sst=sst./max(abs(sst(:)));
sst=interp2(sst_x,sst_y,sst,lon,lat,'linear');

for m=1%:length(a)
wind_dir=0;
[u_w,v_w]=pol2cart(degtorad(wind_dir),wind_speed);
h=a(m)*exp((-dist.^2)/(L^2));
sst=scale_sst(m).*sst;

%crlg
u = (-g./ff).*dfdy_m(h,10000);
v = (g./ff).*dfdx_m(h,10000);
u_rel=u_w-u;
v_rel=v_w-v;
[tau_x,tau_y] = wind2stress_comp(u_rel,v_rel);
dtydx=dfdx_m(tau_y,10000);
dtxdy=dfdy_m(tau_x,10000);
dvdx=dfdx_m(v,10000);
dudy=dfdy_m(u,10000);
crl_tau=dtydx-dtxdy;
crl=dvdx-dudy;
w_ek=1./(1020*(ff+crl)).*crl_tau.*8640000;
sum_wek.max_wek_c(m)=max(w_ek(:))
sum_wek.min_wek_c(m)=min(w_ek(:))
%sst easterly
dtdx=dfdx_m(sst,10000);
dtdy=dfdy_m(sst,10000);
dtdn = single(-sind(wind_dir).*dtdx + cosd(wind_dir).*dtdy);
dtds = single(cosd(wind_dir).*dtdx + sind(wind_dir).*dtdy);
theta=cart2pol(u_w,v_w);
[u_sst,v_sst]=pol2cart(theta,alpha*sst);
u_rel_t=u_w+20*u_sst;
v_rel_t=v_w+20*v_sst;
[tau_xt,tau_yt] = wind2stress_comp(u_w+u_sst,v_w+v_sst);
dtydx=dfdx_m(tau_yt,10000);
dtxdy=dfdy_m(tau_xt,10000);
crl_tau=dtydx-dtxdy;
w_ek_esst=1./(1020*(ff)).*crl_tau.*8640000;
%w_ek_sst=(-.01.*dtdn+(-.01*.2).*dtds).*8640000./(1020*ff);
sum_wek.max_wek_esst(m)=max(w_ek_esst(:))
sum_wek.min_wek_esst(m)=min(w_ek_esst(:))

uw=u_w*ones(size(h));
vw=v_w*ones(size(h));

fsst=interp2(zgrid(real_lon,real_lat,0,0,double(sst),L/1000),'linear');
crl=interp2(zgrid(real_lon,real_lat,0,0,double(crl),L/1000),'linear');
ssh=interp2(zgrid(real_lon,real_lat,0,0,double(h),L/1000),'linear');

u_rel=interp2(zgrid(real_lon,real_lat,0,0,double(u_w-10*u),L/1000),'linear');
v_rel=interp2(zgrid(real_lon,real_lat,0,0,double(v_w-10*v),L/1000),'linear');
u_rel_t=interp2(zgrid(real_lon,real_lat,0,0,double(u_rel_t),L/1000),'linear');
v_rel_t=interp2(zgrid(real_lon,real_lat,0,0,double(v_rel_t),L/1000),'linear');
u=interp2(zgrid(real_lon,real_lat,0,0,double(10*u),L/1000),'linear');
v=interp2(zgrid(real_lon,real_lat,0,0,double(10*v),L/1000),'linear');
uw=interp2(zgrid(real_lon,real_lat,0,0,double(uw),L/1000),'linear');
vw=interp2(zgrid(real_lon,real_lat,0,0,double(vw),L/1000),'linear');
ut=interp2(zgrid(real_lon,real_lat,0,0,double(10*u_sst),L/1000),'linear');
vt=interp2(zgrid(real_lon,real_lat,0,0,double(10*v_sst),L/1000),'linear');
tx=interp2(zgrid(real_lon,real_lat,0,0,double(tau_x),L/1000),'linear');
ty=interp2(zgrid(real_lon,real_lat,0,0,double(tau_y),L/1000),'linear');

w_ek_esst=interp2(zgrid(real_lon,real_lat,0,0,double(w_ek_esst),L/1000),'linear');
w_ek=interp2(zgrid(real_lon,real_lat,0,0,double(w_ek),L/1000),'linear');

zgrid_grid
xi=interp2(xi);
yi=interp2(yi);
figure(1)
clf
set(gcf,'PaperPosition',[1 1 8.5 8.5])
pcolor(xi,yi,nan*w_ek);shading interp;axis image
hold on
quiver(xi(5:5:end-5,5:5:end-5),yi(5:5:end-5,5:5:end-5),u_rel(5:5:end-5,5:5:end-5),v_rel(5:5:end-5,5:5:end-5),...
'color','k','linewidth',2)
dd=['-2 ';'-1 ';' 0 ';' 1 ';' 2 '];
title('$\textbf{u}_{rel}$','fontsize',30,'fontweight','bold','Interpreter','latex')
drawnow
box
set(gca,'xtick',[-2 -1 0 1 2],'ytick',[-2 -1 0 1 2]','yticklabel',dd,'fontsize',20,'fontweight','bold',...
'LineWidth',2,'TickLength',[0 0],'layer','top')
line([-2 2],[0 0],'color','k','LineWidth',1.5)
line([0 0],[-2 2],'color','k','LineWidth',1.5)
[x,y]=cylinder(1,100);
plot(x(1,:),y(1,:),'k','linewidth',1.5)
box
print -dpng -r300 figs/vec_scam_u_rel

%{
clf
pcolor(xi,yi,1e5*crl);shading interp;axis image
hold on
colormap(chelle)
caxis([-1 1])
title('$\nabla \times \textbf{u}_o$','fontsize',30,'fontweight','bold','Interpreter','latex')
drawnow
box
set(gca,'xtick',[-2 -1 0 1 2],'ytick',[-2 -1 0 1 2]','yticklabel',dd,'fontsize',20,'fontweight','bold',...
'LineWidth',2,'TickLength',[0 0],'layer','top')
line([-2 2],[0 0],'color','k','LineWidth',1.5)
line([0 0],[-2 2],'color','k','LineWidth',1.5)
plot(x(1,:),y(1,:),'k','linewidth',1.5)
box
print -dpng -r300 figs/vec_scam_crlg

clf
pcolor(xi,yi,-1e5*crl);shading interp;axis image
hold on
colormap(chelle)
caxis([-1 1])
title('$\nabla \times \textbf{u}_{rel}$','fontsize',30,'fontweight','bold','Interpreter','latex')
drawnow
box
set(gca,'xtick',[-2 -1 0 1 2],'ytick',[-2 -1 0 1 2]','yticklabel',dd,'fontsize',20,'fontweight','bold',...
'LineWidth',2,'TickLength',[0 0],'layer','top')
line([-2 2],[0 0],'color','k','LineWidth',1.5)
line([0 0],[-2 2],'color','k','LineWidth',1.5)
plot(x(1,:),y(1,:),'k','linewidth',1.5)
box
print -dpng -r300 figs/vec_scam_crl_rel

clf
pcolor(xi,yi,nan*w_ek);shading interp;axis image
hold on
quiver(xi(5:5:end-5,5:5:end-5),yi(5:5:end-5,5:5:end-5),u(5:5:end-5,5:5:end-5),v(5:5:end-5,5:5:end-5),...
'color','k','linewidth',2)
title('$\textbf{u}_{o}$','fontsize',30,'fontweight','bold','Interpreter','latex')
drawnow
box
set(gca,'xtick',[-2 -1 0 1 2],'ytick',[-2 -1 0 1 2]','yticklabel',dd,'fontsize',20,'fontweight','bold',...
'LineWidth',2,'TickLength',[0 0],'layer','top')
line([-2 2],[0 0],'color','k','LineWidth',1.5)
line([0 0],[-2 2],'color','k','LineWidth',1.5)
plot(x(1,:),y(1,:),'k','linewidth',1.5)
box
print -dpng -r300 figs/vec_scam_u_o

clf
pcolor(xi,yi,nan*w_ek);shading interp;axis image
hold on
quiver(xi(5:5:end-5,5:5:end-5),yi(5:5:end-5,5:5:end-5),uw(5:5:end-5,5:5:end-5),vw(5:5:end-5,5:5:end-5),.5,...
'color','k','linewidth',2)
title('$\textbf{u}_{a}$','fontsize',30,'fontweight','bold','Interpreter','latex')
drawnow
box
set(gca,'xtick',[-2 -1 0 1 2],'ytick',[-2 -1 0 1 2]','yticklabel',dd,'fontsize',20,'fontweight','bold',...
'LineWidth',2,'TickLength',[0 0],'layer','top')
line([-2 2],[0 0],'color','k','LineWidth',1.5)
line([0 0],[-2 2],'color','k','LineWidth',1.5)
box
print -dpng -r300 figs/vec_scam_u_w

clf
pcolor(xi,yi,w_ek);shading interp;axis image
colormap(bwr)
caxis([-20 20])
hold on
contour(xi,yi,w_ek,[-100:2:-1],'k--','LineWidth',1.5)
contour(xi,yi,w_ek,[1:2:100],'k','LineWidth',1.5)
quiver(xi(5:5:end-5,5:5:end-5),yi(5:5:end-5,5:5:end-5),u_rel(5:5:end-5,5:5:end-5),v_rel(5:5:end-5,5:5:end-5),...
'color','k','linewidth',2)
title('$W_{E}$','fontsize',30,'fontweight','bold','Interpreter','latex')
drawnow
box
set(gca,'xtick',[-2 -1 0 1 2],'ytick',[-2 -1 0 1 2]','yticklabel',dd,'fontsize',20,'fontweight','bold',...
'LineWidth',2,'TickLength',[0 0],'layer','top')
line([-2 2],[0 0],'color','k','LineWidth',1.5)
line([0 0],[-2 2],'color','k','LineWidth',1.5)
%plot(x(1,:),y(1,:),'k','linewidth',1.5)
box
print -dpng -r300 figs/vec_scam_wek
%}
clf
pcolor(xi,yi,w_ek);shading interp;axis image
load craig_bwr.pal
colormap(craig_bwr)
caxis([-50 50])
hold on
contour(xi,yi,w_ek,[-100:2:-1],'k--','LineWidth',1.5)
contour(xi,yi,w_ek,[1:2:100],'k','LineWidth',1.5)
%quiver(xi(5:5:end-5,5:5:end-5),yi(5:5:end-5,5:5:end-5),u_rel(5:5:end-5,5:5:end-5),v_rel(5:5:end-5,5:5:end-5),...
%'color','k','linewidth',2)
title('$W_{E}$ anticyclones','fontsize',30,'fontweight','bold','Interpreter','latex')
drawnow
box
set(gca,'xtick',[-2 -1 0 1 2],'ytick',[-2 -1 0 1 2]','yticklabel',dd,'fontsize',20,'fontweight','bold',...
'LineWidth',2,'TickLength',[0 0],'layer','top')
line([-2 2],[0 0],'color','k','LineWidth',1.5)
line([0 0],[-2 2],'color','k','LineWidth',1.5)
%plot(x(1,:),y(1,:),'k','linewidth',1.5)
box
print -dpng -r300 figs/vec_scam_wek_50

clf
pcolor(xi,yi,-w_ek);shading interp;axis image
load craig_bwr.pal
colormap(craig_bwr)
caxis([-50 50])
hold on
contour(xi,yi,w_ek,[-100:2:-1],'k--','LineWidth',1.5)
contour(xi,yi,w_ek,[1:2:100],'k','LineWidth',1.5)
%quiver(xi(5:5:end-5,5:5:end-5),yi(5:5:end-5,5:5:end-5),u_rel(5:5:end-5,5:5:end-5),v_rel(5:5:end-5,5:5:end-5),...
%'color','k','linewidth',2)
title('$W_{E}$ cyclones','fontsize',30,'fontweight','bold','Interpreter','latex')
drawnow
box
set(gca,'xtick',[-2 -1 0 1 2],'ytick',[-2 -1 0 1 2]','yticklabel',dd,'fontsize',20,'fontweight','bold',...
'LineWidth',2,'TickLength',[0 0],'layer','top')
line([-2 2],[0 0],'color','k','LineWidth',1.5)
line([0 0],[-2 2],'color','k','LineWidth',1.5)
%plot(x(1,:),y(1,:),'k','linewidth',1.5)
box
print -dpng -r300 figs/vec_scam_wek_cycl_50

return

%%%%%
%SST
%%%%%
clf
pcolor(xi,yi,fsst);shading interp;axis image
hold on
colormap(chelle)
caxis([-.8 .8])
contour(xi,yi,fsst,[-1:.1:-.1],'k--','LineWidth',1.5)
contour(xi,yi,fsst,[.1:.1:1],'k','LineWidth',1.5)
title('$SST anomaly$','fontsize',30,'fontweight','bold','Interpreter','latex')
drawnow
box
set(gca,'xtick',[-2 -1 0 1 2],'ytick',[-2 -1 0 1 2]','yticklabel',dd,'fontsize',20,'fontweight','bold',...
'LineWidth',2,'TickLength',[0 0],'layer','top')
line([-2 2],[0 0],'color','k','LineWidth',1.5)
line([0 0],[-2 2],'color','k','LineWidth',1.5)
[x,y]=cylinder(1,100);
plot(x(1,:),y(1,:),'k','linewidth',1.5)
box
print -dpng -r300 figs/vec_scam_sst


clf
pcolor(xi,yi,nan*w_ek);shading interp;axis image
hold on
quiver(xi(5:5:end-5,5:5:end-5),yi(5:5:end-5,5:5:end-5),ut(5:5:end-5,5:5:end-5),vt(5:5:end-5,5:5:end-5),.5,...
'color','k','linewidth',2)
title('$\textbf{u}_{sst}$','fontsize',30,'fontweight','bold','Interpreter','latex')
drawnow
box
set(gca,'xtick',[-2 -1 0 1 2],'ytick',[-2 -1 0 1 2]','yticklabel',dd,'fontsize',20,'fontweight','bold',...
'LineWidth',2,'TickLength',[0 0],'layer','top')
line([-2 2],[0 0],'color','k','LineWidth',1.5)
line([0 0],[-2 2],'color','k','LineWidth',1.5)
[x,y]=cylinder(1,100);
plot(x(1,:),y(1,:),'k','linewidth',1.5)
box
print -dpng -r300 figs/vec_scam_u_sst

clf
pcolor(xi,yi,nan*w_ek);shading interp;axis image
hold on
quiver(xi(5:5:end-5,5:5:end-5),yi(5:5:end-5,5:5:end-5),u_rel_t(5:5:end-5,5:5:end-5),v_rel_t(5:5:end-5,5:5:end-5),.5,...
'color','k','linewidth',2)
title('$\textbf{u}_{w}+\textbf{u}_{sst}$','fontsize',30,'fontweight','bold','Interpreter','latex')
drawnow
box
set(gca,'xtick',[-2 -1 0 1 2],'ytick',[-2 -1 0 1 2]','yticklabel',dd,'fontsize',20,'fontweight','bold',...
'LineWidth',2,'TickLength',[0 0],'layer','top')
line([-2 2],[0 0],'color','k','LineWidth',1.5)
line([0 0],[-2 2],'color','k','LineWidth',1.5)
[x,y]=cylinder(1,100);
plot(x(1,:),y(1,:),'k','linewidth',1.5)
box
print -dpng -r300 figs/vec_scam_u_sst_u_w

clf
pcolor(xi,yi,w_ek_esst);shading interp;axis image
hold on
colormap(bwr)
caxis([-20 20])
contour(xi,yi,w_ek_esst,[-100:2:-1],'k--','LineWidth',1.5)
contour(xi,yi,w_ek_esst,[1:2:100],'k','LineWidth',1.5)
quiver(xi(5:5:end-5,5:5:end-5),yi(5:5:end-5,5:5:end-5),u_rel_t(5:5:end-5,5:5:end-5),v_rel_t(5:5:end-5,5:5:end-5),.5,...
'color','k','linewidth',2)
title('$W_{E}$ from SST','fontsize',30,'fontweight','bold','Interpreter','latex')
drawnow
box
set(gca,'xtick',[-2 -1 0 1 2],'ytick',[-2 -1 0 1 2]','yticklabel',dd,'fontsize',20,'fontweight','bold',...
'LineWidth',2,'TickLength',[0 0],'layer','top')
line([-2 2],[0 0],'color','k','LineWidth',1.5)
line([0 0],[-2 2],'color','k','LineWidth',1.5)
[x,y]=cylinder(1,100);
plot(x(1,:),y(1,:),'k','linewidth',1.5)
box
print -dpng -r300 figs/vec_scam_wek_sst
end
