function adata = avg_work_function(adata,sdata,cdata)

i1 = cdata>0;
adata(i1) = sdata(i1) ./ double(cdata(i1));
return
