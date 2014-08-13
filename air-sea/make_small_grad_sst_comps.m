clear all

% %first make tracks
% low_lim=.6
% load gradt_steady lat lon mean_gradt
% load tracks/midlat_tracks
% o_lay=1;
% m_lay=1;
% 
% [ok,ox,oy,ocyc,oid,oscale,ochl,ojdays,ok]=deal(nan*x);
% 
% for n=1:length(x)
% 	[r,c]=imap(y(n)-.125,y(n)+.125,x(n)-.125,x(n)+.125,lat,lon);
% 	if 1e5*mean_gradt(r,c)<=low_lim
% 		ox(o_lay)=x(n);
% 		oy(o_lay)=y(n);
% 		ocyc(o_lay)=cyc(n);
% 		ok(o_lay)=k(n);
% 		oid(o_lay)=id(n);
% 		oscale(o_lay)=scale(n);
% 		ojdays(o_lay)=track_jday(n);
% 		o_lay=o_lay+1;
%     end
% end
% 
% ii=find(isnan(ox));
% ox(ii)=[];
% oy(ii)=[];
% ocyc(ii)=[];
% oid(ii)=[];
% oscale(ii)=[];
% ojdays(ii)=[];
% ochl(ii)=[];
% ok(ii)=[];
% 
% save tracks/low_gradt_tracks ox oy ocyc ok oid oscale ojdays
% 
% 
% %
% % 
% load tracks/low_gradt_tracks
% [low_wek_a,low_wek_c]=comps(ox,oy,ocyc,ok,oid,ojdays,oscale,'wek','~/data/QuickScat/new_mat/QSCAT_30_25km_','n');
% [rot_low_wek_a,rot_low_wek_c]=comps(ox,oy,ocyc,ok,oid,ojdays,oscale,'wek','~/data/QuickScat/new_mat/QSCAT_30_25km_','w');
% % 
% save -append low_gradt_comps
% 

load low_gradt_comps

pcomps_raw2(low_wek_c.median,low_wek_c.median,[-.06 .06],-1,.005,1,['QuikSCAT cyclones N=',num2str(low_wek_c.n_max_sample)],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/low_w_ek_c'])

pcomps_raw2(low_wek_a.median,low_wek_a.median,[-.06 .06],-1,.005,1,['QuikSCAT anticyclones N=',num2str(low_wek_a.n_max_sample)],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/low_w_ek_a'])


pcomps_raw2(rot_low_wek_c.median,low_wek_c.median,[-.06 .06],-1,.005,1,['QuikSCAT cyclones N=',num2str(low_wek_c.n_max_sample)],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/rot_low_w_ek_c'])

pcomps_raw2(rot_low_wek_a.median,low_wek_a.median,[-.06 .06],-1,.005,1,['QuikSCAT anticyclones N=',num2str(low_wek_a.n_max_sample)],2,30)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/comps/rot_low_w_ek_a'])

% 
% load tracks/low_gradt_tracks
% load gradt_steady lat lon
% [r,c]=imap(-50,50,0,360,lat,lon);
% ox(ox>362)=nan;
% ox(ox<4)=nan;
% figure(1)
% clf
% pmap(lon(r,c),lat(r,c),nan*lat(r,c))
% hold on
% uid=unique(oid);
% for m=1:length(uid)
% 	ii=find(oid==uid(m));
% 	xx=ox(ii);
% 	yy=oy(ii);
%     if ocyc(ii(1))==1
%         m_plot(xx,yy,'r','linewidth',.1)
%     else
%         m_plot(xx,yy,'b','linewidth',.1)
%     end
% end	
% 
% 
% print -depsc figs/low_sst_gradt_tracks
% print -dpng -r300 figs/low_sst_gradt_tracks