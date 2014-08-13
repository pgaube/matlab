
clear all
%{

load tracks/midlat_tracks	

%{
ii=find(amp>0 & amp<=5);
[a5_bp26_crl_c,a5_bp26_crl_cc]=clock_comps(id(ii),track_jday(ii),y(ii),'nrbp26_crl_sample','n');
[a5_bp26_crlg_c,a5_bp26_crlg_cc]=clock_comps(id(ii),track_jday(ii),y(ii),'nrbp26_crlg_sample','n');

ii=find(amp>5 & amp<=10);
[a10_bp26_crl_c,a10_bp26_crl_cc]=clock_comps(id(ii),track_jday(ii),y(ii),'nrbp26_crl_sample','n');
[a10_bp26_crlg_c,a10_bp26_crlg_cc]=clock_comps(id(ii),track_jday(ii),y(ii),'nrbp26_crlg_sample','n');

ii=find(amp>10 & amp<=15);
[a15_bp26_crl_c,a15_bp26_crl_cc]=clock_comps(id(ii),track_jday(ii),y(ii),'nrbp26_crl_sample','n');
[a15_bp26_crlg_c,a15_bp26_crlg_cc]=clock_comps(id(ii),track_jday(ii),y(ii),'nrbp26_crlg_sample','n');

ii=find(amp>15 & amp<=20);
[a20_bp26_crl_c,a20_bp26_crl_cc]=clock_comps(id(ii),track_jday(ii),y(ii),'nrbp26_crl_sample','n');
[a20_bp26_crlg_c,a20_bp26_crlg_cc]=clock_comps(id(ii),track_jday(ii),y(ii),'nrbp26_crlg_sample','n');

ii=find(amp>20);
[a30_bp26_crl_c,a30_bp26_crl_cc]=clock_comps(id(ii),track_jday(ii),y(ii),'nrbp26_crl_sample','n');
[a30_bp26_crlg_c,a30_bp26_crlg_cc]=clock_comps(id(ii),track_jday(ii),y(ii),'nrbp26_crlg_sample','n');
%}

%75 80 85 90 95
%9.1000   10.4000   12.4000   15.6000   22.7000

ii=find(amp>=9.1 & amp<10.4);
%[p80_bp26_crl_c,p80_bp26_crl_cc]=clock_comps(id(ii),track_jday(ii),y(ii),'nrbp26_crl_sample','n');
%[p80_bp26_crlg_c,p80_bp26_crlg_cc]=clock_comps(id(ii),track_jday(ii),y(ii),'nrbp26_crlg_sample','n');
[p80_bp26_na_c,p80_bp26_na_cc]=clock_comps(id(ii),track_jday(ii),y(ii),'nrna_crlg_sample','n');

ii=find(amp>=10.4 & amp<12.4);
%[p85_bp26_crl_c,p85_bp26_crl_cc]=clock_comps(id(ii),track_jday(ii),y(ii),'nrbp26_crl_sample','n');
%[p85_bp26_crlg_c,p85_bp26_crlg_cc]=clock_comps(id(ii),track_jday(ii),y(ii),'nrbp26_crlg_sample','n');
[p85_bp26_na_c,p85_bp26_na_cc]=clock_comps(id(ii),track_jday(ii),y(ii),'nrna_crlg_sample','n');

ii=find(amp>=12.4 & amp<15.6);
%[p90_bp26_crl_c,p90_bp26_crl_cc]=clock_comps(id(ii),track_jday(ii),y(ii),'nrbp26_crl_sample','n');
%[p90_bp26_crlg_c,p90_bp26_crlg_cc]=clock_comps(id(ii),track_jday(ii),y(ii),'nrbp26_crlg_sample','n');
[p90_bp26_na_c,p90_bp26_na_cc]=clock_comps(id(ii),track_jday(ii),y(ii),'nrna_crlg_sample','n');


save -append midlat_crls_amp_compos


return
%}
load midlat_crls_amp_compos


fbc=['p80_bp26_crlg_c.std'];
flc=['p80_bp26_crlg_c'];
eval(['tmp2 = double(interp2(',fbc,',2));'])
cplot_comps_cont_pos_scale_2_2(1e5*tmp2,1e5*tmp2,.23,.29,.01,-1,1,['cw 80% -@MAiD@ u_g^'],...
	['~/Documents/OSU/figures/air-sea/comps/std/',flc])
	
