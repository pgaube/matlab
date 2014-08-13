blank_map_lat=[-70:70];
blank_map_lon=[0:360];

figure(11)
clf
pmap(blank_map_lon,blank_map_lat,nan(length(blank_map_lat),length(blank_map_lon)))
hold on