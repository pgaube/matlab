function [compa,compc] = mcomps_time_step(ids,ids_jdays);
%function [compa,compc] = mcomps_time_step(ids,ids_jdays);
%
% Makes composest of the samples 'var'
%
% INPUT:
% EDDY_FILE = file name of eddies over which to composite
% var = variable name, see TRANS_W_25_* files
 METHOD = 'n';
% ids = the ids of the eddy obs to comp
% id_jdays = the jdauy of each id for the comps,  jdays anomst be == size(id)

%
% OUTPUT:
% compa, compc = composites, these are structure files with the following
% 				 atributes:
%		mean
%		N
%		var
%		n_times_steps
%		n_max_samples
%		per_cov

startjd=2451395;
endjd=2454461;




if METHOD=='t'
OUT_HEAD   = 'TRANS_W_ROT_';
OUT_PATH   = '/matlab/matlab/global/gradt_200_trans_samp/';
r_comp=49:113;%33:129;
c_comp=49:113;%33:129;
startjd=2451395;
endjd=2454461;
elseif METHOD=='g'
OUT_HEAD   = 'TRANS_W_ROT_';
OUT_PATH   = '/matlab/matlab/global/gradg_200_trans_samp/';
r_comp=49:113;%33:129;
c_comp=49:113;%33:129;
startjd=2451395;
endjd=2454461;
elseif METHOD=='c'
OUT_HEAD   = 'TRANS_W_ROT_';
OUT_PATH   = '/matlab/matlab/global/gradc_200_trans_samp/';
r_comp=49:113;%33:129;
c_comp=49:113;%33:129;
startjd=2451395;
endjd=2454461;
elseif METHOD=='r'
OUT_HEAD   = 'TRANS_W_ROT_';
OUT_PATH   = '/matlab/matlab/global/ro_trans_samp/';
r_comp=33:129;
c_comp=33:129;
elseif METHOD=='n'
OUT_HEAD   = 'TRANS_W_NOR_';
OUT_PATH   = '/matlab/matlab/global/trans_samp/';
r_comp=17:65;
c_comp=17:65;
elseif METHOD=='mask'
OUT_HEAD   = 'TRANS_W_NOR_';
OUT_PATH   = '/matlab/matlab/global/mask_trans_samp/';
r_comp=17:65;
c_comp=17:65;
elseif METHOD=='w'
OUT_HEAD   = 'TRANS_W_WIR_';
r_comp=49:113;
c_comp=49:113;
OUT_PATH   = '/matlab/matlab/global/wro_trans_samp/';
end



load /matlab/data/eddy/V4/global_tracks_V4_12_weeks nneg

%subset global eddies by the ids want
ii=find(ids_jdays>endjd | ids_jdays<startjd);
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

ssh_compa=double(nan(M,M,ia));
ssh_compc=double(nan(M,M,ic));
ssh_Na=double(ones(M,M));
ssh_Nc=double(ones(M,M));
wek_compa=ssh_compa;
wek_compc=ssh_compc;
wek_Na=ssh_Na;
wek_Nc=ssh_Nc;
chl_compa=ssh_compa;
chl_compc=ssh_compc;
chl_Na=ssh_Na;
chl_Nc=ssh_Nc;
raw_compa=ssh_compa;
raw_compc=ssh_compc;
raw_Na=ssh_Na;
raw_Nc=ssh_Nc;
log_compa=ssh_compa;
log_compc=ssh_compc;
log_Na=ssh_Na;
log_Nc=ssh_Nc;
car_compa=ssh_compa;
car_compc=ssh_compc;
car_Na=ssh_Na;
car_Nc=ssh_Nc;
anom_compa=ssh_compa;
anom_compc=ssh_compc;
anom_Na=ssh_Na;
anom_Nc=ssh_Nc;
sst_compa=ssh_compa;
sst_compc=ssh_compc;
sst_Na=ssh_Na;
sst_Nc=ssh_Nc;
cc_compa=ssh_compa;
cc_compc=ssh_compc;
cc_Na=ssh_Na;
cc_Nc=ssh_Nc;
zza=1;
zzc=1;

