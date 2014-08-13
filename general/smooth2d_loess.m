function [sm_data,mflag,ddx,ddy] = smooth2d_loess(data,xgrid,ygrid,span_x, ...
                                         span_y,xgrid_est,ygrid_est,varargin)
%
%--------------------------------------------------------------------------
% [SM_DATA,FLAG,DDX,DDY] = smooth2d_loess(DATA,XGRID,YGRID,SPAN_X,SPAN_Y, ...
%                                 XGRID_EST,YGRID_EST,OPTION)
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
%          frequencies/wavenumbers are approximately (1/SPAN_X, 1/SPAN_Y).
%          These numbers should have the same units as XGRID and YGRID.
%   XGRID_EST, YGRID_EST are the locations on the grid where smoothed estimates are
%            desired. The estimate grid can be irregular and non-monotonic.
%            Any points in XGRID_EST and YGRID_EST outside of the range of 
%            XGRID and YGRID, respectively, will have SM_DATA=NaN.
%   OPTION(S):
%      1) By default, if XGRID and XGRID_EST are the same, the smoother will 
%         not give smoothed estimates at points where DATA==NaN. To do otherwise,
%         use the following option: 'smooth_over_missing_data',1 
%    
% Outputs:
%   SM_DATA is a 2-dimensional array with LENGTH(XGRID_EST) columns and LENGTH(YGRID_EST) rows 
%           with the smoothed DATA.
%
%   Optional outputs: (only activated when called with these arguments
%                      on the LHS)
%
%   MFLAG is an array the same size as SM_DATA that is set to 1 when the 
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
%   DDX and DDY are arrays the same size as SM_DATA with estimates of the
%        spatial derivatives of the smoothed fields.
%
% Note: By default, if XGRID and XGRID_EST are the same, the smoother will 
%       give smoothed estimates at points where DATA==NaN. To have NaN's
%       in SM_DATA where DATA==NaN when EST_GRID and DATA_GRID are the same,
%       uncomment the "if" statement at line 206 (and the corresponding 
%       "end" statement at line 291).
%
%--------------------------------------------------------------------------
% - Written in Matlab format by Larry O'Neill, September 25, 2004
%   Methodology based on a FORTRAN routine written by Michael Schlax.
%
% - 9/2007 Rewrote to allow for non-uniform grid spacing
% - 3/6/2008 Improved the efficiency of the inner loop and added several
%            check statements that speed up execution. Added a check
%            to insure that the target grid point has a few data points
%            surrounding it in all directions.
% - 11/15/2011 - Implemented option to smooth over NaN's in the input
%                data (to fill holes)
%              - Changed the matrix solution technique, which made routine
%                a little faster
%              - Made a couple of very minor changes to speed up code
% - 1/23/2013  - Added derivative output options, and editted the comments
%                section.
%--------------------------------------------------------------------------

smooth_over_missing_data = 0;

if ~isempty(varargin),
   narg = length(varargin);
   for i=1:narg
      switch varargin{i}
         case 'smooth_over_missing_data',
            smooth_over_missing_data = 1;
      end
   end
end

flagout = nargout>=2;
deriv_out = nargout==3 | nargout==4;

[ny,nx] = size(data);

xgrid_size = size(xgrid);
ygrid_size = size(ygrid);

xgrid_est_size = size(xgrid_est);
ygrid_est_size = size(ygrid_est);

%
% Check that XGRID_EST, YGRID_EST, XGRID, and YGRID are vectors
%

if ndims(xgrid_est_size) > 2 || sum(xgrid_est_size==1) == 0,
    error('XGRID_EST must be a 1-D vector.')
end
if ndims(ygrid_est_size) > 2 || sum(ygrid_est_size==1) == 0,
    error('YGRID_EST must be a 1-D vector.')
end
if ndims(xgrid_size) > 2 || sum(xgrid_size==1) == 0,
    error('XGRID must be a 1-D vector.')
end
if ndims(ygrid_size) > 2 || sum(ygrid_size==1) == 0,
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

