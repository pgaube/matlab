clear

% % % load GS_rings_tracks_run14_jan_5
% % % 
% % % warm_id=515;
% % % % cold_id=[389 500 625 795 1091];
% % % 
% % % cold_id=[720 813 857 1044];
% % % 
% % % ii=find(pop_eddies.id==warm_id);
% % % x=pop_eddies.x(ii);
% % % y=pop_eddies.y(ii);
% % % k=pop_eddies.k(ii);
% % % id=pop_eddies.id(ii);
% % % cyc=pop_eddies.cyc(ii);
% % % track_jday=pop_eddies.track_jday(ii);
% % % radius=pop_eddies.radius(ii);
% % % 
% % % 
% % % ii=find(pop_eddies.id==cold_id(1));
% % % tx=pop_eddies.x(ii)
% % % ty=pop_eddies.y(ii);
% % % tk=pop_eddies.k(ii);
% % % tid=pop_eddies.id(ii);
% % % tcyc=pop_eddies.cyc(ii);
% % % ttack_jday=pop_eddies.track_jday(ii);
% % % tradius=pop_eddies.radius(ii);
% % % 
% % % for m=2:length(cold_id)
% % %     
% % %     ii=find(pop_eddies.id==cold_id(m));
% % %     tx=cat(2,tx,pop_eddies.x(ii));
% % %     ty=cat(2,ty,pop_eddies.y(ii));
% % %     tk=cat(2,tk,pop_eddies.k(ii));
% % %     tid=cat(2,tid,pop_eddies.id(ii));
% % %     tcyc=cat(2,tcyc,pop_eddies.cyc(ii));
% % %     ttack_jday=cat(2,ttack_jday,pop_eddies.track_jday(ii));
% % %     tradius=cat(2,tradius,pop_eddies.radius(ii));
% % % end
% % % 
% % % tid(1:end)=1;
% % % 
% % % 
% % % new_jd=min(ttack_jday):max(ttack_jday)
% % % 
% % % tx=interp1(ttack_jday,tx,new_jd);
% % % ty=interp1(ttack_jday,ty,new_jd);
% % % tk=interp1(ttack_jday,tk,new_jd);
% % % tcyc=interp1(ttack_jday,tcyc,new_jd);
% % % tid=interp1(ttack_jday,tid,new_jd);
% % % tradius=interp1(ttack_jday,tradius,new_jd);
% % % ttack_jday=new_jd;
% % % 
% % % x=cat(2,x,tx);
% % % y=cat(2,y,ty);
% % % k=cat(2,k,tk);
% % % id=cat(2,id,tid);
% % % cyc=cat(2,cyc,tcyc);
% % % track_jday=cat(2,track_jday,ttack_jday);
% % % radius=cat(2,radius,tradius);
% % % adens=nan*x;
% % % adens(cyc==1)=-1;
% % % adens(cyc==-1)=1;
% % % 
% % % figure(1)
% % % clf
% % % pmap(min(pop_eddies.x):max(pop_eddies.x),min(pop_eddies.y):max(pop_eddies.y),nan(length(min(pop_eddies.y):max(pop_eddies.y)),length(min(pop_eddies.x):max(pop_eddies.x))))
% % % hold on
% % % 
% % % ii=find(id==warm_id);
% % % m_plot(x(ii),y(ii),'r')
% % % m_plot(x(ii(1)),y(ii(1)),'r.','markersize',15)
% % % 
% % % ii=find(id==1);
% % % m_plot(x(ii),y(ii),'b')
% % % m_plot(x(ii(1)),y(ii(1)),'b.','markersize',15)
% % % 
% % % clearallbut x y id cyc k track_jday radius adens warm_id cold_id
% % % 
% % % 
% % % save case_study_tracks 
load case_study_tracks 
% [chl_orgin_a,chl_orgin_c]=pop_comps_rel_orgin_mat(x,y,cyc,k,id,track_jday,50,'total_chl');
% [ssh_orgin_a,ssh_orgin_c]=pop_comps_rel_orgin_mat(x,y,cyc,k,id,track_jday,50,'ssh');
% 
% [small_c_orgin_a,small_c_orgin_c]=pop_comps_rel_orgin_mat(x,y,cyc,k,id,track_jday,50,'small_biomass');
% [diat_c_orgin_a,diat_c_orgin_c]=pop_comps_rel_orgin_mat(x,y,cyc,k,id,track_jday,50,'diat_biomass');
% [diaz_c_orgin_a,diaz_c_orgin_c]=pop_comps_rel_orgin_mat(x,y,cyc,k,id,track_jday,50,'diaz_biomass');

