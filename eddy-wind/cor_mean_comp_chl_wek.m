clear all

curs = {'LW','EAC','AGU','BMC','GS','OPAC','HAW'};


startjd=2451556;
endjd=2454461;
%cd /matlab/matlab/hovmuller
load /matlab/data/eddy/V4/global_tracks_V4_12_weeks id x y track_jday
f1=find(track_jday>=startjd & track_jday<=endjd);
id=id(f1);
x=x(f1);
y=y(f1);
%{
for pz=3%1:length(curs)
%load(['cor_mean_cores_amp_' curs{pz}],'ac_uid','cc_uid')
load(['/matlab/matlab/hovmuller/tracks/' curs{pz} '_cor_masked_orgin_tracks'])
figure(2)
clf
pmap(min(x)-10:max(x)+10,min(y)-3:max(y)+3,[x y id],'tracks_dots')
eval(['print -dpng figs/tracks_cor_' curs{pz} '_amp_chl'])

%cor_ids=cat(1,ac_uid,cc_uid);
%f2=sames(cor_ids,id);
%pmap(min(x(f2))-10:max(x(f2))+10,min(y(f2))-3:max(y(f2))+3,[x(f2) y(f2) id(f2)],'tracks')
%eval(['print -dpng figs/tracks_cor_' curs{pz} '_amp_chl'])

end

return 
%}

for pz=1:length(curs)
eval(['load ' curs{pz} '_time_chl_wek'])
lags=[-5:5];
tbins=[-.5:.1:.5];

[s_ac_id,i_s_ac_id]=sort(ac_id);
s_ac_wek=ac_wek(i_s_ac_id);
s_ac_mu=ac_mu(i_s_ac_id);
s_ac_chl=ac_chl(i_s_ac_id);
s_ac_raw=ac_raw(i_s_ac_id);
s_ac_amp=ac_amp(i_s_ac_id);
s_ac_var=ac_var(i_s_ac_id);
s_ac_prct=ac_prct(i_s_ac_id,:);

ac_uid=unique(s_ac_id);
ac_uid(isnan(ac_uid))=[];
ac_r=nan(length(ac_uid),length(lags));
ac_n=ac_r;
ac_mux=ac_r;
ac_muy=ac_r;
ac_sdx=ac_r;
ac_sdy=ac_r;
ac_c=ac_r;
ac_sig=ac_r;
ac_range=nan(length(ac_uid),1);
ac_var=nan(length(ac_uid),1);


[s_cc_id,i_s_cc_id]=sort(cc_id);
s_cc_wek=cc_wek(i_s_cc_id);
s_cc_mu=cc_mu(i_s_cc_id);
s_cc_chl=cc_chl(i_s_cc_id);
s_cc_raw=cc_raw(i_s_cc_id);
s_cc_amp=cc_amp(i_s_cc_id);
s_cc_var=cc_var(i_s_cc_id);
s_cc_prct=cc_prct(i_s_cc_id,:);

cc_uid=unique(s_cc_id);
cc_uid(isnan(cc_uid))=[];
cc_r=nan(length(cc_uid),length(lags));
cc_n=cc_r;
cc_mux=cc_r;
cc_muy=cc_r;
cc_sdx=cc_r;
cc_sdy=cc_r;
cc_c=cc_r;
cc_sig=cc_r;
cc_range=nan(length(cc_uid),1);
cc_var=nan(length(cc_uid),1);


for m=1:length(ac_uid)
	ii=find(s_ac_id==ac_uid(m));
	%[Cor,Covar,N,Sig,Xbar,Ybar,sdX,sdY]
	[ac_r(m,:),ac_c(m,:),ac_n(m,:),ac_sig(m,:),ac_mux(m,:),ac_muy(m,:),ac_sdx(m,:),ac_sdy(m,:)]=...
	pcor(s_ac_amp(ii),s_ac_chl(ii),lags);
	ac_range(m)=abs(pmean(s_ac_prct(ii,1)-s_ac_prct(ii,2)));
	ac_var(m)=pmean(s_ac_var(ii));
end

for m=1:length(cc_uid)
	ii=find(s_cc_id==cc_uid(m));
	%[Cor,Covar,N,Sig,Xbar,Ybar,sdX,sdY]
	[cc_r(m,:),cc_c(m,:),cc_n(m,:),cc_sig(m,:),cc_mux(m,:),cc_muy(m,:),cc_sdx(m,:),cc_sdy(m,:)]=...
	pcor(s_cc_amp(ii),s_cc_chl(ii),lags);
	cc_range(m)=abs(pmean(s_cc_prct(ii,1)-s_cc_prct(ii,2)));
	cc_var(m)=pmean(s_cc_var(ii));
end


%Use when correlating AMPS
%{
ii=find(ac_r(:,6)>=-ac_sig(:,6)); %remove these
all_ac_r=ac_r;
all_ac_muy=ac_muy;
ac_muy(ii,:)=[];
ac_r(ii,:)=[];
ac_n(ii,:)=[];
ac_sig(ii,:)=[];
ac_uid(ii)=[];
all_ac_range=ac_range;
ac_range(ii)=[];
all_ac_var=ac_var;
ac_var(ii)=[];


ii=find(ac_n(:,6)<1); %remove these
ac_r(ii,:)=[];
ac_muy(ii,:)=[];
ac_n(ii,:)=[];
ac_sig(ii,:)=[];
ac_uid(ii)=[];
ac_range(ii)=[];
ac_var(ii)=[];


ii=find(cc_r(:,6)<=cc_sig(:,6)); %remove these
all_cc_r=cc_r;
all_cc_muy=cc_muy;
cc_muy(ii,:)=[];
cc_r(ii,:)=[];
cc_n(ii,:)=[];
cc_sig(ii,:)=[];
cc_uid(ii)=[];
all_cc_range=cc_range;
cc_range(ii)=[];
all_cc_var=cc_var;
cc_var(ii)=[];


ii=find(cc_n(:,6)<1); %remove these
cc_muy(ii,:)=[];
cc_r(ii,:)=[];
cc_n(ii,:)=[];
cc_sig(ii,:)=[];
cc_uid(ii)=[];
cc_range(ii)=[];
cc_var(ii)=[];
%}


