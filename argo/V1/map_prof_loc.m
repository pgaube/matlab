load /data/argo/eddy_profiles plat plon pjday
load /matlab/data/eddy/V4/mat/AVISO_25_W_2454146 lat lon

%put on grid centered at .25 intervals
%{
lat=lat-.125;
lon=lon-.125;
%}
lat=-80:1:80;
lon=0:1:360;
[lon,lat]=meshgrid(lon,lat);
prof_loc_map=zeros(size(lat));

for m=1:length(plat)
	if ~isnan(plon(m))
	tx=plon(m);
	ty=plat(m);
	tmpxs=floor(tx)-1:ceil(tx)+1;
	tmpys=floor(ty)-1:ceil(ty)+1;
    disx = abs(tmpxs-tx);
    disy = abs(tmpys-ty);
    iminx=find(disx==min(disx));
    iminy=find(disy==min(disy));
    cx=tmpxs(iminx(1));
    cy=tmpys(iminy(1));
    r=find(lat(:,1)>=cy-.09 & lat(:,1)<=cy+.09); %added this because FUCKING MATLAB has some sort of inharent rounding error!
    c=find(lon(1,:)>=cx-.09 & lon(1,:)<=cx+.09);
    
    if any(r)
    if any(c)
    	prof_loc_map(r,c)=prof_loc_map(r,c)+1;
    end
    end
    end
end

   
	prof_loc_map(prof_loc_map==0)=nan;