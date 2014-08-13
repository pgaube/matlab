set(0,'DefaultFigureVisible','off')
clear all
close all
global DATA_DIR
global HOME_DIR
global IMAGE_DIR
global HDF_DIR
global MAT_DIR
global COMP_MAT_DIR
global d
global s
global jd
global ran
global fran
global AVHRR_DATA_DIR
global AVHRR_ARC_DIR
global AVHRR_CUR_DIR
global ran
global fran
global cran
global pd

set_fish

%%%%%
%mlat=mlat+.0125;
%mlon=mlon+.01;

%%%%%
cd(HOME_DIR)
!./get_poes_hourly.sh
cd(AVHRR_DATA_DIR)



%now loop through each hdf file and register
tmp=dir('*mo*hdf');
for m=1:length(tmp)
fname=num2str(getfield(tmp,{m},'name'));
fout=fname;
fout(19:20)='fd';
eval(['!cwregister ' HOME_DIR '/pgSoCal_master.hdf ' [AVHRR_DATA_DIR fname] ' ' fout])
eval(['!cwautonav ' HOME_DIR '/sw/fd_domain_autonav.txt sst ' [AVHRR_DATA_DIR fout]])
eval(['!cwangles -l -f ' [AVHRR_DATA_DIR fout]])
eval(['!cp ' [AVHRR_DATA_DIR fout] ' ' AVHRR_ARC_DIR])
%eval(['!cp ' [AVHRR_DATA_DIR fout] ' ' AVHRR_CUR_DIR])
end

cd(HOME_DIR)	
