%This will put the columnar table data into a matrix form
%function [map] = colm2matr(data,lat_space,lon_space)

function [map] = colm2matr(data,lat_space,lon_space)

lat = min(data(:,2)):lat_space:max(data(:,2));
lon = min(data(:,1)):lon_space:max(data(:,1));
time = min(data(:,3)):max(data(:,3));

map = nan(length(lat),length(lon),length(time));  %makes a matrix of NaNs with dim = [lat,lon,time]

for m = min(data(:,2)):4:max(data(:,2))
    for n = min(data(:,1)):5:max(data(:,1))
        for p = min(data(:,3)):max(data(:,3))
            i = find(data(:,2)==m & data(:,1)==n & data(:,3)==p);
            if length(i>0)
                map(find(lat==m),find(lon==n),find(time==p)) = data(i,4);
            end
        end
    end
end

