[m,n,p]=size(tSST);

for r=1:m
	for k=1:p
		
	i = find(~isnan(tSST(r,:,k)));
	v = tSST(r,i,k);
	bar = mean(v);
	tSST(r,i,k)=tSST(r,i,k)-bar;
	end
end

