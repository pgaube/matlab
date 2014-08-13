clear
% 
% 
load GS_core_eddies_run14_sla
% 
% ii=find(stream_eddies.age>=12);
% stream_eddies.x=stream_eddies.x(ii);
% stream_eddies.y=stream_eddies.y(ii);
% stream_eddies.cyc=stream_eddies.cyc(ii);
% stream_eddies.radius=stream_eddies.radius(ii);
% stream_eddies.k=stream_eddies.k(ii);
% stream_eddies.id=stream_eddies.id(ii);
% stream_eddies.track_jday=stream_eddies.track_jday(ii);
% stream_eddies.adens=stream_eddies.adens(ii);
% 

% % %%relative to orgin
% [hp_chl_orgin_a,hp_chl_orgin_c]=pop_comps_rel_orgin_mat(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,50,'hp66_chl');
% [chl_orgin_a,chl_orgin_c]=pop_comps_rel_orgin_mat(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,50,'total_chl');
% [ssh_orgin_a,ssh_orgin_c]=pop_comps_rel_orgin_mat(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,50,'ssh');
% 
% [small_c_orgin_a,small_c_orgin_c]=pop_comps_rel_orgin_mat(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,50,'small_biomass');
% [diat_c_orgin_a,diat_c_orgin_c]=pop_comps_rel_orgin_mat(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,50,'diat_biomass');
% [diaz_c_orgin_a,diaz_c_orgin_c]=pop_comps_rel_orgin_mat(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,50,'diaz_biomass');
% 
% % 
% [hp_small_c_orgin_a,hp_small_c_orgin_c]=pop_comps_rel_orgin_mat(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,50,'hp66_small_biomass');
% [hp_diat_c_orgin_a,hp_diat_c_orgin_c]=pop_comps_rel_orgin_mat(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,50,'hp66_diat_biomass');
% [hp_diaz_c_orgin_a,hp_diaz_c_orgin_c]=pop_comps_rel_orgin_mat(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,50,'hp66_diaz_biomass');
% 
% [nh4_orgin_a,nh4_orgin_c]=pop_comps_rel_orgin_mat(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,50,'bp26_nh4');
% [no3_orgin_a,no3_orgin_c]=pop_comps_rel_orgin_mat(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,50,'bp26_no3');
% [po4_orgin_a,po4_orgin_c]=pop_comps_rel_orgin_mat(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,50,'bp26_po4');
% 
% [tnh4_orgin_a,tnh4_orgin_c]=pop_comps_rel_orgin(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,50,'nh4_1to20','/Volumes/d1/larrya/public_html/0pt1/output_run14/t.14.');
% [tno3_orgin_a,tno3_orgin_c]=pop_comps_rel_orgin(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,50,'no3_1to20','/Volumes/d1/larrya/public_html/0pt1/output_run14/t.14.');
% [tpo4_orgin_a,tpo4_orgin_c]=pop_comps_rel_orgin(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,50,'po4_1to20','/Volumes/d1/larrya/public_html/0pt1/output_run14/t.14.');
% % 
% [bio_small_orgin_a,bio_small_orgin_c]=pop_comps_rel_orgin(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,50,'ss_spc_vint104','/Volumes/d1/larrya/public_html/0pt1/0pt1_run14/t.14.');
% [bio_diat_orgin_a,bio_diat_orgin_c]=pop_comps_rel_orgin(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,50,'ss_diatc_vint104','/Volumes/d1/larrya/public_html/0pt1/0pt1_run14/t.14.');
% [bio_diaz_orgin_a,bio_diaz_orgin_c]=pop_comps_rel_orgin(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,50,'ss_diazc_vint104','/Volumes/d1/larrya/public_html/0pt1/0pt1_run14/t.14.');
% save -append pop_stream_sla

