
clear all

load ULTI_wind_SH_comps

rat_a=smoothn(w_ek_total_qscat_a.mean,5)./(smoothn(w_ek_total_a.mean,5)+smoothn(w_ek_sst_fixed_a.mean,5));
rat_c=smoothn(w_ek_total_qscat_c.mean,5)./(smoothn(w_ek_total_c.mean,5)+smoothn(w_ek_sst_fixed_c.mean,5));


pcomps_raw2(rat_c,rat_c,[.7 1],0,1,5,['Cyclones W_{tot}/(W_{cur}+W_{SST})'],1,30)
print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/sh_rat_c

pcomps_raw2(rat_a,rat_a,[.7 1],0,1,5,['Anticyclones W_{tot}/(W_{cur}+W_{SST})'],1,30)
print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/sh_rat_a

tbins=[.5:.05:1.2];
[b_a,n_a]=phist(rat_a,tbins);
[b_c,n_c]=phist(rat_c,tbins);

figure(1)
clf
stairs(tbins(1:end-1),100*(cumsum(n_a)./sum(n_a)),'r','linewidth',2);
hold on
stairs(tbins(1:end-1),100*(cumsum(n_c)./sum(n_c)),'b','linewidth',2);
title('CPDF of W_{tot}./(W_{cur}+W_{SST})')
ylabel('%')
xlabel('W_{tot}./(W_{cur}+W_{SST})')
print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/sh_rat_cpdf_a
clear

%%%%%
load ULTI_wind_NH_comps

rat_a=smoothn(w_ek_total_qscat_a.mean,5)./(smoothn(w_ek_total_a.mean,5)+smoothn(w_ek_sst_fixed_a.mean,5));
rat_c=smoothn(w_ek_total_qscat_c.mean,5)./(smoothn(w_ek_total_c.mean,5)+smoothn(w_ek_sst_fixed_c.mean,5));


pcomps_raw2(rat_c,rat_c,[.7 1],0,1,5,['Cyclones W_{tot}/(W_{cur}+W_{SST})'],1,30)
print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/nh_rat_c

pcomps_raw2(rat_a,rat_a,[.7 1],0,1,5,['Anticyclones W_{tot}/(W_{cur}+W_{SST})'],1,30)
print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/nh_rat_a

tbins=[.5:.05:1.2];
[b_a,n_a]=phist(rat_a,tbins);
[b_c,n_c]=phist(rat_c,tbins);

figure(1)
clf
stairs(tbins(1:end-1),100*(cumsum(n_a)./sum(n_a)),'r','linewidth',2);
hold on
stairs(tbins(1:end-1),100*(cumsum(n_c)./sum(n_c)),'b','linewidth',2);
title('CPDF of W_{tot}./(W_{cur}+W_{SST})')
ylabel('%')
xlabel('W_{tot}./(W_{cur}+W_{SST})')
print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/nh_rat_cpdf_a
clear

load ULTI_wind_midlat_rot_comps

rat_a=smoothn(w_ek_total_qscat_a.mean,5)./(smoothn(w_ek_total_a.mean,5)+smoothn(w_ek_sst_fixed_a.mean,5));
rat_c=smoothn(w_ek_total_qscat_c.mean,5)./(smoothn(w_ek_total_c.mean,5)+smoothn(w_ek_sst_fixed_c.mean,5));


pcomps_raw2(rat_c,rat_c,[.7 1],0,1,5,['Cyclones W_{tot}/(W_{cur}+W_{SST})'],1,30)
print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/rat_c

pcomps_raw2(rat_a,rat_a,[.7 1],0,1,5,['Anticyclones W_{tot}/(W_{cur}+W_{SST})'],1,30)
print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/rat_a

tbins=[.5:.05:1.2];
[b_a,n_a]=phist(rat_a,tbins);
[b_c,n_c]=phist(rat_c,tbins);

figure(1)
clf
stairs(tbins(1:end-1),100*(cumsum(n_a)./sum(n_a)),'r','linewidth',2);
hold on
stairs(tbins(1:end-1),100*(cumsum(n_c)./sum(n_c)),'b','linewidth',2);
title('CPDF of W_{tot}./(W_{cur}+W_{SST})')
ylabel('%')
xlabel('W_{tot}./(W_{cur}+W_{SST})')
print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/rat_cpdf_a
