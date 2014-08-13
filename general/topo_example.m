%Example
load Global_Topography.mat
Topography=Topo;

DOMAIN_Benguela=[0 25 -33 -5];

I1=find(LON_Topo(1,:)>=DOMAIN_Benguela(1) & LON_Topo(1,:)<=DOMAIN_Benguela(2));
I2=find(LAT_Topo(:,1)>=DOMAIN_Benguela(3) & LAT_Topo(:,1)<=DOMAIN_Benguela(4));
LON_Topo2=LON_Topo(I2,I1);clear lon; LAT_Topo2=LAT_Topo(I2,I1);clear lat
Topography=Topo(I2,I1);clear Topo I1 I2
LAT_Topo2=LAT_Topo2(end:-1:1,:);; LON_Topo2=LON_Topo2(end:-1:1,:);
Topography=Topography(end:-1:1,:);


