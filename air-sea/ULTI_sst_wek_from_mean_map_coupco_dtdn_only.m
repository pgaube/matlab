%loads SeaWiFS CHL data
clear all
close all

jdays=[2452571:7:2455147];%[2452459:7:2454713];%[2452459:7:2454489];%[2451556:7:2454797];
lj=length(jdays);

qsave_path='~/data/QuickScat/new_mat/';
qsave_head='QSCAT_30_25km_';
fsave_path='~/data/QuickScat/ULTI_mat4/';

load([qsave_path qsave_head num2str(jdays(100))],'lon','lat')

ff=(8640000./(1020.*f_cor(lat)));
nf=f_cor(lat)./f_cor(30);
rm=f_cor(lat)./f_cor(20);
sst_th=500

load coupco_maps_month_oct_24 sm_alpha_n alpha_n
mask=nan*alpha_n;
mask(find(~isnan(alpha_n)))=1;
ddo=1;

for m=1:lj
    fprintf('\r    loading %03u of %03u\r',m,lj)
    load([qsave_path qsave_head num2str(jdays(m))],'hp66_dtdn','hp66_dtds')
    
    if exist('hp66_dtds')
        [yea,mon,day]=jd2jdate(jdays(m));
        hp_wek_sst_week_cross=ff.*sm_alpha_n.*mask.*-hp66_dtds;
        hp_wek_sst_week_cross(find(abs(rm.*hp_wek_sst_week_cross)>sst_th))=nan;
        eval(['save -append ',[fsave_path qsave_head num2str(jdays(m))],' hp_wek_sst_week_cross'])
    end
    clear hp66_* hp_* u v *week
end

