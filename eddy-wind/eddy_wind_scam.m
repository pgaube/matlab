load bwr.pal
x=[0:.05:5];
y=[0:.05:5];

[lon,lat]=meshgrid(x,y);

a=.20; %m
a_sst=1.5; %deg c
L=.5; %deg
xo=2.5; 
yo=2.5;
u_w=10; %ms
v_w=0; %ms
alpha=.2;
dist=sqrt((lon-xo).^2+(lat-yo).^2);

rhoa=1.22;
rho=1025;
cd=1.14e-3;

dist=sqrt((lon-xo).^2+(lat-yo).^2);

h=a*exp((-dist.^2)/(L^2));
ff=f_cor(-20);
g = 9.81; %ms^-2

u = (-g./ff).*dfdy(h,.05);
v = (g./ff).*dfdx_abs(h,.05);

crl=dfdx_abs(v,.05)-dfdy(u,.05);
spd_o=sqrt(u.^2+v.^2);

u_rel=u_w-u;
v_rel=v_w-v;
u_rel_min=(u_w/20)-u;
v_rel_min=(v_w/20)-v;
crl_rel=dfdx_abs(v_rel,.05)-dfdy(u_rel,.05);
tau_x=wind2stress(u_rel);
tau_x_min=wind2stress(u_rel_min);
tau_y=wind2stress(v_rel);
crl_tau=dfdx_abs(tau_y,.05)-dfdy(tau_x,.05);
w_ek=1./(1020*ff+crl).*crl_tau.*86400;
%an_w_ek=((-2*rhoa*cd*sqrt(u_rel.^2+v_rel.^2))/(rho.*ff)).*(sqrt(u_rel.^2+v_rel.^2)./dist).*(1-((2*dist.^2)./L.^2));

%{
w_ek_nl=1./(1020*((ff+crl).^2)).*((tau_x.*dfdy(ff+crl,.05))-(tau_y.*dfdx_abs(ff+crl,.05))).*86400;
w_ek_nl_l=dfdx_abs((tau_y./(1020*(ff+crl))),.05)-dfdy((tau_x./(1020*(ff+crl))),.05).*86400;

dist_sst=sqrt((lon-(xo-L)).^2+(lat-(yo-L)).^2);
sst=a_sst*exp(-(dist_sst).^2/(2*(L/1.3)^2));
theta=cart2pol(u_w,v_w);
[u_sst,v_sst]=pol2cart(theta,alpha*sst);
crl_sst=dfdx_abs(v_sst,.05)-dfdy(u_sst,.05);
tau_x_sst=wind2stress(u_w+u_sst);
tau_y_sst=wind2stress(v_w+v_sst);
crl_tau_sst=dfdx_abs(tau_y_sst,.05)-dfdy(tau_x_sst,.05);
w_ek_sst=1./(1020*ff+crl).*crl_tau_sst.*86400;


u_tot=u_w-u+u_sst;
u_tot_min=u_rel_min+u_sst;
v_tot=v_w-v+v_sst;
v_tot_min=v_rel_min+v_sst;
tau_tot_x=wind2stress(u_tot);
tau_tot_y=wind2stress(v_tot);
crl_tau_tot=dfdx_abs(tau_tot_y,.05)-dfdy(tau_tot_x,.05);
crl_tot=dfdx_abs(v_tot,.05)-dfdy(u_tot,.05);
w_ek_tot=1./(1020*ff+crl).*crl_tau_tot.*86400;
%}
return