% [nh4_orgin_a,nh4_orgin_c]=pop_comps_rel_orgin_mat(x,y,cyc,k,id,track_jday,50,'bp26_nh4');
% [no3_orgin_a,no3_orgin_c]=pop_comps_rel_orgin_mat(x,y,cyc,k,id,track_jday,50,'bp26_no3');
% [po4_orgin_a,po4_orgin_c]=pop_comps_rel_orgin_mat(x,y,cyc,k,id,track_jday,50,'bp26_po4');
% % 
% [tnh4_orgin_a,tnh4_orgin_c]=pop_comps_rel_orgin(x,y,cyc,k,id,track_jday,50,'nh4_1to20','/Volumes/d1/larrya/public_html/0pt1/output_run14/t.14.');
% [tno3_orgin_a,tno3_orgin_c]=pop_comps_rel_orgin(x,y,cyc,k,id,track_jday,50,'no3_1to20','/Volumes/d1/larrya/public_html/0pt1/output_run14/t.14.');
% [tpo4_orgin_a,tpo4_orgin_c]=pop_comps_rel_orgin(x,y,cyc,k,id,track_jday,50,'po4_1to20','/Volumes/d1/larrya/public_html/0pt1/output_run14/t.14.');

% [hp_small_c_orgin_a,hp_small_c_orgin_c]=pop_comps_rel_orgin_mat(x,y,cyc,k,id,track_jday,50,'hp66_small_biomass');
% [hp_diat_c_orgin_a,hp_diat_c_orgin_c]=pop_comps_rel_orgin_mat(x,y,cyc,k,id,track_jday,50,'hp66_diat_biomass');
% [hp_diaz_c_orgin_a,hp_diaz_c_orgin_c]=pop_comps_rel_orgin_mat(x,y,cyc,k,id,track_jday,50,'hp66_diaz_biomass');
% 
% [bio_small_orgin_a,bio_small_orgin_c]=pop_comps_rel_orgin(x,y,cyc,k,id,track_jday,50,'ss_spc_vint104','/Volumes/d1/larrya/public_html/0pt1/0pt1_run14/t.14.');
% [bio_diat_orgin_a,bio_diat_orgin_c]=pop_comps_rel_orgin(x,y,cyc,k,id,track_jday,50,'ss_diatc_vint104','/Volumes/d1/larrya/public_html/0pt1/0pt1_run14/t.14.');
% [bio_diaz_orgin_a,bio_diaz_orgin_c]=pop_comps_rel_orgin(x,y,cyc,k,id,track_jday,50,'ss_diazc_vint104','/Volumes/d1/larrya/public_html/0pt1/0pt1_run14/t.14.');
% save case_study_pop_comps_orgi
% save -append case_study_pop_comps
% return
% 
% % % %%Basic stuff
% [ssh_a,dd,ssh_c,rr]=pop_comps_mat(x,y,cyc,k,id,track_jday,radius,adens,'hp21_ssh',1,'nn');
% [ssh_a,dd,ssh_c,rr]=pop_comps_mat(x,y,cyc,k,id,track_jday,radius,adens,'hp21_ssh',1,'n');
% [norm_hp66_chl_a,dd,norm_hp66_chl_c,rr]=pop_comps_mat(x,y,cyc,k,id,track_jday,radius,adens,'hp66_chl',1,'dd');
% [norm_hp66_c_a,dd,norm_hp66_c_c,rr]=pop_comps_mat(x,y,cyc,k,id,track_jday,radius,adens,'hp66_biomass',1,'dd');
% [w_a,dd,w_c,dd]= pop_comps(x,y,cyc,k,id,track_jday,radius,adens,'wvel_104','/Volumes/d1/larrya/public_html/0pt1/output_run14/t.14.',1,0);
% % 
% % % %% Biomass
% [diat_c_a,dd,diat_c_c,rr]=pop_comps_mat(x,y,cyc,k,id,track_jday,radius,adens,'diat_biomass',1,'n');
% [diaz_c_a,dd,diaz_c_c,rr]=pop_comps_mat(x,y,cyc,k,id,track_jday,radius,adens,'diaz_biomass',1,'n');
% [sp_c_a,dd,sp_c_c,rr]=pop_comps_mat(x,y,cyc,k,id,track_jday,radius,adens,'small_biomass',1,'n');
% % % % 
% % % Biomass anomalies
% [norm_hp66_diaz_c_a,dd,norm_hp66_diaz_c_c,rr]=pop_comps_mat(x,y,cyc,k,id,track_jday,radius,adens,'hp66_diaz_biomass',1,'dd_diaz_c');
% [norm_hp66_diat_c_a,dd,norm_hp66_diat_c_c,rr]=pop_comps_mat(x,y,cyc,k,id,track_jday,radius,adens,'hp66_diat_biomass',1,'dd_diat_c');
% [norm_hp66_sp_c_a,dd,norm_hp66_sp_c_c,rr]=pop_comps_mat(x,y,cyc,k,id,track_jday,radius,adens,'hp66_small_biomass',1,'dd_small_c');
% % % % % 
% save -append case_study_pop_comps
% % return
% %%Sources/sinks
% [small_bio_a,small_bio_m,small_bio_c,small_bio_t]= pop_comps(x,y,cyc,k,id,track_jday,radius,adens,'ss_spc_vint104','/Volumes/d1/larrya/public_html/0pt1/0pt1_run14/t.14.',1,0);
% [diaz_bio_a,diaz_bio_m,diaz_bio_c,diaz_bio_t]= pop_comps(x,y,cyc,k,id,track_jday,radius,adens,'ss_diazc_vint104','/Volumes/d1/larrya/public_html/0pt1/0pt1_run14/t.14.',1,0);
% [diat_bio_a,diat_bio_m,diat_bio_c,diat_bio_t]= pop_comps(x,y,cyc,k,id,track_jday,radius,adens,'ss_diatc_vint104','/Volumes/d1/larrya/public_html/0pt1/0pt1_run14/t.14.',1,0);
% % % % % % 
% % % % %%Nuts
% [nh4_a,nh4_m,nh4_c,nh4_t]= pop_comps_mat(x,y,cyc,k,id,track_jday,radius,adens,'bp26_nh4',1,'n');
% [no3_a,no3_m,no3_c,no3_t]= pop_comps_mat(x,y,cyc,k,id,track_jday,radius,adens,'bp26_no3',1,'n');
% [po4_a,mpo4_m,po4_c,po4_t]= pop_comps_mat(x,y,cyc,k,id,track_jday,radius,adens,'bp26_po4',1,'n');
% save -append case_study_pop_comps
% % % % return
% 
% % % %%Nuts
% [tnh4_a,tnh4_m,tnh4_c,tnh4_t]= pop_comps(x,y,cyc,k,id,track_jday,radius,adens,'nh4_1to20','/Volumes/d1/larrya/public_html/0pt1/output_run14/t.14.',1,0);
% [tno3_a,tno3_m,tno3_c,tno3_t]= pop_comps(x,y,cyc,k,id,track_jday,radius,adens,'no3_1to20','/Volumes/d1/larrya/public_html/0pt1/output_run14/t.14.',1,0);
% [tpo4_a,tpo4_m,tpo4_c,tpo4_t]= pop_comps(x,y,cyc,k,id,track_jday,radius,adens,'po4_1to20','/Volumes/d1/larrya/public_html/0pt1/output_run14/t.14.',1,0);
% save -append case_study_pop_comps
% % % return
% % % % % %% Loss
% % % % [small_graze_a,small_graze_m,small_graze_c,small_graze_t]= pop_comps(x,y,cyc,k,id,track_jday,radius,adens,'graze_sp_vint','~/matlab/pop/netcdf/t.14.',1,0);
% % % % [diaz_graze_a,diaz_graze_m,diaz_graze_c,diaz_graze_t]= pop_comps(x,y,cyc,k,id,track_jday,radius,adens,'graze_diaz_vint','~/matlab/pop/netcdf/t.14.',1,0);
% % % % [diat_graze_a,diat_graze_m,diat_graze_c,diat_graze_t]= pop_comps(x,y,cyc,k,id,track_jday,radius,adens,'graze_diat_vint','~/matlab/pop/netcdf/t.14.',1,0);
% 
% % %%% Vertical Advection
% [small_vadv_a,dd,small_vadv_c,dd]= pop_comps(x,y,cyc,k,id,track_jday,radius,adens,'vadv_spc_vint104','/Volumes/d1/larrya/public_html/0pt1/0pt1_run14/t.14.',1,0);
% [diaz_vadv_a,dd,diaz_vadv_c,dd]= pop_comps(x,y,cyc,k,id,track_jday,radius,adens,'vadv_diazc_vint104','/Volumes/d1/larrya/public_html/0pt1/0pt1_run14/t.14.',1,0);
% [diat_vadv_a,dd,diat_vadv_c,dd]= pop_comps(x,y,cyc,k,id,track_jday,radius,adens,'vadv_diatc_vint104','/Volumes/d1/larrya/public_html/0pt1/0pt1_run14/t.14.',1,0);
% % 
% save -append case_study_pop_comps
% % return
% %%% Horizontal Advection
% [small_hadv_a,dd,small_hadv_c,dd]= pop_comps(x,y,cyc,k,id,track_jday,radius,adens,'hadv_spc_vint104','/Volumes/d1/larrya/public_html/0pt1/0pt1_run14/t.14.',1,0);
% [diaz_hadv_a,dd,diaz_hadv_c,dd]= pop_comps(x,y,cyc,k,id,track_jday,radius,adens,'hadv_diazc_vint104','/Volumes/d1/larrya/public_html/0pt1/0pt1_run14/t.14.',1,0);
% [diat_hadv_a,dd,diat_hadv_c,dd]= pop_comps(x,y,cyc,k,id,track_jday,radius,adens,'hadv_diatc_vint104','/Volumes/d1/larrya/public_html/0pt1/0pt1_run14/t.14.',1,0);
% 
% %%% Primary Production
% [small_pp_a,dd,small_pp_c,dd]= pop_comps(x,y,cyc,k,id,track_jday,radius,adens,'photoc_sp_vint104','/Volumes/d1/larrya/public_html/0pt1/0pt1_run14/t.14.',1,0);
% [diaz_pp_a,dd,diaz_pp_c,dd]= pop_comps(x,y,cyc,k,id,track_jday,radius,adens,'photoc_diaz_vint104','/Volumes/d1/larrya/public_html/0pt1/0pt1_run14/t.14.',1,0);
% [diat_pp_a,dd,diat_pp_c,dd]= pop_comps(x,y,cyc,k,id,track_jday,radius,adens,'photoc_diat_vint104','/Volumes/d1/larrya/public_html/0pt1/0pt1_run14/t.14.',1,0);
% 
% % % 
% % % 
% save -append case_study_pop_comps
% return
load case_study_pop_comps

