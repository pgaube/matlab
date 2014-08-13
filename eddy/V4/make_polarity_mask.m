clear
ssh_path='/Volumes/matlab/data/eddy/V4/mat/'
ssh_head='AVISO_25_W_'

startyear = 1992;
startmonth = 10;
startday = 14;

endyear = 2008;
endmonth = 12;
endday = 31;

load global_tracks_v4

%construct date vector
startjd=date2jd(startyear,startmonth,startday)+.5;
endjd=date2jd(endyear,endmonth,endday)+.5;
jdays=[startjd:7:endjd];

for m=1:length(jdays)
	m
	load([ssh_path ssh_head num2str(jdays(m))],'idmask','lat','lon','ssh')
	
	a_mask=nan*idmask;
	c_mask=a_mask;
	
	ip=find(track_jday==jdays(m));
	
		for p=1:length(ip)
			loc=find(abs(idmask)==eid(ip(p)));
			if id(ip(p))>=nneg
				a_mask(loc)=1;
			else
				c_mask(loc)=1;
			end
		end
	eval(['save -append	' [ssh_path ssh_head num2str(jdays(m))] ' a_mask c_mask'])
end	

