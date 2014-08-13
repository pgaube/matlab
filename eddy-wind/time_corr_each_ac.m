clear
warning('off','all')
load EK_time_chl_wek
lags=[-20:20]

[yea,mon,day]=jd2jdate(ac_jday);

uid=unique(ac_id);

cor_chl_wek=nan(length(uid),length(lags));
cor_n_chl_wek=cor_chl_wek;
cor_S_chl_wek=cor_chl_wek;

for m=1:length(uid)
	ii=find(ac_id==uid(m));
	tmp_chl=ac_raw(ii);
	tmp_wek=ac_wek(ii);
	mmm=mon(ii);
	yy=find(mmm<11 & mmm>1);
	tmp_wek(yy)=nan;
	tmp_chl(yy)=nan;
	tmp_c=tmp_chl-smooth1d_loess(tmp_chl,[1:length(tmp_chl)]',20,[1:length(tmp_chl)]');
	tmp_w=tmp_wek-smooth1d_loess(tmp_wek,[1:length(tmp_wek)]',20,[1:length(tmp_wek)]');
	%tmp_c=tmp_chl;
	%tmp_w=tmp_wek;
	[cor_chl_wek(m,:),pp,cor_n_chl_wek(m,:),cor_S_chl_wek(m,:)]=...
	pcor(tmp_w,tmp_c,lags);	
	clear tmp_chl tmp_wek
end


ac_r_bar_summer=(1./nansum(cor_n_chl_wek,1)).*nansum(cor_n_chl_wek.*cor_chl_wek,1);

cor_chl_wek=nan(length(uid),length(lags));
cor_n_chl_wek=cor_chl_wek;
cor_S_chl_wek=cor_chl_wek;

for m=1:length(uid)
	ii=find(ac_id==uid(m));
	tmp_chl=ac_raw(ii);
	tmp_wek=ac_wek(ii);
	mmm=mon(ii);
	yy=find(mmm<2 | mmm>4);
	tmp_wek(yy)=nan;
	tmp_chl(yy)=nan;
	tmp_c=tmp_chl-smooth1d_loess(tmp_chl,[1:length(tmp_chl)]',20,[1:length(tmp_chl)]');
	tmp_w=tmp_wek-smooth1d_loess(tmp_wek,[1:length(tmp_wek)]',20,[1:length(tmp_wek)]');
	%tmp_c=tmp_chl;
	%tmp_w=tmp_wek;
	[cor_chl_wek(m,:),pp,cor_n_chl_wek(m,:),cor_S_chl_wek(m,:)]=...
	pcor(tmp_w,tmp_c,lags);	
	clear tmp_chl tmp_wek
end

ac_r_bar_fall=(1./nansum(cor_n_chl_wek,1)).*nansum(cor_n_chl_wek.*cor_chl_wek,1);

cor_chl_wek=nan(length(uid),length(lags));
cor_n_chl_wek=cor_chl_wek;
cor_S_chl_wek=cor_chl_wek;

for m=1:length(uid)
	ii=find(ac_id==uid(m));
	tmp_chl=ac_raw(ii);
	tmp_wek=ac_wek(ii);
	mmm=mon(ii);
	yy=find(mmm<5 | mmm>7);
	tmp_wek(yy)=nan;
	tmp_chl(yy)=nan;
	tmp_c=tmp_chl-smooth1d_loess(tmp_chl,[1:length(tmp_chl)]',20,[1:length(tmp_chl)]');
	tmp_w=tmp_wek-smooth1d_loess(tmp_wek,[1:length(tmp_wek)]',20,[1:length(tmp_wek)]');
	%tmp_c=tmp_chl;
	%tmp_w=tmp_wek;
	[cor_chl_wek(m,:),pp,cor_n_chl_wek(m,:),cor_S_chl_wek(m,:)]=...
	pcor(tmp_w,tmp_c,lags);	
	clear tmp_chl tmp_wek
end

ac_r_bar_winter=(1./nansum(cor_n_chl_wek,1)).*nansum(cor_n_chl_wek.*cor_chl_wek,1);

cor_chl_wek=nan(length(uid),length(lags));
cor_n_chl_wek=cor_chl_wek;
cor_S_chl_wek=cor_chl_wek;

for m=1:length(uid)
	ii=find(ac_id==uid(m));
	tmp_chl=ac_raw(ii);
	tmp_wek=ac_wek(ii);
	mmm=mon(ii);
	yy=find(mmm<8 | mmm>10);
	tmp_wek(yy)=nan;
	tmp_chl(yy)=nan;
	tmp_c=tmp_chl-smooth1d_loess(tmp_chl,[1:length(tmp_chl)]',20,[1:length(tmp_chl)]');
	tmp_w=tmp_wek-smooth1d_loess(tmp_wek,[1:length(tmp_wek)]',20,[1:length(tmp_wek)]');
	%tmp_c=tmp_chl;
	%tmp_w=tmp_wek;
	[cor_chl_wek(m,:),pp,cor_n_chl_wek(m,:),cor_S_chl_wek(m,:)]=...
	pcor(tmp_w,tmp_c,lags);	
	clear tmp_chl tmp_wek
end


ac_r_bar_spring=(1./nansum(cor_n_chl_wek,1)).*nansum(cor_n_chl_wek.*cor_chl_wek,1);


save time_cor_ac_wek_chl lags ac_r_bar*
cd /Users/gaube/Documents/Publications/gaube_chelton_eddy_wind/figures/calcom_data
save -ascii lags.txt lags
save -ascii r_spring.txt ac_r_bar_spring
save -ascii r_summer.txt ac_r_bar_summer
save -ascii r_fall.txt ac_r_bar_fall
save -ascii r_winter.txt ac_r_bar_winter
cd /matlab/matlab/eddy-wind




figure(8)
clf
plot(lags,ac_r_bar_spring,'g')
hold on
plot(lags,ac_r_bar_summer,'r')
plot(lags,ac_r_bar_fall,'k')
plot(lags,ac_r_bar_winter,'b')
line([0 0],[-1 1])
line([-40 40],[0 0])
axis([-20 20 -.5 .5])
warning('on','all')