pcomps_cbar(diaz_c_a.mean,ssh_a.mean,[.1 1.3],-100,5,100,['DiazC',char(39) char(39),' AC'],1,20)
print -dpng -r300 figs/pop_case_study/diaz_a
pcomps_cbar(diaz_c_c.mean,ssh_c.mean,[1.28 1.44],-100,5,100,['DiazC',char(39) char(39),' CC'],1,20)
print -dpng -r300 figs/pop_case_study/diaz_c

pcomps_cbar(diat_c_a.mean,ssh_a.mean,[10 120],-100,5,100,['DiatC',char(39) char(39),' AC'],1,20)
print -dpng -r300 figs/pop_case_study/diat_a
pcomps_cbar(diat_c_c.mean,ssh_c.mean,[12 20],-100,5,100,['DiatC',char(39) char(39),' CC'],1,20)
print -dpng -r300 figs/pop_case_study/diat_c

pcomps_cbar(sp_c_a.mean,ssh_a.mean,[80 130],-100,5,100,['SmallC',char(39) char(39),' AC'],1,20)
print -dpng -r300 figs/pop_case_study/small_a
pcomps_cbar(sp_c_c.mean,ssh_c.mean,[60 93],-100,5,100,['SmallC',char(39) char(39),' CC'],1,20)
print -dpng -r300 figs/pop_case_study/small_c

