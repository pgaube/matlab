%loads SeaWiFS CHL data
clear all
close all

jdays=[2452466:7:2455126];%[2452459:7:2454713];%[2452459:7:2454489];%[2451556:7:2454797];
lj=length(jdays);
qsave_path='~/data/QuickScat/new_mat/';
qsave_head='QSCAT_30_25km_';
fsave_path='~/data/QuickScat/ULTI_mat4/';
apath='~/data/eddy/V5/mat/AVISO_25_W_'

load([apath num2str(jdays(30))],'lat','lon')
slat=lat;
slon=lon;
load([qsave_path qsave_head num2str(jdays(100))],'lon','lat')

[rs,cs]=imap(min(lat(:)),max(lat(:)),0,360,slat,slon);

bbad=500*.01;

for m=1:lj
    fprintf('\r    loading %03u of %03u\r',m,lj)
    load([qsave_path qsave_head num2str(jdays(m))],'hp66_dtdn','hp66_dtds')
    load([apath num2str(jdays(m))],'crl')
    
    if exist('hp66_dtds')
        ff=(8640000./(1020.*(f_cor(lat)+crl(rs,cs))));
        norm_hp66_dtdn=ff.*hp66_dtds;
        norm_hp66_dtdn2=ff.*hp66_dtds;
        norm_hp66_dtdn2(abs(norm_hp66_dtdn)>=bbad)=nan;
        eval(['save -append ',[fsave_path qsave_head num2str(jdays(m))],' norm_hp66_dtdn*'])
    end
    clear hp66_* norm* crl
end

