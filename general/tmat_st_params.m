function tmat_set_params

more off


global SPAN2 SPAN2HALF C CR DX_OVERLAP RADIAL_SPAN
global NPTS_SPAN_THRESHOLD NPTS_HALFSPAN_THRESHOLD
global NPTS_NORTH NPTS_SOUTH NPTS_EAST NPTS_WEST
global GRIDX GRIDY


GRIDX=[0:.1:9.9];
GRIDY=[0:.1:35.9];



%----------------------------------------------------------------------
% Set the radial span of the gridding. This is the loess half-power radius in 
% units of meters.
%----------------------------------------------------------------------

RADIAL_SPAN = 50e3;


%----------------------------------------------------------------------
% Thresholds for the number of observations within each grid cell,
% and for the number of obs that must surround the center of the
% grid in each geodetic direction
%----------------------------------------------------------------------

NPTS_SPAN_THRESHOLD = 2;   % Must have this many pts within SPAN distance to 
                            % obtain a gridded estimate at that grid point
NPTS_HALFSPAN_THRESHOLD = 1;
NPTS_NORTH = 0;
NPTS_SOUTH = 0;
NPTS_EAST  = 0;
NPTS_WEST  = 0;


%----------------------------------------------------------------------
% Miscellaneous parameters that get calculated only once
%----------------------------------------------------------------------


%
% Span in spatial distance
%

SPAN2 = RADIAL_SPAN^2;
SPAN2HALF = SPAN2/4;

% distance of 1deg latitude

r = 6371000;
C = 2*pi/360;
CR = C*r;

DX_OVERLAP = 6;  %RADIAL_SPAN/CR/cos(deg2rad(84));



%----------------------------------------------------------------------
