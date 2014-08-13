clear all
% % %
% % 
load mat/pop_model_domain lat lon z r c
% % 
% % % select time period
% % vv=[1740:2139]; %this is the whole encilada
% % % vv=[1807:2139];
% % % vv=[1740:1750];
% % [i,tm]=size(vv); % tm = number of time levels
% % 
% % 
% % fname1='/private/d1/larrya/0pt1_run14/t.14.'; %with eddy wind
fname2='/Volumes/d1/larrya/0pt1_run33/t.33.'; %without eddy wind
% % 
% % [small_vint,diat_vint,diaz_vint]=deal(nan(length(lat(:,1)),length(lon(1,:)),tm));
% % 
% % % read data
% % tic
% % n=0;
% % for nn=vv; % time
% %     n=n+1;
% %     flid=num2str(nn)
% %     %first run14
% %     if exist([fname1 flid '.spc_vint104'])
% %         
% %         small_vint(:,:,n)=read_pop('/private/d1/larrya/0pt1_run14/t.14.',flid,'spc_vint104',1);
% %         diat_vint(:,:,n)=read_pop('/private/d1/larrya/0pt1_run14/t.14.',flid,'diatc_vint104',1);
% %         diaz_vint(:,:,n)=read_pop('/private/d1/larrya/0pt1_run14/t.14.',flid,'diazc_vint104',1);
% %     end
% %     
% % end;
% % 
% % save vint_3_phyto lon lat vv small_vint diat_vint diaz_vint
% % 
% 
% % load vint_3_phyto
% 
% f=2*pi/365.25;
% x=vv*5;
% 
% [ss_small,ss_diat,ss_diaz]=deal(nan(size(small_vint)));
% 
% for m=1:length(r);
%     for n=1:length(c);
%         small=squeeze(small_vint(m,n,:));
%         ss_small(m,n,:)=smooth1d_loess(small,vv',30,vv');
%        
% %         clf
% %         subplot(311)
% %         plot(small)
% %         hold on
% %         plot(squeeze(ss_small(m,n,:)),'r');
%         
%         diat=squeeze(diat_vint(m,n,:));
%         ss_diat(m,n,:)=smooth1d_loess(diat,vv',30,vv');
%         
% %         subplot(312)
% %         plot(diat)
% %         hold on
% %         plot(squeeze(ss_diat(m,n,:)),'r');
%         
%         diaz=squeeze(diaz_vint(m,n,:));
%         ss_diaz(m,n,:)=smooth1d_loess(diaz,vv',30,vv');
%         
% %         subplot(313)
% %         plot(diaz)
% %         hold on
% %         plot(squeeze(ss_diaz(m,n,:)),'r');
% %         drawnow
%     end
% end
% save time_filter_biomass ss* *_vint lat lon
%now write to output
% load time_filter_biomass
vv=[1740:2139]; %this is the whole encilada
for m=1:length(vv);
    flid=num2str(vv(m))
    %first run14
    if exist(['mat/run33_',num2str(vv(m)),'.mat'])
        load(['mat/run33_',num2str(vv(m))],'s','t')
        small_biomass=single(squeeze(small_vint(:,:,m)));
        tt=small_biomass-squeeze(ss_small(:,:,m));
        sm=smoothn(tt,11000);
        hp66_small_biomass=single(tt-sm);
        clear tt sm
        
        diat_biomass=single(squeeze(diat_vint(:,:,m)));
        tt=diat_biomass-squeeze(ss_diat(:,:,m));
        sm=smoothn(tt,11000);
        hp66_diat_biomass=single(tt-sm);
        clear tt sm
        
        diaz_biomass=single(squeeze(diaz_vint(:,:,m)));
        tt=diaz_biomass-squeeze(ss_diaz(:,:,m));
        sm=smoothn(tt,11000);
        hp66_diaz_biomass=single(tt-sm);
        clear tt sm
        
        save(['mat/run14_',num2str(vv(m))],'*biomass*','-append')
        clear tt sm
        
    end
end
