clear
% 

load GS_core_eddies_run14_sla

ii=find(stream_eddies.age>=12);
stream_eddies.x=stream_eddies.x(ii);
stream_eddies.y=stream_eddies.y(ii);
stream_eddies.cyc=stream_eddies.cyc(ii);
stream_eddies.radius=stream_eddies.radius(ii);
stream_eddies.k=stream_eddies.k(ii);
stream_eddies.id=stream_eddies.id(ii);
stream_eddies.track_jday=stream_eddies.track_jday(ii);
stream_eddies.adens=stream_eddies.adens(ii);
% 
% % 
% % %% Biomass
% [diat_c_a,dd,diat_c_c,rr]=pop_comps_mat(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'diat_biomass',1,'n');
% [diaz_c_a,dd,diaz_c_c,rr]=pop_comps_mat(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'diaz_biomass',1,'n');
% [sp_c_a,dd,sp_c_c,rr]=pop_comps_mat(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'small_biomass',1,'n');
% save -append pop_stream_12_weeks
% 
% %%Sources/sinks
% [small_bio_a,small_bio_m,small_bio_c,small_bio_t]= pop_comps(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'ss_spc_vint104','/Volumes/d1/larrya/public_html/0pt1/0pt1_run14/t.14.',1,0);
% [diaz_bio_a,diaz_bio_m,diaz_bio_c,diaz_bio_t]= pop_comps(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'ss_diazc_vint104','/Volumes/d1/larrya/public_html/0pt1/0pt1_run14/t.14.',1,0);
% [diat_bio_a,diat_bio_m,diat_bio_c,diat_bio_t]= pop_comps(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'ss_diatc_vint104','/Volumes/d1/larrya/public_html/0pt1/0pt1_run14/t.14.',1,0);
% save -append pop_stream_12_weeks
% 
% %%diff
% [small_hdif_a,small_hdif_m,small_hdif_c,small_bio_t]= pop_comps(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'hdif_spc_vint104','/Volumes/d1/larrya/public_html/0pt1/0pt1_run14/t.14.',1,0);
% [diaz_hdif_a,diaz_hdif_m,diaz_hdif_c,diaz_hdif_t]= pop_comps(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'hdif_diazc_vint104','/Volumes/d1/larrya/public_html/0pt1/0pt1_run14/t.14.',1,0);
% [diat_hdif_a,diat_hdif_m,diat_hdif_c,diat_hdif_t]= pop_comps(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'hdif_diatc_vint104','/Volumes/d1/larrya/public_html/0pt1/0pt1_run14/t.14.',1,0);
% save -append pop_stream_12_weeks
% 
% [small_vdif_a,small_vdif_m,small_vdif_c,small_bio_t]= pop_comps(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'vdif_spc_vint104','/Volumes/d1/larrya/public_html/0pt1/0pt1_run14/t.14.',1,0);
% [diaz_vdif_a,diaz_vdif_m,diaz_vdif_c,diaz_vdif_t]= pop_comps(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'vdif_diazc_vint104','/Volumes/d1/larrya/public_html/0pt1/0pt1_run14/t.14.',1,0);
% [diat_vdif_a,diat_vdif_m,diat_vdif_c,diat_vdif_t]= pop_comps(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'vdif_diatc_vint104','/Volumes/d1/larrya/public_html/0pt1/0pt1_run14/t.14.',1,0);
% save -append pop_stream_12_weeks
% 
%%Nuts
% [tnh4_a,tnh4_m,tnh4_c,tnh4_t]= pop_comps(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'nh4_1to20','/Volumes/d1/larrya/public_html/0pt1/output_run14/t.14.',1,0);
% [tno3_a,tno3_m,tno3_c,tno3_t]= pop_comps(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'no3_1to20','/Volumes/d1/larrya/public_html/0pt1/output_run14/t.14.',1,0);
% [tpo4_a,tpo4_m,tpo4_c,tpo4_t]= pop_comps(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'po4_1to20','/Volumes/d1/larrya/public_html/0pt1/output_run14/t.14.',1,0);

