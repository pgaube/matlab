clear all
set_regions
spath='/matlab/data/gsm/mat/GSM_9_21_';
load /matlab/data/eddy/V5/global_tracks_v5_12_weeks track_jday
jdays=unique(track_jday);
load([spath num2str(jdays(400))],'sm_gchl_200_day','glon','glat')
clear jdays
for trt=1:length(curs)
	load(['/matlab/matlab/regions/tracks/tight/',curs{trt},'_tracks'])
	jdays=unique(track_jday);
	[chl_anom,car_anom,cc_anom]=deal(nan*x);
	
	for p=1:length(jdays)
		fprintf('finding chl of week %03u of %03u \r',p,length(jdays))
		if exist([spath num2str(jdays(p)) '.mat'])
			load([spath num2str(jdays(p))],'sp66_chl','sp66_car','sp66_cc')
			if exist('sp66_chl') & exist('sp66_car') & exist('sp66_cc')
				f1=find(track_jday==jdays(p));
				for n=1:length(f1)
					[r,c]=imap(y(f1(n))-.125,y(f1(n))+.125,x(f1(n))-.125,x(f1(n))+.125,glat,glon);
					chl_anom(f1(n))=double(sp66_chl(r(1),c(1)));
					car_anom(f1(n))=double(sp66_car(r(1),c(1)));
					cc_anom(f1(n))=double(sp66_cc(r(1),c(1)));
				end
			end
			clear sp66_*
		end
	end	
	eval(['save -append /matlab/matlab/regions/tracks/tight/',curs{trt},'_tracks chl_anom car_anom cc_anom'])
end		
