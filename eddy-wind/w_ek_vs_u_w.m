x=[0:.05:5];
y=[0:.05:5];

[lon,lat]=meshgrid(x,y);

a=.25; %m
a_sst=2; %deg c
L=.75; %deg
xo=2.5; 
yo=2.5;
alpha=.2;
v_w=0;

dist=sqrt((lon-xo).^2+(lat-yo).^2);

h=a*exp(-dist.^2/(2*L^2));
ff=6e-5;
g = 9.81; %ms^-2

u = (-g./ff).*dfdy(h,.05);
v = (g./ff).*dfdx_abs(h,.05);

crl=dfdx_abs(v,.05)-dfdy(u,.05);
spd_o=sqrt(u.^2+v.^2);
m=1;
for u_w=1:.5:30
u_rel=u_w-u;
v_rel=v_w-v;
u_rel_min=(u_w/20)-u;
v_rel_min=(v_w/20)-v;
crl_rel=dfdx_abs(v_rel,.05)-dfdy(u_rel,.05);
tau_x=wind2stress(u_rel);
tau_x_min=wind2stress(u_rel_min);
tau_y=wind2stress(v_rel);
crl_tau=dfdx_abs(tau_y,.05)-dfdy(tau_x,.05);
w=1/(1020*ff)*crl_tau.*86400;
w_ek(m)=max(w(:));
m=m+1;
end

figure(1)
plot([1:.5:30],w_ek,'k')
title('Ekman Pumping as a function of ambient wind speed')
xlabel('wind speed [ms^{-1}]  ')
ylabel('Ekman pumping [m day^{-1}]   ')
print -dpng -r300 ~/Documents/OSU/Talks/OS01/w_ek_vs_u_w