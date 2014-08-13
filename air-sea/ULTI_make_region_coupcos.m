clear all
% close all

jdays=[2452459:7:2454706];%[2451556:7:2454797];
lj=length(jdays);

lj=291
tbins=-1e-5:.1e-5:1e-5;
ltb=length(tbins)-1;

sbins=-1:.1:1;
lsb=length(sbins)-1;

qsave_path='~/data/QuickScat/new_mat/';
qsave_head='QSCAT_30_25km_';
load(['~/data/QuickScat/mat/' qsave_head num2str(jdays(1))],'mask')
load([qsave_path qsave_head num2str(jdays(1))],'lon','lat')
slon=lon;slat=lat;

osave_path='/Users/new_gaube/data/ReynoldsSST/mat/';
osave_head='OI_25_30_';
load([osave_path osave_head num2str(jdays(1))],'lon','lat')
olon=lon;olat=lat;

asave_path='~/data/eddy/V5/mat/';
asave_head='AVISO_25_W_';
load([asave_path asave_head num2str(jdays(1))],'lon','lat')
alon=lon;alat=lat;

dmask=mask;



[year,month,day]=jd2jdate(jdays(1:lj));

curs = {'new_SP',...
    'AGR',...
    'HAW',...
    'EIO',...
    'CAR',...
    'AGU',...
    'new_EIO',...
    'new_SEA',...
    'midlat'};


for mm=1:length(curs)
    if mm~=9
        load(['~/matlab/domains/',curs{mm},'_lat_lon'])
        [r,c]=imap(min(lat),max(lat),min(lon),max(lon),slat,slon);
        [ro,co]=imap(min(lat),max(lat),min(lon),max(lon),olat,olon);
        [ra,ca]=imap(min(lat),max(lat),min(lon),max(lon),alat,alon);
        ddmask=dmask;
    else
        r=1:length(slat(:,1));c=1:length(slon(1,:));
        [ro,co]=imap(min(slat(:)),max(slat(:)),min(slon(:)),max(slon(:)),olat,olon);
        [ra,ca]=imap(min(slat(:)),max(slat(:)),min(slon(:)),max(slon(:)),alat,alon);
        ddmask=dmask;
        ddmask(abs(slat)<=15)=nan;
        ddmask(abs(slat)>=45)=nan;
    end
    [SPD,SST,CRL,DTDN]=deal(single(nan(length(r),length(c),lj)));
    
    for m=1:lj
        fprintf('\r    loading %03u of %03u\r',m,lj)
        load([qsave_path qsave_head num2str(jdays(m))],'hp66_crlstr','hp66_dtds','hp66_wspd')
        load([osave_path osave_head num2str(jdays(m))],'hp66_sst')
%         load([asave_path asave_head num2str(jdays(m))],'mask')
%         CRL(:,:,m)=single(hp66_crlstr(r,c)).*ddmask(r,c).*mask(ra,ca);
%         DTDN(:,:,m)=single(hp66_dtds(r,c)).*ddmask(r,c).*mask(ra,ca);
%         SPD(:,:,m)=single(hp66_wspd(r,c)).*ddmask(r,c).*mask(ra,ca);
%         SST(:,:,m)=single(hp66_sst(ro,co)).*ddmask(r,c).*mask(ra,ca);
        
        CRL(:,:,m)=single(hp66_crlstr(r,c)).*ddmask(r,c);
        DTDN(:,:,m)=single(hp66_dtds(r,c)).*ddmask(r,c);
        SPD(:,:,m)=single(hp66_wspd(r,c)).*ddmask(r,c);
        SST(:,:,m)=single(hp66_sst(ro,co)).*ddmask(r,c);
        
%         figure(1)
%         clf
%         subplot(211)
%         pcolor(double(SPD(:,:,m)));shading flat;axis image
%         caxis([-1 1])
%         subplot(212)
%         pcolor(double(SST(:,:,m)));shading flat;axis image
%         caxis([-1 1])
%         drawnow

        clear hp66* mask
    end
    
    
    DTDN=-DTDN(:);
    CRL=CRL(:);
    SPD=SPD(:);
    SST=SST(:);
    
    for i=1:ltb
        bin_est = find(DTDN>=tbins(i) & DTDN<tbins(i+1));
        binned_samps2(i) = double(pmean(CRL(bin_est)));
        std_samps2(i) = double(pstd(CRL(bin_est)));
    end
    [Cor,Covar,N,Sig,Xbar,Ybar,sdX,sdY]=pcor(tbins(1:length(tbins)-1),binned_samps2);
    alpha_n(mm)=Cor*sdY/sdX
    
    for i=1:lsb
        bin_est = find(SST>=sbins(i) & SST<sbins(i+1));
        binned_samps3(i) = double(pmean(SPD(bin_est)));
        std_samps3(i) = double(pstd(SPD(bin_est)));
    end
    [Cor,Covar,N,Sig,Xbar,Ybar,sdX,sdY]=pcor(sbins(1:length(sbins)-1),binned_samps3);
    alpha_s(mm)=Cor*sdY/sdX
    
    
    
    figure(1)
    clf
    errorbar(tbins(1:length(tbins)-1),binned_samps2,std_samps2,'k*')
    hold on
    y=tbins(1:length(tbins)-1).*alpha_n(mm);
    plot(tbins(1:length(tbins)-1),y,'k')
    title([curs{mm},'  \alpha_c = ',num2str(alpha_n(mm))])
    axis tight
    eval(['print -dpng -r300 figs/',curs{mm},'_crst_copco'])
    
    
    figure(2)
    clf
    errorbar(sbins(1:length(sbins)-1),binned_samps3,std_samps3,'k*')
    hold on
    y=tbins(1:length(sbins)-1).*alpha_s(mm);
    plot(tbins(1:length(sbins)-1),y,'k')
    title([curs{mm},'  \alpha_s = ',num2str(alpha_s(mm))])
    axis tight
    eval(['print -dpng -r300 figs/',curs{mm},'_sst_copco'])
    clear *samps*
end
% return
save region_crlstr_dtdn_coupling_coeff curs alpha_n alpha_s