chl=[0.01:.05:1]';

lambda 	= [443 490 550 555];
kw 		= [.00990 .01660 .05746 .06053];
chi		= [.10560 .07242 .04111 .03996];
e		= [.67443 .68955 .64927 .64204];

kb = chl*(chi.*e);

k = ones(length(chl),1)*kw+kb;

ze = 38*chl.^-0.428;

figure(1)
clf
hold on
plot(chl,1./k(:,1),chl,1./k(:,2),chl,1./k(:,3),chl,1./k(:,4))
plot(chl,ze,'k--')
legend(num2str(lambda(1)),num2str(lambda(2)),num2str(lambda(3)),num2str(lambda(4)),'Z_e for Morel 1988','location','best')
title('1/K_d(\lambda) as a function of [chl]')
xlabel('[chl] mg m^{-3}')
ylabel('1/K_d(\lambda) m')
axis([0 1 0 200])

figure(2)
clf
semilogx(chl,1./k(:,1),chl,1./k(:,2),chl,1./k(:,3),chl,1./k(:,4),chl,ze)
legend(num2str(lambda(1)),num2str(lambda(2)),num2str(lambda(3)),num2str(lambda(4)),'Z_e for Morel 1988','location','best')
title('1/K_d(\lambda) as a function of log_{10}[chl]')
xlabel('log_{10}[chl] mg m^{-3}')
ylabel('1/K_d(\lambda) m')
