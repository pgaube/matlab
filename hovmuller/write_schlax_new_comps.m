clear all
%
!rm for_mike/*composit*
load new_mgrad_rot_comps *rot_*

compcc=double(rot_all_bp21_chl_N_cc.mean);
compcc(isnan(compcc))=1e35;

compc=double(rot_all_bp21_chl_N_c.mean);
compc(isnan(compc))=1e35;


tt=[-2 2 -2 2];
eval(['save -ascii for_mike/global_composite_all_amp_northward_grad_chl_mean_cc.dat tt'])
tt=[length(compcc(1,:)) length(compcc(:,1)) .0625 .0625];
eval(['save -ascii -append for_mike/global_composite_all_amp_northward_grad_chl_mean_cc.dat tt'])
tt=compcc';
eval(['save -ascii -append for_mike/global_composite_all_amp_northward_grad_chl_mean_cc.dat tt'])

tt=[-2 2 -2 2];
eval(['save -ascii for_mike/global_composite_all_amp_northward_grad_chl_mean_c.dat tt'])
tt=[length(compc(1,:)) length(compc(:,1)) .0625 .0625];
eval(['save -ascii -append for_mike/global_composite_all_amp_northward_grad_chl_mean_c.dat tt'])
tt=compc';
eval(['save -ascii -append for_mike/global_composite_all_amp_northward_grad_chl_mean_c.dat tt'])

compcc=double(rot_all_bp21_chl_S_cc.mean);
compcc(isnan(compcc))=1e35;

compc=double(rot_all_bp21_chl_S_c.mean);
compc(isnan(compc))=1e35;


tt=[-2 2 -2 2];
eval(['save -ascii for_mike/global_composite_all_amp_southward_grad_chl_mean_cc.dat tt'])
tt=[length(compcc(1,:)) length(compcc(:,1)) .0625 .0625];
eval(['save -ascii -append for_mike/global_composite_all_amp_southward_grad_chl_mean_cc.dat tt'])
tt=compcc';
eval(['save -ascii -append for_mike/global_composite_all_amp_southward_grad_chl_mean_cc.dat tt'])

tt=[-2 2 -2 2];
eval(['save -ascii for_mike/global_composite_all_amp_southward_grad_chl_mean_c.dat tt'])
tt=[length(compc(1,:)) length(compc(:,1)) .0625 .0625];
eval(['save -ascii -append for_mike/global_composite_all_amp_southward_grad_chl_mean_c.dat tt'])
tt=compc';
eval(['save -ascii -append for_mike/global_composite_all_amp_southward_grad_chl_mean_c.dat tt'])


load section_trans_samp

compcc=double(section_24_bp26_chl_rot_N_cc.mean);
compcc(isnan(compcc))=1e35;

compc=double(section_24_bp26_chl_rot_N_c.mean);
compc(isnan(compc))=1e35;

tt=[-2 2 -2 2];
eval(['save -ascii for_mike/vocals_composite_chl_mean_cc.dat tt'])
tt=[length(compcc(1,:)) length(compcc(:,1)) .0625 .0625];
eval(['save -ascii -append for_mike/vocals_composite_chl_mean_cc.dat tt'])
tt=compcc';
eval(['save -ascii -append for_mike/vocals_composite_chl_mean_cc.dat tt'])

tt=[-2 2 -2 2];
eval(['save -ascii for_mike/vocals_composite_chl_mean_c.dat tt'])
tt=[length(compc(1,:)) length(compc(:,1)) .0625 .0625];
eval(['save -ascii -append for_mike/vocals_composite_chl_mean_c.dat tt'])
tt=compc';
eval(['save -ascii -append for_mike/vocals_composite_chl_mean_c.dat tt'])

compcc=double(section_30_bp26_chl_rot_N_cc.mean);
compcc(isnan(compcc))=1e35;

compc=double(section_30_bp26_chl_rot_N_c.mean);
compc(isnan(compc))=1e35;

tt=[-2 2 -2 2];
eval(['save -ascii for_mike/vocals_west_composite_chl_mean_cc.dat tt'])
tt=[length(compcc(1,:)) length(compcc(:,1)) .0625 .0625];
eval(['save -ascii -append for_mike/vocals_west_composite_chl_mean_cc.dat tt'])
tt=compcc';
eval(['save -ascii -append for_mike/vocals_west_composite_chl_mean_cc.dat tt'])

tt=[-2 2 -2 2];
eval(['save -ascii for_mike/vocals_west_composite_chl_mean_c.dat tt'])
tt=[length(compc(1,:)) length(compc(:,1)) .0625 .0625];
eval(['save -ascii -append for_mike/vocals_west_composite_chl_mean_c.dat tt'])
tt=compc';
eval(['save -ascii -append for_mike/vocals_west_composite_chl_mean_c.dat tt'])

compcc=double(section_31_bp26_chl_rot_N_cc.mean);
compcc(isnan(compcc))=1e35;

compc=double(section_31_bp26_chl_rot_N_c.mean);
compc(isnan(compc))=1e35;

tt=[-2 2 -2 2];
eval(['save -ascii for_mike/vocals_east_composite_chl_mean_cc.dat tt'])
tt=[length(compcc(1,:)) length(compcc(:,1)) .0625 .0625];
eval(['save -ascii -append for_mike/vocals_east_composite_chl_mean_cc.dat tt'])
tt=compcc';
eval(['save -ascii -append for_mike/vocals_east_composite_chl_mean_cc.dat tt'])

tt=[-2 2 -2 2];
eval(['save -ascii for_mike/vocals_east_composite_chl_mean_c.dat tt'])
tt=[length(compc(1,:)) length(compc(:,1)) .0625 .0625];
eval(['save -ascii -append for_mike/vocals_east_composite_chl_mean_c.dat tt'])
tt=compc';
eval(['save -ascii -append for_mike/vocals_east_composite_chl_mean_c.dat tt'])






return
load /matlab/matlab/QG_model/alpha_1_tau_30_comps y_a y_c ssh_a ssh_c
r=17:65;
c=17:65;

compa = double(-ssh_c(r,c));
tt=[-3 3 -3 3];
eval(['save -ascii for_mike/model_alpha_1_composite_ssh_median_cc.dat tt'])
tt=[length(compa(1,:)) length(compa(:,1)) .125 .125];
eval(['save -ascii -append for_mike/model_alpha_1_composite_ssh_median_cc.dat tt'])
tt=compa';
eval(['save -ascii -append for_mike/model_alpha_1_composite_ssh_median_cc.dat tt'])

compa = double(y_c(r,c));
tt=[-3 3 -3 3];
eval(['save -ascii for_mike/model_alpha_1_composite_tracer_median_cc.dat tt'])
tt=[length(compa(1,:)) length(compa(:,1)) .125 .125];
eval(['save -ascii -append for_mike/model_alpha_1_composite_tracer_median_cc.dat tt'])
tt=compa';
eval(['save -ascii -append for_mike/model_alpha_1_composite_tracer_median_cc.dat tt'])

compa = double(-ssh_a(r,c));
tt=[-3 3 -3 3];
eval(['save -ascii for_mike/model_alpha_1_composite_ssh_median_c.dat tt'])
tt=[length(compa(1,:)) length(compa(:,1)) .125 .125];
eval(['save -ascii -append for_mike/model_alpha_1_composite_ssh_median_c.dat tt'])
tt=compa';
eval(['save -ascii -append for_mike/model_alpha_1_composite_ssh_median_c.dat tt'])

compa = double(y_a(r,c));
tt=[-3 3 -3 3];
eval(['save -ascii for_mike/model_alpha_1_composite_tracer_median_c.dat tt'])
tt=[length(compa(1,:)) length(compa(:,1)) .125 .125];
eval(['save -ascii -append for_mike/model_alpha_1_composite_tracer_median_c.dat tt'])
tt=compa';
eval(['save -ascii -append for_mike/model_alpha_1_composite_tracer_median_c.dat tt'])

load /matlab/matlab/QG_model/alpha_2_tau_30_comps y_a y_c ssh_a ssh_c
r=17:65;
c=17:65;

compa = double(-ssh_c(r,c));
tt=[-3 3 -3 3];
eval(['save -ascii for_mike/model_alpha_2_composite_ssh_median_cc.dat tt'])
tt=[length(compa(1,:)) length(compa(:,1)) .125 .125];
eval(['save -ascii -append for_mike/model_alpha_2_composite_ssh_median_cc.dat tt'])
tt=compa';
eval(['save -ascii -append for_mike/model_alpha_2_composite_ssh_median_cc.dat tt'])

compa = double(y_c(r,c));
tt=[-3 3 -3 3];
eval(['save -ascii for_mike/model_alpha_2_composite_tracer_median_cc.dat tt'])
tt=[length(compa(1,:)) length(compa(:,1)) .125 .125];
eval(['save -ascii -append for_mike/model_alpha_2_composite_tracer_median_cc.dat tt'])
tt=compa';
eval(['save -ascii -append for_mike/model_alpha_2_composite_tracer_median_cc.dat tt'])

compa = double(-ssh_a(r,c));
tt=[-3 3 -3 3];
eval(['save -ascii for_mike/model_alpha_2_composite_ssh_median_c.dat tt'])
tt=[length(compa(1,:)) length(compa(:,1)) .125 .125];
eval(['save -ascii -append for_mike/model_alpha_2_composite_ssh_median_c.dat tt'])
tt=compa';
eval(['save -ascii -append for_mike/model_alpha_2_composite_ssh_median_c.dat tt'])

compa = double(y_a(r,c));
tt=[-3 3 -3 3];
eval(['save -ascii for_mike/model_alpha_2_composite_tracer_median_c.dat tt'])
tt=[length(compa(1,:)) length(compa(:,1)) .125 .125];
eval(['save -ascii -append for_mike/model_alpha_2_composite_tracer_median_c.dat tt'])
tt=compa';
eval(['save -ascii -append for_mike/model_alpha_2_composite_tracer_median_c.dat tt'])

load /matlab/matlab/QG_model/alpha_3_tau_30_comps y_a y_c ssh_a ssh_c
r=17:65;
c=17:65;

compa = double(-ssh_c(r,c));
tt=[-3 3 -3 3];
eval(['save -ascii for_mike/model_alpha_3_composite_ssh_median_cc.dat tt'])
tt=[length(compa(1,:)) length(compa(:,1)) .125 .125];
eval(['save -ascii -append for_mike/model_alpha_3_composite_ssh_median_cc.dat tt'])
tt=compa';
eval(['save -ascii -append for_mike/model_alpha_3_composite_ssh_median_cc.dat tt'])

compa = double(y_c(r,c));
tt=[-3 3 -3 3];
eval(['save -ascii for_mike/model_alpha_3_composite_tracer_median_cc.dat tt'])
tt=[length(compa(1,:)) length(compa(:,1)) .125 .125];
eval(['save -ascii -append for_mike/model_alpha_3_composite_tracer_median_cc.dat tt'])
tt=compa';
eval(['save -ascii -append for_mike/model_alpha_3_composite_tracer_median_cc.dat tt'])

compa = double(-ssh_a(r,c));
tt=[-3 3 -3 3];
eval(['save -ascii for_mike/model_alpha_3_composite_ssh_median_c.dat tt'])
tt=[length(compa(1,:)) length(compa(:,1)) .125 .125];
eval(['save -ascii -append for_mike/model_alpha_3_composite_ssh_median_c.dat tt'])
tt=compa';
eval(['save -ascii -append for_mike/model_alpha_3_composite_ssh_median_c.dat tt'])

compa = double(y_a(r,c));
tt=[-3 3 -3 3];
eval(['save -ascii for_mike/model_alpha_3_composite_tracer_median_c.dat tt'])
tt=[length(compa(1,:)) length(compa(:,1)) .125 .125];
eval(['save -ascii -append for_mike/model_alpha_3_composite_tracer_median_c.dat tt'])
tt=compa';
eval(['save -ascii -append for_mike/model_alpha_3_composite_tracer_median_c.dat tt'])