% %%Basic stuff
% [norm_ssh_a,dd,norm_ssh_c,rr]=pop_comps_mat(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'hp21_ssh',1,'nn');
% [ssh_a,dd,ssh_c,rr]=pop_comps_mat(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'hp21_ssh',1,'n');
% [norm_hp66_chl_a,dd,norm_hp66_chl_c,rr]=pop_comps_mat(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'hp66_chl',1,'dd');
[hp66_chl_a,dd,hp66_chl_c,rr]=pop_comps_mat(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'hp66_chl',1,'n');
% [chl_a,dd,chl_c,rr]=pop_comps_mat(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'total_chl',1,'nn');
% [hp66_pp_a,dd,hp66_pp_c,rr]=pop_comps_mat(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'hp66_pp',1,'n');
% [norm_hp66_pp_a,dd,norm_hp66_pp_c,rr]=pop_comps_mat(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'hp66_pp',1,'pp');
% [norm_hp66_pp_a,dd,norm_hp66_c_c,rr]=pop_comps_mat(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'hp66_biomass',1,'cc');
% [w_a,dd,w_c,dd]= pop_comps(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'wvel_104','/Volumes/d1/larrya/public_html/0pt1/output_run14/t.14.',1,0);
% [vadv_no3_a,dd,vadv_no3_c,dd]= pop_comps(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'vadv_no3_1to20','/Volumes/d1/larrya/public_html/0pt1/0pt1_run14/t.14.',1,0);

save -append pop_stream_sla
return

%%% vertical
[z_biomass_a,z_biomass_c]=pop_comps_z(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,'z_total_biomass',1);
save -append pop_stream_sla

% 
% % %% Biomass
[diat_c_a,dd,diat_c_c,rr]=pop_comps_mat(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'diat_biomass',1,'n');
[diaz_c_a,dd,diaz_c_c,rr]=pop_comps_mat(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'diaz_biomass',1,'n');
[sp_c_a,dd,sp_c_c,rr]=pop_comps_mat(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'small_biomass',1,'n');
save -append pop_stream_sla

% % Biomass anomalies
[norm_hp66_diaz_c_a,dd,norm_hp66_diaz_c_c,rr]=pop_comps_mat(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'hp66_diaz_biomass',1,'dd_diaz_c');
[norm_hp66_diat_c_a,dd,norm_hp66_diat_c_c,rr]=pop_comps_mat(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'hp66_diat_biomass',1,'dd_diat_c');
[norm_hp66_sp_c_a,dd,norm_hp66_sp_c_c,rr]=pop_comps_mat(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'hp66_small_biomass',1,'dd_small_c');
save -append pop_stream_sla


%%Sources/sinks
[small_bio_a,small_bio_m,small_bio_c,small_bio_t]= pop_comps(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'ss_spc_vint104','/Volumes/d1/larrya/public_html/0pt1/0pt1_run14/t.14.',1,0);
[diaz_bio_a,diaz_bio_m,diaz_bio_c,diaz_bio_t]= pop_comps(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'ss_diazc_vint104','/Volumes/d1/larrya/public_html/0pt1/0pt1_run14/t.14.',1,0);
[diat_bio_a,diat_bio_m,diat_bio_c,diat_bio_t]= pop_comps(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'ss_diatc_vint104','/Volumes/d1/larrya/public_html/0pt1/0pt1_run14/t.14.',1,0);
save -append pop_stream_sla

%%diff
[small_hdif_a,small_hdif_m,small_hdif_c,small_bio_t]= pop_comps(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'hdif_spc_vint104','/Volumes/d1/larrya/public_html/0pt1/0pt1_run14/t.14.',1,0);
[diaz_hdif_a,diaz_hdif_m,diaz_hdif_c,diaz_hdif_t]= pop_comps(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'hdif_diazc_vint104','/Volumes/d1/larrya/public_html/0pt1/0pt1_run14/t.14.',1,0);
[diat_hdif_a,diat_hdif_m,diat_hdif_c,diat_hdif_t]= pop_comps(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'hdif_diatc_vint104','/Volumes/d1/larrya/public_html/0pt1/0pt1_run14/t.14.',1,0);
save -append pop_stream_sla

[small_vdif_a,small_vdif_m,small_vdif_c,small_bio_t]= pop_comps(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'vdif_spc_vint104','/Volumes/d1/larrya/public_html/0pt1/0pt1_run14/t.14.',1,0);
[diaz_vdif_a,diaz_vdif_m,diaz_vdif_c,diaz_vdif_t]= pop_comps(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'vdif_diazc_vint104','/Volumes/d1/larrya/public_html/0pt1/0pt1_run14/t.14.',1,0);
[diat_vdif_a,diat_vdif_m,diat_vdif_c,diat_vdif_t]= pop_comps(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'vdif_diatc_vint104','/Volumes/d1/larrya/public_html/0pt1/0pt1_run14/t.14.',1,0);
save -append pop_stream_sla

