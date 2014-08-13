function x = timeseries(lat,lon,data)

%function x = timeseries(lat,lon,data)
%Caclulates the time series of value of the data in the region specified in m.file



c=find(lat>=0 & lat<=2); 
r=find(lon>=199 & lon<=201);

T = data(c,r,:);


for k = 1:length(T(1,1,:))
	
	t = T(:,:,k);
	i = find(~isnan(t));
	x = t(i);
	tbar = mean(x(:));
	x = tbar;
end

		