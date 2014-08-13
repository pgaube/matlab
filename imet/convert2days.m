%converts IMET dates into date strings used for plotting

jday = nan(1,length(yday));


for i=1:length(yday)
    [month,day,year] = jul2date(yday(i),2000);
    jday(i) = date2jd(year,month,day);
end

    