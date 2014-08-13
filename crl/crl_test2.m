
clear all
close all

global STEP
global CHL_PATH
global CHL_HEAD
global OUT_PATH
global OUT_HEAD
global SSH_PATH
global TRACK_DATA
global SSH_HEAD
global AMSRE_PATH
global AMSRE_HEAD
global OI_PATH
global OI_HEAD
global Q_PATH
global Q_HEAD
global RAND_PATH
global RAND_HEAD
global MSST_PATH
global MSST_HEAD
global CHL_DATA
global START_JD
global END_JD
global MIN_AMP
global MAX_AMP
global MIN_DUR
global START_YR
global START_MO
global START_DY
global END_YR
global END_MO
global END_DY
global RAD_ADD
global RAD_MULT
global MAX_AMP
global SAM_RAD
global SCENE RAD

set_crl_test_param




%----------------------------------------------------------------------
% Sample Eddies
%----------------------------------------------------------------------

%make arrays to save jdays
%find grid spacing
ssh_file = [SSH_PATH SSH_HEAD num2str(jdays(1))];
load(ssh_file)
dy = abs(lat(2)-lat(1)); %m
BOX = floor(2*SCENE_RAD/dy);
cent = (BOX/2)+1;

ppp=1;

for m=1:2%length(jdays)
	fprintf('\r     Sampling %07u , %3u of %3u \r',jdays(m),m,length(jdays))
	lay = 1;
	%find eddies that are present at jdays(m)
	tmp = find(sam_track_jday == jdays(m));
	
	% Set up file names
	ssh_file = [SSH_PATH SSH_HEAD num2str(jdays(m))];
	amsre_file = [AMSRE_PATH AMSRE_HEAD num2str(jdays(m))];
	oi_file = [OI_PATH OI_HEAD num2str(jdays(m))];
	q_file = [Q_PATH Q_HEAD num2str(jdays(m))];
	r_file = [RAND_PATH RAND_HEAD  num2str(jdays(m))];
	s_file = [SST_WIND_PATH SST_WIND_HEAD  num2str(jdays(m))];
	out_file = [OUT_PATH OUT_HEAD num2str(jdays(m))];
	
	
	% load files
	load(ssh_file)
	lat=lat(41:600,:);
	lon=lon(41:600,:);
	ssh=ssh(41:600,:);
	u=u(41:600,:);
	v=v(41:600,:);
	crl=crl(41:600,:);
	hp66_crlg=hp66_crlg(41:600,:);
	idmask=idmask(41:600,:);
	
	%load Rand data
	load(r_file,'nR')
	nR=nR(41:600,:);
	
	%load(q_file,'lp66_crl')
	load(s_file,'wind_crl_sst')

	
	ppp=ppp+1;
	
	crl= hp66_crlg;
	var_of_crl(ppp)=pstd(crl);
	crstd=pstd(crl);

	
	
	% make test files

	crl_10  = crl + wind_crl_sst +(3 .*(nR .* crstd));
	crl_9  	= crl + wind_crl_sst +(2.5 .*(nR .* crstd));
	crl_8 	= crl + wind_crl_sst +(2 .*(nR .* crstd));
	crl_7 	= crl + wind_crl_sst +(1.5 .*(nR .* crstd));
	crl_6 	= crl + wind_crl_sst +(1 .*(nR .* crstd));
	crl_5 	= crl + wind_crl_sst +(.9 .*(nR .* crstd));
	crl_4 	= crl + wind_crl_sst +(.8 .*(nR .* crstd));
	crl_3 	= crl + wind_crl_sst +(.7 .*(nR .* crstd));
	crl_2  	= crl + wind_crl_sst +(.6 .*(nR .* crstd));
	crl_1  	= crl + wind_crl_sst +(.5 .*(nR .* crstd));
	
	%{	
	crl_10  = crl +((lp66_crl./pstd(lp66_crl)).*crstd) +(3 .*(nR .* crstd));
	crl_9  	= crl +((lp66_crl./pstd(lp66_crl)).*crstd) +(2.5 .*(nR .* crstd));
	crl_8 	= crl +((lp66_crl./pstd(lp66_crl)).*crstd) +(2 .*(nR .* crstd));
	crl_7 	= crl +((lp66_crl./pstd(lp66_crl)).*crstd) +(1.5 .*(nR .* crstd));
	crl_6 	= crl +((lp66_crl./pstd(lp66_crl)).*crstd) +(1 .*(nR .* crstd));
	crl_5 	= crl +((lp66_crl./pstd(lp66_crl)).*crstd) +(.9 .*(nR .* crstd));
	crl_4 	= crl +((lp66_crl./pstd(lp66_crl)).*crstd) +(.8 .*(nR .* crstd));
	crl_3 	= crl +((lp66_crl./pstd(lp66_crl)).*crstd) +(.7 .*(nR .* crstd));
	crl_2  	= crl +((lp66_crl./pstd(lp66_crl)).*crstd) +(.6 .*(nR .* crstd));
	crl_1  	= crl +((lp66_crl./pstd(lp66_crl)).*crstd) +(.5 .*(nR .* crstd));
	%}

	crl_sample 					= single(nan(41,41,length(tmp)));
	
	crl_10_sample				= single(nan(41,41,length(tmp)));
	crl_9_sample 				= single(nan(41,41,length(tmp)));
	crl_8_sample 				= single(nan(41,41,length(tmp)));
	crl_7_sample 				= single(nan(41,41,length(tmp)));
	crl_6_sample 				= single(nan(41,41,length(tmp)));
	crl_5_sample 				= single(nan(41,41,length(tmp)));
	crl_4_sample 				= single(nan(41,41,length(tmp)));
	crl_3_sample 				= single(nan(41,41,length(tmp)));
	crl_2_sample 				= single(nan(41,41,length(tmp)));
	crl_1_sample 				= single(nan(41,41,length(tmp)));
	

	
	id_index	            = single(nan(length(tmp),1)); 
    eid_index	            = single(nan(length(tmp),1));
    x_index		            = single(nan(length(tmp),1));
    y_index		            = single(nan(length(tmp),1));
    efold_index		        = single(nan(length(tmp),1));
    k_index					= single(nan(length(tmp),1));
	