%Use when correalting WEK
%
ii=find(ac_r(:,6)<=ac_sig(:,6)); %remove these
all_ac_r=ac_r;
all_ac_muy=ac_muy;
ac_muy(ii,:)=[];
ac_r(ii,:)=[];
ac_n(ii,:)=[];
ac_sig(ii,:)=[];
ac_uid(ii)=[];
all_ac_range=ac_range;
ac_range(ii)=[];
all_ac_var=ac_var;
ac_var(ii)=[];


ii=find(ac_n(:,6)<1); %remove these
ac_r(ii,:)=[];
ac_muy(ii,:)=[];
ac_n(ii,:)=[];
ac_sig(ii,:)=[];
ac_uid(ii)=[];
ac_range(ii)=[];
ac_var(ii)=[];

ii=find(cc_r(:,6)<=cc_sig(:,6)); %remove these
all_cc_r=cc_r;
all_cc_muy=cc_muy;
cc_muy(ii,:)=[];
cc_r(ii,:)=[];
cc_n(ii,:)=[];
cc_sig(ii,:)=[];
cc_uid(ii)=[];
all_cc_range=cc_range;
cc_range(ii)=[];
all_cc_var=cc_var;
cc_var(ii)=[];


ii=find(cc_n(:,6)<1); %remove these
cc_muy(ii,:)=[];
cc_r(ii,:)=[];
cc_n(ii,:)=[];
cc_sig(ii,:)=[];
cc_uid(ii)=[];
cc_range(ii)=[];
cc_var(ii)=[];
%


ac_r_bar=(1./nansum(ac_n,1)).*nansum(ac_n.*ac_r,1);
ac_sig_bar=(1./nansum(ac_n,1)).*nansum(ac_n.*ac_sig,1);
%r_mbar=nanmedian(r,1);
ac_r_bar(6)

cc_r_bar=(1./nansum(cc_n,1)).*nansum(cc_n.*cc_r,1);
cc_sig_bar=(1./nansum(cc_n,1)).*nansum(cc_n.*cc_sig,1);
%r_mbar=nanmedian(r,1);
cc_r_bar(6)


%[bar_est,num_est]=phist(r(:,6),tbins);


%{
figure(36)
clf
plot(lags,ac_r_bar,'r')
hold on
plot(lags,cc_r_bar)
%plot(lags,ac_sig_bar,'r--')
%plot(lags,cc_sig_bar,'--')
%legend('r Anticyclones','r Cyclones','Sig Anticyclones','Sig Cyclones')
legend('r Anticyclones','r Cyclones')
%plot(lags,r_mbar,'o')
line([0 0],[-1 1],'color','k')
line([-5 5],[0 0],'color','k')
set(gca,'xtick',[-5:5])
plot(lags,ac_r_bar,'r*')
plot(lags,cc_r_bar,'*')
axis([-5 5 -.6 .9])
text(-4.3,.85,['j = ',num2str(length(ac_r(:,1)))],'color','r')
text(-4.3,.75,['j = ',num2str(length(cc_r(:,1)))],'color','b')

title({'Mean correlation between Ekman Pumping and CHL Anomaly'})
xlabel('lag (weeks) ')
eval(['print -dpng figs/cor_' curs{pz} '_wek_chl'])
%}


figure(37)
clf
scatter(all_ac_r(:,6),all_ac_range,'r.')
hold on
scatter(all_cc_r(:,6),all_cc_range,'b.')
scatter(ac_r(:,6),ac_range,'r*')
scatter(cc_r(:,6),cc_range,'b*')
line([0 0],[-1 1],'color','k')
line([-5 5],[0 0],'color','k')
set(gca,'xtick',[-5:5])
axis([-2 2 0 .5])
xlabel('correlation ')
ylabel('dynamic range of chl  ')
title({'Scatter of dynamic range of selected eddies'})
text(1,.45,curs{pz})
eval(['print -dpng figs/cor_' curs{pz} '_amp_chl'])


figure(20)
clf
scatter(all_ac_r(:,6),all_ac_muy(:,6),'r.')
hold on
scatter(all_cc_r(:,6),all_cc_muy(:,6),'b.')
scatter(ac_r(:,6),ac_muy(:,6),'r*')
scatter(cc_r(:,6),cc_muy(:,6),'b*')
line([0 0],[-1 1],'color','k')
line([-5 5],[0 0],'color','k')
set(gca,'xtick',[-5:5])
axis([-2 2 -.2 .2])
xlabel('correlation ')
ylabel('mean chl over whole life  ')
title({'Scatter of mean chl within eddy core'})
text(1,.15,curs{pz})
eval(['print -dpng figs/scatt_sel_wek_' curs{pz} '_cor_chl'])
%eval(['save cor_mean_cores_wek_' curs{pz} ' ac* cc*'])
end


return

figure(2)
clf
bar(tbins(1:end-1),num_est./max(num_est))
title('Histogram of correlation at lag=0  ')
ylabel('relative freq')
xlabel('r')