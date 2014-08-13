load /Volumes/matlab/data/eddy/V4/global_tracks_V4.mat
load /Volumes/matlab/data/eddy/V4/mat/AVISO_25_W_2454818.mat lat lon

imap=nan*lat;
for n=1:length(imap(:,1))*length(imap(1,:))
	imap(n)=(n-1)+1;
end

for m=1:length(x)
	r=find(lat(:,1)>= gy(m)-.1 & lat(:,1)<= gy(m)+.1);
	c=find(lon(1,:)>= gx(m)-.1 & lon(1,:)<= gx(m)+.1);
	i_grid(m)=imap(r,c);
end

save -append /Volumes/matlab/data/eddy/V4/global_tracks_V4.mat i_grid
	
