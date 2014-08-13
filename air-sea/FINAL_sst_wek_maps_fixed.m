%loads SeaWiFS CHL data
clear all
close all


jdays=[2452459:7:2455147];%[2452459:7:2454489];%[2451556:7:2454797];
lj=length(jdays);

asave_path='~/data/eddy/V5/mat/';
asave_head='AVISO_25_W_';
qsave_path='~/data/QuickScat/new_mat/';
qsave_head='QSCAT_30_25km_';
osave_path='~/data/ReynoldsSST/mat/';
osave_head='OI_25_30_';
fsave_path='~/data/QuickScat/ULTI_mat3/';

load([asave_path asave_head num2str(jdays(1))],'lon','lat')
slat=lat;
slon=lon;
load([osave_path osave_head num2str(jdays(1))],'lon','lat')
olat=lat;
olon=lon;
load([qsave_path qsave_head num2str(jdays(100))],'lon','lat')


[rs,cs]=imap(min(lat(:)),max(lat(:)),1,1,slat,slon);
[ro,co]=imap(min(lat(:)),max(lat(:)),1,1,olat,olon);


% wek_sst=nan(length(lat(:,1)),1440,lj);
% wek_crlg=wek_sst;


ff=f_cor(lat);
ff=(8640000./(1020.*ff));
alpha=0.32;
nf=f_cor(lat)./f_cor(30);
load coupco_map_crlstr beta_*
ddo=1;

for m=1:lj
    fprintf('\r    loading %03u of %03u\r',m,lj)
    load([qsave_path qsave_head num2str(jdays(m))],'hp66_dtdn','hp66_dtds')
    if exist('hp66_dtdn','var')
        
        %sst
        %
        
        [yea,mon,day]=jd2jdate(jdays(m));
        hp_wek_sst_week_fixed=ff.*((0.01.*hp66_dtds)+(0.01*.2.*hp66_dtdn));
        
        eval(['save ',[fsave_path qsave_head num2str(jdays(m))],' hp_wek_sst_week_fixed lat lon'])
        clear hp66_* hp_*
    else
        eval(['save ',[fsave_path qsave_head num2str(jdays(m))],' lat lon'])
    end
    
end
