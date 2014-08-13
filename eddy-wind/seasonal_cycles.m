
%
apath='/matlab/data/eddy/V4/mat/AVISO_25_W_';
spath='/matlab/data/mld/mat/MLD_25_30_';
qpath='/matlab/data/QuickScat/mat/QSCAT_30_25km_';
ppath='/matlab/data/gsm/mat/GSM_9_21_';

startjd=2451556
endjd=2454832
jdays=[startjd:7:endjd];
jdays=jdays(1:end-5);

load([ppath num2str(jdays(1))],'glon','glat')
load([spath num2str(jdays(1))],'lon','lat')
load([qpath num2str(jdays(200))],'lon','lat')
qlon=lon;
qlat=lat;

load /matlab/matlab/domains/EK_lat_lon.mat
[r,c]=imap(min(lat),max(lat),min(lon),max(lon),lat,lon);
[rq,cq]=imap(min(lat),max(lat),min(lon),max(lon),qlat,qlon);
[rg,cg]=imap(min(lat),max(lat),min(lon),max(lon),glat,glon);


[ts_mld,ts_u3,ts_par,ts_chl,ts_strm,ts_car]=deal(nan*jdays);

%
for m=1:length(jdays)
	m
	load([ppath num2str(jdays(m))],'gpar_week')
	tmp=gpar_week(rg,cg);
	ts_par(m)=nanmean(tmp(:));
	
	load([spath num2str(jdays(m))],'mld_week')
	tmp=mld_week(rg,cg);
	ts_mld(m)=nanmean(tmp(:));
	
	load([ppath num2str(jdays(m))],'gchl_week')
	tmp=gchl_week(rg,cg);
	ts_chl(m)=10^nanmean(tmp(:));
	
	load([ppath num2str(jdays(m))],'gcar_week')
	tmp=gcar_week(rg,cg);
	ts_car(m)=nanmean(tmp(:));
	
	load([qpath num2str(jdays(m))],'u3_week')
	tmp=u3_week(rq,cq);
	ts_u3(m)=nanmean(tmp(:));
	
	load([qpath num2str(jdays(m))],'strm_week')
	tmp=strm_week(rq,cq);
	ts_strm(m)=nanmean(tmp(:));
end
	
save seasonal_cycles_ts ts_* jdays lat lon

%}
load EK_time_chl_wek
%load seasonal_cycles_ts
[ts_ac_u3,ts_cc_u3,ts_ac_par,ts_cc_par,ts_ac_raw,ts_cc_raw,ts_ac_mld,ts_ac_chl,ts_cc_chl,...
ts_cc_mld,ts_ac_amp,ts_cc_amp,ts_cc_wek,ts_ac_wek,ts_cc_r,ts_ac_r,ts_log_r,ts_log_r,ts_ac_car,ts_cc_car]...
=deal(nan(size(ts_mld)));

for m=1:length(ts_ac_mld);
	ii=find(ac_jday==jdays(m));
	ts_ac_mld(m)=pmean(ac_amld(ii));
	ts_ac_amp(m)=pmean(ac_amp(ii));
	ts_ac_wek(m)=pmean(ac_wek(ii));
	ts_ac_raw(m)=pmean(ac_raw(ii));
	ts_ac_par(m)=pmean(ac_par(ii));
	ts_ac_u3(m)=pmean(ac_u3(ii));
	ts_ac_car(m)=pmean(ac_car(ii));
	ts_ac_r(m)=pmean(ac_r_chl_wek(ii));
	ts_ac_log(m)=pmean(ac_log(ii));
	ts_ac_chl(m)=pmean(ac_chl(ii));
	
	ii=find(cc_jday==jdays(m));
	ts_cc_mld(m)=pmean(cc_amld(ii));
	ts_cc_amp(m)=pmean(cc_amp(ii));
	ts_cc_wek(m)=pmean(cc_wek(ii));
	ts_cc_raw(m)=pmean(cc_raw(ii));
	ts_cc_par(m)=pmean(cc_par(ii));
	ts_cc_u3(m)=pmean(cc_u3(ii));
	ts_cc_car(m)=pmean(cc_car(ii));
	ts_cc_r(m)=pmean(cc_r_chl_wek(ii));
	ts_cc_log(m)=pmean(cc_log(ii));
	ts_cc_chl(m)=pmean(cc_chl(ii));
end	



