%loads SeaWiFS CHL data
%clear all
%close all


jdays=[2452459:7:2454489];%[2451556:7:2454797];
lj=length(jdays);

asave_path='/matlab/data/eddy/V4/mat/';
asave_head='AVISO_25_W_';
qsave_path='/matlab/data/QuickScat/mat/';
qsave_head='QSCAT_30_25km_';
osave_path='/matlab/data/ReynoldsSST/mat/';
osave_head='OI_25_30_';


load([asave_path asave_head num2str(jdays(1))],'lon','lat')
slat=lat;
slon=lon;
load([osave_path osave_head num2str(jdays(1))],'lon','lat')
olat=lat;
olon=lon;
load([qsave_path qsave_head num2str(jdays(100))],'lon','lat')


[rssh,cssh]=imap(min(lat(:)),max(lat(:)),1,1,slat,slon);
[ro,co]=imap(min(lat(:)),max(lat(:)),1,1,olat,olon);


ff=f_cor(lat);
denom=1020*sqrt(abs(ff));
[rn,cn]=imap(0,90,0,360,lat,lon);
[rs,cs]=imap(-90,0,0,360,lat,lon);
for m=1:lj
	fprintf('\r    loading %03u of %03u\r',m,lj)
	%load([qsave_path qsave_head num2str(jdays(m))],'bp_crl_sst','bp_crl_e')
	load([qsave_path qsave_head num2str(jdays(m))],'sm_u_week','sm_v_week','u_week','v_week','u_e','v_e','wspd_week','bp_crl_sst','bp_crl_sst')
	load([asave_path asave_head num2str(jdays(m))],'u','v','bp26_crlg')
	load([osave_path osave_head num2str(jdays(m))],'sst_week')
	
	w_theta=rad2deg(cart2pol(sm_u_week,sm_v_week));
	gradt_x=dfdx(lat,sst_week,.25);
	gradt_y=dfdy(sst_week,.25);
	t_theta=rad2deg(cart2pol(gradt_x(ro,:),gradt_y(ro,:)));
	
	w_theta(w_theta<0)=360+w_theta(w_theta<0);
	t_theta(t_theta<0)=360+t_theta(t_theta<0);

	tmp_theta=(w_theta-t_theta);
	thet_prime=nan*tmp_theta
	theta_prime(tmp_theta<0)=360+(w_theta(tmp_theta<0)-t_theta(tmp_theta<0));
	theta_prime(tmp_theta>0)=360-(w_theta(tmp_theta>0)-t_theta(tmp_theta>0));

	
	wind_crl_sst=gradt(ro,:)*sind(theta_prime(lay));

	return
	%{
	figure(1)
	clf
	quiver([1:10:225],[1:10:225],u_w_tmp(1:10:225,1:10:225),v_w_tmp(1:10:225,1:10:225))
	title('wind')
	drawnow
	figure(2)
	clf
	compass(u_w_bar,u_w_bar)
	drawnow
	%}
	
	
	
	
	%{
	ii=find(1e5*abs(bp_crl_sst)>1);
	bp_crl_sst(ii)=nan;
	%}
	
	%sst
	%
	sst=sst_week(ro,:);
	theta=rad2deg(cart2pol(sm_u_week,sm_v_week));	
	ii=find(theta<0);
	theta(ii)=180+(180+theta(ii));
	[u_sst,v_sst]=pol2cart(deg2rad(theta),0.32*sst);		
	crl_sst = dfdx(lat,v_sst,.25)-dfdy(u_sst,.25);
	sm_crl_sst=linx_smooth2d_f(crl_sst,2,2);
	lp=linx_smooth2d_f(sm_crl_sst,6,6);
	bp_crl_sst=sm_crl_sst-lp;
	save test bp_crl_sst
	return
	%drift
	crl_e = dfdx(lat,v_e,.25)-dfdy(u_e,.25);
	sm_crl_e=linx_smooth2d_f(crl_e,2,2);
	lp=linx_smooth2d_f(sm_crl_e,6,6);
	bp_crl_e=sm_crl_e-lp;
	%}
	
	%all the crls
	
	bp_crl_all=bp_crl_sst-bp26_crlg(rssh,:)-bp_crl_e;
	bp_crl_gs=bp_crl_sst-bp26_crlg(rssh,:);
	eval(['save -append ',[qsave_path qsave_head num2str(jdays(m))],' bp_crl_gs bp_crl_all bp_crl_sst'])
	
