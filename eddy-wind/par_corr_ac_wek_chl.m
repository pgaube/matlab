clear
warning('off','all')
load EK_time_chl_wek
lags=[-20:20];

[yea,mon,day]=jd2jdate(ac_jday);


accep_cor=find(ac_par<1.8);

%{
cor_chl_wek=nan(length(accep_cor),length(lags));
cor_n_chl_wek=cor_chl_wek;
cor_S_chl_wek=cor_chl_wek;
%}

for m=1:length(accep_cor)
	ii=find(ac_id==ac_id(accep_cor(m)) & ac_par<1.8);
	tmp_chl=nan(1,length(ii));
	tmp_wek=tmp_chl;
	kk=ac_k(ii);
	xx=ac_k(accep_cor(m))-max(lags)+1;
	jj=kk-xx;
	for n=1:length(ii)
		if jj(n)>0
		tmp_chl(jj(n))=ac_raw(ii(n));
		tmp_wek(jj(n))=ac_wek(ii(n));
		end
	end
	
	tmp_c=tmp_chl-smooth1d_loess(tmp_chl,1:length(tmp_chl),20,1:length(tmp_chl));
	tmp_w=tmp_wek-smooth1d_loess(tmp_wek,1:length(tmp_chl),20,1:length(tmp_chl));
	%tmp_c=tmp_chl;
	%tmp_w=tmp_wek;
	[cor_chl_wek(m,:),pp,cor_n_chl_wek(m,:),cor_S_chl_wek(m,:)]=...
	pcor(tmp_w,tmp_c,lags);	
	clear tmp_chl tmp_wek
end

%{
ii=find(cor_chl_wek>=cor_S_chl_wek);
cor_chl_wek(ii,:)=nan;
cor_n_chl_wek(ii,:)=nan;
summer_bad=length(ii)./length(cor_chl_wek(:,1))
%}

ac_r_bar_low_par=(1./nansum(cor_n_chl_wek,1)).*nansum(cor_n_chl_wek.*cor_chl_wek,1);


accep_cor=find(ac_par>1.8);
cor_chl_wek=nan(length(accep_cor),length(lags));
cor_n_chl_wek=cor_chl_wek;
cor_S_chl_wek=cor_chl_wek;

for m=1:length(accep_cor)
	ii=find(ac_id==ac_id(accep_cor(m)) & ac_par>1.8);
	tmp_chl=nan(1,length(ii));
	tmp_wek=tmp_chl;
	kk=ac_k(ii);
	xx=ac_k(accep_cor(m))-21;
	jj=kk-xx;
	for n=1:length(ii)
		if jj(n)>0
		tmp_chl(jj(n))=ac_raw(ii(n));
		tmp_wek(jj(n))=ac_wek(ii(n));
		end
	end
	
	tmp_c=tmp_chl-smooth1d_loess(tmp_chl,1:length(tmp_chl),20,1:length(tmp_chl));
	tmp_w=tmp_wek-smooth1d_loess(tmp_wek,1:length(tmp_chl),20,1:length(tmp_chl));
	%tmp_c=tmp_chl;
	%tmp_w=tmp_wek;
	[cor_chl_wek(m,:),pp,cor_n_chl_wek(m,:),cor_S_chl_wek(m,:)]=...
	pcor(tmp_w,tmp_c,lags);	
	clear tmp_chl tmp_wek
end

%{
ii=find(cor_chl_wek>=cor_S_chl_wek);
cor_chl_wek(ii,:)=nan;
cor_n_chl_wek(ii,:)=nan;
fall_bad=length(ii)./length(cor_chl_wek(:,1))
%}

ac_r_bar_hi_par=(1./nansum(cor_n_chl_wek,1)).*nansum(cor_n_chl_wek.*cor_chl_wek,1);

save par_cor_ac_wek_chl cor_* accep_cor lags ac_r_bar*

%{
cd /Users/gaube/Documents/Publications/gaube_chelton_eddy_wind/figures/calcom_data
save -ascii lags.txt lags
save -ascii r_spring.txt ac_r_bar_spring
save -ascii r_summer.txt ac_r_bar_summer
save -ascii r_fall.txt ac_r_bar_fall
save -ascii r_winter.txt ac_r_bar_winter
%}


figure(8)
plot(lags,ac_r_bar_hi_par,'r')
hold on
plot(lags,ac_r_bar_low_par,'b')
line([0 0],[-1 1])
line([-40 40],[0 0])
axis([-20 20 -.5 .5])
warning('on','all')
