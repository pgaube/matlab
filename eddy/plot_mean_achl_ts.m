



close all
clear all
load /Volumes/matlab/matlab/leeuwin/leeuwin_orgin_select_16_weeks.mat
c=73;
%}

% Subset samples based off of eddy file

% make indices
ai=find(sel_ids>=nneg);
ci=find(sel_ids<nneg);


uid = unique(sel_ids);
icu = find(uid<nneg);
iau = find(uid>=nneg);



% average the spatil chl of each eddy
anom_bar = nan(length(sel_anom(1,1,:)),1);
chl_bar=anom_bar;
ss_bar=anom_bar;
N  = nan(length(sel_anom(1,1,:)),1);
Nss  = nan(length(sel_anom(1,1,:)),1);
for m=1:length(sel_anom(1,1,:))
	tmp = sel_anom(c-20:c+20,c-20:c+20,m);
	anom_bar(m) = pmean(tmp(:));
	tmp = sel_chl(c-20:c+20,c-20:c+20,m);
	chl_bar(m) = pmean(tmp(:));
	N(m) = length(find(~isnan(tmp)));
	tmp = sel_ss(c-20:c+20,c-20:c+20,m);
	ss_bar(m) = pmean(tmp(:));
	Nss(m) = length(find(~isnan(tmp)));
end	


% Normalize each eddy by the mean achl in the first five time steps
nanom_bar=nan.*anom_bar;
nchl_bar=nanom_bar;
nss_bar=nanom_bar;

for m=1:length(uid)
	ii = find(sel_ids==uid(m));
	sel_stage(ii) = sel_k(ii)./sel_k(ii(length(ii)));
	%qq=find(sel_k(ii)==1);
	qq=find(sel_k(ii)>=1 & sel_k(ii)<=2);
	if any(qq)
		tmp = anom_bar(ii(qq));
		atmp = pmean(sel_amp(ii(qq)));
		nanom_bar(ii) = anom_bar(ii)./pmean(tmp(:));
		sel_namp(ii)  = sel_amp(ii)./atmp;
		tmp = chl_bar(ii(qq));
		nchl_bar(ii) = chl_bar(ii)./pmean(tmp(:));
		tmp = ss_bar(ii(qq));
		nss_bar(ii) = ss_bar(ii)./pmean(tmp(:));
	else
		nanom_bar(ii)=nan;
		nchl_bar(ii)=nan;
		nss_bar(ii)=nan;
	end
end	



dt=2;
tdt=5;
tbins=1:dt:max(sel_k)+1;

bar_nchla=nan(size(tbins));
bar_chla=nan(size(tbins));
bar_chlc=nan(size(tbins));
bar_nampa=nan(size(tbins));
bar_nampc=nan(size(tbins));
bar_nchlc=nan(size(tbins));
bar_ssa=nan(size(tbins));
bar_ssc=nan(size(tbins));
bar_nssa=nan(size(tbins));
bar_nssc=nan(size(tbins));
std_nchla=nan(size(tbins));
std_nchlc=nan(size(tbins));
ci_nchla=nan(2,length(tbins));
ci_nchlc=nan(2,length(tbins));

bar_achla=nan(size(tbins));
bar_achlc=nan(size(tbins));
std_achla=nan(size(tbins));
std_achlc=nan(size(tbins));
ci_achla=nan(2,length(tbins));
ci_achlc=nan(2,length(tbins));

 for i=1:length(tbins)-1
        bin_est = find(sel_k(ai)>=tbins(i) & sel_k(ai)<tbins(i+1));
        bar_ssa(i) = (1./nansum(Nss(ai(bin_est))))*nansum(ss_bar(ai(bin_est)).*Nss(ai(bin_est)));
        bar_nssa(i) = (1./nansum(Nss(ai(bin_est))))*nansum(nss_bar(ai(bin_est)).*Nss(ai(bin_est)));
        bar_nchla(i) = (1./nansum(N(ai(bin_est))))*nansum(nanom_bar(ai(bin_est)).*N(ai(bin_est)));
        bar_chla(i) = (1./nansum(N(ai(bin_est))))*nansum(nchl_bar(ai(bin_est)).*N(ai(bin_est)));
    	ci_nchla(:,i)= confint(nanom_bar(ai(bin_est)))';
    	std_nchla(i) = pstd(nanom_bar(ai(bin_est)));
    	bar_achla(i) = (1./nansum(N(ai(bin_est))))*nansum(anom_bar(ai(bin_est)).*N(ai(bin_est)));
    	ci_achla(:,i)= confint(anom_bar(ai(bin_est)))';
    	std_achla(i) = pstd(anom_bar(ai(bin_est)));
    	bar_nampa(i)  = nanmean(sel_namp(ai(bin_est)));
    	
    	bin_est = find(sel_k(ci)>=tbins(i) & sel_k(ci)<tbins(i+1));
        bar_ssc(i) = (1./nansum(Nss(ci(bin_est))))*nansum(ss_bar(ci(bin_est)).*Nss(ci(bin_est)));
        bar_nssc(i) = (1./nansum(Nss(ci(bin_est))))*nansum(nss_bar(ci(bin_est)).*Nss(ci(bin_est)));
        bar_nchlc(i) = (1./nansum(N(ci(bin_est))))*nansum(nanom_bar(ci(bin_est)).*N(ci(bin_est)));
        bar_chlc(i) = (1./nansum(N(ci(bin_est))))*nansum(nchl_bar(ci(bin_est)).*N(ci(bin_est)));
    	ci_nchlc(:,i)  = confint(nanom_bar(ci(bin_est)))';
    	std_nchlc(i) = pstd(nanom_bar(ci(bin_est)));
    	bar_achlc(i) = (1./nansum(N(ci(bin_est))))*nansum(anom_bar(ci(bin_est)).*N(ci(bin_est)));
    	ci_achlc(:,i)  = confint(anom_bar(ci(bin_est)))';
    	std_achlc(i) = pstd(anom_bar(ci(bin_est)));
    	bar_nampc(i)  = nanmean(sel_namp(ci(bin_est)));
  end 	


