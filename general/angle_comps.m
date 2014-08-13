function [compa,compc] = angle_comps(id,track_jday,min_theta1,max_theta1,min_theta2,max_theta2,var);
%function [compa,compc] = angle_comps(id,track_jday,min_theta1,max_theta1,min_theta2,max_theta2,var);
%
% Makes composest of the samples 'var'
%
% INPUT:
% EDDY_FILE = file name of eddies over which to composite
% var = variable name, see TRANS_W_25_* files

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


load /matlab/data/eddy/V4/global_tracks_V4_12_weeks nneg

OUT_HEAD   = 'TRANS_W_NOR_';
OUT_PATH   = '/matlab/matlab/global/trans_samp/';
r_comp=17:65;
c_comp=17:65;

f1=find(track_jday>=startjd & track_jday<=endjd);
id=id(f1);
track_jday=track_jday(f1);

jdays=[min(track_jday):7:max(track_jday)];
lj=length(jdays);
lid=length(id);


% Create indicies
uid=unique(id);
ic = length(find(id<nneg));
ia = length(find((id>=nneg)));
% Create matrices to save jdays
load([OUT_PATH OUT_HEAD num2str(startjd)],var);
eval(['data = ' var ';']);
[M]=length(r_comp);

tcompa=single(nan(M,M,ia));
Na=single(ones(M,M));
zza=1;

tcompc=single(nan(M,M,ic));
Nc=single(ones(M,M));
zzc=1;

for m=1:lj
    fprintf('\r                 compositing week %03u of %03u \r',m,length(jdays))
    load([OUT_PATH OUT_HEAD num2str(jdays(m))],var,'id_index','wind_index');
    eval(['data = ' var ';'])
    %size(data)
    day_id=unique(id(track_jday==jdays(m)));
    ii=sames(day_id,id_index);
    if any(ii)
        for pp=1:length(ii)
            n=~isnan(data(r_comp,c_comp,ii(pp)));
            obs=data(r_comp,c_comp,ii(pp));
            if (id_index(ii(pp))>=nneg & abs(wind_index(ii(pp)))>=min_theta1 & abs(wind_index(ii(pp)))<=max_theta1) |...
               (id_index(ii(pp))>=nneg & abs(wind_index(ii(pp)))>=min_theta2 & abs(wind_index(ii(pp)))<=max_theta2)
                tcompa(:,:,zza)=single(obs);
                zza=zza+1;
                Na=Na+n;
                %fprintf('\n   %05u of %05u %05u of %05u \r',zza,ia,zzc,ic)
                %figure(1)
                %clf
                %pcolor(double(obs));shading flat
                %caxis([-.1 .1])
                %drawnow
            elseif (id_index(ii(pp))<nneg & abs(wind_index(ii(pp)))>=min_theta1 & abs(wind_index(ii(pp)))<=max_theta1) |...
               (id_index(ii(pp))<nneg & abs(wind_index(ii(pp)))>=min_theta2 & abs(wind_index(ii(pp)))<=max_theta2)            
                tcompc(:,:,zzc)=single(obs);
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
    clear id_index ii pp day_id
end

%build structure array
for m=1:length(r_comp)
	for n=1:length(c_comp)
		compa.median(m,n) = nanmedian(squeeze(tcompa(m,n,:)));
	end
end

compa.N 				= Na-1;
compa.n_max_sample		= max(Na(:));
compa.n_eddies		    = length(id);
compa.per_cov			= 100*(Na./max(Na(:)));

for r=1:length(tcompa(:,1,1))
	for c=1:length(tcompa(1,:,1))
	compa.mean(r,c) = pmean(tcompa(r,c,:));
	compa.std(r,c) = pstd(tcompa(r,c,:));
	end
end	

clear tcompa Na

for m=1:length(r_comp)
	for n=1:length(c_comp)
		compc.median(m,n) = nanmedian(squeeze(tcompc(m,n,:)));
	end
end

compc.N 				= Nc-1;
compc.n_max_sample		= max(Nc(:));
compc.n_eddies		    = length(id);
compc.per_cov			= 100*(Nc./max(Nc(:)));

for r=1:length(tcompc(:,1,1))
	for c=1:length(tcompc(1,:,1))
	compc.mean(r,c) = pmean(tcompc(r,c,:));
	compc.std(r,c) = pstd(tcompc(r,c,:));
	end
end	


fprintf('\n')
