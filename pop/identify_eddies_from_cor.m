clear
load bwr.pal
%set up parameters
rref=-.1;
set_pop
mm=6;
% 

% load GS_rings_tracks_run14_mdt
% minlat=30;
% maxlat=50;
% minlon=180+(180-70);
% maxlon=180+(180-35);
% % 
% figure(1)
% clf
% pmap(minlon:maxlon,minlat:maxlat,nan(length(minlat:maxlat),length(minlon:maxlon)))
% hold on
% uid=unique(pop_eddies.id);
% for m=1:length(uid)
%     ii=find(pop_eddies.id==uid(m));
%     if pop_eddies.cyc(ii(1))==1
%         m_plot(pop_eddies.x(ii),pop_eddies.y(ii),'r')
%         dd=find(pop_eddies.k(ii)==1);
%         if any(dd)
%             m_plot(pop_eddies.x(ii(dd)),pop_eddies.y(ii(dd)),'r.','markersize',5)
%         end    
%     elseif pop_eddies.cyc(ii(1))<1
%         m_plot(pop_eddies.x(ii),pop_eddies.y(ii),'b')
%         dd=find(pop_eddies.k(ii)==1);
%         if any(dd)
%             m_plot(pop_eddies.x(ii(dd)),pop_eddies.y(ii(dd)),'b.','markersize',5)
%         end
%     end
% end
% title('Eddies tracked in POP')
% xlabel([num2str(length(pop_eddies.id(pop_eddies.cyc==-1))),' cyclones and ',num2str(length(pop_eddies.id(pop_eddies.cyc==1))),' anticyclones'])
% print -dpng -r300 figs/tracks_from_POP
% 
% 
% load GS_rings_tracks_run14_mdt
% minlat=30;
% maxlat=50;
% minlon=180+(180-70);
% maxlon=180+(180-35);
% 
% figure(1)
% clf
% pmap(minlon:maxlon,minlat:maxlat,nan(length(minlat:maxlat),length(minlon:maxlon)))
% hold on
% uid=unique(aviso_eddies.id);
% for m=1:length(uid)
%     ii=find(aviso_eddies.id==uid(m));
%     if aviso_eddies.cyc(ii(1))==1
%         m_plot(aviso_eddies.x(ii),aviso_eddies.y(ii),'r')
%         dd=find(aviso_eddies.k(ii)==1);
%         if any(dd)
%             m_plot(aviso_eddies.x(ii(dd)),aviso_eddies.y(ii(dd)),'r.','markersize',5)
%         end    
%     elseif aviso_eddies.cyc(ii(1))<1
%         m_plot(aviso_eddies.x(ii),aviso_eddies.y(ii),'b')
%         dd=find(aviso_eddies.k(ii)==1);
%         if any(dd)
%             m_plot(aviso_eddies.x(ii(dd)),aviso_eddies.y(ii(dd)),'b.','markersize',5)
%         end
%     end
% end
% title('Eddies tracked in AVISO')
% xlabel([num2str(length(aviso_eddies.id(aviso_eddies.cyc==-1))),' cyclones and ',num2str(length(aviso_eddies.id(aviso_eddies.cyc==1))),' anticyclones'])
% print -dpng -r300 figs/tracks_from_AVISO


