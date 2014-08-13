%Calculates the correlation Coeffecient of two matracies of equal size.  
%also can call other descriptive statistics such as mean and varance
%function [cor,xbar,ybar] = cor3d_fast(x,y)
%Copyright Peter Gaube August 2 2006

function [cor]  = cor3d_fast(x,y)
%function [xbar,ybar,varx,vary] = cor3d_fast(x,y)




xbar = nanmean(x,3);
ybar = nanmean(y,3);
xybar = nanmean(x.*y,3);

x2bar = nanmean(x.^2,3);
y2bar = nanmean(y.^2,3);

covxx = x2bar-xbar.^2;
covyy = y2bar-ybar.^2;
covxy = xybar-xbar.*ybar;

cor = covxy./((covxx.*covyy).^.5);

