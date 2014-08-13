function subset_tracks_tight_ext_v6(DOMAIN)

%subsets global_tracks_V5_12_weeks in time and space by eddy orgin
%DPATH='/matlab/matlab/domains/';
%DOMAIN='PC_lat_lon'


%Load track and domain
%load global_tracks_V5_12_weeks
load global_tracks_ext_V6
display('WARNING, loading 4 week tracks')
load(['~/matlab/domains/',DOMAIN])

min_lon=min(lon(:));
max_lon=max(lon(:));
max_lat=max(lat(:));
min_lat=min(lat(:));

%subset by space
ii = find(ext_x>=min_lon & ext_x<=max_lon & ext_y>=min_lat & ext_y<=max_lat);
f2=ii;
    
%Now subset data
id                                 = id(f2)';
amp                                = a(f2)';
age                                = age(f2)';
axial_speed                        = u(f2)';
scale                              = l(f2)';
track_jday                         = track_jdays(f2)';
ext_x                              = ext_x(f2)';
ext_y                              = ext_y(f2)';
k                                  = k(f2)';
cyc                                = cyc(f2)';
unique_id                          = unique(id)';
ai=find(cyc>0);
ci=find(cyc<0);


clearallbut age id amp axial_speed scale track_jday ext_x ext_y k cyc unique_id ai ci DOMAIN DPATH

save([DOMAIN,'_tracks_V6'])
