set(0,'DefaultFigureVisible','off')
clear all
close all


set_satfish

% cd(REMOVE_DIR)
% tmp=dir('*.png');
% !rm -r *.png
% 
% cd(L0_IMAGE_DIR)
% !cp * ~/fish/satfish/sf_web_images_arc/

%
%ftp data to FD ftp server
fobj = ftp('ftp2.ftptoyoursite.com:21','gaube','Fishsst123');
% fobj = ftp('ftp.fishdope.com:21','gaube','Fishsst123');
% pasv(fobj);

% % dir(fobj)
cd(CA1_IMAGE_DIR)
% cd(fobj,'scmo/');
cd(fobj,'socalmo/');

mput(fobj,'*ca1*.png')
!cp * ~/satfish/images/sf_web_images_arc/
!rm -r *.png

cd([IMAGE_DIR,'/ca2_out/'])
cd(fobj,'/chi/');
mput(fobj,'ca2*.png')
!rm -r *.png

cd([IMAGE_DIR,'/ca3_out/'])
cd(fobj,'/scio/');
mput(fobj,'ca3*.png')
!rm -r *.png

cd([IMAGE_DIR,'/ca4_out/'])
cd(fobj,'/scob/');
mput(fobj,'ca4*.png')
!rm -r *.png

cd([IMAGE_DIR,'/ca5_out/'])
cd(fobj,'/sd2ens/');
mput(fobj,'ca5*.png')
!rm -r *.png

cd([IMAGE_DIR,'/ca6_out/'])
cd(fobj,'/e2sq/');
mput(fobj,'ca6*.png')
!rm -r *.png


% for m=1:length(tmp)
% 	fname=num2str(getfield(tmp,{m},'name'))
% 	delete(fobj,fname)
% end

close(fobj);
%

% % cd(IMAGE_DIR)