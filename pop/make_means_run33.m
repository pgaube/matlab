clear all
% select time period
vv=[1740:2139]; %this is the whole encilada

[i,tm]=size(vv); % tm = number of time levels
load mat/run33_1740 lat lon
% read data
tic
n=0;
[diat_c,diaz_c,small_c]=deal(zeros(length(lat(:,1)),length(lon(1,:))));
[diat_n,diaz_n,small_n]=deal(ones(length(lat(:,1)),length(lon(1,:))));
for nn=vv; % time
    n=n+1;
    flid=num2str(nn)
    %first run14
    if exist(['mat/run33_',num2str(nn),'.mat'])
        load(['mat/run33_',num2str(nn)],'diat_biomass','diaz_biomass','small_biomass')
        diat_c=((diat_c.*diat_n)+diat_biomass)./(diat_n+1);
        diaz_c=((diaz_c.*diaz_n)+diaz_biomass)./(diaz_n+1);
        small_c=((small_c.*small_n)+small_biomass)./(small_n+1);
        clear *biomass
        diat_n=diat_n+1;
        diaz_n=diaz_n+1;
        small_n=small_n+1;        
    end
end

mean_diaz_biomass=diaz_c;
mean_diat_biomass=diat_c;
mean_small_biomass=small_c;

save ~/matlab/pop/mat/mean_diaz_biomass_run33 mean_diaz_biomass
save ~/matlab/pop/mat/mean_diat_biomass_run33 mean_diat_biomass
save ~/matlab/pop/mat/mean_small_biomass_run33 mean_small_biomass


save pop_biomass_means_run33 *_c lat lon

load pop_biomass_means_run33
figure(1)
clf
pmap(lon,lat,log10(diat_c))
caxis([0.3 2.5])
print -dpng -r300 figs/mean_diat_c_run33

figure(1)
clf
pmap(lon,lat,log10(diaz_c))
caxis([-1.5 1])
print -dpng -r300 figs/mean_diaz_c_run33

figure(1)
clf
pmap(lon,lat,log10(small_c))
caxis([1.5 2.5])
print -dpng -r300 figs/mean_small_c_run33

figure(1)
clf
pmap(lon,lat,log10(diat_c+diaz_c+small_c))
caxis([1.6 2.3])
print -dpng -r300 figs/mean_c_run33


