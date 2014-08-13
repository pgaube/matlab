clear all
load bwr.pal

% load ULTI_wind_NH_comps

ysz=16;
xsz=13;
xspan=2.5;
dx=0.3;
dy=0.3;
xofst=1.5;
yofst=11;



figure(1)
clf
set(gcf,'PaperPosition',[1 1 xsz ysz])
hold on


load FIANL_sst_midlat_rot_comps sst_*
x=1000*[-500:10:500];
y=1000*[-500:10:500];
sst_x=1000*100*linspace(-2,2,33);
sst_y=sst_x;
[lon,lat]=meshgrid(x,y);
[sst_lon,sst_lat]=meshgrid(sst_x,sst_y);

real_lat=30+(lat./1000./111.11);
real_lon=30+(lon./1000./111.11);

a=[.145]; %m
L=75e3; %m
Ls=90e3;
alpha=0.48;
xo=0; 
yo=0;
dist=sqrt((lon-xo).^2+(lat-yo).^2);
scale_sst=[0.3];
wind_speed=7; %ms
[ff,bb]=f_cor(30);
g = 9.81; %ms^-2

sst=smoothn(double(sst_c.S_mean),20); %deg c
sst=sst./max(abs(sst(:)));
% sst=flipud(interp2(sst_x,sst_y,sst,lon,lat,'linear'));
sst=(interp2(sst_x,sst_y,sst,lon,lat,'linear'));

h=a*exp((-dist.^2)/(2*L^2));
sst=scale_sst.*sst;

%We currents westerly wind
wind_dir=0;
wind_dir_sst=180;
[u_w,v_w]=pol2cart(degtorad(wind_dir),wind_speed);

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
dcdy=dfdy_m(crl,10000);
dcdx=dfdx_m(crl,10000);
wl_e=1./(1020*(ff+crl)).*crl_tau.*8640000;
wn_e=(1/1020)*(1./(ff+crl).^2).*((tau_x.*dcdy)-(tau_y.*dcdx)).*8640000;
wb_e=(1/1020)*(1./(ff+crl).^2).*(tau_x.*bb).*8640000;
w_ek_e=wl_e+wn_e;

%sst westerly
dtdx=dfdx_m(sst,10000);
dtdy=dfdy_m(sst,10000);
dtdn = single(-sind(wind_dir_sst).*dtdx + cosd(wind_dir_sst).*dtdy);

w_ek_esst=(.013.*dtdn).*8640000./(1020*ff+crl);

%We currents southerly wind
wind_dir=90;
wind_dir_sst=270;
[u_w,v_w]=pol2cart(degtorad(wind_dir),wind_speed);
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
dcdy=dfdy_m(crl,10000);
dcdx=dfdx_m(crl,10000);
wl_n=1./(1020*(ff+crl)).*crl_tau.*8640000;
wn_n=(1/1020)*(1./(ff+crl).^2).*((tau_x.*dcdy)-(tau_y.*dcdx)).*8640000;
wb_n=(1/1020)*(1./(ff+crl).^2).*(tau_x.*bb).*8640000;

w_ek_n=wl_n+wn_n;


%sst northerly
dtdx=dfdx_m(sst,10000);
dtdy=dfdy_m(sst,10000);
dtdn = single(-sind(wind_dir_sst).*dtdx + cosd(wind_dir_sst).*dtdy);

w_ek_nsst=(.013.*dtdn).*8640000./(1020*ff+crl);

fsst=(zgrid_abs(real_lon,real_lat,30,30,double(sst),Ls/1000));
crl=(zgrid_abs(real_lon,real_lat,30,30,double(crl),Ls/1000));
ssh=(zgrid_abs(real_lon,real_lat,30,30,double(h),Ls/1000));

w_ek_nsst=(zgrid_abs(real_lon,real_lat,30,30,double(w_ek_nsst),Ls/1000));
w_ek_esst=(zgrid_abs(real_lon,real_lat,30,30,double(w_ek_esst),Ls/1000));
w_ek_e=(zgrid_abs(real_lon,real_lat,30,30,double(w_ek_e),Ls/1000));
w_ek_n=(zgrid_abs(real_lon,real_lat,30,30,double(w_ek_n),Ls/1000));

