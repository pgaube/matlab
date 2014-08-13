%loads SeaWiFS CHL data
clear all
close all

lags=-8:8;

jdays=[2450884:7:2454461];
lj=length(jdays);

save_path='~/data/gsm/mat/';
save_head='GSM_9_21_';
asave_path='~/data/eddy/V5/mat/';
asave_head='AVISO_25_W_';
qsave_path='~/data/QuickScat/mat/';
qsave_head='QSCAT_30_25km_';

load ~/data/eddy/V5/global_tracks_V5
load([save_path save_head num2str(jdays(1))],'glon','glat')
load([asave_path asave_head num2str(jdays(1))],'lon','lat')
slat=lat;
slon=lon;
load([qsave_path qsave_head num2str(jdays(200))],'lon','lat')



[rs,cs]=imap(min(lat(:)),max(lat(:)),1,1,slat,slon);
[r,c]=imap(min(lat(:)),max(lat(:)),1,1,glat,glon);

[SSH,CHL_AC,CHL_CC,CHL_NO,CHL_ED]=deal(single(nan(length(r),length(c),lj)));
r0=SSH(:,:,1);
N=r0;


for m=1:lj
	fprintf('\r    loading %03u of %03u\r',m,lj)
    if exist([save_path save_head num2str(jdays(m)) '.mat'])
        load([save_path save_head num2str(jdays(m))],'sp66_chl')
    else
        sp66_chl=nan(size(glat));
    end
    
	load([asave_path asave_head num2str(jdays(m))],'ssh','mask','idmask')
    
    %%%%%%Make mask for AC and CC
    ia=find(track_jday==jdays(m) & cyc==1);
    ic=find(track_jday==jdays(m) & cyc==-1);
    iac=find(track_jday==jdays(m));
    
    mask_ac=nan*idmask;
    mask_cc=mask_ac;
    mask_ed=mask_cc;
    for dd=1:length(ia)
        mask_ac(abs(idmask)==eid(ia(dd)))=1;
    end
    for dd=1:length(ic)
        mask_cc(abs(idmask)==eid(ic(dd)))=1;
    end
    for dd=1:length(iac)
        mask_ed(abs(idmask)==eid(iac(dd)))=1;
    end
    

    
    mask_no=nan*mask;
    mask_no(isnan(mask_ed))=1;
    
    figure(1)
    clf
    subplot(221)
    pmap(slon,slat,ssh.*mask_ac)
    caxis([-40 40])
    subplot(222)
    pmap(slon,slat,ssh.*mask_cc)
    caxis([-40 40])
    subplot(223)
    pmap(slon,slat,ssh.*mask_ed)
    caxis([-40 40])
    subplot(224)
    pmap(slon,slat,ssh.*mask_no)
    caxis([-40 40])
    return
    
    CHL_AC(:,:,m)=single(flipud(sp66_chl(r,:)).*mask_ac(rs,:));
    CHL_CC(:,:,m)=single(flipud(sp66_chl(r,:)).*mask_cc(rs,:));
	SSH(:,:,m)=single(ssh(rs,:));
% % % %     figure(1)
% % % %     clf
% % % %     pmap(lon,lat,SSH(:,:,m))
% % % %     
% % % %     figure(2)
% % % %     clf
% % % %     pmap(lon,lat,WEK(:,:,m))
% % % %     caxis([-.1 .1])
% % % %     
% % % %     figure(3)
% % % %     clf
% % % %     pmap(lon,lat,CHL(:,:,m))
% % % %     caxis([-.01 .01])
% % % %     drawnow
    
end

% save -v7.3 tmp lat lon CHL SSH
% now do correlation


for m=1:560
	for n=1:1440
    da=dfdx_abs(squeeze(SSH(m,n,:))',7);
    [r0_dadt_ac(m,n,:),dum,N_dadt(m,n,:),Sig_dadt(m,n,:)]=pcor(squeeze(CHL_AC(m,n,:))',da,lags);
    [r0_dadt_cc(m,n,:),dum,N_dadt(m,n,:),Sig_dadt(m,n,:)]=pcor(squeeze(CHL_CC(m,n,:))',da,lags);
	end
end


save FINAL_cor_dsshdt_by_polarity r0* N* Sig* lat lon
