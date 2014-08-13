clear all
spath='~/data/eddy/V5/mat/AVISO_25_W_';
startjd=2450548;
endjd=2451633;
jdays=[startjd:7:endjd];
    

minlat=30;
maxlat=50;
minlon=180+(180-70);
maxlon=180+(180-35);
% load ~/data/eddy/V5/global_tracks_V5 x y amp k id cyc track_jday scale

load([spath,num2str(startjd)],'lat','lon')
[r,c]=imap(minlat,maxlat,minlon,maxlon,lat,lon);
lat=lat(r,c);
lon=lon(r,c);

SSH=nan(length(r),length(c),length(jdays));
for m=1:length(jdays)
    load([spath,num2str(jdays(m))],'ssh')
    SSH(:,:,m)=ssh(r,c);
    clear ssh
end

save test_data SSH lat lon jdays