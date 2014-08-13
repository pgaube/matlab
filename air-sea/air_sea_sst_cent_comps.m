clear all
close all
%Set range of dates
START_YR = 2002;
START_MO = 07;
START_DY = 03;
END_YR= 2008;
END_MO = 01;
END_DY = 23;


%construct date variables
START_JD=date2jd(START_YR,START_MO,START_DY)+.5;
END_JD=date2jd(END_YR,END_MO,END_DY)+.5;
jdays = START_JD:7:END_JD;

LOAD_HEAD   = 'TRANS_W_NOR_';
LOAD_PATH   = '/Volumes/matlab/matlab/global/trans_samp/';

OUT_HEAD 	= 'SST_CENT_CRL_';
OUT_PATH	= '/Volumes/matlab/matlab/air-sea/sst_cent_samps/'

% Set up r and c
% North Anti
r1=42:62;
c1=28:48;
% North Cycl
r2=30:50;
c2=28:48;
% South Anti
r3=24:44;
c3=27:47;
% South Cycl
r4=35:55;
c4=26:46;

for m=3:length(jdays)-3
	fprintf('\r                          -- file %3u of %3u \r',m,length(jdays))
	% Set up file names
	load_file = [LOAD_PATH LOAD_HEAD num2str(jdays(m))];
	out_file = [OUT_PATH OUT_HEAD num2str(jdays(m))];
	load(load_file,'nrhp66_crl_21_sample','id_index','nrhp_u_sample','nrhp_v_sample')
	for d=1:4
		lay=1;
		% Load tracks
		if d<=2
			load /Volumes/matlab/matlab/air-sea/tracks/north_tracks_V4_16_weeks.mat id
		elseif d>=3
			load /Volumes/matlab/matlab/air-sea/tracks/south_tracks_V4_16_weeks.mat id
		end
		
		tmp = sames(id,id_index);
		
		if d==1
			cent_crl_samps_north_a=nan(81,81,length(tmp));
		elseif d==2
			cent_crl_samps_north_c=nan(81,81,length(tmp));
		elseif d==3
			cent_crl_samps_south_a=nan(81,81,length(tmp));
		elseif d==4
			cent_crl_samps_south_c=nan(81,81,length(tmp));
		end
		
		for ed = 1:length(tmp)
 			fprintf('\r     Normalizing %3u of %3u \r',ed,length(tmp))
 			% subset obs so we can only focus 
 			eval(['data=nrhp66_crl_21_sample(r',num2str(d),',c',num2str(d),',tmp(ed));']); 		
 			eval(['ubar=pmean(nrhp_u_sample(r',num2str(d),',c',num2str(d),',tmp(ed)));']);
			eval(['vbar=pmean(nrhp_v_sample(r',num2str(d),',c',num2str(d),',tmp(ed)));']);
			windt=rad2deg(cart2pol(ubar,vbar))-180; %makes 0 = E
			ndata=pgrid(double(data), ...
					 	double(windt));       
			if d==1
				cent_crl_samps_north_a(:,:,lay)=ndata;
				lay=lay+1;
			elseif d==2
				cent_crl_samps_north_c(:,:,lay)=ndata;
				lay=lay+1;			
			elseif d==3
				cent_crl_samps_south_a(:,:,lay)=ndata;
				lay=lay+1;
			elseif d==4
				cent_crl_samps_south_c(:,:,lay)=ndata;
				lay=lay+1;
			end	
    	end
    end	
    if exist([out_file, '.mat'])
    	eval(['save -append ' out_file ' cent*samps*'])
    else
    	eval(['save ' out_file ' cent*samps*'])
    end
 end
 