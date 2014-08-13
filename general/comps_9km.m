function [compa,compc] = comps(EDDY_FILE,var,METHOD);
%function [compa,compc] = comps(EDDY_FILE,var,METHOD);
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


if METHOD=='r'
%OUT_HEAD   = 'TRANS_W_ROT_';
%OUT_PATH   = '/Volumes/matlab/matlab/global/ro_trans_samp/';
OUT_HEAD   = 'TRANS_W_4km_';
OUT_PATH   = '/Volumes/matlab/matlab/global/old_trans_9km/';
elseif METHOD=='n'
OUT_HEAD   = 'TRANS_W_NOR_';
OUT_PATH   = '/Volumes/matlab/matlab/global/trans_samp/';
elseif METHOD=='w'
OUT_HEAD   = 'TRANS_W_WIR_';
OUT_PATH   = '/Volumes/matlab/matlab/global/wro_trans_samp/';
end


% First load the tracks you want to composite
load(EDDY_FILE);
startjd=2450821;
endjd=2454489;

% subset eddies to dates where we have samples of all our shit
f1=find(track_jday>=startjd & track_jday<=endjd);

id=id(f1);
eid=eid(f1);
x=x(f1);
y=y(f1);
amp=amp(f1);
axial_speed=axial_speed(f1);
efold=efold(f1);
radius=radius(f1);
track_jday=track_jday(f1);
prop_speed=prop_speed(f1);
k=k(f1);
b=1;
jdays=[min(track_jday):7:max(track_jday)];

% Create indicies
uid=unique(id);
icuid = find(uid<nneg);
iauid = find(uid>=nneg);

% Create matrices to save jdays
load([OUT_PATH OUT_HEAD num2str(startjd+14)],var);
eval(['data = ' var ';']);
[M]=length(data(:,1));
Na=double(ones(M,M));
Nc=double(ones(M,M));
tcompa=double(zeros(M,M));
tcompc=double(zeros(M,M));
tvara=double(zeros(M,M));
tvarc=double(zeros(M,M));

for m=1:length(jdays)
    fprintf('\r     compositing week %03u of %03u \r',m,length(jdays))
    load([OUT_PATH OUT_HEAD num2str(jdays(m))],var,'*_index');
    eval(['data = ' var ';'])
    %size(data)
    
    ii=sames(uid,id_index);
    if any(ii)
        for pp=1:length(ii)
            obs=data(:,:,ii(pp));
            obs(find(isnan(obs)))=0;
            n=~isnan(data(:,:,ii(pp)));
            if id_index(ii(pp))>=nneg;
                tcompa=(1./(Na+n)).*((tcompa.*Na)+(obs.*n));
                tvara = ((1./(Na+n)).*((tcompa.*Na)+(obs.^2.*n))) ...
                		./ (tcompa.^2);
                %figure(1)
                %pcolor(double(compa));shading flat;drawnow;caxis([-.5 .5])
                Na=Na+n;
            else
                tcompc=(1./(Nc+n)).*((tcompc.*Nc)+(obs.*n));
                tvarc = ((1./(Na+n)).*((tcompc.*Nc)+(obs.^2.*n))) ...
                		./ (tcompc.^2);
                %figure(2)
                %pcolor(double(compc));shading flat;drawnow;caxis([-.5 .5])
                Nc=Nc+n;
            end
        end
    end
end


tcompa(tcompa==0)=nan;
tcompc(tcompc==0)=nan;

tvara(tvara==0)=nan;
tvarc(tvarc==0)=nan;

% build structure array
compa.mean  			= tcompa;
compa.var	  			= tvara;
compa.N 				= Na;
compa.n_max_sample		= max(Na(:));
compa.n_time_steps		= length(id);
compa.per_cov			= Na./max(Na(:));

compc.mean  			= tcompc;
compc.var	  			= tvarc;
compc.N 				= Nc;
compc.n_max_sample		= max(Nc(:));
compc.n_time_steps		= length(id);
compc.per_cov			= Nc./max(Nc(:));


fprintf('\n')
