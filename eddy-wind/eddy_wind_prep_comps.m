clear all

load /Volumes/matlab/matlab/eddy-wind/norm_comps_16_weeks
zgrid_grid
[r,c]=imap(-3,3,-3,3,yi,xi);
xi=xi(r,c);
yi=yi(r,c);
dist=sqrt(xi.^2+yi.^2);
dist=interp2(dist,2);
ii=find(dist<=1.5);

track_file={'oID','oSPC','oNPC','oSAT','oNAT'}
w=2:2:12;


for n=1:length(track_file)
crla=[track_file{n} '_crl_a'];
crlc=[track_file{n} '_crl_c'];
crlga=[track_file{n} '_crlg_a'];
crlgc=[track_file{n} '_crlg_c'];
foia=[track_file{n} '_foi_a'];
foic=[track_file{n} '_foi_c'];
spda=[track_file{n} '_spd_a'];
spdc=[track_file{n} '_spd_c'];
chla=[track_file{n} '_achl_a'];
chlc=[track_file{n} '_achl_c'];



eval(['ttt=interp2(' crla '.N(r,c),2);'])
mask_min=nan*ttt;
eval(['mask_min((ttt./' crla '.n_max_sample)>=.1)=1;'])
mask_maj=nan*ttt;
mask_maj(ii)=1;
eval(['tmp = double(interp2(' crla '.mean(r,c),2).*mask_min);'])
%{

cplot_comps_cont_3_3(tmp.*1e5,tmp.*1e5,-.25,.25,.05,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/comps/' crla '_bg'])
eval(['tmp = double(interp2(' crla '.mean(r,c),2).*mask_maj);'])	
cplot_comps_cont_3_3(tmp.*1e5,tmp.*1e5,-.25,.25,.05,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/comps/' crla])
	
eval(['ttt=interp2(' crlga '.N(r,c),2);'])
mask_min=ones(size(ttt));
eval(['tmp = double(interp2(' crlga '.mean(r,c),2).*mask_min);'])
cplot_comps_cont_3_3(tmp.*1e5,tmp.*1e5,-.45,.45,.05,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/comps/' crlga '_bg'])
eval(['tmp = double(interp2(' crlga '.mean(r,c),2).*mask_maj);'])	
cplot_comps_cont_3_3(tmp.*1e5,tmp.*1e5,-.45,.45,.05,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/comps/' crlga])	

eval(['ttt=interp2(' crlc '.N(r,c),2);'])
mask_min=ones(size(ttt));
eval(['tmp = double(interp2(' crlc '.mean(r,c),2).*mask_min);'])
cplot_comps_cont_3_3(tmp.*1e5,tmp.*1e5,-.45,.45,.05,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/comps/' crlc '_bg'])
eval(['tmp = double(interp2(' crlc '.mean(r,c),2).*mask_maj);'])	
cplot_comps_cont_3_3(tmp.*1e5,tmp.*1e5,-.45,.45,.05,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/comps/' crlc])	

eval(['ttt=interp2(' crlgc '.N(r,c),2);'])
mask_min=ones(size(ttt));
eval(['tmp = double(interp2(' crlgc '.mean(r,c),2).*mask_min);'])
cplot_comps_cont_3_3(tmp.*1e5,tmp.*1e5,-.45,.45,.05,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/comps/' crlgc '_bg'])
eval(['tmp = double(interp2(' crlgc '.mean(r,c),2).*mask_maj);'])	
cplot_comps_cont_3_3(tmp.*1e5,tmp.*1e5,-.45,.45,.05,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/comps/' crlgc])		
%}	
eval(['ttt=interp2(' chlc '.N(r,c),2);'])
mask_min=ones(size(ttt));
eval(['tmp = double(interp2(' chlc '.mean(r,c),2).*mask_min);'])
cplot_comps_cont_3_3(tmp,tmp,-.04,.04,.01,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/comps/' chlc '_bg'])
eval(['tmp = double(interp2(' chlc '.mean(r,c),2).*mask_maj);'])	
cplot_comps_cont_3_3(tmp,tmp,-.04,.04,.01,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/comps/' chlc])		

eval(['ttt=interp2(' chla '.N(r,c),2);'])
mask_min=ones(size(ttt));
eval(['tmp = double(interp2(' chla '.mean(r,c),2).*mask_min);'])
cplot_comps_cont_3_3(tmp,tmp,-.04,.04,.01,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/comps/' chla '_bg'])
eval(['tmp = double(interp2(' chla '.mean(r,c),2).*mask_maj);'])	
cplot_comps_cont_3_3(tmp,tmp,-.04,.04,.01,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/comps/' chla])			
%{
%
ii=find(dist<=2.25);
mask_maj(ii)=1;
%
eval(['ttt=interp2(' foia '.N(r,c),2);'])
mask_min=ones(size(ttt));
eval(['tmp = double(interp2(' foia '.mean(r,c),2).*mask_min);'])
cplot_comps_cont_3_3(tmp,tmp,-.45,.45,.05,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/comps/' foia '_bg'])
eval(['tmp = double(interp2(' foia '.mean(r,c),2).*mask_maj);'])	
cplot_comps_cont_3_3(tmp,tmp,-.45,.45,.05,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/comps/' foia])	
	
eval(['ttt=interp2(' foic '.N(r,c),2);'])
mask_min=ones(size(ttt));
eval(['tmp = double(interp2(' foic '.mean(r,c),2).*mask_min);'])
cplot_comps_cont_3_3(tmp,tmp,-.45,.45,.05,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/comps/' foic '_bg'])
eval(['tmp = double(interp2(' foic '.mean(r,c),2).*mask_maj);'])	
cplot_comps_cont_3_3(tmp,tmp,-.45,.45,.05,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/comps/' foic])		
	
eval(['ttt=interp2(' spda '.N(r,c),2);'])
mask_min=ones(size(ttt));
eval(['tmp = double(interp2(' spda '.mean(r,c),2).*mask_min);'])
cplot_comps_cont_3_3(tmp,tmp,-.45,.45,.05,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/comps/' spda '_bg'])
eval(['tmp = double(interp2(' spda '.mean(r,c),2).*mask_maj);'])	
cplot_comps_cont_3_3(tmp,tmp,-.45,.45,.05,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/comps/' spda])	
	
eval(['ttt=interp2(' spdc '.N(r,c),2);'])
mask_min=ones(size(ttt));
eval(['tmp = double(interp2(' spdc '.mean(r,c),2).*mask_min);'])
cplot_comps_cont_3_3(tmp,tmp,-.45,.45,.05,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/comps/' spdc '_bg'])
eval(['tmp = double(interp2(' spdc '.mean(r,c),2).*mask_maj);'])	
cplot_comps_cont_3_3(tmp,tmp,-.45,.45,.05,-1,1,...
	['~/Documents/OSU/figures/eddy-wind/comps/' spdc])	
%}
end
	