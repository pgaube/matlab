%Program Franks - Similar to Franks et al. (1986)
clear all
ndays=300; nsteps=ndays*4;
%Set up storage vectors for results
Pct=ones(nsteps*ndays,1); Tct=Pct; Nct=Pct; Zct=Pct; 
%Set values of all parameters for standard run
%Daily rates are reduced for small time steps
Vm=0.62./nsteps; m=0.1/nsteps; Rm=1.5/nsteps; d=0.2/nsteps; Mix=0.02/nsteps;
%Try Vm=0.69; try other changes
Gamma=0.3; Ks=1.; Lmda=1.; NatZ=10.6; 
%Set values of starting conditions
NIT=1.6; P=0.3; Z=0.1;  P0=0.; %P0 initially set to zero; try 1.0
ct=0;
%Main loop starts here, one cycle per model day
for i=1:ndays
  %To add autumn mixing use the following statements; make ndays=200.
  %if i>120  Mix=Mix+0.02/nsteps; end
%Subloop to allow nstep time steps per day
    for j=1:nsteps
        ct=ct+1; Tct(ct)=ct/nsteps; 
        Nct(ct)=NIT; Pct(ct)=P; Zct(ct)=Z;
        UPTAKE=Vm*NIT/(Ks+NIT);
        if P>P0 
           Ivlev=Rm*(1-exp(-Lmda*(P-P0)));
        else Ivlev=0.;
        end      
        delP=UPTAKE*P-m*P-Z*Ivlev;
        delZ=Gamma*Z*Ivlev-d*Z;
        delN=-UPTAKE*P+m*P+(1-Gamma)*Z*Ivlev+d*Z;
       %To mix with deeper water and sink some organic matter use the
       %following delN= statement instead: 
       %delN=-UPTAKE*P+0.6*m*P+0.4*(1-Gamma)*Z*Ivlev+0.4*d*Z+Mix*(NatZ-NIT);
       %Calculate new values of P, Z, NIT:
        P=P+delP; Z=Z+delZ; NIT=NIT+delN;
    end
end
figure(1)
set(gcf,'PaperPosition',[1 1 30 10])
clf

plot(Tct(1:end)./7, Nct(1:end),'k','LineWidth',4); hold on;
plot(Tct(1:end)./7, Pct(1:end),'g','LineWidth',4);
plot(Tct(1:end)./7, Zct(1:end),'r','LineWidth',4);
legend('N','P','Z','location','NorthEastOutside')
xlabel('weeks ','fontsize',40,'fontweight','bold')
ylabel('\mu mol N liter^{-1} ','fontsize',40,'fontweight','bold')
%title({'a) N, P and Z concentration','as a fucntion of time (weeks)'},'fontsize',40,'fontweight','bold')
axis([0 12 0 1.6])
set(gca,'XLim',[1 12])
Pd=interp1(Tct,Pct,1:ndays);
r=pcor(Pd,Pd,[0:100]);
set(gca,'fontsize',40,'fontweight','bold','LineWidth',4,'TickLength',[.01 .05],'layer','top')
%print -dpng -r300 npz_eddy

figure(2)
set(gcf,'PaperPosition',[1 1 20 10])
clf
plot(0:100,r,'LineWidth',4)
hold on
line([30 30],[-1.5 1.5],'color','k','LineWidth',4)
axis([0 45 -1.5 1.5])
set(gca,'xtick',[0:5:45])
%title('b) time lagged auto-correlation (days) of P','fontsize',40,'fontweight','bold')
xlabel('days ','fontsize',40,'fontweight','bold')
set(gca,'fontsize',40,'fontweight','bold','LineWidth',4,'TickLength',[.01 .05],'layer','top')
%print -dpng -r300 npz_eddy_auto