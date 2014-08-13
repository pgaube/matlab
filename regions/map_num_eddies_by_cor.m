% clear all
% load ~/data/eddy/V6/global_tracks_ext_V6.mat ext_x ext_y age
% x=ext_x;y=ext_y;
% load FINAL_cor_sm_output lon lat sm_cor_0
% slat=lat;slon=lon;
% lat=-70:70;lon=0:359;
% [lon,lat]=meshgrid(lon,lat);
% 
% dx=.5;
% 
% [n_map]=deal(nan(size(lat)));
% 
% for m=1:length(lat(:,1))
%     for n=1:length(lon(1,:))
%         ii=find(x>=lon(1,n)-dx & x<=lon(1,n)+dx & y>=lat(m,1)-dx & y<=lat(m,1)+dx & age>=12);
%         n_map(m,n)=length(ii);
%     end
% end
% 
% save n_eddies_map n_map lat lon sm_cor_0

figure(1)
clf
pmap(lon,lat,n_map);
% caxis([0 10])
title('N')
cc=colorbar

per_total_map=100*(n_map./nansum(n_map(:)));

dif_track_map=nansum(n_map(:))./length(find(age>=12))

gcor=interp2(slon,slat,sm_cor_0,lon,lat);

figure(2)
clf
pmap(lon,lat,gcor);caxis([-.5 .5])

mask=nan*gcor;
mask(abs(gcor)>=.12)=1;

figure(3)
clf
pmap(lon,lat,mask.*gcor);caxis([-.5 .5])

dy=111.11*linspace(1,1,length(lat(1,:)));
dx=111.11*linspace(1,1,length(lat(:,1)))'.*cosd(lat(:,1));
area_map=dx*dy;
mask=nan*gcor;
mask(~isnan(gcor))=1;
area_map=area_map.*mask;


mask=nan*gcor;
mask(gcor>=.12)=1;
tt=per_total_map.*mask;
perc_pos=nansum(tt(:))
tt=area_map.*mask;
area_pos=nansum(tt(:))./nansum(area_map(:))
figure(4)
clf
pmap(lon,lat,mask.*gcor);caxis([-.5 .5])

mask=nan*gcor;
mask(gcor<=-.12)=1;
tt=per_total_map.*mask;
perc_neg=nansum(tt(:))
tt=area_map.*mask;
area_neg=nansum(tt(:))./nansum(area_map(:))
figure(5)
clf
pmap(lon,lat,mask.*gcor);caxis([-.5 .5])











