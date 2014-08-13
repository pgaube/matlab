clear all
% 
minlat=-60;
maxlat=60;
minlon=0;
maxlon=360;

%first track eddies in AVISO

spath='~/data/eddy/V5/mat/AVISO_25_W_';
% % startjd=2451549; %5 Jan 2000
% % endjd=2453523; %1 Jun 2005


startjd=2453376; %5 Jan 2005
endjd=2453733; %28 Dec 2005

jdays=[startjd:7:endjd];
%     
% 
% % now load SSH data
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
% end
% 
% %%%%% Now interpolate to 5-day week
% njdays=[startjd:5:endjd];
% nSSH=nan(length(r),length(c),length(njdays));
% nMDT=nSSH;
% 
% for m=1:length(slat(:,1))
%     for n=1:length(slon(1,:))
%         nSSH(m,n,:)=interp1(jdays,squeeze(SSH(m,n,:)),njdays);
%         nMDT(m,n,:)=interp1(jdays,squeeze(MDT(m,n,:)),njdays);
%     end
% end
% 
% 
% 
% save tmp_aviso_mdt slat slon njdays nSSH nMDT
% 
% 
% load tmp_aviso_mdt
% % % mdt_eddies=track_eddies_MDT(slon,slat,njdays,nSSH,nMDT,.25,7);
% aviso_eddies=track_eddies_PG(slon,slat,njdays,nSSH,.25,7);
% save test_aviso_tracks_jan_28 aviso_eddies
% 
% return


% % % Now track eddies in model
% spath='/Volumes/ys-home/mat/POP_BEC_JAN_15_2014_';
spath='/glade/u/home/pgaube/mat/POP_BEC_JAN_15_2014_';

pdays=[1:5:386];


% now load pop SSH data
% load /Volumes/ys-home/mat/buff_mask_0_pt_25_degree 
load /glade/u/home/pgaube/mat/buff_mask_0_pt_25_degree 

[rp,cp]=imap(minlat,maxlat,minlon,maxlon,tlat,tlon);
plat=lat(rp,cp);
plon=lon(rp,cp);

pSSH=nan(length(r),length(c),length(pdays));
for m=1:length(pdays)
    if exist([spath,num2str(pdays(m)),'.mat'])
        load([spath,num2str(pdays(m))],'hp66_ssh')
        if exist('hp66_ssh')
            pSSH(:,:,m)=griddata(plon,plat,bp21_ssh(rp,cp),slon,slat,'linear').*mask;
            clear hp66_ssh
        end
    end
%     figure(1)
%     clf
%     pmap(slon,slat,pSSH(:,:,m));
%     title(num2str(m))
%     drawnow
end
jdays_tmp=1:length(pdays);
save tmp_aviso_mdt slat slon jdays jdays_tmp pSSH

load tmp_aviso_mdt
pop_eddies=track_eddies_PG(slon,slat,jdays_tmp,pSSH,.25,5);
pop_eddies.track_jday=jday2pday(pop_eddies.track_jday)
save test_pop_tracks pop_eddies

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