% return
pcomps_cbar(tpo4_a.mean,ssh_a.mean,[2e-2 2.3e-1],-100,5,100,['PO_4', char(39),' AC'],1,20)
print -dpng -r300 figs/pop_case_study/tpo4_a
pcomps_cbar(tpo4_c.mean,ssh_c.mean,[1e-4 3e-3],-100,5,100,['PO_4', char(39),' CC'],1,20)
print -dpng -r300 figs/pop_case_study/tpo4_c
% return
pcomps_cbar(tnh4_a.mean,ssh_a.mean,[.01 .1],-100,5,100,['NH_4', char(39),' AC'],1,20)
print -dpng -r300 figs/pop_case_study/tnh4_a
pcomps_cbar(tnh4_c.mean,ssh_c.mean,[.02 .05],-100,5,100,['NH_4', char(39),' CC'],1,20)
print -dpng -r300 figs/pop_case_study/tnh4_c
% return
pcomps_cbar(tno3_a.mean,ssh_a.mean,[.2 3],-100,5,100,['NO_3', char(39),' AC'],1,20)
print -dpng -r300 figs/pop_case_study/tno3_a
pcomps_cbar(tno3_c.mean,ssh_c.mean,[.03 .2],-100,5,100,['NO_3', char(39),' CC'],1,20)
print -dpng -r300 figs/pop_case_study/tno3_c
% return


