clear all
%{
load /matlab/matlab/regions/tracks/orgin/lw_tracks 
[yeaa,mona,daya]=jd2jdate(track_jday);
mon=['jan';'feb';'mar';'apr';'may';'jun';'jul';'aug';'sep';'oct';'nov';'dec'];
%{
for m=1:length(mon)
	ii=find(mona==m);
	eval(['[' mon(m,:) '_car_N_a,' mon(m,:) '_car_N_c]=dir_clock_comps(id(ii),track_jday(ii),y(ii),' ...
	char(39) 'nrsp66_car_sample' char(39) ',' char(39) 'N' char(39) ',' char(39) 'c' char(39) ')'])
end
%}
 

ii=find(mona>=5 & mona<=9);
%[win_car_N_a,win_car_N_c]=dir_clock_comps(id(ii),track_jday(ii),y(ii),'nrsp66_car_sample','N','c');
%[win_car_S_a,win_car_S_c]=dir_clock_comps(id(ii),track_jday(ii),y(ii),'nrsp66_car_sample','S','c');
%[win_sst_N_a,win_sst_N_c]=dir_clock_comps(id(ii),track_jday(ii),y(ii),'nrbp26_sst_sample','N','t');
[win_chl_S_a,win_chl_S_c]=dir_clock_comps(id(ii),track_jday(ii),y(ii),'nrsp66_chl_sample','S','g');
save -append EK_rot_comps
return
%}
load EK_rot_comps
	
ran=[-.4 .4]
flc='win_c_sst_N';
tmp = double(interp2(win_sst_N_a.median,2));
tmp2 = double(interp2(win_sst_N_a.median,2));
cplot_comps_cont_2_2(tmp,tmp2,ran(1),ran(2),.1,-1,1,['CC northward @MAi@ T N=',num2str(win_sst_N_a.n_max_sample)],...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/rot/',flc]) 

fla='win_a_sst_N';
tmp = double(interp2(win_sst_N_c.median,2));
tmp2 = double(interp2(win_sst_N_c.median,2));
cplot_comps_cont_2_2(tmp,tmp2,ran(1),ran(2),.1,-1,1,['AC northward @MAi@ T N=',num2str(win_sst_N_c.n_max_sample)],...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/rot/',fla])

ran=[-.4 .4]
flc='win_c_c_N';
tmp = double(interp2(win_car_N_a.median,2));
tmp2 = double(interp2(win_car_N_a.median,2));
cplot_comps_cont_2_2(tmp,tmp2,ran(1),ran(2),.1,-10,10,['CC northward @MAi@ C N=',num2str(win_car_N_a.n_max_sample)],...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/rot/',flc]) 


fla='win_a_c_N';
tmp = double(interp2(win_car_N_c.median,2));
tmp2 = double(interp2(win_car_N_c.median,2));
cplot_comps_cont_2_2(tmp,tmp2,ran(1),ran(2),.1,-10,10,['AC northward @MAi@ C N=',num2str(win_car_N_c.n_max_sample)],...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/rot/',fla])
	
flc='win_c_c_S';
tmp = double(interp2(win_car_S_a.median,2));
tmp2 = double(interp2(win_car_S_a.median,2));
cplot_comps_cont_2_2(tmp,tmp2,ran(1),ran(2),.1,-10,10,['CC southward @MAi@ C N=',num2str(win_car_S_a.n_max_sample)],...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/rot/',flc]) 


fla='win_a_c_S';
tmp = double(interp2(win_car_S_c.median,2));
tmp2 = double(interp2(win_car_S_c.median,2));
cplot_comps_cont_2_2(tmp,tmp2,ran(1),ran(2),.1,-10,10,['AC southward @MAi@ C N=',num2str(win_car_S_c.n_max_sample)],...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/rot/',fla])

ran=[-.005 .005]
flc='win_c_chl_S';
tmp = double(interp2(win_chl_S_a.median,2));
tmp2 = double(interp2(win_chl_S_a.median,2));
cplot_comps_cont_2_2(tmp,tmp2,ran(1),ran(2),.001,-10,10,['CC southward @MAi@ CHL N=',num2str(win_chl_S_a.n_max_sample)],...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/rot/',flc]) 


fla='win_a_chl_S';
tmp = double(interp2(win_chl_S_c.median,2));
tmp2 = double(interp2(win_chl_S_c.median,2));
cplot_comps_cont_2_2(tmp,tmp2,ran(1),ran(2),.001,-10,10,['AC southward @MAi@ CHL N=',num2str(win_chl_S_c.n_max_sample)],...
	['~/Documents/OSU/figures/eddy-wind/EK_comps/rot/',fla])