% % %%Nuts
[nh4_a,nh4_m,nh4_c,nh4_t]= pop_comps_mat(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'bp26_nh4',1,'n');
[no3_a,no3_m,no3_c,no3_t]= pop_comps_mat(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'bp26_no3',1,'n');
[po4_a,mpo4_m,po4_c,po4_t]= pop_comps_mat(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'bp26_po4',1,'n');
save -append pop_stream_sla

% % % %%Nuts
[tnh4_a,tnh4_m,tnh4_c,tnh4_t]= pop_comps(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'nh4_1to20','/Volumes/d1/larrya/public_html/0pt1/output_run14/t.14.',1,0);
[tno3_a,tno3_m,tno3_c,tno3_t]= pop_comps(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'no3_1to20','/Volumes/d1/larrya/public_html/0pt1/output_run14/t.14.',1,0);
[tpo4_a,tpo4_m,tpo4_c,tpo4_t]= pop_comps(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'po4_1to20','/Volumes/d1/larrya/public_html/0pt1/output_run14/t.14.',1,0);
[ss_no3_a,ss_no3_m,ss_no3_c,ss_no3_t]= pop_comps(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'ss_no3_1to20','/Volumes/d1/larrya/public_html/0pt1/0pt1_run14/t.14.',1,0);
% 
save -append pop_stream_sla
% % 
% % % %%% Vertical Advection
[small_vadv_a,dd,small_vadv_c,dd]= pop_comps(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'vadv_spc_vint104','/Volumes/d1/larrya/public_html/0pt1/0pt1_run14/t.14.',1,0);
[diaz_vadv_a,dd,diaz_vadv_c,dd]= pop_comps(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'vadv_diazc_vint104','/Volumes/d1/larrya/public_html/0pt1/0pt1_run14/t.14.',1,0);
[diat_vadv_a,dd,diat_vadv_c,dd]= pop_comps(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'vadv_diatc_vint104','/Volumes/d1/larrya/public_html/0pt1/0pt1_run14/t.14.',1,0);
% 
save -append pop_stream_sla
% % % % return
% % % %%% Horizontal Advection
[small_hadv_a,dd,small_hadv_c,dd]= pop_comps(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'hadv_spc_vint104','/Volumes/d1/larrya/public_html/0pt1/0pt1_run14/t.14.',1,0);
[diaz_hadv_a,dd,diaz_hadv_c,dd]= pop_comps(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'hadv_diazc_vint104','/Volumes/d1/larrya/public_html/0pt1/0pt1_run14/t.14.',1,0);
[diat_hadv_a,dd,diat_hadv_c,dd]= pop_comps(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'hadv_diatc_vint104','/Volumes/d1/larrya/public_html/0pt1/0pt1_run14/t.14.',1,0);

% % %%% Primary Production
[small_pp_a,dd,small_pp_c,dd]= pop_comps(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'photoc_sp_vint104','/Volumes/d1/larrya/public_html/0pt1/0pt1_run14/t.14.',1,0);
[diaz_pp_a,dd,diaz_pp_c,dd]= pop_comps(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'photoc_diaz_vint104','/Volumes/d1/larrya/public_html/0pt1/0pt1_run14/t.14.',1,0);
[diat_pp_a,dd,diat_pp_c,dd]= pop_comps(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'photoc_diat_vint104','/Volumes/d1/larrya/public_html/0pt1/0pt1_run14/t.14.',1,0);

% % % % 
% % % % 
save -append pop_stream_sla
return
load pop_stream_sla
pcomps_cbar(diaz_c_a.mean,ssh_a.mean,[1 1.35],-50,5,50,['DiazC',char(39) char(39),' AC'],1,20)
print -dpng -r300 figs/pop_stream/diaz_a
pcomps_cbar(diaz_c_c.mean,ssh_c.mean,[1 1.35],-50,5,50,['DiazC',char(39) char(39),' CC'],1,20)
print -dpng -r300 figs/pop_stream/diaz_c

