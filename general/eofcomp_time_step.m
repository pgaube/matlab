function [compa,compc] = mcomps(EDDY_FILE,var,METHOD);
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
tcompa=double(nan(M,M,ia));
tcompc=double(nan(M,M,ic));
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
        for pp=1:length(ii)
            obs=data(r_comp,c_comp,ii(pp));
            n=~isnan(data(r_comp,c_comp,ii(pp)));
            if id_index(ii(pp))>=nneg;
                tcompa(:,:,zza)=obs;
                zza=zza+1;
                Na=Na+n;
                %fprintf('\n   %05u of %05u %05u of %05u \r',zza,ia,zzc,ic)
                %figure(1)
                %clf
                %pcolor(double(obs));shading flat
                %caxis([-.1 .1])
                %drawnow
            else
                tcompc(:,:,zzc)=obs;
                zzc=zzc+1;
                Nc=Nc+n;
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

clearallbut tcompa tcompc Na Nc id 

fbad=nan(length(tcompa(1,1,:)),1);
for m=1:length(fbad)
	tmp=tcompa(:,:,m);
	fbad(m)=nansum(tmp(:));
end
ibad=find(fbad==0);
tcompa(:,:,ibad)=[];

fbad=nan(length(tcompc(1,1,:)),1);
for m=1:length(fbad)
	tmp=tcompc(:,:,m);
	fbad(m)=nansum(tmp(:));
end
ibad=find(fbad==0);
tcompc(:,:,ibad)=[];



% build structure array
compa.median  			= nanmedian(tcompa,3);
%compa.mode	  			= nanmode(tcompa,3);
compa.N 				= Na-1;
compa.n_max_sample		= max(Na(:));
compa.n_eddies		    = length(id);
compa.per_cov			= 100*(Na./max(Na(:)));
%compa.mean				= nanmean(tcompa,3);
%compa.std	 			= nanstd(tcompa,0,3);
for r=1:length(tcompa(:,1,1))
	for c=1:length(tcompa(1,:,1))
	compa.mean(r,c) = pmean(tcompa(r,c,:));
	compa.std(r,c) = pstd(tcompa(r,c,:));
	end
end	
%}

clear tcompa

compc.median  			= nanmedian(tcompc,3);
%compc.mode	  			= nanmode(tcompc,3);
compc.N 				= Nc-1;
compc.n_max_sample		= max(Nc(:));
compc.n_eddies		    = length(id);
compc.per_cov			= 100*(Nc./max(Nc(:)));
%compc.mean				= nanmean(tcompc,3);
%compc.std	 			= nanstd(tcompc,0,3);
for r=1:length(tcompc(:,1,1))
	for c=1:length(tcompc(1,:,1))
	compc.mean(r,c) = pmean(tcompc(r,c,:));
	compc.std(r,c) = pstd(tcompc(r,c,:));
	end
end	
%}
fprintf('\n')
