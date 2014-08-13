%CONFIDENCEINTERVAL   two-sided 95% confidence interval
%   U = CONFIDENCEINTERVAL(X) returns the right-critical value for
%   the 95% confidence interval of the location of the mean of X.
%
%   ERRORBAR(MEAN(X),CONFIDENCEINTERVAL(X))
%
%   See also STUDENT_T

% (c)2005 by Cris Luengo, 25 January 2005

function [u] = confidenceinterval(x)
if isvector(x)
   x = x(:);
end
n = size(x,1);
[u] = norminv([0.025 0.975],pmean(x),pstd(x));

%[u] = norminv([0.025 0.975],0,1)*pstd(x)/sqrt(n);