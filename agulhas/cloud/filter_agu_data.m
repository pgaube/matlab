%Filter CTT and Qscat data

SPANX=20
SPANY=10

sst_hp=nan*sst(:,:,1);
cross_wnd_hp=sst_hp;
ctp_hp=sst_hp;
ctt_hp=sst_hp;     
ctt_lp=sst_hp;
down_wnd_hp=sst_hp;               
tau_crl_hp=sst_hp;                    
tau_div_hp=sst_hp;                 
tau_mag_hp=sst_hp;                 
taux_hp=sst_hp;                 
tauy_hp=sst_hp;               
wind_spd_hp=sst_hp;           


%just do means
ctt_hp=smooth2d_f(nanmean(ctt_day,3),2,2)-smooth2d_f(nanmean(ctt_day,3),SPANX,SPANY);
ctt_lo_hp=smooth2d_f(nanmean(ctt_lo_day,3),2,2)-smooth2d_f(nanmean(ctt_lo_day,3),SPANX,SPANY);
ctt_hi_hp=smooth2d_f(nanmean(ctt_hi_day,3),2,2)-smooth2d_f(nanmean(ctt_hi_day,3),SPANX,SPANY);
sst_hp=nanmean(sst,3)-smooth2d_f(nanmean(sst,3),SPANX,SPANY);
cross_wnd_hp=nanmean(cross_wnd,3)-smooth2d_f(nanmean(cross_wnd,3),SPANX,SPANY);
down_wnd_hp=nanmean(down_wnd,3)-smooth2d_f(nanmean(down_wnd,3),SPANX,SPANY);
tau_crl_hp=nanmean(tau_crl,3)-smooth2d_f(nanmean(tau_crl,3),SPANX,SPANY);
tau_div_hp=nanmean(tau_div,3)-smooth2d_f(nanmean(tau_div,3),SPANX,SPANY);
tau_mag_hp=nanmean(tau_mag,3)-smooth2d_f(nanmean(tau_mag,3),SPANX,SPANY);
taux_hp=nanmean(taux,3)-smooth2d_f(nanmean(taux,3),SPANX,SPANY);
tauy_hp=nanmean(tauy,3)-smooth2d_f(nanmean(tauy,3),SPANX,SPANY);
wind_spd_hp=nanmean(wind_spd,3)-smooth2d_f(nanmean(wind_spd,3),SPANX,SPANY);

%{
for m=1:12
	m
    % Smooth CTT 2x2 before hp filtering
    ctt_lp(:,:,m)=smooth2d_f(ctt(:,:,m),2,2);
	sst_hp(:,:,m)=sst(:,:,m)-smooth2d_f(sst(:,:,m),SPANX,SPANY);
	cross_wnd_hp(:,:,m)=cross_wnd(:,:,m)-smooth2d_f(cross_wnd(:,:,m),SPANX,SPANY);
	ctp_hp(:,:,m)=ctp(:,:,m)-smooth2d_f(ctp(:,:,m),SPANX,SPANY);
	ctt_hp(:,:,m)=ctt_lp(:,:,m)-smooth2d_f(ctt(:,:,m),SPANX,SPANY);
	down_wnd_hp(:,:,m)=down_wnd(:,:,m)-smooth2d_f(down_wnd(:,:,m),SPANX,SPANY);
	tau_crl_hp(:,:,m)=tau_crl(:,:,m)-smooth2d_f(tau_crl(:,:,m),SPANX,SPANY);
	tau_div_hp(:,:,m)=tau_div(:,:,m)-smooth2d_f(tau_div(:,:,m),SPANX,SPANY);
	tau_mag_hp(:,:,m)=tau_mag(:,:,m)-smooth2d_f(tau_mag(:,:,m),SPANX,SPANY);
	taux_hp(:,:,m)=taux(:,:,m)-smooth2d_f(taux(:,:,m),SPANX,SPANY);
	tauy_hp(:,:,m)=tauy(:,:,m)-smooth2d_f(tauy(:,:,m),SPANX,SPANY);
	wind_spd_hp(:,:,m)=wind_spd(:,:,m)-smooth2d_f(wind_spd(:,:,m),SPANX,SPANY);
	
end	
%}