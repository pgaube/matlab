clear
load bwr.pal
%set up parameters
rref=-.1;
set_pop
mm=6;


load GS_rings_tracks_run14_mdt
minlat=30;
maxlat=50;
minlon=180+(180-70);
maxlon=180+(180-35);

figure(1)
clf
pmap(minlon:maxlon,minlat:maxlat,nan(length(minlat:maxlat),length(minlon:maxlon)))
hold on
uid=unique(pop_eddies.id);
for m=1:length(uid)
    ii=find(pop_eddies.id==uid(m));
    if pop_eddies.cyc(ii(1))==1
        m_plot(pop_eddies.x(ii),pop_eddies.y(ii),'r')
        dd=find(pop_eddies.k(ii)==1);
        if any(dd)
            m_plot(pop_eddies.x(ii(dd)),pop_eddies.y(ii(dd)),'r.','markersize',15)
        end    
    elseif pop_eddies.cyc(ii(1))<1
        m_plot(pop_eddies.x(ii),pop_eddies.y(ii),'b')
        dd=find(pop_eddies.k(ii)==1);
        if any(dd)
            m_plot(pop_eddies.x(ii(dd)),pop_eddies.y(ii(dd)),'b.','markersize',15)
        end
    end
end
title('Eddies tracked in POP')
xlabel([num2str(length(pop_eddies.id(pop_eddies.cyc==-1))),' cyclones and ',num2str(length(pop_eddies.id(pop_eddies.cyc==1))),' anticyclones'])
print -dpng -r300 figs/tracks_from_POP


load GS_rings_tracks_run14_mdt
minlat=30;
maxlat=50;
minlon=180+(180-70);
maxlon=180+(180-35);

figure(1)
clf
pmap(minlon:maxlon,minlat:maxlat,nan(length(minlat:maxlat),length(minlon:maxlon)))
hold on
uid=unique(aviso_eddies.id);
for m=1:length(uid)
    ii=find(aviso_eddies.id==uid(m));
    if aviso_eddies.cyc(ii(1))==1
        m_plot(aviso_eddies.x(ii),aviso_eddies.y(ii),'r')
        dd=find(aviso_eddies.k(ii)==1);
        if any(dd)
            m_plot(aviso_eddies.x(ii(dd)),aviso_eddies.y(ii(dd)),'r.','markersize',15)
        end    
    elseif aviso_eddies.cyc(ii(1))<1
        m_plot(aviso_eddies.x(ii),aviso_eddies.y(ii),'b')
        dd=find(aviso_eddies.k(ii)==1);
        if any(dd)
            m_plot(aviso_eddies.x(ii(dd)),aviso_eddies.y(ii(dd)),'b.','markersize',15)
        end
    end
end
title('Eddies tracked in AVISO')
xlabel([num2str(length(aviso_eddies.id(aviso_eddies.cyc==-1))),' cyclones and ',num2str(length(aviso_eddies.id(aviso_eddies.cyc==1))),' anticyclones'])
print -dpng -r300 figs/tracks_from_AVISO


%now subset by space pop
load GS_rings_tracks_run14_mdt

set_pop
eval(['ii=find(pop_eddies.y>',curs{mm},'_domain(1) & pop_eddies.y<',curs{mm},'_domain(2) & pop_eddies.x>',curs{mm},'_domain(3) & pop_eddies.x<',curs{mm},'_domain(4));']);
x=pop_eddies.x(ii);
y=pop_eddies.y(ii);
k=pop_eddies.k(ii);
eid=pop_eddies.eid(ii);
id=pop_eddies.id(ii);
cyc=pop_eddies.cyc(ii);
ro=pop_eddies.ro(ii);
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
ro=ro(ii);
radius=radius(ii);
track_jday=track_jday(ii);
save GS_rings_cor_tracks_feb_4 x y k id cyc radius track_jday ro adens


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
    elseif cyc(ii(1))<1
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
print -dpng -r300 figs/pop_GS_rings_cor_tracks_feb_4


figure(1)
clf
[r,c]=imap(30,47,284,325,lat,lon);
pmap(lon(r,c),lat(r,c),r0(r,c,9))
hold on
m_contour(lon(r,c),lat(r,c),r0(r,c,9),[rref rref],'k','linewidth',2)
caxis([-.5 .5])
colormap(bwr)
print -dpng -r300 figs/pop_cor

%now subset by space AVISO

load GS_rings_tracks_run14_mdt
set_pop
% x=ext_x;y=ext_y;
eval(['ii=find(aviso_eddies.y>',curs{mm},'_domain(1) & aviso_eddies.y<',curs{mm},'_domain(2) & aviso_eddies.x>',curs{mm},'_domain(3) & aviso_eddies.x<',curs{mm},'_domain(4));']);
x=aviso_eddies.x(ii);
y=aviso_eddies.y(ii);
k=aviso_eddies.k(ii);
id=aviso_eddies.id(ii);
cyc=aviso_eddies.cyc(ii);
ro=aviso_eddies.ro(ii);
track_jday=aviso_eddies.track_jday(ii);
radius=aviso_eddies.radius(ii);



%%%now find cor value of each eddy location

load ~/data/gsm/FINAL_cor_out r0_ssh lon lat
r0=r0_ssh;
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
cyc=cyc(ii);
ro=ro(ii);
track_jday=track_jday(ii);
radius=radius(ii);

adens=nan*x;
adens(cyc==1)=-1;
adens(cyc==-1)=1;
xlabel([num2str(length(find(cyc==1))),' anticyclones, ',num2str(length(find(cyc==-1))),' cyclones'])
title('All tracks that transect region')
save AVISO_GS_rings_cor_tracks_feb_4 x y k id cyc radius track_jday ro adens

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
print -dpng -r300 figs/AVISO_GS_rings_cor_tracks_jab_28

figure(1)
clf
[r,c]=imap(30,47,284,325,lat,lon);
pmap(lon(r,c),lat(r,c),r0(r,c,9))
hold on
m_contour(lon(r,c),lat(r,c),r0(r,c,9),[rref rref],'k','linewidth',2)
caxis([-.5 .5])
colormap(bwr)
print -dpng -r300 figs/sat_cor

xlabel([num2str(length(find(cyc==1))),' anticyclones, ',num2str(length(find(cyc==-1))),' cyclones'])
title('All tracks that transect region')

print -dpng -r300 figs/AVISO_tracks_jan_28


