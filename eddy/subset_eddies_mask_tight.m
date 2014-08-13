
%--------------------------------------------------------------------------------
% You must have a variable 'mask' in the workspace that is on a 1/4 degree grid, same as gridded
% gx and gy and load eddy file
%--------------------------------------------------------------------------------

f2=nan*id;
h=1;
for l=1:length(id)
    if ~isnan(mask(find(lat(:,1)>=y(ii(l))-.5 & lat(:,1)<=y(ii(l))+.5), ...
    		find(lon(1,:)>=x(ii(l))-.5 & lon(1,:)<=x(ii(l))+.5)));
    	f2(h)=l;
    	h=h+1;
    end
end
f2(isnan(f2))=[];


%now subset eddy fields
id                                 = id(f2);
eid 							   = eid(f2);
amp                                = amp(f2);
axial_speed                        = axial_speed(f2);
scale                              = scale(f2);
track_jday                         = track_jday(f2);
x                                  = x(f2);
y                                  = y(f2);
k                                  = k(f2);
cyc                                = cyc(f2);
unique_id                          = unique(id);
ai=find(id>=nneg);
ci=find(id<nneg);
