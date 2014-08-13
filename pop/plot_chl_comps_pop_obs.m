
clear all


load obs_stream_sla

pcomps_mask(norm_hp66_chl_a,norm_ssh_a.mean,[-.3 .3],-1,.1,1,['N = ',num2str(norm_hp66_chl_a.n_max_sample)],2,30)
print -dpng -r300 figs/obs_stream/norm_chl_a_sla
pcomps_mask(norm_hp66_chl_c,norm_ssh_c.mean,[-.3 .3],-1,.1,1,['N = ',num2str(norm_hp66_chl_c.n_max_sample)],2,30)
print -dpng -r300 figs/obs_stream/norm_chl_c_sla
% 
% 
% pcomps_raw2(norm_hp66_c_a.mean,norm_ssh_a.mean,[-.075 .075],-1,.1,1,['C',char(39) char(39),' AC'],3,20)
% print -dpng -r300 figs/obs_stream/norm_car_a_sla
% pcomps_raw2(norm_hp66_c_c.mean,norm_ssh_c.mean,[-.075 .075],-1,.1,1,['C',char(39) char(39),' CC'],3,20)
% print -dpng -r300 figs/obs_stream/norm_car_c_sla
% 

load pop_stream_sla
% pcomps(ssh_a,ssh_a.mean,[-40 40],-150,5,150,['SSH AC'],2,20)
% print -dpng -r300 figs/pop_stream/ssh_a_sla
% pcomps(ssh_c,ssh_c.mean,[-40 40],-150,5,150,['SSH CC'],2,20)
% print -dpng -r300 figs/pop_stream/ssh_c_sla
% return
% 
pcomps_mask(norm_hp66_chl_a,norm_ssh_a.mean,[-.4 .4],-1,.1,1,['N = ',num2str(norm_hp66_chl_a.n_max_sample)],2,30)
print -dpng -r300 figs/pop_stream/norm_chl_a_sla
pcomps_mask(norm_hp66_chl_c,norm_ssh_c.mean,[-.4 .4],-1,.1,1,['N = ',num2str(norm_hp66_chl_c.n_max_sample)],2,30)
print -dpng -r300 figs/pop_stream/norm_chl_c_sla

% 
% pcomps_raw2(norm_hp66_c_a.mean,norm_ssh_a.mean,[-.12 .12],-1,.1,1,['C',char(39) char(39),' AC'],3,20)
% print -dpng -r300 figs/pop_stream/norm_car_a_sla
% pcomps_raw2(norm_hp66_c_c.mean,norm_ssh_c.mean,[-.12 .12],-1,.1,1,['C',char(39) char(39),' CC'],3,20)
% print -dpng -r300 figs/pop_stream/norm_car_c_sla

load pop_stream_run33

% pcomps(ssh_a,ssh_a.mean,[-40 40],-150,5,150,['SSH AC'],3,20)
% print -dpng -r300 figs/pop_stream_run33/ssh_a_sla
% pcomps(ssh_c,ssh_c.mean,[-40 40],-150,5,150,['SSH CC'],3,20)
% print -dpng -r300 figs/pop_stream_run33/ssh_c_sla
% return

pcomps_mask(norm_hp66_chl_a,norm_ssh_a.mean,[-.4 .4],-1,.1,1,['N = ',num2str(norm_hp66_chl_a.n_max_sample)],2,30)
print -dpng -r300 figs/pop_stream_run33/norm_chl_a_sla
pcomps_mask(norm_hp66_chl_c,norm_ssh_c.mean,[-.4 .4],-1,.1,1,['N = ',num2str(norm_hp66_chl_c.n_max_sample)],2,30)
print -dpng -r300 figs/pop_stream_run33/norm_chl_c_sla
% 
% pcomps_raw2(norm_hp66_c_a.mean,norm_ssh_a.mean,[-.12 .12],-1,.1,1,['C',char(39) char(39),' AC'],3,20)
% print -dpng -r300 figs/pop_stream_run33/norm_car_a_sla
% pcomps_raw2(norm_hp66_c_c.mean,norm_ssh_c.mean,[-.12 .12],-1,.1,1,['C',char(39) char(39),' CC'],3,20)
% print -dpng -r300 figs/pop_stream_run33/norm_car_c_sla