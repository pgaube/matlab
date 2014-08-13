%calculates 29 day overlapping averages of wind componets at 7 day intervals


q=1;

p=15:7:length(U_TAU(1,1,:));
u_tau=nan(length(lat),length(lon),length(p));
v_tau=nan(length(lat),length(lon),length(p));
tau=nan(length(lat),length(lon),length(p));






for p=p
    if p<= length(U_TAU(1,1,:))-14
        u_tau(:,:,q) = nanmean(U_TAU(:,:,p-14:p+14),3);
        v_tau(:,:,q) = nanmean(V_TAU(:,:,p-14:p+14),3);
        tau(:,:,q) = nanmean(TAU(:,:,p-14:p+14),3);
        time_29_7_int=time(p,:);
        q=q+1;
    else end
end