for ed = 1:length(tmp)
 		%fprintf('\r     Rotating %3u of %3u \r',ed,length(tmp))
        % Start out by indexing spatial location of data to be centered at eddy
        r = find(lat(:,100)>= sam_y(tmp(ed)) - (SCENE_RAD + dy/2) & ...
                 lat(:,100)<= sam_y(tmp(ed)) + (SCENE_RAD + dy/2));
        
        c = find(lon(100,:)>= sam_x(tmp(ed)) - (SCENE_RAD + dy/2) & ...
                 lon(100,:)<= sam_x(tmp(ed)) + (SCENE_RAD + dy/2));
        
                
        if length(r) == BOX+1 & length(c) == BOX+1
        scene_lat = single(lat(r,c)); 
        scene_lon = single(lon(r,c));
        emask = idmask(r,c);
        
        %now mask the data
        emask(abs(emask) ~= sam_eid(tmp(ed)))=nan;
        mask=emask;
        tmask=mask;
        tmask(tmask>0)=nan;
        mask(~isnan(mask))=1;
        tmask(~isnan(tmask))=1;
        
		scene_crl = single(crl(r,c)).*mask;
		
		scene_crl_1 = single(crl_1(r,c)).*mask;
		scene_crl_2 = single(crl_2(r,c)).*mask;
		scene_crl_3 = single(crl_3(r,c)).*mask;
		scene_crl_4 = single(crl_4(r,c)).*mask;
		scene_crl_5 = single(crl_5(r,c)).*mask;
		scene_crl_6 = single(crl_6(r,c)).*mask;
		scene_crl_7 = single(crl_7(r,c)).*mask;
		scene_crl_8 = single(crl_8(r,c)).*mask;
		scene_crl_9 = single(crl_9(r,c)).*mask;
		scene_crl_10= single(crl_10(r,c)).*mask;
		
		
        
        crl_sample(:,:,lay) = scene_crl;
        
        crl_1_sample(:,:,lay) = scene_crl_1;
        crl_2_sample(:,:,lay) = scene_crl_2;
        crl_3_sample(:,:,lay) = scene_crl_3;
        crl_4_sample(:,:,lay) = scene_crl_4;
        crl_5_sample(:,:,lay) = scene_crl_5;
        crl_6_sample(:,:,lay) = scene_crl_6;
        crl_7_sample(:,:,lay) = scene_crl_7;
        crl_8_sample(:,:,lay) = scene_crl_8;
        crl_9_sample(:,:,lay) = scene_crl_9;
        crl_10_sample(:,:,lay)= scene_crl_10;
        
 
        %from eddy file
        id_index(lay)           = sam_id(tmp(ed)); 
        eid_index(lay)          = sam_eid(tmp(ed));
        x_index(lay)            = sam_x(tmp(ed));
        y_index(lay)            = sam_y(tmp(ed)); 
        efold_index(lay)        = sam_efold(tmp(ed));
        k_index(lay)			= sam_k(tmp(ed));
        
        lay=lay+1;
        end
    end
    
    % Now save the data
    
    eval(['save ' out_file ' *_sample *_index'])
end    
    
save var_of_crl var_of_crl
fprintf('\n')



















