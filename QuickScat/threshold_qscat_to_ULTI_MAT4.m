clear all
spath='~/data/QuickScat/ULTI_mat3/QSCAT_30_25km_'
rpath='~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_'

%Set range of dates

jdays=[2452459:7:2455147];
[year,month,day]=jd2jdate(jdays);
%loess filter

load([spath num2str(jdays(30))],'lat','lon')
ff=f_cor(lat);
ff=(8640000./(1020.*ff));
rm=f_cor(lat)./f_cor(20);
load bwr.pal
load chelle.pal
% progressbar
ddo=1;


wek_th=500
sst_th=500

for m=1:length(jdays)
    yearday(m) = year(m)*1000+julian(month(m),day(m),year(m));
    calday(m) =  year(m)*10000+month(m)*100+day(m);
    fprintf('\r   filtering %08u \r',calday(m))
    load([spath num2str(jdays(m))],'wek','hp_wek_sst_week_dtdn','hp_wek_sst_week_fixed','hp_wek_crlg_week')
    
    
    wek(find(abs(rm.*wek)>wek_th))=nan;
    hp_wek_crlg_week(find(abs(rm.*hp_wek_crlg_week)>wek_th))=nan;
    
    if exist('hp_wek_sst_week_dtdn')
        hp_wek_sst_week_dtdn(find(abs(rm.*hp_wek_sst_week_dtdn)>sst_th))=nan;
        hp_wek_sst_week_fixed(find(abs(rm.*hp_wek_sst_week_dtdn)>sst_th))=nan;
    end
    
    
    
    
    eval(['save ' [rpath num2str(jdays(m))] ' lat lon *_week hp* wek'])
end