figure(5)
clf
plot(tbins,smooth1d_loess(bar_nchla,1:length(tbins),5,1:length(tbins)),'r','linewidth',2);
hold on
plot(tbins,smooth1d_loess(bar_nchlc,1:length(tbins),5,1:length(tbins)),'b','linewidth',2);
plot(tbins,smooth1d_loess(bar_nampa,1:length(tbins),3,1:length(tbins)),'--r')
plot(tbins,smooth1d_loess(bar_nampc,1:length(tbins),3,1:length(tbins)),'--b')
legend('aCHL Anti','aCHL Cycl','Amp Anti','Amp Cycl','fontsize',14)
legend('aCHL Anti','aCHL Cycl','Amp Anti','Amp Cycl','fontsize',14)
scatter(tbins,bar_nchla,'.r')
scatter(tbins,bar_nchlc,'.b')
line([0 length(tbins)],[0 0],'color','k')
axis([0 100 -3 4])
title({'Mean Normalized log_{10}(CHL) Anomaly as a Function of Duration  ','Liftimes \geq 16 Weeks  '},'fontsize',14)
xlabel('eddy age (weeks)  ','fontsize',14)
ylabel('mean log_{10}(CHL) anomaly normalized to the first observation  ','fontsize',14)
%text(75,4,[num2str(length(iau)),' Anticyclones'],'color','r')
%text(75,3.8,['N = ' num2str(length(ai))],'color','r')
%text(75,3,[num2str(length(icu)),' Cyclones'],'color','b')
%text(75,2.8,['N = ' num2str(length(ci))],'color','b')	
set(gca,'linewidth',2)
print -dpng ~/Documents/OSU/figures/leeuwin/chl_trans/orgin_16_80_weeks/mean_norm_anom_k.png

figure(2)
clf
plot(tbins,smooth1d_loess(bar_nssa,1:length(tbins),5,1:length(tbins)),'r','linewidth',2);
hold on
plot(tbins,smooth1d_loess(bar_nssc,1:length(tbins),5,1:length(tbins)),'b','linewidth',2);
legend('CHL SS Anticyclones','CHL SS Cyclones','fontsize',14)
scatter(tbins,bar_nssa,'.r')
scatter(tbins,bar_nssc,'.b')
line([0 length(tbins)],[0 0],'color','k')
axis([0 100 0 1.5])
title({'Mean Normalized log_{10}(CHL) Seasonal Cycle as a Function of Duration  ','Liftimes \geq 16 Weeks  '},'fontsize',14)
xlabel('eddy age (weeks)  ','fontsize',14)
ylabel('mean log_{10}(CHL) seasonal cycle normalized to the first observation  ','fontsize',14)
%text(75,4,[num2str(length(iau)),' Anticyclones'],'color','r')
%text(75,3.8,['N = ' num2str(length(ai))],'color','r')
%text(75,3,[num2str(length(icu)),' Cyclones'],'color','b')
%text(75,2.8,['N = ' num2str(length(ci))],'color','b')	
set(gca,'linewidth',2)
print -dpng ~/Documents/OSU/figures/leeuwin/chl_trans/orgin_16_80_weeks/mean_norm_ss_k.png

