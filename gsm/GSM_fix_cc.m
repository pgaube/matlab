%loads SeaWiFS CHL data from the gsm algorithum
clear all
close all
jdays=[2450821:2454489];



%Set path and region
save_path = '/matlab/data/gsm/mat/GSM_9_21_';

for m=1:length(jdays)
	if exist([save_path num2str(jdays(m)),'.mat'])
		load([save_path num2str(jdays(m))],'gcc_week')
		if exist('gcc_week')
			m
			gcc_week(gcc_week<0)=nan;
			save([save_path num2str(jdays(m))],'gcc_week','-append')
			clear gcc_week
		end	
	end	
end

