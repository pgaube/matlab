clear all

curs = {'LW','EAC','AGU','BMC','GS','OPAC','HAW'};
%

startjd=2451556;
endjd=2454461;
%cd /Volumes/matlab/matlab/hovmuller
load /matlab/data/eddy/V4/global_tracks_V4_12_weeks id x y track_jday
f1=find(track_jday>=startjd & track_jday<=endjd);
id=id(f1);
x=x(f1);
y=y(f1);

for pz=7%1:length(curs)
%load(['cor_mean_cores_amp_' curs{pz}],'ac_uid','cc_uid')
load(['/matlab/matlab/hovmuller/tracks/' curs{pz} '_cor_masked_orgin_tracks'])
figure(2)
clf
pmap(min(x)-10:max(x)+10,min(y)-3:max(y)+3,[x y id],'tracks')
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

[s_cc_id,i_s_cc_id]=sort(cc_id);
s_cc_wek=cc_wek(i_s_cc_id);
s_cc_mu=cc_mu(i_s_cc_id);
s_cc_chl=cc_chl(i_s_cc_id);
s_cc_raw=cc_raw(i_s_cc_id);
s_cc_amp=cc_amp(i_s_cc_id);

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


for m=1:length(ac_uid)
	ii=find(s_ac_id==ac_uid(m));
	%[Cor,Covar,N,Sig,Xbar,Ybar,sdX,sdY]
	[ac_r(m,:),ac_c(m,:),ac_n(m,:),ac_sig(m,:),ac_mux(m,:),ac_muy(m,:),ac_sdx(m,:),ac_sdy(m,:)]=...
	pcor(s_ac_chl(ii),s_ac_chl(ii),lags);
end

for m=1:length(cc_uid)
	ii=find(s_cc_id==cc_uid(m));
	%[Cor,Covar,N,Sig,Xbar,Ybar,sdX,sdY]
	[cc_r(m,:),cc_c(m,:),cc_n(m,:),cc_sig(m,:),cc_mux(m,:),cc_muy(m,:),cc_sdx(m,:),cc_sdy(m,:)]=...
	pcor(s_cc_chl(ii),s_cc_chl(ii),lags);
end


ac_r_bar=(1./nansum(ac_n,1)).*nansum(ac_n.*ac_r,1);
ac_sig_bar=(1./nansum(ac_n,1)).*nansum(ac_n.*ac_sig,1);
%r_mbar=nanmedian(r,1);
ac_r_bar(6)

cc_r_bar=(1./nansum(cc_n,1)).*nansum(cc_n.*cc_r,1);
cc_sig_bar=(1./nansum(cc_n,1)).*nansum(cc_n.*cc_sig,1);
%r_mbar=nanmedian(r,1);
cc_r_bar(6)


%[bar_est,num_est]=phist(r(:,6),tbins);

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
line([-5 5],[.5 .5],'color','k')
set(gca,'xtick',[-5:5])
plot(lags,ac_r_bar,'r*')
plot(lags,cc_r_bar,'*')
axis([-5 5 0 1])
text(-4.3,.85,['j = ',num2str(length(ac_r(:,1)))],'color','r')
text(-4.3,.75,['j = ',num2str(length(cc_r(:,1)))],'color','b')

title({'Mean auto correlation of CHL Anomaly'})
xlabel('lag (weeks) ')
eval(['print -dpng figs/autocor_' curs{pz} '_chl'])
eval(['save autocor_mean_cores_chl_' curs{pz} ' ac* cc*'])
end


return

figure(2)
clf
bar(tbins(1:end-1),num_est./max(num_est))
title('Histogram of correlation at lag=0  ')
ylabel('relative freq')
xlabel('r')