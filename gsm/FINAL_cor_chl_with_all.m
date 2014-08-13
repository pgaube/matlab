% %loads SeaWiFS CHL data
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


load([save_path save_head num2str(jdays(1))],'glon','glat')
load([asave_path asave_head num2str(jdays(1))],'lon','lat')
slat=lat;
slon=lon;
load([qsave_path qsave_head num2str(jdays(200))],'lon','lat')



[rs,cs]=imap(min(lat(:)),max(lat(:)),1,1,slat,slon);
[r,c]=imap(min(lat(:)),max(lat(:)),1,1,glat,glon);

[SSH,WEK,CHL]=deal(single(nan(560,1440,lj)));
r0=nan(560,1440,length(lags));
N=r0;
Sig=r0;

for m=1:lj
	fprintf('\r    loading %03u of %03u\r',m,lj)
    if exist([save_path save_head num2str(jdays(m)) '.mat'])
        load([save_path save_head num2str(jdays(m))],'sp66_chl')
    else
        sp66_chl=nan(size(glat));
    end
    if exist([qsave_path qsave_head num2str(jdays(m)) '.mat'])
        load([qsave_path qsave_head num2str(jdays(m))],'w_ek')
    else
        w_ek=nan(size(lat));
    end
	load([asave_path asave_head num2str(jdays(m))],'ssh','mask')
    CHL(:,:,m)=single(flipud(sp66_chl(r,:)).*mask(rs,:));
	SSH(:,:,m)=single(ssh(rs,:));
    WEK(:,:,m)=single(w_ek);
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
	[r0_ssh(m,n,:),dum,N_ssh(m,n,:),Sig_ssh(m,n,:)]=pcor(CHL(m,n,:),SSH(m,n,:),lags);
    [r0_wek(m,n,:),dum,N_wek(m,n,:),Sig_wek(m,n,:)]=pcor(CHL(m,n,:),WEK(m,n,:),lags);
    da=dfdx_abs(squeeze(SSH(m,n,:))',7);
    [r0_dadt(m,n,:),dum,N_dadt(m,n,:),Sig_dadt(m,n,:)]=pcor(squeeze(CHL(m,n,:))',da,lags);
	end
end


save FINAL_cor_out r0* N* Sig* lat lon
