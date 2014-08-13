function smoothdata = smooth2dgen(data,spanx,spany,xgrid,ygrid)

%
% SMOOTH2DGEN(DATA,SPANX,SPANY,XGRID,YGRID)
%
% This routine smooths 2-dimensional spatially gridded data with a loess
% smoother. Missing values are denoted with NaN's. This routine works with
% data on a regularly or irregularly-spaced grid.
%
% Inputs: 
%    DATA is a MAXY-by-MAXX matrix of spatially gridded data to be smoothed.
%    SPANX and SPANY are the half-spans of the smoothing operation. These spans
%    are roughly equivalent to a block average of 0.6 times their values.
%    XGRID and YGRID are the grids in the x and y direction with lengths
%    of MAXX and MAXY, respectively.
%
% Outputs:
%    SMOOTHDATA is the same dimension and size as DATA, except smoothed to remove
%    scales of variability shorter than the half-spans.
% 
% Calls the mex-function smooth2df.mexaxp which is a gateway function to
% Schlaxs' routines.
%
% Larry O'Neill 
% July 22, 2002
% 

%
% Check to see that the dimensions of the DATA array match the 
% input parameters set by MAXX and MAXY
%

maxx = length(xgrid);
maxy = length(ygrid);

[a,b] = size(data);

if a~=maxx,
   disp('The number of rows of the data array do not match MAXX')
   return
end
if b~=maxy,
   disp('The number of columns of the data array do not match MAXY')
   return
end


% Replace NaN's with missing value code 1e35

data(isnan(data)) = 1.e35;

smoothdata = smooth2dgenf(data,maxx,maxy,spanx,spany,xgrid,ygrid);

% Replace missing value code 1e35 with NaN's

smoothdata(smoothdata == 1.e35) = NaN;

