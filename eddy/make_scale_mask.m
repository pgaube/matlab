clear all
close all
startjd=2448910;
endjd=2454832;
jdays=startjd:7:endjd;

HEAD='/Volumes/matlab/data/eddy/V4/mat/AVISO_25_W_';
load([HEAD,num2str(jdays(1))],'lat','lon','ssh')

load /Volumes/matlab/data/eddy/V4/global_tracks_V4.mat
for m=1:length(jdays)
	fprintf('\r Jdays %3u of %3u \r',m,length(jdays))
	scmask=nan*ssh;
	fname=[HEAD,num2str(jdays(m))];
	load(fname)
	ttmp=find(track_jday==jdays(m));
	for p=1:length(ttmp)
		dist=sqrt(((lon-x(ttmp(p))).*111.11.*cosd(lat)).^2+((lat-y(ttmp(p))).*111.11).^2);
		ie=find(dist<=scale(ttmp(p)));
		iee=find(dist<=2*scale(ttmp(p)));
		scmask(iee)=-eid(ttmp(p));
		scmask(ie)=eid(ttmp(p));
	end
	eval(['save -append ' fname ' scmask'])
end	
		
		
	
	