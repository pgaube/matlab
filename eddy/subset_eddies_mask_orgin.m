
%--------------------------------------------------------------------------------
% You must have a variable 'mask' in the workspace that is on a 1/4 degree grid, same as gridded
% gx and gy and load eddy file
%--------------------------------------------------------------------------------



uid=unique(id);
good_id=nan*uid;
for l=1:length(uid)
	ii=find(id==uid(l));
	ll=find(k(ii)==1);
	if any(ll)
    if ~isnan(mask(find(lat(:,1)>=y(ii(ll))-.5 & lat(:,1)<=y(ii(ll))+.5), ...
    		find(lon(1,:)>=x(ii(ll))-.5 & lon(1,:)<=x(ii(ll))+.5)));
    	good_id(l)=uid(l);
    end
    end
end
good_id(isnan(good_id))=[];
f2=sames(good_id,id);


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


clear f2 