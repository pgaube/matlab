clear all
%
% spath='~/matlab/pop/mat/run14_';
% seapath='/Users/new_gaube/data/gsm/mat/GSM_9_21_';
% load ~/matlab/pop/mat/pop_model_domain lat lon
pdays=[1740:1773 1801:1873 1901:1973 2001:2073 2101:2139];
%
% %%make jdays that encompase same date range
% %first pop week is week 40 = day 200.
% %consider 2001, day 200 is July 7th, 2001.
% %closest mid_week_jday is 2452116
%
% jdays=2452116:7:2452116+365*6;
% interp_jdays=2452116:5:2452116+365*6;
%
% %%load seawifs mask
% load /Users/new_gaube/data/gsm/mat/GSM_9_21_2452172 glat glon
% [r,c]=imap(min(lat(:)),max(lat(:)),min(lon(:)),max(lon(:)),glat,glon);
%
% mask=nan(length(r),length(c),length(jdays));
% imask=nan(length(r),length(c),length(interp_jdays));
%
% for m=1:length(jdays)
%     load([seapath num2str(jdays(m))],'gchl_week')
%     tmp_mask=nan*gchl_week(r,c);
%     tmp_mask(~isnan(gchl_week(r,c)))=1;
%     mask(:,:,m)=flipud(tmp_mask);
%     %     figure(1)
%     %     clf
%     %     pmap(glon(r,c),flipud(glat(r,c)),mask(:,:,m));
%     %     drawnow
% end
%
%
% %interpolate to 5-day
% for m=1:length(r)
%     for n=1:length(c)
%         imask(m,n,:)=interp1(jdays,squeeze(mask(m,n,:)),interp_jdays,'nearest');
%     end
% end
%
% imask=imask(:,:,1:length(pdays));
%
% %interpolate to pop grid
% pimask=nan(length(lat(:,1)),length(lon(1,:)),length(pdays));
%
% for m=1:length(pdays)
%     pimask(:,:,m)=griddata(double(glon(r,c)),double(flipud(glat(r,c))),double(imask(:,:,m)),double(lon),double(lat),'nearest');
%
% % figure(1)
% % clf
% % pmap(lon,lat,pimask(:,:,1));
% % drawnow
% % return
% end
% save seawifs_cloud_mask lon lat pimask pdays itnerp_jdays


load seawifs_cloud_mask
load tmp_chl lat lon pdays

for m=1:length(pdays)
    eval(['load mat/run14_',num2str(pdays(m)),' hp66_chl'])
    if exist('hp66_chl')
        mask_hp66_chl=hp66_chl.*pimask(:,:,m);
        figure(1)
        clf
        pmap(lon,lat,mask_hp66_chl);
        caxis([-.2 .2])
        drawnow
        
        eval(['save -append mat/run14_',num2str(pdays(m)),' mask_hp66_chl'])
        clear *hp66*
    end
end