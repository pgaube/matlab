clear all

!rm for_mike/*composit*
load mgrad_rot_comps *rot_*

compcc=double(interp_rot_small_ssh_cc.median);
ncc=double(interp_rot_small_ssh_cc.N);
compcc(isnan(compcc))=1e35;
ncc(isnan(ncc))=1e35;

compc=double(interp_rot_small_ssh_c.median);
nc=double(interp_rot_small_ssh_c.N);
compc(isnan(compc))=1e35;
nc(isnan(nc))=1e35;


tt=[-2 2 -2 2];
eval(['save -ascii for_mike/global_composite_smaller_than_5cm_amp_ssh_median_cc.dat tt'])
tt=[length(compcc(1,:)) length(compcc(:,1)) .0625 .0625];
eval(['save -ascii -append for_mike/global_composite_smaller_than_5cm_amp_ssh_median_cc.dat tt'])
tt=compcc';
eval(['save -ascii -append for_mike/global_composite_smaller_than_5cm_amp_ssh_median_cc.dat tt'])

tt=[-2 2 -2 2];
eval(['save -ascii for_mike/global_composite_smaller_than_5cm_amp_ssh_median_c.dat tt'])
tt=[length(compcc(1,:)) length(compcc(:,1)) .0625 .0625];
eval(['save -ascii -append for_mike/global_composite_smaller_than_5cm_amp_ssh_median_c.dat tt'])
tt=compc';
eval(['save -ascii -append for_mike/global_composite_smaller_than_5cm_amp__ssh_median_c.dat tt'])


compcc=double(rot_small_bp21_chl_cc.median);
ncc=double(rot_small_bp21_chl_cc.N);
compcc(isnan(compcc))=1e35;
ncc(isnan(ncc))=1e35;

compc=double(rot_small_bp21_chl_c.median);
nc=double(rot_small_bp21_chl_c.N);
compc(isnan(compc))=1e35;
nc(isnan(nc))=1e35;


tt=[-2 2 -2 2];
eval(['save -ascii for_mike/global_composite_smaller_than_5cm_amp_chl_median_cc.dat tt'])
tt=[length(compc(1,:)) length(compc(:,1)) .0625 .0625];
eval(['save -ascii -append for_mike/global_composite_smaller_than_5cm_amp_chl_median_cc.dat tt'])
tt=compcc';
eval(['save -ascii -append for_mike/global_composite_smaller_than_5cm_amp_chl_median_cc.dat tt'])

tt=[-2 2 -2 2];
eval(['save -ascii for_mike/global_composite_smaller_than_5cm_amp_chl_median_c.dat tt'])
tt=[length(compc(1,:)) length(compc(:,1)) .0625 .0625]
eval(['save -ascii -append for_mike/global_composite_smaller_than_5cm_amp_chl_median_c.dat tt'])
tt=compc';
eval(['save -ascii -append for_mike/global_composite_smaller_than_5cm_amp_chl_median_c.dat tt'])




compcc=double(interp_rot_large_ssh_cc.median);
ncc=double(interp_rot_large_ssh_cc.N);
compcc(isnan(compcc))=1e35;
ncc(isnan(ncc))=1e35;

compc=double(interp_rot_large_ssh_c.median);
nc=double(interp_rot_large_ssh_c.N);
compc(isnan(compc))=1e35;
nc(isnan(nc))=1e35;


tt=[-2 2 -2 2];
eval(['save -ascii for_mike/global_composite_larger_than_5cm_amp_ssh_median_cc.dat tt'])
tt=[length(compcc(1,:)) length(compcc(:,1)) .0625 .0625];
eval(['save -ascii -append for_mike/global_composite_larger_than_5cm_amp_ssh_median_cc.dat tt'])
tt=compcc';
eval(['save -ascii -append for_mike/global_composite_larger_than_5cm_amp_ssh_median_cc.dat tt'])

tt=[-2 2 -2 2];
eval(['save -ascii for_mike/global_composite_larger_than_5cm_amp_ssh_median_c.dat tt'])
tt=[length(compcc(1,:)) length(compcc(:,1)) .0625 .0625];
eval(['save -ascii -append for_mike/global_composite_larger_than_5cm_amp_ssh_median_c.dat tt'])
tt=compc';
eval(['save -ascii -append for_mike/global_composite_larger_than_5cm_amp__ssh_median_c.dat tt'])


compcc=double(rot_large_bp21_chl_cc.median);
ncc=double(rot_large_bp21_chl_cc.N);
compcc(isnan(compcc))=1e35;
ncc(isnan(ncc))=1e35;

compc=double(rot_large_bp21_chl_c.median);
nc=double(rot_large_bp21_chl_c.N);
compc(isnan(compc))=1e35;
nc(isnan(nc))=1e35;


tt=[-2 2 -2 2];
eval(['save -ascii for_mike/global_composite_larger_than_5cm_amp_chl_median_cc.dat tt'])
tt=[length(compc(1,:)) length(compc(:,1)) .0625 .0625];
eval(['save -ascii -append for_mike/global_composite_larger_than_5cm_amp_chl_median_cc.dat tt'])
tt=compcc';
eval(['save -ascii -append for_mike/global_composite_larger_than_5cm_amp_chl_median_cc.dat tt'])

tt=[-2 2 -2 2];
eval(['save -ascii for_mike/global_composite_larger_than_5cm_amp_chl_median_c.dat tt'])
tt=[length(compc(1,:)) length(compc(:,1)) .0625 .0625]
eval(['save -ascii -append for_mike/global_composite_larger_than_5cm_amp_chl_median_c.dat tt'])
tt=compc';
eval(['save -ascii -append for_mike/global_composite_larger_than_5cm_amp_chl_median_c.dat tt'])




load section_trans_samp

compa=double(section_30_bp21_chl_a.median);
na=double(section_30_bp21_chl_a.N);
compa(isnan(compa))=1e35;
na(isnan(na))=1e35;

compc=double(section_30_bp21_chl_c.median);
nc=double(section_30_bp21_chl_c.N);
compc(isnan(compc))=1e35;
nc(isnan(nc))=1e35;


tt=[-3 3 -3 3];
eval(['save -ascii for_mike/section_1_west_composite_chl_median_a.dat tt'])
tt=[length(compa(1,:)) length(compa(:,1)) .125 .125];
eval(['save -ascii -append for_mike/section_1_west_composite_chl_median_a.dat tt'])
tt=compa';
eval(['save -ascii -append for_mike/section_1_west_composite_chl_median_a.dat tt'])

tt=[-3 3 -3 3];
eval(['save -ascii for_mike/section_1_west_composite_chl_median_c.dat tt'])
tt=[length(compc(1,:)) length(compc(:,1)) .125 .125];
eval(['save -ascii -append for_mike/section_1_west_composite_chl_median_c.dat tt'])
tt=compc';
eval(['save -ascii -append for_mike/section_1_west_composite_chl_median_c.dat tt'])

tt=[-3 3 -3 3];
eval(['save -ascii for_mike/section_1_west_composite_chl_n_a.dat tt'])
tt=[length(na(1,:)) length(na(:,1)) .125 .125];
eval(['save -ascii -append for_mike/section_1_west_composite_chl_n_a.dat tt'])
tt=na';
eval(['save -ascii -append for_mike/section_1_west_composite_chl_n_a.dat tt'])

tt=[-3 3 -3 3];
eval(['save -ascii for_mike/section_1_west_composite_chl_n_c.dat tt'])
tt=[length(nc(1,:)) length(nc(:,1)) .125 .125];
eval(['save -ascii -append for_mike/section_1_west_composite_chl_n_c.dat tt'])
tt=nc';
eval(['save -ascii -append for_mike/section_1_west_composite_chl_n_c.dat tt'])

compa=double(section_30_ssh_a.median);
na=double(section_30_ssh_a.N);
compa(isnan(compa))=1e35;
na(isnan(na))=1e35;

compc=double(section_30_ssh_c.median);
nc=double(section_30_ssh_c.N);
compc(isnan(compc))=1e35;
nc(isnan(nc))=1e35;


tt=[-3 3 -3 3];
eval(['save -ascii for_mike/section_1_west_composite_ssh_median_a.dat tt'])
tt=[length(compa(1,:)) length(compa(:,1)) .125 .125];
eval(['save -ascii -append for_mike/section_1_west_composite_ssh_median_a.dat tt'])
tt=compa';
eval(['save -ascii -append for_mike/section_1_west_composite_ssh_median_a.dat tt'])

tt=[-3 3 -3 3];
eval(['save -ascii for_mike/section_1_west_composite_ssh_median_c.dat tt'])
tt=[length(compc(1,:)) length(compc(:,1)) .125 .125];
eval(['save -ascii -append for_mike/section_1_west_composite_ssh_median_c.dat tt'])
tt=compc';
eval(['save -ascii -append for_mike/section_1_west_composite_ssh_median_c.dat tt'])

tt=[-3 3 -3 3];
eval(['save -ascii for_mike/section_1_west_composite_ssh_n_a.dat tt'])
tt=[length(na(1,:)) length(na(:,1)) .125 .125];
eval(['save -ascii -append for_mike/section_1_west_composite_ssh_n_a.dat tt'])
tt=na';
eval(['save -ascii -append for_mike/section_1_west_composite_ssh_n_a.dat tt'])

tt=[-3 3 -3 3];
eval(['save -ascii for_mike/section_1_west_composite_ssh_n_c.dat tt'])
tt=[length(nc(1,:)) length(nc(:,1)) .125 .125];
eval(['save -ascii -append for_mike/section_1_west_composite_ssh_n_c.dat tt'])
tt=nc';
eval(['save -ascii -append for_mike/section_1_west_composite_ssh_n_c.dat tt'])


compa=double(section_31_bp21_chl_a.median);
na=double(section_31_bp21_chl_a.N);
compa(isnan(compa))=1e35;
na(isnan(na))=1e35;

compc=double(section_31_bp21_chl_c.median);
nc=double(section_31_bp21_chl_c.N);
compc(isnan(compc))=1e35;
nc(isnan(nc))=1e35;


tt=[-3 3 -3 3];
eval(['save -ascii for_mike/section_1_east_composite_chl_median_a.dat tt'])
tt=[length(compa(1,:)) length(compa(:,1)) .125 .125];
eval(['save -ascii -append for_mike/section_1_east_composite_chl_median_a.dat tt'])
tt=compa';
eval(['save -ascii -append for_mike/section_1_east_composite_chl_median_a.dat tt'])

tt=[-3 3 -3 3];
eval(['save -ascii for_mike/section_1_east_composite_chl_median_c.dat tt'])
tt=[length(compc(1,:)) length(compc(:,1)) .125 .125];
eval(['save -ascii -append for_mike/section_1_east_composite_chl_median_c.dat tt'])
tt=compc';
eval(['save -ascii -append for_mike/section_1_east_composite_chl_median_c.dat tt'])

tt=[-3 3 -3 3];
eval(['save -ascii for_mike/section_1_east_composite_chl_n_a.dat tt'])
tt=[length(na(1,:)) length(na(:,1)) .125 .125];
eval(['save -ascii -append for_mike/section_1_east_composite_chl_n_a.dat tt'])
tt=na';
eval(['save -ascii -append for_mike/section_1_east_composite_chl_n_a.dat tt'])

tt=[-3 3 -3 3];
eval(['save -ascii for_mike/section_1_east_composite_chl_n_c.dat tt'])
tt=[length(nc(1,:)) length(nc(:,1)) .125 .125];
eval(['save -ascii -append for_mike/section_1_east_composite_chl_n_c.dat tt'])
tt=nc';
eval(['save -ascii -append for_mike/section_1_east_composite_chl_n_c.dat tt'])

compa=double(section_31_ssh_a.median);
na=double(section_31_ssh_a.N);
compa(isnan(compa))=1e35;
na(isnan(na))=1e35;

compc=double(section_31_ssh_c.median);
nc=double(section_31_ssh_c.N);
compc(isnan(compc))=1e35;
nc(isnan(nc))=1e35;


tt=[-3 3 -3 3];
eval(['save -ascii for_mike/section_1_east_composite_ssh_median_a.dat tt'])
tt=[length(compa(1,:)) length(compa(:,1)) .125 .125];
eval(['save -ascii -append for_mike/section_1_east_composite_ssh_median_a.dat tt'])
tt=compa';
eval(['save -ascii -append for_mike/section_1_east_composite_ssh_median_a.dat tt'])

tt=[-3 3 -3 3];
eval(['save -ascii for_mike/section_1_east_composite_ssh_median_c.dat tt'])
tt=[length(compc(1,:)) length(compc(:,1)) .125 .125];
eval(['save -ascii -append for_mike/section_1_east_composite_ssh_median_c.dat tt'])
tt=compc';
eval(['save -ascii -append for_mike/section_1_east_composite_ssh_median_c.dat tt'])

tt=[-3 3 -3 3];
eval(['save -ascii for_mike/section_1_east_composite_ssh_n_a.dat tt'])
tt=[length(na(1,:)) length(na(:,1)) .125 .125];
eval(['save -ascii -append for_mike/section_1_east_composite_ssh_n_a.dat tt'])
tt=na';
eval(['save -ascii -append for_mike/section_1_east_composite_ssh_n_a.dat tt'])

tt=[-3 3 -3 3];
eval(['save -ascii for_mike/section_1_east_composite_ssh_n_c.dat tt'])
tt=[length(nc(1,:)) length(nc(:,1)) .125 .125];
eval(['save -ascii -append for_mike/section_1_east_composite_ssh_n_c.dat tt'])
tt=nc';
eval(['save -ascii -append for_mike/section_1_east_composite_ssh_n_c.dat tt'])


load /matlab/matlab/QG_model/alpha_1_tau_30_comps y_a y_c ssh_a ssh_c
r=17:65;
c=17:65;

compa = double(ssh_c(r,c));
tt=[-3 3 -3 3];
eval(['save -ascii for_mike/model_alpha_1_composite_ssh_median_a.dat tt'])
tt=[length(compa(1,:)) length(compa(:,1)) .125 .125];
eval(['save -ascii -append for_mike/model_alpha_1_composite_ssh_median_a.dat tt'])
tt=compa';
eval(['save -ascii -append for_mike/model_alpha_1_composite_ssh_median_a.dat tt'])

compa = double(y_c(r,c));
tt=[-3 3 -3 3];
eval(['save -ascii for_mike/model_alpha_1_composite_tracer_median_a.dat tt'])
tt=[length(compa(1,:)) length(compa(:,1)) .125 .125];
eval(['save -ascii -append for_mike/model_alpha_1_composite_tracer_median_a.dat tt'])
tt=compa';
eval(['save -ascii -append for_mike/model_alpha_1_composite_tracer_median_a.dat tt'])

compa = double(ssh_a(r,c));
tt=[-3 3 -3 3];
eval(['save -ascii for_mike/model_alpha_1_composite_ssh_median_c.dat tt'])
tt=[length(compa(1,:)) length(compa(:,1)) .125 .125];
eval(['save -ascii -append for_mike/model_alpha_1_composite_ssh_median_c.dat tt'])
tt=compa';
eval(['save -ascii -append for_mike/model_alpha_1_composite_ssh_median_c.dat tt'])

compa = double(y_c(r,c));
tt=[-3 3 -3 3];
eval(['save -ascii for_mike/model_alpha_1_composite_tracer_median_c.dat tt'])
tt=[length(compa(1,:)) length(compa(:,1)) .125 .125];
eval(['save -ascii -append for_mike/model_alpha_1_composite_tracer_median_c.dat tt'])
tt=compa';
eval(['save -ascii -append for_mike/model_alpha_1_composite_tracer_median_c.dat tt'])

load /matlab/matlab/QG_model/alpha_2_tau_30_comps y_a y_c ssh_a ssh_c
r=17:65;
c=17:65;

compa = double(ssh_c(r,c));
tt=[-3 3 -3 3];
eval(['save -ascii for_mike/model_alpha_2_composite_ssh_median_a.dat tt'])
tt=[length(compa(1,:)) length(compa(:,1)) .125 .125];
eval(['save -ascii -append for_mike/model_alpha_2_composite_ssh_median_a.dat tt'])
tt=compa';
eval(['save -ascii -append for_mike/model_alpha_2_composite_ssh_median_a.dat tt'])

compa = double(y_c(r,c));
tt=[-3 3 -3 3];
eval(['save -ascii for_mike/model_alpha_2_composite_tracer_median_a.dat tt'])
tt=[length(compa(1,:)) length(compa(:,1)) .125 .125];
eval(['save -ascii -append for_mike/model_alpha_2_composite_tracer_median_a.dat tt'])
tt=compa';
eval(['save -ascii -append for_mike/model_alpha_2_composite_tracer_median_a.dat tt'])

compa = double(ssh_a(r,c));
tt=[-3 3 -3 3];
eval(['save -ascii for_mike/model_alpha_2_composite_ssh_median_c.dat tt'])
tt=[length(compa(1,:)) length(compa(:,1)) .125 .125];
eval(['save -ascii -append for_mike/model_alpha_2_composite_ssh_median_c.dat tt'])
tt=compa';
eval(['save -ascii -append for_mike/model_alpha_2_composite_ssh_median_c.dat tt'])

compa = double(y_c(r,c));
tt=[-3 3 -3 3];
eval(['save -ascii for_mike/model_alpha_2_composite_tracer_median_c.dat tt'])
tt=[length(compa(1,:)) length(compa(:,1)) .125 .125];
eval(['save -ascii -append for_mike/model_alpha_2_composite_tracer_median_c.dat tt'])
tt=compa';
eval(['save -ascii -append for_mike/model_alpha_2_composite_tracer_median_c.dat tt'])

load /matlab/matlab/QG_model/alpha_3_tau_30_comps y_a y_c ssh_a ssh_c
r=17:65;
c=17:65;

compa = double(ssh_c(r,c));
tt=[-3 3 -3 3];
eval(['save -ascii for_mike/model_alpha_3_composite_ssh_median_a.dat tt'])
tt=[length(compa(1,:)) length(compa(:,1)) .125 .125];
eval(['save -ascii -append for_mike/model_alpha_3_composite_ssh_median_a.dat tt'])
tt=compa';
eval(['save -ascii -append for_mike/model_alpha_3_composite_ssh_median_a.dat tt'])

compa = double(y_c(r,c));
tt=[-3 3 -3 3];
eval(['save -ascii for_mike/model_alpha_3_composite_tracer_median_a.dat tt'])
tt=[length(compa(1,:)) length(compa(:,1)) .125 .125];
eval(['save -ascii -append for_mike/model_alpha_3_composite_tracer_median_a.dat tt'])
tt=compa';
eval(['save -ascii -append for_mike/model_alpha_3_composite_tracer_median_a.dat tt'])

compa = double(ssh_a(r,c));
tt=[-3 3 -3 3];
eval(['save -ascii for_mike/model_alpha_3_composite_ssh_median_c.dat tt'])
tt=[length(compa(1,:)) length(compa(:,1)) .125 .125];
eval(['save -ascii -append for_mike/model_alpha_3_composite_ssh_median_c.dat tt'])
tt=compa';
eval(['save -ascii -append for_mike/model_alpha_3_composite_ssh_median_c.dat tt'])

compa = double(y_c(r,c));
tt=[-3 3 -3 3];
eval(['save -ascii for_mike/model_alpha_3_composite_tracer_median_c.dat tt'])
tt=[length(compa(1,:)) length(compa(:,1)) .125 .125];
eval(['save -ascii -append for_mike/model_alpha_3_composite_tracer_median_c.dat tt'])
tt=compa';
eval(['save -ascii -append for_mike/model_alpha_3_composite_tracer_median_c.dat tt'])