% [vadv_no3_a,vadv_no3_m,vadv_no3_c,vadv_no3_t]= pop_comps(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'vadv_no3_1to20','/Volumes/d1/larrya/public_html/0pt1/0pt1_run14/t.14.',1,0);
% [vdif_no3_a,vdif_no3_m,vdif_no3_c,vdif_no3_t]= pop_comps(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'vdif_no3_1to20','/Volumes/d1/larrya/public_html/0pt1/0pt1_run14/t.14.',1,0);
% [hdif_no3_a,hdif_no3_m,hdif_no3_c,hdif_no3_t]= pop_comps(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'hdif_no3_1to20','/Volumes/d1/larrya/public_html/0pt1/0pt1_run14/t.14.',1,0);
% [hadv_no3_a,hadv_no3_m,hadv_no3_c,hadv_no3_t]= pop_comps(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'hadv_no3_1to20','/Volumes/d1/larrya/public_html/0pt1/0pt1_run14/t.14.',1,0);
% [ss_no3_a,ss_no3_m,ss_no3_c,ss_no3_t]= pop_comps(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'ss_no3_1to20','/Volumes/d1/larrya/public_html/0pt1/0pt1_run14/t.14.',1,0);
% save -append pop_stream_12_weeks
% 
% %%% Vertical Advection
% [small_vadv_a,dd,small_vadv_c,dd]= pop_comps(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'vadv_spc_vint104','/Volumes/d1/larrya/public_html/0pt1/0pt1_run14/t.14.',1,0);
% [diaz_vadv_a,dd,diaz_vadv_c,dd]= pop_comps(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'vadv_diazc_vint104','/Volumes/d1/larrya/public_html/0pt1/0pt1_run14/t.14.',1,0);
% [diat_vadv_a,dd,diat_vadv_c,dd]= pop_comps(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'vadv_diatc_vint104','/Volumes/d1/larrya/public_html/0pt1/0pt1_run14/t.14.',1,0);
% save -append pop_stream_12_weeks
% 
% %%% Horizontal Advection
% [small_hadv_a,dd,small_hadv_c,dd]= pop_comps(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'hadv_spc_vint104','/Volumes/d1/larrya/public_html/0pt1/0pt1_run14/t.14.',1,0);
% [diaz_hadv_a,dd,diaz_hadv_c,dd]= pop_comps(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'hadv_diazc_vint104','/Volumes/d1/larrya/public_html/0pt1/0pt1_run14/t.14.',1,0);
% [diat_hadv_a,dd,diat_hadv_c,dd]= pop_comps(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'hadv_diatc_vint104','/Volumes/d1/larrya/public_html/0pt1/0pt1_run14/t.14.',1,0);
% 
% %%% Primary Production
% [small_pp_a,dd,small_pp_c,dd]= pop_comps(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'photoc_sp_vint104','/Volumes/d1/larrya/public_html/0pt1/0pt1_run14/t.14.',1,0);
% [diaz_pp_a,dd,diaz_pp_c,dd]= pop_comps(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'photoc_diaz_vint104','/Volumes/d1/larrya/public_html/0pt1/0pt1_run14/t.14.',1,0);
% [diat_pp_a,dd,diat_pp_c,dd]= pop_comps(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'photoc_diat_vint104','/Volumes/d1/larrya/public_html/0pt1/0pt1_run14/t.14.',1,0);
% save -append pop_stream_12_weeks
% 
% % %%% Primary Production
% [small_pp_a,dd,small_pp_c,dd]= pop_comps(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'photoc_sp_vint104','/Volumes/d1/larrya/public_html/0pt1/0pt1_run14/t.14.',1,0);
% [diaz_pp_a,dd,diaz_pp_c,dd]= pop_comps(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'photoc_diaz_vint104','/Volumes/d1/larrya/public_html/0pt1/0pt1_run14/t.14.',1,0);
% [diat_pp_a,dd,diat_pp_c,dd]= pop_comps(stream_eddies.x,stream_eddies.y,stream_eddies.cyc,stream_eddies.k,stream_eddies.id,stream_eddies.track_jday,stream_eddies.radius,stream_eddies.adens,'photoc_diat_vint104','/Volumes/d1/larrya/public_html/0pt1/0pt1_run14/t.14.',1,0);
% save -append pop_stream_12_weeks


