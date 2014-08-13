%loads SeaWiFS CHL data from the gsm algorithum
clear all
close all
jdays=[2450821:2454489];



%Set path and region
save_path = '/matlab/data/gsm/mat/GSM_9_21_';

for m=1:length(jdays)
	if exist([save_path num2str(jdays(m)),'.mat'])
		load([save_path num2str(jdays(m))],'sm_gchl_200_day')
		if exist('sm_gchl_200_day')
			m
			sm_dchldy_200_day=-dfdy(10.^sm_gchl_200_day,.25);
			save([save_path num2str(jdays(m))],'sm_dchldy_200_day','-append')
			clear sm_gchl_200_day sm_dchldy_200_day
		end	
	end	
end

