function [fit,amp,phase,rsq] = harmonic(data,t,T)
% function [fit,amp,phase,rsq] = harmonic(data,time,T)
% Least square fit of sinusoid with period T
% to time-series "data". (harmonic analysis)
% [input]
% - data: values for time-series
% - time: times for time-series
% - T: period to be fit in same units as t.
%   ie: if t is in hrs, & fitting diurnal
%   cycle, T = 24.
% [output]
% - fit:  vector of the fitted harmonic
% - amp (optional):  amplitude of harmonic
% - phase (optional):  phase of harmonic
% - rsq (optional):  r-squared goodness of fit
% [see:  Winkler&Hayes, 1975 p690 & Bloomfield, 1976 p11]
% Copyright (C) SCKennan(21mar94):  copied from F.Bingham "mlinfit.m"
%  revised(21mar94):  returns the fit to one harmonic

% Notation follows Winkler and Hayes, Statistics
% Holt, Rinehart and Winston, 1975. Page 690ff.

Y = data(:);
n=length(Y);
X = ones(n,3);
X(:,2) = cos(2*pi*t(:)/T);
X(:,3) = sin(2*pi*t(:)/T);
k = 3;

b = inv(X' * X) * X' * Y;     %Done!  Coefficients found.

% NEW to fred's program
% see Bloomfield p.11 for the following:
amp = sqrt(b(2)^2 + b(3)^2);
phase = atan2(-1*b(3),b(2));
fit = amp*cos(2*pi*t/T + phase);

% Now calculate multiple correlation coefficient...
rsq = ( ( b' * X' * Y ) - ( (1/n) * (sum(Y)^2) ) ) / ...
      ( (Y' * Y) - ( (1/n) * (sum(Y)^2) ) );

% and sample error variance.
%sesq = ( (Y' * Y) - (b' * X' * Y) ) / n;

% Find 95% confidence intervals for b's
%aii = diag(inv(X' * X));
% T distribution loaded from Splus.
%load t975.d
%bconf = t975(n-k) * sqrt(sesq) * sqrt(aii) * sqrt(n/(n-k));

% Test for significance of total correlation.
% This variable is distributed as F with k-1 and n-k degrees of freedom
% and can be used to test the null hypothesis b2=b3=...=bn=0.
%fvar = (rsq / (1 - rsq)) * (n-k)/(k-1);
