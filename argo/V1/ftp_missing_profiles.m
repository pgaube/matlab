clear all
load missing_profiles
fobj = ftp('www.usgodae.org')
%pasv(fobj)
cd(fobj,'pub/outgoing/argo/dac')
for m=1:length(misprof)
	tmp=num2str(misprof{m});
	jj=find(tmp=='/');
	cd(fobj,tmp(1:jj(3)));
	mget(fobj,tmp(jj(3)+1:length(tmp)),'/data/argo/profiles/')
	cd(fobj,'/pub/outgoing/argo/dac');
end
close(fobj)
	