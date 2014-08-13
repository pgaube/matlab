clear all
close all


alph = .32;

Q_HEAD   = 'QSCAT_30_25km_';
Q_PATH   = '/matlab/data/QuickScat/mat/';

SSH_HEAD   = 'AVISO_25_W_';
SSH_PATH   = '/matlab/data/eddy/V4/mat/';

OI_HEAD   = 'OI_25_30_';
OI_PATH   = '/matlab/data/ReynoldsSST/mat/';

OUT_HEAD   = 'SSTWIND_25_W_';
OUT_PATH   = '/matlab/data/SSTWIND/mat/';

startjd=2452459;
endjd=2454489;
jdays=startjd:7:endjd;


for m=1:length(jdays)
	fprintf('\r     making week %03u of %03u \r',m,length(jdays))
	out_file = [OUT_PATH OUT_HEAD num2str(jdays(m))];
	load([Q_PATH Q_HEAD num2str(jdays(m))],'u_week','v_week','bp26_wspd','bp26_crl');
	load([SSH_PATH SSH_HEAD num2str(jdays(m))],'bp26_crlg','lon','lat','crl');
    bp26_crlg=bp26_crlg(41:600,:);
    crl=crl(41:600,:);
    lon=lon(41:600,:);
    lat=lat(41:600,:);
	w_theta=rad2deg(cart2pol(u_week,v_week));
	pur_w_theta=w_theta;
	
	%now gradt
	load([OI_PATH OI_HEAD num2str(jdays(m))],'sst_week','bp26_sst');
	sst=sst_week(81:640,:);
	bp26_sst=bp26_sst(81:640,:);
	u_t=dfdx(lat,sst,.25);
	v_t=dfdy(sst,.25);
	mag_t_bar=sqrt(u_t.^2+v_t.^2);
	t_theta=rad2deg(cart2pol(u_t,v_t));
	
	ii=find(w_theta<0);
	w_theta(ii)=360+w_theta(ii);
	
	ii=find(t_theta<0);
	t_theta(ii)=360+t_theta(ii);
	
	tmp_theta=(w_theta-t_theta);
	ii=find(tmp_theta<0);
	theta_prime=nan*tmp_theta;
	theta_prime(ii)=360+(w_theta(ii)-t_theta(ii));
	ii=find(tmp_theta>0);
	theta_prime(ii)=360-(w_theta(ii)-t_theta(ii));
	
	%{
	wind_crl_sst=alph*mag_t_bar.*sind(theta_prime);
	
	wind_crl_sst_pert_wspd=-crl+wind_crl_sst;
	
	lp=linx_smooth2d_f(wind_crl_sst_pert_wspd,6,6);
    sm=linx_smooth2d_f(wind_crl_sst_pert_wspd,2,2);
	bp26_sst_ind_crl=sm-lp;
	
	
	Swspd = gama*bp26_sst;
	
	[Su,Sv] = pol2cart(deg2rad(pur_w_theta),Swspd);
	
	Svdx = dfdx(lat,Sv,.25);
	Sudy = dfdy(Su,.25);
	
	wind_crl_sst_pert_wspd = bp26_crlg+(Svdx-Sudy);
	%}
	
	
	eval(['save ' out_file '  *theta* u_t v_t mag_t_bar'])	
end