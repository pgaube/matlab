load mapped_eddy_properties_V4

tbins=0:.1:8

[n,b]=phist(exp_cor_map(:),tbins);

cpdf=100*cumsum(n./sum(n));
figure(1)
clf
stairs(tbins(1:end-1),cpdf)