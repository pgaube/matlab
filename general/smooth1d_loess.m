function [sm_data,flag] = smooth1d_loess(data,data_grid,span_x,est_grid)

%--------------------------------------------------------------------------
% [SM_DATA,FLAG] = smooth1d_loess(DATA,DATA_GRID,SPAN_X,EST_GRID)
%
% 1-dimensional loess smoother. The smoothed value at each grid point 
% is found from a weighted least-squares regression of the points within 
% ± SPAN_X of the grid point to a quadratic surface.
%
% Inputs (all required):
%   DATA is a row or column vector of the data to be smoothed. 
%        Missing value flag is NaN.
%   DATA_GRID is locations on the grid where DATA are located. This must
%             be the same size as the DATA vector.
%   SPAN_X is the filter half-power point (a scalar). The larger the 
%          number, the more smoothing is performed. For the tricubic 
%          weighting function used here, the smoothing is approximately 
%          equivalent to using a running average of length equal to 
%          ~0.6*SPAN_X. However, the spectral characteristics of this 
%          smoother are usually much more desirable.
%   EST_GRID are the locations on the grid where smoothed estimates are
%            desired. The estimate grid can be irregular and non-monotonic.
%            Any points in EST_GRID outside of the range of DATA_GRID will
%            not have SM_DATA=NaN.
%
% Outputs:
%   SM_DATA is a vector the same size as EST_GRID containing the
%           smoothed version of DATA at the locations specified by 
%           EST_GRID.
%   FLAG is a vector the same size as EST_GRID that is set to 1 when the 
%        smoothed estimate is inside the range of the data within ± 
%        SPAN_X of that grid point and 0 otherwise. When the smoothed 
%        estimate is out of range, the estimate will be included in the 
%        output SM_DATA. This will typically occur near the edges of the 
%        DATA series or when SPAN_X only encompasses a small number of grid
%        points in DATA_GRID. While the smoothed estimate is usually only
%        marginally out-of-range in these cases, care should be used when 
%        considering these points because the smoothed estimate may not be 
%        very good at that particular point. If there are many such points, 
%        consider using a larger SPAN_X (smoothing over more points).
%
% Note: By default, if EST_GRID and DATA_GRID are the same, the smoother will 
%       give smoothed estimates at points where DATA==NaN. To have NaN's
%       in SM_DATA where DATA==NaN when EST_GRID and DATA_GRID are the same,
%       uncomment the "if" statement at line 138 (and the corresponding 
%       "end" statement at line 197).
%  
%--------------------------------------------------------------------------
% - Written in Matlab format by Larry O'Neill, May 27, 2006, based on a 
%   Fortran version written by Michael Schlax
% - LWO Update June 8, 2006 to include FLAG parameter
% - LWO Update June 9, 2006 to fix an error on some matlab versions with 
%       the specification of the weighting function and to include smoothed 
%       estimates in SM_DATA when FLAG==1
% - LWO Update April 17, 2007 to fix a check statement regarding
%       clipping values of est_grid outside the range of data_grid. Fixes
%       issues arising when trying to extrapolate outside range of DATA_GRID. 
%       Also made routine more efficient by rewriting some inefficient code and
%       removing a few redundant computations. Now runs about 40% faster.
%--------------------------------------------------------------------------

num_elem = size(data);
if length(num_elem)~=2 | all(num_elem~=1),
    error('DATA must be a 1-dimensional row or column vector');
end

if size(data) ~= size(data_grid),
    error('Input DATA and DATA_GRID must be the same size.')
end

%
% Make input vectors row vectors
%

if num_elem(1) < num_elem(2),
    data = data';
    data_grid = data_grid';
end

est_grid_size = size(est_grid);

if est_grid_size(1) < est_grid_size(2),
    est_grid = est_grid';
end

%
% Check if EST_GRID is same as DATA_GRID. If it is, smoothed 
% estimates will not be computed at NaN's in DATA.
%

if length(est_grid) == length(data_grid) & est_grid == data_grid,
    grid_same = 1;
else,
    grid_same = 0;
end

%
% Check that EST_GRID is a vector
%

if ndims(est_grid_size) > 2 | sum(est_grid_size==1) == 0,
    error('EST_GRID must be a 1-D vector.')
end

sm_data = repmat(NaN,est_grid_size);  % Preallocate NaNs for output vector
flag = zeros(est_grid_size);  % Preallocate 0's for output flag vector

%
% Only consider points where EST_GRID is within the range of DATA_GRID
%

sx = find(est_grid >= min(data_grid) & est_grid <= max(data_grid))';

%
% Normalize DATA_GRID and EST_GRID by SPAN_X
%

data_grid = data_grid/span_x;
est_grid = est_grid/span_x;

%
% Find locations of missing data, marked by NaN's
%

nan_data_loc = isnan(data);

%
% Loop through all the points in EST_GRID that are within the range of DATA_GRID
%

for i=sx

   % To get smoothed estimates at the locations of missing values, comment
   % this IF statement out (only works if EST_GRID is the same as
   % DATA_GRID). Note that smoothed estimates in large contiguous blocks
   % of NaNs will not be very accurate.

%   if (logical(grid_same) & ~isnan(data(i))) | ~logical(grid_same),    

      dx = data_grid - est_grid(i);
      distx = abs(dx);      
      igood = distx+nan_data_loc < 1;  % more efficient way of removing points
      ngood = sum(igood);

      if ngood >= 3,    % Need at least 3 data points for regression

      datareg = data(igood);
	  dxsel = dx(igood);
	  distsel = distx(igood);

         %
         % Use the tricubic weighting function for the filter weights. This
	 	 % is a more computationally efficient way of writing out
	 	 % w = (1-distsel.^3).^3;
         %

         w = 1 - distsel.*distsel.*distsel; 
         w = w.*w.*w;
	 
         %
         % Compute array of w*(1+x+x2)
         %

	 	 xin(:,1) = w;
         xin(:,2) = w.*dxsel;
         xin(:,3) = xin(:,2).*dxsel;

         %
         % Least-squares solution to the over-determined set of 
         % equations as specified by the "\" operator. Basically solves
         % the equation wYhat=B*(wX), where Yhat is the smoothed estimate
         % of the input DATA, X is the coordinate relative to the grid 
         % point of the smoothed estimate, and B are the regression 
         % coefficients. Solves with QR decomposition.
         %

         B = xin \ (w.*datareg);

         %
         % Smoothed value is just the first regression coefficient, since
         % the grid point was chosen such that it's at x=0. Also need to 
         % check that the regression point is within the range of the data
         % points used in fitting the quadratic surface. It should be out
         % of range only rarely, and if it is, the smoothed estimate at
         % that point is given and the FLAG is set to =1.
         %

         sm_data(i) = B(1);

         if B(1) > min(datareg) & B(1) < max(datareg),
            flag(i) = 1;
         end

         clear xin B w dxsel distsel datareg

      end
%   end
end

return
