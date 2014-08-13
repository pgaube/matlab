%loads SeaWiFS CHL data from the gsm algorithum
clear all
%close all
jdays=[2450821:2454489];



%Set path and region
save_path = '/matlab/data/gsm/mat/GSM_9_21_';

for m=1:length(jdays)
	if exist([save_path num2str(jdays(m)),'.mat'])
		load([save_path num2str(jdays(m))],'gpar_week','glat')
		if exist('gpar_week')
			m
			[yea,mon,day]=jd2jdate(jdays(m));
			yd=julian(mon,day,yea,yea);
			dl=daylength(yd,glat);
			gpar_week=24*gpar_week./dl;

			save([save_path num2str(jdays(m))],'gpar_week','-append')
			clear gpar_week dl yd year mon day
		end	
	end	
end

