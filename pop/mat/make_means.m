clear all
% select time period
vv=[1740:2139]; %this is the whole encilada

[i,tm]=size(vv); % tm = number of time levels
load mat/run14_1740 lat lon
% read data
tic
n=0;
[diat_c,diaz_c,small_c]=deal(nan(length(lat(:,1)),length(lon(1,:)),tm);
for nn=vv; % time
    n=n+1;
    flid=num2str(nn)
    %first run14
    if exist(['mat/run14_',num2str(nn),'.mat'])
        load(['mat/run14_',num2str(nn)],'*_biomass'])
        diat_c(:,:,m)=diat_biomass;
        diaz_c(:,:,m)=diaz_biomass;
        small_c(:,:,m)=small_biomass;
    end
end

mean_diat_c=nanmean(diat_c,3);
mean_diaz_c=nanmean(diaz_c,3);
mean_smal_c=nanmean(small_c,3);



