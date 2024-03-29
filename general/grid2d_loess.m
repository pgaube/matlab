function [sm_data,flag] = grid2d_loess(data,xgrid,ygrid,span_x, ...
                                         span_y,xgrid_est,ygrid_est)
%
%--------------------------------------------------------------------------
% [SM_DATA,FLAG] = grid2d_loess(DATA,XGRID,YGRID,SPAN_X,SPAN_Y, ...
%                                 XGRID_EST,YGRID_EST)
%
% 2-dimensional loess gridder. The smoothed value at each grid point 
% is found from a weighted least-squares regression of the points within 
% +/- SPAN_X and SPAN_Y of the grid point to a quadratic surface.
%
% Inputs (all required):
%   DATA is a row vector array of the data to be smoothed. 
%        Missing value flag is NaN.
%   XGRID is x locations of DATA. This must be the same size as DATA array.
%   YGRID is y locations of DATA. This must be the same size as DATA array.
%   SPAN_X, SPAN_Y are the filter half-power points (each a scalar). The larger the 
%          number, the more smoothing is performed. For the tricubic 
%          weighting function used here, the smoothing is approximately 
%          equivalent to using a running average of length equal to 
%          ~0.6*SPAN_X. However, the spectral characteristics of this 
%          smoother are usually much more desirable. The filter cutoff
%          frequencies are approximately (1/SPAN_X, 1/SPAN_Y).
%   XGRID_EST, YGRID_EST are column and row vectors, respectivly, where smoothed estimates are
%            desired. The estimate grid can be irregular and non-monotonic.
%            Any points in XGRID_EST and YGRID_EST outside of the range of 
%			 XGRID and YGRID, respectively, will have SM_DATA=NaN.
%
% Outputs:
%   SM_DATA is a 2-dimensional array with LENGTH(XGRID_EST) columns and LENGTH(YGRID_EST) rows 
%           with the smoothed DATA.
%   FLAG is an array the same size as SM_DATA that is set to 1 when the 
%        smoothed estimate is outside the range of the data within +/- 
%        SPAN_X of that grid point and 0 otherwise. When the smoothed 
%        estimate is out of range, the estimate will be included in the 
%        output SM_DATA. This will typically occur near the edges of the 
%        DATA series or when SPAN_X only encompasses a small number of grid
%        points in XGRID. While the smoothed estimate is usually only
%        marginally out-of-range in these cases, care should be used when 
%        considering these points because the smoothed estimate may not be 
%        very good at that particular point. If there are many such points, 
%        consider using a larger SPAN_X (smoothing over more points).
%
%  
%--------------------------------------------------------------------------
% - Written by Peter Gaube, December 8, 2009. 
%   Based on smooth2d_loess.m by Larry O'Neill, September 25, 2007
%--------------------------------------------------------------------------

flagout = nargout==2;

[ny] = size(data);

xgrid_size = size(xgrid);
ygrid_size = size(ygrid);

xgrid_est_size = size(xgrid_est);
ygrid_est_size = size(ygrid_est);

%
% Check that XGRID_EST, YGRID_EST, XGRID, and YGRID are vectors
%

if ndims(xgrid_est_size) > 2 | sum(xgrid_est_size==1) == 0,
    error('XGRID_EST must be a 1-D vector.')
end
if ndims(ygrid_est_size) > 2 | sum(ygrid_est_size==1) == 0,
    error('YGRID_EST must be a 1-D vector.')
end
if ndims(xgrid_size) > 2 | sum(xgrid_size==1) == 0,
    error('XGRID must be a 1-D vector.')
end
if ndims(ygrid_size) > 2 | sum(ygrid_size==1) == 0,
    error('YGRID must be a 1-D vector.')
end

%
% Make input vectors row vectors
%

if xgrid_est_size(1) < xgrid_est_size(2),
    xgrid_est = xgrid_est';
end
if ygrid_est_size(1) < ygrid_est_size(2),
    ygrid_est = ygrid_est';
