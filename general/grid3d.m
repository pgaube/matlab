%Copyright Peter Gaube 7/11/2006
%must use equal size and dim matrices
%function [xgridded] = biggrid(x)  Regridds data from 9 onto 27 km at step=2 and 54 km at step=6 spatial grid

function [xgridded,n] = biggrid(x)
m = length(x(:,1,1));
n = length(x(1,:,1));
xstep = 3;
ystep = 9;

xgridded = [];
warning('off', 'all')
	for i = 1:xstep
        for j = 1:ystep
		k = (i-1)*ystep+j;
		y(:,:,:,k) = x(i:xstep:m-xstep+i,j:ystep:n-ystep+j,:);
        end
    end
f = ~isnan(y);
i = find(isnan(y));
y(i)=0;
num = sum(f,4);
xgridded = sum(y,4)./num;
%i = find(num==0);
%xgridded(i) = NaN;

	
                                            