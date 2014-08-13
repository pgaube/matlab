function [eofa,eofc] = eofcomps(EDDY_FILE,var,METHOD);
%function [compa,compc] = mcomps(EDDY_FILE,var,METHOD);
%
% Makes composest of the samples 'var'
%
% INPUT:
% EDDY_FILE = file name of eddies over which to composite
% var = variable name, see TRANS_W_25_* files
% METHOD = how the varible is sampled
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

% First load the tracks you want to composite
load(EDDY_FILE);
%these are the good ones
startjd=2451395;
endjd=2454461;

if METHOD=='t'
OUT_HEAD   = 'TRANS_W_ROT_';
OUT_PATH   = '/matlab/matlab/global/ro_trans_samp/';
r_comp=49:113;
c_comp=49:113;
startjd=2451395;%2450884;
endjd=2454797;
elseif METHOD=='r'
OUT_HEAD   = 'TRANS_W_ROT_';
OUT_PATH   = '/matlab/matlab/global/ro_trans_samp/';
r_comp=34:128;
c_comp=34:128;
elseif METHOD=='n'
OUT_HEAD   = 'TRANS_W_NOR_';
OUT_PATH   = '/matlab/matlab/global/trans_samp/';
r_comp=17:65;
c_comp=17:65;
elseif METHOD=='w'
OUT_HEAD   = 'TRANS_W_WIR_';
OUT_PATH   = '/matlab/matlab/global/wro_trans_samp/';
r_comp=49:113;
c_comp=49:113;
elseif METHOD=='no_mask'
OUT_HEAD   = 'TRANS_W_NMK_';
OUT_PATH   = '/matlab/matlab/global/no_mask_trans_samp/';
r_comp=17:65;
c_comp=17:65;
end



% subset eddies to dates where we have samples of all our shit
f1=find(track_jday>=startjd & track_jday<=endjd);

id=id(f1);
track_jday=track_jday(f1);
b=1;
jdays=[min(track_jday):7:max(track_jday)];
lj=length(jdays);
lid=length(id);

% Create indicies
uid=unique(id);
ic = length(find(id<nneg));
ia = length(find(id>=nneg));

% Create matrices to save jdays
load([OUT_PATH OUT_HEAD num2str(startjd+14)],var);
eval(['data = ' var ';']);
[M]=length(r_comp);
tcompa=double(nan(M,M,lj));
tcompc=double(nan(M,M,lj));
Na=double(ones(M,M));
Nc=double(ones(M,M));
zza=1;
zzc=1;

for m=1:lj
    fprintf('\r                 compositing week %03u of %03u \r',m,length(jdays))
    load([OUT_PATH OUT_HEAD num2str(jdays(m))],var,'id_index');
    eval(['data = ' var ';'])
    %size(data)
    day_id=unique(id(track_jday==jdays(m)));
    
    ii=sames(day_id,id_index);
    if any(ii)
    	tmpa=double(nan(M,M,length(ii)));
    	tmpc=double(nan(M,M,length(ii)));
    	zza=1;
    	zzc=1;
        for pp=1:length(ii)
            obs=data(r_comp,c_comp,ii(pp));
            if id_index(ii(pp))>=nneg;
                tmpa(:,:,zza)=obs;
                zza=zza+1;
            else
                tmpc(:,:,zzc)=obs;
                zzc=zzc+1;
                
            end
        end
        tcompa(:,:,m)=fillnans(nanmean(tmpa,3));
        tcompc(:,:,m)=fillnans(nanmean(tmpc,3));
    end
    clear id_index tmpa tmpc zza zzc
end

clearallbut tcompa tcompc id 

%calculate EOFs
[lambda,modes,amp,percent] = eof_space(tcompa);

eofa.modes=modes;
eofa.amps=amp;
eofa.lambda=lambda;
eofa.percent=percent;

[lambda,modes,amp,percent] = eof_space(tcompc);

eofc.modes=modes;
eofc.amps=amp;
eofc.lambda=lambda;
eofc.percent=percent;


fprintf('\n')
