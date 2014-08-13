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

set_satfish


cd(AVHRR_DATA_DIR)
eval(['!cwdownload --age 24 --station wi --dir ',AVHRR_DATA_DIR,' vmcwsst3.nesdis.noaa.gov'])
!rm *wn.hdf
!rm *ws.hdf
!rm *sl.hdf
!rm *sj.hdf




tmp=dir('*wi*hdf');
for m=1:length(tmp)
fname=num2str(getfield(tmp,{m},'name'));
fout=fname;
fout(19:20)='wi';
eval(['!cwregister ' HOME_DIR '/cc_master.hdf ' [AVHRR_DATA_DIR fname] ' ' fout])
%eval(['!cwautonav ' HOME_DIR '/sw/fd_domain_autonav.txt sst ' [AVHRR_DATA_DIR fout]])
eval(['!cwangles -l -f ' [AVHRR_DATA_DIR fout]])
%eval(['!cp ' [AVHRR_DATA_DIR fout] ' ' AVHRR_ARC_DIR])
eval(['!cp ' [AVHRR_DATA_DIR fout] ' ' AVHRR_SF_DIR])
end





cd(HOME_DIR)	
