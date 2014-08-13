load /Volumes/matlab/data/eddy/V4/global_tracks_V4.mat
load /Volumes/matlab/data/eddy/V4/mat/AVISO_25_W_2454818.mat lat lon

imap=nan*mask;
for n=1:length(mask(:,1))*length(mask(1,:))
	imap(n)=(n-1)+1;
end

imap=imap.*mask;

good_loc=imap(~isnan(imap));
good_loc=good_loc(:);

ii=sames(good_loc,i_grid);

%Now subset data
i_grid=i_grid(ii);
id=id(ii);
eid=eid(ii);
x=x(ii);
y=y(ii);
gx=gx(ii);
gy=gy(ii);
amp=amp(ii);
axial_speed=axial_speed(ii);
efold=efold(ii);
scale=scale(ii);
radius=radius(ii);
track_jday=track_jday(ii);
prop_speed=prop_speed(ii);
k=k(ii);
edge_ssh=edge_ssh(ii);
day=day(ii);
month=month(ii);
year=year(ii);
unique_id=unique(id);
ai=find(id>=nneg);
ci=find(id<nneg);

