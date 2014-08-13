function yi = interp1d_poly(y,x,xi,p)
% function yi = interp1d_poly(y,x,xi,p)
% 1-d polynomial (Lagrange) interpolation
% x, xi column vectors
% interpolates columns of y
% copyright (c) S.C.Kennan (13apr2004)

% p :	order of polynomial
% n :	number of pts. needed
n = p + 1;
% m :	total number of data pts.
% c :	number of columns to data (ie: separate data series)
[m,c] = size(y);
% mi :	total number of interpolation pts.
mi = length(xi);

% if 1xc row vector, make it column vector
x = x(:); xi = xi(:);
if (m==1), y = y(:); [m,c] = size(y); end

di = NaN*ones(mi,c);
yi = NaN*ones(mi,c);

% for each interval
for i=1:m-(n-1),

x_beg = x(i);
x_end = x(i+n-1);
%  find interpolation pts.
Ix = find(xi>=x_beg & xi<=x_end);
Mx = length(Ix);

% for each column
for j=1:c,

%  if data are good and there are interpolation pts. for this interval
My = length(find(isnan(y(i:i+n-1,j))));
if (My==0 & Mx>0),
	%  mean of data positions being used
	xb = (x_end + x_beg)/2;
	%  average separation
	dx = (x_end - x_beg)/(n-1);
	%  distances to pts.
        Di = (xi(Ix)-xb).^2/dx;
        ddi = di(Ix,j);
        yyi = yi(Ix,j);
        %  if this is a better interpolation interval than existing one
        K = find(Di<ddi | isnan(ddi));
        if length(K)>0,
		%  p+1 x pts. to the 0:p powers
		X = (((x(i:i+n-1) - xb)/dx)*ones(1,p+1)).^(ones(n,1)*[0:p]);
		Y = y(i:i+n-1,j);
		%  xi pts. in the interval to the 0:p powers
		Xi = (((xi(Ix) - xb)/dx)*ones(1,p+1)).^(ones(Mx,1)*[0:p]);
		Yi = Xi*inv(X'*X)*X'*Y;
		% reset the distances and int. values
		ddi(K) = Di(K);
		yyi(K) = Yi(K);
		di(Ix,j) = ddi;
		yi(Ix,j) = yyi;
	end
end
end
end
