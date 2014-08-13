clear
%inputs
global Po
global Zo
global mu
global g
global b
global m

Po=50; 	%inital # of P
Zo=5;	%initial # of Z
mu=0.6;	%P growth rate
g=0.11;	%grazing rate of P by Z
b=0.001;%reporductive rate of Z per P
m=0.05;	%mortality rate of Z

t0 = 0;
tfinal = 600;
ti=t0:tfinal;
y0 = [Po Zo]';

% Simulate the differential equation.
tfinal = tfinal*(1+eps);
[t,x] = ode23('lotka',[t0 tfinal],y0);
y(:,1)=interp1(t,x(:,1),ti');
y(:,2)=interp1(t,x(:,2),ti');
t=ti';

figure(1)
clf
plot(t,y(:,1),'b')
hold on
plot(t,y(:,2),'r')

lags=0:100;
rho_p=pcor(y(:,1),y(:,1),lags);
rho_z=pcor(y(:,2),y(:,2),lags);
figure(2)
clf
plot(lags,rho_p,'b')
hold on
plot(lags,rho_z,'r')
grid