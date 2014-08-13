function zi = interp2d(z,y,x,yi,xi,p)
% function yi = interp2d(z,y,x,yi,xi,p)
% 2-d polynomial interpolation
% p must be odd
% x, y, xi, yi column vectors
% z length(y) x length(x) matrix
% copyright (C) S.C.Kennan (13apr2004)

% p :   order of polynomial
% n :   number of pts. needed
n = p + 1;
% m :   total number of y-positions
% n :   total number of x-positions
% mXn :   total number of data pts.
% c :   number of columns to data (ie: separate data series)
[my,mx] = size(z);
% mi :  total number of interpolation pts.
myi = length(yi);
mxi = length(xi);

% if 1xc row vector, make it column vector
x = x(:); y = y(:); xi = xi(:); yi = yi(:);

zi = NaN*ones(myi,mxi);
di = NaN*ones(myi,mxi);

% for each interval, ie: one pair of data at a time
for i=1:my-(n-1),
for j=1:mx-(n-1),

y_beg = y(i);
y_end = y(i+n-1);
x_beg = x(j);
x_end = x(j+n-1);
%  find interpolation pts.
Ix = find(xi>=x_beg & xi<=x_end);
Iy = find(yi>=y_beg & yi<=y_end);
My = length(Iy);
Mx = length(Ix);
%  if data are good and there are interpolation pts. for this interval
Mz = length(find(isnan(z(i:i+n-1,j:j+n-1))));
if (Mz==0 & My>0 & Mx>0),
	%  mean of data positions being used
	xb = (x_end + x_beg)/2;
	yb = (y_end + y_beg)/2;
	%  average separation
	dx = (x_end - x_beg)/(n-1);
	dy = (y_end - y_beg)/(n-1);
	%  distances to pts.
	Di = ones(My,1)*((xi(Ix)'-xb).^2/dx) + ((yi(Iy)-yb).^2/dy)*ones(1,Mx);
	ddi = di(Iy,Ix);
	zzi = zi(Iy,Ix);
	%  if this is a better interpolation interval than existing one
	K = find(Di<ddi | isnan(ddi));
	if length(K)>0, 
		X = (reshape(ones(n,1)*((x(j:j+n-1)'-xb)/dx),n^2,1)* ...
			ones(1,(p+1)^2)).^ ...
			(ones(n^2,1)*reshape(ones(p+1,1)*[0:p],1,(p+1)^2));
		Y = (reshape(((y(i:i+n-1)-yb)/dy)*ones(1,n),n^2,1)* ...
			ones(1,(p+1)^2)).^ ...
			(ones(n^2,1)*reshape([0:p]'*ones(1,p+1),1,(p+1)^2));
		Z = reshape(z(i:i+n-1,j:j+n-1),n^2,1);
		Xi = (reshape(ones(My,1)*((xi(Ix)'-xb)/dx),My*Mx,1)* ...
			ones(1,(p+1)^2)).^ ...
			(ones(My*Mx,1)*reshape(ones(p+1,1)*[0:p],1,(p+1)^2));
		Yi = (reshape(((yi(Iy)-yb)/dy)*ones(1,Mx),My*Mx,1)* ...
			ones(1,(p+1)^2)).^ ...
			(ones(My*Mx,1)*reshape([0:p]'*ones(1,p+1),1,(p+1)^2));
		Zi = reshape((Xi.*Yi)*inv((X.*Y)'*(X.*Y))*(X.*Y)'*Z,My,Mx);
		% reset the distances and int. values
		ddi(K) = Di(K);
		zzi(K) = Zi(K);
		di(Iy,Ix) = ddi;
		zi(Iy,Ix) = zzi;
	end
end
end
end
