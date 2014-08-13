clear all
load ~/data/aviso/mat/AVISO_25_NRT_2456338 lon lat
slat=lat;
slon=lon;
load chelle.pal
ff=1;
load ~/matlab/resonate/mapped_eddy_properties amplitude_map lon lat
mlon=lon;mlat=lat;
% 
% % load acoustic_track
% load fk003_dtime_lat_lon
% data=fk003_dtime_lat_lon;
% 
% figure(1)
% clf
% plot(data(:,3),data(:,2))
% return
% 
% yeardays=round(min(data(:,1)))+1:round(max(data(:,1)))+1;
% 
% for m=1:length(yeardays)
%     ii=find(data(:,1)+1>=yeardays(m)-.5 & data(:,1)+1<yeardays(m)+.5);
%     y(m)=pmean(data(ii,2));
%     x(m)=180+(180+pmean(data(ii,3)));
% end
% 
% 
% 
% 
% %make jday
% for m=1:length(yeardays)
%     [month(m),day(m),year(m)]=jul2date(yeardays(m),2012);
% end
% jdays=date2jd(year,month,day)+.5;
% 
% 
% 
% [r,c]=imap(min(y)-10,max(y)+5,min(x)-10,max(x)+15,slat,slon);
% 
% %%%Load SSH data
% iSSH=nan(length(r),length(c),length(jdays));
% for rr=1:length(jdays)
%     if exist(['~/data/aviso/mat/AVISO_25_NRT_',num2str(jdays(rr)),'.mat'])
%         load(['~/data/aviso/mat/AVISO_25_NRT_',num2str(jdays(rr))],'ssh')
%         iSSH(:,:,rr)=ssh(r,c);
%     end
% end
% 
% 
% 
% slat=slat(r,c);slon=slon(r,c);
% save falkor_natl_ssh iSSH  slat slon jdays x y
% 


load falkor_natl_ssh
[r,c]=imap(min(y)-10,max(y)+5,min(x)-10,max(x)+15,mlat,mlon);
normer=griddata(mlon,mlat,amplitude_map,slon,slat);
for rr=1:length(jdays)
    [yea,mon,day]=jd2jdate(jdays(rr));
    jul=julian(mon,day,yea,yea)
    figure(1)
    clf
    
    pmap(slon,slat,double(iSSH(:,:,rr)./normer));
    hold on
%     m_contour(slon,slat,double(iSSH(:,:,rr)),[-500:4:-4],'k--')
%     m_contour(slon,slat,double(iSSH(:,:,rr)),[4:4:500],'k')
%     caxis([-20 20])
    caxis([-2.7 2.7])
    colormap(chelle)
    title('SSH C.I. 4cm')
    m_plot(x(1:rr),y(1:rr),'k','linewidth',2)
    m_plot(x(rr),y(rr),'w.','markersize',18)
    title(['SLA/(eddy amplitude) ',num2str(yea),'-',num2str(mon),'-',num2str(day),'  yearday ',num2str(jul)])
%     xlabel('C.I. 4 cm')
    cc=colorbar;
    axes(cc)
%     ylabel('cm')
    eval(['print -dpng -r300 frames/falkor_natl/frame_',num2str(ff)])
    ff=ff+1;
    
end