figure(4)
clf
plot(tbins,smooth1d_loess(bar_chla,1:length(tbins),5,1:length(tbins)),'r','linewidth',2);
hold on
plot(tbins,smooth1d_loess(bar_chlc,1:length(tbins),5,1:length(tbins)),'b','linewidth',2);
%plot(tbins,smooth1d_loess(bar_nampa,1:length(tbins),3,1:length(tbins)),'--r')
%plot(tbins,smooth1d_loess(bar_nampc,1:length(tbins),3,1:length(tbins)),'--b')
legend('CHL Anticyclones','CHL Cyclones','fontsize',14)
%legend('CHL Anti','CHL Cycl','Amp Anti','Amp Cycl','fontsize',14)
scatter(tbins,bar_chla,'.r')
scatter(tbins,bar_chlc,'.b')
line([0 length(tbins)],[0 0],'color','k')
axis([0 100 0 1.5])
title({'Mean Normalized log_{10}(CHL) as a Function of Duration  ','Liftimes \geq 16 Weeks  '},'fontsize',14)
xlabel('eddy age (weeks)  ','fontsize',14)
ylabel('mean log_{10}(CHL) normalized to the first observation  ','fontsize',14)
%text(75,4,[num2str(length(iau)),' Anticyclones'],'color','r')
%text(75,3.8,['N = ' num2str(length(ai))],'color','r')
%text(75,3,[num2str(length(icu)),' Cyclones'],'color','b')
%text(75,2.8,['N = ' num2str(length(ci))],'color','b')	
set(gca,'linewidth',2)
print -dpng ~/Documents/OSU/figures/leeuwin/chl_trans/orgin_16_80_weeks/mean_norm_chl_k.png

figure(1)
clf
plot(tbins,smooth1d_loess(bar_achla,1:length(tbins),5,1:length(tbins)),'r','linewidth',2);
hold on
plot(tbins,smooth1d_loess(bar_achlc,1:length(tbins),5,1:length(tbins)),'b','linewidth',2);
legend('CHL Anticyclones','CHL Cyclones')
line([0 length(tbins)],[0 0],'color','k')
scatter(tbins,bar_achla,'.r')
scatter(tbins,bar_achlc,'.b')
axis([1 65 -.2 .2])
title({'Mean CHL Anomaly as a Function of Duration  ','Liftimes \geq 16 Weeks  '},'fontsize',14)
xlabel('eddy age (weeks)  ','fontsize',14)
ylabel('mean log_{10}(CHL) anomaly [mg/m^3]  ','fontsize',14)
set(gca,'linewidth',2)
print -dpng ~/Documents/OSU/figures/leeuwin/chl_trans/orgin_16_80_weeks/mean_anom_k.png
a_bar=pmean(bar_achla)
c_bar=pmean(bar_achlc)
[ccor,ccovar,cN,csig]=pcor(bar_nampc,bar_chlc,-20:20)
[acor,acovar,aN,asig]=pcor(bar_nampa,bar_chla,-20:20)

figure(6)
clf
plot([-20:20],acor,'r')
hold on
plot([-20:20],ccor,'b')
scatter([-20:20],acor,'or')
scatter([-20:20],ccor,'ob')
line([-20 20],[0 0],'color','k')
line([0 0],[-1 1],'color','k')
axis([-20 20 .5 1])
title('Correlation Between Normalized CHL and Normalized Amplitude, Binned by Eddy Age  ')
xlabel('time lags (weeks), negative lag amp leads chl  ')
ylabel('corelation coefficient ')
set(gca,'linewidth',2)
print -dpng ~/Documents/OSU/figures/leeuwin/chl_trans/orgin_16_80_weeks/cor_k.png


return



		
		
tbins=0:.02:1+dt;

bar_nchla=nan(size(tbins));
bar_chla=nan(size(tbins));
bar_chlc=nan(size(tbins));
bar_nampa=nan(size(tbins));
bar_nampc=nan(size(tbins));
bar_nchlc=nan(size(tbins));
std_nchla=nan(size(tbins));
std_nchlc=nan(size(tbins));
ci_nchla=nan(2,length(tbins));
ci_nchlc=nan(2,length(tbins));

