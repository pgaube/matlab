clear all

curs = {'LW','EAC','AGU','BMC','GS','OPAC','HAW'};
lags=[-5:5];


for pz=1:length(curs)
eval(['load ' curs{pz} '_time_chl_wek'])

%sort and make nan arrays for mean eddy values
[s_ac_id,i_s_ac_id]=sort(ac_id);
s_ac_wek=ac_wek(i_s_ac_id);
s_ac_mu=ac_mu(i_s_ac_id);
s_ac_chl=ac_chl(i_s_ac_id);
s_ac_raw=ac_raw(i_s_ac_id);
s_ac_amp=ac_amp(i_s_ac_id);
s_ac_var=ac_var(i_s_ac_id);
s_ac_prct=ac_prct(i_s_ac_id,:);
s_ac_k=ac_k(i_s_ac_id);

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
ac_age=ac_range;


[s_cc_id,i_s_cc_id]=sort(cc_id);
s_cc_wek=cc_wek(i_s_cc_id);
s_cc_mu=cc_mu(i_s_cc_id);
s_cc_chl=cc_chl(i_s_cc_id);
s_cc_raw=cc_raw(i_s_cc_id);
s_cc_amp=cc_amp(i_s_cc_id);
s_cc_var=cc_var(i_s_cc_id);
s_cc_prct=cc_prct(i_s_cc_id,:);
s_cc_k=cc_k(i_s_cc_id);

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
cc_age=cc_range;


for m=1:length(ac_uid)
	ii=find(s_ac_id==ac_uid(m));
	[ac_r(m,:),ac_c(m,:),ac_n(m,:),ac_sig(m,:),ac_mux(m,:),ac_muy(m,:),ac_sdx(m,:),ac_sdy(m,:)]=...
	pcor(s_ac_amp(ii),s_ac_chl(ii),lags);
	ac_mux(m,:)=nanmedian(s_ac_chl(ii));
	ac_muy(m,:)=nanmedian(s_ac_chl(ii));
	ac_range(m)=abs(pmean(s_ac_prct(ii,1)-s_ac_prct(ii,2)));
	ac_var(m)=pmean(s_ac_var(ii));
	ac_age(m)=max(s_ac_k(ii));
end

for m=1:length(cc_uid)
	ii=find(s_cc_id==cc_uid(m));
	%[Cor,Covar,N,Sig,Xbar,Ybar,sdX,sdY]
	[cc_r(m,:),cc_c(m,:),cc_n(m,:),cc_sig(m,:),cc_mux(m,:),cc_muy(m,:),cc_sdx(m,:),cc_sdy(m,:)]=...
	pcor(s_cc_amp(ii),s_cc_chl(ii),lags);
	cc_mux(m,:)=nanmedian(s_cc_chl(ii));
	cc_muy(m,:)=nanmedian(s_cc_chl(ii));
	cc_range(m)=abs(pmean(s_cc_prct(ii,1)-s_cc_prct(ii,2)));
	cc_var(m)=pmean(s_cc_var(ii));
	cc_age(m)=max(s_cc_k(ii));
end



%{
figure
clf
scatter(ac_r(:,6),ac_range,'r.')
hold on
scatter(cc_r(:,6),cc_range,'b.')
line([0 0],[-1 1],'color','k')
line([-5 5],[0 0],'color','k')
set(gca,'xtick',[-5:5])
axis([-2 2 0 .5])
xlabel('correlation ')
ylabel('dynamic range of chl  ')
title({'Scatter of dynamic range of eddies'})
text(1,.45,curs{pz})
%eval(['print -dpng figs/cor_' curs{pz} '_amp_chl'])
%}

figure
clf
scatter(ac_r(:,6),ac_muy(:,6),'r.')
hold on
scatter(cc_r(:,6),cc_muy(:,6),'b.')
line([0 0],[-1 1],'color','k')
line([-5 5],[0 0],'color','k')
set(gca,'xtick',[-5:5])
axis([-2 2 -.2 .2])
xlabel('correlation ')
ylabel('mean chl over whole life  ')
title({'Scatter of mean chl within eddy core'})
text(1,.15,curs{pz})
%eval(['print -dpng figs/scatt_sel_wek_' curs{pz} '_cor_chl'])
%eval(['save cor_mean_cores_wek_' curs{pz} ' ac* cc*'])
eval(['save select_cores_amp_' curs{pz} ' ac* cc*'])
end