fbc=['p80_bp26_crl_c.std'];
flc=['p80_bp26_crl_c'];
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_pos_scale_2_2(1e5*tmp,1e5*tmp,.29,.33,.01,-1,1,['cw 80% @MAiD@ u_w^'],...
	['~/Documents/OSU/figures/air-sea/comps/std/',flc])
	
fbc=['p80_bp26_na_c.std'];
flc=['p80_bp26_na_c'];
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_pos_scale_2_2(1e5*tmp,1e5*tmp,.35,.4,.01,-1,1,['cw 80% @MAiD@ u_na^'],...
	['~/Documents/OSU/figures/air-sea/comps/std/',flc])	

fbc=['p80_bp26_crlg_cc.std'];
flc=['p80_bp26_crlg_cc'];
eval(['tmp2 = double(interp2(',fbc,',2));'])
cplot_comps_cont_pos_scale_2_2(1e5*tmp2,1e5*tmp2,.23,.29,.01,-1,1,['cc 80% -@MAiD@ u_g^'],...
	['~/Documents/OSU/figures/air-sea/comps/std/',flc])
	
fbc=['p80_bp26_crl_cc.std'];
flc=['p80_bp26_crl_cc'];
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_pos_scale_2_2(1e5*tmp,1e5*tmp,.29,.33,.01,-1,1,['cc 80% @MAiD@ u_w^'],...
	['~/Documents/OSU/figures/air-sea/comps/std/',flc])
	
fbc=['p80_bp26_na_cc.std'];
flc=['p80_bp26_na_cc'];
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_pos_scale_2_2(1e5*tmp,1e5*tmp,.35,.4,.01,-1,1,['cc 80% @MAiD@ u_na^'],...
	['~/Documents/OSU/figures/air-sea/comps/std/',flc])	

fbc=['p85_bp26_crlg_c.std'];
flc=['p85_bp26_crlg_c'];
eval(['tmp2 = double(interp2(',fbc,',2));'])
cplot_comps_cont_pos_scale_2_2(1e5*tmp2,1e5*tmp2,.235,.305,.01,-1,1,['cw 85% -@MAiD@ u_g^'],...
	['~/Documents/OSU/figures/air-sea/comps/std/',flc])
	
fbc=['p85_bp26_crl_c.std'];
flc=['p85_bp26_crl_c'];
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_pos_scale_2_2(1e5*tmp,1e5*tmp,.3,.34,.01,-1,1,['cw 85% @MAiD@ u_w^'],...
	['~/Documents/OSU/figures/air-sea/comps/std/',flc])	

fbc=['p85_bp26_na_c.std'];
flc=['p85_bp26_na_c'];
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_pos_scale_2_2(1e5*tmp,1e5*tmp,.35,.4,.01,-1,1,['cw 85% @MAiD@ u_na^'],...
	['~/Documents/OSU/figures/air-sea/comps/std/',flc])		
	
fbc=['p85_bp26_crlg_cc.std'];
flc=['p85_bp26_crlg_cc'];
eval(['tmp2 = double(interp2(',fbc,',2));'])
cplot_comps_cont_pos_scale_2_2(1e5*tmp2,1e5*tmp2,.235,.305,.01,-1,1,['cc 85% -@MAiD@ u_g^'],...
	['~/Documents/OSU/figures/air-sea/comps/std/',flc])
	
fbc=['p85_bp26_crl_cc.std'];
flc=['p85_bp26_crl_cc'];
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_pos_scale_2_2(1e5*tmp,1e5*tmp,.3,.34,.01,-1,1,['cc 85% @MAiD@ u_w^'],...
	['~/Documents/OSU/figures/air-sea/comps/std/',flc])	
	
fbc=['p85_bp26_na_cc.std'];
flc=['p85_bp26_na_cc'];
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_pos_scale_2_2(1e5*tmp,1e5*tmp,.35,.4,.01,-1,1,['cc 85% @MAiD@ u_na^'],...
	['~/Documents/OSU/figures/air-sea/comps/std/',flc])		
	
