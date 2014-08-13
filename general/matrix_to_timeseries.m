%Caclulates the time series of value of the data in the region specified in m.file



c=find(lat>=12.5 & lat<=13.5); 
r=find(lon>=264.5 & lon<=265.5);

T = tSST(c,r,:);

for k = 1:length(T(1,1,:))
	
	y = T(:,:,k);
	y = y(:);
	i = find(~isnan(y));
	z = y(i);
	tbar = mean(z);
	x(k) = tbar;
end

		