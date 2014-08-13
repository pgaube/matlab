clear all
% 
minlat=30;
maxlat=50;
minlon=180+(180-70);
maxlon=180+(180-35);

%first track eddies in AVISO

spath='~/data/eddy/V5/mat/AVISO_25_W_';
startjd=2451549; %5 Jan 2000
endjd=2453523; %1 Jun 2005
jdays=[startjd:7:endjd];
% %     
% % 
% % % now load SSH data
% load([spath,num2str(startjd)],'lat','lon')
% [r,c]=imap(minlat,maxlat,minlon,maxlon,lat,lon);
% slat=lat(r,c);
% slon=lon(r,c);
% 
% 
% [SSH,MDT]=deal(nan(length(r),length(c),length(jdays)));
% for m=1:length(jdays)
%     load([spath,num2str(jdays(m))],'mdt','ssh')
%     SSH(:,:,m)=ssh(r,c);
%     MDT(:,:,m)=mdt(r,c);
% %     figure(1)
% %     clf
% %     pmap(slon,slat,SSH(:,:,m));
% %     title(num2str(m))
% %     drawnow
% 
%     clear ssh mdt
% ended
% 
% save tmp_aviso_mdt slat slon jdays SSH MDT
% return

load tmp_aviso_mdt
mdt_eddies=track_eddies_MDT(slon,slat,jdays,SSH,MDT,.25,7);
ssh_eddies=track_eddies_PG(slon,slat,jdays,SSH,.25,7);
save test_aviso_GS_mdt

return


% % % Now track eddies in model run 14

spath='~/matlab/pop/mat/run14_';
pdays=[1740:1773 1801:1873 1901:1973 2001:2073 2101:2139];


% now load pop SSH data
load ~/matlab/pop/mat/pop_model_domain.mat lat lon
load(['~/data/eddy/V5/mat/AVISO_25_W_2451549'],'ssh')
mask=nan*ssh;
mask(~isnan(ssh))=1;
mask=mask(r,c);
[rp,cp]=imap(minlat,maxlat,minlon,maxlon,lat,lon);
plat=lat(rp,cp);
plon=lon(rp,cp);

pSSH=nan(length(r),length(c),length(pdays));
for m=1:length(pdays)
    if exist([spath,num2str(pdays(m)),'.mat'])
        load([spath,num2str(pdays(m))],'bp21_ssh')
        if exist('bp21_ssh')
            pSSH(:,:,m)=griddata(plon,plat,bp21_ssh(rp,cp),slon,slat,'linear').*mask;
            clear bp21_ssh
        end
    end
%     figure(1)
%     clf
%     pmap(slon,slat,pSSH(:,:,m));
%     title(num2str(m))
%     drawnow
end
jdays_tmp=1:length(pdays);
pop_eddies=track_eddies_PG(slon,slat,jdays_tmp,pSSH,.25,5);
pop_eddies.track_jday=jday2pday(pop_eddies.track_jday)
save GS_rings_tracks_run14_jan_5

% 
% 
% 
% %%Now track eddies in model Run 33
% 
% spath='~/matlab/pop/mat/run33_';
% pdays=[1740:1773 1801:1873 1901:1973 2001:2073 2101:2139];
%     
% 
% % now load pop SSH data
% load ~/matlab/pop/mat/pop_model_domain.mat lat lon
% load(['~/data/eddy/V5/mat/AVISO_25_W_2451549'],'ssh')
% mask=nan*ssh;
% mask(~isnan(ssh))=1;
% mask=mask(r,c);
% [rp,cp]=imap(minlat,maxlat,minlon,maxlon,lat,lon);
% plat=lat(rp,cp);
% plon=lon(rp,cp);
% 
% pSSH=nan(length(r),length(c),length(pdays));
% for m=1:length(pdays)
%     if exist([spath,num2str(pdays(m)),'.mat'])
%         load([spath,num2str(pdays(m))],'bp21_ssh')
%     else
%         load([spath,num2str(pdays(m-1))],'bp21_ssh')
%     end
%     pSSH(:,:,m)=griddata(plon,plat,bp21_ssh(rp,cp),slon,slat,'linear').*mask;
%     clear bp21_ssh
% end
% 
% ijd=1:5:5*length(pdays);
% pjd=1:7:5*length(pdays);
% ipSSH=nan(length(r),length(c),length(pjd));
% 
% for m=1:length(r)
%     for n=1:length(c)
%         ipSSH(m,n,:)=interp1(ijd,squeeze(pSSH(m,n,:)),pjd,'linear');
%     end
% end
% 
% 
% 
% pop_eddies=track_eddies_PG(slon,slat,pjd,ipSSH,.25);
% jdays_tmp=1:length(pdays);
% pop_eddies=track_eddies3(slon,slat,jdays_tmp,pSSH,.25,5);
% pop_eddies.track_jday=jday2pday(pop_eddies.track_jday)
% save GS_rings_tracks_run33_jan_5
% 
% 
% 