fbc=['p90_bp26_crlg_c.std'];
flc=['p90_bp26_crlg_c'];
eval(['tmp2 = double(interp2(',fbc,',2));'])
cplot_comps_cont_pos_scale_2_2(1e5*tmp2,1e5*tmp2,.26,.34,.01,-1,1,['cw 90% -@MAiD@ u_g^'],...
	['~/Documents/OSU/figures/air-sea/comps/std/',flc])
	
fbc=['p90_bp26_crl_c.std'];
flc=['p90_bp26_crl_c'];
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_pos_scale_2_2(1e5*tmp,1e5*tmp,.32,.36,.01,-1,1,['cw 90% @MAiD@ u_w^'],...
	['~/Documents/OSU/figures/air-sea/comps/std/',flc])	
	
fbc=['p90_bp26_na_c.std'];
flc=['p90_bp26_na_c'];
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_pos_scale_2_2(1e5*tmp,1e5*tmp,.36,.43,.01,-1,1,['cw 90% @MAiD@ u_na^'],...
	['~/Documents/OSU/figures/air-sea/comps/std/',flc])		

fbc=['p90_bp26_crlg_cc.std'];
flc=['p90_bp26_crlg_cc'];
eval(['tmp2 = double(interp2(',fbc,',2));'])
cplot_comps_cont_pos_scale_2_2(1e5*tmp2,1e5*tmp2,.26,.34,.01,-1,1,['cc 90% -@MAiD@ u_g^'],...
	['~/Documents/OSU/figures/air-sea/comps/std/',flc])
	
fbc=['p90_bp26_crl_cc.std'];
flc=['p90_bp26_crl_cc'];
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_pos_scale_2_2(1e5*tmp,1e5*tmp,.32,.36,.01,-1,1,['cc 90% @MAiD@ u_w^'],...
	['~/Documents/OSU/figures/air-sea/comps/std/',flc])		
		
fbc=['p90_bp26_na_cc.std'];
flc=['p90_bp26_na_cc'];
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_pos_scale_2_2(1e5*tmp,1e5*tmp,.36,.43,.01,-1,1,['cc 90% @MAiD@ u_na^'],...
	['~/Documents/OSU/figures/air-sea/comps/std/',flc])			

return
fbc=['a5_bp26_crlg_c.std'];
flc=['a5_bp26_crlg_c'];
eval(['tmp2 = double(interp2(',fbc,',2));'])
cplot_comps_cont_pos_scale_2_2(1e5*tmp2,1e5*tmp2,.13,.18,.01,-1,1,['cw >5cm -@MAiD@ u_g^'],...
	['~/Documents/OSU/figures/air-sea/comps/std/',flc])
	
fbc=['a5_bp26_crl_c.std'];
flc=['a5_bp26_crl_c'];
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_pos_scale_2_2(1e5*tmp,1e5*tmp,.26,.28,.01,-1,1,['cw >5cm @MAiD@ u_w^'],...
	['~/Documents/OSU/figures/air-sea/comps/std/',flc])

fbc=['a5_bp26_crlg_cc.std'];
flc=['a5_bp26_crlg_cc'];
eval(['tmp2 = double(interp2(',fbc,',2));'])
cplot_comps_cont_pos_scale_2_2(1e5*tmp2,1e5*tmp2,.13,.18,.01,-1,1,['cc >5cm -@MAiD@ u_g^'],...
	['~/Documents/OSU/figures/air-sea/comps/std/',flc])
	
fbc=['a5_bp26_crl_cc.std'];
flc=['a5_bp26_crl_cc'];
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_pos_scale_2_2(1e5*tmp,1e5*tmp,.26,.28,.01,-1,1,['cc >5cm @MAiD@ u_w^'],...
	['~/Documents/OSU/figures/air-sea/comps/std/',flc])
	
fbc=['a10_bp26_crlg_c.std'];
flc=['a10_bp26_crlg_c'];
eval(['tmp2 = double(interp2(',fbc,',2));'])
cplot_comps_cont_pos_scale_2_2(1e5*tmp2,1e5*tmp2,.19,.25,.01,-1,1,['cw >10cm -@MAiD@ u_g^'],...
	['~/Documents/OSU/figures/air-sea/comps/std/',flc])
	
