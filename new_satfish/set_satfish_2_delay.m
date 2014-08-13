global DATA_DIR
global HOME_DIR
global IMAGE_DIR
global HDF_DIR
global MAT_DIR
global COMP_MAT_DIR
global SW_DIR
global d
global s
global jd
global ran

set_satfish


%make date vec
s=datevec(date);
jd=date2jd(s(1),s(2),s(3))+.5;
[s(1),s(2),s(3)]=jd2jdate(jd-2);
d=julian(s(2),s(3),s(1),s(1));
