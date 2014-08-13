clear
% 
% 
load GS_rings_cor_tracks_feb_4
[chl_orgin_a,chl_orgin_c]=pop_comps_rel_orgin_mat(cor_eddies.x,cor_eddies.y,cor_eddies.cyc,cor_eddies.k,cor_eddies.id,cor_eddies.track_jday,100,'total_chl');
[ssh_orgin_a,ssh_orgin_c]=pop_comps_rel_orgin_mat(cor_eddies.x,cor_eddies.y,cor_eddies.cyc,cor_eddies.k,cor_eddies.id,cor_eddies.track_jday,100,'ssh');

[small_c_orgin_a,small_c_orgin_c]=pop_comps_rel_orgin_mat(cor_eddies.x,cor_eddies.y,cor_eddies.cyc,cor_eddies.k,cor_eddies.id,cor_eddies.track_jday,100,'small_biomass');
[diat_c_orgin_a,diat_c_orgin_c]=pop_comps_rel_orgin_mat(cor_eddies.x,cor_eddies.y,cor_eddies.cyc,cor_eddies.k,cor_eddies.id,cor_eddies.track_jday,100,'diat_biomass');
[diaz_c_orgin_a,diaz_c_orgin_c]=pop_comps_rel_orgin_mat(cor_eddies.x,cor_eddies.y,cor_eddies.cyc,cor_eddies.k,cor_eddies.id,cor_eddies.track_jday,100,'diaz_biomass');

[nh4_orgin_a,nh4_orgin_c]=pop_comps_rel_orgin(cor_eddies.x,cor_eddies.y,cor_eddies.cyc,cor_eddies.k,cor_eddies.id,cor_eddies.track_jday,100,'nh4_1to20','/Volumes/d1/larrya/public_html/0pt1/output_run14/t.14.');
[no3_orgin_a,no3_orgin_c]=pop_comps_rel_orgin(cor_eddies.x,cor_eddies.y,cor_eddies.cyc,cor_eddies.k,cor_eddies.id,cor_eddies.track_jday,100,'no3_1to20','/Volumes/d1/larrya/public_html/0pt1/output_run14/t.14.');
[po4_orgin_a,po4_orgin_c]=pop_comps_rel_orgin(cor_eddies.x,cor_eddies.y,cor_eddies.cyc,cor_eddies.k,cor_eddies.id,cor_eddies.track_jday,100,'po4_1to20','/Volumes/d1/larrya/public_html/0pt1/output_run14/t.14.');

[bio_small_orgin_a,bio_small_orgin_c]=pop_comps_rel_orgin(cor_eddies.x,cor_eddies.y,cor_eddies.cyc,cor_eddies.k,cor_eddies.id,cor_eddies.track_jday,100,'ss_spc_vint104','/Volumes/d1/larrya/public_html/0pt1/0pt1_run14/t.14.');
[bio_diat_orgin_a,bio_diat_orgin_c]=pop_comps_rel_orgin(cor_eddies.x,cor_eddies.y,cor_eddies.cyc,cor_eddies.k,cor_eddies.id,cor_eddies.track_jday,100,'ss_diatc_vint104','/Volumes/d1/larrya/public_html/0pt1/0pt1_run14/t.14.');
[bio_diaz_orgin_a,bio_diaz_orgin_c]=pop_comps_rel_orgin(cor_eddies.x,cor_eddies.y,cor_eddies.cyc,cor_eddies.k,cor_eddies.id,cor_eddies.track_jday,100,'ss_diazc_vint104','/Volumes/d1/larrya/public_html/0pt1/0pt1_run14/t.14.');
save -append pop_cor_feb_4
return

