%set up parameters
rref=-.2;
set_pop
mm=5;

%now subset by space
load pop_run14_tracks
eval(['ii=find(y>',curs{mm},'_domain(1) & y<',curs{mm},'_domain(2) & x>',curs{mm},'_domain(3) & x<',curs{mm},'_domain(4));']);
x=x(ii);
y=y(ii);
k=k(ii);
id=id(ii);
cyc=cyc(ii);
adens=adens(ii);
amp=amp(ii);
track_jday=track_jday(ii);

ii=find(k>=lt(mm));
uid=unique(id(ii));
ii=sames(uid,id);
x=x(ii);
y=y(ii);
k=k(ii);
id=id(ii);
cyc=cyc(ii);
adens=adens(ii);
amp=amp(ii);
track_jday=track_jday(ii);
save tmp_cor_tracks x y k id cyc adens amp track_jday
%%%now find cor value of each eddy location

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
cyc=cyc(ii);
adens=adens(ii);
amp=amp(ii);
track_jday=track_jday(ii);

[numa,numc,numm,numt]=deal(0);
figure(1)
clf
[r,c]=imap(30,47,284,325,lat,lon);
pmap(lon(r,c),lat(r,c),nan*r0(r,c,9))
hold on
for m=1:length(uid)
    ii=find(id==uid(m));
    if cyc(ii(1))==1 & pmean(adens(ii))<0
        m_plot(x(ii),y(ii),'r')
        dd=find(k(ii)==1);
        if any(dd)
            m_plot(x(ii(dd)),y(ii(dd)),'r.','markersize',15)
        end
        numa=numa+1;
    elseif cyc(ii(1))<1 & pmean(adens(ii))<0
        m_plot(x(ii),y(ii),'k')
        dd=find(k(ii)==1);
        if any(dd)
            m_plot(x(ii(dd)),y(ii(dd)),'k.','markersize',15)
        end
        numt=numt+1;
    elseif cyc(ii(1))<1 & pmean(adens(ii))>0
        m_plot(x(ii),y(ii),'b')
        dd=find(k(ii)==1);
        if any(dd)
            m_plot(x(ii(dd)),y(ii(dd)),'b.','markersize',15)
        end
        numc=numc+1;
    elseif cyc(ii(1))==1 & pmean(adens(ii))>0
        m_plot(x(ii),y(ii),'g')
        dd=find(k(ii)==1);
        if any(dd)
            m_plot(x(ii(dd)),y(ii(dd)),'g.','markersize',15)
        end
        numm=numm+1;
    end
end
m_contour(lon(r,c),lat(r,c),r0(r,c,9),[rref rref],'k','linewidth',2)


xlabel([num2str(numa),' anticyclones, ',num2str(numm),' MWE, ',num2str(numc),' cyclones, ',num2str(numt),' thinnies, '])
title('All tracks that transect region')
eval(['save ',curs{mm},'_cor_tracks x y k id cyc track_jday amp adens'])

load tmp_cor_tracks
ii=find(igood==1 & iorgin==1);
uid=unique(id(ii));
ii=sames(uid,id);
x=x(ii);
y=y(ii);
k=k(ii);
id=id(ii);
cyc=cyc(ii);
adens=adens(ii);
amp=amp(ii);
track_jday=track_jday(ii);

[numa,numc,numm,numt]=deal(0);
figure(2)
clf
[r,c]=imap(30,47,284,325,lat,lon);
pmap(lon(r,c),lat(r,c),nan*r0(r,c,9))
hold on
for m=1:length(uid)
    ii=find(id==uid(m));
    if cyc(ii(1))==1 & pmean(adens(ii))<0
        m_plot(x(ii),y(ii),'r')
        dd=find(k(ii)==1);
        if any(dd)
            m_plot(x(ii(dd)),y(ii(dd)),'r.','markersize',15)
        end
        numa=numa+1;
    elseif cyc(ii(1))<1 & pmean(adens(ii))<0
        m_plot(x(ii),y(ii),'k')
        dd=find(k(ii)==1);
        if any(dd)
            m_plot(x(ii(dd)),y(ii(dd)),'k.','markersize',15)
        end
        numt=numt+1;
    elseif cyc(ii(1))<1 & pmean(adens(ii))>0
        m_plot(x(ii),y(ii),'b')
        dd=find(k(ii)==1);
        if any(dd)
            m_plot(x(ii(dd)),y(ii(dd)),'b.','markersize',15)
        end
        numc=numc+1;
    elseif cyc(ii(1))==1 & pmean(adens(ii))>0
        m_plot(x(ii),y(ii),'g')
        dd=find(k(ii)==1);
        if any(dd)
            m_plot(x(ii(dd)),y(ii(dd)),'g.','markersize',15)
        end
        numm=numm+1;
    end
end
m_contour(lon(r,c),lat(r,c),r0(r,c,9),[rref rref],'k','linewidth',2)


xlabel([num2str(numa),' anticyclones, ',num2str(numm),' MWE, ',num2str(numc),' cyclones, ',num2str(numt),' thinnies, '])
eval(['save ',curs{mm},'_cor_orgin_tracks x y k id cyc track_jday amp adens igood iorgin'])
title(['All tracks that orriginate in region, r=',num2str(rref),' contoured'])
print -dpng -r300 figs/GS_rings_orgin_tracks