w_ek_c_e=(zgrid_abs(real_lon,real_lat,30,30,double(wl_e),Ls/1000));
w_ek_c_n=(zgrid_abs(real_lon,real_lat,30,30,double(wl_n),Ls/1000));
w_ek_z_e=(zgrid_abs(real_lon,real_lat,30,30,double(wn_e),Ls/1000));
w_ek_z_n=(zgrid_abs(real_lon,real_lat,30,30,double(wn_n),Ls/1000));
w_ek_b_e=(zgrid_abs(real_lon,real_lat,30,30,double(wb_e),Ls/1000));
w_ek_b_n=(zgrid_abs(real_lon,real_lat,30,30,double(wb_n),Ls/1000));



%%anticyclones
ax=subplot(641);
tmp=interp2(w_ek_esst);
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
ylabel('Westerly wind','HorizontalAlignment','center','fontsize',20)
text(-1.5,2.3,'$a) \ W_{SST \ }$','HorizontalAlignment','center','fontsize',20,'interpreter','latex')
text(-3.7,-2.4,'Anticyclone','HorizontalAlignment','center','fontsize',30,'color','r','Rotation',90)

loc_x=loc_x+xspan+dx;

ax=subplot(642);
tmp=interp2(w_ek_c_e);
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
text(2.4,4,'Ekman Pumping in Idealized Northern Hemisphere Eddies','HorizontalAlignment','center','fontsize',30)
text(-1.5,2.3,'$b) \ W_{c}$','HorizontalAlignment','center','fontsize',20,'interpreter','latex')



%%W_sst noro
loc_x=loc_x+xspan+dx;

ax=subplot(643);
tmp=interp2(w_ek_z_e);
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
text(-1.5,2.3,'$c) \ W_{\zeta}$','HorizontalAlignment','center','fontsize',20,'interpreter','latex')


loc_x=loc_x+xspan+dx;

ax=subplot(644);
tmp=interp2(w_ek_e);
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
text(-1.5,2.3,'$d) \ W_{cur}$','HorizontalAlignment','center','fontsize',20,'interpreter','latex')

yofst=yofst-xspan-dy;


ax=subplot(645);
tmp=interp2(w_ek_nsst);
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
ylabel('Poleward wind','HorizontalAlignment','center','fontsize',20)

loc_x=loc_x+xspan+dx;

ax=subplot(646);
tmp=interp2(w_ek_c_n);
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



%%W_sst noro
loc_x=loc_x+xspan+dx;

ax=subplot(647);
tmp=interp2(w_ek_z_n);
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


loc_x=loc_x+xspan+dx;

ax=subplot(648);
tmp=interp2(w_ek_n);
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



a=[-.14]; %m
alpha=0.48;
xo=0; 
yo=0;
dist=sqrt((lon-xo).^2+(lat-yo).^2);
scale_sst=[0.3];
wind_speed=7; %ms
[ff,bb]=f_cor(30);
g = 9.81; %ms^-2

sst=smoothn(double(sst_cc.S_mean),20); %deg c
sst=sst./max(abs(sst(:)));
% sst=flipud(interp2(sst_x,sst_y,sst,lon,lat,'linear'));
sst=(interp2(sst_x,sst_y,sst,lon,lat,'linear'));

h=a*exp((-dist.^2)/(2*L^2));
sst=scale_sst.*sst;

%We currents westerly wind
wind_dir=0;
wind_dir_sst=180;
[u_w,v_w]=pol2cart(degtorad(wind_dir),wind_speed);

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
dcdy=dfdy_m(crl,10000);
dcdx=dfdx_m(crl,10000);
wl_e=1./(1020*(ff+crl)).*crl_tau.*8640000;
wn_e=(1/1020)*(1./(ff+crl).^2).*((tau_x.*dcdy)-(tau_y.*dcdx)).*8640000;
wb_e=(1/1020)*(1./(ff+crl).^2).*(tau_x.*bb).*8640000;
w_ek_e=wl_e+wn_e;

%sst westerly
dtdx=dfdx_m(sst,10000);
dtdy=dfdy_m(sst,10000);
dtdn = single(-sind(wind_dir_sst).*dtdx + cosd(wind_dir_sst).*dtdy);

w_ek_esst=(.013.*dtdn).*8640000./(1020*ff+crl);

