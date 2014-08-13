function [g,l,r,a,S]=pgauss(x,y,h)

%
% [newy,sig,mu,A,S]=pgauss(x,y,h)
%
% this function is doing fit to the function
%
% g = A * exp( -(x-r).^2 / (2*l^2) );
%
% the fitting is been done by a polyfit
% the ln of the data.
%
%

%% threshold
if nargin==2, h=0.2; end 

%% cutting 
indx = (y > max(y)*h); 

%% fitting 
p=polyfit(x(indx), log(y(indx)), 2); 
l=sqrt(-1/(2*p(1))); 
r=p(2)*l^2; 
a=exp(p(3)+r^2/(2*l^2));

g = a * exp( -(x-r).^2 / (2*l^2) ); 
S = pvar(g)/pvar(y);
