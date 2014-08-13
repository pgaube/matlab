set_satfish


%make date vec
s=datevec(date);
jd=date2jd(s(1),s(2),s(3))+.5;
[s(1),s(2),s(3)]=jd2jdate(jd-3);
d=julian(s(2),s(3),s(1),s(1));
