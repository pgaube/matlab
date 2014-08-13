%loads SeaWiFS CHL data from the gsm algorithum
clear all
close all
jdays=[2450821:2454489];



%Set path and region
save_path = '/matlab/data/gsm/mat/GSM_9_D_';

load([save_path num2str(jdays(400))],'gchl_day','glon','glat')
N_cov=zeros(size(gchl_day));
N=0;
for m=1:length(jdays)
	if exist([save_path num2str(jdays(m)),'.mat'])
		load([save_path num2str(jdays(m))],'gchl_day')
		if exist('gchl_day')
			m
			mask=zeros(size(gchl_day));
			mask(~isnan(gchl_day))=1;
			N_cov=N_cov+mask;
			N=N+1;
			clear mask gchl_day
		end	
	end	
end

save gchl_daily_coverage_map N_cov N