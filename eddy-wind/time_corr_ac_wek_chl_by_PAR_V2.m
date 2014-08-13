clear
warning('off','all')
load EK_time_chl_wek
lags=[-15:15];
zz=find(lags==0);

iwinter=find(ac_par<=1.5);
isummer=find(ac_par>=2);

chl=ac_chl'-smooth1d_loess(ac_chl',1:length(ac_chl),20,1:length(ac_chl));
wek=ac_wek'-smooth1d_loess(ac_wek',1:length(ac_wek),20,1:length(ac_wek));

wek(isummer)=nan;
chl(isummer)=nan;
[cor_winter,pp,N_winter,S_winter]=pcor(wek,chl,lags);

chl=ac_chl'-smooth1d_loess(ac_chl',1:length(ac_chl),20,1:length(ac_chl));
wek=ac_wek'-smooth1d_loess(ac_wek',1:length(ac_wek),20,1:length(ac_wek));

wek(iwinter)=nan;
chl(iwinter)=nan;
[cor_summer,pp,N_summer,S_summer]=pcor(wek,chl,lags);

figure(8)
clf
hold on
plot(lags,cor_summer,'r')
plot(lags,cor_winter,'b')
line([0 0],[-1 1])
line([min(lags) max(lags)],[0 0])
axis([min(lags) max(lags) -.5 .5])
warning('on','all')


return

uid=unique(ac_id);
working_on='summer'

cor_chl_wek=nan(length(uid),length(lags));
cor_n_chl_wek=cor_chl_wek;
cor_S_chl_wek=cor_chl_wek;

for m=1:length(uid)
	%fprintf('\r  Sampling -- file %3u of %3u \r',m,length(accep_cor))
	ii=find(ac_id==uid(m));
	tmp_chl=ac_raw(ii);
	tmp_wek=ac_wek(ii);
	tmp_par=ac_par(ii);
	yy=find(tmp_par<2);
	tmp_wek(yy)=nan;
	tmp_chl(yy)=nan;
	%tmp_c=tmp_chl'-smooth1d_loess(tmp_chl',1:length(tmp_chl),20,1:length(tmp_chl));
	%tmp_w=tmp_wek'-smooth1d_loess(tmp_wek',1:length(tmp_chl),20,1:length(tmp_chl));
	tmp_c=tmp_chl;
	tmp_w=tmp_wek;
	[cor_chl_wek(m,:),pp,cor_n_chl_wek(m,:),cor_S_chl_wek(m,:)]=...
	pcor(tmp_w,tmp_c,lags);	
	clear tmp_chl tmp_wek
end



ii=find(abs(cor_chl_wek(:,zz))<abs(cor_S_chl_wek(:,zz)));
%ii=find(abs(cor_chl_wek)<abs(cor_S_chl_wek));
cor_chl_wek(ii)=nan;
cor_n_chl_wek(ii)=nan;
summer_bad=length(ii)./length(cor_chl_wek(:))

ac_r_bar_summer=(1./nansum(cor_n_chl_wek,1)).*nansum(cor_n_chl_wek.*cor_chl_wek,1);


working_on='winter'

cor_chl_wek=nan(length(uid),length(lags));
cor_n_chl_wek=cor_chl_wek;
cor_S_chl_wek=cor_chl_wek;

for m=1:length(uid)
	%fprintf('\r  Sampling -- file %3u of %3u \r',m,length(accep_cor))
	ii=find(ac_id==uid(m));
	tmp_chl=ac_raw(ii);
	tmp_wek=ac_wek(ii);
	tmp_par=ac_par(ii);
	yy=find(tmp_par>1.5);
	tmp_wek(yy)=nan;
	tmp_chl(yy)=nan;
	%tmp_c=tmp_chl'-smooth1d_loess(tmp_chl',1:length(tmp_chl),20,1:length(tmp_chl));
	%tmp_w=tmp_wek'-smooth1d_loess(tmp_wek',1:length(tmp_chl),20,1:length(tmp_chl));
	tmp_c=tmp_chl;
	tmp_w=tmp_wek;
	[cor_chl_wek(m,:),pp,cor_n_chl_wek(m,:),cor_S_chl_wek(m,:)]=...
	pcor(tmp_w,tmp_c,lags);	
	clear tmp_chl tmp_wek
end



ii=find(abs(cor_chl_wek(:,zz))<abs(cor_S_chl_wek(:,zz)));
i%i=find(abs(cor_chl_wek)<abs(cor_S_chl_wek));
cor_chl_wek(ii)=nan;
cor_n_chl_wek(ii)=nan;
winter_bad=length(ii)./length(cor_chl_wek(:))

