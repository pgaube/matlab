clear all

curs = {'new_SP',...
    'AGR',...
    'HAW',...
    'EIO',...
    'CAR',...
    'AGU',...
    'new_EIO',...
    'new_SEA',...
    'SP'};

%			sst		crl	    W_E		W_Ec	W_T		W_Tc
cranges= [	.3		.4		10		2		1		.25		%SP		1
            .7		.7		35		5		15		2		%AGR	2
            .15		.5		20		5		2		.2		%HAW	3
            .4		.7		15		3		3		.5		%EIO	4
            .06		.5		35		5		3		.5   	%CAR	5
            1		1		20		5		10		1       %SEA	6
            .4		.7		12		2		2		.25     %newEIO 7
            1		1		15		2		7		1       %SEA2	8
            .3		.4		10		2		1		.25];	%old SP 9


%
%
for mm=1:6

    load(['~/data/eddy/V6/',curs{mm},'_lat_lon_tracks_V6'])
    ii=find(track_jday>=2452466 & track_jday<=2455126 & age>=12);
    ext_x=ext_x(ii);
    ext_y=ext_y(ii);
    k=k(ii);
    id=id(ii);
    track_jday=track_jday(ii);
    cyc=cyc(ii);
    scale=scale(ii);
    
% 
    eval(['[',curs{mm},'_wek_total_a,',curs{mm},'_wek_total_c]=schlax_comps(ext_x,ext_y,cyc,k,id,track_jday,scale,'...
        char(39),'hp_total_wek_est',char(39),',',char(39),...
        '~/data/QuickScat/schlax/mat/schlax_',char(39),',',...
        char(39),'n',char(39),');'])

%     eval(['[',curs{mm},'_wek_total_qscat_a,',curs{mm},'_wek_total_qscat_c]=schlax_comps(ext_x,ext_y,cyc,k,id,track_jday,scale,'...
%         char(39),'hp_total_wek_qscat',char(39),',',char(39),...
%         '~/data/QuickScat/schlax/mat/schlax_',char(39),',',...
%         char(39),'n',char(39),');'])

    eval(['[',curs{mm},'_fixed_wek_sst_a,',curs{mm},'_fixed_wek_sst_c]=schlax_comps(ext_x,ext_y,cyc,k,id,track_jday,scale,'...
        char(39),'hp_wek_sst_week_fixed',char(39),',',char(39),...
        '~/data/QuickScat/schlax/mat/schlax_',char(39),',',...
        char(39),'n',char(39),');'])
    
    save -append SCHLAX_region_comps
end






