clear all
close all
startjd=2448910;
endjd=2454832;
jdays=startjd:7:endjd;

HEAD='/Volumes/matlab/data/eddy/V4/mat/AVISO_25_W_';
load([HEAD,num2str(jdays(1))],'lat','lon','ssh')

load /Volumes/matlab/data/eddy/V4/global_tracks_V4.mat
for m=210:length(jdays)
	fprintf('\r Jdays %3u of %3u \r',m,length(jdays))
	per_ssh=nan*ssh;
	fname=[HEAD,num2str(jdays(m))];
	load(fname)
	ttmp=find(track_jday>=jdays(m)-.1 & track_jday<=jdays(m)+.1);
	for p=1:length(ttmp)
		ii=find(abs(idmask)==eid(ttmp(p)));
		%if any(ii)
		%	per_ssh(ii)=edge_ssh(ttmp(p));
		%else
		%	error('ii=[], m = ',m)
		%end	
	end
	eval(['save -append ' fname ' per_ssh'])
end	
		
		
	
	