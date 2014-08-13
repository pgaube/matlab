clear
ssh_path='~/data/eddy/V5/mat/'
ssh_head='AVISO_25_W_'

load global_tracks_v5_12_weeks

jdays=track_jday(1):7:track_jday(end);
jdays=[2451913:7:2455137];
for m=1:length(jdays)
	m
	load([ssh_path ssh_head num2str(jdays(m))],'idmask','lat','lon','ssh')
	
	ls_mask_ac=nan*idmask;
	ls_mask_cc=nan*idmask;
	
	ip=find(track_jday==jdays(m));
	
		for p=1:length(ip)
			dist=sqrt((111.11*(lat-y(ip(p)))).^2+((111.11*cosd(y(ip(p))))*(lon-x(ip(p)))).^2);
			if  cyc(ip(p))==1
				ii=find(dist<=scale(ip(p)));
				ls_mask_ac(ii)=eid(ip(p));
			elseif 	cyc(ip(p))==-1
				ii=find(dist<=scale(ip(p)));
				ls_mask_cc(ii)=eid(ip(p));
			end
		end
	%{
	figure(1)
	clf
	subplot(211)
	pmap(lon,lat,ls2_mask_ac);
	subplot(212)
	pmap(lon,lat,ls2_mask_cc);
	%}
	eval(['save -append	' [ssh_path ssh_head num2str(jdays(m))] ' ls_mask_ac ls_mask_cc'])
end	

