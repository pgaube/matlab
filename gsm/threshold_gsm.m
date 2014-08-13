clear all
ipath='~/data/gsm/mat/GSM_9_21_'

%Set range of dates

jdays=[2450884:7:2454461];
[year,month,day]=jd2jdate(jdays);
%loess filter

load([ipath num2str(jdays(30))],'glat','glon')

load bwr.pal
load chelle.pal
% progressbar
ddo=1;


for m=1:length(jdays)
    yearday(m) = year(m)*1000+julian(month(m),day(m),year(m));
    calday(m) =  year(m)*10000+month(m)*100+day(m);
    fprintf('\r   filtering %08u \r',calday(m))
    load([ipath num2str(jdays(m))],'sp66_chl')
    
    th_sp66_chl=sp66_chl;
    th_sp66_chl(abs(th_sp66_chl)>.5)=nan;
    
    eval(['save -append ' [ipath num2str(jdays(m))] ' th_sp66_chl'])
    clear sp66_chl th_sp66_chl
end


