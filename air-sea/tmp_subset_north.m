
%clear all
%subsets global_tracks_V4 in time and space by eddy orgin
DPATH='/Volumes/matlab/matlab/domains/';
DOMAIN='NORTH_lat_lon';


%Load track and domain
%load global_tracks_V4_16_weeks
load([DPATH,DOMAIN])

min_lon=min(lon(:));
max_lon=max(lon(:));
max_lat=max(lat(:));
min_lat=min(lat(:));

%subset by space
tii = find(x>=min_lon & x<=max_lon & y>=min_lat & y<=max_lat & k==1);
tun=unique(id(tii));

ii=nan;
for l=1:length(tun)
	ftmp = find(id==tun(l));
        ii   = cat(1,ii,ftmp);
end
ii(1)=[];

    
%Now subset data
id=id(ii);
eid=eid(ii);
x=x(ii);
y=y(ii);
amp=amp(ii);
axial_speed=axial_speed(ii);
efold=efold(ii);
radius=radius(ii);
track_jday=track_jday(ii);
prop_speed=prop_speed(ii);
k=k(ii);
edge_ssh=edge_ssh(ii);
unique_id=unique(id);
ai=find(id>=nneg);
ci=find(id<nneg);


%now convert x into lon
%x = 360+x;


clear tti tjdays ttun l ftmp start* end* r itime tmp* ispace ii tracks tid tx ty tamp ...
tax* test_* tjday trop* tyear tday tk tmonth header tpr* tun tii

%save([DOMAIN,'_tracks'])