end
if xgrid_size(1) < xgrid_size(2),
    xgrid = xgrid';
end
if ygrid_size(1) < ygrid_size(2),
    ygrid = ygrid';
end

nx_est = length(xgrid_est);
ny_est = length(ygrid_est);

%
% Check to see if XGRID and YGRID have a length consistent with DATA
%

if length(xgrid) ~= ny,
    error('XGRID is not equal to the size of DATA')
end

if length(ygrid) ~= ny,
    error('YGRID is not equal to the size of DATA')
end


%
% Only consider points where XGRID_EST and YGRID_EST are within the range 
% of XGRID and YGRID, respectively
%

sx = find(xgrid_est >= min(xgrid) & xgrid_est <= max(xgrid))';
sy = find(ygrid_est >= min(ygrid) & ygrid_est <= max(ygrid))';

mxgrid = xgrid;
mygrid = ygrid;

%
% Normalize MXGRID and XGRID_EST by SPAN_X and
% MYGRID and YGRID_EST by SPAN_Y
%

mxgrid = mxgrid/span_x;
xgrid_est = xgrid_est/span_x;
mygrid = mygrid/span_y;
ygrid_est = ygrid_est/span_y;

%
% Preallocate the output arrays
%

sm_data = repmat(NaN,[ny_est nx_est]);  
             % Preallocate NaNs for output SM_DATA array

if flagout,
   flag = zeros([ny_est nx_est]);
             % Preallocate 0's for output FLAG array
end

%
% Find locations of missing data, marked by NaN's
%

nan_data_loc = isnan(data);
switch sum(nan_data_loc(:)),
    case 0,
        nan_data_loc = 0;
    case ny,
        warning('DATA array contains nothing but NAN''s')
        return
end

%
% Loop through all points in the estimate grid
%

for j=sy

    dy = mygrid - ygrid_est(j);
    dy2 = dy.*dy;

    for i=sx



        

        dx = mxgrid - xgrid_est(i);
        dist = dx.*dx + dy2;
        igood = (dist+nan_data_loc) < 1;
        ngood = sum(igood(:));

        if ngood >= 10,    % Need at least 10 data points for regression

           datasel = data(igood);
           dxsel = dx(igood);
           dysel = dy(igood);
	       distsel2 = dist(igood);
           distsel = sqrt(distsel2);
           
           %
           % Use the tricubic weighting function for the filter weights. This
	       % is a more computationally efficient way of writing out
	       % w = (1-distsel.^3).^3;
           %

           w = 1 - distsel2.*distsel;
           w = w.*w.*w;

           %
           % Compute array of w*(1+x+y+x^2+y^2+xy)
           %
 
           xin = repmat(w,[1 6]);
           
           xin(:,2) = xin(:,2).*dxsel;
           xin(:,3) = xin(:,3).*dysel;
           xin(:,4) = xin(:,2).*dxsel;
           xin(:,5) = xin(:,3).*dysel;
           xin(:,6) = xin(:,2).*dysel;

           %
           % Least-squares solution to the over-determined set of 
           % equations as specified by the "\" operator. Basically solves
           % the equation wYhat=B*(wX), where Yhat is the smoothed estimate
           % of the input DATA, X is the coordinate relative to the grid 
           % point of the smoothed estimate, and B are the regression 
           % coefficients. Solves with QR decomposition.
           %
           
           B = xin \ (w.*datasel);
           
           %
           % Smoothed value is just the first regression coefficient, since
           % the grid point was chosen such that it's at x=0. Also need to 
           % check that the regression point is within the range of the data
           % points used in fitting the quadratic surface. It should be out
           % of range only rarely, and if it is, the smoothed estimate at
           % that point is given and the FLAG is set to =1.
           %

           sm_data(j,i) = B(1);

           if flagout,
              if B(1) > min(datasel) & B(1) < max(datasel),
                 flag(j,i) = 1;
              end
           end
       end
    end
end

return