ac_r_bar_winter=(1./nansum(cor_n_chl_wek,1)).*nansum(cor_n_chl_wek.*cor_chl_wek,1);
%}
working_on='all'
cor_chl_wek=nan(length(uid),length(lags));
cor_n_chl_wek=cor_chl_wek;
cor_S_chl_wek=cor_chl_wek;
auto_cor_par=cor_n_chl_wek;
auto_cor_chl=cor_n_chl_wek;
auto_cor_wek=cor_n_chl_wek;
auto_n_par=cor_n_chl_wek;
auto_n_chl=cor_n_chl_wek;
auto_n_wek=cor_n_chl_wek;
for m=1:length(uid)
	%fprintf('\r  Sampling -- file %3u of %3u \r',m,length(accep_cor))
	ii=find(ac_id==uid(m));
	tmp_chl=ac_raw(ii);
	tmp_wek=ac_wek(ii);
	tmp_par=ac_par(ii);
	tmp_u3=ac_amp(ii);
	%tmp_c=tmp_chl'-smooth1d_loess(tmp_chl',1:length(tmp_chl),20,1:length(tmp_chl));
	%tmp_w=tmp_wek'-smooth1d_loess(tmp_wek',1:length(tmp_chl),20,1:length(tmp_chl));
	tmp_c=tmp_chl;
	tmp_w=tmp_wek;
	[cor_chl_wek(m,:),pp,cor_n_chl_wek(m,:),cor_S_chl_wek(m,:)]=...
	pcor(tmp_w,tmp_c,lags);
	[auto_cor_u3(m,:),pp,auto_n_u3(m,:)]=pcor(tmp_u3,tmp_u3,lags);	
	[auto_cor_par(m,:),pp,auto_n_par(m,:)]=pcor(tmp_par,tmp_par,lags);
	[auto_cor_chl(m,:),pp,auto_n_chl(m,:)]=pcor(tmp_chl,tmp_chl,lags);
	[auto_cor_wek(m,:),pp,auto_n_wek(m,:)]=pcor(tmp_wek,tmp_wek,lags);
	clear tmp_chl tmp_wek
end


%{
ii=find(abs(cor_chl_wek(:,zz))<abs(cor_S_chl_wek(zz)));
ii=find(abs(cor_chl_wek)>abs(cor_S_chl_wek));
cor_chl_wek(ii)=nan;
cor_n_chl_wek(ii)=nan;
all_bad=length(ii)./length(cor_chl_wek(:))
%}

ac_r_bar_all=(1./nansum(cor_n_chl_wek,1)).*nansum(cor_n_chl_wek.*cor_chl_wek,1);
auto_r_bar_chl=(1./nansum(auto_n_chl,1)).*nansum(auto_n_chl.*auto_cor_chl,1);
auto_r_bar_wek=(1./nansum(auto_n_wek,1)).*nansum(auto_n_wek.*auto_cor_wek,1);
auto_r_bar_par=(1./nansum(auto_n_par,1)).*nansum(auto_n_par.*auto_cor_par,1);
auto_r_bar_u3=(1./nansum(auto_n_u3,1)).*nansum(auto_n_u3.*auto_cor_u3,1);


save time_cor_ac_wek_chl_par lags ac_r_bar*

cd /Users/gaube/Documents/Publications/gaube_chelton_eddy_wind/figures/calcom_data
save -ascii lags.txt lags
save -ascii r_summer_par.txt ac_r_bar_summer
save -ascii r_winter_par.txt ac_r_bar_winter
save -ascii r_all_par.txt ac_r_bar_all

cd /matlab/matlab/eddy-wind



figure(9)
clf
hold on
plot(lags,auto_r_bar_chl,'g')
plot(lags,auto_r_bar_chl,'go')
line([0 0],[-1 1])
line([min(lags) max(lags)],[0 0])
axis([min(lags) max(lags) -.5 .5])

figure(11)
clf
hold on
plot(lags,auto_r_bar_u3,'r')
plot(lags,auto_r_bar_u3,'ro')
line([0 0],[-1 1])
line([min(lags) max(lags)],[0 0])
axis([min(lags) max(lags) -1 1])

figure(12)
clf
hold on
plot(lags,auto_r_bar_par,'c')
plot(lags,auto_r_bar_par,'co')
line([0 0],[-1 1])
line([min(lags) max(lags)],[0 0])
axis([min(lags) max(lags) -1 1])

figure(10)
clf
hold on
plot(lags,auto_r_bar_wek,'k')
plot(lags,auto_r_bar_wek,'ko')
line([0 0],[-1 1])
line([min(lags) max(lags)],[0 0])
axis([min(lags) max(lags) -.5 .5])

figure(8)
clf
hold on
plot(lags,ac_r_bar_summer,'r')
plot(lags,ac_r_bar_winter,'b')
line([0 0],[-1 1])
line([min(lags) max(lags)],[0 0])
axis([min(lags) max(lags) -.5 .5])
warning('on','all')