if length(xgrid) ~= nx,
    error('XGRID is not equal to the number of columns of DATA')
end

if length(ygrid) ~= ny,
    error('YGRID is not equal to the number of rows of DATA')
end

%
% Check if EST_GRID is same as DATA_GRID. If it is, smoothed 
% estimates will not be computed at NaN's in DATA.
%

if (nx_est == nx && ny_est == ny) && ...   
   all(xgrid_est == xgrid) && ...
   all(ygrid_est == ygrid),
      grid_same = 1;
   else,
      grid_same = 0;
end

%
% Only consider points where XGRID_EST and YGRID_EST are within the range 
% of XGRID and YGRID, respectively
%

sx = find(xgrid_est >= min(xgrid) & xgrid_est <= max(xgrid))';
sy = find(ygrid_est >= min(ygrid) & ygrid_est <= max(ygrid))';

[mxgrid,mygrid] = meshgrid(xgrid',ygrid);

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
   mflag = zeros([ny_est nx_est]);
             % Preallocate 0's for output FLAG array
end

if deriv_out,
   ddx = zeros([ny_est nx_est]);
   ddy = zeros([ny_est nx_est]);
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

npt_threshold = 10;

for j=sy

%   progress_bar(j,length(sy))

   dy = mygrid - ygrid_est(j);
   dy2 = dy.*dy;
   jgood = find((dy2+nan_data_loc) < 1);

   if length(jgood) >= npt_threshold,

      dy = dy(jgood);
      dy2 = dy2(jgood);
      mxgrid2 = mxgrid(jgood);
      data2 = data(jgood);

      for i=sx

         if ~logical(grid_same) || ...
	    (logical(grid_same) && ...
	     (smooth_over_missing_data||~isnan(data(j,i)))),
%---
% 11/15/2011
% Changed order of execution of things in the if statement to speed things
% up  
%         if (logical(grid_same) && ...
%	     (~isnan(data(j,i)||smooth_over_missing_data))) || ...
%            ~logical(grid_same),    
%---

	    dx = mxgrid2 - xgrid_est(i);

	    i1 = find(abs(dx) < 1);

	    if length(i1) >= npt_threshold,

	       dx = dx(i1);
	       dy_sel = dy(i1);
	       dy2_sel = dy2(i1);

	       dist = dx.*dx + dy2_sel;
	       igood = find(dist < 1);
	       ngood = length(igood);

	       if ngood >= npt_threshold,   % Need at least this number
                                            % of data points for regression

	          data2_sel = data2(i1);
                  datasel = data2_sel(igood);
                  distsel2 = dist(igood);
                  dxsel = dx(igood);
                  dysel = dy_sel(igood);

		  %
		  % Use the tricubic weighting function for the filter weights. This
		  % is a more computationally efficient way of writing out
		  % w = (1-distsel.^3).^3;
		  %

		  w = 1 - distsel2.*sqrt(distsel2);
		  w = w.*w.*w;

		  %
		  % Compute array of w*(1+x+y+x^2+y^2+xy)
		  %

		  xin = ones(ngood,6);
		  xin(:,1) = w;
		  xin(:,2) = w.*dxsel;
		  xin(:,3) = w.*dysel;
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
%---
% Changed 11/15/2011
xtx = inv(xin'*xin);
D = xin'*(w.*datasel);
B = xtx*D;
%		  B = xin \ (w.*datasel);
%----

		  %
		  % Smoothed value is just the first regression coefficient, since
		  % the grid point was chosen such that it's at x=0. Also need to 
		  % check that the regression point is within the range of the data
		  % points used in fitting the quadratic surface. It should be out
		  % of range only rarely, and if it is, the smoothed estimate at
		  % that point is given and the FLAG is set to =1.
		  %

		  if flagout && (B(1) < min(datasel) || B(1) > max(datasel)),
		        mflag(j,i) = 1;
		  end

		  sm_data(j,i) = B(1);

                  if deriv_out,
		     ddx(j,i) = B(2);
		     ddy(j,i) = B(3);
		  end
		  
               end
            end
         end
      end
   end
end

return
