function [new_c,cnt]=poiss_reg(z,a,d,n)

%
% [new_c,S,cnt]=poiss_reg(z,a,d,n)
%
% this function does non-linear least squeared regression to a modifed Poisson using
% Levenberg-Maquardt algorithm for minimization of a sum of squares
%
% The Poisson is defined as
% 	p = a*(z./d).*exp(1-(z./d)).^n
%
% INPUT:
%	z       =       data to fit
%       d       =       loc of middle of curve
%       n       =       shape parameter
%       a       =       amp
% OUTPUT:
%	g 	= 	values of the fitted poisson [D,N,A]
%	S 	= 	skill of regression, assumes N is large
%	cnt	=	# of iterations neede to solve

t=1:length(z);
% check to make sure that x and t are row vectors
dm=size(t)
if dm(1)<dm(2)
    t=t';
    z=z';
end



% use Levenberg-Mauart algorith to iterativly find good solution

c=[a d n]
res = @(c) real(c(1)*(z./c(2)).*exp(1-(z/c(2)))).^c(3);
[new_c,dum,cnt]=LMFnlsq(res,c);

