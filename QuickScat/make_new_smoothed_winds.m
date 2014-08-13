clear all
ipath='~/data/QuickScat/mat/QSCAT_30_25km_'
spath='~/data/QuickScat/new_mat/QSCAT_30_25km_'
fpath='~/data/QuickScat/ULTI_mat4/QSCAT_30_25km_'

%Set range of dates
jdays=2452494;
% jdays=[2452459:7:2455147];
[year,month,day]=jd2jdate(jdays);
%loess filter

load([spath num2str(jdays(1))],'lat','lon')
ff=f_cor(lat);
progressbar
for m=1:length(jdays)
    yearday(m) = year(m)*1000+julian(month(m),day(m),year(m));
    calday(m) =  year(m)*10000+month(m)*100+day(m);
    fprintf('\r   filtering %08u \r',calday(m))
    
%     if exist([ipath num2str(jdays(m)),'.mat'])
%         load([ipath num2str(jdays(m))],'dtds_week','dtdn_week','crlstr_week','lat','lon')
%     end
    load([spath num2str(jdays(m))],'crlstr_week','u_week','v_week')
    if exist('u_week')
        tic
        [lp,flag]=smooth2d_loess(u_week,lon(1,:),lat(:,1),8,8,lon(1,:),lat(:,1));
        lp(flag==1)=nan;
        sm_66_u=lp;
        clear lp
        
        [lp,flag]=smooth2d_loess(v_week,lon(1,:),lat(:,1),8,8,lon(1,:),lat(:,1));
        lp(flag==1)=nan;
        sm_66_v=lp;
        clear lp
    end
    eval(['save -append ' [fpath num2str(jdays(m))] ' *sm_*'])
    clear *_week lp
    progressbar(m/length(jdays))
end


