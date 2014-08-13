global DATA_DIR
global TERRA_DATA_DIR
global AQUA_DATA_DIR
global AQUA_DATA_ARC
global AVHRR_DATA_DIR
global AVHRR_ARC_DIR
global AVHRR_CUR_DIR
global AVHRR_HDF_DIR
global HOME_DIR
global IMAGE_DIR
global BUFF_DIR
global MASK_IMAGE_DIR
global CLOUD_IMAGE_DIR
global HDF_DIR
global MAT_DIR
global COMP_MAT_DIR
global COMP_IMG_DIR
global SW_DIR
global CW_DIR
global LINUX_CWF_DIR
global d
global s
global jd
global ran
global fran
global cran
global pd


%set directorys
HOME_DIR 	= '/Users/fish/fish';
DATA_DIR 	= [HOME_DIR '/data/'];
TERRA_DATA_DIR = [HOME_DIR '/terra_data/'];
AQUA_DATA_DIR = [HOME_DIR '/aqua_data/'];
AQUA_DATA_ARC = [HOME_DIR '/aqua_data_arc/'];
CW_DIR 	= [HOME_DIR '/cwdata/'];
AVHRR_HDF_DIR	= ['/Volumes/gaube/fish/avhrr_data/poes/out'];
AVHRR_DATA_DIR 	= [HOME_DIR '/avhrr_data/poes/incoming/'];
AVHRR_ARC_DIR 	= [HOME_DIR '/avhrr_data/poes/arc/'];
AVHRR_CUR_DIR 	= [HOME_DIR '/avhrr_data/poes/cur/'];
AVHRR_SFCUR_DIR 	= [HOME_DIR '/avhrr_data/poes/sfcur/'];
AVHRR_SF_DIR 	= [HOME_DIR '/avhrr_data/poes/SF/'];
BUFF_DIR 	= [HOME_DIR '/buff_image/'];
IMAGE_DIR 	= [HOME_DIR '/image/'];
IMAGE_DIR2 	= [HOME_DIR '/image2/'];
IMAGE_DIR3 	= [HOME_DIR '/image3/'];
AUTO_IMAGE_DIR 	= [HOME_DIR '/auto_image/'];
L0_IMAGE_DIR 	= [HOME_DIR '/l0_image/'];
MASK_IMAGE_DIR 	= [HOME_DIR '/mask_image/'];
FULL_IMAGE_DIR 	= [HOME_DIR '/fullimage/'];
PMASK_IMAGE_DIR 	= [HOME_DIR '/pgmaskimage/'];
HDF_DIR 	= [HOME_DIR '/hdf/'];
MAT_DIR 	= [HOME_DIR '/mat/'];
COMP_MAT_DIR 	= [HOME_DIR '/comp_mat/'];
COMP_IMG_DIR 	= [HOME_DIR '/comp_image/'];
CLOUD_IMAGE_DIR = [HOME_DIR '/cloud_image/'];
REMOVE_DIR	 	= [HOME_DIR '/remove_image/'];


%add software path
eval(['addpath(' char(39) HOME_DIR '/sw/' char(39) ')'])
eval(['addpath(' char(39) HOME_DIR '/sw/m_map/' char(39) ')'])
addpath('/Applications/MATLAB_R2010aSV.app/toolbox/mexnc/')
addpath('/Applications/MATLAB_R2010aSV.app/toolbox/mexcdf/')

%load stuff
load noaa.pal
load chelle.pal
load fdcolor.pal
pjet=jet(256);

labs=['bc';'wa';'or';'nc';'cc';'sc';'nb';'sb'];	

%make date vec
s=datevec(date);
jd=date2jd(s(1),s(2),s(3))+.5;
[s(1),s(2),s(3)]=jd2jdate(jd);
d=julian(s(2),s(3),s(1),s(1));
if s(2)<10 & s(3)<10
	pd=[num2str(s(1)-2000) '0' num2str(s(2)) '0' num2str(s(3))];
elseif s(2)>=10 & s(3)<10
	pd=[num2str(s(1)-2000) num2str(s(2)) '0' num2str(s(3))];	
elseif s(2)<10 & s(3)>=10
	pd=[num2str(s(1)-2000) '0' num2str(s(2)) num2str(s(3))];
else
	pd=[num2str(s(1)-2000) num2str(s(2)) num2str(s(3))];
end	
t=clock;
pt=t(4:5);

%color axis
load([HOME_DIR '/fishran'])
%ran=[54 67];
gran=[58 64];
fran=[4e-5 3e-4];
cran=[-1.5 1.2];
fake_cran=[-.99 -.8];
adjt_up=-10;
adjt_down=1;