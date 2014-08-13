clear all
load /matlab/matlab/argo/indian_anom_prof
load /matlab/matlab/domains/INDIAN_lat_lon
lat=floor(min(lat)):ceil(max(lat));
lon=floor(min(lon)):ceil(max(lon));
[lon,lat]=meshgrid(lon,lat);
prof_loc_map=zeros(size(lat));

for m=1:length(tlat)
	if ~isnan(tlon(m))
	px=tlon(m);
	py=tlat(m);
	tmpxs=floor(px)-1:ceil(px)+1;
	tmpys=floor(py)-1:ceil(py)+1;
    disx = abs(tmpxs-px);
    disy = abs(tmpys-py);
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