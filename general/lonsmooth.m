%function [data_no_trend, trend]=lonsmooth(data,dx)
%
%remove the longitudinal trend from the
%data

function [data_no_trend, trend]=lonsmooth(data,dx)

data_bar = nan*data;
trend = nan*data;
[m,n,p]=size(data);
warning('off', 'all')


for k = 1:p
	for r = 1:m
    	for c = 1:n
    		
    		if (c > dx & c < n-dx)
    			p = data(r,c-dx:c+dx,k);
    		elseif (c <= dx)
    			p = data(r,1:c+dx,k);
    		elseif (c >= n-dx)
    			p = data(r,c-dx:n,k);
    		end
    		
   	 		i = find(~isnan(p));
    		b = p(i);
    		trend(r,c,k) = mean(b);

end
end
end

data_no_trend = data-trend;



