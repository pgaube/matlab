clear
% 
% load rings_cor_tracks
% ii=find(k<4);
% x=x(ii);y=y(ii);k=k(ii);id=id(ii);track_jday=track_jday(ii);radius=radius(ii);cyc=cyc(ii);adens=adens(ii);
% %%Basic stuff
% [ssh_a,dd,ssh_c,rr]=pop_comps_mat(x,y,cyc,k,id,track_jday,radius,adens,'hp21_ssh',1,'n');
% [norm_ssh_a,dd,norm_ssh_c,rr]=pop_comps_mat(x,y,cyc,k,id,track_jday,radius,adens,'hp21_ssh',1,'nn');
% [norm_hp66_chl_a,dd,norm_hp66_chl_c,rr]=pop_comps_mat(x,y,cyc,k,id,track_jday,radius,adens,'hp66_chl',1,'dd');
% 
% %% Biomass
% [diat_c_a,dd,diat_c_c,rr]=pop_comps_mat(x,y,cyc,k,id,track_jday,radius,adens,'diat_biomass',1,'n');
% [diaz_c_a,dd,diaz_c_c,rr]=pop_comps_mat(x,y,cyc,k,id,track_jday,radius,adens,'diaz_biomass',1,'n');
% [sp_c_a,dd,sp_c_c,rr]=pop_comps_mat(x,y,cyc,k,id,track_jday,radius,adens,'small_biomass',1,'n');
% 
% %% Biomass anomalies
% [norm_hp66_diaz_c_a,dd,norm_hp66_diaz_c_c,rr]=pop_comps_mat(x,y,cyc,k,id,track_jday,radius,adens,'hp66_diaz_biomass',1,'dd_diaz_c');
% [norm_hp66_diat_c_a,dd,norm_hp66_diat_c_c,rr]=pop_comps_mat(x,y,cyc,k,id,track_jday,radius,adens,'hp66_diat_biomass',1,'dd_diat_c');
% [norm_hp66_sp_c_a,dd,norm_hp66_sp_c_c,rr]=pop_comps_mat(x,y,cyc,k,id,track_jday,radius,adens,'hp66_small_biomass',1,'dd_small_c');
% 
% %% Soruces and sinks
% [small_bio_a,dd,small_bio_c,dd]= pop_comps(x,y,cyc,k,id,track_jday,radius,adens,'ss_spc_vint104','/private/d1/larrya/public_html/0pt1/0pt1_run14/t.14.',1,0);
% [diaz_bio_a,dd,diaz_bio_c,dd]= pop_comps(x,y,cyc,k,id,track_jday,radius,adens,'ss_diazc_vint104','/private/d1/larrya/public_html/0pt1/0pt1_run14/t.14.',1,0);
% [diat_bio_a,dd,diat_bio_c,dd]= pop_comps(x,y,cyc,k,id,track_jday,radius,adens,'ss_diatc_vint104','/private/d1/larrya/public_html/0pt1/0pt1_run14/t.14.',1,0);
% 
% 
% %%% Vertical Advection
% [small_vadv_a,dd,small_vadv_c,dd]= pop_comps(x,y,cyc,k,id,track_jday,radius,adens,'vadv_spc_vint104','/private/d1/larrya/public_html/0pt1/0pt1_run14/t.14.',1,0);
% [diaz_vadv_a,dd,diaz_vadv_c,dd]= pop_comps(x,y,cyc,k,id,track_jday,radius,adens,'vadv_diazc_vint104','/private/d1/larrya/public_html/0pt1/0pt1_run14/t.14.',1,0);
% [diat_vadv_a,dd,diat_vadv_c,dd]= pop_comps(x,y,cyc,k,id,track_jday,radius,adens,'vadv_diatc_vint104','/private/d1/larrya/public_html/0pt1/0pt1_run14/t.14.',1,0);
% 
% 
% %%% Horizontal Advection
% [small_hadv_a,dd,small_hadv_c,dd]= pop_comps(x,y,cyc,k,id,track_jday,radius,adens,'hadv_spc_vint104','/private/d1/larrya/public_html/0pt1/0pt1_run14/t.14.',1,0);
% [diaz_hadv_a,dd,diaz_hadv_c,dd]= pop_comps(x,y,cyc,k,id,track_jday,radius,adens,'hadv_diazc_vint104','/private/d1/larrya/public_html/0pt1/0pt1_run14/t.14.',1,0);
% [diat_hadv_a,dd,diat_hadv_c,dd]= pop_comps(x,y,cyc,k,id,track_jday,radius,adens,'hadv_diatc_vint104','/private/d1/larrya/public_html/0pt1/0pt1_run14/t.14.',1,0);
% 
% 
% save -append pop_rings_comps_week_1_3


