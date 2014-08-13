clear all
% select time period
vv=[1740:2139]; %this is the whole encilada

[i,tm]=size(vv); % tm = number of time levels
load mat/run14_1740 lat lon
% read data
tic
n=0;
for nn=vv; % time
    n=n+1;
    flid=num2str(nn)
    %first run14
    if exist(['mat/run14_',num2str(nn),'.mat'])
        load(['mat/run14_',num2str(nn)],'z_diat_biomass','z_diaz_biomass','z_small_biomass')
        z_total_biomass=z_diat_biomass+z_diaz_biomass+z_small_biomass;
        eval(['save -append mat/run14_',num2str(nn),' z_total_biomass'])
    end
end