%{
figure(1)
clf
pcolor(lon,lat,100*h);shading flat
hold on
quiver(lon(1:6:101,1:6:101),lat(1:6:101,1:6:101),u(1:6:101,1:6:101),v(1:6:101,1:6:101),.7,'k');
contour(lon,lat,h,[0:.02:1],'k')
axis image
title('ssh with ssh contours and u_o,v_o   ')
xlabel({['amp=' num2str(a) 'm, L=' num2str(L) 'deg  '],[' u_o_{max}=' num2str(max(spd_o(:))) 'ms^{-1}, u_{wind}=' num2str(u_w) 'cms^{-1}   ']})
cc=colorbar;
axes(cc)
ylabel('cm  ')
print -dpng -r300 ~/Documents/Publications/gaube_chelton_crl_crl/diagrams/ssh_ssh_uo_vo.png



figure(1)
clf
clf
pcolor(lon,lat,w_ek_nl);shading flat
hold on
quiver(lon(1:6:101,1:6:101),lat(1:6:101,1:6:101),u_rel_min(1:6:101,1:6:101),v_rel_min(1:6:101,1:6:101),1,'k');
contour(lon,lat,h,[0:.02:1],'k')
caxis([-.5 .5])
axis image
colormap(bwr)
title('Nonlinear Ekman Pumping with ssh contours and \tau_x,\tau_y   ')
cc=colorbar;
axes(cc)
ylabel('m per day  ')
print -dpng -r300 ~/Documents/Publications/gaube_chelton_crl_crl/diagrams/w_ek_nl_ssh_tx_ty.png

figure(10)
clf
clf
pcolor(lon,lat,w_ek_nl_l);shading flat
hold on
quiver(lon(1:6:101,1:6:101),lat(1:6:101,1:6:101),u_rel_min(1:6:101,1:6:101),v_rel_min(1:6:101,1:6:101),1,'k');
contour(lon,lat,h,[0:.02:1],'k')
caxis([-.5 .5])
axis image
colormap(bwr)
title('Nonlinear + Linear Ekman Pumping with ssh contours and \tau_x,\tau_y   ')
cc=colorbar;
axes(cc)
ylabel('m per day  ')
print -dpng -r300 ~/Documents/Publications/gaube_chelton_crl_crl/diagrams/w_ek_nl_l_ssh_tx_ty.png


figure(2)
clf
pcolor(lon,lat,1e5.*crl);shading flat
hold on
quiver(lon(1:6:101,1:6:101),lat(1:6:101,1:6:101),u(1:6:101,1:6:101),v(1:6:101,1:6:101),.7,'k');
contour(lon,lat,h,[0:.02:1],'k')
colormap(bwr)
caxis([-1 1])
axis image
title('crl_o with ssh contours and u_o,v_o   ')
cc=colorbar;
axes(cc)
ylabel('ms^{-1} per 100km  ')
print -dpng -r300 ~/Documents/Publications/gaube_chelton_crl_crl/diagrams/crlo_ssh_uo_vo.png

figure(2)
clf
pcolor(lon,lat,1e5.*-crl);shading flat
hold on
quiver(lon(1:6:101,1:6:101),lat(1:6:101,1:6:101),-u(1:6:101,1:6:101),-v(1:6:101,1:6:101),.7,'k');
contour(lon,lat,h,[0:.02:1],'k')
colormap(bwr)
caxis([-1 1])
axis image
title('-crl_o with ssh contours and -u_o,-v_o   ')
cc=colorbar;
axes(cc)
ylabel('ms^{-1} per 100km  ')
print -dpng -r300 ~/Documents/Publications/gaube_chelton_crl_crl/diagrams/-crlo_ssh_-uo_-vo.png
%}

figure(3)
clf
pcolor(lon,lat,w_ek);shading flat
hold on
quiver(lon(1:6:101,1:6:101),lat(1:6:101,1:6:101),u_rel_min(1:6:101,1:6:101),v_rel_min(1:6:101,1:6:101),1,'k');
contour(lon,lat,h,[0:.02:1],'k')
caxis([-.2 .2])
axis image
colormap(bwr)
title('Ekman Pumping with ssh contours and \tau_x,\tau_y   ')
cc=colorbar;
axes(cc)
ylabel('m per day  ')
print -dpng -r300 ~/Documents/Publications/gaube_chelton_crl_crl/diagrams/w_ek_ssh_tx_ty.png

return
figure(4)
clf
pcolor(lon,lat,sst);shading flat
hold on
quiver(lon(1:6:101,1:6:101),lat(1:6:101,1:6:101),u_sst(1:6:101,1:6:101),v_sst(1:6:101,1:6:101),.7,'k');
contour(lon,lat,h,[0:.02:1],'k')
axis image
title('SST with contours of ssh and u_s,v_s   ')
xlabel(['max_{SST}=' num2str(a_sst) '^\circ C, \alpha=' num2str(alpha) '  '])
%caxis('auto')
caxis([-1.5 1.5])
cc=colorbar;
axes(cc)
ylabel('^\circ C  ')
print -dpng -r300 ~/Documents/Publications/gaube_chelton_crl_crl/diagrams/sst_ssh_us_vs.png

figure(5)
clf
pcolor(lon,lat,w_ek_sst);shading flat
hold on
%quiver(lon(1:6:101,1:6:101),lat(1:6:101,1:6:101),u_tot_min(1:6:101,1:6:101),v_tot_min(1:6:101,1:6:101),1,'k');
contour(lon,lat,h,[0:.02:1],'k')
%contour(lon,lat,sst,[0:.2:1],'k--')
axis image
colormap(bwr)
caxis([-.2 .2])
title('w-ek-sst with contours of ssh and SST(dashed)   ')
cc=colorbar;
axes(cc)
ylabel('ms^{-1} per 100km  ')
print -dpng -r300 ~/Documents/Publications/gaube_chelton_crl_crl/diagrams/w_ek_sst_ssh.png

figure(6)
clf
pcolor(lon,lat,w_ek_tot);shading flat
hold on
quiver(lon(1:6:101,1:6:101),lat(1:6:101,1:6:101),u_tot_min(1:6:101,1:6:101),v_tot_min(1:6:101,1:6:101),1,'k');
contour(lon,lat,h,[0:.02:1],'k')
%contour(lon,lat,sst,[0:.2:1],'k--')
axis image
colormap(bwr)
caxis([-.2 .2])
title('Total Ekman Pumping with contours of ssh and SST(dashed) and u_{tot},v_{tot}  ')
cc=colorbar;
axes(cc)
ylabel('m per day  ')
print -dpng -r300 ~/Documents/Publications/gaube_chelton_crl_crl/diagrams/w_ek_tot_ssh_utot_vtot.png