% % % % load pop_rings_comps
load pop_rings_comps

pcomps_raw2(norm_ssh_a.mean,norm_ssh_a.mean,[-1 1],-1,.1,1,'Normalized SSH AC',1,20)
print -dpng -r300 figs/pop_GS_rings_norm_ssh_a
pcomps_raw2(norm_ssh_c.mean,norm_ssh_c.mean,[-1 1],-1,.1,1,'Normalized SSH CC',1,20)
print -dpng -r300 figs/pop_GS_rings_norm_ssh_c

pcomps_raw2(norm_hp66_chl_a.mean,norm_ssh_a.mean,[-.5 .5],-1,.1,1,['CHL',char(39) char(39),' AC'],1,20)
print -dpng -r300 figs/pop_GS_rings_norm_chl_a
pcomps_raw2(norm_hp66_chl_c.mean,norm_ssh_c.mean,[-.5 .5],-1,.1,1,['CHL',char(39) char(39),' CC'],1,20)
print -dpng -r300 figs/pop_GS_rings_norm_chl_c

pcomps_raw2(norm_hp66_diaz_c_a.mean,norm_ssh_a.mean,[-.1 .1],-1,.1,1,['DiazC',char(39) char(39),' AC'],1,20)
print -dpng -r300 figs/pop_GS_rings_norm_diaz_a
pcomps_raw2(norm_hp66_diaz_c_c.mean,norm_ssh_c.mean,[-.1 .1],-1,.1,1,['DiazC',char(39) char(39),' CC'],1,20)
print -dpng -r300 figs/pop_GS_rings_norm_diaz_c

pcomps_raw2(norm_hp66_diat_c_a.mean,norm_ssh_a.mean,[-.3 .3],-1,.1,1,['DiatC',char(39) char(39),' AC'],1,20)
print -dpng -r300 figs/pop_GS_rings_norm_diat_a
pcomps_raw2(norm_hp66_diat_c_c.mean,norm_ssh_c.mean,[-.3 .3],-1,.1,1,['DiatC',char(39) char(39),' CC'],1,20)
print -dpng -r300 figs/pop_GS_rings_norm_diat_c

pcomps_raw2(norm_hp66_sp_c_a.mean,norm_ssh_a.mean,[-.07 .07],-1,.1,1,['SmallC',char(39) char(39),' AC'],1,20)
print -dpng -r300 figs/pop_GS_rings_norm_small_a
pcomps_raw2(norm_hp66_sp_c_c.mean,norm_ssh_c.mean,[-.07 .07],-1,.1,1,['SmallC',char(39) char(39),' CC'],1,20)
print -dpng -r300 figs/pop_GS_rings_norm_small_c

pcomps_raw2(small_bio_a.mean,norm_ssh_a.mean,[0 6e-5],-1,.1,1,['Small SS',char(39) char(39),' AC'],1,20)
print -dpng -r300 figs/pop_GS_rings_small_bio_a
pcomps_raw2(small_bio_c.mean,norm_ssh_c.mean,[0 6e-5],-1,.1,1,['Small SS',char(39) char(39),' CC'],1,20)
print -dpng -r300 figs/pop_GS_rings_small_bio_c

pcomps_raw2(diaz_bio_a.mean,norm_ssh_a.mean,[0 1.6e-7],-1,.1,1,['Diaz SS',char(39) char(39),' AC'],1,20)
print -dpng -r300 figs/pop_GS_rings_diaz_bio_a
pcomps_raw2(diaz_bio_c.mean,norm_ssh_c.mean,[0 1.6e-7],-1,.1,1,['Diaz SS',char(39) char(39),' CC'],1,20)
print -dpng -r300 figs/pop_GS_rings_diaz_bio_c