%%%NO3


load pop_stream_12_weeks
ac_no3_ss=round(100*pmean(1e7*ss_no3_a.ks_05(1:2)))./100;
ac_no3_vadv=round(100*pmean(1e7*vadv_no3_a.ks_05(1:2)))./100;
ac_no3_hadv=round(100*pmean(1e7*hadv_no3_a.ks_05(1:2)))./100;
ac_no3_vdif=round(100*pmean(1e7*vdif_no3_a.ks_05(1:2)))./100;
ac_no3_hdif=round(100*pmean(1e7*hdif_no3_a.ks_05(1:2)))./100;
ac_sum_terms=ac_no3_vadv+ac_no3_hadv+ac_no3_hdif+ac_no3_vdif+ac_no3_ss;

% diff_ac=pmean(tno3_a.ks_05(1:2))-ac_sum_terms

cc_no3_ss=round(100*pmean(1e7*ss_no3_c.ks_05(1:2)))./100;
cc_no3_vadv=round(100*pmean(1e7*vadv_no3_c.ks_05(1:2)))./100;
cc_no3_hadv=round(100*pmean(1e7*hadv_no3_c.ks_05(1:2)))./100;
cc_no3_vdif=round(100*pmean(1e7*vdif_no3_c.ks_05(1:2)))./100;
cc_no3_hdif=round(100*pmean(1e7*hdif_no3_c.ks_05(1:2)))./100;
cc_sum_terms=cc_no3_vadv+cc_no3_hadv+cc_no3_hdif+cc_no3_vdif+ac_no3_ss;

% test_diff_ac=pmean(tno3_a.ks_05(1:2))-pmean(tno3_a.ks_05(11:22))
return
figure(1)
set(gcf,'PaperPosition',[1 1 4 4])
clf
subplot(121)
axis([0 1 0 1])
line([.25 .25],[.25 .75],'color','k')
line([.25 .75],[.75 .75],'color','k')
line([.75 .75],[.75 .25],'color','k')
line([.75 .25],[.25 .25],'color','k')
axis square
text(.22,.12,[{'vadv',num2str(ac_no3_vadv)}],'fontsize',6)
text(.62,.12,[{'vdif',num2str(ac_no3_vdif)}],'fontsize',6)
text(.06,.6,[{'hadv',num2str(ac_no3_hadv)}],'fontsize',6)
text(.06,.3,[{'hdiff',num2str(ac_no3_hdif)}],'fontsize',6)
text(.81,.5,[{'SS',num2str(ac_no3_ss)}],'fontsize',6)
text(.5,.5,[{'\DeltaNO3',num2str(ac_sum_terms)}],'fontsize',6)
% text(.4,.4,[{'\Sigma',num2str(sum_terms)}])
text(.38,.79,['Anticyclones'],'fontsize',6)
set(gca,'xcolor',[1 1 1],'ycolor',[1 1 1])

subplot(122)
axis([0 1 0 1])
line([.25 .25],[.25 .75],'color','k')
line([.25 .75],[.75 .75],'color','k')
line([.75 .75],[.75 .25],'color','k')
line([.75 .25],[.25 .25],'color','k')
axis square
text(.22,.12,[{'vadv',num2str(cc_no3_vadv)}],'fontsize',6)
text(.62,.12,[{'vdif',num2str(cc_no3_vdif)}],'fontsize',6)
text(.06,.6,[{'hadv',num2str(cc_no3_hadv)}],'fontsize',6)
text(.06,.3,[{'hdiff',num2str(cc_no3_hdif)}],'fontsize',6)
text(.81,.5,[{'SS',num2str(cc_no3_ss)}],'fontsize',6)
text(.5,.5,[{'\DeltaNO3',num2str(cc_sum_terms)}],'fontsize',6)
% text(.4,.4,[{'\Sigma',num2str(sum_terms)}])
text(.38,.79,['Cyclones'],'fontsize',6)
set(gca,'xcolor',[1 1 1],'ycolor',[1 1 1])