pcomps_cbar(diat_c_a.mean,ssh_a.mean,[15 80],-50,5,50,['DiatC',char(39) char(39),' AC'],1,20)
print -dpng -r300 figs/pop_stream/diat_a
pcomps_cbar(diat_c_c.mean,ssh_c.mean,[15 50],-50,5,50,['DiatC',char(39) char(39),' CC'],1,20)
print -dpng -r300 figs/pop_stream/diat_c
% return
pcomps_cbar(sp_c_a.mean,ssh_a.mean,[77 93],-50,5,50,['SmallC',char(39) char(39),' AC'],1,20)
print -dpng -r300 figs/pop_stream/small_a
pcomps_cbar(sp_c_c.mean,ssh_c.mean,[77 95],-50,5,50,['SmallC',char(39) char(39),' CC'],1,20)
print -dpng -r300 figs/pop_stream/small_c
% return
% return

pcomps_cbar(tpo4_a.mean,ssh_a.mean,[4e-2 1.5e-1],-50,5,50,['PO_4', char(39),' AC'],1,20)
print -dpng -r300 figs/pop_stream/tpo4_a
pcomps_cbar(tpo4_c.mean,ssh_c.mean,[4e-2 1e-1],-50,5,50,['PO_4', char(39),' CC'],1,20)
print -dpng -r300 figs/pop_stream/tpo4_c
% return
pcomps_cbar(tnh4_a.mean,ssh_a.mean,[.02 .1],-50,5,50,['NH_4', char(39),' AC'],1,20)
print -dpng -r300 figs/pop_stream/tnh4_a
pcomps_cbar(tnh4_c.mean,ssh_c.mean,[.02 .06],-50,5,50,['NH_4', char(39),' CC'],1,20)
print -dpng -r300 figs/pop_stream/tnh4_c
% return
pcomps_cbar(tno3_a.mean,ssh_a.mean,[.7 2.3],-50,5,50,['NO_3', char(39),' AC'],1,20)
print -dpng -r300 figs/pop_stream/tno3_a
pcomps_cbar(tno3_c.mean,ssh_c.mean,[.5 1.4],-50,5,50,['NO_3', char(39),' CC'],1,20)
print -dpng -r300 figs/pop_stream/tno3_c
% return

pcomps_cbar(diat_hdif_a.mean,ssh_a.mean,[-3e-6 3e-6],-50,5,50,['Diat h-diff',char(39) char(39),' AC'],1,20)
print -dpng -r300 figs/pop_stream/diat_hdif
pcomps_cbar(diat_hdif_c.mean,ssh_c.mean,[-3e-6 3e-6],-50,5,50,['Diat h-diff',char(39) char(39),' CC'],1,20)
print -dpng -r300 figs/pop_stream/diat_hdif

pcomps_cbar(small_hdif_a.mean,ssh_a.mean,[-3e-6 3e-6],-50,5,50,['small h-diff',char(39) char(39),' AC'],1,20)
print -dpng -r300 figs/pop_stream/small_hdif
pcomps_cbar(diat_hdif_c.mean,ssh_c.mean,[-3e-6 3e-6],-50,5,50,['small h-diff',char(39) char(39),' CC'],1,20)
print -dpng -r300 figs/pop_stream/small_hdif

pcomps_cbar(diaz_hdif_a.mean,ssh_a.mean,[-3e-7 3e-7],-50,5,50,['diaz h-diff',char(39) char(39),' AC'],1,20)
print -dpng -r300 figs/pop_stream/diaz_hdif
pcomps_cbar(diaz_hdif_c.mean,ssh_c.mean,[-3e-7 3e-7],-50,5,50,['diaz h-diff',char(39) char(39),' CC'],1,20)
print -dpng -r300 figs/pop_stream/diaz_hdif


pcomps_cbar(diat_pp_a.mean,ssh_a.mean,[4.5e-5 5.2e-4],-50,5,50,['Diat PP',char(39) char(39),' AC'],1,20)
print -dpng -r300 figs/pop_stream/diat_pp_a
pcomps_cbar(diat_pp_c.mean,ssh_c.mean,[8e-5 3e-4],-50,5,50,['Diat PP',char(39) char(39),' CC'],1,20)
print -dpng -r300 figs/pop_stream/diat_pp_c

