function [newy,beta,S,delta_beta,S_crit]=reg(varargin)

%
% [NEWY,BETA,S,delta_beta,S_crit] = reg(XX,YY,'METHOD',w)
%
% This function calculates the least squares regression of N points xx,yy
% onto a varity of regression models
%
% ***INPUTS***
%
% Required:
% XX is the independent variable
% YY is the dependent functional value at each XX
% 'METHOD' = Regression method
%     'lin' is linear regression (beta1*t)
%     'quad' is quadratic reression (beta1*t^2)
%     'both' is all of the above
%
% Optional:
% W (all=1) is a vector of weights to be used in determining which points
%   have more influence 
%  Only for Harmonic Regrision
%     M (=1) is the number of harmonics for a particular base frequency to
%       regress against
%     F (=1) is the base frequency (2*pi)
%
% ***OUTPUTS***
% NEWY is the regression curve for the points at each XX
% also:
% BETA is the least-squared estimate of the Beata_1 coefficent
% S is defined as the 'hindcast skill' or r^2 value of the regression.
% delta_B are the individual confidance intervals for B_o and B_1
% Written Peter Gaube in June, 2008.

%check inputs
if nargin >= 2,
   xx = varargin{1};
   xx=xx(:);
   yy = varargin{2};
   yy=yy(:);
end
if nargin >= 3,
   METHOD = varargin{3};
end

if nargin >= 4,
   w = varargin{4};
end

W = [];
[a b] = size(yy);

%
% Make sure x and y are columns vectors
%

if a>b,
   yy = yy';
end

[a b] = size(xx);
if a>b,
   xx = xx';
end

%whos xx yy
%
% For weighted function, only want the elements of the main diagonal
% of the product of column vectors ydata and wdata.
%

if isempty(W) == 1,
   W = ones(size(xx));
end

%
% Remove missing data for all input data
%

good = find(~isnan(xx) & ~isnan(yy));


if ~isempty(good)
  	xdata=xx(good)';
	ydata=yy(good)';
	wdata=W(good)';
else,
   %warning('HARM_REG.M: Input data all NaN''s')
   newy = nan;
   beta = [nan nan];
   S = nan;
   delta_beta =[nan nan];
   S_crit = nan;
   return
end 
% 
% Apply any weights to the data
%

%ydata = diag(ydata*wdata');

%
% Define the design matrix X [N,(M*2+1)] with N Observations and M frequencies.
% The matrix X has M*2+1 columns because a sine and cosine is needed for
% each frequencies, and the first column of X is 1.
% Rows have each additional observation while columns have each frequency.
% See D.B Chelton's Data Analysis notes, Section 9.4, equations 9.3.23a
% and 9.4.26b in particular.
%

N = length(xdata); 
X(1:N,1) = 1;
switch METHOD
  case {'lin'}
    X(1:N,2) = xdata;
  case {'quad'}
    X(1:N,2) = xdata.^2;
  case {'both'}
    X(1:N,2) = xdata;
    X(1:N,3) = xdata.^2;
end

%
% Now solve for the parameters -- beta's -- of the model
% Matlab has a function '\' that takes care of inversion.
% This is equivalent to the operation commented out bellow  
%

beta = X \ ydata;
%beta = inv(X' * X) * X' * ydata;

%
% Now find the regression values
%

switch METHOD
  case {'lin'}
    newy = ones(size(xx))*beta(1);
    newy = newy + beta(2).*xx;
  case {'quad'}
    newy = ones(size(xx))*beta(1);
    newy = newy + beta(2).*xx.^2;
  case {'both'}
    newy = ones(size(xx))*beta(1);
    newy = newy + beta(2).*xx+ beta(3).*(xx.^2);
end

% Determine the skill (S) of the model

S = pvar(newy)/pvar(ydata);

% Determine the confidance intervals of B_o and B_1 at alpha=0.05

delta_beta=[0 0];
delta_beta(2) = sqrt((1-S)/(N-S))*(pvar(ydata)/pvar(xdata))*tinv(0.05/2,N-2);
delta_beta(1) = sqrt(pstd(xdata))*delta_beta(2);

% Determine of skill is significant at alpha = 0.05

S_crit=(1/N)*finv(0.05,1,N-2);