%We currents southerly wind
wind_dir=90;
wind_dir_sst=270;
[u_w,v_w]=pol2cart(degtorad(wind_dir),wind_speed);
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
dcdy=dfdy_m(crl,10000);
dcdx=dfdx_m(crl,10000);
wl_n=1./(1020*(ff+crl)).*crl_tau.*8640000;
wn_n=(1/1020)*(1./(ff+crl).^2).*((tau_x.*dcdy)-(tau_y.*dcdx)).*8640000;
wb_n=(1/1020)*(1./(ff+crl).^2).*(tau_x.*bb).*8640000;

w_ek_n=wl_n+wn_n;


%sst northerly
dtdx=dfdx_m(sst,10000);
dtdy=dfdy_m(sst,10000);
dtdn = single(-sind(wind_dir_sst).*dtdx + cosd(wind_dir_sst).*dtdy);

w_ek_nsst=(.013.*dtdn).*8640000./(1020*ff+crl);

fsst=(zgrid_abs(real_lon,real_lat,30,30,double(sst),Ls/1000));
crl=(zgrid_abs(real_lon,real_lat,30,30,double(crl),Ls/1000));
ssh=(zgrid_abs(real_lon,real_lat,30,30,double(h),Ls/1000));

w_ek_nsst=(zgrid_abs(real_lon,real_lat,30,30,double(w_ek_nsst),Ls/1000));
w_ek_esst=(zgrid_abs(real_lon,real_lat,30,30,double(w_ek_esst),Ls/1000));
w_ek_e=(zgrid_abs(real_lon,real_lat,30,30,double(w_ek_e),Ls/1000));
w_ek_n=(zgrid_abs(real_lon,real_lat,30,30,double(w_ek_n),Ls/1000));

w_ek_c_e=(zgrid_abs(real_lon,real_lat,30,30,double(wl_e),Ls/1000));
w_ek_c_n=(zgrid_abs(real_lon,real_lat,30,30,double(wl_n),Ls/1000));
w_ek_z_e=(zgrid_abs(real_lon,real_lat,30,30,double(wn_e),Ls/1000));
w_ek_z_n=(zgrid_abs(real_lon,real_lat,30,30,double(wn_n),Ls/1000));
w_ek_b_e=(zgrid_abs(real_lon,real_lat,30,30,double(wb_e),Ls/1000));
w_ek_b_n=(zgrid_abs(real_lon,real_lat,30,30,double(wb_n),Ls/1000));



yofst=yofst-xspan-dy-dy;

%%Cyclones
ax=subplot(6,4,14);
tmp=interp2(w_ek_esst);
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
ylabel('Westerly wind','HorizontalAlignment','center','fontsize',20)
text(-3.7,-2.3,'Cyclone','HorizontalAlignment','center','fontsize',30,'color','b','Rotation',90)

loc_x=loc_x+xspan+dx;

ax=subplot(6,4,15);
tmp=interp2(w_ek_c_e);
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



%%W_sst noro
loc_x=loc_x+xspan+dx;

ax=subplot(6,4,16);
tmp=interp2(w_ek_z_e);
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


loc_x=loc_x+xspan+dx;

ax=subplot(6,4,17);
tmp=interp2(w_ek_e);
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

yofst=yofst-xspan-dy;


ax=subplot(6,4,17);
tmp=interp2(w_ek_nsst);
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
ylabel('Poleward wind','HorizontalAlignment','center','fontsize',20)

loc_x=loc_x+xspan+dx;

ax=subplot(6,4,19);
tmp=interp2(w_ek_c_n);
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



%%W_sst noro
loc_x=loc_x+xspan+dx;

ax=subplot(6,4,20);
tmp=interp2(w_ek_z_n);
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

ax=subplot(6,4,21);
tmp=interp2(w_ek_n);
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
set(cc,'units','inches','position',[4.5 yofst 2*xspan .3],'LineWidth',1.5)
xlabel(cc,{'cm day^{-1}'},'fontsize',13,'HorizontalAlignment','center')

print -dpng -r300 /Users/new_gaube/Documents/Publications/new_sst_wind/figs/pumping_scam
print -dpng -r300 /Users/new_gaube/Documents/Publications/new_sst_wind/sumitted_revision/figs/fig_5
!open /Users/new_gaube/Documents/Publications/new_sst_wind/figs/pumping_scam.png    
    
    
    
    
    
    