%now subset by space pop
% load GS_rings_tracks_run14_mdt
% 
% set_pop
% eval(['ii=find(pop_eddies.y>',curs{mm},'_domain(1) & pop_eddies.y<',curs{mm},'_domain(2) & pop_eddies.x>',curs{mm},'_domain(3) & pop_eddies.x<',curs{mm},'_domain(4) & pop_eddies.age>=4);']);
% cor_eddies.x=pop_eddies.x(ii);
% cor_eddies.y=pop_eddies.y(ii);
% cor_eddies.k=pop_eddies.k(ii);
% cor_eddies.eid=pop_eddies.eid(ii);
% cor_eddies.id=pop_eddies.id(ii);
% cor_eddies.cyc=pop_eddies.cyc(ii);
% cor_eddies.ro=pop_eddies.ro(ii);
% cor_eddies.track_jday=pop_eddies.track_jday(ii);
% cor_eddies.radius=pop_eddies.radius(ii);
% cor_eddies.age=pop_eddies.age(ii);
% 
% cor_eddies.adens=nan*pop_eddies.x;
% cor_eddies.adens(pop_eddies.cyc==1)=-1;
% cor_eddies.adens(pop_eddies.cyc==-1)=1;
% 
% load cor_ssh_3chl_out r0 lon lat
% r0(:,:,9)=smoothn(r0(:,:,9),20);
% igood=zeros(size(cor_eddies.x));
% iorgin=igood;
% for m=1:length(cor_eddies.x)
%     [r,c]=imap(cor_eddies.y(m)-.125,cor_eddies.y(m)+.125,cor_eddies.x(m)-.125,cor_eddies.x(m)+.125,lat,lon);
% %     r0(r(1),c(1),9)
%     if rref<0
%         if r0(r(1),c(1),9)<=rref
%             igood(m)=1;
%             if pop_eddies.k(m)==1
%                 iorgin(m)=1;
%             end
%         end
%     elseif rref>0
%         if r0(r(1),c(1),9)>=rref
%             igood(m)=1;
%             if pop_eddies.k(m)==1
%                 iorgin(m)=1;
%             end
%         end
%     end
% end
% 
% ii=find(igood==1);
% uid=unique(cor_eddies.id(ii));
% ii=sames(uid,cor_eddies.id);
% cor_eddies.x=cor_eddies.x(ii);
% cor_eddies.y=cor_eddies.y(ii);
% cor_eddies.k=cor_eddies.k(ii);
% cor_eddies.id=cor_eddies.id(ii);
% cor_eddies.age=cor_eddies.age(ii);
% cor_eddies.eid=cor_eddies.eid(ii);
% cor_eddies.cyc=cor_eddies.cyc(ii);
% cor_eddies.adens=cor_eddies.adens(ii);
% cor_eddies.ro=cor_eddies.ro(ii);
% cor_eddies.radius=cor_eddies.radius(ii);
% cor_eddies.track_jday=cor_eddies.track_jday(ii);
% save GS_rings_cor_tracks_feb_4 cor_eddies
% 
% 
% figure(1)
% clf
% [r,c]=imap(30,47,284,325,lat,lon);
% pmap(lon(r,c),lat(r,c),nan*r0(r,c,9))
% hold on
% for m=1:length(uid)
%     ii=find(cor_eddies.id==uid(m));
%     if cor_eddies.cyc(ii(1))==1
%         m_plot(cor_eddies.x(ii),cor_eddies.y(ii),'r')
%         dd=find(cor_eddies.k(ii)==1);
%         if any(dd)
%             m_plot(cor_eddies.x(ii(dd)),cor_eddies.y(ii(dd)),'r.','markersize',5)
%         end    
%     elseif cor_eddies.cyc(ii(1))<1
%         m_plot(cor_eddies.x(ii),cor_eddies.y(ii),'b')
%         dd=find(cor_eddies.k(ii)==1);
%         if any(dd)
%             m_plot(cor_eddies.x(ii(dd)),cor_eddies.y(ii(dd)),'b.','markersize',5)
%         end
%     end
% end
% m_contour(lon(r,c),lat(r,c),r0(r,c,9),[rref rref],'k','linewidth',2)
% 
% 
% xlabel([num2str(length(find(cor_eddies.cyc==1))),' anticyclones, ',num2str(length(find(cor_eddies.cyc==-1))),' cyclones'])
% title('All tracks that transect region')
% print -dpng -r300 figs/pop_GS_rings_cor_tracks_feb_4
% 
% 
% figure(1)
% clf
% [r,c]=imap(30,47,284,325,lat,lon);
% pmap(lon(r,c),lat(r,c),r0(r,c,9))
% hold on
% m_contour(lon(r,c),lat(r,c),r0(r,c,9),[rref rref],'k','linewidth',2)
% caxis([-.5 .5])
% colormap(bwr)
% print -dpng -r300 figs/pop_cor
% % % return

%now subset by space AVISO

