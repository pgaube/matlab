load ~/data/eddy/V5/global_tracks_v5.mat


lat=-80:80;
lon=0:360;
[lon,lat]=meshgrid(lon,lat);

dx=1;

[radius_map,amplitude_map,u_map,age_map,cyc_map]=deal(nan(size(lat)));

for m=1:length(lat(:,1))
    for n=1:length(lon(1,:))
        ii=find(x>=lon(1,n)-dx & x<=lon(1,n)+dx & y>=lat(m,1)-dx & y<=lat(m,1)+dx);
        amplitude_map(m,n)=pmean(amp(ii));
        radius_map(m,n)=pmean(scale(ii));
        u_map(m,n)=pmean(axial_speed(ii));
        age_map(m,n)=pmean(k(ii));
        cyc_map(m,n)=length(find(cyc(ii)==-1))/length(find(cyc(ii)==1));
    end
end
period_map=100*100*2*pi*radius_map./u_map./60./60./25;

figure(1)
clf
pmap(lon,lat,amplitude_map);
caxis([0 15])
  
figure(1)
clf
pmap(lon,lat,period_map);
caxis([0 15])

save mapped_eddy_properties lat lon *_map

