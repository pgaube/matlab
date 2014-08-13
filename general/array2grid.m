%converts geolocated values in a array into a matrix
%function [map,lat,lon]=vector2matrix_3d(data,lats,lons,times)

function [X,lat,lon]=vector2matrix_2d(data,lats,lons,times)

lat = unique(lats);
lon = unique(lons);

if length(times)>1
    X = nan(length(lat),length(lon),length(times));
      for m = 1:length(lat)
          for n = 1:length(lon)
            p = find(lats == lat(m) & lons == lon(n));
            if length(p)>0
                X(m,n,:) = data(p,:);
            end
          end
      end

else
    X = nan(length(lat),length(lon));
      for m = 1:length(lat)
          for n = 1:length(lon)
              p = find(lats == lat(m) & lons == lon(n));
              if length(p)>0
                X(m,n) = data(p);
              end
          end
      end
end
