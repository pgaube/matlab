
interp_jdays=[2450884:7:2454832];


load_path = '~/data/gsm/mat/'
load([load_path,'GSM_9_21_2450821'],'glon','glat')

data=single(nan(length(glat(:,1)),length(glat(1,:)),length(interp_jdays)));


for m=1:length(interp_jdays)
    fname = [load_path 'GSM_9_21_' num2str(interp_jdays(m)) '.mat'];
    if exist(fname)
        fprintf('\r     loading and calc grad of file %03u of %03u \r',m,length(interp_jdays))
        eval(['load ' fname ' sp66_chl'])
        if exist('sp66_chl')
            tt=abs(sp66_chl);
            data(:,:,m)=tt;
            clear sp66_chl
        end
    end
end

mean_hp66_chl=nanmean(data,3);

%
% for m=1:length(interp_jdays)
%     fname = [load_path 'GSM_9_21_' num2str(interp_jdays(m)) '.mat'];
%     if exist(fname)
%     	fprintf('\r     loading and calc grad of file %03u of %03u \r',m,length(interp_jdays))
% 		eval(['load ' fname ' gkd_week'])
% 		tt=1./gkd_week;
% 		data(:,:,m)=tt;
% 		clear gkd_week
% 	end
% end
%
% mean_optical_depth=nanmean(data,3);

save mean_gchl -append mean_*


