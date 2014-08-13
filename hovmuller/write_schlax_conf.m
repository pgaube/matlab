clear all
%
!rm for_mike/*composit*
load conf_intervals

stdcc=double(std_midlat_N_cc);
stdcc(isnan(stdcc))=1e35;

stdc=double(std_midlat_N_c);
stdc(isnan(stdc))=1e35;


tt=[-2 2 -2 2];
eval(['save -ascii for_mike/global_composite_all_amp_northward_grad_chl_std_cc.dat tt'])
tt=[length(stdcc(1,:)) length(stdcc(:,1)) .0625 .0625];
eval(['save -ascii -append for_mike/global_composite_all_amp_northward_grad_chl_std_cc.dat tt'])
tt=stdcc';
eval(['save -ascii -append for_mike/global_composite_all_amp_northward_grad_chl_std_cc.dat tt'])

tt=[-2 2 -2 2];
eval(['save -ascii for_mike/global_composite_all_amp_northward_grad_chl_std_c.dat tt'])
tt=[length(stdc(1,:)) length(stdc(:,1)) .0625 .0625];
eval(['save -ascii -append for_mike/global_composite_all_amp_northward_grad_chl_std_c.dat tt'])
tt=stdc';
eval(['save -ascii -append for_mike/global_composite_all_amp_northward_grad_chl_std_c.dat tt'])

stdcc=double(std_midlat_S_cc);
stdcc(isnan(stdcc))=1e35;

stdc=double(std_midlat_S_c);
stdc(isnan(stdc))=1e35;

tt=[-2 2 -2 2];
eval(['save -ascii for_mike/global_composite_all_amp_southward_grad_chl_std_cc.dat tt'])
tt=[length(stdcc(1,:)) length(stdcc(:,1)) .0625 .0625];
eval(['save -ascii -append for_mike/global_composite_all_amp_southward_grad_chl_std_cc.dat tt'])
tt=stdcc';
eval(['save -ascii -append for_mike/global_composite_all_amp_southward_grad_chl_std_cc.dat tt'])

tt=[-2 2 -2 2];
eval(['save -ascii for_mike/global_composite_all_amp_southward_grad_chl_std_c.dat tt'])
tt=[length(stdc(1,:)) length(stdc(:,1)) .0625 .0625];
eval(['save -ascii -append for_mike/global_composite_all_amp_southward_grad_chl_std_c.dat tt'])
tt=stdc';
eval(['save -ascii -append for_mike/global_composite_all_amp_southward_grad_chl_std_c.dat tt'])


stdcc=double(std_24_cc);
stdcc(isnan(stdcc))=1e35;

stdc=double(std_24_c);
stdc(isnan(stdc))=1e35;

tt=[-2 2 -2 2];
eval(['save -ascii for_mike/vocals_composite_chl_std_cc.dat tt'])
tt=[length(stdcc(1,:)) length(stdcc(:,1)) .0625 .0625];
eval(['save -ascii -append for_mike/vocals_composite_chl_std_cc.dat tt'])
tt=stdcc';
eval(['save -ascii -append for_mike/vocals_composite_chl_std_cc.dat tt'])

tt=[-2 2 -2 2];
eval(['save -ascii for_mike/vocals_composite_chl_std_c.dat tt'])
tt=[length(stdc(1,:)) length(stdc(:,1)) .0625 .0625];
eval(['save -ascii -append for_mike/vocals_composite_chl_std_c.dat tt'])
tt=stdc';
eval(['save -ascii -append for_mike/vocals_composite_chl_std_c.dat tt'])

stdcc=double(std_30_cc);
stdcc(isnan(stdcc))=1e35;

stdc=double(std_30_c);
stdc(isnan(stdc))=1e35;

tt=[-2 2 -2 2];
eval(['save -ascii for_mike/vocals_west_composite_chl_std_cc.dat tt'])
tt=[length(stdcc(1,:)) length(stdcc(:,1)) .0625 .0625];
eval(['save -ascii -append for_mike/vocals_west_composite_chl_std_cc.dat tt'])
tt=stdcc';
eval(['save -ascii -append for_mike/vocals_west_composite_chl_std_cc.dat tt'])

tt=[-2 2 -2 2];
eval(['save -ascii for_mike/vocals_west_composite_chl_std_c.dat tt'])
tt=[length(stdc(1,:)) length(stdc(:,1)) .0625 .0625];
eval(['save -ascii -append for_mike/vocals_west_composite_chl_std_c.dat tt'])
tt=stdc';
eval(['save -ascii -append for_mike/vocals_west_composite_chl_std_c.dat tt'])

stdcc=double(std_31_cc);
stdcc(isnan(stdcc))=1e35;

stdc=double(std_31_c);
stdc(isnan(stdc))=1e35;
tt=[-2 2 -2 2];
eval(['save -ascii for_mike/vocals_east_composite_chl_std_cc.dat tt'])
tt=[length(stdcc(1,:)) length(stdcc(:,1)) .0625 .0625];
eval(['save -ascii -append for_mike/vocals_east_composite_chl_std_cc.dat tt'])
tt=stdcc';
eval(['save -ascii -append for_mike/vocals_east_composite_chl_std_cc.dat tt'])

tt=[-2 2 -2 2];
eval(['save -ascii for_mike/vocals_east_composite_chl_std_c.dat tt'])
tt=[length(stdc(1,:)) length(stdc(:,1)) .0625 .0625];
eval(['save -ascii -append for_mike/vocals_east_composite_chl_std_c.dat tt'])
tt=stdc';
eval(['save -ascii -append for_mike/vocals_east_composite_chl_std_c.dat tt'])



r=17:65;
c=17:65;


compa = double(std_3_y_cc(r,c));
tt=[-3 3 -3 3];
eval(['save -ascii for_mike/model_alpha_3_composite_tracer_std_cc.dat tt'])
tt=[length(compa(1,:)) length(compa(:,1)) .125 .125];
eval(['save -ascii -append for_mike/model_alpha_3_composite_tracer_std_cc.dat tt'])
tt=compa';
eval(['save -ascii -append for_mike/model_alpha_3_composite_tracer_std_cc.dat tt'])


compa = double(std_3_y_c(r,c));
tt=[-3 3 -3 3];
eval(['save -ascii for_mike/model_alpha_3_composite_tracer_std_c.dat tt'])
tt=[length(compa(1,:)) length(compa(:,1)) .125 .125];
eval(['save -ascii -append for_mike/model_alpha_3_composite_tracer_std_c.dat tt'])
tt=compa';
eval(['save -ascii -append for_mike/model_alpha_3_composite_tracer_std_c.dat tt'])

compa = double(std_1_y_cc(r,c));
tt=[-3 3 -3 3];
eval(['save -ascii for_mike/model_alpha_1_composite_tracer_std_cc.dat tt'])
tt=[length(compa(1,:)) length(compa(:,1)) .125 .125];
eval(['save -ascii -append for_mike/model_alpha_1_composite_tracer_std_cc.dat tt'])
tt=compa';
eval(['save -ascii -append for_mike/model_alpha_1_composite_tracer_std_cc.dat tt'])


compa = double(std_1_y_c(r,c));
tt=[-3 3 -3 3];
eval(['save -ascii for_mike/model_alpha_1_composite_tracer_std_c.dat tt'])
tt=[length(compa(1,:)) length(compa(:,1)) .125 .125];
eval(['save -ascii -append for_mike/model_alpha_1_composite_tracer_std_c.dat tt'])
tt=compa';
eval(['save -ascii -append for_mike/model_alpha_1_composite_tracer_std_c.dat tt'])
