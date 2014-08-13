%loads SeaWiFS CHL data
%clear all
%close all


jdays=[2451395:7:2454461];
lj=length(jdays);

asave_path='/matlab/data/eddy/V4/mat/';
asave_head='AVISO_25_W_';
qsave_path='/matlab/data/QuickScat/mat/';
qsave_head='QSCAT_30_25km_';
osave_path='/matlab/data/ReynoldsSST/mat/';
osave_head='OI_25_30_';
OUT_HEAD   = 'SSTWIND_25_W_';
OUT_PATH   = '/matlab/data/SSTWIND/mat/';

load([asave_path asave_head num2str(jdays(1))],'lon','lat')
slat=lat;
slon=lon;
load([qsave_path qsave_head num2str(jdays(100))],'lon','lat')
load mask


[rs,cs]=imap(min(lat(:)),max(lat(:)),1,1,slat,slon);


%wek_sst=nan(length(lat(:,1)),1440,lj);
%wek_crlg=wek_sst;


ff=f_cor(lat);
ff=(8640000./(1020.*ff));
alpha=0.32;

load coupco_map_crlstr a_crl beta_* CI

for m=1:lj
	fprintf('\r    loading %03u of %03u\r',m,lj)
	if exist([qsave_path qsave_head num2str(jdays(m)) '.mat'])
	   %load([qsave_path qsave_head num2str(jdays(m))],'wspd_week','u_week','v_week','wspd_week','crlstr_week','sm_crlstr_week','w_ek')
	   load([qsave_path qsave_head num2str(jdays(m))],'sm_u_week','sm_v_week')
	   load([asave_path asave_head num2str(jdays(m))],'u','v')
	   %load([osave_path osave_head num2str(jdays(m))],'bp26_sst')
	   %load([OUT_PATH OUT_HEAD num2str(jdays(m))],'mag_t_bar','theta_prime')
	   %
	   
	   
	   %sst
	   
	   
	   [yea,mon,day]=jd2jdate(jdays(m));
	   
	   %
	   %crlg
	   %
	   tau_x=wind2stress(sm_u_week-u(rs,:));
	   tau_y=wind2stress(sm_v_week-v(rs,:));
	   crl_tau=dfdx(lat,tau_y,.25)-dfdy(tau_x,.25);
	   tt=ff.*crl_tau.*mask;
	   lp=linx_smooth2d_f(tt,6,6);
	   hp_wek_crlg_week=tt-lp;
   		
   	   figure(1)
   	   clf
   	   pcolor(lon,lat,double(hp_wek_crlg_week));shading flat;caxis([-10 10])
   	   drawnow
	   eval(['save -append ',[qsave_path qsave_head num2str(jdays(m))],' hp_*_week*'])
	   clear sm_* hp_* u_* v_*
	end
end