for m=1:lj
    fprintf('\r                 compositing week %03u of %03u \r',m,length(jdays))
    load([OUT_PATH OUT_HEAD num2str(jdays(m))],'id_index');
    day_id=unique(ids(ids_jdays==jdays(m)));
    ii=sames(day_id,id_index);
    if any(ii)
        %load([OUT_PATH OUT_HEAD num2str(jdays(m))],'nrraw_bp26_chl_sample','nrnbp21_chl_sample','nrw_ek_sample','nrssh_sample','nrbp21_car_sample','nrbp21_anom_sample','nrbp26_sst_sample','id_index');
        load([OUT_PATH OUT_HEAD num2str(jdays(m))],'nrbp26_chl_sample','nrsp66_cc_sample','nrbp26_sst_sample','nrssh_sample','nrraw_bp26_chl_sample','nrw_ek_sample','nrsp66_car_sample','nrraw_hp66_chl_sample','nrsp66_chl_sample','id_index');
        
        for pp=1:length(ii)
            ssh_obs=nrssh_sample(r_comp,c_comp,ii(pp));
            wek_obs=nrw_ek_sample(r_comp,c_comp,ii(pp));
            chl_obs=nrraw_hp66_chl_sample(r_comp,c_comp,ii(pp));
            raw_obs=nrraw_bp26_chl_sample(r_comp,c_comp,ii(pp));
            car_obs=nrsp66_car_sample(r_comp,c_comp,ii(pp));
            anom_obs=nrsp66_chl_sample(r_comp,c_comp,ii(pp));
            sst_obs=nrbp26_sst_sample(r_comp,c_comp,ii(pp));
            cc_obs=nrsp66_cc_sample(r_comp,c_comp,ii(pp));
            log_obs=nrbp26_chl_sample(r_comp,c_comp,ii(pp));
            
            ssh_n=~isnan(ssh_obs);
            wek_n=~isnan(wek_obs);
            chl_n=~isnan(chl_obs);
            raw_n=~isnan(raw_obs);
            car_n=~isnan(car_obs);
            anom_n=~isnan(anom_obs);
            sst_n=~isnan(sst_obs);
            cc_n=~isnan(cc_obs);
            log_n=~isnan(cc_obs);
            
            if id_index(ii(pp))>=nneg;
                ssh_compa(:,:,zza)=ssh_obs;
                wek_compa(:,:,zza)=wek_obs;
                chl_compa(:,:,zza)=chl_obs;
                raw_compa(:,:,zza)=raw_obs;
                car_compa(:,:,zza)=car_obs;
                anom_compa(:,:,zza)=anom_obs;
                sst_compa(:,:,zza)=sst_obs;
                cc_compa(:,:,zza)=cc_obs;
                log_compa(:,:,zza)=log_obs;
                
                ssh_Na=ssh_Na+ssh_n;
                wek_Na=wek_Na+wek_n;
                chl_Na=chl_Na+chl_n;
                raw_Na=raw_Na+raw_n;
                car_Na=car_Na+car_n;
                anom_Na=anom_Na+anom_n;
                sst_Na=sst_Na+sst_n;
                cc_Na=cc_Na+cc_n;
                log_Na=log_Na+log_n;
                
                zza=zza+1;
                
                %fprintf('\n   %05u of %05u %05u of %05u \r',zza,ia,zzc,ic)
                %figure(1)
                %clf
                %pcolor(double(obs));shading flat
                %caxis([-.1 .1])
                %drawnow
            else
				ssh_compc(:,:,zzc)=ssh_obs;
                wek_compc(:,:,zzc)=wek_obs;
                chl_compc(:,:,zzc)=chl_obs;
                raw_compc(:,:,zzc)=raw_obs;
                car_compc(:,:,zzc)=car_obs;
                anom_compc(:,:,zzc)=anom_obs;
                sst_compc(:,:,zzc)=sst_obs;
                cc_compc(:,:,zzc)=cc_obs;
                log_compc(:,:,zzc)=log_obs;
                
                ssh_Nc=ssh_Nc+ssh_n;
                wek_Nc=wek_Nc+wek_n;
                chl_Nc=chl_Nc+chl_n;
                raw_Nc=raw_Nc+raw_n;
                car_Nc=car_Nc+car_n;
                anom_Nc=anom_Nc+anom_n;
                sst_Nc=sst_Nc+sst_n;               
                cc_Nc=cc_Nc+cc_n;
                log_Nc=log_Nc+log_n;
                
                zzc=zzc+1;
                %fprintf('\n   %05u of %05u %05u of %05u \r',zza,ia,zzc,ic)
                %figure(2)
                %clf
                %pcolor(double(obs));shading flat
                %caxis([-.1 .1])
                %drawnow
            end
        end
    end
    clear id_index
end

