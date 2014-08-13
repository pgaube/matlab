% % % loads SeaWiFS CHL data
clear all
close all

lags=-5:5;


startjd=2451549; %5 Jan 2000
endjd=2453523; %1 Jun 2005
jdays=[startjd:7:endjd];
lj=length(jdays);

save_path='~/data/gsm/mat/';
save_head='GSM_9_21_';
asave_path='~/data/eddy/V5/mat/';
asave_head='AVISO_25_W_';

load GS_rings_tracks_run14_sla aviso_eddies

load([save_path save_head num2str(jdays(1))],'glon','glat')
load([asave_path asave_head num2str(jdays(1))],'lon','lat')
slat=lat;
slon=lon;


minlat=30;
maxlat=50;
minlon=180+(180-70);
maxlon=180+(180-35);
% 

[rg,cg]=imap(minlat,maxlat,minlon,maxlon,glat,glon);

[r,c]=imap(minlat,maxlat,minlon,maxlon,slat,slon);

slat=slat(r,c);slon=slon(r,c);
glat=glat(rg,cg);glon=glon(rg,cg);


%%%First load data and interp to 5 day week
minlat=30;
maxlat=50;
minlon=180+(180-70);
maxlon=180+(180-35);

% % first track eddies in AVISO

save_path='~/data/gsm/mat/';
save_head='GSM_9_21_';
asave_path='~/data/eddy/V5/mat/';
asave_head='AVISO_25_W_';

startjd=2451549; %5 Jan 2000
endjd=2453523; %1 Jun 2005
jdays=[startjd:7:endjd];
    
% 
% 
% SSH=nan(length(r),length(c),length(jdays));
% CHL=SSH;
% for m=1:length(jdays)
%     m
%     load([save_path save_head num2str(jdays(m))],'sp66_chl')
% 	load([asave_path asave_head num2str(jdays(m))],'ssh')
%     SSH(:,:,m)=ssh(r,c);
%     CHL(:,:,m)=flipud(sp66_chl(rg,cg));
%     
% %     figure(1)
% %     clf
% %     subplot(211)
% %     pmap(slon,slat,SSH(:,:,m));
% %     subplot(212)
% %     pmap(slon,slat,CHL(:,:,m));
% %     drawnow
%     
%     clear ssh sp66_chl
% end
% 
% %%%%% Now interpolate to 5-day week
% njdays=[startjd:5:endjd];
% nSSH=nan(length(r),length(c),length(njdays));
% nCHL=nSSH;
% 
% for m=1:length(slat(:,1))
%     for n=1:length(slon(1,:))
%         nSSH(m,n,:)=interp1(jdays,squeeze(SSH(m,n,:)),njdays);
%         nCHL(m,n,:)=interp1(jdays,squeeze(CHL(m,n,:)),njdays);
%     end
% end
% 
%         
% 
% save tmp_ssh_chl_obs slat slon nSSH nCHL njdays r c
% 
% % return

load tmp_ssh_chl_obs
[SSH,CHL_AC,CHL_CC,CHL_NO,CHL_ED,CHL]=deal(single(nan(length(r),length(c),lj)));
r0=SSH(:,:,1);
N=r0;


for m=1:length(njdays)
	fprintf('\r    loading %03u of %03u\r',m,length(njdays))
    
    ii=find(aviso_eddies.jdays==njdays(m))
            mask=aviso_eddies.mask(:,:,ii);
            amask=nan*mask;
            ia=find(aviso_eddies.track_jday==njdays(m) & aviso_eddies.cyc==1);
            for ike=1:length(ia)
                amask(mask==aviso_eddies.eid(ia(ike)))=1;
            end
            
            cmask=nan*mask;
            ic=find(aviso_eddies.track_jday==njdays(m) & aviso_eddies.cyc==-1);
            for ike=1:length(ic)
                cmask(mask==aviso_eddies.eid(ic(ike)))=1;
            end
            tmask=nan*mask;
            tmask(~isnan(mask))=1;
            
            nmask=nan*mask;
            nmask(isnan(mask))=1;
    
%     figure(1)
%     clf
%     subplot(221)
%     pmap(slon,slat,nSSH(:,:,m).*amask)
%     caxis([-40 40])
%     subplot(222)
%     pmap(slon,slat,nSSH(:,:,m).*cmask)
%     caxis([-40 40])
%     subplot(223)
%     pmap(slon,slat,nSSH(:,:,m).*tmask)
%     caxis([-40 40])
%     subplot(224)
%     pmap(slon,slat,nSSH(:,:,m).*nmask)
%     caxis([-40 40])
    
    
    CHL(:,:,m)=single(nCHL(:,:,m));
    CHL_AC(:,:,m)=single(nCHL(:,:,m).*amask);
    CHL_CC(:,:,m)=single(nCHL(:,:,m).*cmask);
    CHL_NO(:,:,m)=single(nCHL(:,:,m).*nmask);
    CHL_ED(:,:,m)=single(nCHL(:,:,m).*tmask);
	SSH(:,:,m)=single(nSSH(:,:,m));
    
%     figure(2)
%     clf
%     subplot(221)
%     pmap(slon,slat,CHL_AC(:,:,m))
%     caxis([-.1 .1])
%     subplot(222)
%     pmap(slon,slat,CHL_CC(:,:,m))
%     caxis([-.1 .1])
%     subplot(223)
%     pmap(slon,slat,CHL_ED(:,:,m))
%     caxis([-.1 .1])
%     subplot(224)
%     pmap(slon,slat,CHL_NO(:,:,m))
%     caxis([-.1 .1])
% return
    
end

save obs_hp66_ssh_and_hp66_chl_by_polarity slat slon jdays CHL SSH CHL_AC CHL_CC CHL_ED CHL_NO
% % % now do correlation
clear
load obs_hp66_ssh_and_hp66_chl_by_polarity
lags=-5:5;

[r0,ar0,cr0,N,aN,cN]=deal(nan(length(slat(:,1)),length(slon(1,:)),length(lags)));
for m=1:length(slat(:,1))
    for n=1:length(slon(1,:))
        [r0(m,n,:),dum,N(m,n,:),dd]=pcor(squeeze(CHL(m,n,:))',squeeze(SSH(m,n,:))',lags);
        [ar0(m,n,:),dum,aN(m,n,:),dd]=pcor(squeeze(CHL_AC(m,n,:))',squeeze(SSH(m,n,:))',lags);
        [cr0(m,n,:),dum,cN(m,n,:),dd]=pcor(squeeze(CHL_CC(m,n,:))',squeeze(SSH(m,n,:))',lags);
        [tr0(m,n,:),dum,tN(m,n,:),dd]=pcor(squeeze(CHL_ED(m,n,:))',squeeze(SSH(m,n,:))',lags);
        [nr0(m,n,:),dum,nN(m,n,:),dd]=pcor(squeeze(CHL_NO(m,n,:))',squeeze(SSH(m,n,:))',lags);
    end
end


save obs_cor_0 *r0 *N slon slat
