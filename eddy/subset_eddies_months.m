
%--------------------------------------------------------------------------------
%Set eddy parameters
%--------------------------------------------------------------------------------


MIN_AMP = 0
MAX_AMP = 1e4
MIN_DUR = 16
MAX_DUR = 1e5

MINMONTH = 1
MAXMONTH = 3

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
radius                             = radius(f2);
prop_speed                         = prop_speed(f2);
track_jday                         = track_jday(f2);
x                                  = x(f2);
y                                  = y(f2);
k                                  = k(f2);



%index by month and subset

[y,m,d]=jd2jdate(track_jday);
f3=find(m>=MINMONTH & m<=MAXMONTH);

%now subset eddy fields
id                                 = id(f3);
eid 							   = eid(f3);
amp                                = amp(f3);
axial_speed                        = axial_speed(f3);
efold                              = efold(f3);
radius                             = radius(f3);
prop_speed                         = prop_speed(f3);
track_jday                         = track_jday(f3);
x                                  = x(f3);
y                                  = y(f3);
k                                  = k(f3);
ai=find(id>=nneg);
ci=find(id<nneg);


clear f2 f1 l f0 ftmp amp_bar f3 m d y