%{
fbad=nan(length(ssh_compa(1,1,:)),1);
for m=1:length(fbad)
	tmp=ssh_compa(:,:,m);
	fbad(m)=nansum(tmp(:));
end
ibad=find(fbad==0);
ssh_compa(:,:,ibad)=[];

fbad=nan(length(ssh_compc(1,1,:)),1);
for m=1:length(fbad)
	tmp=ssh_compc(:,:,m);
	fbad(m)=nansum(tmp(:));
end
ibad=find(fbad==0);
ssh_compc(:,:,ibad)=[];

fbad=nan(length(wek_compa(1,1,:)),1);
for m=1:length(fbad)
	tmp=wek_compa(:,:,m);
	fbad(m)=nansum(tmp(:));
end
ibad=find(fbad==0);
wek_compa(:,:,ibad)=[];

fbad=nan(length(wek_compc(1,1,:)),1);
for m=1:length(fbad)
	tmp=wek_compc(:,:,m);
	fbad(m)=nansum(tmp(:));
end
ibad=find(fbad==0);
wek_compc(:,:,ibad)=[];

fbad=nan(length(chl_compa(1,1,:)),1);
for m=1:length(fbad)
	tmp=chl_compa(:,:,m);
	fbad(m)=nansum(tmp(:));
end
ibad=find(fbad==0);
chl_compa(:,:,ibad)=[];

fbad=nan(length(chl_compc(1,1,:)),1);
for m=1:length(fbad)
	tmp=chl_compc(:,:,m);
	fbad(m)=nansum(tmp(:));
end
ibad=find(fbad==0);
chl_compc(:,:,ibad)=[];

fbad=nan(length(car_compa(1,1,:)),1);
for m=1:length(fbad)
	tmp=car_compa(:,:,m);
	fbad(m)=nansum(tmp(:));
end
ibad=find(fbad==0);
car_compa(:,:,ibad)=[];

fbad=nan(length(car_compc(1,1,:)),1);
for m=1:length(fbad)
	tmp=car_compc(:,:,m);
	fbad(m)=nansum(tmp(:));
end
ibad=find(fbad==0);
car_compc(:,:,ibad)=[];

fbad=nan(length(anom_compa(1,1,:)),1);
for m=1:length(fbad)
	tmp=anom_compa(:,:,m);
	fbad(m)=nansum(tmp(:));
end
ibad=find(fbad==0);
anom_compa(:,:,ibad)=[];

fbad=nan(length(anom_compc(1,1,:)),1);
for m=1:length(fbad)
	tmp=anom_compc(:,:,m);
	fbad(m)=nansum(tmp(:));
end
ibad=find(fbad==0);
anom_compc(:,:,ibad)=[];

fbad=nan(length(sst_compa(1,1,:)),1);
for m=1:length(fbad)
	tmp=sst_compa(:,:,m);
	fbad(m)=nansum(tmp(:));
end
ibad=find(fbad==0);
sst_compa(:,:,ibad)=[];

fbad=nan(length(sst_compc(1,1,:)),1);
for m=1:length(fbad)
	tmp=sst_compc(:,:,m);
	fbad(m)=nansum(tmp(:));
end
ibad=find(fbad==0);
sst_compc(:,:,ibad)=[];
%}


% build structure array
compa.ssh_median  			= nanmedian(ssh_compa,3);
compa.ssh_mean  			= nanmean(ssh_compa,3);
compa.ssh_N 				= ssh_Na-1;
compa.ssh_n_max_sample		= max(ssh_Na(:));
compa.ssh_per_cov			= 100*(ssh_Na./max(ssh_Na(:)));

compa.wek_median  			= nanmedian(wek_compa,3);
compa.wek_mean  			= nanmean(wek_compa,3);
compa.wek_N 				= wek_Na-1;
compa.wek_n_max_sample		= max(wek_Na(:));
compa.wek_per_cov			= 100*(wek_Na./max(wek_Na(:)));

compa.chl_median  			= nanmedian(chl_compa,3);
compa.chl_mean				= nanmean(chl_compa,3);
compa.chl_N 				= chl_Na-1;
compa.chl_n_max_sample		= max(chl_Na(:));
compa.chl_per_cov			= 100*(chl_Na./max(chl_Na(:)));

compa.raw_median  			= nanmedian(raw_compa,3);
compa.raw_mean  			= nanmean(raw_compa,3);
compa.raw_N 				= raw_Na-1;
compa.raw_n_max_sample		= max(raw_Na(:));
compa.raw_per_cov			= 100*(raw_Na./max(raw_Na(:)));

