clear all
% load zissou.pal
% load GS_core_eddies_run14_sla
load /Users/new_gaube/matlab/pop/mat/pop_model_domain.mat lat lon z
z=z(1:20);
% 
% 
% 
% [pd]=deal(nan(20,length(stream_eddies.id)));
% 
% for m=1:length(stream_eddies.id)
%         load(['~/matlab/pop/mat/run14_',num2str(stream_eddies.track_jday(m))],'pdens_anom')
%         
%         [r,c]=imap(stream_eddies.y(m)-.1,stream_eddies.y(m)+.1,stream_eddies.x(m)-.1,stream_eddies.x(m)+.1,lat,lon);
% 
%         pd(:,m)=double(squeeze(pdens_anom(r(1),c(1),:)));
% end
% 
% save cor_eddies_pd_amp pd stream_eddies
% 
% 
% load GS_core_meanders_run14_sla
% 
% 
% [pd]=deal(nan(20,length(stream_eddies.id)));
% 
% for m=1:length(stream_eddies.id)
%         load(['~/matlab/pop/mat/run14_',num2str(stream_eddies.track_jday(m))],'pdens_anom')
%         
%         [r,c]=imap(stream_eddies.y(m)-.1,stream_eddies.y(m)+.1,stream_eddies.x(m)-.1,stream_eddies.x(m)+.1,lat,lon);
% 
%         pd(:,m)=double(squeeze(pdens_anom(r(1),c(1),:)));
% end
% 
% save cor_meander_pd_amp pd stream_eddies

load cor_eddies_pd_amp

for m=1:20
    ii=find(stream_eddies.cyc==1);
    [era(m),d,d,Sig]=pcor(stream_eddies.amp(ii),pd(m,ii));
    ii=find(stream_eddies.cyc==-1);
    [erc(m),d,d,Sig]=pcor(stream_eddies.amp(ii),pd(m,ii));
end

load cor_meander_pd_amp

for m=1:20
    ii=find(stream_eddies.cyc==1);
    [mra(m),d,d,Sig]=pcor(stream_eddies.amp(ii),pd(m,ii));
    ii=find(stream_eddies.cyc==-1);
    [mrc(m),d,d,Sig]=pcor(stream_eddies.amp(ii),pd(m,ii));
end


!toast figs/cor_adens_amp.png
figure(1)
set(gcf,'PaperPosition',[1 1 4 6])
plot(Sig*ones(size(z)),z,'k--')
hold on
plot(-Sig*ones(size(z)),z,'k--')

plot(era,z,'r','linewidth',1)
plot(erc,z,'b','linewidth',1)
plot(mra,z,'r--','linewidth',1)
plot(mrc,z,'b--','linewidth',1)

axis ij
axis([-1 1 0 500])
line([0 0],[0 500],'color','k')
set(gca,'xtick',[-1:.5:1],'LineWidth',1,'TickLength',[.01 .02],'layer','top')
title({'Correlation between adens','and eddy amplitude'})
ylabel('depth (m)')
print -dpng -r300 figs/cor_adens_amp
% !open figs/cor_adens_amp.png
