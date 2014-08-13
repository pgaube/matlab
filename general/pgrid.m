function [zi,xi,yi] = pgrid(z,theta);
%function [zi,xi,yi] = zgrid(z,theta);
%
% Inputs
% z = the data used to make the estimate zi [m,n]
% theta = angle to rotate (in degrees)
%
% Output
% zi = an interpalted estimate of z at locations x/l and y/l [m*d,n*d]

ny=length(z(:,1));

xi=[-(ny-1)/2:(ny-1)/2];
xi=ones(length(xi),1)*xi;
yi=xi';

xp = xi.*cosd(theta)+yi*sind(theta);
xp=interp2(xp,2);
yp = -xi.*sind(theta)+yi.*cosd(theta);
yp=interp2(yp,2);


zi = griddata(xi,yi,z,xp,yp,'nearest');


