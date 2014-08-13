function [z, l] = regspline2d (x_out, y_out, arg_3, arg_4, arg_5, arg_6)
%
% Gridding using regularized spline in tension
%
%	Finds a surface using regularized splines in tension.
%	Solution can be evaluated on a grid or at arbitrary locations
%
%	Use one of the following call formats:
%
%	z = reg2d (x_out, y_out, x_data, y_data, z_data)
%	z = reg2d (x_out, y_out, x_data, y_data, z_data, t)
%
% The input parameters are:
%
%	x_out	- Desired output x positions (can be vector or matrix)
%	y_out	- Desired output y positions (can be vector or matrix)
%
%	x_data	- x-coordinates of points with data constraints
%	y_data	- y-coordinates of points with data constraints
%	z_data	- data constraints at the above points
%
%	t	- tension to use, 0 <= t < 1
%		  if t is a vector of length 2 the second value is taken as the lengthscale
%

IM = sqrt (-1);
length_scale = abs (max(x_out(:)) - min(x_out(:)) + IM * (max(y_out(:)) - min(y_out(:)))) / 50;

if (nargin == 5 | nargin == 10 | nargin == 7)	% No tension selected, set default
	t = 0;
	n_args = nargin;
else
	n_args = nargin - 1;
	t = eval (['arg_' int2str(nargin)]);
	if (length(t) == 2)	% User gave both tension and lengthscale
		length_scale = t(2);
		t = t(1);
	end
	if (t < 0.0 | t >= 1.0)
		error ('spline2d: tension must be 0 <= t < 1 !')
	end
end

% Now figure out what was passed and assign the data accordingly

if (n_args == 5 | n_args == 10)	% z_data supplied
	x_data = arg_3;
	y_data = arg_4;
	z_data = arg_5;
end
if (n_args == 7)	% only z_slope supplied
	x_slope = arg_3;
	y_slope = arg_4;
	i_slope = arg_5;
	j_slope = arg_6;
	z_slope = arg_7;
elseif (n_args == 10)	% z_slope supplied
	x_slope = arg_6;
	y_slope = arg_7;
	i_slope = arg_8;
	j_slope = arg_9;
	z_slope = arg_10;
end

% Misc initializations

p = sqrt (t / (1 - t));
p = p / length_scale;
n0 = 0;
n1 = 0;

% First we must enforce the use of column vectors for the data constrainst

if (n_args == 5 | n_args == 10)	% z_data supplied; check if we must transpose
	[m,n] = size (x_data); if (m < n), x_data = x_data'; end
	[m,n] = size (y_data); if (m < n), y_data = y_data'; end
	[m,n] = size (z_data); if (m < n), z_data = z_data'; end
	n0 = length (z_data);
end
if (n_args == 7 | n_args == 10)	% z_slope supplied; check if we must transpose
	[m,n] = size (x_slope); if (m < n), x_slope = x_slope'; end
	[m,n] = size (y_slope); if (m < n), y_slope = y_slope'; end
	[m,n] = size (i_slope); if (m < n), i_slope = i_slope'; end
	[m,n] = size (j_slope); if (m < n), j_slope = j_slope'; end
	[m,n] = size (z_slope); if (m < n), z_slope = z_slope'; end
	n1 = length (z_slope);
end

% Assembly final xp, yp, and zp vectors (possibly combination of data and slopes)

if (n_args == 10)	% z_data and z_slope supplied; put xyz in general point vector
	xp = [x_data; x_slope];
	yp = [y_data; y_slope];
	zp = [z_data; z_slope];
elseif (n_args == 7)	% z_slope supplied; put xyz in general point vector
	xp = x_slope;
	yp = y_slope;
	zp = z_slope;
else 			% z_data supplied; put xyz in general point vector
	xp = x_data;
	yp = y_data;
	zp = z_data;
end

% Now build the square n x n linear system that must be solved for the alpha's

disp ('build matrix')
tic
n = n0 + n1;
A = zeros (n, n);
if (n_args == 5 | n_args == 10)	% z_data supplied; build data matrix rows
	for i = 1:n0
		r = (abs ((xp(i) - xp) + IM * (yp(i) - yp)));
%         whos r p A
%         rr=(regsplinetens (r, p))';
%         whos rr
		A(i,:) = (regsplinetens (r, p))';
	end
end
if (n_args == 7 | n_args == 10)	% z_slope supplied; build slope matrix rows
	for i = 1:n1
		j = i + n0;
		dx = xp(j) - xp;
		dy = yp(j) - yp;
		A(j,:) = (spline2d_grad (dx, dy, i_slope(i), j_slope(i), p))';
	end
end
toc
disp ('solve matrix')
tic
% Done building square linear system, now solve it

alpha = A \ zp;
toc
if (nargout == 2)	% Return eigenvalues
	disp ('find eigenvalues')
	tic
	l = svd (A);
	toc
end

disp ('evaluate')
tic
% Now evaluate final solution at output locations

z = zeros (size(x_out));
for i = 1:length(alpha)
	r = abs ((x_out - xp(i)) + IM * (y_out - yp(i)));
	z = z + alpha(i) * regsplinetens (r, p);
end

toc
disp ('done')


function g = regsplinetens (r, phi)
% REGSPLINETENS  Regularized spline in tension (Cartesian 2D)
%
% Usage:
%   g = regsplinetens (r, phi)
% where
%   r = radial distance
%   phi = tension parameter
%
% Based on Mitasova and Mitas, 1993, Math. Geol., 25 (6)

z = (0.5 * phi * r).^2;
g = zeros (size(r));
A = find (z <= 1.0);
B = find (z  > 1.0);
if (~isempty (A))
    x = z(A);
    g(A) = 0.99999193 * x;
    x = x .* x;
    g(A) = g(A) - 0.24991055 * x;
    x = x .* x;
    g(A) = g(A) + 0.05519968 * x;
    x = x .* x;
    g(A) = g(A) - 0.00976004 * x;
    x = x .* x;
    g(A) = g(A) + 0.00107857 * x;
end
if (~isempty (B))
    x = z(B);
    g(B) = log(x) + 0.577215664901;
    En = 0.2677737343 +  8.6347608925 * x;
    Ed = 3.9584869228 + 21.0996530827 * x;
    x = x .* x;
    En = En + 18.0590169730 * x;
    Ed = Ed + 25.6329561486* x;
    x = x .* x;
    En = En + 8.5733287401 * x;
    Ed = Ed + 9.5733223454 * x;
    x = x .* x;
    En = En + x;
    Ed = Ed + x;
    g(B) = g(B) + (En ./ Ed) ./ (z(B) .* exp(z(B)));
end