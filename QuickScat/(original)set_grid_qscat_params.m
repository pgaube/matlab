function set_grid_qscat_params

more off

global TOP_LEVEL_DIR
global QSCAT_ORBIT_FILE_DIR
global GRID_SWATH_DATA_OUTPUT_DIR
global RADIAL_SPAN
global SSMI_ICE_FILE_DIR
global GRIDX GRIDY
global NX_GRID NY_GRID 
global TIME_SPAN
global ICE_THRESHOLD
global SL
global SOS_ALL_THRESHOLD
global ICLASS_THRESHOLD
global IRAIN_SCAT_THRESHOLD
global RAD_RAIN_THRESHOLD
global MIN_DIFF_THRESHOLD
global ICE_GRIDX ICE_GRIDY
global MATLAB_VERSION
global BEG_HEAD
global DAILY_AVG_OUTPUT_DIR
global WEEKLY_AVG_OUTPUT_DIR
global MONTHLY_AVG_OUTPUT_DIR
global SY SX
global SSMI_SAT_IDENTIFIER
global SSMI_DATA_VERSION
global ECHO_FP
global NPTS_SPAN_THRESHOLD NPTS_HALFSPAN_THRESHOLD
global NPTS_NORTH NPTS_SOUTH NPTS_EAST NPTS_WEST
global QSCAT_ORBIT_INFO_FILE
global SPAN2 SPAN2HALF C CR DX_OVERLAP
global NAN_MATRIX
global IX IY
global MAX_DWDX MAX_DWSTRDX
global MAX_WSPD MAX_STRM
global ICLASS_INT_THRESHOLD
global rho0 a0 b0 c0
global QSCAT_GCM_DIR_DIFF_THRESHOLD
global LOESS_AVG_OUTPUT_DIR


%----------------------------------------------------------------------
% Option to print out a formatted parameter list to the screen
% or to a file. ECHO_FP = 2 gives it the screen, fp=fopen(...)
% inserted here can give a pointer to a file.
%----------------------------------------------------------------------

ECHO_FP = 2;

%----------------------------------------------------------------------
% Define directory slashes
%----------------------------------------------------------------------

COMP = computer;

if strcmp(COMP,'PCWIN'),
    SL = '\';
else
    SL = '/';
end


%----------------------------------------------------------------------
% Get matlab version information for save functions
%----------------------------------------------------------------------

%tmp = ver;
%MATLAB_VERSION = str2num(tmp(2).Version(1));
%clear tmp

tmp = version;
MATLAB_VERSION = str2num(tmp(1));
clear tmp

%----------------------------------------------------------------------
% Specify the top level directory containing all the data and all the 
% data to be saved
%----------------------------------------------------------------------

TOP_LEVEL_DIR = '/Volumes/matlab/data/QuickScat/';

%----------------------------------------------------------------------
% Location of QuikSCAT orbital data
%----------------------------------------------------------------------

QSCAT_ORBIT_FILE_DIR = ['/home/wallaby/data/pgaube/data/qscat/swaths/'];

if exist(QSCAT_ORBIT_FILE_DIR) ~=7,
   error(['SET_GRID_QSCAT_PARAMS: Directory does not exist (', ...
          QSCAT_ORBIT_FILE_DIR,')'])
end

%----------------------------------------------------------------------
% Location to save gridded swath data. Will be put in folders mimicing
% the orbital directory structure.
%----------------------------------------------------------------------

GRID_SWATH_DATA_OUTPUT_DIR = ['/home/wallaby/data/pgaube/data/qscat/gridded_swath/'];

%GRID_SWATH_DATA_OUTPUT_DIR = [TOP_LEVEL_DIR,'gridded_swath/test/'];

if exist(GRID_SWATH_DATA_OUTPUT_DIR) ~=7,
   error(['SET_GRID_QSCAT_PARAMS: Directory does not exist (', ...
          GRID_SWATH_DATA_OUTPUT_DIR,')'])
end

%----------------------------------------------------------------------
% Set the radial span of the gridding. This is the loess half-power radius in 
% units of meters.
%----------------------------------------------------------------------

RADIAL_SPAN = 80e3;
%----------------------------------------------------------------------
% Threshold of calling the interpolated ice field "ice-filled"
%----------------------------------------------------------------------

ICE_THRESHOLD = 0.05;

%----------------------------------------------------------------------
% Define spatial grid
%----------------------------------------------------------------------

GRIDX = 0.125:0.25:359.875;
GRIDY = -89.875:0.25:89.875;

NX_GRID = length(GRIDX);
NY_GRID = length(GRIDY);

NAN_MATRIX = repmat(NaN,[NY_GRID NX_GRID]);

[IX,IY] = meshgrid(1:NX_GRID,1:NY_GRID);

%----------------------------------------------------------------------
% Thresholds for the selection of accurate wind retrievals
% in the gridding process
%----------------------------------------------------------------------

SOS_ALL_THRESHOLD = 2.2;
ICLASS_THRESHOLD = 1;
IRAIN_SCAT_THRESHOLD = 2;
RAD_RAIN_THRESHOLD = 0.15;
MIN_DIFF_THRESHOLD = 180;

