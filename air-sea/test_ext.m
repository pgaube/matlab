clear all

curs = {'SP',...
		'AGR',...
		'HAW',...
		'EIO',...
		'CAR',...
		'AGU'};

% %			sst		crl	    W_E		W_Ec	W_T		W_Tc				
% cranges= [	.2		.3		2		.5		.15		.01		%SP		1
% 			.7		.7		12		1		10		1		%AGR	2
% 			.12		.4		5		1		.3		.05		%HAW	3
% 			.3		.5		7		1		.8		.1		%EIO	4
% 			.06		.5		7		1		.2		.05		%CAR	5
% 			.9		1		12		2		7		1];     %AGU	6
% 
% 
% 
% for m=4%1:length(curs)
% 	
% 	load(['~/data/eddy/V5/',curs{m},'_lat_lon_tracks'])	
% 	
% % 	eval(['[',curs{m},'_ssh_a,',curs{m},'_ssh_c]=comps(x,y,cyc,k,id,track_jday,scale,'...
% % 	    char(39),'ssh',char(39),',',char(39),...
% % 		'~/data/eddy/V5/mat/AVISO_25_W_',char(39),',',...
% % 		char(39),'n',char(39),');'])
%     eval(['[',curs{m},'_crlg_a,',curs{m},'_crlg_c]=comps(ext_x,ext_y,cyc,k,id,track_jday,scale,'...
% 	    char(39),'hp66_crlg',char(39),',',char(39),...
% 		'~/data/eddy/V5/mat/AVISO_25_W_',char(39),',',...
% 		char(39),'n',char(39),');'])
% 
%  	save -append tmp_eio_comps
% end


%%crl and ssh FROM SSH EXTRMA
load EIO_comps
zgrid_grid
figure(1)
clf
subplot(211)
plot(xi(1,:),1e5*EIO_crlg_a.mean(:,17),'r');axis square
hold on
plot(xi(1,:),1e5*EIO_crlg_c.mean(:,17),'b');axis square
grid
xlabel('L_s')
ylabel('m s^{-1} per 100 km')
title('zonal section along y=0')

subplot(212)
plot(1e5*EIO_crlg_a.mean(19,:),xi(1,:),'r');axis square
hold on
plot(1e5*EIO_crlg_c.mean(19,:),xi(1,:),'b');axis square
grid
ylabel('L_s')
xlabel('m s^{-1} per 100 km')
title('meridional section along x=0.25L_s')
print -dpng -r300 figs/section_SIO_crlg
return



load tmp_eio_comps
m=4

flc='c_ssh_ext';
eval(['tmp = ',curs{m},'_ssh_c;'])
eval(['tmp2 = ',curs{m},'_crlg_c;'])
eval(['n = ',curs{m},'_ssh_c.n_max_sample;'])

pcomps_raw(1e5*tmp2.median,1e5*tmp2.median,[-.5 .5],-1,.03,1,['relative to extrema'],1)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{m},'_comps/ext_',flc],1)

flc='a_ssh_ext';
eval(['tmp = ',curs{m},'_ssh_a;'])
eval(['tmp2 = ',curs{m},'_crlg_a;'])
eval(['n = ',curs{m},'_ssh_a.n_max_sample;'])

pcomps_raw(1e5*tmp2.median,1e5*tmp2.median,[-.5 .5],-1,.03,1,['relative to extrema'],1)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{m},'_comps/ext_',flc],1)

load EIO_comps
flc='c_ssh';
eval(['tmp = ',curs{m},'_ssh_c;'])
eval(['tmp2 = ',curs{m},'_crlg_c;'])
eval(['n = ',curs{m},'_ssh_c.n_max_sample;'])

pcomps_raw(1e5*tmp2.median,1e5*tmp2.median,[-.5 .5],-1,.03,1,['relative to centroid'],1)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{m},'_comps/ext_',flc],1)

flc='a_ssh';
eval(['tmp = ',curs{m},'_ssh_a;'])
eval(['tmp2 = ',curs{m},'_crlg_a;'])
eval(['n = ',curs{m},'_ssh_a.n_max_sample;'])

pcomps_raw(1e5*tmp2.median,1e5*tmp2.median,[-.5 .5],-1,.03,1,['relative to centroid'],1)
eval(['print -dpng -r300 ~/Documents/OSU/figures/air-sea/new/',curs{m},'_comps/ext_',flc],1)

	