f=2*pi/365.25;
[ss_ac_chl,beta_ac_chl]=harm_reg(jdays,ts_ac_chl,2,2*pi/365.25);
[ss_cc_chl,beta_cc_chl]=harm_reg(jdays,ts_cc_chl,2,2*pi/365.25);
[ss_ac_r,beta_ac_r]=harm_reg(jdays,ts_ac_r,2,2*pi/365.25);
[ss_cc_r,beta_cc_r]=harm_reg(jdays,ts_cc_r,2,2*pi/365.25);
[ss_ac_log,beta_ac_log]=harm_reg(jdays,ts_ac_log,2,2*pi/365.25);
[ss_cc_log,beta_cc_log]=harm_reg(jdays,ts_cc_log,2,2*pi/365.25);
[ss_ac_raw,beta_ac_raw]=harm_reg(jdays,ts_ac_raw,2,2*pi/365.25);
[ss_cc_raw,beta_cc_raw]=harm_reg(jdays,ts_cc_raw,2,2*pi/365.25);
[ss_ac_wek,beta_ac_wek]=harm_reg(jdays,ts_ac_wek,2,2*pi/365.25);
[ss_cc_wek,beta_cc_wek]=harm_reg(jdays,ts_cc_wek,2,2*pi/365.25);
[ss_ac_amp,beta_ac_amp]=harm_reg(jdays,ts_ac_amp,2,2*pi/365.25);
[ss_cc_amp,beta_cc_amp]=harm_reg(jdays,ts_cc_amp,2,2*pi/365.25);
[ss_ac_mld,beta_ac_mld]=harm_reg(jdays,ts_ac_mld,2,2*pi/365.25);
[ss_cc_mld,beta_cc_mld]=harm_reg(jdays,ts_cc_mld,2,2*pi/365.25);
[ss_ac_u3,beta_ac_u3]=harm_reg(jdays,ts_ac_u3,2,2*pi/365.25);
[ss_cc_u3,beta_cc_u3]=harm_reg(jdays,ts_cc_u3,2,2*pi/365.25);
[ss_ac_car,beta_ac_car]=harm_reg(jdays,ts_ac_car,2,2*pi/365.25);
[ss_cc_car,beta_cc_car]=harm_reg(jdays,ts_cc_car,2,2*pi/365.25);
[ss_ac_par,beta_ac_par]=harm_reg(jdays,ts_ac_par,2,2*pi/365.25);
[ss_cc_par,beta_cc_par]=harm_reg(jdays,ts_cc_par,2,2*pi/365.25);
[ss_chl,beta_chl]=harm_reg(jdays,10.^ts_chl,2,2*pi/365.25);
[ss_strm,beta_strm]=harm_reg(jdays,ts_strm,2,2*pi/365.25);
[ss_car,beta_car]=harm_reg(jdays,ts_car,2,2*pi/365.25);
[ss_mld,beta_mld]=harm_reg(jdays,ts_mld,2,2*pi/365.25);
save seasonal_cycles ss_* beta_* jdays