% %%Basic stuff
[norm_ssh_a,dd,norm_ssh_c,rr]=pop_comps_mat(cor_eddies.x,cor_eddies.y,cor_eddies.cyc,cor_eddies.k,cor_eddies.id,cor_eddies.track_jday,cor_eddies.radius,cor_eddies.adens,'hp21_ssh',1,'nn');
[ssh_a,dd,ssh_c,rr]=pop_comps_mat(cor_eddies.x,cor_eddies.y,cor_eddies.cyc,cor_eddies.k,cor_eddies.id,cor_eddies.track_jday,cor_eddies.radius,cor_eddies.adens,'hp21_ssh',1,'n');
[norm_hp66_chl_a,dd,norm_hp66_chl_c,rr]=pop_comps_mat(cor_eddies.x,cor_eddies.y,cor_eddies.cyc,cor_eddies.k,cor_eddies.id,cor_eddies.track_jday,cor_eddies.radius,cor_eddies.adens,'hp66_chl',1,'dd');
[norm_hp66_c_a,dd,norm_hp66_c_c,rr]=pop_comps_mat(cor_eddies.x,cor_eddies.y,cor_eddies.cyc,cor_eddies.k,cor_eddies.id,cor_eddies.track_jday,cor_eddies.radius,cor_eddies.adens,'hp66_biomass',1,'dd');
[w_a,dd,w_c,dd]= pop_comps(cor_eddies.x,cor_eddies.y,cor_eddies.cyc,cor_eddies.k,cor_eddies.id,cor_eddies.track_jday,cor_eddies.radius,cor_eddies.adens,'wvel_104','/Volumes/d1/larrya/public_html/0pt1/output_run14/t.14.',1,0);
save -append pop_cor_feb_4

% %% Biomass
[diat_c_a,dd,diat_c_c,rr]=pop_comps_mat(cor_eddies.x,cor_eddies.y,cor_eddies.cyc,cor_eddies.k,cor_eddies.id,cor_eddies.track_jday,cor_eddies.radius,cor_eddies.adens,'diat_biomass',1,'n');
[diaz_c_a,dd,diaz_c_c,rr]=pop_comps_mat(cor_eddies.x,cor_eddies.y,cor_eddies.cyc,cor_eddies.k,cor_eddies.id,cor_eddies.track_jday,cor_eddies.radius,cor_eddies.adens,'diaz_biomass',1,'n');
[sp_c_a,dd,sp_c_c,rr]=pop_comps_mat(cor_eddies.x,cor_eddies.y,cor_eddies.cyc,cor_eddies.k,cor_eddies.id,cor_eddies.track_jday,cor_eddies.radius,cor_eddies.adens,'small_biomass',1,'n');
save -append pop_cor_feb_4

% % Biomass anomalies
[norm_hp66_diaz_c_a,dd,norm_hp66_diaz_c_c,rr]=pop_comps_mat(cor_eddies.x,cor_eddies.y,cor_eddies.cyc,cor_eddies.k,cor_eddies.id,cor_eddies.track_jday,cor_eddies.radius,cor_eddies.adens,'hp66_diaz_biomass',1,'dd_diaz_c');
[norm_hp66_diat_c_a,dd,norm_hp66_diat_c_c,rr]=pop_comps_mat(cor_eddies.x,cor_eddies.y,cor_eddies.cyc,cor_eddies.k,cor_eddies.id,cor_eddies.track_jday,cor_eddies.radius,cor_eddies.adens,'hp66_diat_biomass',1,'dd_diat_c');
[norm_hp66_sp_c_a,dd,norm_hp66_sp_c_c,rr]=pop_comps_mat(cor_eddies.x,cor_eddies.y,cor_eddies.cyc,cor_eddies.k,cor_eddies.id,cor_eddies.track_jday,cor_eddies.radius,cor_eddies.adens,'hp66_small_biomass',1,'dd_small_c');
save -append pop_cor_feb_4
% return
%%Sources/sinks
[small_bio_a,small_bio_m,small_bio_c,small_bio_t]= pop_comps(cor_eddies.x,cor_eddies.y,cor_eddies.cyc,cor_eddies.k,cor_eddies.id,cor_eddies.track_jday,cor_eddies.radius,cor_eddies.adens,'ss_spc_vint104','/Volumes/d1/larrya/public_html/0pt1/0pt1_run14/t.14.',1,0);
[diaz_bio_a,diaz_bio_m,diaz_bio_c,diaz_bio_t]= pop_comps(cor_eddies.x,cor_eddies.y,cor_eddies.cyc,cor_eddies.k,cor_eddies.id,cor_eddies.track_jday,cor_eddies.radius,cor_eddies.adens,'ss_diazc_vint104','/Volumes/d1/larrya/public_html/0pt1/0pt1_run14/t.14.',1,0);
[diat_bio_a,diat_bio_m,diat_bio_c,diat_bio_t]= pop_comps(cor_eddies.x,cor_eddies.y,cor_eddies.cyc,cor_eddies.k,cor_eddies.id,cor_eddies.track_jday,cor_eddies.radius,cor_eddies.adens,'ss_diatc_vint104','/Volumes/d1/larrya/public_html/0pt1/0pt1_run14/t.14.',1,0);
save -append pop_cor_feb_4

