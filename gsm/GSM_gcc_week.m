%loads SeaWiFS CHL data from the gsm algorithum
clear all
%close all
jdays=[2450821:2454489];



%Set path and region
save_path = '/matlab/data/gsm/mat/GSM_9_21_';

for m=1:length(jdays)
	if exist([save_path num2str(jdays(m)),'.mat'])
		load([save_path num2str(jdays(m))],'gchl_week')
		if exist('gchl_week')
			m
			lp=linx_smooth2d_fill_f(gchl_week,6,6);
			hp66_interp_chl=gchl_week-lp;

			save([save_path num2str(jdays(m))],'hp66_interp_chl','-append')
			clear gchl_week lp
		end	
	end	
end

