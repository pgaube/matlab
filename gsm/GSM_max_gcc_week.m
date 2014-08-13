%loads SeaWiFS CHL data from the gsm algorithum
clear all
close all
jdays=[2450821:2454461];



%Set path and region
save_path = '~/data/gsm/mat/GSM_9_21_';

for m=1:length(jdays)
	if exist([save_path num2str(jdays(m)),'.mat'])
		load([save_path num2str(jdays(m))],'gchl_week','gcar_week')
        m
        gcc_week=(10.^gchl_week)./(10.^gcar_week);
        gcc_week(gcc_week<0)=nan;
		
        lp=linx_smooth2d_f(gcc_week,6,6);
		sp66_cc=gcc_week-lp;
        
        save([save_path num2str(jdays(m))],'gcc_week','sp66_cc','-append')
		clear gcc_weeklp sp66_cc
	end	
end

