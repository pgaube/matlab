clear all
ipath='~/data/QuickScat/mat/QSCAT_30_25km_'
spath='~/data/QuickScat/new_mat/QSCAT_30_25km_'
fpath='~/data/QuickScat/FINAL_mat/QSCAT_30_25km_'

%Set range of dates

jdays=[2452459:7:2455147];
[year,month,day]=jd2jdate(jdays);
%loess filter

load([spath num2str(jdays(30))],'lat','lon')
ff=f_cor(lat);
progressbar
for m=1:length(jdays)
    yearday(m) = year(m)*1000+julian(month(m),day(m),year(m));
    calday(m) =  year(m)*10000+month(m)*100+day(m);
    fprintf('\r   filtering %08u \r',calday(m))
    
    if exist([ipath num2str(jdays(m)),'.mat'])
        load([ipath num2str(jdays(m))],'dtds_week','dtdn_week','crlstr_week','lat','lon')
    end
    load([spath num2str(jdays(m))],'crlstr_week','u_week','v_week')
    if exist('dtds_week')
        tic
        [lp,flag]=smooth2d_loess(dtds_week,lon(1,:),lat(:,1),6,6,lon(1,:),lat(:,1));
        lp(flag==1)=nan;
        hp66_dtds=dtds_week-lp;
        clear lp
        
        [lp,flag]=smooth2d_loess(dtdn_week,lon(1,:),lat(:,1),6,6,lon(1,:),lat(:,1));
        lp(flag==1)=nan;
        hp66_dtdn=dtdn_week-lp;
        clear lp
    end
    
    [lp,flag]=smooth2d_loess(crlstr_week,lon(1,:),lat(:,1),6,6,lon(1,:),lat(:,1));
    lp(flag==1)=nan;
    length(find(flag==1))
    hp66_crlstr=crlstr_week-lp;
    wek=(1./((ff*1020))).*hp66_crlstr.*8640000;
    clear lp
    
    wspd_week=sqrt(u_week.^2+v_week.^2);
    [lp,flag]=smooth2d_loess(wspd_week,lon(1,:),lat(:,1),6,6,lon(1,:),lat(:,1));
    lp(flag==1)=nan;
    hp66_wspd=wspd_week-lp;
    clear lp
    
    eval(['save ' [fpath num2str(jdays(m))] ' lat lon *_week hp* wek'])
    clear *_week lp hp* wek
    progressbar(m/length(jdays))
end