print -dpng -r300 week_1_budget.png
!open week_1_budget.png

load pop_stream_12_weeks
ac_no3_ss=round(100*pmean(1e7*ss_no3_a.ks_05(11:12)))./100;
ac_no3_vadv=round(100*pmean(1e7*vadv_no3_a.ks_05(11:12)))./100;
ac_no3_hadv=round(100*pmean(1e7*hadv_no3_a.ks_05(11:12)))./100;
ac_no3_vdif=round(100*pmean(1e7*vdif_no3_a.ks_05(11:12)))./100;
ac_no3_hdif=round(100*pmean(1e7*hdif_no3_a.ks_05(11:12)))./100;
ac_sum_terms=ac_no3_vadv+ac_no3_hadv+ac_no3_hdif+ac_no3_vdif+ac_no3_ss;

% diff_ac=pmean(tno3_a.ks_05(11:12))-ac_sum_terms

cc_no3_ss=round(100*pmean(1e7*ss_no3_c.ks_05(11:12)))./100;
cc_no3_vadv=round(100*pmean(1e7*vadv_no3_c.ks_05(11:12)))./100;
cc_no3_hadv=round(100*pmean(1e7*hadv_no3_c.ks_05(11:12)))./100;
cc_no3_vdif=round(100*pmean(1e7*vdif_no3_c.ks_05(11:12)))./100;
cc_no3_hdif=round(100*pmean(1e7*hdif_no3_c.ks_05(11:12)))./100;
cc_sum_terms=cc_no3_vadv+cc_no3_hadv+cc_no3_hdif+cc_no3_vdif+ac_no3_ss;


figure(1)
set(gcf,'PaperPosition',[1 1 4 4])
clf
subplot(121)
axis([0 1 0 1])
line([.25 .25],[.25 .75],'color','k')
line([.25 .75],[.75 .75],'color','k')
line([.75 .75],[.75 .25],'color','k')
line([.75 .25],[.25 .25],'color','k')
axis square
text(.22,.12,[{'vadv',num2str(ac_no3_vadv)}],'fontsize',6)
text(.62,.12,[{'vdif',num2str(ac_no3_vdif)}],'fontsize',6)
text(.06,.6,[{'hadv',num2str(ac_no3_hadv)}],'fontsize',6)
text(.06,.3,[{'hdiff',num2str(ac_no3_hdif)}],'fontsize',6)
text(.81,.5,[{'SS',num2str(ac_no3_ss)}],'fontsize',6)
text(.5,.5,[{'\DeltaNO3',num2str(ac_sum_terms)}],'fontsize',6)
% text(.4,.4,[{'\Sigma',num2str(sum_terms)}])
text(.38,.79,['Anticyclones'],'fontsize',6)
set(gca,'xcolor',[1 1 1],'ycolor',[1 1 1])

subplot(122)
axis([0 1 0 1])
line([.25 .25],[.25 .75],'color','k')
line([.25 .75],[.75 .75],'color','k')
line([.75 .75],[.75 .25],'color','k')
line([.75 .25],[.25 .25],'color','k')
axis square
text(.22,.12,[{'vadv',num2str(cc_no3_vadv)}],'fontsize',6)
text(.62,.12,[{'vdif',num2str(cc_no3_vdif)}],'fontsize',6)
text(.06,.6,[{'hadv',num2str(cc_no3_hadv)}],'fontsize',6)
text(.06,.3,[{'hdiff',num2str(cc_no3_hdif)}],'fontsize',6)
text(.81,.5,[{'SS',num2str(cc_no3_ss)}],'fontsize',6)
text(.5,.5,[{'\DeltaNO3',num2str(cc_sum_terms)}],'fontsize',6)
% text(.4,.4,[{'\Sigma',num2str(sum_terms)}])
text(.38,.79,['Cyclones'],'fontsize',6)
set(gca,'xcolor',[1 1 1],'ycolor',[1 1 1])

