
%Copyright Peter Gaube 7/11/2006
%must use equal size and dim matrices
%function [xgridded] = biggrid(x)  Regridds data 

%[1/4 1/4] to [4 /5] latstep = 16 lonstep = 20
%[1/12 1/12] to [1/4 1/4] latstep = 3 lonstep = 3
%[1/12 1/12] to [1/2 1/2] latstep = 6 lonstep = 6

function [xgridded,n] = biggrid(x)
m = length(x(:,1,1));
n = length(x(1,:,1));
latstep = 10;
lonstep = 6;


xgridded = [];
warning('off', 'all')
	for i = 1:latstep
        for j = 1:lonstep
		k = (i-1)*lonstep+j;
		y(:,:,k) = x(i:latstep:m-latstep+i,j:lonstep:n-lonstep+j);
        end
    end
f = ~isnan(y);
i = find(isnan(y));
y(i)=0;
interm = sum(y,3)./sum(f,3);
interm(interm==0)=nan;
n = sum(f,3);
%p = find(n<5);
%interm(p) = nan;
xgridded = interm;