compa.car_median  			= nanmedian(car_compa,3);
compa.car_mean  			= nanmean(car_compa,3);
compa.car_N 				= car_Na-1;
compa.car_n_max_sample		= max(car_Na(:));
compa.car_per_cov			= 100*(car_Na./max(car_Na(:)));

compa.anom_median  			= nanmedian(anom_compa,3);
compa.anom_mean  			= nanmean(anom_compa,3);
compa.anom_N 				= anom_Na-1;
compa.anom_n_max_sample		= max(anom_Na(:));
compa.anom_per_cov			= 100*(anom_Na./max(anom_Na(:)));

compa.sst_median  			= nanmedian(sst_compa,3);
compa.sst_mean  			= nanmean(sst_compa,3);
compa.sst_N 				= sst_Na-1;
compa.sst_n_max_sample		= max(sst_Na(:));
compa.sst_per_cov			= 100*(sst_Na./max(sst_Na(:)));

compa.cc_median  			= nanmedian(cc_compa,3);
compa.cc_mean  				= nanmean(cc_compa,3);
compa.cc_N 					= cc_Na-1;
compa.cc_n_max_sample		= max(cc_Na(:));
compa.cc_per_cov			= 100*(cc_Na./max(cc_Na(:)));

compa.log_median  			= nanmedian(log_compa,3);
compa.log_mean  			= nanmean(log_compa,3);
compa.log_N 				= log_Na-1;
compa.log_n_max_sample		= max(log_Na(:));
compa.log_per_cov			= 100*(log_Na./max(log_Na(:)));

clear *_compa

compc.ssh_median  			= nanmedian(ssh_compc,3);
compc.ssh_mean  			= nanmean(ssh_compc,3);
compc.ssh_N 				= ssh_Nc-1;
compc.ssh_n_max_sample		= max(ssh_Nc(:));
compc.ssh_per_cov			= 100*(ssh_Na./max(ssh_Nc(:)));

compc.wek_median  			= nanmedian(wek_compc,3);
compc.wek_mean  			= nanmean(wek_compc,3);
compc.wek_N 				= wek_Nc-1;
compc.wek_n_max_sample		= max(wek_Nc(:));
compc.wek_per_cov			= 100*(wek_Na./max(wek_Nc(:)));

compc.chl_median  			= nanmedian(chl_compc,3);
compc.chl_mean	 			= nanmean(chl_compc,3);
compc.chl_N 				= chl_Nc-1;
compc.chl_n_max_sample		= max(chl_Nc(:));
compc.chl_per_cov			= 100*(chl_Na./max(chl_Nc(:)));

compc.raw_median  			= nanmedian(raw_compc,3);
compc.raw_mean  			= nanmean(raw_compc,3);
compc.raw_N 				= raw_Nc-1;
compc.raw_n_max_sample		= max(raw_Nc(:));
compc.raw_per_cov			= 100*(raw_Nc./max(raw_Nc(:)));

compc.car_median  			= nanmedian(car_compc,3);
compc.car_mean  			= nanmean(car_compc,3);
compc.car_N 				= car_Nc-1;
compc.car_n_max_sample		= max(car_Nc(:));
compc.car_per_cov			= 100*(car_Na./max(car_Nc(:)));

compc.anom_median  			= nanmedian(anom_compc,3);
compc.anom_mean  			= nanmean(anom_compc,3);
compc.anom_N 				= anom_Nc-1;
compc.anom_n_max_sample		= max(anom_Nc(:));
compc.anom_per_cov			= 100*(anom_Na./max(anom_Nc(:)));

compc.sst_median  			= nanmedian(sst_compc,3);
compc.sst_mean  			= nanmean(sst_compc,3);
compc.sst_N 				= sst_Nc-1;
compc.sst_n_max_sample		= max(sst_Nc(:));
compc.sst_per_cov			= 100*(sst_Na./max(sst_Nc(:)));

compc.cc_median  			= nanmedian(cc_compc,3);
compc.cc_mean  				= nanmean(cc_compc,3);
compc.cc_N 					= cc_Nc-1;
compc.cc_n_max_sample		= max(cc_Nc(:));
compc.cc_per_cov			= 100*(cc_Na./max(cc_Nc(:)));

compc.log_median  			= nanmedian(log_compc,3);
compc.log_mean  			= nanmean(log_compc,3);
compc.log_N 				= log_Nc-1;
compc.log_n_max_sample		= max(log_Nc(:));
compc.log_per_cov			= 100*(log_Nc./max(log_Nc(:)));

clear *_compc

fprintf('\n')