print -dpng -r300 week_12_budget.png
!open week_12_budget.png





return


%DAIT
load pop_stream_12_weeks
ac_diat_ss=round(100*pmean(1e5*diat_bio_a.ks_05(11:12)))./100;
ac_diat_vadv=round(100*pmean(1e5*diat_vadv_a.ks_05(11:12)))./100;
ac_diat_hadv=round(100*pmean(1e5*diat_hadv_a.ks_05(11:12)))./100;
ac_diat_vdif=round(100*pmean(1e5*diat_vdif_a.ks_05(11:12)))./100;
ac_diat_hdif=round(100*pmean(1e5*diat_hdif_a.ks_05(11:12)))./100;
ac_sum_terms=ac_diat_vadv+ac_diat_hadv+ac_diat_hdif+ac_diat_vdif+ac_diat_ss;

cc_diat_ss=round(100*pmean(1e5*diat_bio_c.ks_05(11:12)))./100;
cc_diat_vadv=round(100*pmean(1e5*diat_vadv_c.ks_05(11:12)))./100;
cc_diat_hadv=round(100*pmean(1e5*diat_hadv_c.ks_05(11:12)))./100;
cc_diat_vdif=round(100*pmean(1e5*diat_vdif_c.ks_05(11:12)))./100;
cc_diat_hdif=round(100*pmean(1e5*diat_hdif_c.ks_05(11:12)))./100;
cc_sum_terms=cc_diat_vadv+cc_diat_hadv+cc_diat_hdif+cc_diat_vdif+cc_diat_ss;

figure(1)
set(gcf,'PaperPosition',[1 1 4 4])
clf
subplot(121)
axis([0 1 0 1])
line([.25 .25],[.25 .75],'color','k')
line([.25 .75],[.75 .75],'color','k')
line([.75 .75],[.75 .25],'color','k')
line([.75 .25],[.25 .25],'color','k')
axis square
text(.22,.12,[{'vadv',num2str(ac_diat_vadv)}],'fontsize',6)
text(.62,.12,[{'vdif',num2str(ac_diat_vdif)}],'fontsize',6)
text(.06,.6,[{'hadv',num2str(ac_diat_hadv)}],'fontsize',6)
text(.06,.3,[{'hdiff',num2str(ac_diat_hdif)}],'fontsize',6)
text(.81,.5,[{'SS',num2str(ac_diat_ss)}],'fontsize',6)
text(.5,.5,[{'\DeltaC',num2str(ac_sum_terms)}],'fontsize',6)
% text(.4,.4,[{'\Sigma',num2str(sum_terms)}])
text(.38,.79,['Anticyclones'],'fontsize',6)
set(gca,'xcolor',[1 1 1],'ycolor',[1 1 1])

subplot(122)
axis([0 1 0 1])
line([.25 .25],[.25 .75],'color','k')
line([.25 .75],[.75 .75],'color','k')
line([.75 .75],[.75 .25],'color','k')
line([.75 .25],[.25 .25],'color','k')
axis square
text(.22,.12,[{'vadv',num2str(cc_diat_vadv)}],'fontsize',6)
text(.62,.12,[{'vdif',num2str(cc_diat_vdif)}],'fontsize',6)
text(.06,.6,[{'hadv',num2str(cc_diat_hadv)}],'fontsize',6)
text(.06,.3,[{'hdiff',num2str(cc_diat_hdif)}],'fontsize',6)
text(.81,.5,[{'SS',num2str(cc_diat_ss)}],'fontsize',6)
text(.5,.5,[{'\DeltaC',num2str(cc_sum_terms)}],'fontsize',6)
% text(.4,.4,[{'\Sigma',num2str(sum_terms)}])
text(.38,.79,['Cyclones'],'fontsize',6)
set(gca,'xcolor',[1 1 1],'ycolor',[1 1 1])

