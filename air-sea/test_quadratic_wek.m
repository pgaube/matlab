clear all
a=.2; %m
L=1; %deg
xo=0; 
yo=0;
ff=f_cor(-30);
gg = 9.81; %ms^-2
v_w=10;

x=linspace(-2,2,65);
%y=x;
%[x,y]=meshgrid(x,y);
%dist=sqrt(x.^2+y.^2);
w= sum(-1 + 2.*rand(3,20000));
figure(4)
clf
h=hist(w,65);
%plot(x,h)
h=smooth1d_loess(h,1:length(h),100,1:length(h));
h=a*(h./(max(h)));
h=(a*(1-x.^2))./((x/(L+.5)).^4+1);
%h(h<0)=0;
hold on
plot(x,h,'k')
g=a*exp((-x.^2)/(L^2));

plot(x,g,'g')

v = (gg./ff).*dfdx_abs(h,.0625);
v_rel=v_w-v;
tau_y=wind2stress(v_rel);
crl_tau=dfdx_abs(tau_y,.0625);
w_ek=1./(1020*ff).*crl_tau.*8640000;


v = (gg./ff).*dfdx_abs(g,.0625);
v_rel=v_w-v;
tau_y=wind2stress(v_rel);
crl_tau=dfdx_abs(tau_y,.0625);
g_ek=1./(1020*ff).*crl_tau.*8640000;

figure(5)
clf
plot(x,w_ek,'k')
hold on
plot(x,g_ek,'g')
