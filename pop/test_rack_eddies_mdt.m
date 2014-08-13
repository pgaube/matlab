% clear all
% 
load tmp_aviso_ssh slon slat jdays nMDT nSSH
aviso_eddies=track_eddies_MDT(slon,slat,jdays,nMDT,nSSH,.25);
% 
% for m=1:20
%     figure(5)
%     clf
%     pmap(slon,slat,nSSH(:,:,m));caxis([-50 50])
%     hold on
%     ii=find(aviso_eddies.cyc==1 & aviso_eddies.track_jday<=jdays(m));
%     m_plot(aviso_eddies.x(ii),aviso_eddies.y(ii),'k*','markersize',5)
%     ii=find(aviso_eddies.cyc==-1 & aviso_eddies.track_jday<=jdays(m));
%     m_plot(aviso_eddies.x(ii),aviso_eddies.y(ii),'w*','markersize',5)
%     pause(2)
% end
