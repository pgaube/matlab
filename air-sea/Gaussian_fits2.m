% Gaussian eddy fits
clear;

r0=[0:0.01:2];
omega=2*pi/86400;
lat=30;
f0 = 2*omega*sind(lat);
g=9.81;
Ls=90*10^3;
r=r0*Ls;

A1=0.145;
eta01= 0.00;
b1=1.2
L1=Ls/b1
pltnam1=strcat('(A,\eta_0,b)=(',num2str(A1,3),',',num2str(eta01),',',num2str(b1,3),')');

etaG1=A1*exp(-0.5*r.^2./L1^2);



ssh1=eta01+etaG1;
vel1=-(r/L1^2).*(g/f0).*etaG1;
zeta1=-(1/L1^2)*(2.-(r/L1).^2).*(g/f0).*etaG1;

figure
subplot(1,3,1)
plot(r0,ssh1*10^2,'-k')
hold on
plot([0 2],[0 0],':k')
axis([0 2 -2 16])
title(pltnam1)

subplot(1,3,2)
plot(r0,abs(vel1)*10^2,'-k')
axis([0 2 0 16])
title(pltnam1)

subplot(1,3,3)
plot(r0,zeta1*10^5,'-k')
hold on
plot([0 2],[0 0],':k')
axis([0 2 -0.7 0.2])
title(pltnam1)

