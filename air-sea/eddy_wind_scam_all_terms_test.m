%
clear all


x=1000*[-400:10:400];
y=1000*[-400:10:400];

[lon,lat]=meshgrid(x,y);
xo=0; 
yo=0;
a=.2; %m
L=60e3; %m
dist=sqrt((lon-xo).^2+(lat-yo).^2);
wind_speed=7; %ms
[ff,bb]=f_cor(30);
g = 9.81; %ms^-2

h=a(1)*exp((-dist.^2)/(2*L^2));


%We currents westerly wind
wind_dir=180;
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

w_ek_l=(1/1020)*(1./(ff)).*crl_tau.*8640000;
w_ek_n=(1/1020)*(1./(ff).^2).*((tau_x.*dcdy)-(tau_y.*dcdx)).*8640000;
w_ek_b=-(1/1020)*(1./(ff).^2)*(tau_x.*bb).*8640000;
crlt=(dcdy)-(dcdx);
trm1=(tau_x.*dcdy);
vel=(sqrt(u.^2+v.^2));
trm2=-(tau_y.*dcdx);
trm3=(tau_x.*dcdy)-(tau_y.*dcdx);

ddist=1e-3*sqrt(lon.^2+lat.^2);
ri=linspace(0,400,41);

for m=1:length(ri)-1
	ii=find(ddist>=ri(m) & ddist<ri(m+1));

	azav_l(m)=pmean(w_ek_l(ii));
	azav_n(m)=pmean(w_ek_n(ii));
	azav_b(m)=pmean(w_ek_b(ii));
	azav_crlt(m)=pmean(crlt(ii));
    azav_ter1(m)=pmean(trm1(ii));
    azav_ter2(m)=pmean(trm2(ii));
    azav_ter3(m)=pmean(trm3(ii));
    azav_v(m)=pmean(vel(ii));
end	
%}
ri=ri(1:end-1);
T_c=2*pi*100*1000*ri./azav_v/60/60/24;

figure(1)
clf
subplot(221)
plot(ri,azav_crlt)
title('crl of crl')

subplot(222)
plot(ri,azav_ter1)
title('\tau_x * dcdy')

subplot(223)
plot(ri,azav_ter2)
title('-\tau_y * dcdx')

subplot(224)
plot(ri,azav_ter3)
title('\tau_x * dcdy-\tau_y * dcdx')