pcomps_cbar(diat_pp_a.mean,ssh_a.mean,[4e-5 5e-4],-100,5,100,['Diat PP',char(39) char(39),' AC'],1,20)
print -dpng -r300 figs/pop_case_study/diat_pp_a
pcomps_cbar(diat_pp_c.mean,ssh_c.mean,[7e-6 5e-5],-100,5,100,['Diat PP',char(39) char(39),' CC'],1,20)
print -dpng -r300 figs/pop_case_study/diat_pp_c

pcomps_cbar(diaz_pp_a.mean,ssh_a.mean,[2e-8 1e-6],-100,5,100,['Diaz PP',char(39) char(39),' AC'],1,20)
print -dpng -r300 figs/pop_case_study/diaz_pp_a
pcomps_cbar(diaz_pp_c.mean,ssh_c.mean,[4e-7 5e-7],-100,5,100,['Diaz PP',char(39) char(39),' CC'],1,20)
print -dpng -r300 figs/pop_case_study/diaz_pp_c

pcomps_cbar(small_pp_a.mean,ssh_a.mean,[3e-4 1.2e-3],-100,5,100,['Small PP',char(39) char(39),' AC'],1,20)
print -dpng -r300 figs/pop_case_study/small_pp_a
pcomps_cbar(small_pp_c.mean,ssh_c.mean,[1e-4 3.5e-4],-100,5,100,['Small PP',char(39) char(39),' CC'],1,20)
print -dpng -r300 figs/pop_case_study/small_pp_c

pcomps_cbar(diat_vadv_a.mean,ssh_a.mean,[-4e-6 4e-6],-100,5,100,['Diat vadv',char(39) char(39),' AC'],1,20)
print -dpng -r300 figs/pop_case_study/diat_vadv_a
pcomps_cbar(diat_vadv_c.mean,ssh_c.mean,[-2e-6 1e-6],-100,5,100,['Diat vadv',char(39) char(39),' CC'],1,20)
print -dpng -r300 figs/pop_case_study/diat_vadv_c

