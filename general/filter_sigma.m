function [filtered_x,f] = filter_sigma(n,x)
  %[filtered_x] = filter_sigma(n,x)
  %n standard deviation filter for array containing NaNs.
  %
  %Input
  %n = number of standard deviation from the mean
  %x = data (Can contain Nan's, must be a [1 m] array)
  %
  %Output
  %filtered_x = x filterd by +/- n standard deviations


s=pstd(x);
m=pmean(x);
filtered_x = nan(size(x));
f = find(abs(x-m)<= n*s);
filtered_x(f) = x(f);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function v=pvar(x)

p=~isnan(x);
y=x(p);
v = pmean(y.^2)-pmean(y)^2;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function sd=pstd(x)

sd=sqrt(pvar(x));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function mean = pmean(x)

p=~isnan(x);
y=x(p);
mean=sum(y)/length(y);
