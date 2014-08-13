function [pday_out]=jday2pday(jday_in)
%input jday day number 1:length(pday)
%output pday week number of pop output

pdays=[1740:1773 1801:1873 1901:1973 2001:2073 2101:2139];
jdays=1:length(pdays);

pday_out=nan*jday_in;
for m=1:length(jday_in)
    ii=find(jdays==jday_in(m));
    pday_out(m)=pdays(ii);
end


    