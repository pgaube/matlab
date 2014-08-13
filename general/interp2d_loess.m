function [sm_data,flag] = interp2d_loess(data,xgrid,ygrid,span_x,span_y)
%
%--------------------------------------------------------------------------
% [SM_DATA,FLAG] = interp2d_loess(DATA,XGRID,YGRID,SPAN_X,SPAN_Y)
%
% 2-dimensional loess smoother. The smoothed value at each grid point 
% is found from a weighted least-squares regression of the points within 
% +/- SPAN_X and SPAN_Y of the grid point to a quadratic surface.
%
% Inputs (all required):
%   DATA is a 2-dimensional array of the data to be smoothed. 
%        Missing value flag is NaN.
%   XGRID is locations on the grid along the columns of DATA. This must
%             be the same size as the number of columns of the DATA array.
%   YGRID is locations on the grid along the rows of DATA. This must
%             be the same size as the number of rows of the DATA array.
%   SPAN_X, SPAN_Y are the filter half-power points (each a scalar). The larger the 
%          number, the more smoothing is performed. For the tricubic 
%          weighting function used here, the smoothing is approximately 
%          equivalent to using a running average of length equal to 
%          ~0.6*SPAN_X. However, the spectral characteristics of this 
%          smoother are usually much more desirable. The filter cutoff
%          frequencies are approximately (1/SPAN_X, 1/SPAN_Y).
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
% Note: By default, if XGRID and XGRID_EST are the same, the smoother will 
%       give smoothed estimates at points where DATA==NaN. To have NaN's
%       in SM_DATA where DATA==NaN when EST_GRID and DATA_GRID are the same,
%       uncomment the "if" statement at line 186 (and the corresponding 
%       "end" statement at line 251).
%  
%--------------------------------------------------------------------------
% - Written in Matlab format by Larry O'Neill, September 25, 2007
%--------------------------------------------------------------------------

flagout = nargout==2;

[ny,nx] = size(data);

xgrid_size = size(xgrid);
ygrid_size = size(ygrid);


%
% Check that XGRID_EST, YGRID_EST, XGRID, and YGRID are vectors
%

if ndims(xgrid_size) > 2 | sum(xgrid_size==1) == 0,
    error('XGRID must be a 1-D vector.')
end
if ndims(ygrid_size) > 2 | sum(ygrid_size==1) == 0,
    error('YGRID must be a 1-D vector.')
end

%
% Make input vectors row vectors
%

if xgrid_size(1) < xgrid_size(2),
    xgrid = xgrid';
end
if ygrid_size(1) < ygrid_size(2),
    ygrid = ygrid';
end


%
% Check to see if XGRID and YGRID have a length consistent with DATA
%

if length(xgrid) ~= nx,
    error('XGRID is not equal to the number of columns of DATA')
end

if length(ygrid) ~= ny,
    error('YGRID is not equal to the number of rows of DATA')
end
grid_same = 1;

sx = 1:nx;
sy= 1:ny;


[mxgrid,mygrid] = meshgrid(xgrid',ygrid);

%
% Normalize MXGRID and XGRID_EST by SPAN_X and
% MYGRID and YGRID_EST by SPAN_Y
%

mxgrid = mxgrid/span_x;
mygrid = mygrid/span_y;

%
% Preallocate the output arrays
%

sm_data = repmat(NaN,[ny nx]);  
             % Preallocate NaNs for output SM_DATA array

if flagout,
   flag = zeros([ny nx]);
             % Preallocate 0's for output FLAG array
end

%
% Find locations of missing data, marked by NaN's
%

nan_data_loc = isnan(data);
switch sum(nan_data_loc(:)),
    case 0,
        nan_data_loc = 0;
    case ny*nx,
        warning('DATA array contains nothing but NAN''s')
        return
end

%
% Loop through all points in the estimate grid
%

for j=sy

    dy = mygrid - mygrid(j);
    dy2 = dy.*dy;

    for i=sx
	if isnan(data(j,i)) 

        dx = mxgrid - mxgrid(i);
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
end

% now fill in nans in data
tmp=data;
tmp(isnan(data))=sm_data(isnan(data));
sm_data=tmp;
return
