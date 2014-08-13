function [compa,compc] = eofcomps_time_step(ids,ids_jdays);
%function [compa,compc] = eofcomps_time_step(ids,ids_jdays);
%
% Makes EOF from the composites of the SSH,SST,WEK,RAW,
%
% INPUT:
% EDDY_FILE = file name of eddies over which to composite
% var = variable name, see TRANS_W_25_* files
% ids = the ids of the eddy obs to comp
% id_jdays = the jdauy of each id for the comps,  jdays must be == size(id)

startjd=2451395;
endjd=2454461;




OUT_HEAD   = 'TRANS_W_NOR_';
OUT_PATH   = '/matlab/matlab/global/trans_samp/';
r_comp=33:49;
c_comp=33:49;


load /matlab/data/eddy/V4/global_tracks_V4_12_weeks nneg

%subset global eddies by the ids want
ii=find(ids_jdays>endjd & ids_jdays<startjd);
ids_jdays(ii)=[];
ids(ii)=[];


jdays=[min(ids_jdays):7:max(ids_jdays)];
lj=length(jdays);
lid=length(ids);

% Create indicies
uid=unique(ids);
ic = length(find(ids<nneg));
ia = length(find(ids>=nneg));

% Create matrices to save jdays
load([OUT_PATH OUT_HEAD num2str(startjd+14)],'nrw_ek_sample');
dat=nrw_ek_sample;
[M]=length(r_comp);

ssh_compa=double(nan(M,M,lj));
ssh_compc=double(nan(M,M,lj));
wek_compa=ssh_compa;
wek_compc=ssh_compc;
raw_compa=ssh_compa;
raw_compc=ssh_compc;
sst_compa=ssh_compa;
sst_compc=ssh_compc;


for m=1:lj
    fprintf('\r                 compositing week %03u of %03u \r',m,length(jdays))
    load([OUT_PATH OUT_HEAD num2str(jdays(m))],'id_index');
    day_id=unique(ids(ids_jdays==jdays(m)));
    ii=sames(day_id,id_index);
    if any(ii)
        load([OUT_PATH OUT_HEAD num2str(jdays(m))],'nrbp26_sst_sample','nrssh_sample','nrsp66_chl_sample','nrw_ek_sample','id_index');
        ssh_tmpa=double(nan(M,M,length(ii)));
    	ssh_tmpc=double(nan(M,M,length(ii)));
    	wek_tmpa=double(nan(M,M,length(ii)));
    	wek_tmpc=double(nan(M,M,length(ii)));
    	raw_tmpa=double(nan(M,M,length(ii)));
    	raw_tmpc=double(nan(M,M,length(ii)));
    	sst_tmpa=double(nan(M,M,length(ii)));
    	sst_tmpc=double(nan(M,M,length(ii)));
    	zza=1;
    	zzc=1;
        for pp=1:length(ii)
            ssh_obs=nrssh_sample(r_comp,c_comp,ii(pp));
            wek_obs=nrw_ek_sample(r_comp,c_comp,ii(pp));
            raw_obs=nrsp66_chl_sample(r_comp,c_comp,ii(pp));
            sst_obs=nrbp26_sst_sample(r_comp,c_comp,ii(pp));
            
            if id_index(ii(pp))>=nneg;
                ssh_tmpa(:,:,zza)=ssh_obs;
                wek_tmpa(:,:,zza)=wek_obs;
                raw_tmpa(:,:,zza)=raw_obs;
                sst_tmpa(:,:,zza)=sst_obs;
                zza=zza+1;
            else
				ssh_tmpc(:,:,zzc)=ssh_obs;
                wek_tmpc(:,:,zzc)=wek_obs;
                raw_tmpc(:,:,zzc)=raw_obs;
                sst_tmpc(:,:,zzc)=sst_obs;
                zzc=zzc+1;
            end
        end
        ssh_compa(:,:,m)=fillnans(nanmean(ssh_tmpa,3));
    	ssh_compc(:,:,m)=fillnans(nanmean(ssh_tmpc,3));
    	sst_compa(:,:,m)=fillnans(nanmean(sst_tmpa,3));
    	sst_compc(:,:,m)=fillnans(nanmean(sst_tmpc,3));
    	wek_compa(:,:,m)=fillnans(nanmean(wek_tmpa,3));
    	wek_compc(:,:,m)=fillnans(nanmean(wek_tmpc,3));
    	raw_compa(:,:,m)=fillnans(nanmean(raw_tmpa,3));
    	raw_compc(:,:,m)=fillnans(nanmean(raw_tmpc,3));
    end
    clear id_index *_tmpa *_tmpc zza zzc
end

%calculate EOFs
[lambda,modes,amp,percent] 		= eof_space(ssh_compa);
compa.ssh_modes  				= modes;
compa.ssh_amp  					= amp;
compa.ssh_lambda 				= lambda;
compa.ssh_percent		        = percent;

[lambda,modes,amp,percent] 		= eof_space(ssh_compc);
compc.ssh_modes  				= modes;
compc.ssh_amp  					= amp;
compc.ssh_lambda 				= lambda;
compc.ssh_percent		        = percent;

[lambda,modes,amp,percent] 		= eof_space(sst_compa);
compa.sst_modes  				= modes;
compa.sst_amp  					= amp;
compa.sst_lambda 				= lambda;
compa.sst_percent		        = percent;

[lambda,modes,amp,percent] 		= eof_space(sst_compc);
compc.sst_modes  				= modes;
compc.sst_amp  					= amp;
compc.sst_lambda 				= lambda;
compc.sst_percent		        = percent;

[lambda,modes,amp,percent] 		= eof_space(raw_compa);
compa.raw_modes  				= modes;
compa.raw_amp  					= amp;
compa.raw_lambda 				= lambda;
compa.raw_percent		        = percent;

[lambda,modes,amp,percent] 		= eof_space(raw_compc);
compc.raw_modes  				= modes;
compc.raw_amp  					= amp;
compc.raw_lambda 				= lambda;
compc.raw_percent		        = percent;

[lambda,modes,amp,percent] 		= eof_space(wek_compa);
compa.wek_modes  				= modes;
compa.wek_amp  					= amp;
compa.wek_lambda 				= lambda;
compa.wek_percent		        = percent;

[lambda,modes,amp,percent] 		= eof_space(wek_compc);
compc.wek_modes  				= modes;
compc.wek_amp  					= amp;
compc.wek_lambda 				= lambda;
compc.wek_percent		        = percent;

fprintf('\n')