ICLASS_INT_THRESHOLD = 3;
QSCAT_GCM_DIR_DIFF_THRESHOLD = 90;

%----------------------------------------------------------------------
% Thresholds for the number of observations within each grid cell,
% and for the number of obs that must surround the center of the
% grid in each geodetic direction
%----------------------------------------------------------------------

NPTS_SPAN_THRESHOLD = 10;   % Must have this many pts within SPAN distance to 
                           % obtain a gridded estimate at that grid point
NPTS_HALFSPAN_THRESHOLD = 5;
NPTS_NORTH = 4;
NPTS_SOUTH = 4;
NPTS_EAST  = 4;
NPTS_WEST  = 4;

%----------------------------------------------------------------------
% Quality control check for the gridded winds
%----------------------------------------------------------------------

MAX_WSPD = 70;
MAX_STRM = 7.5;
MAX_DWDX = 0.5e-3;
MAX_DWSTRDX = 0.5e-5;



%----------------------------------------------------------------------
% Location of SSMI gridded ice fields
% Assume that if the SSMI_ICE_FILE_DIR is left empty, i.e., if
% SSMI_ICE_FILE_DIR = [], then no ice flagging is done.
%----------------------------------------------------------------------

SSMI_ICE_FILE_DIR =  '/home/wallaby/data/pgaube/data/ssmi/';

if ~isempty(SSMI_ICE_FILE_DIR) & exist(SSMI_ICE_FILE_DIR) ~=7,
   error(['SET_GRID_QSCAT_PARAMS: Directory does not exist (', ...
          SSMI_ICE_FILE_DIR,')'])
end

%----------------------------------------------------------------------
% Specify the spatial grid of the gridded ice fields
%----------------------------------------------------------------------

ICE_GRIDX = GRIDX;
ICE_GRIDY = GRIDY;

%----------------------------------------------------------------------
% Specify SSMI satellite number and dataset version number used
% for ice removal
%----------------------------------------------------------------------

SSMI_SAT_IDENTIFIER = 'f14';
SSMI_DATA_VERSION = 'v6';

%----------------------------------------------------------------------
% prefix for the gridded orbit file names
%----------------------------------------------------------------------

BEG_HEAD = 'global_';

%----------------------------------------------------------------------
% Directories to save the time-averaged fields
%----------------------------------------------------------------------

LOESS_AVG_OUTPUT_DIR =  '/Volumes/data/pgaube/data/QuickScat/swath/grid_swath/loess_21_week/';

DAILY_AVG_OUTPUT_DIR =  ['/home/wallaby/data/pgaube/data/qscat/avg_fields/daily/'];
%DAILY_AVG_OUTPUT_DIR = 'G:/QuikSCAT_winds/Larry_processed/gridded_swath/test/daily/';

if ~isempty(DAILY_AVG_OUTPUT_DIR) & exist(DAILY_AVG_OUTPUT_DIR) ~=7,
   error(['SET_GRID_QSCAT_PARAMS: Directory does not exist (', ...
          DAILY_AVG_OUTPUT_DIR,')'])
end

WEEKLY_AVG_OUTPUT_DIR =  '/home/wallaby/data/pgaube/data/qscat/avg_fields/weekly/';
%WEEKLY_AVG_OUTPUT_DIR = 'G:/QuikSCAT_winds/Larry_processed/gridded_swath/test/weekly/';

if ~isempty (WEEKLY_AVG_OUTPUT_DIR) & exist(WEEKLY_AVG_OUTPUT_DIR) ~=7,
   error(['SET_GRID_QSCAT_PARAMS: Directory does not exist (', ...
          WEEKLY_AVG_OUTPUT_DIR,')'])
end

MONTHLY_AVG_OUTPUT_DIR =  ['/home/wallaby/data/pgaube/data/qscat/avg_fields/monthly/'];
%MONTHLY_AVG_OUTPUT_DIR = 'G:/QuikSCAT_winds/Larry_processed/gridded_swath/test/monthly/';

if ~isempty(MONTHLY_AVG_OUTPUT_DIR) & exist(MONTHLY_AVG_OUTPUT_DIR) ~=7,
   error(['SET_GRID_QSCAT_PARAMS: Directory does not exist (', ...
          MONTHLY_AVG_OUTPUT_DIR,')'])
end

%----------------------------------------------------------------------
% Indices of the full gridded global swaths to use
% when making the time averages
%----------------------------------------------------------------------

SX = 1:length(GRIDX);
SY = 81:640;   % gives a latitude range of -69.875:0.25:69.875

%----------------------------------------------------------------------
% Location of the QuikSCAT orbit information file. Contains all the
% times of each orbit, which is needed to grid swaths for specific
% periods. Information taken directly from the SSMI website and saved
% as a .txt file.
%----------------------------------------------------------------------

QSCAT_ORBIT_INFO_FILE = [TOP_LEVEL_DIR,'qscat_info.txt'];

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

% For the computation of stress and the drag coefficient

rho0 = 1.223;   % density
a0   = 2.7e-3;
b0   = 0.142e-3;
c0   = 0.0764e-3;

%----------------------------------------------------------------------