bar_achla=nan(size(tbins));
bar_achlc=nan(size(tbins));
std_achla=nan(size(tbins));
std_achlc=nan(size(tbins));
ci_achla=nan(2,length(tbins));
ci_achlc=nan(2,length(tbins));


 for i=1:length(tbins)-1
        bin_est = find(sel_stage(ai)>=tbins(i) & sel_stage(ai)<tbins(i+1));
        bar_nchla(i) = (1./nansum(N(ai(bin_est))))*nansum(nanom_bar(ai(bin_est)).*N(ai(bin_est)));
        bar_chla(i) = (1./nansum(N(ai(bin_est))))*nansum(nchl_bar(ai(bin_est)).*N(ai(bin_est)));
    	ci_nchla(:,i)= confint(nanom_bar(ai(bin_est)))';
    	std_nchla(i) = pstd(nanom_bar(ai(bin_est)));
    	bar_achla(i) = (1./nansum(N(ai(bin_est))))*nansum(anom_bar(ai(bin_est)).*N(ai(bin_est)));
    	ci_achla(:,i)= confint(anom_bar(ai(bin_est)))';
    	std_achla(i) = pstd(anom_bar(ai(bin_est)));
    	bar_nampa(i)  = nanmean(sel_namp(ai(bin_est)));
    	
    	bin_est = find(sel_stage(ci)>=tbins(i) & sel_stage(ci)<tbins(i+1));
        bar_nchlc(i) = (1./nansum(N(ci(bin_est))))*nansum(nanom_bar(ci(bin_est)).*N(ci(bin_est)));
        bar_chlc(i) = (1./nansum(N(ci(bin_est))))*nansum(nchl_bar(ci(bin_est)).*N(ci(bin_est)));
    	ci_nchlc(:,i)  = confint(nanom_bar(ci(bin_est)))';
    	std_nchlc(i) = pstd(nanom_bar(ci(bin_est)));
    	bar_achlc(i) = (1./nansum(N(ci(bin_est))))*nansum(anom_bar(ci(bin_est)).*N(ci(bin_est)));
    	ci_achlc(:,i)  = confint(anom_bar(ci(bin_est)))';
    	std_achlc(i) = pstd(anom_bar(ci(bin_est)));
    	bar_nampc(i)  = nanmean(sel_namp(ci(bin_est)));
  end 	

figure(3)
clf
plot(tbins,smooth1d_loess(bar_nchla,1:length(tbins),6,1:length(tbins)),'r','linewidth',2);
hold on
plot(tbins,smooth1d_loess(bar_nchlc,1:length(tbins),6,1:length(tbins)),'b','linewidth',2);
plot(tbins,smooth1d_loess(bar_nampa,1:length(tbins),3,1:length(tbins)),'--r')
plot(tbins,smooth1d_loess(bar_nampc,1:length(tbins),3,1:length(tbins)),'--b')
legend('aCHL Anti','aCHL Cycl','Amp Anti','Amp Cycl','fontsize',14)
scatter(tbins,bar_nchla,'.r')
scatter(tbins,bar_nchlc,'.b')
line([0 length(tbins)],[0 0],'color','k')
axis([0 1 -4 4])
title({'Mean Normalized CHL Anomaly as a Function of Life Stage  ','Liftimes \geq 16 Weeks  '},'fontsize',14)
xlabel('eddy life stage  ','fontsize',14)
ylabel('mean CHL anomaly normalized to the first observation  ','fontsize',14)

print -dpng ~/Documents/OSU/figures/leeuwin/chl_trans/orgin_16_80_weeks/mean_norm_anom_norm_k.png

figure(5)
clf
plot(tbins,smooth1d_loess(bar_chla,1:length(tbins),6,1:length(tbins)),'r','linewidth',2);
hold on
plot(tbins,smooth1d_loess(bar_chlc,1:length(tbins),6,1:length(tbins)),'b','linewidth',2);
plot(tbins,smooth1d_loess(bar_nampa,1:length(tbins),3,1:length(tbins)),'--r')
plot(tbins,smooth1d_loess(bar_nampc,1:length(tbins),3,1:length(tbins)),'--b')
legend('aCHL Anti','aCHL Cycl','Amp Anti','Amp Cycl','fontsize',14)
scatter(tbins,bar_chla,'.r')
scatter(tbins,bar_chlc,'.b')
line([0 length(tbins)],[0 0],'color','k')
axis([0 1 0 3])
title({'Mean Normalized CHL as a Function of Life Stage  ','Liftimes \geq 16 Weeks  '},'fontsize',14)
xlabel('eddy life stage  ','fontsize',14)
ylabel('mean CHL normalized to the first observation  ','fontsize',14)

print -dpng ~/Documents/OSU/figures/leeuwin/chl_trans/orgin_16_80_weeks/mean_norm_chl_norm_k.png

[ccor,ccovar,cN,csig]=pcor(bar_nampc,bar_chlc,-20:20);
[acor,acovar,aN,asig]=pcor(bar_nampa,bar_chla,-20:20)

figure(7)
plot([-20:20],acor,'r')
hold on
plot([-20:20],ccor,'b')
line([-20 20],[0 0],'color','k')
line([0 0],[-1 1],'color','k')
axis([-20 20 -1 1])
title('Correlation Between Normalized CHL and Normalized Amplitude, Binned by Eddy Life Stage  ')
xlabel('time lags (weeks), negative lag amp leads chl  ')
ylabel('corelation coefficient ')
print -dpng ~/Documents/OSU/figures/leeuwin/chl_trans/orgin_16_80_weeks/cor_k.png

