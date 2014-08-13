function [sdata,cdata] = sumcnt_work_function(data,sdata,cdata)

i1 = ~isnan(data);
sdata(i1) = sdata(i1)+data(i1);
cdata(i1) = cdata(i1)+uint8(1);
return
