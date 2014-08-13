% % % %as a function of Ua
clear all
D=[250 500 750];
wind_speed=[2:.2:20]; %ms

for m=1:length(D)
    for n=1:length(wind_speed)
        atten(n,m)=D(m)*1020*2/3/1.2/10^-3/wind_speed(n)/60/60/24;
    end
end

figure(2)
clf
set(gcf,'PaperPosition',[1 1 15/4 10/4])
plot(wind_speed,atten(:,1),'k','linewidth',1)
hold on
plot(wind_speed,atten(:,2),'k--','linewidth',1)
plot(wind_speed,atten(:,3),'k','linewidth',2)
axis([2 20 50 1000])
cc=legend('250 m','500 m','750 m','location','northeast')
set(cc,'box','off')
xlabel('Wind speed U_a(m s^{-1})','fontsize',35/4)
ylabel({'T_E (days)'},'fontsize',35/4)
title({'Eddy Attenuation Time Scale T_E'},'fontsize',35/4)
set(gca,'fontsize',25/4,'xtick',[1:2:30],'linewidth',1)
print -dpng -r300 figs/attenuation_time_scale_wspd


% % now as a function of D
clear all
D=[200:10:1000];
wind_speed=[7 14 21]; %ms

for m=1:length(D)
    for n=1:length(wind_speed)
        atten(n,m)=D(m)*1020*2/3/1.2/10^-3/wind_speed(n)/60/60/24;
    end
end

figure(2)
clf
set(gcf,'PaperPosition',[1 1 15/4 10/4])
plot(D',atten(1,:),'k','linewidth',1)
hold on
plot(D',atten(2,:),'k--','linewidth',1)
plot(D',atten(3,:),'k','linewidth',2)
axis([200 1000 0 1000])
cc=legend('7 m s^{-1}','14 m s^{-1}','21 m s^{-1}','location','northwest')
set(cc,'box','off')
xlabel('Vertical eddy scale D (m)','fontsize',35/4)
ylabel({'T_E (days)'},'fontsize',35/4)
title({'Eddy Attenuation Time Scale'},'fontsize',35/4)
set(gca,'fontsize',25/4,'xtick',[200:200:1000],'linewidth',1)
print -dpng -r300 figs/attenuation_time_scale_D