pcomps_raw2(diat_bio_a.mean,norm_ssh_a.mean,[5e-6 1.3e-5],-1,.1,1,['Diat SS',char(39) char(39),' AC'],1,20)
print -dpng -r300 figs/pop_GS_rings_diat_bio_a
pcomps_raw2(diat_bio_c.mean,norm_ssh_c.mean,[5e-6 2e-5],-1,.1,1,['Diat SS',char(39) char(39),' CC'],1,20)
print -dpng -r300 figs/pop_GS_rings_diat_bio_c

pcomps_raw2(diat_vadv_a.mean,norm_ssh_a.mean,[-2e-6 2e-6],-1,.1,1,['Diat vadv',char(39) char(39),' AC'],1,20)
print -dpng -r300 figs/pop_GS_rings_diat_vadv_a
pcomps_raw2(diat_vadv_c.mean,norm_ssh_c.mean,[-5e-6 5e-6],-1,.1,1,['Diat vadv',char(39) char(39),' CC'],1,20)
print -dpng -r300 figs/pop_GS_rings_diat_vadv_c

pcomps_raw2(diaz_vadv_a.mean,norm_ssh_a.mean,[-2e-7 2e-7],-1,.1,1,['Diaz vadv',char(39) char(39),' AC'],1,20)
print -dpng -r300 figs/pop_GS_rings_diaz_vadv_a
pcomps_raw2(diaz_vadv_c.mean,norm_ssh_c.mean,[-2e-7 2e-7],-1,.1,1,['Diaz vadv',char(39) char(39),' CC'],1,20)
print -dpng -r300 figs/pop_GS_rings_diaz_vadv_c

pcomps_raw2(small_vadv_a.mean,norm_ssh_a.mean,[-5e-6 5e-6],-1,.1,1,['Small vadv',char(39) char(39),' AC'],1,20)
print -dpng -r300 figs/pop_GS_rings_small_vadv_a
pcomps_raw2(small_vadv_c.mean,norm_ssh_c.mean,[-5e-6 5e-6],-1,.1,1,['Small vadv',char(39) char(39),' CC'],1,20)
print -dpng -r300 figs/pop_GS_rings_small_vadv_c

pcomps_raw2(diat_hadv_a.mean,norm_ssh_a.mean,[-8e-6 8e-6],-1,.1,1,['Diat hadv',char(39) char(39),' AC'],1,20)
print -dpng -r300 figs/pop_GS_rings_diat_hadv_a
pcomps_raw2(diat_hadv_c.mean,norm_ssh_c.mean,[-1e-5 1e-5],-1,.1,1,['Diat hadv',char(39) char(39),' CC'],1,20)
print -dpng -r300 figs/pop_GS_rings_diat_hadv_c
% return
pcomps_raw2(diaz_hadv_a.mean,norm_ssh_a.mean,[-2e-7 2e-7],-1,.1,1,['Diaz hadv',char(39) char(39),' AC'],1,20)
print -dpng -r300 figs/pop_GS_rings_diaz_hadv_a
pcomps_raw2(diaz_hadv_c.mean,norm_ssh_c.mean,[-2e-7 2e-7],-1,.1,1,['Diaz hadv',char(39) char(39),' CC'],1,20)
print -dpng -r300 figs/pop_GS_rings_diaz_hadv_c
% return
pcomps_raw2(small_hadv_a.mean,norm_ssh_a.mean,[-8e-6 8e-6],-1,.1,1,['Small hadv',char(39) char(39),' AC'],1,20)
print -dpng -r300 figs/pop_GS_rings_small_hadv_a
pcomps_raw2(small_hadv_c.mean,norm_ssh_c.mean,[-8e-6 8e-6],-1,.1,1,['Small hadv',char(39) char(39),' CC'],1,20)
print -dpng -r300 figs/pop_GS_rings_small_hadv_c




