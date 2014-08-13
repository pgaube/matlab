clear all
mon=['jan';'feb';'mar';'apr';'may';'jun';'jul';'aug';'sep';'oct';'nov';'dec'];


cd ~/data/eddy/V5/
% subset_tracks_v5('maurtitus_lat_lon');
subset_tracks_tight_v5('maurtitus_lat_lon');
% 
load maurtitus_lat_lon_tracks
% 
cd ~/matlab/mauritius/
% 
% 
% 
[chl_a,chl_c]=comps(x,y,cyc,k,id,track_jday,scale,'sp66_chl','~/data/gsm/mat/GSM_9_21_','dd');
[ssh_a,ssh_c]=comps(x,y,cyc,k,id,track_jday,scale,'ssh','~/data/eddy/V5/mat/AVISO_25_W_','n');
save MAU_comps
% % 
% % [yeaa,mona,daya]=jd2jdate(track_jday);
% % % 
% % for n=1:12
% %     ii=find(mona==n);
% %     eval(['[ma_',num2str(n),'_chl_a,ma',...
% %         '_',num2str(n),'_chl_c]=comps(x(ii),y(ii),cyc(ii),k(ii),id(ii),track_jday(ii),scale(ii),',...
% %         char(39),'sp66_chl',char(39),',',char(39),...
% %         '~/data/gsm/mat/GSM_9_21_',char(39),',',...
% %         char(39),'dd',char(39),');'])
% %     
% %     eval(['[ma_',num2str(n),'_ssh_a,ma',...
% %         '_',num2str(n),'_ssh_c]=comps(x(ii),y(ii),cyc(ii),k(ii),id(ii),track_jday(ii),scale(ii),',...
% %         char(39),'ssh',char(39),',',char(39),...
% %         '~/data/eddy/V5/mat/AVISO_25_W_',char(39),',',...
% %         char(39),'n',char(39),');'])
% %     
% % end
% % 
% % 
% % save -append MAU_comps
% % now plot
% 


%now plot
% 


clear
load MAU_comps
pcomps_raw2(chl_a.mean,ssh_a.mean,[-.07 .07],-100,2,100,['Normalized CHL Anomalies of Mauritius Anticyclones'],1,15)
print -dpng -r300 figs/chl_anom_anticyclones

pcomps_raw2(chl_c.mean,ssh_c.mean,[-.07 .07],-100,2,100,['Normalized CHL Anomalies of Mauritius Cyclones'],1,15)
print -dpng -r300 figs/chl_anom_cyclones
% 
% for n=1:12
%     eval(['pcomps_raw2(chl_a.mean,ssh_a.mean,[-.07 .07],-100,2,100,[',char(39),'Normalized CHL Anomalies of Mauritius Anticyclones',char(39),'],1,15)'])
%     eval(['print -dpng -r300 figs/chl_anom_',mon(n),'_anticyclones'])
%     
%     eval(['pcomps_raw2(chl_c.mean,ssh_c.mean,[-.07 .07],-100,2,100,[',char(39),'Normalized CHL Anomalies of Mauritius Anticyclones',char(39),'],1,15)'])
%     eval(['print -dpng -r300 figs/chl_anom_',mon(n),'_cyclones'])
% end

% 
% pcomps(chl_a,ssh_a.mean,[-.12 .12],-100,2,100,['Normalized CHL Anomalies of Mauritius Anticyclones'],2,15)
% pcomps(chl_c,ssh_c.mean,[-.12 .12],-100,2,100,['Normalized CHL Anomalies of Mauritius Cyclones'],2,15)