end


clear all
close all
OUT_HEAD   = 'TRANS_W_';
OUT_PATH   = '/Volumes/matlab/matlab/global/new_trans_samp/';
startjd=2452459;
endjd=2454489;
jdays=startjd:7:endjd;


for m=1:length(jdays)
	fprintf('\r     compositing week %03u of %03u \r',m,length(jdays))
	out_file = [OUT_PATH OUT_HEAD num2str(jdays(m))];
	load(out_file,'lat_sample','nrfoi_sample','nru_sample','nrv_sample');
	% Create matrices to save jdays
	[M]=length(lat_sample(1,1,:));
	t_theta=double(nan(M,1));
	w_theta=double(nan(M,1));
	s_theta=double(nan(M,1));
	theta_prime=double(nan(M,1));
	wind_crl_sst=double(nan(M,1));
	stress_crl_sst=double(nan(M,1));
		
		for lay=1:M
		fprintf('\r     Calculating %3u of %3u \r',lay,M)
		%start with wind
		u_w_tmp=nru_sample(:,:,lay);
		u_w_bar=nanmean(u_w_tmp(:));
		v_w_tmp=nrv_sample(:,:,lay);
		v_w_bar=nanmean(v_w_tmp(:));
		

		w_theta(lay)=rad2deg(cart2pol(u_w_bar,v_w_bar));
		
		
		%{
		figure(1)
		clf
		quiver([1:10:225],[1:10:225],u_w_tmp(1:10:225,1:10:225),v_w_tmp(1:10:225,1:10:225))
		title('wind')
		drawnow
		figure(2)
		clf
		compass(u_w_bar,u_w_bar)
		drawnow
		%}
		

		%now gradt
		tmp_lat=interp2([1:41],[1:41]',lat_sample(:,:,lay),[1:.178:41],[1:.178:41]');
		u_t_tmp=dfdx(tmp_lat,nrfoi_sample(:,:,lay),.0446);
		u_t_bar=nanmean(u_t_tmp(:));
		v_t_tmp=dfdy(nrfoi_sample(:,:,lay),.0446);
		v_t_bar=nanmean(v_t_tmp(:));
		mag_t_bar=sqrt(u_t_bar^2+v_t_bar^2);
		t_theta(lay)=rad2deg(cart2pol(u_t_bar,v_t_bar));
		
		if w_theta(lay)<0
			w_theta(lay)=360+w_theta(lay);
		end
		if t_theta(lay)<0
			t_theta(lay)=360+t_theta(lay);
		end
		
		tmp_theta=(w_theta(lay)-t_theta(lay));
		if tmp_theta<0
			theta_prime(lay)=360+(w_theta(lay)-t_theta(lay));
		else
			theta_prime(lay)=360-(w_theta(lay)-t_theta(lay));
		end
		
		wind_crl_sst(lay)=mag_t_bar*sind(theta_prime(lay));
		%{
		figure(3)
		clf
		pcolor(double(nrfoi_sample(:,:,lay)));shading flat;hold on
		quiver([1:6:225],[1:6:225],u_t_tmp(1:6:225,1:6:225),v_t_tmp(1:6:225,1:6:225))
		title('gradt')
		drawnow
		hold off
		figure(4)
		clf
		compass(u_t_bar,v_t_bar)
		title(['\theta = ',num2str(theta_prime(lay))])
		drawnow
		%}
		
		end
	eval(['save -append ' out_file ' w_theta t_theta theta_prime wind_crl_sst'])	
end