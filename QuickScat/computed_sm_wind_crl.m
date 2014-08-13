clear all
spath='~/data/QuickScat/new_mat/QSCAT_30_25km_'

%Set range of dates

jdays=[2452459:7:2455147];
[year,month,day]=jd2jdate(jdays);

load([spath num2str(jdays(30))],'lat','lon')


for m=1:length(jdays)
    yearday(m) = year(m)*1000+julian(month(m),day(m),year(m));
    calday(m) =  year(m)*10000+month(m)*100+day(m);
    fprintf('\r   filtering %08u \r',calday(m))
    load([spath num2str(jdays(m))],'sm_u_week','sm_v_week')
    
    sm_wind_crl = dfdx(lat,sm_v_week,.25)-dfdy(sm_u_week,.25);
    
    eval(['save -append ' [spath num2str(jdays(m))] ' sm_wind_crl'])
end


