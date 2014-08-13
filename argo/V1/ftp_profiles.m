clear all
load eddy_argo_prof_index
fobj = ftp('www.usgodae.org')
%pasv(fobj)
cd(fobj,'pub/outgoing/argo/dac')
for m=1:length(eddy_plat)
	tmp=num2str(eddy_pfile{m});
	jj=find(tmp=='/');
	fname=tmp(jj(3)+1:length(tmp));
	if ~exist(['/data/argo/profiles/', fname])
		v=dir(fobj,[tmp(1:jj(3)),tmp(jj(3)+1:length(tmp))]);
		if length(v)>0
			cd(fobj,tmp(1:jj(3)));
			mget(fobj,tmp(jj(3)+1:length(tmp)),'/data/argo/profiles/')
			cd(fobj,'/pub/outgoing/argo/dac');
		end	
	end	
end
close(fobj)
	
