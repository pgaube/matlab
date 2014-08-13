
global STEP
global CHL_PATH
global CHL_HEAD
global OUT_PATH
global OUT_HEAD
global SSH_PATH
global TRACK_DATA
global SSH_HEAD
global AMSRE_PATH
global AMSRE_HEAD
global OI_PATH
global OI_HEAD
global Q_PATH
global Q_HEAD
global RAND_PATH
global RAND_HEAD
global MSST_PATH
global MSST_HEAD
global CHL_DATA
global START_JD
global END_JD
global MIN_AMP
global MAX_AMP
global MIN_DUR
global START_YR
global START_MO
global START_DY
global END_YR
global END_MO
global END_DY
global RAD_ADD
global RAD_MULT
global MAX_AMP
global SAM_RAD
global SCENE RAD

%--------------------------------------------------------------------------------
%Set data file locations
%--------------------------------------------------------------------------------

SSH_HEAD   = 'AVISO_25_W_';
SSH_PATH   = '/matlab/data/eddy/V4/mat/';

AMSRE_HEAD   = 'AMSRE_25_W_';
AMSRE_PATH   = '/matlab/data/AMSRE/mat/';

Q_HEAD   = 'QSCAT_W_25km_';
Q_PATH   = '/matlab/data/QuickScat/mat/';

OI_HEAD   = 'OI_25_W_';
OI_PATH   = '/matlab/data/ReynoldsSST/mat/';

CHL_HEAD   = 'CHL_4_W_';
CHL_PATH   = '/matlab/matlab/global/modis_chl_4km/';

CHL_HEAD   = 'SST_4_W_';
CHL_PATH   = '/matlab/matlab/global/modis_sst_4km/';

TRACK_DATA = '/matlab/data/eddy/V4/global_tracks_V4_16_weeks.mat';
TRACK_OUT  = '/matlab/matlab/global/new_trans_samp/global_sam_tracks_V4_16_weeks.mat';

RAND_HEAD   = 'RAND_W_';
RAND_PATH   = '/matlab/data/rand/';

SST_WIND_HEAD = 'SSTWIND_25_W_';
SST_WIND_PATH = '/matlab/data/SSTWIND/mat/';

OUT_HEAD   = 'CRLT_W_';
OUT_PATH   = '/matlab/matlab/global/crl_test/';



%----------------------------------------------------------------------
% Load data
%----------------------------------------------------------------------

eval(['load ' TRACK_OUT]);



%--------------------------------------------------------------------------------
% Define Scene and Sample radius
%--------------------------------------------------------------------------------

SAM_RAD     = 250e3; %in meters
SCENE_RAD   = 5;   %degrees

%--------------------------------------------------------------------------------
%Set dates over which tracking should be done
%--------------------------------------------------------------------------------

%Set range of dates
START_YR = 2002;
START_MO = 07;
START_DY = 03;
END_YR= 2008;
END_MO = 01;
END_DY = 23;


%construct date variables
START_JD=date2jd(START_YR,START_MO,START_DY)+.5;
END_JD=date2jd(END_YR,END_MO,END_DY)+.5;
jdays = START_JD:7:END_JD;






