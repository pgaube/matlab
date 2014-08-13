function [newy,sig,mu,A,S]=ppois(x,y)

%
% [newy,sig,mu,A,S]=ppois(x,y)
%
% this function is doing fit to the Poisson function
% y = (x.^l.*exp(l))./factorial(x)
% 
% however the following approximation is made to remove
% the factorial from the denomenator
% log(factorial(x)) ~ x.*log(x)-x+1+.5.*log(x)
% 
% the fitting is been done by a polyfit
% the log of the data.
%
%

%% threshold
if nargin==2, h=0.2; end 

%% cutting 
indx = (y > max(y)*h); 

%% fitting 
p=polyfit(x(indx), log(y(indx)), 2); 
sig=sqrt(-1/(2*p(1))); 
mu=p(2)*sig^2; 
A=exp(p(3)+mu^2/(2*sig^2));

newy=A * exp( -(x-mu).^2 / (2*sig^2) ); 
S = pvar(newy)/pvar(y);
