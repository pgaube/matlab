function [r,c]=igrid(min_lat,max_lat,min_lon,max_lon,lat,lon);

%function [r,c]=igrid(min_lat,max_lat,min_lon,max_lon,lat,lon);
%check to see if lat lon are matrix or vectors

[m,n]=size(lat);
if m==1 | n==1
	r=find(lat>=min_lat & lat<=max_lat);
	c=find(lon>=min_lon & lon<=max_lon);
else
	r=find(lat(:,1)>=min_lat & lat(:,1)<=max_lat);
	c=find(lon(1,:)>=min_lon & lon(1,:)<=max_lon);
end	