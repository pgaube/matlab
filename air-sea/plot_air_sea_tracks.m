lat=-60:60;
lon=0:360;
load /matlab/data/eddy/V4/full_tracks/air-sea_kur_s_lat_lon_tracks x y id track_jday
pmap(lon,lat,[x y id track_jday],'tracks_dots')
hold on
load /matlab/data/eddy/V4/full_tracks/air-sea_kur_n_lat_lon_tracks x y id track_jday
pmap(lon,lat,[x y id track_jday],'tracks_dots')
load /matlab/data/eddy/V4/full_tracks/air-sea_agu_lat_lon_tracks x y id track_jday
pmap(lon,lat,[x y id track_jday],'tracks_dots')
load /matlab/data/eddy/V4/full_tracks/air-sea_eio_lat_lon_tracks x y id track_jday
pmap(lon,lat,[x y id track_jday],'tracks_dots')
load /matlab/data/eddy/V4/full_tracks/air-sea_sio_lat_lon_tracks x y id track_jday
pmap(lon,lat,[x y id track_jday],'tracks_dots')
load /matlab/data/eddy/V4/full_tracks/HAW_lat_lon_tracks x y id track_jday
pmap(lon,lat,[x y id track_jday],'tracks_dots')
load /matlab/data/eddy/V4/full_tracks/air-sea_car_lat_lon_tracks x y id track_jday
pmap(lon,lat,[x y id track_jday],'tracks_dots')
load /matlab/data/eddy/V4/full_tracks/oPC_lat_lon_tracks x y id track_jday
pmap(lon,lat,[x y id track_jday],'tracks_dots')

load /matlab/matlab/domains/air-sea_kur_s_lat_lon
draw_domain(lon,lat)
load /matlab/matlab/domains/air-sea_kur_n_lat_lon
draw_domain(lon,lat)
load /matlab/matlab/domains/air-sea_agu_lat_lon
draw_domain(lon,lat)
load /matlab/matlab/domains/air-sea_eio_lat_lon
draw_domain(lon,lat)
load /matlab/matlab/domains/air-sea_sio_lat_lon
draw_domain(lon,lat)
load /matlab/matlab/domains/HAW_lat_lon
draw_domain(lon,lat)
load /matlab/matlab/domains/air-sea_car_lat_lon
draw_domain(lon,lat)
load /matlab/matlab/domains/oPC_lat_lon
draw_domain(lon,lat)

print -dpng -r300 figs/air_sea_tracks