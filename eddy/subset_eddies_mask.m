
%--------------------------------------------------------------------------------
% You must have a variable 'mask' in the workspace that is on a 1/4 degree grid, same as gridded
% gx and gy and load eddy file
%--------------------------------------------------------------------------------




f2=nan*id;
for l=1:length(id)
    if ~isnan(mask(find(lat(:,1)>=gy(l)-eps & lat(:,1)<=gy(l)+eps), ...
    		find(lon(1,:)>=gx(l)-eps & lon(1,:)<=gx(l)+eps)));
    	f2(l)=l;
    end	
end
f2(isnan(f2))=[];


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


clear f2 