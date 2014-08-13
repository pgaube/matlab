%function [mean] = pmean(x);% Calculates the mean of x

function mean = pmean(x)
warning('OFF','all')
x=x(:);
p=~isnan(x);
y=x(p);
mean=sum(y)/length(y);
warning('ON','all')