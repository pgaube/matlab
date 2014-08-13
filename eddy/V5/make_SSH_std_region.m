% clear all
% 
% load global_tracks_v5 track_jday
% 
% jdays=2452424:7:2455159;
% lj=length(jdays);
% % lj=20
% 
% 
% asave_path='~/data/eddy/V5/mat/';
% asave_head='AVISO_25_W_';
% 
% 
% 
load([asave_path asave_head num2str(jdays(1))],'lon','lat')
alat=lat;
alon=lon;

load ~/matlab/domains/AGU_lat_lon
[r,c]=imap(min(lat),max(lat),min(lon),max(lon),alat,alon);
% max_lat=max(lat(:));
% min_lat=min(lat(:));
% max_lon=max(lon(:));
% min_lon=min(lon(:));
% 
% meta_std=nan(length(r),length(c),lj);
% 
% for m=1:lj
% 	fprintf('\r    loading %03u of %03u\r',m,lj)
% 	load([asave_path asave_head num2str(jdays(m))],'ssh')
% 	meta_std(:,:,m)=ssh(r,c);
% 	
% 	clear ssh
% end
% 
% for m=1:length(r)
%     for n=1:length(c)
%         ssh_std(m,n)=pstd(meta_std(m,n,:));
%     end
% end

figure(1)
clf
m_proj('Equidistant cylindrical','lon',[min_lon max_lon],'lat',[min_lat max_lat]);
m_pcolor(alon(r,c),alat(r,c),ssh_std);shading flat
hold on
[c,s]=m_contour(alon(r,c),alat(r,c),ssh_std,[5:5:50],'k')
clabel(c,s)
caxis([0 50])
m_grid('xtick',[round(min_lon):10:round(max_lon)],'ytick',[round(min_lat):5:round(max_lat)],'tickdir','in','color','k','lineweight',1.5,'fontsize',8);
m_coast('patch',[0 0 0]);
daspect([.6 1 1])
colorbar('horiz')
title('Pete std(SSH)')
print -dpng -r300 SEA_SSH_std