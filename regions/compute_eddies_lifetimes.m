clear all
set_regions
mon=['jan';'feb';'mar';'apr';'may';'jun';'jul';'aug';'sep';'oct';'nov';'dec'];
% %
% %
% %
nn=0;
for m=[5 7 8]
    nn=nn+1;
    load(['~/data/eddy/V5/','new_',curs{m},'_lat_lon_tight_orgin_tracks'])
    %lifetime
    uid=unique(id);
    [lt,pd,cc]=deal(nan*uid);
    for n=1:length(uid)
        ii=find(id==uid(n));
        lt(n)=max(k(ii));
        sx=x(ii(1));sy=y(ii(1));
        ex=x(ii(end));ey=y(ii(end));
        pd(n)=111.11*cosd((sy+ey)/2)*sqrt((ex-sx)^2+(ey-sy)^2);
        cc(n)=cyc(ii(1));
    end
    tat(1,nn)=nanmedian(pd)
    tat(2,nn)=nanmedian(lt)
    tat(3,nn)=length(uid)
    reg(nn)=curs(m)
end
