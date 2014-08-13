%remove the longitudinal trend from the
%data

function [data_no_trend, trend]=lontrend(data)

load latlon
data_bar = nan*data;
trend = nan*data;
[m,n,p]=size(data);



for k = 1:p
	for r = 1:m
    	p = data(r,:,k);
   	 	i = find(~isnan(p));
   	 	v = data(r,i,k);
    	b = p(i);
   	 	LOn = lon(i);
   	 	a = polyfit(LOn,b,1); %finds the coefficients of a polynomial 
                        %that fits a set of data in a least-squares
                        %sense.
    	trend(r,:,k)=a(1,1)*lon+a(1,2); %removes longitudinal trend 
                                   %of SST from the SST data
        %trend(r,:,k) = mean(b);
end
end

data_no_trend = data-trend;



