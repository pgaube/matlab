function [sel_means,sel_N,sel_ids,sel_eid,sel_k,sel_amp] = means_4km(EDDY_FILE,var);
%function [sel_field,sel_ids,sel_edi,sel_k,sel_amp] = sels_4km(EDDY_FILE,var);
%chl_anom_sample       145x145x1026            86286600  single              
%chl_sample            145x145x1026            86286600  single              
%eid_index            1026x1                       8208  double              
%id_index             1026x1                       8208  double              
%k_index              1026x1                       8208  double  
%

c=73;
OUT_HEAD   = 'TRANS_W_4km_';
OUT_PATH   = '/Volumes/matlab/matlab/global/new_trans_4km/';
% First load the tracks you want to composite
load(EDDY_FILE);

load([OUT_PATH 'TRANS_W_4km_2454468'],var)
eval(['tmp = ' var ';']);
BOX=(length(tmp(1,:,1))-1);
startjd=2452459;
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
sel_means=nan(length(id),1);
sel_N=sel_means;


for m=1:length(jdays)
    fprintf('\r     selecting sample from week %03u of %03u \r',m,length(jdays))
    load([OUT_PATH OUT_HEAD num2str(jdays(m))],var,'*_index');
	eval(['data = ' var ';']);
	ii=sames(uid,id_index);
    if any(ii)
        for n=1:length(ii)
            tmp = data(c-20:c+20,c-20:c+20,ii(n));
			sel_means(b) = pmean(tmp(:));
			sel_N(b) = length(find(~isnan(tmp)));
            sel_ids(b)=id_index(ii(n));
            sel_eid(b)=eid_index(ii(n));
            sel_k(b)=k_index(ii(n));
            b=b+1;
        end
    end
end

fprintf('\n')



