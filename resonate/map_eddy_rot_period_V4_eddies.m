% load ~/data/eddy/V4/global_tracks_v4.mat
% 
% 
% lat=-80:80;
% lon=0:360;
% [lon,lat]=meshgrid(lon,lat);
% 
% dx=1;
% 
% [radius_map,amplitude_map,u_map,age_map,c_map,c_west_map]=deal(nan(size(lat)));
% 
% for m=1:length(lat(:,1))
%     for n=1:length(lon(1,:))
%         ii=find(x>=lon(1,n)-dx & x<=lon(1,n)+dx & y>=lat(m,1)-dx & y<=lat(m,1)+dx);
%         amplitude_map(m,n)=pmean(amp(ii));
%         c_map(m,n)=pmean(abs(prop_speed(ii)));
%         c_west_map(m,n)=pmean(abs(prop_speed_west(ii)));
%         radius_map(m,n)=pmean(scale(ii));
%         u_map(m,n)=pmean(axial_speed(ii));
%         age_map(m,n)=pmean(k(ii));
%     end
% end
% period_map=100*100*2*pi*radius_map./u_map./60./60./24;
% 
% exp_cor_map=radius_map./c_map.*100.*1000./60./60./24./7;
% exp_cor_west_map=radius_map./c_west_map.*100.*1000./60./60./24./7;
% 
% save mapped_eddy_properties_V4 lat lon *_map
% 

load mapped_eddy_properties_V4 lat lon *_map

figure(1)
clf
pmap(lon,lat,c_map);
caxis([0 10])
title('c')
cc=colorbar
axes(cc)
ylabel('cm s^{-1}')
print -dpng -r300 figs/c_map
  
figure(2)
clf
pmap(lon,lat,radius_map);
caxis([0 150])
title('L_s')
cc=colorbar
axes(cc)
ylabel('km')
print -dpng -r300 figs/L_s_map

figure(3)
clf
pmap(lon,lat,exp_cor_map);
caxis([0 10])
title('L_s/c')
cc=colorbar
axes(cc)
ylabel('weeks')
print -dpng -r300 figs/l_s_over_c_map


figure(4)
clf
pmap(lon,lat,exp_cor_west_map);
caxis([0 10])
title('L_s/c')
cc=colorbar
axes(cc)
ylabel('weeks')
print -dpng -r300 figs/l_s_over_c_west_map



