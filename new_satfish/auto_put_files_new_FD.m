clear all
close all


set_satfish

%%First do FishDope Domain
%ftp data to FD ftp server
fobj = ftp('ftp2.ftptoyoursite.com:21','gaube','Fishsst123');
%%my home dir is chats


% % dir(fobj)
cd(CA1_AUTO_IMAGE_DIR)
%%make file list

%%first do ne* because it's only sent to one folder (for now)
%%file list for wa* domain
tmp=dir('*png');

for m=1:length(tmp)
    tt=num2str(getfield(tmp,{m},'name'))
    fname(m,:)=['ne*' tt(4:20) '*']
end


cd(fobj,'/chart2/upload/canyons/');
for m=1:length(tmp)
    mput(fobj,fname(m,:))
end

%%next do wa* because it's only sent to one folder (for now)
%%file list for wa* domain
tmp=dir('*png');

for m=1:length(tmp)
    tt=num2str(getfield(tmp,{m},'name'))
    fname(m,:)=['wa*' tt(4:20) '*']
end


cd(fobj,'/chart2/upload/wa/');
% cd(fobj,'/chart2/upload/wa/');
for m=1:length(tmp)
    mput(fobj,fname(m,:))
end

%%next do ca* domain
tmp=dir('*png');
%%file list for ca* domain
for m=1:length(tmp)
    tt=num2str(getfield(tmp,{m},'name'))
    fname(m,:)=['ca*' tt(4:20) '*']
end


cd(fobj,'/chart/upload/socalmo/');
for m=1:length(tmp)
    mput(fobj,fname(m,:))
end

!cp * ~/satfish/images/sf_web_images_arc/
!rm -r *.png

cd([IMAGE_DIR,'/ca2_out/'])
cd(fobj,'/chart/upload/chi/');
for m=1:length(tmp)
    mput(fobj,fname(m,:))
end
% !rm -r *.png

cd([IMAGE_DIR,'/ca3_out/'])
cd(fobj,'/chart/upload/scio/');
for m=1:length(tmp)
    mput(fobj,fname(m,:))
end
% !rm -r *.png

cd([IMAGE_DIR,'/ca4_out/'])
cd(fobj,'/chart/upload/scob/');
for m=1:length(tmp)
    mput(fobj,fname(m,:))
end
% !rm -r *.png

cd([IMAGE_DIR,'/ca5_out/'])
cd(fobj,'/chart/upload/sd2ens/');
for m=1:length(tmp)
    mput(fobj,fname(m,:))
end
% !rm -r *.png

cd([IMAGE_DIR,'/ca6_out/'])
cd(fobj,'/chart/upload/e2sq/');
for m=1:length(tmp)
    mput(fobj,fname(m,:))
end
% !rm -r *.png

close(fobj);
cd(HOME_DIR)