load GS_rings_tracks_run14_mdt
set_pop
% x=ext_x;y=ext_y;
eval(['ii=find(aviso_eddies.y>35 & aviso_eddies.y>',curs{mm},'_domain(1) & aviso_eddies.y<',curs{mm},'_domain(2) & aviso_eddies.x>',curs{mm},'_domain(3) & aviso_eddies.x<',curs{mm},'_domain(4)& aviso_eddies.age>=4);']);
aviso_cor_eddies.x=aviso_eddies.x(ii);
aviso_cor_eddies.y=aviso_eddies.y(ii);
aviso_cor_eddies.k=aviso_eddies.k(ii);
aviso_cor_eddies.id=aviso_eddies.id(ii);
aviso_cor_eddies.cyc=aviso_eddies.cyc(ii);
aviso_cor_eddies.ro=aviso_eddies.ro(ii);
aviso_cor_eddies.track_jday=aviso_eddies.track_jday(ii);
aviso_cor_eddies.radius=aviso_eddies.radius(ii);



%%%now find cor value of each eddy location

load ~/data/gsm/FINAL_cor_out r0_ssh lon lat
r0=r0_ssh;
r0(:,:,9)=smoothn(r0(:,:,9),20);
igood=zeros(size(aviso_cor_eddies.x));
iorgin=igood;
for m=1:length(aviso_cor_eddies.x)
    [r,c]=imap(aviso_cor_eddies.y(m)-.125,aviso_cor_eddies.y(m)+.125,aviso_cor_eddies.x(m)-.125,aviso_cor_eddies.x(m)+.125,lat,lon);
%     r0(r(1),c(1),9)
    if rref<0
        if r0(r(1),c(1),9)<=rref
            igood(m)=1;
            if aviso_cor_eddies.k(m)==1
                iorgin(m)=1;
            end
        end
    elseif rref>0
        if r0(r(1),c(1),9)>=rref
            igood(m)=1;
            if aviso_cor_eddies.k(m)==1
                iorgin(m)=1;
            end
        end
    end
end

ii=find(igood==1);
uid=unique(aviso_cor_eddies.id(ii));
ii=sames(uid,aviso_cor_eddies.id);
aviso_cor_eddies.x=aviso_cor_eddies.x(ii);
aviso_cor_eddies.y=aviso_cor_eddies.y(ii);
aviso_cor_eddies.k=aviso_cor_eddies.k(ii);
aviso_cor_eddies.id=aviso_cor_eddies.id(ii);
aviso_cor_eddies.cyc=aviso_cor_eddies.cyc(ii);
aviso_cor_eddies.ro=aviso_cor_eddies.ro(ii);
aviso_cor_eddies.track_jday=aviso_cor_eddies.track_jday(ii);
aviso_cor_eddies.radius=aviso_cor_eddies.radius(ii);

aviso_cor_eddies.adens=nan*aviso_cor_eddies.x;
aviso_cor_eddies.adens(aviso_cor_eddies.cyc==1)=-1;
aviso_cor_eddies.adens(aviso_cor_eddies.cyc==-1)=1;
xlabel([num2str(length(find(aviso_cor_eddies.cyc==1))),' anticyclones, ',num2str(length(find(aviso_cor_eddies.cyc==-1))),' cyclones'])
title('All tracks that transect region')
save AVISO_GS_rings_cor_tracks_feb_4 aviso_cor_eddies

figure(1)
clf
[r,c]=imap(30,47,284,325,lat,lon);
pmap(lon(r,c),lat(r,c),nan*r0(r,c,9))
hold on
for m=1:length(uid)
    ii=find(aviso_cor_eddies.id==uid(m));
    if aviso_cor_eddies.cyc(ii(1))==1
        m_plot(aviso_cor_eddies.x(ii),aviso_cor_eddies.y(ii),'r')
        dd=find(aviso_cor_eddies.k(ii)==1);
        if any(dd)
            m_plot(aviso_cor_eddies.x(ii(dd)),aviso_cor_eddies.y(ii(dd)),'r.','markersize',5)
        end    
    elseif aviso_cor_eddies.cyc(ii(1))<1 & pmean(aviso_cor_eddies.adens(ii))>0
        m_plot(aviso_cor_eddies.x(ii),aviso_cor_eddies.y(ii),'b')
        dd=find(aviso_cor_eddies.k(ii)==1);
        if any(dd)
            m_plot(aviso_cor_eddies.x(ii(dd)),aviso_cor_eddies.y(ii(dd)),'b.','markersize',5)
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

xlabel([num2str(length(find(aviso_cor_eddies.cyc==1))),' anticyclones, ',num2str(length(find(aviso_cor_eddies.cyc==-1))),' cyclones'])
title('All tracks that transect region')

print -dpng -r300 figs/AVISO_tracks_jan_28


