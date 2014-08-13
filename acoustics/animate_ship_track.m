clear all
load ~/data/aviso/mat/AVISO_25_W_2456477 lon lat
slat=lat;
slon=lon;
load chelle.pal
ff=1;
% load acoustic_track
%
% %try to remove bad data
% ddx=diff(track(:,3));
% ii=find(ddx>1);
% track(ii-2:ii+2,:)=[];
% ddy=diff(track(:,2));
% ii=find(ddy>1);
% track(ii-2:ii+2,:)=[];
%
% ii=find(track(:,3)>-45 & track(:,2)>37 & track(:,2)<40);
% track(ii-2:ii+2,:)=[];
%
% x=180+(180+track(:,3));
% y=track(:,2);
%
% %make jday
% for m=1:length(track(:,1))
%     [month(m),day(m),year(m)]=jul2date(track(m,1),2011);
% end
% jdays=[date2jd(year,month,day)+.5]';
% ijday=min(round(jdays)):max(round(jdays));
%
% ssh_jday=2455770:7:2455819;
%
%
% [r,c]=imap(min(y)-10,max(y)+5,min(x)-10,max(x)+15,slat,slon);
%
% %%%Load SSH data
% SSH=nan(length(r),length(c),length(ssh_jday));
% iSSH=nan(length(r),length(c),length(ijday));
% for rr=1:length(ssh_jday)
%     if exist(['~/data/aviso/mat/AVISO_25_W_',num2str(ssh_jday(rr)),'.mat'])
%         load(['~/data/aviso/mat/AVISO_25_W_',num2str(ssh_jday(rr))],'ssh')
%         SSH(:,:,rr)=ssh(r,c);
%     end
% end
%
%
% %%%Interpolate to daily
% for mm=1:length(r)
%     for nn=1:length(c)
%         iSSH(mm,nn,:)=interp1(ssh_jday,squeeze(SSH(mm,nn,:)),ijday,'linear');
%     end
% end
%
% slat=slat(r,c);slon=slon(r,c);
% save gareth_natl_ssh iSSH SSH slat slon ssh_jday ijday jdays x y
%
% % for m=1:length(ijday)
% % clf
% % pmap(slon,slat,iSSH(:,:,m))
% % drawnow
% % end

load gareth_natl_ssh

for rr=1:length(ijday)
    [yea,mon,day]=jd2jdate(ijday(rr));
    jul=julian(mon,day,yea,yea)
    figure(1)
    clf
    
    pmap(slon,slat,double(iSSH(:,:,rr)));
    hold on
    m_contour(slon,slat,double(iSSH(:,:,rr)),[-500:4:-4],'k--')
    m_contour(slon,slat,double(iSSH(:,:,rr)),[4:4:500],'k')
    caxis([-20 20])
    colormap(chelle)
    title('SSH C.I. 4cm')
    iip=find(jdays<=ijday(rr)+.1 & jdays>=ijday(rr)-.1);
    m_plot(x(iip),y(iip),'w.','markersize',18)
    ipp=find(jdays<=ijday(rr));
    m_plot(x(ipp),y(ipp),'w','linewidth',2)
    title([num2str(yea),'-',num2str(mon),'-',num2str(day),'  yearday ',num2str(jul)])
    eval(['print -dpng -r300 frames/gareth_natl/frame_',num2str(ff)])
    ff=ff+1;
    
end



