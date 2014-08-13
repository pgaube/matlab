function [r,c]=imap_4km(min_lat,max_lat,min_lon,max_lon,lat,lon);

%[r,c]=imap(min_lat,max_lat,min_lon,max_lon,lat,lon);


%check to see if lat lon are matrix or vectors
[m,n]=size(lat);
if m==1 | n==1
	r=find(lat>=min_lat-.04 & lat<=max_lat+.04);
	c=find(lon>=min_lon-.04 & lon<=max_lon+.04);
else
	r=find(lat(:,1)>=min_lat-.04 & lat(:,1)<=max_lat+.04);
	c=find(lon(1,:)>=min_lon-.04 & lon(1,:)<=max_lon+.04);
end	
