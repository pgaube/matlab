function g=gauss(x,a,r,l)

%
% g=gauss(x,r,l)
%
% this function make a gaussian of the form
%
% g = A * exp( -(x-r).^2 / (2*l^2) ); 
%
% the fitting is been done by a polyfit
% the lan of the data.
%
%


g = a * exp( -(x-r).^2 / (2*l^2) ); 