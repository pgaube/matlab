function [jday_out]=pday2jday(pday_in)
%input jday day number 1:length(pday)
%output pday week number of pop output

pdays=[1740:1773 1801:1873 1901:1973 2001:2073 2101:2139];
jdays=1:length(pjdays);

jday_out=nan(pday_in);
for m=1:pday_in
    ii=find(pday==pday_in(m));
    jday_out=jday(ii);
end


    