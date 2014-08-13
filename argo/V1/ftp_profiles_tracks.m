clear all
load eddy_argo_prof_index

load /matlab/data/eddy/V4/full_tracks/dCC_lat_lon_tracks.mat id nneg lon lat amp

uid=unique(id);
same_prof=sames(uid,eddy_id);
eddy_pfile=eddy_pfile(same_prof);


%get missing profiles
fobj = ftp('www.usgodae.org')
cd(fobj,'pub/outgoing/argo/dac')
for m=1:length(same_prof)
	%now look to see if float is in eddy
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
	
