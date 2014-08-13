
function [lon,lat,den_grid]=eddy_density(x,y)
%function [lon,lat,den_grid]=eddy_density(x,y)
%make map domain
lat=[-60:.5:60];
lon=[0:.5:359];
[lon,lat]=meshgrid(lon,lat);
den_grid=zeros(size(lat));

%grid eddy locs using min dist
for m=1:length(x)
	tx=x(m);
	ty=y(m);
	tmpxs=floor(tx)-1:.5:ceil(tx)+1;
	tmpys=floor(ty)-1:.5:ceil(ty)+1;
    disx = abs(tmpxs-tx);
    disy = abs(tmpys-ty);
    iminx=find(disx==min(disx));
    iminy=find(disy==min(disy));
    cx=tmpxs(iminx(1));
    cy=tmpys(iminy(1));
    r=find(lat(:,1)>=cy-.09 & lat(:,1)<=cy+.09); %added this because FUCKING MATLAB has some sort of inharent rounding error!
    c=find(lon(1,:)>=cx-.09 & lon(1,:)<=cx+.09);
    den_grid(r,c)=den_grid(r,c)+1;
end    
    
den_grid(den_grid==0)=nan;

%{
pmap(lon,lat,den_grid,'blank');
title('Eddy Density')
c=colorbar;
%axes(c)
%ylabel('Number of Eddies')
%}

