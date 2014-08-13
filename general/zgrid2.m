function [zi,xi,yi] = zgrid2(lon,lat,x,y,z,l);
%function [zi,xi,yi] = zgrid2(lon,lat,x,y,z,l);
%
% Inputs
% lon = longitude locations of the data in z [m,n]
% lat = latitude locations of the data in z [m,n]
% x = zonal location of the centroid of z (longitude) [1,1]
% y = meridional location of the centroid of z (latitude) [1,1]
% z = the data used to make the estimate zi [m,n]
% l = scale to which to normalize the locations of zi to z [1,1] in (km)
%
% Output
% zi = an interpalted estimate of z at locations x/l and y/l [m*d,n*d]

%check if all NaN
if isnan(nanmean(z))
    zi=nan(size(z));
end


dist_x = (lon-x).*(111.1*cosd(lat));
dist_y = (lat-y).*111.1;

dist_xi=(dist_x(1,:)./l);
dist_yi=(dist_y(:,1)./l);

xi=[-2:.125:2];
[xi,yi]=meshgrid(xi,xi);


% zi = griddata(grid_xs,grid_ys,grid_data,grid_bin1,grid_bin2,'linear');
% F = TriScatteredInterp(grid_xs(:),grid_ys(:),grid_data(:),'linear');
% zi = F(grid_bin1,grid_bin2);



if length(dist_xi)<length(xi(1,:)) || length(dist_yi)<length(xi(1,:))
    zi=nan(size(xi));
else
    for m=1:length(xi(1,:))
        for n=1:length(xi(1,:))
            zi(m,n)=bilin_pnt(yi(m,n),xi(m,n),length(xi(1,:)),length(xi(1,:)),dist_yi,dist_xi,z,3,3);
        end
    end
end
        
        
