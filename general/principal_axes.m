function [l1,l2,thetap] = principal_axes(u,v)

%
% This function finds the principle axes of variability for a time series.
% The principle axes are the axes that contains most of the variability in
% a time series. 
%
% [l1,l2,thetap] = principal_axes(u,v)
%
% Inputs:
%
% U is the x-axis component of the time series
% V is the y-axis component of the time series
%
% Outputs:
%
% l1 is the variance of the major principle axes
% l2 is the variance of the minor principle axes
% thetap is the counterclockwise angle the major axes makes with the 
%        original x-axis.
%
% July 12, 2002
%

i1 = find(~isnan(u+v));

up = u(i1);
vp = v(i1);

if ~isempty(up+vp),
   
%   meanu = mean(up);
%   meanv = mean(vp);

   up = up - mean(up);
   vp = vp - mean(vp);

   a = mean(up.^2) + mean(vp.^2);
   b = mean(up.^2) - mean(vp.^2);
   c = mean(up.*vp);
   d = sqrt(b^2 + 4*c^2);

   l1 = 0.5*(a + d);
   l2 = 0.5*(a - d);

   thetap = 0.5*atan2(2*c,b);

else,

   [l1,l2,thetap] = deal(NaN);
   
end
