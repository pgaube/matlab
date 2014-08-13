clear
ssh_path='/matlab/data/eddy/V4/mat/'
ssh_head='AVISO_25_W_'

load global_tracks_v4

jdays=track_jday(1):7:track_jday(end);

for m=1:length(jdays)
	m
	load([ssh_path ssh_head num2str(jdays(m))],'idmask','lat','lon','ssh')
	
	ls_5_cm_mask=nan*idmask;
	
	ip=find(track_jday==jdays(m));
	
		for p=1:length(ip)
			if amp(ip(p))>=5
			dist=sqrt((111.11*(lat-y(ip(p)))).^2+((111.11*cosd(y(ip(p))))*(lon-x(ip(p)))).^2);
			ii=find(dist<=scale(ip(p)));
			ls_5_cm_mask(ii)=1;
			end
		end
	eval(['save -append	' [ssh_path ssh_head num2str(jdays(m))] ' ls_5_cm_mask'])
end	

