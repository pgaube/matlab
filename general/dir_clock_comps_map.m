function [compc,compcc] = dir_clock_comps(id,track_jday,y,var,dir,METHOD);
%function [compc,compcc] = dir_clock_comps(id,track_jday,y,var,dir,METHOD);
%
% Makes composest of the samples 'var'
%
% INPUT:
% EDDY_FILE = file name of eddies over which to composite
% var = variable name, see TRANS_W_25_* files
% METHOD = how the varible is sampled
% dir = 'N' or 'S'
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
OUT_PATH   = '/matlab/matlab/global/ro_200_trans_samp/';
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
elseif METHOD=='w'
OUT_HEAD   = 'TRANS_W_WIR_';
OUT_PATH   = '/matlab/matlab/global/wro_trans_samp/';
end

f1=find(track_jday>=startjd & track_jday<=endjd);
id=id(f1);
y=y(f1);
track_jday=track_jday(f1);

load /matlab/data/eddy/V4/global_tracks_V4_12_weeks nneg lat lon
jdays=[min(track_jday):7:max(track_jday)];
lj=length(jdays);
lid=length(id);


% Create indicies
uid=unique(id);
ic = length(find((id<nneg & y<0) | (id>=nneg & y>0)));
ia = length(find((id>=nneg & y<0) | (id<nneg & y>0)));
% Create matrices to save jdays
load([OUT_PATH OUT_HEAD num2str(startjd)],var);
eval(['data = ' var ';']);
[M]=length(r_comp);
tcompa=single(nan(M,M,ia));
Na=single(ones(M,M));
id_comp=nan(ia,1);
x_comp=id_comp;
y_comp=x_comp;
zza=1;

for m=1:lj
    fprintf('\r                 compositing week %03u of %03u \r',m,length(jdays))
    load([OUT_PATH OUT_HEAD num2str(jdays(m))],var,'id_index','y_index','rot_index','x_index');
    eval(['data = ' var ';'])
    %size(data)
    day_id=unique(id(track_jday==jdays(m)));
    
    ii=sames(day_id,id_index);
    if any(ii)
        for pp=1:length(ii)
        switch var
        	case {'nrssh_sample'}
            	obs=abs(data(r_comp,c_comp,ii(pp)));
            otherwise
            	obs=data(r_comp,c_comp,ii(pp));
        end	
            n=~isnan(data(r_comp,c_comp,ii(pp)));
            if rot_index(ii(pp))==dir
            if (id_index(ii(pp))>=nneg & y_index(ii(pp))<0) | (id_index(ii(pp))<nneg & y_index(ii(pp))>0)
                tcompa(:,:,zza)=single(obs);
                id_comp(zza)=id_index(ii(pp));
                x_comp(zza)=x_index(ii(pp));
                y_comp(zza)=y_index(ii(pp));
                zza=zza+1;
                Na=Na+n;
                
                %fprintf('\n   %05u of %05u %05u of %05u \r',zza,ia,zzc,ic)
                %figure(1)
                %clf
                %pcolor(double(obs));shading flat
                %caxis([-.1 .1])
                %drawnow
            end
            end
        end
    end
    clear id_index ii pp day_id
end

%clearallbut tcompa tcompc Na Nc id r_comp c_comp ia ic



% build structure array
for m=1:length(r_comp)
	for n=1:length(c_comp)
		compcc.median(m,n) = nanmedian(squeeze(tcompa(m,n,:)));
	end
end

compcc.N 				= Na-1;
compcc.n_max_sample		= max(Na(:));
compcc.n_eddies		    = length(unique(id_comp(find(~isnan(id_comp)))));
compcc.n_eddy_obs	    = length(find(~isnan(id_comp)));
compcc.per_cov			= 100*(Na./max(Na(:)));
compcc.x_locs			= x_comp;
compcc.y_locs			= y_comp;

for r=1:length(tcompa(:,1,1))
	for c=1:length(tcompa(1,:,1))
	compcc.mean(r,c) = pmean(tcompa(r,c,:));
	compcc.std(r,c) = pstd(tcompa(r,c,:));
	end
end	

clear tcompa Na id_comp x_comp y_comp

tcompc=single(nan(M,M,ic));
Nc=single(ones(M,M));
id_comp=nan(length(ic),1);
x_comp=id_comp;
y_comp=x_comp;
zzc=1;

for m=1:lj
    fprintf('\r                 compositing week %03u of %03u \r',m,length(jdays))
    load([OUT_PATH OUT_HEAD num2str(jdays(m))],var,'id_index','y_index','x_xomp','rot_index');
    eval(['data = ' var ';'])
    %size(data)
    day_id=unique(id(track_jday==jdays(m)));
    
    ii=sames(day_id,id_index);
    if any(ii)
        for pp=1:length(ii)
        switch var
        	case {'nrssh_sample'}
            	obs=abs(data(r_comp,c_comp,ii(pp)));
            otherwise
            	obs=data(r_comp,c_comp,ii(pp));
        end	
            n=~isnan(data(r_comp,c_comp,ii(pp)));
            if rot_index(ii(pp))==dir
            if (id_index(ii(pp))>=nneg & y_index(ii(pp))>0) | (id_index(ii(pp))<nneg & y_index(ii(pp))<0)            
                tcompc(:,:,zzc)=single(obs);
                id_comp(zzc)=id_index(ii(pp));
                x_comp(zzc)=x_index(ii(pp));
                y_comp(zzc)=y_index(ii(pp));
                zzc=zzc+1;
                Nc=Nc+n;
                %fprintf('\n   %05u of %05u %05u of %05u \r',zza,ia,zzc,ic)
                %figure(1)
                %clf
                %pcolor(double(obs));shading flat
                %caxis([-.1 .1])
                %drawnow
            end
            end
        end
    end
    clear id_index ii pp day_id
end

%clearallbut tcompa tcompc Na Nc id 

for m=1:length(r_comp)
	for n=1:length(c_comp)
		compc.median(m,n) = nanmedian(squeeze(tcompc(m,n,:)));
	end
end

compc.N 				= Nc-1;
compc.n_max_sample		= max(Nc(:));
compc.n_eddies		    = length(unique(id_comp(find(~isnan(id_comp)))));
compc.n_eddy_obs	    = length(find(~isnan(id_comp)));
compc.per_cov			= 100*(Nc./max(Nc(:)));
compc.x_locs			= x_comp;
compc.y_locs			= y_comp;

for r=1:length(tcompc(:,1,1))
	for c=1:length(tcompc(1,:,1))
	compc.mean(r,c) = pmean(tcompc(r,c,:));
	compc.std(r,c) = pstd(tcompc(r,c,:));
	end
end	


fprintf('\n')