% % % %%Nuts
[nh4_a,nh4_m,nh4_c,nh4_t]= pop_comps_mat(cor_eddies.x,cor_eddies.y,cor_eddies.cyc,cor_eddies.k,cor_eddies.id,cor_eddies.track_jday,cor_eddies.radius,cor_eddies.adens,'bp26_nh4',1,'n');
[no3_a,no3_m,no3_c,no3_t]= pop_comps_mat(cor_eddies.x,cor_eddies.y,cor_eddies.cyc,cor_eddies.k,cor_eddies.id,cor_eddies.track_jday,cor_eddies.radius,cor_eddies.adens,'bp26_no3',1,'n');
[po4_a,mpo4_m,po4_c,po4_t]= pop_comps_mat(cor_eddies.x,cor_eddies.y,cor_eddies.cyc,cor_eddies.k,cor_eddies.id,cor_eddies.track_jday,cor_eddies.radius,cor_eddies.adens,'bp26_po4',1,'n');
save -append pop_cor_feb_4

% %%Nuts
[tnh4_a,tnh4_m,tnh4_c,tnh4_t]= pop_comps(cor_eddies.x,cor_eddies.y,cor_eddies.cyc,cor_eddies.k,cor_eddies.id,cor_eddies.track_jday,cor_eddies.radius,cor_eddies.adens,'nh4_1to20','/Volumes/d1/larrya/public_html/0pt1/output_run14/t.14.',1,0);
[tno3_a,tno3_m,tno3_c,tno3_t]= pop_comps(cor_eddies.x,cor_eddies.y,cor_eddies.cyc,cor_eddies.k,cor_eddies.id,cor_eddies.track_jday,cor_eddies.radius,cor_eddies.adens,'no3_1to20','/Volumes/d1/larrya/public_html/0pt1/output_run14/t.14.',1,0);
[tpo4_a,tpo4_m,tpo4_c,tpo4_t]= pop_comps(cor_eddies.x,cor_eddies.y,cor_eddies.cyc,cor_eddies.k,cor_eddies.id,cor_eddies.track_jday,cor_eddies.radius,cor_eddies.adens,'po4_1to20','/Volumes/d1/larrya/public_html/0pt1/output_run14/t.14.',1,0);

save -append pop_cor_feb_4