pcomps_cbar(diaz_vadv_a.mean,ssh_a.mean,[-2e-7 2e-7],-100,5,100,['Diaz vadv',char(39) char(39),' AC'],1,20)
print -dpng -r300 figs/pop_case_study/diaz_vadv_a
pcomps_cbar(diaz_vadv_c.mean,ssh_c.mean,[-2e-7 2e-7],-100,5,100,['Diaz vadv',char(39) char(39),' CC'],1,20)
print -dpng -r300 figs/pop_case_study/diaz_vadv_c

pcomps_cbar(small_vadv_a.mean,ssh_a.mean,[-5e-6 5e-6],-100,5,100,['Small vadv',char(39) char(39),' AC'],1,20)
print -dpng -r300 figs/pop_case_study/small_vadv_a
pcomps_cbar(small_vadv_c.mean,ssh_c.mean,[-5e-6 5e-6],-100,5,100,['Small vadv',char(39) char(39),' CC'],1,20)
print -dpng -r300 figs/pop_case_study/small_vadv_c


% pcomps_cbar(small_graze_a.mean,ssh_a.mean,[.2e-3 .45e-3],-100,5,100,['Grazing on Small Phyto', char(39),' AC'],1,20)
% print -dpng -r300 figs/pop_case_study/small_graze_a
% 
% pcomps_cbar(small_graze_c.mean,ssh_c.mean,[.2e-3 .45e-3],-100,5,100,['Grazing on Small Phyto', char(39),' CC'],1,20)
% print -dpng -r300 figs/pop_case_study/small_graze_c
% 
% pcomps_cbar(diaz_graze_a.mean,ssh_a.mean,[.1e-8 1e-8],-100,5,100,['Grazing on Diaz Phyto', char(39),' AC'],1,20)
% print -dpng -r300 figs/pop_case_study/diaz_graze_a
% 
% pcomps_cbar(diaz_graze_c.mean,ssh_c.mean,[.1e-8 1e-8],-100,5,100,['Grazing on Diaz Phyto', char(39),' CC'],1,20)
% print -dpng -r300 figs/pop_case_study/diaz_graze_c
% 
% pcomps_cbar(small_graze_a.mean,ssh_a.mean,[4e-5 4e-4],-100,5,100,['Grazing on Diat Phyto', char(39),' AC'],1,20)
% print -dpng -r300 figs/pop_case_study/diat_graze_a
% 
% pcomps_cbar(diat_graze_c.mean,ssh_c.mean,[1e-5 2.5e-4],-100,5,100,['Grazing on Diat Phyto', char(39),' CC'],1,20)
% print -dpng -r300 figs/pop_case_study/diat_graze_c
% 

pcomps_cbar(po4_a.mean,ssh_a.mean,[-.06 .06],-100,5,100,['PO_4', char(39),' AC'],1,20)
print -dpng -r300 figs/pop_case_study/po4_a
pcomps_cbar(po4_c.mean,ssh_c.mean,[-2e-3 2e-3],-100,5,100,['PO_4', char(39),' CC'],1,20)
print -dpng -r300 figs/pop_case_study/po4_c

pcomps_cbar(nh4_a.mean,ssh_a.mean,[-.02 .02],-100,5,100,['NH_4', char(39),' AC'],1,20)
print -dpng -r300 figs/pop_case_study/nh4_a
pcomps_cbar(nh4_c.mean,ssh_c.mean,[-6e-3 6e-3],-100,5,100,['NH_4', char(39),' CC'],1,20)
print -dpng -r300 figs/pop_case_study/nh4_c

pcomps_cbar(no3_a.mean,ssh_a.mean,[-.7 .7],-100,5,100,['NO_3', char(39),' AC'],1,20)
print -dpng -r300 figs/pop_case_study/no3_a
pcomps_cbar(no3_c.mean,ssh_c.mean,[-.04 .04],-100,5,100,['NO_3', char(39),' CC'],1,20)
print -dpng -r300 figs/pop_case_study/no3_c

pcomps_cbar(ssh_a.mean,ssh_a.mean,[-1 1],-100,5,100,'Normalized SSH AC',1,20)
print -dpng -r300 figs/pop_case_study/ssh_a
pcomps_cbar(ssh_c.mean,ssh_c.mean,[-1 1],-100,5,100,'Normalized SSH CC',1,20)
print -dpng -r300 figs/pop_case_study/ssh_c

