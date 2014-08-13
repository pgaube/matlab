%close all
%clear all
%load /Volumes/matlab/matlab/leeuwin/leeuwin_orgin_select_16_80_weeks.mat
c=73;


% Subset samples based off of eddy file

% make indices
ai=find(sel_ids>=nneg);
ci=find(sel_ids<nneg);


uid = unique(sel_ids);
icu = find(uid<nneg);
iau = find(uid>=nneg);



% average the spatial chl of each eddy
anom_bar = nan(length(sel_anom(1,1,:)),1);
N  = nan(length(sel_anom(1,1,:)),1);

for m=1:length(sel_anom(1,1,:))
	tmp = sel_anom(c-20:c+20,c-20:c+20,m);
	anom_bar(m) = pmean(tmp(:));
	N(m) = length(find(~isnan(tmp)));
	
end	



% Normalize each eddy by the mean achl in the first five time steps
% and redefine age
sel_stage=nan.*sel_k;
nanom_bar=nan.*anom_bar;

for m=1:length(uid)
	ii = find(sel_ids==uid(m));
	sel_stage(ii) = sel_k(ii)./sel_k(ii(length(ii)));	
        qq=find(sel_k(ii)==1);
	if any(qq)
		tmp = anom_bar(ii(qq));
		nanom_bar(ii) = anom_bar(ii)./pmean(tmp(:));
	else
		anom_bar(ii)=nan;
	end
end	



dt=.05;
tdt=.25;
tbins=0:dt:1+dt;

bar_nchla=nan(size(tbins));
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
    	ci_nchla(:,i)  = confint(nanom_bar(ai(bin_est)))';
    	std_nchla(i) = pstd(nanom_bar(ai(bin_est)));
    	bar_achla(i) = (1./nansum(N(ai(bin_est))))*nansum(anom_bar(ai(bin_est)).*N(ai(bin_est)));
    	ci_achla(:,i)  = confint(anom_bar(ai(bin_est)))';
    	std_achla(i) = pstd(anom_bar(ai(bin_est)));
    	    	
    	bin_est = find(sel_stage(ci)>=tbins(i) & sel_stage(ci)<tbins(i+1));
        bar_nchlc(i) = (1./nansum(N(ci(bin_est))))*nansum(nanom_bar(ci(bin_est)).*N(ci(bin_est)));
    	ci_nchlc(:,i)  = confint(nanom_bar(ci(bin_est)))';
    	std_nchlc(i) = pstd(nanom_bar(ci(bin_est)));
    	bar_achlc(i) = (1./nansum(N(ci(bin_est))))*nansum(anom_bar(ci(bin_est)).*N(ci(bin_est)));
    	ci_achlc(:,i)  = confint(anom_bar(ci(bin_est)))';
    	std_achlc(i) = pstd(anom_bar(ci(bin_est)));
  end 	


figure(2)
clf
plot(tbins,smooth1d_loess(bar_nchla,1:length(tbins),4,1:length(tbins)),'r','linewidth',2);
hold on
scatter(tbins,bar_nchla,'.r')
scatter(tbins,bar_nchlc,'.b')
%plot(bar_nchla+ci_nchla(1,:),'r--')
%plot(bar_nchla+ci_nchla(2,:),'r--')
%plot(bar_nchlc+ci_nchlc(1,:),'b--')
%plot(bar_nchlc+ci_nchlc(2,:),'b--')
line([0 length(tbins)],[1 1],'color','k')
plot(tbins,smooth1d_loess(bar_nchlc,1:length(tbins),4,1:length(tbins)),'b','linewidth',2);
axis([0 1 -2 4])
%axis([1 length(tbins) min(cat(2,[bar_nchla-std_nchla],[bar_nchlc-std_nchlc])) ...
%	max(cat(2,[bar_nchla+std_nchla],[bar_nchlc+std_nchlc]))])
title({'Mean Normalized CHL Anomaly as a Function of Duration','Liftimes \geq 16 and \leq 80 weeks'})
xlabel('eddy life stage')
ylabel('mean CHL anomaly normalized to the first observation')
text(16,4,[num2str(length(iau)),' Anticyclones'],'color','r')
text(16,3.6,['N = ' num2str(length(ai))],'color','r')
text(16,3,[num2str(length(icu)),' Cyclones'],'color','b')
text(16,2.6,['N = ' num2str(length(ci))],'color','b')	
				
print -dpng ~/Documents/OSU/figures/leeuwin/chl_trans/orgin_16_80_weeks/mean_norm_anom_life_stage.png


figure(1)
clf
plot(tbins,smooth1d_loess(bar_achla,1:length(tbins),4,1:length(tbins)),'r','linewidth',2);
hold on
scatter(tbins,bar_achla,'.r')
scatter(tbins,bar_achlc,'.b')
line([0 1],[0 0],'color','k')
plot(tbins,smooth1d_loess(bar_achlc,1:length(tbins),4,1:length(tbins)),'b','linewidth',2);
axis([0 1 -.1 .1])
title({'Mean CHL Anomaly as a Function of Duration','Liftimes \geq 16 and \leq 80 weeks'})
xlabel('eddy life stage')
ylabel('mean CHL anomaly [mg/m^3]')
text(length(tbins)-(.35*length(tbins)),max(cat(2,[bar_achla+std_achla],[bar_achlc+std_achlc])) ...
		-(.1*max(cat(2,[bar_achla+std_achla],[bar_achlc+std_achlc]))), ...
		[num2str(length(iau)),' Anticyclones'],'color','r')