fbc=['a10_bp26_crl_c.std'];
flc=['a10_bp26_crl_c'];
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_pos_scale_2_2(1e5*tmp,1e5*tmp,.28,.31,.01,-1,1,['cw >10cm @MAiD@ u_w^'],...
	['~/Documents/OSU/figures/air-sea/comps/std/',flc])

fbc=['a10_bp26_crlg_cc.std'];
flc=['a10_bp26_crlg_cc'];
eval(['tmp2 = double(interp2(',fbc,',2));'])
cplot_comps_cont_pos_scale_2_2(1e5*tmp2,1e5*tmp2,.19,.25,.01,-1,1,['cc >10cm -@MAiD@ u_g^'],...
	['~/Documents/OSU/figures/air-sea/comps/std/',flc])
	
fbc=['a10_bp26_crl_cc.std'];
flc=['a10_bp26_crl_cc'];
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_pos_scale_2_2(1e5*tmp,1e5*tmp,.28,.31,.01,-1,1,['cc >10cm @MAiD@ u_w^'],...
	['~/Documents/OSU/figures/air-sea/comps/std/',flc])

fbc=['a15_bp26_crlg_c.std'];
flc=['a15_bp26_crlg_c'];
eval(['tmp2 = double(interp2(',fbc,',2));'])
cplot_comps_cont_pos_scale_2_2(1e5*tmp2,1e5*tmp2,.19,.25,.01,-1,1,['cw >15cm -@MAiD@ u_g^'],...
	['~/Documents/OSU/figures/air-sea/comps/std/',flc])
	
fbc=['a15_bp26_crl_c.std'];
flc=['a15_bp26_crl_c'];
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_pos_scale_2_2(1e5*tmp,1e5*tmp,.28,.3,.4,.01,-1,1,['cw >15cm @MAiD@ u_w^'],...
	['~/Documents/OSU/figures/air-sea/comps/std/',flc])

fbc=['a15_bp26_crlg_cc.std'];
flc=['a15_bp26_crlg_cc'];
eval(['tmp2 = double(interp2(',fbc,',2));'])
cplot_comps_cont_pos_scale_2_2(1e5*tmp2,1e5*tmp2,.19,.25,.01,-1,1,['cc >15cm -@MAiD@ u_g^'],...
	['~/Documents/OSU/figures/air-sea/comps/std/',flc])
	
fbc=['a15_bp26_crl_cc.std'];
flc=['a15_bp26_crl_cc'];
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_pos_scale_2_2(1e5*tmp,1e5*tmp,.33,.4,.01,-1,1,['cc >15cm @MAiD@ u_w^'],...
	['~/Documents/OSU/figures/air-sea/comps/std/',flc])
	
fbc=['a20_bp26_crlg_c.std'];
flc=['a20_bp26_crlg_c'];
eval(['tmp2 = double(interp2(',fbc,',2));'])
cplot_comps_cont_pos_scale_2_2(1e5*tmp2,1e5*tmp2,.33,.4,.01,-1,1,['cw >20cm -@MAiD@ u_g^'],...
	['~/Documents/OSU/figures/air-sea/comps/std/',flc])
	
fbc=['a20_bp26_crl_c.std'];
flc=['a20_bp26_crl_c'];
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_pos_scale_2_2(1e5*tmp,1e5*tmp,.33,.4,.01,-1,1,['cw >20cm @MAiD@ u_w^'],...
	['~/Documents/OSU/figures/air-sea/comps/std/',flc])

fbc=['a20_bp26_crlg_cc.std'];
flc=['a20_bp26_crlg_cc'];
eval(['tmp2 = double(interp2(',fbc,',2));'])
cplot_comps_cont_pos_scale_2_2(1e5*tmp2,1e5*tmp2,.33,.4,.01,-1,1,['cc >20cm -@MAiD@ u_g^'],...
	['~/Documents/OSU/figures/air-sea/comps/std/',flc])
	
fbc=['a20_bp26_crl_cc.std'];
flc=['a20_bp26_crl_cc'];
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_pos_scale_2_2(1e5*tmp,1e5*tmp,.33,.4,.01,-1,1,['cc >20cm @MAiD@ u_w^'],...
	['~/Documents/OSU/figures/air-sea/comps/std/',flc])
	
