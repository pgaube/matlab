load tracks/EK_lat_lon_tracks.mat

figure(10)
clf
scatter(track_wek,track_hp21_chl,'k.')
axis([0 .4 0 .4])
xlabel('track_wek_chl')
ylabel('track_hp21_chl')
line([0 1],[0 1])
