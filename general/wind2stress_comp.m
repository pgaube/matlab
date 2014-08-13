function [tau_x,tau_y] = wind2stress_comp(u,v)

rho0 = 1.223;   % density
a0   = 2.7e-3;
b0   = 0.142e-3;
c0   = 0.0764e-3;

spd=sqrt(u.^2+v.^2);
dir=atan2(v,u);
ax = cos(dir);
ay = sin(dir);

spd2 = spd.*spd;
strm = rho0*(a0*spd + b0*spd2 + c0*spd2.*spd);

tau_x = strm.*ax;
tau_y = strm.*ay;


