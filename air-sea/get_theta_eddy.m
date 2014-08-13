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