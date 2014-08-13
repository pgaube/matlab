function new_data=buffnan(data,buff)


new_data=data;
for m=1:length(data(:,1))
	for n=1:length(data(1,:))
		if isnan(data(m,n)) & ...
		   m>buff+1 & ...
		   m<length(data(:,1))-buff & ...
		   n>buff+1 & ...
		   n<length(data(1,:))-buff
			new_data(m-buff:m+buff,n-buff:n+buff)=nan;
		end
	end
end