% %%% Vertical Advection
[small_vadv_a,dd,small_vadv_c,dd]= pop_comps(cor_eddies.x,cor_eddies.y,cor_eddies.cyc,cor_eddies.k,cor_eddies.id,cor_eddies.track_jday,cor_eddies.radius,cor_eddies.adens,'vadv_spc_vint104','/Volumes/d1/larrya/public_html/0pt1/0pt1_run14/t.14.',1,0);
[diaz_vadv_a,dd,diaz_vadv_c,dd]= pop_comps(cor_eddies.x,cor_eddies.y,cor_eddies.cyc,cor_eddies.k,cor_eddies.id,cor_eddies.track_jday,cor_eddies.radius,cor_eddies.adens,'vadv_diazc_vint104','/Volumes/d1/larrya/public_html/0pt1/0pt1_run14/t.14.',1,0);
[diat_vadv_a,dd,diat_vadv_c,dd]= pop_comps(cor_eddies.x,cor_eddies.y,cor_eddies.cyc,cor_eddies.k,cor_eddies.id,cor_eddies.track_jday,cor_eddies.radius,cor_eddies.adens,'vadv_diatc_vint104','/Volumes/d1/larrya/public_html/0pt1/0pt1_run14/t.14.',1,0);
% 
save -append pop_cor_feb_4
% % return
% %%% Horizontal Advection
% [small_hadv_a,dd,small_hadv_c,dd]= pop_comps(cor_eddies.x,cor_eddies.y,cor_eddies.cyc,cor_eddies.k,cor_eddies.id,cor_eddies.track_jday,cor_eddies.radius,cor_eddies.adens,'hadv_spc_vint104','/Volumes/d1/larrya/public_html/0pt1/0pt1_run14/t.14.',1,0);
% [diaz_hadv_a,dd,diaz_hadv_c,dd]= pop_comps(cor_eddies.x,cor_eddies.y,cor_eddies.cyc,cor_eddies.k,cor_eddies.id,cor_eddies.track_jday,cor_eddies.radius,cor_eddies.adens,'hadv_diazc_vint104','/Volumes/d1/larrya/public_html/0pt1/0pt1_run14/t.14.',1,0);
% [diat_hadv_a,dd,diat_hadv_c,dd]= pop_comps(cor_eddies.x,cor_eddies.y,cor_eddies.cyc,cor_eddies.k,cor_eddies.id,cor_eddies.track_jday,cor_eddies.radius,cor_eddies.adens,'hadv_diatc_vint104','/Volumes/d1/larrya/public_html/0pt1/0pt1_run14/t.14.',1,0);

%%% Primary Production
[small_pp_a,dd,small_pp_c,dd]= pop_comps(cor_eddies.x,cor_eddies.y,cor_eddies.cyc,cor_eddies.k,cor_eddies.id,cor_eddies.track_jday,cor_eddies.radius,cor_eddies.adens,'photoc_sp_vint104','/Volumes/d1/larrya/public_html/0pt1/0pt1_run14/t.14.',1,0);
[diaz_pp_a,dd,diaz_pp_c,dd]= pop_comps(cor_eddies.x,cor_eddies.y,cor_eddies.cyc,cor_eddies.k,cor_eddies.id,cor_eddies.track_jday,cor_eddies.radius,cor_eddies.adens,'photoc_diaz_vint104','/Volumes/d1/larrya/public_html/0pt1/0pt1_run14/t.14.',1,0);
[diat_pp_a,dd,diat_pp_c,dd]= pop_comps(cor_eddies.x,cor_eddies.y,cor_eddies.cyc,cor_eddies.k,cor_eddies.id,cor_eddies.track_jday,cor_eddies.radius,cor_eddies.adens,'photoc_diat_vint104','/Volumes/d1/larrya/public_html/0pt1/0pt1_run14/t.14.',1,0);

% % 
% % 
save -append pop_cor_feb_4
% % return
load pop_cor_feb_4

pcomps_cbar(diat_pp_a.mean,norm_ssh_a.mean,[4e-5 5e-4],-1,.1,1,['Diat PP',char(39) char(39),' AC'],1,20)
print -dpng -r300 figs/pop_cor/diat_pp_a
pcomps_cbar(diat_pp_c.mean,norm_ssh_c.mean,[8e-5 4e-4],-1,.1,1,['Diat PP',char(39) char(39),' CC'],1,20)
print -dpng -r300 figs/pop_cor/diat_pp_c

pcomps_cbar(diaz_pp_a.mean,norm_ssh_a.mean,[5e-7 7e-7],-1,.1,1,['Diaz PP',char(39) char(39),' AC'],1,20)
print -dpng -r300 figs/pop_cor/diaz_pp_a
pcomps_cbar(diaz_pp_c.mean,norm_ssh_c.mean,[5e-7 8e-7],-1,.1,1,['Diaz PP',char(39) char(39),' CC'],1,20)
print -dpng -r300 figs/pop_cor/diaz_pp_c