print -dpng -r300 week_12_budget.png
!open week_12_budget.png


return
%%%DIAT Biomass

load pop_stream_12_weeks
ac_diat_ss=round(100*pmean(1e5*diat_bio_a.ks_05(1:2)))./100;
ac_diat_vadv=round(100*pmean(1e5*diat_vadv_a.ks_05(1:2)))./100;
ac_diat_hadv=round(100*pmean(1e5*diat_hadv_a.ks_05(1:2)))./100;
ac_diat_vdif=round(100*pmean(1e5*diat_vdif_a.ks_05(1:2)))./100;
ac_diat_hdif=round(100*pmean(1e5*diat_hdif_a.ks_05(1:2)))./100;
ac_sum_terms=ac_diat_vadv+ac_diat_hadv+ac_diat_hdif+ac_diat_vdif+ac_diat_ss;

cc_diat_ss=round(100*pmean(1e5*diat_bio_c.ks_05(1:2)))./100;
cc_diat_vadv=round(100*pmean(1e5*diat_vadv_c.ks_05(1:2)))./100;
cc_diat_hadv=round(100*pmean(1e5*diat_hadv_c.ks_05(1:2)))./100;
cc_diat_vdif=round(100*pmean(1e5*diat_vdif_c.ks_05(1:2)))./100;
cc_diat_hdif=round(100*pmean(1e5*diat_hdif_c.ks_05(1:2)))./100;
cc_sum_terms=cc_diat_vadv+cc_diat_hadv+cc_diat_hdif+cc_diat_vdif+cc_diat_ss;

figure(1)
set(gcf,'PaperPosition',[1 1 4 4])
clf
subplot(121)
axis([0 1 0 1])
line([.25 .25],[.25 .75],'color','k')
line([.25 .75],[.75 .75],'color','k')
line([.75 .75],[.75 .25],'color','k')
line([.75 .25],[.25 .25],'color','k')
axis square
text(.22,.12,[{'vadv',num2str(ac_diat_vadv)}],'fontsize',6)
text(.62,.12,[{'vdif',num2str(ac_diat_vdif)}],'fontsize',6)
text(.06,.6,[{'hadv',num2str(ac_diat_hadv)}],'fontsize',6)
text(.06,.3,[{'hdiff',num2str(ac_diat_hdif)}],'fontsize',6)
text(.81,.5,[{'SS',num2str(ac_diat_ss)}],'fontsize',6)
text(.5,.5,[{'\DeltaC',num2str(ac_sum_terms)}],'fontsize',6)
% text(.4,.4,[{'\Sigma',num2str(sum_terms)}])
text(.38,.79,['Anticyclones'],'fontsize',6)
set(gca,'xcolor',[1 1 1],'ycolor',[1 1 1])

subplot(122)
axis([0 1 0 1])
line([.25 .25],[.25 .75],'color','k')
line([.25 .75],[.75 .75],'color','k')
line([.75 .75],[.75 .25],'color','k')
line([.75 .25],[.25 .25],'color','k')
axis square
text(.22,.12,[{'vadv',num2str(cc_diat_vadv)}],'fontsize',6)
text(.62,.12,[{'vdif',num2str(cc_diat_vdif)}],'fontsize',6)
text(.06,.6,[{'hadv',num2str(cc_diat_hadv)}],'fontsize',6)
text(.06,.3,[{'hdiff',num2str(cc_diat_hdif)}],'fontsize',6)
text(.81,.5,[{'SS',num2str(cc_diat_ss)}],'fontsize',6)
text(.5,.5,[{'\DeltaC',num2str(cc_sum_terms)}],'fontsize',6)
% text(.4,.4,[{'\Sigma',num2str(sum_terms)}])
text(.38,.79,['Cyclones'],'fontsize',6)
set(gca,'xcolor',[1 1 1],'ycolor',[1 1 1])

