%loads SeaWiFS CHL data from the gsm algorithum
clear all
%close all
jdays=[2450821:2454489];



%Set path and region
save_path = '/matlab/data/gsm/mat/GSM_9_21_';

for m=1:length(jdays)
	if exist([save_path num2str(jdays(m)),'.mat'])
		load([save_path num2str(jdays(m))],'gpar_week')
		if exist('gpar_week')
			m
			lp=linx_smooth2d_f(gcc_week,6,6);
			sp66_cc=gcc_week-lp;

			save([save_path num2str(jdays(m))],'sp66_cc','-append')
			clear gcc_week lp sp66_cc
		end	
	end	
end