x=1:365;
ac_chl_y=beta_ac_chl(1)+beta_ac_chl(2)*cos(f*x)+beta_ac_chl(3)*cos(2*f*x)+beta_ac_chl(4)*sin(f*x)+beta_ac_chl(5)*sin(2*f*x);
cc_chl_y=beta_cc_chl(1)+beta_cc_chl(2)*cos(f*x)+beta_cc_chl(3)*cos(2*f*x)+beta_cc_chl(4)*sin(f*x)+beta_cc_chl(5)*sin(2*f*x);
ac_r_y=beta_ac_r(1)+beta_ac_r(2)*cos(f*x)+beta_ac_r(3)*cos(2*f*x)+beta_ac_r(4)*sin(f*x)+beta_ac_r(5)*sin(2*f*x);
cc_r_y=beta_cc_r(1)+beta_cc_r(2)*cos(f*x)+beta_cc_r(3)*cos(2*f*x)+beta_cc_r(4)*sin(f*x)+beta_cc_r(5)*sin(2*f*x);
ac_log_y=beta_ac_log(1)+beta_ac_log(2)*cos(f*x)+beta_ac_log(3)*cos(2*f*x)+beta_ac_log(4)*sin(f*x)+beta_ac_log(5)*sin(2*f*x);
cc_log_y=beta_cc_log(1)+beta_cc_log(2)*cos(f*x)+beta_cc_log(3)*cos(2*f*x)+beta_cc_log(4)*sin(f*x)+beta_cc_log(5)*sin(2*f*x);
ac_raw_y=beta_ac_raw(1)+beta_ac_raw(2)*cos(f*x)+beta_ac_raw(3)*cos(2*f*x)+beta_ac_raw(4)*sin(f*x)+beta_ac_raw(5)*sin(2*f*x);
cc_raw_y=beta_cc_raw(1)+beta_cc_raw(2)*cos(f*x)+beta_cc_raw(3)*cos(2*f*x)+beta_cc_raw(4)*sin(f*x)+beta_cc_raw(5)*sin(2*f*x);
ac_wek_y=beta_ac_wek(1)+beta_ac_wek(2)*cos(f*x)+beta_ac_wek(3)*cos(2*f*x)+beta_ac_wek(4)*sin(f*x)+beta_ac_wek(5)*sin(2*f*x);
cc_wek_y=beta_cc_wek(1)+beta_cc_wek(2)*cos(f*x)+beta_cc_wek(3)*cos(2*f*x)+beta_cc_wek(4)*sin(f*x)+beta_cc_wek(5)*sin(2*f*x);
ac_amp_y=beta_ac_amp(1)+beta_ac_amp(2)*cos(f*x)+beta_ac_amp(3)*cos(2*f*x)+beta_ac_amp(4)*sin(f*x)+beta_ac_amp(5)*sin(2*f*x);
cc_amp_y=beta_cc_amp(1)+beta_cc_amp(2)*cos(f*x)+beta_cc_amp(3)*cos(2*f*x)+beta_cc_amp(4)*sin(f*x)+beta_cc_amp(5)*sin(2*f*x);
ac_mld_y=beta_ac_mld(1)+beta_ac_mld(2)*cos(f*x)+beta_ac_mld(3)*cos(2*f*x)+beta_ac_mld(4)*sin(f*x)+beta_ac_mld(5)*sin(2*f*x);
cc_mld_y=beta_cc_mld(1)+beta_cc_mld(2)*cos(f*x)+beta_cc_mld(3)*cos(2*f*x)+beta_cc_mld(4)*sin(f*x)+beta_cc_mld(5)*sin(2*f*x);
ac_u3_y=beta_ac_u3(1)+beta_ac_u3(2)*cos(f*x)+beta_ac_u3(3)*cos(2*f*x)+beta_ac_u3(4)*sin(f*x)+beta_ac_u3(5)*sin(2*f*x);
cc_u3_y=beta_cc_u3(1)+beta_cc_u3(2)*cos(f*x)+beta_cc_u3(3)*cos(2*f*x)+beta_cc_u3(4)*sin(f*x)+beta_cc_u3(5)*sin(2*f*x);
ac_car_y=beta_ac_car(1)+beta_ac_car(2)*cos(f*x)+beta_ac_car(3)*cos(2*f*x)+beta_ac_car(4)*sin(f*x)+beta_ac_car(5)*sin(2*f*x);
cc_car_y=beta_cc_car(1)+beta_cc_car(2)*cos(f*x)+beta_cc_car(3)*cos(2*f*x)+beta_cc_car(4)*sin(f*x)+beta_cc_car(5)*sin(2*f*x);
ac_par_y=beta_ac_par(1)+beta_ac_par(2)*cos(f*x)+beta_ac_par(3)*cos(2*f*x)+beta_ac_par(4)*sin(f*x)+beta_ac_par(5)*sin(2*f*x);
cc_par_y=beta_cc_par(1)+beta_cc_par(2)*cos(f*x)+beta_cc_par(3)*cos(2*f*x)+beta_cc_par(4)*sin(f*x)+beta_cc_par(5)*sin(2*f*x);
chl_y=beta_chl(1)+beta_chl(2)*cos(f*x)+beta_chl(3)*cos(2*f*x)+beta_chl(4)*sin(f*x)+beta_chl(5)*sin(2*f*x);
strm_y=beta_strm(1)+beta_strm(2)*cos(f*x)+beta_strm(3)*cos(2*f*x)+beta_strm(4)*sin(f*x)+beta_strm(5)*sin(2*f*x);
car_y=beta_car(1)+beta_car(2)*cos(f*x)+beta_car(3)*cos(2*f*x)+beta_car(4)*sin(f*x)+beta_car(5)*sin(2*f*x);
mld_y=beta_mld(1)+beta_mld(2)*cos(f*x)+beta_mld(3)*cos(2*f*x)+beta_mld(4)*sin(f*x)+beta_mld(5)*sin(2*f*x);
figure(121)
clf
plot(x,chl_y./(max(abs(chl_y))),'g')
hold on
plot(x,car_y./(max(abs(car_y))),'b')
legend('CHL','C')
return
%print -dpng -r300 ss_mld_u3

cd /Users/gaube/Documents/Publications/gaube_chelton_eddy_wind/figures/

save -ascii calcom_data/time.txt x
save -ascii calcom_data/ss_chl.txt chl_y
save -ascii calcom_data/ss_mld.txt mld_y
save -ascii calcom_data/ss_ac_mld.txt ac_mld_y
save -ascii calcom_data/ss_cc_mld.txt cc_mld_y
save -ascii calcom_data/ss_ac_u3.txt ac_u3_y
save -ascii calcom_data/ss_ac_u3.txt ac_u3_y
save -ascii calcom_data/ss_cc_u3.txt cc_u3_y
save -ascii calcom_data/ss_ac_car.txt ac_car_y
save -ascii calcom_data/ss_cc_car.txt cc_car_y
save -ascii calcom_data/ss_ac_par.txt ac_par_y
save -ascii calcom_data/ss_cc_par.txt cc_par_y
save -ascii calcom_data/ss_ac_amp.txt ac_amp_y
save -ascii calcom_data/ss_cc_amp.txt cc_amp_y
save -ascii calcom_data/ss_ac_wek.txt ac_wek_y
save -ascii calcom_data/ss_cc_wek.txt cc_wek_y
save -ascii calcom_data/ss_ac_raw.txt ac_raw_y
save -ascii calcom_data/ss_cc_raw.txt cc_raw_y
save -ascii calcom_data/ss_ac_chl.txt ac_chl_y
save -ascii calcom_data/ss_cc_chl.txt cc_chl_y
save -ascii calcom_data/ss_ac_r.txt ac_r_y
save -ascii calcom_data/ss_cc_r.txt cc_r_y
save -ascii calcom_data/ss_ac_log.txt ac_log_y
save -ascii calcom_data/ss_cc_log.txt cc_log_y
cd /matlab/matlab/eddy-wind/