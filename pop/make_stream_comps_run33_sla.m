clear
% 
% 
load GS_core_eddies_run33_sla
% % 
% % ii=find(stream_eddies.age>=12);
% % stream_eddies.x=stream_eddies.x(ii);
% % stream_eddies.y=stream_eddies.y(ii);
% % stream_eddies.cyc=stream_eddies.cyc(ii);
% % stream_eddies.radius=stream_eddies.radius(ii);
% % stream_eddies.k=stream_eddies.k(ii);
% % stream_eddies.id=stream_eddies.id(ii);
% % stream_eddies.track_jday=stream_eddies.track_jday(ii);
% % stream_eddies.adens=stream_eddies.adens(ii);
% % 
% 
% % %%relative to orgin
% [hp_chl_orgin_a,hp_chl_orgin_c]=pop_comps_rel_orgin_mat_run33(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,50,'hp66_chl');
% [chl_orgin_a,chl_orgin_c]=pop_comps_rel_orgin_mat_run33(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,50,'total_chl');
% [ssh_orgin_a,ssh_orgin_c]=pop_comps_rel_orgin_mat_run33(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,50,'ssh');
% % save -append pop_stream_run33
% 
% [small_c_orgin_a,small_c_orgin_c]=pop_comps_rel_orgin_mat_run33(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,50,'small_biomass');
% [diat_c_orgin_a,diat_c_orgin_c]=pop_comps_rel_orgin_mat_run33(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,50,'diat_biomass');
% [diaz_c_orgin_a,diaz_c_orgin_c]=pop_comps_rel_orgin_mat_run33(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,50,'diaz_biomass');
% % % 
% % 
% % % [tnh4_orgin_a,tnh4_orgin_c]=pop_comps_rel_orgin(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,50,'nh4_1to20','/Volumes/d1/larrya/public_html/0pt1/output_run33/t.33.');
% % [tno3_orgin_a,tno3_orgin_c]=pop_comps_rel_orgin_run33(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,50,'no3_1to20','/Volumes/d1/larrya/public_html/0pt1/output_run33/t.33.');
% % % [tpo4_orgin_a,tpo4_orgin_c]=pop_comps_rel_orgin(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,50,'po4_1to20','/Volumes/d1/larrya/public_html/0pt1/output_run33/t.33.');
% % save -append pop_stream_run33
% % 
% % %% Biomass
% % [diat_c_a,dd,diat_c_c,rr]=pop_comps_mat_run33(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'diat_biomass',1,'n');
% % [diaz_c_a,dd,diaz_c_c,rr]=pop_comps_mat_run33(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'diaz_biomass',1,'n');
% % [sp_c_a,dd,sp_c_c,rr]=pop_comps_mat_run33(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'small_biomass',1,'n');
% 
% [tno3_a,tno3_m,tno3_c,tno3_t]= pop_comps(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'no3_1to20','/Volumes/d1/larrya/public_html/0pt1/output_run33/t.33.',1,0);
% [w_a,dd,w_c,dd]= pop_comps(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'wvel_104','/Volumes/d1/larrya/public_html/0pt1/output_run33/t.33.',1,0);

% 
% % % % % %%Basic stuff
% [vadv_no3_a,dd,vadv_no3_c,dd]= pop_comps(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'vadv_no3_1to20','/Volumes/d1/larrya/public_html/0pt1/0pt1_run33/t.33.',1,0);
% [norm_ssh_a,dd,norm_ssh_c,rr]=pop_comps_mat_run33(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'hp21_ssh',1,'nn');
% % % [ssh_a,dd,ssh_c,rr]=pop_comps_mat_run33(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'hp21_ssh',1,'n');
[hp66_chl_a,dd,hp66_chl_c,rr]=pop_comps_mat_run33(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'hp66_chl',1,'n');
% [norm_hp66_chl_a,dd,norm_hp66_chl_c,rr]=pop_comps_mat_run33(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'hp66_chl',1,'dd');
% [chl_a,dd,chl_c,rr]=pop_comps_mat_run33(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'total_chl',1,'nn');
% [norm_hp66_c_a,dd,norm_hp66_c_c,rr]=pop_comps_mat_run33(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'sp66_car',1,'cc');
% [hp66_pp_a,dd,hp66_pp_c,rr]=pop_comps_mat_run33(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'hp66_pp',1,'n');
% % % [w_a,dd,w_c,dd]= pop_comps(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'wvel_104','/Volumes/d1/larrya/public_html/0pt1/output_run33/t.33.',1,0);
save -append pop_stream_run33
return
% 
load pop_stream_run33
pcomps_cbar(diaz_c_a.mean,ssh_a.mean,[1 1.35],-50,5,50,['DiazC',char(39) char(39),' AC'],1,20)
print -dpng -r300 figs/pop_stream_run33/diaz_a
pcomps_cbar(diaz_c_c.mean,ssh_c.mean,[1 1.35],-50,5,50,['DiazC',char(39) char(39),' CC'],1,20)
print -dpng -r300 figs/pop_stream_run33/diaz_c

pcomps_cbar(diat_c_a.mean,ssh_a.mean,[15 80],-50,5,50,['DiatC',char(39) char(39),' AC'],1,20)
print -dpng -r300 figs/pop_stream_run33/diat_a
pcomps_cbar(diat_c_c.mean,ssh_c.mean,[15 50],-50,5,50,['DiatC',char(39) char(39),' CC'],1,20)
print -dpng -r300 figs/pop_stream_run33/diat_c


pcomps_cbar(sp_c_a.mean,ssh_a.mean,[77 93],-50,5,50,['SmallC',char(39) char(39),' AC'],1,20)
print -dpng -r300 figs/pop_stream_run33/small_a
pcomps_cbar(sp_c_c.mean,ssh_c.mean,[77 95],-50,5,50,['SmallC',char(39) char(39),' CC'],1,20)
print -dpng -r300 figs/pop_stream_run33/small_c

% 
% pcomps_cbar(tno3_a.mean,ssh_a.mean,[.7 2.3],-50,5,50,['NO_3', char(39),' AC'],1,20)
% print -dpng -r300 figs/pop_stream_run33/tno3_a
% pcomps_cbar(tno3_c.mean,ssh_c.mean,[.5 1.4],-50,5,50,['NO_3', char(39),' CC'],1,20)
% print -dpng -r300 figs/pop_stream_run33/tno3_c

pcomps_cbar(ssh_a.mean,ssh_a.mean,[-1 1],-50,5,50,'Normalized SSH AC',1,20)
print -dpng -r300 figs/pop_stream_run33/ssh_a
pcomps_cbar(ssh_c.mean,ssh_c.mean,[-1 1],-50,5,50,'Normalized SSH CC',1,20)
print -dpng -r300 figs/pop_stream_run33/ssh_c



