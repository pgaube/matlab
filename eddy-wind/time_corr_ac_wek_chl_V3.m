clear
warning('off','all')
load EK_time_chl_wek
lags=[-15:15];

[yea,mon,day]=jd2jdate(ac_jday);


accep_cor=find(mon>=11 | mon==1);

working_on='summer'

cor_chl_wek=nan(length(accep_cor),length(lags));
cor_n_chl_wek=cor_chl_wek;
cor_S_chl_wek=cor_chl_wek;

for m=1:length(accep_cor)
	%fprintf('\r  Sampling -- file %3u of %3u \r',m,length(accep_cor))
	ii=find(ac_id==ac_id(accep_cor(m)));
	tmp_chl=nan(1,101);
	tmp_wek=tmp_chl;
	tmp_mon=tmp_chl;
	xx=ac_k(accep_cor(m))-51;
	kk=ac_k(ii);
	if xx>=0
		jj=kk+xx;
	else
		jj=kk-xx;
	end	
	for n=1:length(jj)
		if jj(n)>0
		tmp_chl(jj(n))=ac_raw(ii(n));
		tmp_wek(jj(n))=ac_wek(ii(n));
		tmp_mon(jj(n))=mon(ii(n));
		end
	end
	yy=find(tmp_mon<11 & tmp_mon>1);
	tmp_wek(yy)=nan;
	tmp_chl(yy)=nan;
	tmp_c=tmp_chl-smooth1d_loess(tmp_chl,1:length(tmp_chl),20,1:length(tmp_chl));
	tmp_w=tmp_wek-smooth1d_loess(tmp_wek,1:length(tmp_chl),20,1:length(tmp_chl));
	%tmp_c=tmp_chl;
	%tmp_w=tmp_wek;
	[cor_chl_wek(m,:),pp,cor_n_chl_wek(m,:),cor_S_chl_wek(m,:)]=...
	pcor(tmp_w,tmp_c,lags);	
	clear tmp_chl tmp_wek
end

%{
ii=find(abs(cor_chl_wek)<abs(cor_S_chl_wek));
cor_chl_wek(ii)=nan;
cor_n_chl_wek(ii)=nan;
summer_bad=length(ii)./length(cor_chl_wek(:))
%}
ac_r_bar_summer=(1./nansum(cor_n_chl_wek,1)).*nansum(cor_n_chl_wek.*cor_chl_wek,1);
%ac_r_bar_summer(abs(lags)>11)=0;

accep_cor=find(ac_par<=1.5);

working_on='fall'

accep_cor=find(mon>=2 & mon<=4);
cor_chl_wek=nan(length(accep_cor),length(lags));
cor_n_chl_wek=cor_chl_wek;
cor_S_chl_wek=cor_chl_wek;

for m=1:length(accep_cor)
	%fprintf('\r  Sampling -- file %3u of %3u \r',m,length(accep_cor))
	ii=find(ac_id==ac_id(accep_cor(m)));
	tmp_chl=nan(1,101);
	tmp_wek=tmp_chl;
	tmp_mon=tmp_chl;
	xx=ac_k(accep_cor(m))-51;
	kk=ac_k(ii);
	if xx>=0
		jj=kk+xx;
	else
		jj=kk-xx;
	end	
	for n=1:length(jj)
		if jj(n)>0
		tmp_chl(jj(n))=ac_raw(ii(n));
		tmp_wek(jj(n))=ac_wek(ii(n));
		tmp_mon(jj(n))=mon(ii(n));
		end
	end
	yy=find(tmp_mon<2 | tmp_mon>4);
	tmp_wek(yy)=nan;
	tmp_chl(yy)=nan;
	tmp_c=tmp_chl-smooth1d_loess(tmp_chl,1:length(tmp_chl),20,1:length(tmp_chl));
	tmp_w=tmp_wek-smooth1d_loess(tmp_wek,1:length(tmp_chl),20,1:length(tmp_chl));
	%tmp_c=tmp_chl;
	%tmp_w=tmp_wek;
	[cor_chl_wek(m,:),pp,cor_n_chl_wek(m,:),cor_S_chl_wek(m,:)]=...
	pcor(tmp_w,tmp_c,lags);	
	clear tmp_chl tmp_wek
end

%{
ii=find(abs(cor_chl_wek)<abs(cor_S_chl_wek));
cor_chl_wek(ii)=nan;
cor_n_chl_wek(ii)=nan;
fall_bad=length(ii)./length(cor_chl_wek(:))
%}
ac_r_bar_fall=(1./nansum(cor_n_chl_wek,1)).*nansum(cor_n_chl_wek.*cor_chl_wek,1);
%ac_r_bar_fall(abs(lags)>11)=0;

working_on='winter'

accep_cor=find(mon>=5 & mon<=7);
cor_chl_wek=nan(length(accep_cor),length(lags));
cor_n_chl_wek=cor_chl_wek;
cor_S_chl_wek=cor_chl_wek;

for m=1:length(accep_cor)
	%fprintf('\r  Sampling -- file %3u of %3u \r',m,length(accep_cor))
	ii=find(ac_id==ac_id(accep_cor(m)));
	tmp_chl=nan(1,101);
	tmp_wek=tmp_chl;
	tmp_mon=tmp_chl;
	xx=ac_k(accep_cor(m))-51;
	kk=ac_k(ii);
	if xx>=0
		jj=kk+xx;
	else
		jj=kk-xx;
	end	
	for n=1:length(jj)
		if jj(n)>0
		tmp_chl(jj(n))=ac_raw(ii(n));
		tmp_wek(jj(n))=ac_wek(ii(n));
		tmp_mon(jj(n))=mon(ii(n));
		end
	end
	yy=find(tmp_mon<5 | tmp_mon>7);
	tmp_wek(yy)=nan;
	tmp_chl(yy)=nan;
	tmp_c=tmp_chl-smooth1d_loess(tmp_chl,1:length(tmp_chl),20,1:length(tmp_chl));
	tmp_w=tmp_wek-smooth1d_loess(tmp_wek,1:length(tmp_chl),20,1:length(tmp_chl));
	%tmp_c=tmp_chl;
	%tmp_w=tmp_wek;
	[cor_chl_wek(m,:),pp,cor_n_chl_wek(m,:),cor_S_chl_wek(m,:)]=...
	pcor(tmp_w,tmp_c,lags);	
	clear tmp_chl tmp_wek
