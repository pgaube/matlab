function [zi,xi,yi] = zgrid(lon,lat,x,y,z,l);
%function [zi,xi,yi] = zgrid(lon,lat,x,y,z,l);
%
% Inputs
% lon = longitude locations of the data in z [m,n]
% lat = latitude locations of the data in z [m,n]
% x = zonal location of the centroid of z (longitude) [1,1]
% y = meridional location of the centroid of z (latitude) [1,1]
% z = the data used to make the estimate zi [m,n]
% l = scale to which to normalize the locations of zi to z [1,1]
%
% Output
% zi = an interpalted estimate of z at locations x/l and y/l [m*d,n*d]


dist_x = sqrt(((lon-x).*(111.1*cosd(lat))).^2); 
dist_y = sqrt(((lat-y).*111.1).^2);


dist_xi = (dist_x./l);
dist_yi=(dist_y./l);


xi=cat(2,[5:-.25:0],[.1:.25:5]);
xi=ones(length(xi),1)*xi;
yi=xi';

zi = griddata(dist_xi,dist_yi,z,xi,yi,'nearest');



