function out=ftp_batch_profile(pname)

%get missing profiles
fobj = ftp('www.usgodae.org');
cd(fobj,'pub/outgoing/argo/dac');
for nn=1:length(pname)
    tmp=num2str(pname{nn});
    jj=find(tmp=='/');
    fname=tmp(jj(3)+1:length(tmp));
    v=dir(fobj,[tmp(1:jj(3)),tmp(jj(3)+1:length(tmp))]);
    if length(v)>0
        cd(fobj,tmp(1:jj(3)));
        mget(fobj,tmp(jj(3)+1:length(tmp)),'/Users/new_gaube/data/argo/profiles/');
    else
        display(['could not find profile on server',tmp])
    end
end
close(fobj)
out=fname;
	