pcomps_cbar(diaz_pp_a.mean,ssh_a.mean,[5e-7 7e-7],-50,5,50,['Diaz PP',char(39) char(39),' AC'],1,20)
print -dpng -r300 figs/pop_stream/diaz_pp_a
pcomps_cbar(diaz_pp_c.mean,ssh_c.mean,[5e-7 7e-7],-50,5,50,['Diaz PP',char(39) char(39),' CC'],1,20)
print -dpng -r300 figs/pop_stream/diaz_pp_c

pcomps_cbar(small_pp_a.mean,ssh_a.mean,[3e-4 5e-4],-50,5,50,['Small PP',char(39) char(39),' AC'],1,20)
print -dpng -r300 figs/pop_stream/small_pp_a
pcomps_cbar(small_pp_c.mean,ssh_c.mean,[3e-4 4e-4],-50,5,50,['Small PP',char(39) char(39),' CC'],1,20)
print -dpng -r300 figs/pop_stream/small_pp_c


pcomps_cbar(diat_vadv_a.mean,ssh_a.mean,[-4e-6 4e-6],-50,5,50,['Diat vadv',char(39) char(39),' AC'],1,20)
print -dpng -r300 figs/pop_stream/diat_vadv_a
pcomps_cbar(diat_vadv_c.mean,ssh_c.mean,[-2e-6 1e-6],-50,5,50,['Diat vadv',char(39) char(39),' CC'],1,20)
print -dpng -r300 figs/pop_stream/diat_vadv_c

pcomps_cbar(diaz_vadv_a.mean,ssh_a.mean,[-2e-7 2e-7],-50,5,50,['Diaz vadv',char(39) char(39),' AC'],1,20)
print -dpng -r300 figs/pop_stream/diaz_vadv_a
pcomps_cbar(diaz_vadv_c.mean,ssh_c.mean,[-2e-7 2e-7],-50,5,50,['Diaz vadv',char(39) char(39),' CC'],1,20)
print -dpng -r300 figs/pop_stream/diaz_vadv_c

pcomps_cbar(small_vadv_a.mean,ssh_a.mean,[-5e-6 5e-6],-50,5,50,['Small vadv',char(39) char(39),' AC'],1,20)
print -dpng -r300 figs/pop_stream/small_vadv_a
pcomps_cbar(small_vadv_c.mean,ssh_c.mean,[-5e-6 5e-6],-50,5,50,['Small vadv',char(39) char(39),' CC'],1,20)
print -dpng -r300 figs/pop_stream/small_vadv_c

pcomps_cbar(po4_a.mean,ssh_a.mean,[-.06 .06],-50,5,50,['PO_4', char(39),' AC'],1,20)
print -dpng -r300 figs/pop_stream/po4_a
pcomps_cbar(po4_c.mean,ssh_c.mean,[-3e-2 3e-2],-50,5,50,['PO_4', char(39),' CC'],1,20)
print -dpng -r300 figs/pop_stream/po4_c

pcomps_cbar(nh4_a.mean,ssh_a.mean,[-.02 .02],-50,5,50,['NH_4', char(39),' AC'],1,20)
print -dpng -r300 figs/pop_stream/nh4_a
pcomps_cbar(nh4_c.mean,ssh_c.mean,[-1e-2 1e-2],-50,5,50,['NH_4', char(39),' CC'],1,20)
print -dpng -r300 figs/pop_stream/nh4_c

pcomps_cbar(no3_a.mean,ssh_a.mean,[-.4 .4],-50,5,50,['NO_3', char(39),' AC'],1,20)
print -dpng -r300 figs/pop_stream/no3_a
pcomps_cbar(no3_c.mean,ssh_c.mean,[-.4 .4],-50,5,50,['NO_3', char(39),' CC'],1,20)
print -dpng -r300 figs/pop_stream/no3_c
% return
pcomps_cbar(ssh_a.mean,ssh_a.mean,[-1 1],-50,5,50,'Normalized SSH AC',1,20)
print -dpng -r300 figs/pop_stream/ssh_a
pcomps_cbar(ssh_c.mean,ssh_c.mean,[-1 1],-50,5,50,'Normalized SSH CC',1,20)
print -dpng -r300 figs/pop_stream/ssh_c

