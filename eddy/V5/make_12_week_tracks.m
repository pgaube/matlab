
%--------------------------------------------------------------------------------
%Set eddy parameters
%--------------------------------------------------------------------------------

clear all
MIN_AMP = 0
MAX_AMP = 1e5
MIN_DUR = 12
MAX_DUR = 1e5
NON_LIN = 0

load global_tracks_v5

unique_id = unique(id);
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
cyc                                = cyc(f2);
eid 							   = eid(f2);
amp                                = amp(f2);
axial_speed                        = axial_speed(f2);
scale                              = scale(f2);
track_jday                         = track_jday(f2);
x                                  = x(f2);
y                                  = y(f2);
k                                  = k(f2);
unique_id                          = unique(id);
ai=find(id>=nneg);
ci=find(id<nneg);

nneg=103588;

save global_tracks_v5_12_weeks