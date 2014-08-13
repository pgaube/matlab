%loads SeaWiFS CHL data
clear all
close all

jdays=[2452459:7:2454713];%[2452459:7:2454489];%[2451556:7:2454797];
lj=length(jdays);

qsave_path='~/data/QuickScat/new_mat/';
qsave_head='QSCAT_30_25km_';
fload_path='~/data/QuickScat/ULTI_mat4/';
fsave_path='~/data/QuickScat/ULTI_mat3/';

load([qsave_path qsave_head num2str(jdays(100))],'lon','lat')

wek_sst1=nan(length(lat(:,1)),1440,lj);
wek_sst2=wek_sst1;
wek_sst3=wek_sst1;
wek_crlg=wek_sst1;


ff=f_cor(lat);
ff=(8640000./(1020.*ff));
alpha=0.32;
nf=f_cor(lat)./f_cor(30);
load coupco_map_crlstr beta_*
ddo=1;

rho0 = 1.223;   % density
a0   = 2.7e-3;
b0   = 0.142e-3;
c0   = 0.0764e-3;
alpha1=0.3
alpha2=0.4
alpha3=0.5

for m=1:lj
    fprintf('\r    loading %03u of %03u\r',m,lj)
    load([qsave_path qsave_head num2str(jdays(m))],'sm_u_week','sm_v_week','hp66_dtds')
    load([fload_path qsave_head num2str(jdays(m))],'hp_wek_crlg_week')
    
    spd=sqrt(sm_u_week.^2+sm_v_week.^2);
    spd2=spd.*spd;
    
    hp_wek_sst_week_alpha1 = -ff.*rho0.*(a0*spd + b0*spd2 + c0*spd2.*spd).*alpha1.*hp66_dtds;
    hp_wek_sst_week_alpha2 = -ff.*rho0.*(a0*spd + b0*spd2 + c0*spd2.*spd).*alpha2.*hp66_dtds;
    hp_wek_sst_week_alpha3 = -ff.*rho0.*(a0*spd + b0*spd2 + c0*spd2.*spd).*alpha3.*hp66_dtds;
    
    wek_sst1(:,:,m)=hp_wek_sst_week_alpha1;
    wek_sst2(:,:,m)=hp_wek_sst_week_alpha2;
    wek_sst3(:,:,m)=hp_wek_sst_week_alpha3;

    if exist('hp_wek_crlg_week')
        wek_crlg(:,:,m)=hp_wek_crlg_week;
    end
    
    eval(['save -append ',[fsave_path qsave_head num2str(jdays(m))],' hp_wek_sst_week_alpha*'])
    clear hp66_* hp_* u v *week
end

%save -v7.3 tmp lat lon CHL SSH
% mean_sm_wspd=nanmean(wspd,3);
% save -append sst_wek_maps median_* mean_* lat lon sm_*
%
% return
% mean_hp_ratio=nanmean(abs(wek_sst)./abs(wek_crlg),3);
% median_hp_ratio=nanmedian(abs(wek_sst)./abs(wek_crlg),3);
mean_wek_sst1=nanmean(abs(wek_sst1),3);
mean_wek_sst2=nanmean(abs(wek_sst2),3);
mean_wek_sst3=nanmean(abs(wek_sst3),3);
mean_wek_crlg=nanmean(abs(wek_crlg),3);
% sm_mean_hp_ratio=smoothn(mean_hp_ratio,20);
% sm_median_hp_ratio=smoothn(median_hp_ratio,10);

%}
save -append sst_wek_maps median_* mean_* lat lon sm_*