fbc=['a30_bp26_crlg_c.std'];
flc=['a30_bp26_crlg_c'];
eval(['tmp2 = double(interp2(',fbc,',2));'])
cplot_comps_cont_pos_scale_2_2(1e5*tmp2,1e5*tmp2,.33,.4,.01,-1,1,['cw >30cm -@MAiD@ u_g^'],...
	['~/Documents/OSU/figures/air-sea/comps/std/',flc])
	
fbc=['a30_bp26_crl_c.std'];
flc=['a30_bp26_crl_c'];
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_pos_scale_2_2(1e5*tmp,1e5*tmp,.33,.4,.01,-1,1,['cw >30cm @MAiD@ u_w^'],...
	['~/Documents/OSU/figures/air-sea/comps/std/',flc])

fbc=['a30_bp26_crlg_cc.std'];
flc=['a30_bp26_crlg_cc'];
eval(['tmp2 = double(interp2(',fbc,',2));'])
cplot_comps_cont_pos_scale_2_2(1e5*tmp2,1e5*tmp2,.33,.4,.01,-1,1,['cc >30cm -@MAiD@ u_g^'],...
	['~/Documents/OSU/figures/air-sea/comps/std/',flc])
	
fbc=['a30_bp26_crl_cc.std'];
flc=['a30_bp26_crl_cc'];
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_pos_scale_2_2(1e5*tmp,1e5*tmp,.33,.4,.01,-1,1,['cc >30cm @MAiD@ u_w^'],...
	['~/Documents/OSU/figures/air-sea/comps/std/',flc])	
	
