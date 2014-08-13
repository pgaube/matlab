clear all
close all

set_satfish

cd(AQUA_L1_DATA_DIR)
!rm *


s(3)=s(3)-1

%get file list from server using wget

ye=num2str(s(1));
if s(2)<10
    mo=['0',num2str(s(2))];
else
    mo=num2str(s(2));
end
if s(3)<10
    da=['0',num2str(s(3))];
else
    da=num2str(s(3));
end
% eval(['!/usr/local/bin/wget --post-data="subID=1437&addurl=1&results_as_file=1&sdate=',ye,'-',mo,'-',da,'&edate=',ye,'-',mo,'-',da,'" -O - http://oceandata.sci.gsfc.nasa.gov/search/file_search.cgi | wget -i -'])
eval(['!/usr/local/bin/wget --post-data="subID=1437&addurl=1&results_as_file=1&sdate=',ye,'-',mo,'-',da,'&edate=',ye,'-',mo,'-',da,'" -O - http://oceandata.sci.gsfc.nasa.gov/search/file_search.cgi | !/usr/local/bin/wget -i -'])



