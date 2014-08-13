%set up parameters
rref=-.2;
set_pop
mm=5;

%now subset by space
load GS_rings_tracks_aviso_jan_5 
% x=ext_x;y=ext_y;
eval(['ii=find(aviso_eddies.y>',curs{mm},'_domain(1) & aviso_eddies.y<',curs{mm},'_domain(2) & aviso_eddies.x>',curs{mm},'_domain(3) & aviso_eddies.x<',curs{mm},'_domain(4));']);
x=aviso_eddies.x(ii);
y=aviso_eddies.y(ii);
k=aviso_eddies.k(ii);
id=aviso_eddies.id(ii);
cyc=aviso_eddies.cyc(ii);
amp=aviso_eddies.amp(ii);
track_jday=aviso_eddies.track_jday(ii);
radius=aviso_eddies.radius(ii);

adens=nan*x;
adens(cyc==1)=-1;
adens(cyc==-1)=1;
save tmp_cor_tracks_AVISO_jan_5  x y k id cyc adens amp track_jday radius
figure(1)
clf
pmap(min(x)-10:max(x)+10,min(y)-5:max(y)+5,[x' y' id' cyc' track_jday' k'],'new_tracks_starts')



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
amp=amp(ii);
track_jday=track_jday(ii);
radius=radius(ii);

[numa,numc,numm,numt]=deal(0);
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
        numa=numa+1;
    elseif cyc(ii(1))<1
        m_plot(x(ii),y(ii),'b')
        dd=find(k(ii)==1);
        if any(dd)
            m_plot(x(ii(dd)),y(ii(dd)),'b.','markersize',15)
        end
        numc=numc+1;
    end
end
m_contour(lon(r,c),lat(r,c),r0(r,c,9),[rref rref],'k','linewidth',2)


xlabel([num2str(numa),' anticyclones,',num2str(numc),' cyclones.'])
title('All tracks that transect region')
eval(['save ',curs{mm},'_cor_tracks_AVISO x y k id cyc radius  track_jday amp'])

load tmp_cor_tracks_AVISO
ii=find(igood==1 & iorgin==1 & y>=34);%add lat criteria to make sure no southern eddies
uid=unique(id(ii));
ii=sames(uid,id);
x=x(ii);
y=y(ii);
k=k(ii);
id=id(ii);
cyc=cyc(ii);
amp=amp(ii);
track_jday=track_jday(ii);
radius=radius(ii);

[numa,numc,numm,numt]=deal(0);
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
        numa=numa+1;
    elseif cyc(ii(1))<1
        m_plot(x(ii),y(ii),'b')
        dd=find(k(ii)==1);
        if any(dd)
            m_plot(x(ii(dd)),y(ii(dd)),'b.','markersize',15)
        end
        numc=numc+1;
    end
end
m_contour(lon(r,c),lat(r,c),r0(r,c,9),[rref rref],'k','linewidth',2)


xlabel([num2str(numa),' anticyclones,',num2str(numc),' cyclones.'])
title(['All tracks that orriginate in region, r=',num2str(rref),' contoured'])
print -dpng -r300 figs/AVISO_GS_rings_orgin_tracks
eval(['save ',curs{mm},'_cor_orgin_tracks_AVISO radius x y k id cyc track_jday amp'])

load tmp_cor_tracks_AVISO
ii=find(igood==1 & y>=34); %add lat criteria to make sure no southern eddies
uid=unique(id(ii));
ii=sames(uid,id);
x=x(ii);
y=y(ii);
k=k(ii);
id=id(ii);
cyc=cyc(ii);
amp=amp(ii);
track_jday=track_jday(ii);
radius=radius(ii);

[numa,numc,numm,numt]=deal(0);
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
        numa=numa+1;
    elseif cyc(ii(1))<1
        m_plot(x(ii),y(ii),'b')
        dd=find(k(ii)==1);
        if any(dd)
            m_plot(x(ii(dd)),y(ii(dd)),'b.','markersize',15)
        end
        numc=numc+1;
    end
end
m_contour(lon(r,c),lat(r,c),r0(r,c,9),[rref rref],'k','linewidth',2)


xlabel([num2str(numa),' anticyclones,',num2str(numc),' cyclones.'])
title(['All tracks that transverse in region, r=',num2str(rref),' contoured'])
print -dpng -r300 figs/AVISO_GS_rings_tracks
eval(['save ',curs{mm},'_cor_tracks_AVISO x radius y k id cyc track_jday amp'])