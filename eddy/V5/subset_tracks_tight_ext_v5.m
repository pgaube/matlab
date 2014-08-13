function subset_tracks_tight_v5(DOMAIN)

%subsets global_tracks_V5_12_weeks in time and space by eddy orgin
%DPATH='/matlab/matlab/domains/';
%DOMAIN='PC_lat_lon'


%Load track and domain
%load global_tracks_V5_12_weeks
load global_tracks_V5
display('WARNING, loading 4 week tracks')
load(['~/matlab/domains/',DOMAIN])

min_lon=min(lon(:));
max_lon=max(lon(:));
max_lat=max(lat(:));
min_lat=min(lat(:));

%subset by space
ii = find(x>=min_lon & x<=max_lon & y>=min_lat & y<=max_lat);
f2=ii;
    
%Now subset data
id                                 = id(f2);
eid 							   = eid(f2);
amp                                = amp(f2);
axial_speed                        = axial_speed(f2);
scale                              = scale(f2);
track_jday                         = track_jday(f2);
x                                  = x(f2);
y                                  = y(f2);
ext_x                              = ext_x(f2);
ext_y                              = ext_y(f2);
k                                  = k(f2);
cyc                                = cyc(f2);
unique_id                          = unique(id);
ai=find(cyc>0);
ci=find(cyc<0);


clearallbut id eid amp axial_speed scale track_jday x y ext_x ext_y k cyc unique_id ai ci DOMAIN DPATH

save([DOMAIN,'_tracks'])