text(length(tbins)-(.35*length(tbins)),max(cat(2,[bar_achla+std_achla],[bar_achlc+std_achlc])) ...
		-(.18*max(cat(2,[bar_achla+std_achla],[bar_achlc+std_achlc]))), ...
		['N = ' num2str(length(ai))],'color','r')
		
text(length(tbins)-(.35*length(tbins)),max(cat(2,[bar_achla+std_achla],[bar_achlc+std_achlc])) ...
		-(.3*max(cat(2,[bar_achla+std_achla],[bar_achlc+std_achlc]))), ...
		[num2str(length(icu)),' Cyclones'],'color','b')
text(length(tbins)-(.35*length(tbins)),max(cat(2,[bar_achla+std_achla],[bar_achlc+std_achlc])) ...
		-(.38*max(cat(2,[bar_achla+std_achla],[bar_achlc+std_achlc]))), ...
		['N = ' num2str(length(ci))],'color','b')		
print -dpng ~/Documents/OSU/figures/leeuwin/chl_trans/orgin_16_80_weeks/mean_anom_life_stage.png

return

figure(3)
clf
plot(num_nchlc)
hold on
plot(num_nchla,'r')
set(gca,'xticklabel',{num2str(tbins(1:tdt:length(tbins))')},'xtick',[1:tdt:length(tbins)])
 

		
return
figure(2)
clf
plot(bar_nchla,'r','linewidth',2);
hold on
line([0 max(k_index)+1],[0 0],'color','k')
plot(bar_nchlc,'b','linewidth',2);
set(gca,'xticklabel',{num2str(tbins(1:tdt:length(tbins))')},'xtick',[1:tdt:length(tbins)])
axis([1 length(tbins) -10 10])
%axis([1 length(tbins) min(cat(2,[bar_nchla-std_nchla],[bar_nchlc-std_nchlc])) ...
%	max(cat(2,[bar_nchla+std_nchla],[bar_nchlc+std_nchlc]))])
title({'Anticyclones','Mean Normalized CHL Anomaly as a Function of Duration','Liftimes \geq 16 and \leq 80 weeks'})
xlabel('Duration (Weeks)')
ylabel('Mean CHL Anomaly [mg/m^3]')
text(length(tbins)-(.35*length(tbins)),max(cat(2,[bar_nchla+std_nchla],[bar_nchlc+std_nchlc])) ...
		-(.1*max(cat(2,[bar_nchla+std_nchla],[bar_nchlc+std_nchlc]))), ...
		[num2str(length(sam_unique_anti_id)),' Anticyclones'],'color','r')
text(length(tbins)-(.35*length(tbins)),max(cat(2,[bar_nchla+std_nchla],[bar_nchlc+std_nchlc])) ...
		-(.18*max(cat(2,[bar_nchla+std_nchla],[bar_nchlc+std_nchlc]))), ...
		['N = ' num2str(length(id_index(ai)))],'color','r')
		
text(length(tbins)-(.35*length(tbins)),max(cat(2,[bar_nchla+std_nchla],[bar_nchlc+std_nchlc])) ...
		-(.3*max(cat(2,[bar_nchla+std_nchla],[bar_nchlc+std_nchlc]))), ...
		[num2str(length(sam_unique_cycl_id)),' Cyclones'],'color','b')
text(length(tbins)-(.35*length(tbins)),max(cat(2,[bar_nchla+std_nchla],[bar_nchlc+std_nchlc])) ...
		-(.38*max(cat(2,[bar_nchla+std_nchla],[bar_nchlc+std_nchlc]))), ...
		['N = ' num2str(length(id_index(ci)))],'color','b')		
		
		
		
		
return
figure(1)
clf
plot(bar_achla,'r','linewidth',2);
hold on
line([0 max(k_index)+1],[0 0],'color','k')
plot(bar_achla+std_achla,'r--')
plot(bar_achla-std_achla,'r--')
set(gca,'xticklabel',{num2str(tbins(1:tdt:length(tbins))')},'xtick',[1:tdt:length(tbins)])
axis([1 length(tbins) min(cat(2,[bar_achla-std_achla],[bar_achlc-std_achlc])) ...
	max(cat(2,[bar_achla+std_achla],[bar_achlc+std_achlc]))])
title({'Anticyclones','Mean CHL Anomaly as a Function of Duration','Liftimes \geq 16 and \leq 80 weeks'})
xlabel('Duration (Weeks)')
ylabel('Mean CHL Anomaly [mg/m^3]')
text(length(tbins)-(.35*length(tbins)),max(cat(2,[bar_achla+std_achla],[bar_achlc+std_achlc])) ...
		-(.1*max(cat(2,[bar_achla+std_achla],[bar_achlc+std_achlc]))), ...
		[num2str(length(sam_unique_anti_id)),' Anticyclones'],'color','r')
text(length(tbins)-(.35*length(tbins)),max(cat(2,[bar_achla+std_achla],[bar_achlc+std_achlc])) ...
		-(.18*max(cat(2,[bar_achla+std_achla],[bar_achlc+std_achlc]))), ...
		['N = ' num2str(length(id_index(ai)))],'color','r')
		

figure(2)
clf
plot(bar_achlc,'linewidth',2);
hold on
line([0 max(k_index)+1],[0 0],'color','k')
plot(bar_achlc+std_achlc,'--')
plot(bar_achlc-std_achlc,'--')
set(gca,'xticklabel',{num2str(tbins(1:tdt:length(tbins))')},'xtick',[1:tdt:length(tbins)])
axis([1 length(tbins) min(cat(2,[bar_achla-std_achla],[bar_achlc-std_achlc])) ...
	max(cat(2,[bar_achla+std_achla],[bar_achlc+std_achlc]))])
title({'Cyclones','Mean CHL Anomaly as a Function of Duration','Liftimes \geq 16 and \leq 80 weeks'})
xlabel('Duration (Weeks)')
ylabel('Mean CHL Anomaly [mg/m^3]')
text(length(tbins)-(.35*length(tbins)),max(cat(2,[bar_achla+std_achla],[bar_achlc+std_achlc])) ...
		-(.1*max(cat(2,[bar_achla+std_achla],[bar_achlc+std_achlc]))), ...
		[num2str(length(sam_unique_cycl_id)),' Cyclones'],'color','b')
text(length(tbins)-(.35*length(tbins)),max(cat(2,[bar_achla+std_achla],[bar_achlc+std_achlc])) ...
		-(.18*max(cat(2,[bar_achla+std_achla],[bar_achlc+std_achlc]))), ...
		['N = ' num2str(length(id_index(ci)))],'color','b')		



figure(3)
clf
plot(bar_chla,'r','linewidth',2);
hold on
plot(bar_chla+std_chla,'r--')
plot(bar_chla-std_chla,'r--')
set(gca,'xticklabel',{num2str(tbins(1:tdt:length(tbins))')},'xtick',[1:tdt:length(tbins)])
axis([1 length(tbins) min(cat(2,[bar_chla-std_chla],[bar_chlc-std_chlc])) ...
	max(cat(2,[bar_chla+std_chla],[bar_chlc+std_chlc]))])
title({'Anticyclones','Mean CHL as a Function of Duration','Liftimes \geq 16 and \leq 80 weeks'})
xlabel('Duration (Weeks)')
ylabel('Mean CHL Anomaly [mg/m^3]')
text(length(tbins)-(.35*length(tbins)),max(cat(2,[bar_chla+std_chla],[bar_chlc+std_chlc])) ...
		-(.07*max(cat(2,[bar_chla+std_chla],[bar_chlc+std_chlc]))), ...
		[num2str(length(sam_unique_anti_id)),' Antiyclones'],'color','r')
text(length(tbins)-(.35*length(tbins)),max(cat(2,[bar_chla+std_chla],[bar_chlc+std_chlc])) ...
		-(.11*max(cat(2,[bar_chla+std_chla],[bar_chlc+std_chlc]))), ...
		['N = ' num2str(length(id_index(ai)))],'color','r')			


figure(4)
clf
plot(bar_chlc,'linewidth',2);
hold on
%line([0 max(k_index)+1],[1 1],'color','k')
plot(bar_chlc+std_chlc,'--')
plot(bar_chlc-std_chlc,'--')
set(gca,'xticklabel',{num2str(tbins(1:tdt:length(tbins))')},'xtick',[1:tdt:length(tbins)])
axis([1 length(tbins) min(cat(2,[bar_chla-std_chla],[bar_chlc-std_chlc])) ...
	max(cat(2,[bar_chla+std_chla],[bar_chlc+std_chlc]))])
title({'Cyclones','Mean CHL as a Function of Duration','Liftimes \geq 16 and \leq 80 weeks'})
xlabel('Duration (Weeks)')
ylabel('Mean CHL Anomaly [mg/m^3]')
text(length(tbins)-(.35*length(tbins)),max(cat(2,[bar_chla+std_chla],[bar_chlc+std_chlc])) ...
		-(.07*max(cat(2,[bar_chla+std_chla],[bar_chlc+std_chlc]))), ...
		[num2str(length(sam_unique_cycl_id)),' Cyclones'],'color','b')
text(length(tbins)-(.35*length(tbins)),max(cat(2,[bar_chla+std_chla],[bar_chlc+std_chlc])) ...
		-(.11*max(cat(2,[bar_chla+std_chla],[bar_chlc+std_chlc]))), ...
		['N = ' num2str(length(id_index(ci)))],'color','b')			