pcomps_cbar(small_pp_a.mean,norm_ssh_a.mean,[3e-4 6.5e-4],-1,.1,1,['Small PP',char(39) char(39),' AC'],1,20)
print -dpng -r300 figs/pop_cor/small_pp_a
pcomps_cbar(small_pp_c.mean,norm_ssh_c.mean,[3e-4 4.5e-4],-1,.1,1,['Small PP',char(39) char(39),' CC'],1,20)
print -dpng -r300 figs/pop_cor/small_pp_c


pcomps_cbar(diat_vadv_a.mean,norm_ssh_a.mean,[-4e-6 4e-6],-1,.1,1,['Diat vadv',char(39) char(39),' AC'],1,20)
print -dpng -r300 figs/pop_cor/diat_vadv_a
pcomps_cbar(diat_vadv_c.mean,norm_ssh_c.mean,[-2e-6 1e-6],-1,.1,1,['Diat vadv',char(39) char(39),' CC'],1,20)
print -dpng -r300 figs/pop_cor/diat_vadv_c

pcomps_cbar(diaz_vadv_a.mean,norm_ssh_a.mean,[-2e-7 2e-7],-1,.1,1,['Diaz vadv',char(39) char(39),' AC'],1,20)
print -dpng -r300 figs/pop_cor/diaz_vadv_a
pcomps_cbar(diaz_vadv_c.mean,norm_ssh_c.mean,[-2e-7 2e-7],-1,.1,1,['Diaz vadv',char(39) char(39),' CC'],1,20)
print -dpng -r300 figs/pop_cor/diaz_vadv_c

pcomps_cbar(small_vadv_a.mean,norm_ssh_a.mean,[-5e-6 5e-6],-1,.1,1,['Small vadv',char(39) char(39),' AC'],1,20)
print -dpng -r300 figs/pop_cor/small_vadv_a
pcomps_cbar(small_vadv_c.mean,norm_ssh_c.mean,[-5e-6 5e-6],-1,.1,1,['Small vadv',char(39) char(39),' CC'],1,20)
print -dpng -r300 figs/pop_cor/small_vadv_c

pcomps_cbar(po4_a.mean,norm_ssh_a.mean,[-.06 .06],-1,.1,1,['PO_4', char(39),' AC'],1,20)
print -dpng -r300 figs/pop_cor/po4_a
pcomps_cbar(po4_c.mean,norm_ssh_c.mean,[-2e-2 2e-2],-1,.1,1,['PO_4', char(39),' CC'],1,20)
print -dpng -r300 figs/pop_cor/po4_c

pcomps_cbar(nh4_a.mean,norm_ssh_a.mean,[-.02 .02],-1,.1,1,['NH_4', char(39),' AC'],1,20)
print -dpng -r300 figs/pop_cor/nh4_a
pcomps_cbar(nh4_c.mean,norm_ssh_c.mean,[-1e-2 1e-2],-1,.1,1,['NH_4', char(39),' CC'],1,20)
print -dpng -r300 figs/pop_cor/nh4_c

pcomps_cbar(no3_a.mean,norm_ssh_a.mean,[-.7 .7],-1,.1,1,['NO_3', char(39),' AC'],1,20)
print -dpng -r300 figs/pop_cor/no3_a
pcomps_cbar(no3_c.mean,norm_ssh_c.mean,[-.4 .4],-1,.1,1,['NO_3', char(39),' CC'],1,20)
print -dpng -r300 figs/pop_cor/no3_c

pcomps_cbar(norm_ssh_a.mean,norm_ssh_a.mean,[-1 1],-1,.1,1,'Normalized SSH AC',1,20)
print -dpng -r300 figs/pop_cor/norm_ssh_a
pcomps_cbar(norm_ssh_c.mean,norm_ssh_c.mean,[-1 1],-1,.1,1,'Normalized SSH CC',1,20)
print -dpng -r300 figs/pop_cor/norm_ssh_c

