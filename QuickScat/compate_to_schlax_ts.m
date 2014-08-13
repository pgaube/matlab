% clear all
% jdays=2452641:7:2453005
% 
% [ts_taux,ts_tauy,ts_crl]=deal(nan(53,1));
% load ULTI_mat2/QSCAT_30_25km_2452466 lat lon
% [r,c]=imap(20.1,20.2,180.1,180.2,lat,lon);
% 
% 
% for m=1:length(jdays)
%     load(['new_mat/QSCAT_30_25km_',num2str(jdays(m))],'crlstr_week')
%     ts_crl(m)=1e8*crlstr_week(r,c);
%     clear crlstr_week
% end

figure(2)
clf
plot(linspace(1,365,53),ts_crl,'linewidth',1)
set(gca,'xtick',[0:40:360])
line([1 365],[0 0],'color','k')
axis([1 365 -100 50])
daspect([180 320 1])
% print -dpng -r300 test