clear all
% select time period
vv=[1740:2139]; %this is the whole encilada

[i,tm]=size(vv); % tm = number of time levels
load mat/run14_1740 lat lon
% read data
tic
n=0;
[chl]=deal(nan(length(lat(:,1)),length(lon(1,:)),tm));

for nn=vv; % time
    n=n+1;
    flid=num2str(nn)
    %first run14
    if exist(['mat/run14_',num2str(nn),'.mat'])
        load(['mat/run14_',num2str(nn)],'small_biomass')
        chl(:,:,n)=small_biomass;
        clear small_biomass
    end
end

mean_small_biomass=real(10.^nanmean(log10(chl),3));
mean_lat=lat;
mean_lon=lon;
save mean_small_biomass mean_lat mean_lon mean_small_biomass
figure(1)
clf
pmap(mean_lon,mean_lat,log10(mean_small_biomass))




