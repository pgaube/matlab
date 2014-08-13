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

%%%%%
%mlat=mlat+.0125;
%mlon=mlon+.01;

%%%%%

!rm *fd.hdf
!rm *wa.hdf
!rm *wi.hdf

cd(AVHRR_DATA_DIR)
eval(['!cwdownload --age 5 --station mo --dir ',AVHRR_DATA_DIR,' vmcwsst3.nesdis.noaa.gov'])



%now loop through each hdf file and register
!toast *n15*.hdf
tmp=dir('*mo*hdf');
for m=1:length(tmp)
    fname=num2str(getfield(tmp,{m},'name'));
    fout=fname;
    fout(19:20)='fd';
    if ~exist([AVHRR_ARC_DIR fout],'file')
        eval(['!cwregister ' HOME_DIR '/pgSoCal_master.hdf ' [AVHRR_DATA_DIR fname] ' ' fout])
        eval(['!cwautonav ' HOME_DIR '/sw/fd_domain_autonav.txt sst ' [AVHRR_DATA_DIR fout]])
        eval(['!cwangles -l -f ' [AVHRR_DATA_DIR fout]])
        eval(['!cp ' [AVHRR_DATA_DIR fout] ' ' AVHRR_SF_DIR])
        eval(['!touch ' [AVHRR_ARC_DIR fout]])
        eval(['!touch ' [AVHRR_ARC_DIR fname]])
    end
    
    fout=fname;
    fout(19:20)='wa';
    if ~exist([AVHRR_ARC_DIR fout],'file')
        eval(['!cwregister ' HOME_DIR '/pgWA1_master.hdf ' [AVHRR_DATA_DIR fname] ' ' fout])
        %         eval(['!cwautonav ' HOME_DIR '/sw/fd_domain_autonav.txt sst ' [AVHRR_DATA_DIR fout]])
        eval(['!cwangles -l -f ' [AVHRR_DATA_DIR fout]])
        eval(['!cp ' [AVHRR_DATA_DIR fout] ' ' AVHRR_SF_DIR])
        %       eval(['!cp ' [AVHRR_DATA_DIR fout] ' ' HOME_DIR '/mask/'])
        eval(['!touch ' [AVHRR_ARC_DIR fout]])
        eval(['!touch ' [AVHRR_ARC_DIR fname]])
    end
    
end
% 
eval(['!cwdownload --age 5 --station wi --dir ',AVHRR_DATA_DIR,' vmcwsst3.nesdis.noaa.gov'])
!toast *n15*.hdf
tmp=dir('*wi*hdf');
for m=1:length(tmp)
    fname=num2str(getfield(tmp,{m},'name'));
    fout=fname;
    fout(19:20)='ne';
    if ~exist([AVHRR_ARC_DIR fout],'file')
        eval(['!cwregister ~/satfish/NE1_master.hdf ' [AVHRR_DATA_DIR fname] ' ' fout])
        %         eval(['!cwautonav ' HOME_DIR '/sw/fd_domain_autonav.txt sst ' [AVHRR_DATA_DIR fout]])
        eval(['!cwangles -l -f ' [AVHRR_DATA_DIR fout]])
        eval(['!cp ' [AVHRR_DATA_DIR fout] ' ' AVHRR_SF_DIR])
        %       eval(['!cp ' [AVHRR_DATA_DIR fout] ' ' HOME_DIR '/mask/'])
        eval(['!touch ' [AVHRR_ARC_DIR fout]])
        eval(['!touch ' [AVHRR_ARC_DIR fname]])
    end
    
end

tmp=dir('*hdf');
for m=1:length(tmp)
    fname=num2str(getfield(tmp,{m},'name'));
    eval(['!echo -n > ' [AVHRR_DATA_DIR fname]])
end



cd(HOME_DIR)
