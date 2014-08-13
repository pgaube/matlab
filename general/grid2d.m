function varargout = grid2d(z,y,x,yi,xi,Ry,Rx,varargin)
% function [zi,num] = grid2d(z,y,x,yi,xi,Ry,Rx,'method',fac,'shape')
% 2-d gridding
% x, y, xi, yi vectors
% Ry, Rx radii of influence
% method [default: 'mean']
%	'mean' or 'median': only data within Ry,Rx are included
%	'gaussian': all data are included, Ry/Rx are the gaussian scales
% fac: for method='gaussian' only:  factor for determining if data within
%	range.  ie: default fac=2, data within ellipse of 2*Ry,2*Rx
% shape [default: 'box']
%	'box': shape is a box with x-length 2*x, y-length 2*x
%	'ellipse': shape is an ellipse with x-radius Rx, y-radius, Ry
% z length(y) x length(x) matrix of gridded data
% num length(y) x length(x) matrix of # of raw data used per grid pt.
% copyright (C) S.C.Kennan (05may2004)

% m :   total number of y-positions
% n :   total number of x-positions
% mXn :   total number of data pts.
% c :   number of columns to data (ie: separate data series)
[my,mx] = size(z);
% mi :  total number of interpolation pts.
myi = length(yi);
mxi = length(xi);

Rx2 = Rx^2;
Ry2 = Ry^2;
METHOD = 'mean';
SHAPE = 'box';
FAC = 2;
if length(varargin)>=1,
	METHOD = lower(varargin{1});
	if strcmp(METHOD,'ave'), METHOD = 'mean'; end
	if strcmp(METHOD,'med'), METHOD = 'median'; end
	if strcmp(METHOD,'gau'), METHOD = 'gaussian'; end
end

% if 1xc row vector, make it column vector
x = x(:); y = y(:); xi = xi(:); yi = yi(:);
y = y*ones(1,mx);
x = ones(my,1)*x';
x = x(:); y = y(:); z = z(:);
I = find(isnan(z));
if length(I)>0, z(I) = []; x(I) = []; y(I) = []; end

ni = NaN*ones(myi,mxi);
zi = NaN*ones(myi,mxi);

% for each interpolation pt.
for i=1:myi,
for j=1:mxi,
	Dx2 = ((xi(j) - x).^2)/Rx2;
	Dy2 = ((yi(i) - y).^2)/Ry2;
	switch METHOD
	case {'mean','median'}
		if length(varargin)==2, SHAPE = lower(varargin{2}); end
		switch SHAPE
		case {'ellipse'}
			I = find((Dx2 + Dy2) <= 1);
		case {'box'}
			I = find((Dx2 <= 1) & (Dy2 <= 1));
		otherwise error('valid shapes "ellipse", "box"');
		end
		if length(I)>0,
			ni(i,j) = length(I);
			eval(['zi(i,j) = ',METHOD,'(z(I));']);
		end
	case {'gaussian'}
		if length(varargin)==2, FAC = varargin{2}; end
		I = find((Dx2 + Dy2) <= FAC^2);
		if length(I)>0,
			ni(i,j) = sum(exp(-Dx2(I)/Rx2 - Dy2(I)/Ry2));
			zi(i,j) = sum(z(I).*exp(-Dx2(I)/Rx2 - Dy2(I)/Ry2)) ...
				./ni(i,j);
		end
	otherwise error('valid methods are "mean/ave", "median/med", "gaussian/gau"');
	end
end
end

%  if number of data per pt. requested
varargout{1} = zi;
varargout{2} = ni;