return
%means
fbc=['a5_bp26_crlg_c.mean'];
flc=['a5_bp26_crlg_c'];
eval(['tmp2 = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(-1e6*tmp2,-1e6*tmp2,-6,6,1,-10,10,['cw >5cm -@MAiD@ u_g^'],...
	['~/Documents/OSU/figures/air-sea/comps/',flc])
	
fbc=['a5_bp26_crl_c.mean'];
flc=['a5_bp26_crl_c'];
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(1e6*tmp,1e6*tmp,-6,6,1,-10,10,['cw >5cm @MAiD@ u_w^'],...
	['~/Documents/OSU/figures/air-sea/comps/',flc])

fbc=['a5_bp26_crlg_cc.mean'];
flc=['a5_bp26_crlg_cc'];
eval(['tmp2 = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(-1e6*tmp2,-1e6*tmp2,-6,6,1,-10,10,['cc >5cm -@MAiD@ u_g^'],...
	['~/Documents/OSU/figures/air-sea/comps/',flc])
	
fbc=['a5_bp26_crl_cc.mean'];
flc=['a5_bp26_crl_cc'];
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(1e6*tmp,1e6*tmp,-6,6,1,-10,10,['cc >5cm @MAiD@ u_w^'],...
	['~/Documents/OSU/figures/air-sea/comps/',flc])
	
fbc=['a10_bp26_crlg_c.mean'];
flc=['a10_bp26_crlg_c'];
eval(['tmp2 = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(-1e6*tmp2,-1e6*tmp2,-6,6,1,-10,10,['cw >10cm -@MAiD@ u_g^'],...
	['~/Documents/OSU/figures/air-sea/comps/',flc])
	
fbc=['a10_bp26_crl_c.mean'];
flc=['a10_bp26_crl_c'];
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(1e6*tmp,1e6*tmp,-6,6,1,-10,10,['cw >10cm @MAiD@ u_w^'],...
	['~/Documents/OSU/figures/air-sea/comps/',flc])

fbc=['a10_bp26_crlg_cc.mean'];
flc=['a10_bp26_crlg_cc'];
eval(['tmp2 = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(-1e6*tmp2,-1e6*tmp2,-6,6,1,-10,10,['cc >10cm -@MAiD@ u_g^'],...
	['~/Documents/OSU/figures/air-sea/comps/',flc])
	
fbc=['a10_bp26_crl_cc.mean'];
flc=['a10_bp26_crl_cc'];
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(1e6*tmp,1e6*tmp,-6,6,1,-10,10,['cc >10cm @MAiD@ u_w^'],...
	['~/Documents/OSU/figures/air-sea/comps/',flc])

fbc=['a15_bp26_crlg_c.mean'];
flc=['a15_bp26_crlg_c'];
eval(['tmp2 = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(-1e6*tmp2,-1e6*tmp2,-6,6,1,-10,10,['cw >15cm -@MAiD@ u_g^'],...
	['~/Documents/OSU/figures/air-sea/comps/',flc])
	
fbc=['a15_bp26_crl_c.mean'];
flc=['a15_bp26_crl_c'];
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(1e6*tmp,1e6*tmp,-6,6,1,-10,10,['cw >15cm @MAiD@ u_w^'],...
	['~/Documents/OSU/figures/air-sea/comps/',flc])

fbc=['a15_bp26_crlg_cc.mean'];
flc=['a15_bp26_crlg_cc'];
eval(['tmp2 = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(-1e6*tmp2,-1e6*tmp2,-6,6,1,-10,10,['cc >15cm -@MAiD@ u_g^'],...
	['~/Documents/OSU/figures/air-sea/comps/',flc])
	
fbc=['a15_bp26_crl_cc.mean'];
flc=['a15_bp26_crl_cc'];
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(1e6*tmp,1e6*tmp,-6,6,1,-10,10,['cc >15cm @MAiD@ u_w^'],...
	['~/Documents/OSU/figures/air-sea/comps/',flc])
	
fbc=['a20_bp26_crlg_c.mean'];
flc=['a20_bp26_crlg_c'];
eval(['tmp2 = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(-1e6*tmp2,-1e6*tmp2,-6,6,1,-10,10,['cw >20cm -@MAiD@ u_g^'],...
	['~/Documents/OSU/figures/air-sea/comps/',flc])
	
fbc=['a20_bp26_crl_c.mean'];
flc=['a20_bp26_crl_c'];
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(1e6*tmp,1e6*tmp,-6,6,1,-10,10,['cw >20cm @MAiD@ u_w^'],...
	['~/Documents/OSU/figures/air-sea/comps/',flc])

fbc=['a20_bp26_crlg_cc.mean'];
flc=['a20_bp26_crlg_cc'];
eval(['tmp2 = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(-1e6*tmp2,-1e6*tmp2,-6,6,1,-10,10,['cc >20cm -@MAiD@ u_g^'],...
	['~/Documents/OSU/figures/air-sea/comps/',flc])
	
fbc=['a20_bp26_crl_cc.mean'];
flc=['a20_bp26_crl_cc'];
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(1e6*tmp,1e6*tmp,-6,6,1,-10,10,['cc >20cm @MAiD@ u_w^'],...
	['~/Documents/OSU/figures/air-sea/comps/',flc])
	
fbc=['a30_bp26_crlg_c.mean'];
flc=['a30_bp26_crlg_c'];
eval(['tmp2 = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(-1e6*tmp2,-1e6*tmp2,-6,6,1,-10,10,['cw >30cm -@MAiD@ u_g^'],...
	['~/Documents/OSU/figures/air-sea/comps/',flc])
	
fbc=['a30_bp26_crl_c.mean'];
flc=['a30_bp26_crl_c'];
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(1e6*tmp,1e6*tmp,-6,6,1,-10,10,['cw >30cm @MAiD@ u_w^'],...
	['~/Documents/OSU/figures/air-sea/comps/',flc])

fbc=['a30_bp26_crlg_cc.mean'];
flc=['a30_bp26_crlg_cc'];
eval(['tmp2 = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(-1e6*tmp2,-1e6*tmp2,-6,6,1,-10,10,['cc >30cm -@MAiD@ u_g^'],...
	['~/Documents/OSU/figures/air-sea/comps/',flc])
	
fbc=['a30_bp26_crl_cc.mean'];
flc=['a30_bp26_crl_cc'];
eval(['tmp = double(interp2(',fbc,',2));'])
cplot_comps_cont_2_2(1e6*tmp,1e6*tmp,-6,6,1,-10,10,['cc >30cm @MAiD@ u_w^'],...
	['~/Documents/OSU/figures/air-sea/comps/',flc])	