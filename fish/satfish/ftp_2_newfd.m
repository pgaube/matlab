set(0,'DefaultFigureVisible','off')
clear all
close all


set_satfish

cd(REMOVE_DIR)
tmp=dir('*.png');
!rm -r *.png

cd(L0_IMAGE_DIR)
!cp * ~/fish/satfish/sf_web_images_arc/

%
%ftp data to FD ftp server
fobj = ftp('ftp2.ftptoyoursite.com:21','fishsst','z217ygUWn');
pasv(fobj);
cd(fobj,'/web/content/bnk_fish/images/');
mput(fobj,'*.png')

for m=1:length(tmp)
	fname=num2str(getfield(tmp,{m},'name'))
	delete(fobj,fname)
end

close(fobj);
%

!rm -r *
cd(HOME_DIR)