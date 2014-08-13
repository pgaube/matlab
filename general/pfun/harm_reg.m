function [newy,beta,S,theta]=harm_reg(varargin)

%
% [NEWY,BETA,S,theta] = harm_reg(XX,YY,M,F,W)
%
% This function calculates the least squares regression of N points xx,yy
% onto sines and cosines of M frequencies per 2 pi radians using a design matrix
% and matrix manipulations. This function returns the regression values
% y-hat at each data point xx that is non-NaN.
%
% ***INPUTS***
%
%    required:
% XX is the independent variable
% YY is the dependent functional value at each XX
%    optional:
% M (=1) is the number of harmonics for a particular base frequency to
%    regress against
% F (=1) is the base frequency (2*pi)
% W (all=1) is a vector of weights to be used in determining which points 
%   have more influence 
%
% ***OUTPUTS***
% NEWY is the regression curve for the points at each XX
% also:
% BETA(:) are the amplitudes of each cosine and sine at each new frequency
%         The vector contains all the cosine amplitudes first, then all the 
%         sine amplitudes.
% S is defined as the 'hindcast skill' or r^2 value of the regression.
%
% Written originaly by Larry O'Neill in July, 2002 (cos_sin_reg.m) and
% then modified by Peter Gaube in May, 2008.
%
%Example of how to call this script
%[ss_y,beta_y]=harm_reg(time,y,2,2*pi/365.25);
%
%



%
% Set up the input variables
%



W = [];
M = 1;
F = 1;

if nargin >= 2,
   xx = varargin{1};
   yy = varargin{2};
end
if nargin >= 3,
   M = varargin{3};
end
if nargin >= 4,
   F = varargin{4};
end
if nargin >= 5,
   W = varargin{5};
end

%
% Make sure x and y are columns vectors
%

[a b] = size(yy);
if a>b,
   yy = yy';
end
[a b] = size(xx);
if a>b,
   xx = xx';
end

%
% For weighted function, only want the elements of the main diagonal
% of the product of column vectors ydata and wdata.
%

if isempty(W) == 1,
   W = ones(size(xx));
end

%
% Remove missing data for all input data and check to make sure you have at least 80% coverage
%

i1 = ~isnan(xx+yy);

% Protect against inputs of all NaN's

if ~isempty(i1) & sum(i1) > 2 sum(i1)/length(xx) >= .8;
   xdata = xx(i1)';
   ydata = yy(i1)';
   wdata = W(i1)';
else,
   %warning('HARM_REG.M: Input data all NaN''s')
   newy = repmat(NaN,size(xx));
   beta = repmat(NaN,[2*M+1 1]);
   S = nan;
   theta = nan;
   return
end 

% 
% Apply any weights to the data
%

ydata = diag(ydata*wdata');

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

for i=1:N
   for j=1:M 
      X(i,j+1) = wdata(i)*cos(F*j*xdata(i));
      X(i,j+M+1) = wdata(i)*sin(F*j*xdata(i));
   end
end
%
% Now solve for the parameters -- beta's -- of the model
% Matlab has a function '\' that takes care of inversion.
%   

beta = X \ ydata;
%beta = inv(X' * X) * X' * ydata;

%
% Now find the regression values
%

newy = ones(size(xx))*beta(1);

for m=2:M+1
   newy = newy + beta(m)*cos(F*(m-1)*xx) + beta(m+M)*sin(F*(m-1)*xx);
end

% Determine the skill (S) of the model

S = pvar(newy)/pvar(ydata);

%Determine Phase
theta = atan2(-beta(2),1/beta(3));


% Display the values
%{
string = 'y(x) = %f';

for i=1:M
   if i==1,
      string = [string,' + %f*cos(F*x) + %f*sin(F*x)'];
   else,
      string = [string,' + %f*cos(',num2str(i,'%1u'), ...
                       '*F*x) + %f*sin(',num2str(i,'%1u'),'*F*x)'];
   end
end   


tmp = zeros(2*M,1);
tmp(1:2:end) = beta(2:M+1);
tmp(2:2:end) = beta(M+2:end);
fprintf(['\nBest Fit Equation: \n',string,' \n\n'],beta(1),tmp)
%}

function v=pvar(x)

p=~isnan(x);
y=x(p);
v = pmean(y.^2)-pmean(y)^2;
