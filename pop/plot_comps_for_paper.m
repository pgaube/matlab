
clear all

% 
load obs_stream_sla

pcomps_stip(norm_hp66_chl_a,obs_ssh_a.mean,[-.25 .25],-500,5,500,['N = ',num2str(norm_hp66_chl_a.n_max_sample)],2,15)
print -dpng -r300 figs/obs_stream/eddies_chl_a_sla
pcomps_stip(norm_hp66_chl_c,obs_ssh_c.mean,[-.25 .25],-500,5,500,['N = ',num2str(norm_hp66_chl_c.n_max_sample)],2,15)
print -dpng -r300 figs/obs_stream/eddies_chl_c_sla

load obs_meanders_sla

pcomps_stip(norm_hp66_chl_a,ssh_a.mean,[-.25 .25],-500,5,500,['N = ',num2str(norm_hp66_chl_a.n_max_sample)],2,15)
print -dpng -r300 figs/obs_stream/meanders_chl_a_sla
pcomps_stip(norm_hp66_chl_c,ssh_c.mean,[-.25 .25],-500,5,500,['N = ',num2str(norm_hp66_chl_c.n_max_sample)],2,15)
print -dpng -r300 figs/obs_stream/meanders_chl_c_sla


load pop_stream_sla

pcomps_stip(norm_hp66_chl_a,ssh_a.mean,[-.4 .4],-500,5,500,['N = ',num2str(norm_hp66_chl_a.n_max_sample)],2,15)
print -dpng -r300 figs/pop_stream/eddies_chl_a_sla
pcomps_stip(norm_hp66_chl_c,ssh_c.mean,[-.4 .4],-500,5,500,['N = ',num2str(norm_hp66_chl_c.n_max_sample)],2,15)
print -dpng -r300 figs/pop_stream/eddies_chl_c_sla

load pop_meanders_sla

pcomps_stip(norm_hp66_chl_a,ssh_a.mean,[-.4 .4],-500,5,500,['N = ',num2str(norm_hp66_chl_a.n_max_sample)],2,15)
print -dpng -r300 figs/pop_stream/meanders_chl_a_sla
pcomps_stip(norm_hp66_chl_c,ssh_c.mean,[-.4 .43],-500,5,500,['N = ',num2str(norm_hp66_chl_c.n_max_sample)],2,15)
print -dpng -r300 figs/pop_stream/meanders_chl_c_sla


load pop_stream_run33
pcomps_stip(norm_hp66_chl_a,ssh_a.mean,[-.4 .4],-500,5,500,['N = ',num2str(norm_hp66_chl_a.n_max_sample)],2,15)
print -dpng -r300 figs/pop_stream_run33/eddies_chl_a_sla

pcomps_stip(norm_hp66_chl_c,ssh_c.mean,[-.4 .4],-500,5,500,['N = ',num2str(norm_hp66_chl_c.n_max_sample)],2,15)
print -dpng -r300 figs/pop_stream_run33/eddies_chl_c_sla

load pop_meanders_run33

pcomps_stip(norm_hp66_chl_a,ssh_a.mean,[-.4 .4],-500,5,500,['N = ',num2str(norm_hp66_chl_a.n_max_sample)],2,15)
print -dpng -r300 figs/pop_stream_run33/meanders_chl_a_sla
pcomps_stip(norm_hp66_chl_c,ssh_c.mean,[-.4 .43],-500,5,500,['N = ',num2str(norm_hp66_chl_c.n_max_sample)],2,15)
print -dpng -r300 figs/pop_stream_run33/meanders_chl_c_sla