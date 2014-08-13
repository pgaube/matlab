%Cleans stacked data

for k = 1:length(tSST(1,1,:));
	j = find(isnan(sCHL(:,:,k)));
	sst = tSST(:,:,k);
	sst(j) = nan;
	tSST(:,:,k)=sst;
	i = find(isnan(tSST(:,:,k)));
	chl=sCHL(:,:,k);
	chl(i) = nan;
	sCHL(:,:,k)=chl;
end