pcomps_cbar(norm_hp66_c_a.mean,norm_ssh_a.mean,[-200 200],-1,.1,1,['C',char(39) char(39),' AC'],1,20)
print -dpng -r300 figs/pop_cor/norm_c_a
pcomps_cbar(norm_hp66_c_c.mean,norm_ssh_c.mean,[-100 100],-1,.1,1,['C',char(39) char(39),' CC'],1,20)
print -dpng -r300 figs/pop_cor/norm_c_c

pcomps_cbar(norm_hp66_chl_a.mean,norm_ssh_a.mean,[-.75 .75],-1,.1,1,['CHL',char(39) char(39),' AC'],1,20)
print -dpng -r300 figs/pop_cor/norm_chl_a
pcomps_cbar(norm_hp66_chl_c.mean,norm_ssh_c.mean,[-.35 .35],-1,.1,1,['CHL',char(39) char(39),' CC'],1,20)
print -dpng -r300 figs/pop_cor/norm_chl_c

pcomps_cbar(norm_hp66_diaz_c_a.mean,norm_ssh_a.mean,[-.3 .3],-1,.1,1,['DiazC',char(39) char(39),' AC'],1,20)
print -dpng -r300 figs/pop_cor/norm_diaz_a
pcomps_cbar(norm_hp66_diaz_c_c.mean,norm_ssh_c.mean,[-.08 .08],-1,.1,1,['DiazC',char(39) char(39),' CC'],1,20)
print -dpng -r300 figs/pop_cor/norm_diaz_c

pcomps_cbar(norm_hp66_diat_c_a.mean,norm_ssh_a.mean,[-.5 .5],-1,.1,1,['DiatC',char(39) char(39),' AC'],1,20)
print -dpng -r300 figs/pop_cor/norm_diat_a
pcomps_cbar(norm_hp66_diat_c_c.mean,norm_ssh_c.mean,[-.2 .2],-1,.1,1,['DiatC',char(39) char(39),' CC'],1,20)
print -dpng -r300 figs/pop_cor/norm_diat_c

pcomps_cbar(norm_hp66_sp_c_a.mean,norm_ssh_a.mean,[-.25 .25],-1,.1,1,['SmallC',char(39) char(39),' AC'],1,20)
print -dpng -r300 figs/pop_cor/norm_small_a
pcomps_cbar(norm_hp66_sp_c_c.mean,norm_ssh_c.mean,[-.07 .07],-1,.1,1,['SmallC',char(39) char(39),' CC'],1,20)
print -dpng -r300 figs/pop_cor/norm_small_c

pcomps_cbar(small_bio_a.mean,norm_ssh_a.mean,[0 8e-5],-1,.1,1,['Small SS',char(39) char(39),' AC'],1,20)
print -dpng -r300 figs/pop_cor/small_bio_a
pcomps_cbar(small_bio_c.mean,norm_ssh_c.mean,[0 7e-5],-1,.1,1,['Small SS',char(39) char(39),' CC'],1,20)
print -dpng -r300 figs/pop_cor/small_bio_c

pcomps_cbar(diaz_bio_a.mean,norm_ssh_a.mean,[0 3e-7],-1,.1,1,['Diaz SS',char(39) char(39),' AC'],1,20)
print -dpng -r300 figs/pop_cor/diaz_bio_a
pcomps_cbar(diaz_bio_c.mean,norm_ssh_c.mean,[0 4e-7],-1,.1,1,['Diaz SS',char(39) char(39),' CC'],1,20)
print -dpng -r300 figs/pop_cor/diaz_bio_c

pcomps_cbar(diat_bio_a.mean,norm_ssh_a.mean,[0 2.5e-5],-1,.1,1,['Diat SS',char(39) char(39),' AC'],1,20)
print -dpng -r300 figs/pop_cor/diat_bio_a
pcomps_cbar(diat_bio_c.mean,norm_ssh_c.mean,[0 5e-5],-1,.1,1,['Diat SS',char(39) char(39),' CC'],1,20)
print -dpng -r300 figs/pop_cor/diat_bio_c
return



