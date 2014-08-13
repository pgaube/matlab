function [zi,xi,yi] = wgrid(lon,lat,x,y,z,theta,l);
%function [zi,xi,yi] = wgrid(lon,lat,x,y,z,theta,l);
%
% Inputs
% lon = longitude locations of the data in z [m,n]
% lat = latitude locations of the data in z [m,n]
% x = zonal location of the centroid of z (longitude) [1,1]
% y = meridional location of the centroid of z (latitude) [1,1]
% z = the data used to make the estimate zi [m,n]
% theta = angle to ratate
% ; = scale
%
% Output
% zi = an interpalted estimate of z at locations x/l and y/l [m*d,n*d]


dist_x = ((lon-x).*(111.1*cosd(lat)))./l;
dist_y = ((lat-y).*111.1)./l;

dist_x=dist_x(1,:);
dist_y=dist_y(:,1);

xi=[-2:.125:2];
xi=ones(length(xi),1)*xi;
yi=xi';


xp = xi.*cosd(theta)+yi*sind(theta);
%xp=interp2(xp,2);
yp = -xi.*sind(theta)+yi.*cosd(theta);
%yp=interp2(yp,2);


zi = griddata(dist_x,dist_y,z,xp,yp,'linear');


