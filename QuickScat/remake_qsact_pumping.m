clear all
ipath='~/data/QuickScat/mat/QSCAT_30_25km_'
spath='~/data/QuickScat/new_mat/QSCAT_30_25km_'
fpath='~/data/QuickScat/FINAL_mat/QSCAT_30_25km_'
opath='~/data/QuickScat/ULTI_mat3/QSCAT_30_25km_'
%Set range of dates

jdays=[2452459:7:2455147]%[2451388:7:2455147];
[year,month,day]=jd2jdate(jdays);
%loess filter

load([spath num2str(jdays(30))],'lat','lon')
ff=f_cor(lat);
progressbar
for m=1:length(jdays)
    yearday(m) = year(m)*1000+julian(month(m),day(m),year(m));
    calday(m) =  year(m)*10000+month(m)*100+day(m);
    fprintf('\r   filtering %08u \r',calday(m))
    
    if exist([fpath num2str(jdays(m)),'.mat'])
        load([fpath num2str(jdays(m))],'hp66_crlstr','lat','lon')
  
        wek=(1./((ff*1020))).*hp66_crlstr.*8640000;
    end
    
    eval(['save -append ' [opath num2str(jdays(m))] ' wek'])
    clear *_week lp hp* wek
    progressbar(m/length(jdays))
end


