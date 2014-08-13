function [zi,xi,yi] = rgrid(lon,lat,x,y,z,x1,y1,l);
%function [zi,xi,yi] = rgrid(lon,lat,x,y,z,x1,y1,l);
%
% Inputs
% lon = longitude locations of the data in z [m,n]
% lat = latitude locations of the data in z [m,n]
% x = zonal location of the centroid of z (longitude) [1,1]
% y = meridional location of the centroid of z (latitude) [1,1]
% z = the data used to make the estimate zi [m,n]
% x1 = zonal location of the centroid of z (longitude) at a prvious time [1,1]
% y1 = meridional location of the centroid of z (latitude) at a prvious time [1,1]
%
% Output
% zi = an interpalted estimate of z at locations x/l and y/l [m*d,n*d]

if y==y1
theta=0;
else
theta=atan((y-y1)/(x-x1));
end
r=sqrt(((x-x1)^2+((y-y1)^2)));


dist_x = ((lon-x).*(111.1*cosd(lat)))./l;
dist_y = ((lat-y).*111.1)./l;

xi=[-2:.25:2];
xi=ones(length(xi),1)*xi;
yi=xi';


xp = xi.*cos(theta)+yi*sin(theta);
xp=interp2(xp,2);
yp = -xi.*sin(theta)+yi.*cos(theta);
yp=interp2(yp,2);


zi = griddata(dist_x,dist_y,z,xp,yp,'nearest');