end

%{
ii=find(abs(cor_chl_wek)<abs(cor_S_chl_wek));
cor_chl_wek(ii)=nan;
cor_n_chl_wek(ii)=nan;
winter_bad=length(ii)./length(cor_chl_wek(:))
%}
ac_r_bar_winter=(1./nansum(cor_n_chl_wek,1)).*nansum(cor_n_chl_wek.*cor_chl_wek,1);
%ac_r_bar_winter(abs(lags)>11)=0;

working_on='spring'

accep_cor=find(mon>=8 & mon<=10);
cor_chl_wek=nan(length(accep_cor),length(lags));
cor_n_chl_wek=cor_chl_wek;
cor_S_chl_wek=cor_chl_wek;

for m=1:length(accep_cor)
	%fprintf('\r  Sampling -- file %3u of %3u \r',m,length(accep_cor))
	ii=find(ac_id==ac_id(accep_cor(m)));
	tmp_chl=nan(1,101);
	tmp_wek=tmp_chl;
	tmp_mon=tmp_chl;
	xx=ac_k(accep_cor(m))-51;
	kk=ac_k(ii);
	if xx>=0
		jj=kk+xx;
	else
		jj=kk-xx;
	end	
	for n=1:length(jj)
		if jj(n)>0
		tmp_chl(jj(n))=ac_raw(ii(n));
		tmp_wek(jj(n))=ac_wek(ii(n));
		tmp_mon(jj(n))=mon(ii(n));
		end
	end
	yy=find(tmp_mon<8 | tmp_mon>10);
	tmp_wek(yy)=nan;
	tmp_chl(yy)=nan;
	tmp_c=tmp_chl-smooth1d_loess(tmp_chl,1:length(tmp_chl),20,1:length(tmp_chl));
	tmp_w=tmp_wek-smooth1d_loess(tmp_wek,1:length(tmp_chl),20,1:length(tmp_chl));
	%tmp_c=tmp_chl;
	%tmp_w=tmp_wek;
	[cor_chl_wek(m,:),pp,cor_n_chl_wek(m,:),cor_S_chl_wek(m,:)]=...
	pcor(tmp_w,tmp_c,lags);	
	clear tmp_chl tmp_wek
end

%{
ii=find(abs(cor_chl_wek)<abs(cor_S_chl_wek));
cor_chl_wek(ii)=nan;
cor_n_chl_wek(ii)=nan;
spring_bad=length(ii)./length(cor_chl_wek(:))
%}
ac_r_bar_spring=(1./nansum(cor_n_chl_wek,1)).*nansum(cor_n_chl_wek.*cor_chl_wek,1);
%ac_r_bar_spring(abs(lags)>11)=0;

working_on='all'

accep_cor=1:length(ac_id);
cor_chl_wek=nan(length(accep_cor),length(lags));
cor_n_chl_wek=cor_chl_wek;
cor_S_chl_wek=cor_chl_wek;

for m=1:length(accep_cor)
	%fprintf('\r  Sampling -- file %3u of %3u \r',m,length(accep_cor))
	ii=find(ac_id==ac_id(accep_cor(m)));
	tmp_chl=nan(1,101);
	tmp_wek=tmp_chl;
	tmp_mon=tmp_chl;
	xx=ac_k(accep_cor(m))-51;
	kk=ac_k(ii);
	if xx>=0
		jj=kk+xx;
	else
		jj=kk-xx;
	end	
	for n=1:length(jj)
		if jj(n)>0
		tmp_chl(jj(n))=ac_raw(ii(n));
		tmp_wek(jj(n))=ac_wek(ii(n));
		tmp_mon(jj(n))=mon(ii(n));
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
ii=find(abs(cor_chl_wek)<abs(cor_S_chl_wek));
cor_chl_wek(ii)=nan;
cor_n_chl_wek(ii)=nan;
spring_bad=length(ii)./length(cor_chl_wek(:))
%}
ac_r_bar_all=(1./nansum(cor_n_chl_wek,1)).*nansum(cor_n_chl_wek.*cor_chl_wek,1);
%ac_r_bar_all(abs(lags)>11)=0;






save time_cor_ac_wek_chl cor_* accep_cor lags ac_r_bar*

cd /Users/gaube/Documents/Publications/gaube_chelton_eddy_wind/figures/calcom_data
save -ascii lags.txt lags
save -ascii r_summer.txt ac_r_bar_summer
save -ascii r_winter.txt ac_r_bar_winter
save -ascii r_spring.txt ac_r_bar_spring
save -ascii r_fall.txt ac_r_bar_fall
save -ascii r_all.txt ac_r_bar_all

cd /matlab/matlab/eddy-wind




figure(8)
clf
hold on
plot(lags,ac_r_bar_summer,'r')
plot(lags,ac_r_bar_winter,'b')
plot(lags,ac_r_bar_fall,'k')
plot(lags,ac_r_bar_spring,'g')
line([0 0],[-1 1])
line([-40 40],[0 0])
axis([-20 20 -.5 .5])
warning('on','all')
