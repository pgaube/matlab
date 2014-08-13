clear all
close all


set_satfish
return
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
%%make file list
tmp=dir('*png');
%ca2_bdsc_130827_0433_536_677.png
for m=1:length(tmp)
    tt=num2str(getfield(tmp,{m},'name'))
    
    fname(m,:)=['*' tt(4:20) '*']
end


% cd(fobj,'scmo/');
cd(fobj,'socalmo/');
for m=1:length(tmp)
    mput(fobj,fname(m,:))
end

!cp * ~/satfish/images/sf_web_images_arc/
!rm -r *.png

cd([IMAGE_DIR,'/ca2_out/'])
cd(fobj,'/chi/');
for m=1:length(tmp)
    mput(fobj,fname(m,:))
end
!rm -r *.png

cd([IMAGE_DIR,'/ca3_out/'])
cd(fobj,'/scio/');
for m=1:length(tmp)
    mput(fobj,fname(m,:))
end
!rm -r *.png

cd([IMAGE_DIR,'/ca4_out/'])
cd(fobj,'/scob/');
for m=1:length(tmp)
    mput(fobj,fname(m,:))
end
!rm -r *.png

cd([IMAGE_DIR,'/ca5_out/'])
cd(fobj,'/sd2ens/');
for m=1:length(tmp)
    mput(fobj,fname(m,:))
end
!rm -r *.png

cd([IMAGE_DIR,'/ca6_out/'])
cd(fobj,'/e2sq/');
for m=1:length(tmp)
    mput(fobj,fname(m,:))
end
!rm -r *.png


% for m=1:length(tmp)
% 	fname=num2str(getfield(tmp,{m},'name'))
% 	delete(fobj,fname)
% end

close(fobj);
%

cd(HOME_DIR)