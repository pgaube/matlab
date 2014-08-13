set_satfish

%%first make sure no files are waiting
auto_put_files_new_FD

%%note this script is specific to seasat

%%%first figure out date of file name
if s(2)<10 & s(3)<10
    pd=[num2str(s(1)-2000) '0' num2str(s(2)) '0' num2str(s(3))];
elseif s(2)>=10 & s(3)<10
    pd=[num2str(s(1)-2000) num2str(s(2)) '0' num2str(s(3))];
elseif s(2)<10 & s(3)>=10
    pd=[num2str(s(1)-2000) '0' num2str(s(2)) num2str(s(3))];
else
    pd=[num2str(s(1)-2000) num2str(s(2)) num2str(s(3))];
end
pd
cd ~/satfish/images/sf_web_images_arc/

%%test to see if a SST was uploaded
tmp=dir(['*bdsc_',pd,'*.png']);
if length(tmp)==0
    sendmail('pgaube@gmail.com',['Failed to upload SST on ',pd],['Today is ',num2str(date)])
else
    display('SST found')
end

%%test to see if a CHL was uploaded
tmp=dir(['*chl_',pd,'*.png']);
if length(tmp)==0
    sendmail('pgaube@gmail.com',['Failed to upload CHL on ',pd],['Today is ',num2str(date)])
else
    display('CHL found')
end

%%test to see if a Clouf Free SST was uploaded
tmp=dir(['*fsst_',pd,'*.png']);
if length(tmp)==0
    sendmail('pgaube@gmail.com',['Failed to upload fSST on ',pd],['Today is ',num2str(date)])
else
    display('fSST found')
end

cd(HOME_DIR)