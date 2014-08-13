load mean_gs_path_obs_pop lons lats std_lats mean std
bs=7;
as=2;
% %% run 14
% load GS_rings_tracks_run14_sla
% 
% lat=min(pop_eddies.y):.25:max(pop_eddies.y);
% lon=min(pop_eddies.x):.25:max(pop_eddies.x);
% [lon,lat]=meshgrid(lon,lat);
% dx=1;
% [radius_map,amplitude_map,age_map]=deal(nan(size(lat)));
% 
% for m=1:length(lat(:,1))
%     for n=1:length(lon(1,:))
%         ii=find(pop_eddies.x>=lon(1,n)-dx & pop_eddies.x<=lon(1,n)+dx & pop_eddies.y>=lat(m,1)-dx & pop_eddies.y<=lat(m,1)+dx);
%         amplitude_map(m,n)=pmean(pop_eddies.amp(ii));
%         radius_map(m,n)=pmean(pop_eddies.radius(ii));
%         age_map(m,n)=pmean(pop_eddies.k(ii));
%     end
% end
% 
% figure(1)
% clf
% pmap(lon,lat,smoothn(amplitude_map,5),'gs')
% hold on
% m_plot(smoothn(lons,10),smoothn(lats,10),'k','linewidth',2);
% m_plot(smoothn(lons,10),smoothn(lats-bs,10),'k--','linewidth',1)
% m_plot(smoothn(lons,10),smoothn(lats+as,10),'k--','linewidth',1)
% caxis([1 50])
% print -dpng -r300 figs/run14_amp_map
% save run14_mapped_eddy_prop lon lat *_map
% 

%% run 33
load GS_rings_tracks_run33_sla
load mean_gs_path_obs_pop_run_33

lat=min(pop_eddies.y):.25:max(pop_eddies.y);
lon=min(pop_eddies.x):.25:max(pop_eddies.x);
[lon,lat]=meshgrid(lon,lat);
dx=1;
[radius_map,amplitude_map,age_map]=deal(nan(size(lat)));

for m=1:length(lat(:,1))
    for n=1:length(lon(1,:))
        ii=find(pop_eddies.x>=lon(1,n)-dx & pop_eddies.x<=lon(1,n)+dx & pop_eddies.y>=lat(m,1)-dx & pop_eddies.y<=lat(m,1)+dx);
        amplitude_map(m,n)=pmean(pop_eddies.amp(ii));
        radius_map(m,n)=pmean(pop_eddies.radius(ii));
        age_map(m,n)=pmean(pop_eddies.k(ii));
    end
end

figure(2)
clf
pmap(lon,lat,smoothn(amplitude_map,5),'gs')
caxis([1 50])
hold on
m_plot(smoothn(lons,10),smoothn(lats,10),'k','linewidth',2);
m_plot(smoothn(lons,10),smoothn(lats-bs,10),'k--','linewidth',1)
m_plot(smoothn(lons,10),smoothn(lats+as,10),'k--','linewidth',1)
print -dpng -r300 figs/run33_amp_map
save run33_mapped_eddy_prop lon lat *_map
% 
% %% obs
% lons=mean(:,1);
% lats=mean(:,2);
% std_lats=std;
% load GS_rings_tracks_run14_sla
% pop_eddies=aviso_eddies;
% 
% lat=min(pop_eddies.y):.25:max(pop_eddies.y);
% lon=min(pop_eddies.x):.25:max(pop_eddies.x);
% [lon,lat]=meshgrid(lon,lat);
% dx=1;
% [radius_map,amplitude_map,age_map]=deal(nan(size(lat)));
% 
% for m=1:length(lat(:,1))
%     for n=1:length(lon(1,:))
%         ii=find(pop_eddies.x>=lon(1,n)-dx & pop_eddies.x<=lon(1,n)+dx & pop_eddies.y>=lat(m,1)-dx & pop_eddies.y<=lat(m,1)+dx);
%         amplitude_map(m,n)=pmean(pop_eddies.amp(ii));
%         radius_map(m,n)=pmean(pop_eddies.radius(ii));
%         age_map(m,n)=pmean(pop_eddies.k(ii));
%     end
% end
% 
% figure(3)
% clf
% pmap(lon,lat,smoothn(amplitude_map,5),'gs')
% caxis([1 50])
% hold on
% m_plot(smoothn(lons,10),smoothn(lats,10),'k','linewidth',2);
% m_plot(smoothn(lons,10),smoothn(lats-bs,10),'k--','linewidth',1)
% m_plot(smoothn(lons,10),smoothn(lats+as,10),'k--','linewidth',1)
% print -dpng -r300 figs/obs_amp_map
% save obs_mapped_eddy_prop lon lat *_map




