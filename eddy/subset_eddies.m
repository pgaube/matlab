
%--------------------------------------------------------------------------------
%Set eddy parameters
%--------------------------------------------------------------------------------


MIN_AMP = 0
MAX_AMP = 1e5
MIN_DUR = 12
MAX_DUR = 1e5
NON_LIN = 0



%subset by NON_LIN

%{
f0=find((axial_speed./prop_speed) >= NON_LIN);

% now subset eddy fields again, removing eddy locations that dont meet
% the non_lin threshold at time t.

id                                 = id(f0);
eid								   = eid(f0);
amp                                = amp(f0);
axial_speed                        = axial_speed(f0);
efold                              = efold(f0);
radius                             = radius(f0);
prop_speed                         = prop_speed(f0);
track_jday                         = track_jday(f0);
x                                  = x(f0);
y                                  = y(f0);
k                                  = k(f0);
eid								   = eid(f0);
%}
unique_id = unique(id);

%
%
%index by amp, do this by subsetting using the mean amp of each eddy
%at the same time we will index by diration.  Do this by looping through
%each id and check diration
%
%


f2=nan;
for l=1:length(unique_id)
    ftmp = find(id==unique_id(l));
    amp_bar = nanmean(amp(ftmp));
    if length(ftmp)>= MIN_DUR & length(ftmp)<= MAX_DUR & amp_bar >= MIN_AMP & amp_bar <= MAX_AMP;
        f2 = cat(1,f2,ftmp);
    end
    clear ftmp
end
f2(1)=[];


%now subset eddy fields
id                                 = id(f2);
eid 							   = eid(f2);
amp                                = amp(f2);
axial_speed                        = axial_speed(f2);
efold                              = efold(f2);
scale                              = scale(f2);
radius                             = radius(f2);
prop_speed                         = prop_speed(f2);
track_jday                         = track_jday(f2);
x                                  = x(f2);
y                                  = y(f2);
gx                                 = gx(f2);
gy                                 = gy(f2);
k                                  = k(f2);
edge_ssh                           = edge_ssh(f2);
month	                           = month(f2);
day	 		                       = day(f2);
year	                           = year(f2);
unique_id                          = unique(id);
ai=find(id>=nneg);
ci=find(id<nneg);


clear f2 f1 l f0 ftmp amp_bar 