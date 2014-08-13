
%--------------------------------------------------------------------------------
%Set eddy parameters
%--------------------------------------------------------------------------------


MIN_DUR = 7

f2=nan;
for l=1:length(unique_id)
    ftmp = find(id==unique_id(l));
    if length(ftmp)>= MIN_DUR 
        f2 = cat(1,f2,ftmp);
    end
    clear ftmp
end
f2(1)=[];


%now subset eddy fields
id                                 = id(f2);
amp                                = amp(f2);
axial_speed                        = axial_speed(f2);
est_efold                          = est_efold(f2);
est_radius                         = est_radius(f2);
est_radius_closed_streamline	   = est_radius_closed_streamline(f2);
prop_speed                         = prop_speed(f2);
track_jday                         = track_jday(f2);
x                                  = x(f2);
y                                  = y(f2);
k                                  = k(f2);
unique_id						   = unique(id);

clear f2 f1 l f0 ftmp amp_bar 

%find starts
tt = (MIN_DUR-1)/2;
i_start=find(k<=tt);

i_stop=[];

for l=1:length(unique_id)
        ftmp = find(id==unique_id(l));
        kmax=max(k(ftmp));
        ftmp2=find(k(ftmp)>=kmax-tt);
        i_stop = cat(1,i_stop,ftmp2);
        clear ftmp2 ftmp kmax
end

%now subset eddy fields
start_id                                 = id(i_start);
start_amp                                = amp(i_start);
start_axial_speed                        = axial_speed(i_start);
start_est_efold                          = est_efold(i_start);
start_est_radius                         = est_radius(i_start);
start_est_radius_closed_streamline       = est_radius_closed_streamline(i_start);
start_prop_speed                         = prop_speed(i_start);
start_track_jday                         = track_jday(i_start);
start_x                                  = x(i_start);
start_y                                  = y(i_start);
start_k                                  = k(i_start);

stop_id                                 = id(i_stop);
stop_amp                                = amp(i_stop);
stop_axial_speed                        = axial_speed(i_stop);
stop_est_efold                          = est_efold(i_stop);
stop_est_radius                         = est_radius(i_stop);
stop_est_radius_closed_streamline       = est_radius_closed_streamline(i_stop);
stop_prop_speed                         = prop_speed(i_stop);
stop_track_jday                         = track_jday(i_stop);
stop_x                                  = x(i_stop);
stop_y                                  = y(i_stop);
stop_k                                  = k(i_stop);

