clear all
ipath='~/data/QuickScat/mat/QSCAT_30_25km_'
spath='~/data/QuickScat/new_mat/QSCAT_30_25km_'

%Set range of dates

jdays=[2451381+7:7:2455154-7];
jdays=[2451556:7:2454706];
[year,month,day]=jd2jdate(jdays);
%loess filter

for m=127:length(jdays)
    yearday(m) = year(m)*1000+julian(month(m),day(m),year(m));
    calday(m) =  year(m)*10000+month(m)*100+day(m);
    fprintf('\r   filtering %08u \r',calday(m))
    
    load([ipath num2str(jdays(m))],'dtds_week','dtdn_week','lat','lon')
    if exist('dtds_week')
        tic;lp=smooth2d_loess(dtds_week,lon(1,:),lat(:,1),6,6,lon(1,:),lat(:,1));toc
        hp66_dtds=dtds_week-lp;
        lp=smooth2d_loess(dtdn_week,lon(1,:),lat(:,1),6,6,lon(1,:),lat(:,1));
        hp66_dtdn=dtdn_week-lp;
        
        eval(['save -append ' [spath num2str(jdays(m))] ' hp*'])
        clear *_week lp hp*
    end
end