print -dpng -r300 week_1_budget.png
!open week_1_budget.png

load pop_stream_12_weeks
ac_diat_ss=round(100*pmean(1e5*diat_bio_a.ks_05(11:12)))./100;
ac_diat_vadv=round(100*pmean(1e5*diat_vadv_a.ks_05(11:12)))./100;
ac_diat_hadv=round(100*pmean(1e5*diat_hadv_a.ks_05(11:12)))./100;
ac_diat_vdif=round(100*pmean(1e5*diat_vdif_a.ks_05(11:12)))./100;
ac_diat_hdif=round(100*pmean(1e5*diat_hdif_a.ks_05(11:12)))./100;
ac_sum_terms=ac_diat_vadv+ac_diat_hadv+ac_diat_hdif+ac_diat_vdif+ac_diat_ss;

cc_diat_ss=round(100*pmean(1e5*diat_bio_c.ks_05(11:12)))./100;
cc_diat_vadv=round(100*pmean(1e5*diat_vadv_c.ks_05(11:12)))./100;
cc_diat_hadv=round(100*pmean(1e5*diat_hadv_c.ks_05(11:12)))./100;
cc_diat_vdif=round(100*pmean(1e5*diat_vdif_c.ks_05(11:12)))./100;
cc_diat_hdif=round(100*pmean(1e5*diat_hdif_c.ks_05(11:12)))./100;
cc_sum_terms=cc_diat_vadv+cc_diat_hadv+cc_diat_hdif+cc_diat_vdif+cc_diat_ss;

figure(1)
set(gcf,'PaperPosition',[1 1 4 4])
clf
subplot(121)
axis([0 1 0 1])
line([.25 .25],[.25 .75],'color','k')
line([.25 .75],[.75 .75],'color','k')
line([.75 .75],[.75 .25],'color','k')
line([.75 .25],[.25 .25],'color','k')
axis square
text(.22,.12,[{'vadv',num2str(ac_diat_vadv)}],'fontsize',6)
text(.62,.12,[{'vdif',num2str(ac_diat_vdif)}],'fontsize',6)
text(.06,.6,[{'hadv',num2str(ac_diat_hadv)}],'fontsize',6)
text(.06,.3,[{'hdiff',num2str(ac_diat_hdif)}],'fontsize',6)
text(.81,.5,[{'SS',num2str(ac_diat_ss)}],'fontsize',6)
text(.5,.5,[{'\DeltaC',num2str(ac_sum_terms)}],'fontsize',6)
% text(.4,.4,[{'\Sigma',num2str(sum_terms)}])
text(.38,.79,['Anticyclones'],'fontsize',6)
set(gca,'xcolor',[1 1 1],'ycolor',[1 1 1])

subplot(122)
axis([0 1 0 1])
line([.25 .25],[.25 .75],'color','k')
line([.25 .75],[.75 .75],'color','k')
line([.75 .75],[.75 .25],'color','k')
line([.75 .25],[.25 .25],'color','k')
axis square
text(.22,.12,[{'vadv',num2str(cc_diat_vadv)}],'fontsize',6)
text(.62,.12,[{'vdif',num2str(cc_diat_vdif)}],'fontsize',6)
text(.06,.6,[{'hadv',num2str(cc_diat_hadv)}],'fontsize',6)
text(.06,.3,[{'hdiff',num2str(cc_diat_hdif)}],'fontsize',6)
text(.81,.5,[{'SS',num2str(cc_diat_ss)}],'fontsize',6)
text(.5,.5,[{'\DeltaC',num2str(cc_sum_terms)}],'fontsize',6)
% text(.4,.4,[{'\Sigma',num2str(sum_terms)}])
text(.38,.79,['Cyclones'],'fontsize',6)
set(gca,'xcolor',[1 1 1],'ycolor',[1 1 1])

print -dpng -r300 week_12_budget.png
!open week_12_budget.png




