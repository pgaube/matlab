% %make TS plot of GS eddies
load rings_cor_orgin_tracks
load ~/matlab/pop/mat/pop_model_domain lat lon
cold_core=[1285 1078 4829];
warm_core=[13316 14635];

jdays=min(track_jday):max(track_jday);
[T,S]=deal(nan(20,length(x)));

for m=1:length(jdays)
    if exist(['~/matlab/pop/mat/run14_',num2str(jdays(m)),'.mat'])
        load(['~/matlab/pop/mat/run14_',num2str(jdays(m))],'t','s')
        ii=find(track_jday==jdays(m));
        for n=1:length(ii)
            [r,c]=imap(y(ii(n))-.125,y(ii(n))+.125,x(ii(n))-.125,x(ii(n))+.125,lat,lon);
            T(:,ii(n))=squeeze(t(r(1),c(1),:));
            S(:,ii(n))=squeeze(s(r(1),c(1),:));
        end
    end
    clear t s
end

save GS_rings_TS id cyc T S
load rings_cor_orgin_tracks
load GS_rings_TS id cyc T S
S(S<32)=nan;
figure(1)
clf
set(gcf,'PaperPosition',[1 1 6 6])
hold on
for m=1:length(x)
    if cyc(m)==1
        plot(S(:,m),T(:,m),'r','linewidth',.1)
    else
        plot(S(:,m),T(:,m),'b','linewidth',.1)
    end
end
for cc=1:length(cold_core)
    ii=find(id==cold_core(cc));
    for dd=1:length(ii)
        plot(S(:,ii(dd)),T(:,ii(dd)),'k--','linewidth',1)
    end
end
for cc=1:length(warm_core)
    ii=find(id==warm_core(cc));
    for dd=1:length(ii)
        plot(S(:,ii(dd)),T(:,ii(dd)),'k','linewidth',1)
    end
end
axis([34.8 36.8 0 28])
title('T-S characteristics of GS rings from automated detection')
ylabel('T')
xlabel('S')
text(36,10,'dashed = cold core')
text(36,9,'solid = warm core')
text(36,5,['Na= ',num2str(length(cyc(cyc==1))),', Nc= ',num2str(length(cyc(cyc==-1)))])
set(gca,'fontsize',10,'fontweight','bold','LineWidth',.5,'TickLength',[.01 .05],'layer','top')
print -dpng -r300 figs/GS_TS


%%%now identify just GS rings
igood=zeros(size(x));
for m=1:length(x)
    ii=find(T(:,m)>=15);
    if min(S(ii,m))>35.2
        igood(m)=1;
    end
end
ii=find(igood==1);
% uid=unique(id(ii));
% ii=sames(uid,id);

x=x(ii);
adens=adens(ii);
y=y(ii);
k=k(ii);
id=id(ii);
cyc=cyc(ii);
track_jday=track_jday(ii);
S=S(:,ii);
T=T(:,ii);
save intense_cor_orgin_TS_tracks x y k id cyc track_jday S T adens


figure(2)
clf
set(gcf,'PaperPosition',[1 1 6 6])

hold on
for m=1:length(x)
    if cyc(m)==1
        plot(S(:,m),T(:,m),'r','linewidth',.1)
    else
        plot(S(:,m),T(:,m),'b','linewidth',.1)
    end
end
for cc=1:length(cold_core)
    ii=find(id==cold_core(cc));
    for dd=1:length(ii)
        plot(S(:,ii(dd)),T(:,ii(dd)),'k--','linewidth',1)
    end
end
for cc=1:length(warm_core)
    ii=find(id==warm_core(cc));
    for dd=1:length(ii)
        plot(S(:,ii(dd)),T(:,ii(dd)),'k','linewidth',1)
    end
end
axis([34.8 36.8 0 28])
title('T-S characteristics of configed GS rings from T-S detection')
ylabel('T')
xlabel('S')
text(36,5,['Na= ',num2str(length(cyc(cyc==1))),', Nc= ',num2str(length(cyc(cyc==-1)))])
set(gca,'fontsize',10,'fontweight','bold','LineWidth',.5,'TickLength',[.01 .05],'layer','top')

print -dpng -r300 figs/GS_TS_confirm

return
figure(1)
clf
set(gcf,'PaperPosition',[1 1 6 6])
lon=min(x)-5:max(x)+5;
lat=min(y)-2:max(y)+2;
[numa,numc,numm,numt]=deal(0);

pmap(lon,lat,nan(length(lat),length(lon)))
hold on
uid=unique(id);
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
xlabel([num2str(numa),' anticyclones, ',num2str(numm),' MWE, ',num2str(numc),' cyclones, ',num2str(numt),' thinnies, '])
title('All tracks that transect region')
set(gca,'fontsize',10,'fontweight','bold','LineWidth',.5,'TickLength',[.01 .05],'layer','top')
print -dpng -r300 figs/tracks_GS_TS_confirm
