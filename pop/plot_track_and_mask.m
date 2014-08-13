clear
load bwr.pal
%set up parameters
rref=-.1;
set_pop
mm=6;
load GS_rings_cor_tracks_jan_5
load mat/pop_model_domain
figure(1)
clf
[r,c]=imap(30,47,284,325,lat,lon);
pmap(lon(r,c),lat(r,c),nan*mask20(r,c))
hold on
uid=unique(id);
for m=1:length(uid)
    ii=find(id==uid(m));
    if cyc(ii(1))==1
        m_plot(x(ii),y(ii),'r')
        dd=find(k(ii)==1);
        if any(dd)
            m_plot(x(ii(dd)),y(ii(dd)),'r.','markersize',15)
        end    
    elseif cyc(ii(1))<1 & pmean(adens(ii))>0
        m_plot(x(ii),y(ii),'b')
        dd=find(k(ii)==1);
        if any(dd)
            m_plot(x(ii(dd)),y(ii(dd)),'b.','markersize',15)
        end
    end
end
m_contour(lon(r,c),lat(r,c),mask30(r,c),[1 1],'k','linewidth',2)

return
xlabel([num2str(length(find(cyc==1))),' anticyclones, ',num2str(length(find(cyc==-1))),' cyclones'])
title('All tracks that transect region')
print -dpng -r300 figs/pop_GS_rings_cor_tracks
% 

