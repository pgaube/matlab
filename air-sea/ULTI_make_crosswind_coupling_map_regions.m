clear all
% close all

jdays=[2452459:7:2454706];%[2451556:7:2454797];
lj=length(jdays);
tbins=-1e-5:.1e-5:1e-5;
ltb=length(tbins)-1;

qsave_path='~/data/QuickScat/new_mat/';
qsave_head='QSCAT_30_25km_';
load([qsave_path qsave_head num2str(jdays(1))],'lon','lat')
load(['~/data/QuickScat/mat/' qsave_head num2str(jdays(1))],'mask')
slon=lon;slat=lat;
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
        
        DTDN=single(nan(length(r),length(c),lj));
        CRL=DTDN;
    else
        mask(abs(slat)<=15)=nan;
        mask(abs(slat)>=45)=nan;
        r=1:length(slat(:,1));c=1:length(slon(1,:));
    end
    DTDN=single(nan(length(r),length(c),lj));
    CRL=DTDN;
    
    for m=1:lj
        fprintf('\r    loading %03u of %03u\r',m,lj)
        load([qsave_path qsave_head num2str(jdays(m))],'hp66_crlstr','hp66_dtds')
        CRL(:,:,m)=single(hp66_crlstr(r,c)).*mask(r,c);
        DTDN(:,:,m)=single(hp66_dtds(r,c)).*mask(r,c);
        clear hp66*
    end
    
    
    n=DTDN(:);
    y=-CRL(:);
    binned_samps2=nan(1,ltb);
    for i=1:ltb
        bin_est = find(n>=tbins(i) & n<tbins(i+1));
        binned_samps2(i) = double(pmean(y(bin_est)));
        std_samps2(i) = double(pstd(y(bin_est)));
    end
    [Cor,Covar,N,Sig,Xbar,Ybar,sdX,sdY]=pcor(tbins(1:length(tbins)-1),binned_samps2);
    alpha_n(mm)=Cor*sdY/sdX
    
    
    
    figure(1)
    clf
    errorbar(tbins(1:length(tbins)-1),binned_samps2,std_samps2,'k*')
    hold on
    y=tbins(1:length(tbins)-1).*alpha_n(mm);
    plot(tbins(1:length(tbins)-1),y,'k')
    title([curs{mm},'  \alpha = ',num2str(alpha_n(mm))])
    axis tight
    eval(['print -dpng -r300 figs/',curs{mm},'_crst_copco'])

end

save region_crlstr_dtdn_coupling_coeff curs alpha_n