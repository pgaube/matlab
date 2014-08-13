function [sel_field,sel_ids,sel_eid,sel_k,sel_amp] = sels_4km(EDDY_FILE,var);
%function [sel_field,sel_ids,sel_edi,sel_k,sel_amp] = sels_4km(EDDY_FILE,var);
%chl_anom_sample       145x145x1026            86286600  single              
%chl_sample            145x145x1026            86286600  single              
%eid_index            1026x1                       8208  double              
%id_index             1026x1                       8208  double              
%k_index              1026x1                       8208  double  
%

OUT_HEAD   = 'TRANS_W_4km_';
OUT_PATH   = '/Volumes/matlab/matlab/global/trans_samp_4km/';
% First load the tracks you want to composite
load(EDDY_FILE);

load([OUT_PATH 'TRANS_W_4km_2454468'],'chl_sample')
BOX=(length(chl_sample(1,:,1))-1);
startjd=2452459;

% subset eddies to dates where we have samples of all our shit
f1=find(track_jday>=startjd);

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
sel_field=single(nan(BOX+1,BOX+1,length(id)));


for m=1:length(jdays)
    fprintf('\r     selecting sample from week %03u of %03u \r',m,length(jdays))
    load([OUT_PATH OUT_HEAD num2str(jdays(m))],var,'*_index');
	eval(['data = ' var ';']);
	ii=sames(uid,id_index);
    if any(ii)
        for n=1:length(ii)
            sel_field(:,:,b)=data(:,:,ii(n));
            sel_ids(b)=id_index(ii(n));
            sel_eid(b)=eid_index(ii(n));
            sel_k(b)=k_index(ii(n));
            sel_amp(b)=amp_index(ii(n));
            b=b+1;
        end
    end
end

fprintf('\n')



