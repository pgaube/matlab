function [g,S,cnt]=gauss_reg(x,y)

%
% [g,l,r,a,S,cnt]=gauss_reg(x,y)
%
% this function does non-linear least squeared regression to a gaussian using
% Levenberg-Maquardt algorithm for minimization of a sum of squares
%
% The Gaussian is defined as
% 	g = A * exp( -(x-r).^2 / (2*l^2) );
%
% INPUT:
%	x = data to fit
% OUTPUT:
%	g 	= 	values of the fitted gaussian
% 	l 	= 	zonal scale
% 	r 	= 	radius
%	a 	= 	amp
%	S 	= 	skill of regression, assumes N is large
%	cnt	=	# of iterations neede to solve



% first estimate values fitting the ln of the data

% check to make sure that x and t are row vectors
dm=size(y)
if dm(1)<dm(2)
	x=x';
	y=y';	
end	


[tg,tl,tr,ta]=pgauss(x,y);

t=y;

% now use Levenberg-Mauart algorith to iterativly find good solution

c=[ta tr tl]
res = @(c) (c(1)*exp(-(t-c(2)).^2./(2*c(3)^2)))-x; 
[g,dum,cnt]=LMFnlsq(res,[ta,tr,tl]);
S = pvar(g)/pvar(y);