pcomps_cbar(norm_hp66_c_a.mean,ssh_a.mean,[-200 200],-100,5,100,['C',char(39) char(39),' AC'],1,20)
print -dpng -r300 figs/pop_case_study/norm_c_a
pcomps_cbar(norm_hp66_c_c.mean,ssh_c.mean,[-100 100],-100,5,100,['C',char(39) char(39),' CC'],1,20)
print -dpng -r300 figs/pop_case_study/norm_c_c

pcomps_cbar(norm_hp66_chl_a.mean,ssh_a.mean,[-.75 .75],-100,5,100,['CHL',char(39) char(39),' AC'],1,20)
print -dpng -r300 figs/pop_case_study/norm_chl_a
pcomps_cbar(norm_hp66_chl_c.mean,ssh_c.mean,[-.35 .35],-100,5,100,['CHL',char(39) char(39),' CC'],1,20)
print -dpng -r300 figs/pop_case_study/norm_chl_c

pcomps_cbar(norm_hp66_diaz_c_a.mean,ssh_a.mean,[-.3 .3],-100,5,100,['DiazC',char(39) char(39),' AC'],1,20)
print -dpng -r300 figs/pop_case_study/norm_diaz_a
pcomps_cbar(norm_hp66_diaz_c_c.mean,ssh_c.mean,[-.08 .08],-100,5,100,['DiazC',char(39) char(39),' CC'],1,20)
print -dpng -r300 figs/pop_case_study/norm_diaz_c

pcomps_cbar(norm_hp66_diat_c_a.mean,ssh_a.mean,[-.5 .5],-100,5,100,['DiatC',char(39) char(39),' AC'],1,20)
print -dpng -r300 figs/pop_case_study/norm_diat_a
pcomps_cbar(norm_hp66_diat_c_c.mean,ssh_c.mean,[-.2 .2],-100,5,100,['DiatC',char(39) char(39),' CC'],1,20)
print -dpng -r300 figs/pop_case_study/norm_diat_c

pcomps_cbar(norm_hp66_sp_c_a.mean,ssh_a.mean,[-.25 .25],-100,5,100,['SmallC',char(39) char(39),' AC'],1,20)
print -dpng -r300 figs/pop_case_study/norm_small_a
pcomps_cbar(norm_hp66_sp_c_c.mean,ssh_c.mean,[-.07 .07],-100,5,100,['SmallC',char(39) char(39),' CC'],1,20)
print -dpng -r300 figs/pop_case_study/norm_small_c

pcomps_cbar(small_bio_a.mean,ssh_a.mean,[-1.1e-4 1.1e-4],-100,5,100,['Small SS',char(39) char(39),' AC'],1,20)
print -dpng -r300 figs/pop_case_study/small_bio_a
pcomps_cbar(small_bio_c.mean,ssh_c.mean,[-3e-5 3e-5],-100,5,100,['Small SS',char(39) char(39),' CC'],1,20)
print -dpng -r300 figs/pop_case_study/small_bio_c

pcomps_cbar(diaz_bio_a.mean,ssh_a.mean,[-3e-7 3e-7],-100,5,100,['Diaz SS',char(39) char(39),' AC'],1,20)
print -dpng -r300 figs/pop_case_study/diaz_bio_a
pcomps_cbar(diaz_bio_c.mean,ssh_c.mean,[-1e-7 1e-7],-100,5,100,['Diaz SS',char(39) char(39),' CC'],1,20)
print -dpng -r300 figs/pop_case_study/diaz_bio_c

pcomps_cbar(diat_bio_a.mean,ssh_a.mean,[-2.5e-5 2.5e-5],-100,5,100,['Diat SS',char(39) char(39),' AC'],1,20)
print -dpng -r300 figs/pop_case_study/diat_bio_a
pcomps_cbar(diat_bio_c.mean,ssh_c.mean,[-2e-6 2e-6],-100,5,100,['Diat SS',char(39) char(39),' CC'],1,20)
print -dpng -r300 figs/pop_case_study/diat_bio_c
return



