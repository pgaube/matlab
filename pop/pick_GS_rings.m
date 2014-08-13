clear
%set up parameters
rref=-.1;
set_pop
mm=5;

%now subset by space
load GS_rings_tracks_run14_jan_5 
eval(['ii=find(pop_eddies.y>',curs{mm},'_domain(1) & pop_eddies.y<',curs{mm},'_domain(2) & pop_eddies.x>',curs{mm},'_domain(3) & pop_eddies.x<',curs{mm},'_domain(4) & pop_eddies.age>1);']);
x=pop_eddies.x(ii);
y=pop_eddies.y(ii);
k=pop_eddies.k(ii);
eid=pop_eddies.eid(ii);
id=pop_eddies.id(ii);
cyc=pop_eddies.cyc(ii);
amp=pop_eddies.amp(ii);
track_jday=pop_eddies.track_jday(ii);
radius=pop_eddies.radius(ii);
age=pop_eddies.age(ii);

adens=nan*x;
adens(cyc==1)=-1;
adens(cyc==-1)=1;

load cor_ssh_3chl_out r0 lon lat
r0(:,:,9)=smoothn(r0(:,:,9),20);
igood=zeros(size(x));
iorgin=igood;
for m=1:length(x)
    [r,c]=imap(y(m)-.125,y(m)+.125,x(m)-.125,x(m)+.125,lat,lon);
%     r0(r(1),c(1),9)
    if rref<0
        if r0(r(1),c(1),9)<=rref
            igood(m)=1;
            if k(m)==1
                iorgin(m)=1;
            end
        end
    elseif rref>0
        if r0(r(1),c(1),9)>=rref
            igood(m)=1;
            if k(m)==1
                iorgin(m)=1;
            end
        end
    end
end

ii=find(igood==1);
uid=unique(id(ii));
ii=sames(uid,id);
x=x(ii);
y=y(ii);
k=k(ii);
id=id(ii);
age=age(ii);
eid=eid(ii);
cyc=cyc(ii);
adens=adens(ii);
amp=amp(ii);
radius=radius(ii);
track_jday=track_jday(ii);
save GS_rings_cor_tracks_jan_5  x y k id cyc radius track_jday amp adens


figure(1)
clf
[r,c]=imap(30,47,284,325,lat,lon);
pmap(lon(r,c),lat(r,c),nan*r0(r,c,9))
hold on
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
m_contour(lon(r,c),lat(r,c),r0(r,c,9),[rref rref],'k','linewidth',2)


xlabel([num2str(length(find(cyc==1))),' anticyclones, ',num2str(length(find(cyc==-1))),' cyclones'])
title('All tracks that transect region')

figure(2)
clf
ii=find(amp>=10&age>=4)
uid=unique(id(ii));
x=x(ii);
y=y(ii);
k=k(ii);
id=id(ii);
age=age(ii);
eid=eid(ii);
cyc=cyc(ii);
adens=adens(ii);
amp=amp(ii);
radius=radius(ii);
track_jday=track_jday(ii);


figure(3)
clf
[r,c]=imap(30,47,284,325,lat,lon);
pmap(lon(r,c),lat(r,c),nan*r0(r,c,9))
hold on
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
m_contour(lon(r,c),lat(r,c),r0(r,c,9),[rref rref],'k','linewidth',2)

ii=sames(uid,id);
xlabel([num2str(length(find(cyc(ii)==1))),' anticyclones, ',num2str(length(find(cyc(ii)==-1))),' cyclones'])
title('All tracks that transect region with lt>3 weeks and amp>9 cm')
print -dpng -r300 figs/GS_rings_tracks

save GS_rings_cor_tracks_4_week_amp_10_cm x y k id cyc radius track_jday amp adens



