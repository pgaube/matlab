%set directorys
HOME_DIR 	= '/Users/fish/satfish';
DATA_DIR 	= [HOME_DIR '/data/'];
NPP_DATA_DIR = [HOME_DIR '/npp_data/'];
SSH_DIR = [HOME_DIR '/ssh_data/'];
AQUA_DATA_DIR = [HOME_DIR '/aqua_data/'];
AQUA_L1_DATA_DIR = [HOME_DIR '/aqua_L1_data/'];
AQUA_DATA_ARC = [HOME_DIR '/aqua_data_arc/'];
dCW_DIR 	= [HOME_DIR '/cwdata/'];
AVHRR_DATA_DIR 	= [HOME_DIR '/avhrr_data/poes/incoming/'];
AVHRR_ARC_DIR 	= [HOME_DIR '/avhrr_data/poes/arc/'];
AVHRR_CUR_DIR 	= [HOME_DIR '/avhrr_data/poes/cur/'];
AVHRR_SFCUR_DIR 	= [HOME_DIR '/avhrr_data/cur/'];
AVHRR_SF_DIR 	= [HOME_DIR '/avhrr_data/poes/SF/'];
CA1_IMAGE_DIR 	= [HOME_DIR '/images/ca1_out/'];
CA1_AUTO_IMAGE_DIR 	= [HOME_DIR '/images/ca1_auto/'];
IMAGE_DIR 	= [HOME_DIR '/images/'];
FULL_IMAGE_DIR 	= [HOME_DIR 'images/ca1_full/'];
MAT_DIR 	= [HOME_DIR '/mat/'];



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

load avhrr_mask

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
% load([HOME_DIR '/fishran'])
%ran=[54 67];
gran=[58 64];
fran=[1e-6 1.5e-4];
cran=[-1.3 1.2];  %summer
%cran=[-.9 .65]; %winter

fake_cran=[-.99 -.8];
adjt_up=-8;
adjt_down=1;


UTC=8;

%%%Now set up email
mail = 'full.spectrum.imaging@gmail.com'; %Your GMail email address
password = 'seaofcortez';  %Your GMail password
setpref('Internet','mail',mail);
setpref('Internet','SMTP_Server','smtp.gmail.com');
setpref('Internet','SMTP_Username',mail);
setpref('Internet','SMTP_Password',password);

% Gmail server.
props = java.lang.System.getProperties;
props.setProperty('mail.smtp.auth','true');
props.setProperty('mail.smtp.socketFactory.class', 'javax.net.ssl.SSLSocketFactory');
props.setProperty('mail.smtp.socketFactory.port','465');