pcomps_cbar(norm_hp66_c_a.mean,ssh_a.mean,[-150 150],-50,5,50,['C',char(39) char(39),' AC'],1,20)
print -dpng -r300 figs/pop_stream/norm_c_a
pcomps_cbar(norm_hp66_c_c.mean,ssh_c.mean,[-100 100],-50,5,50,['C',char(39) char(39),' CC'],1,20)
print -dpng -r300 figs/pop_stream/norm_c_c

pcomps_cbar(norm_hp66_chl_a.mean,ssh_a.mean,[-.75 .75],-50,5,50,['CHL',char(39) char(39),' AC'],1,20)
print -dpng -r300 figs/pop_stream/norm_chl_a
pcomps_cbar(norm_hp66_chl_c.mean,ssh_c.mean,[-.4 .4],-50,5,50,['CHL',char(39) char(39),' CC'],1,20)
print -dpng -r300 figs/pop_stream/norm_chl_c

pcomps_cbar(norm_hp66_diaz_c_a.mean,ssh_a.mean,[-.05 .05],-50,5,50,['DiazC',char(39) char(39),' AC'],1,20)
print -dpng -r300 figs/pop_stream/norm_diaz_a
pcomps_cbar(norm_hp66_diaz_c_c.mean,ssh_c.mean,[-.05 .05],-50,5,50,['DiazC',char(39) char(39),' CC'],1,20)
print -dpng -r300 figs/pop_stream/norm_diaz_c

pcomps_cbar(norm_hp66_diat_c_a.mean,ssh_a.mean,[-.2 .2],-50,5,50,['DiatC',char(39) char(39),' AC'],1,20)
print -dpng -r300 figs/pop_stream/norm_diat_a
pcomps_cbar(norm_hp66_diat_c_c.mean,ssh_c.mean,[-.2 .2],-50,5,50,['DiatC',char(39) char(39),' CC'],1,20)
print -dpng -r300 figs/pop_stream/norm_diat_c

pcomps_cbar(norm_hp66_sp_c_a.mean,ssh_a.mean,[-.05 .05],-50,5,50,['SmallC',char(39) char(39),' AC'],1,20)
print -dpng -r300 figs/pop_stream/norm_small_a
pcomps_cbar(norm_hp66_sp_c_c.mean,ssh_c.mean,[-.05 .05],-50,5,50,['SmallC',char(39) char(39),' CC'],1,20)
print -dpng -r300 figs/pop_stream/norm_small_c

pcomps_cbar(small_bio_a.mean,ssh_a.mean,[0 5e-5],-50,5,50,['Small SS',char(39) char(39),' AC'],1,20)
print -dpng -r300 figs/pop_stream/small_bio_a
pcomps_cbar(small_bio_c.mean,ssh_c.mean,[0 5e-5],-50,5,50,['Small SS',char(39) char(39),' CC'],1,20)
print -dpng -r300 figs/pop_stream/small_bio_c

pcomps_cbar(diaz_bio_a.mean,ssh_a.mean,[0 1.2e-7],-50,5,50,['Diaz SS',char(39) char(39),' AC'],1,20)
print -dpng -r300 figs/pop_stream/diaz_bio_a
pcomps_cbar(diaz_bio_c.mean,ssh_c.mean,[0 2e-7],-50,5,50,['Diaz SS',char(39) char(39),' CC'],1,20)
print -dpng -r300 figs/pop_stream/diaz_bio_c

pcomps_cbar(diat_bio_a.mean,ssh_a.mean,[0 2.3e-5],-50,5,50,['Diat SS',char(39) char(39),' AC'],1,20)
print -dpng -r300 figs/pop_stream/diat_bio_a
pcomps_cbar(diat_bio_c.mean,ssh_c.mean,[0 3e-5],-50,5,50,['Diat SS',char(39) char(39),' CC'],1,20)
print -dpng -r300 figs/pop_stream/diat_bio_c
return



