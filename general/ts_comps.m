function [tsa,tsc] = ts_comps(EDDY_FILE,var,ra,ca,rc,cc);
%function [tsa,tsc] = ts_comps(EDDY_FILE,var,ra,ca,rc,cc);
%
% Makes time series of composest of the samples 'var' at locations 'x' and 'y'
%
% INPUT:
% EDDY_FILE = file name of eddies over which to composite
% var = variable name, see TRANS_W_25_* files
% r   = x-location of point to make ts_comp of
% c   = y-location of point to make ts_comp of
%
% OUTPUT:
% tsa, tsc = composites, these are structure files with the following
% 				 atributes:
%		mean
%		N
%		var



OUT_HEAD   = 'TRANS_W_';
OUT_PATH   = '/Volumes/matlab/matlab/global/new_trans_samp/';
% First load the tracks you want to composite
load(EDDY_FILE);
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

%set counters
laya=1;
layc=1;

%create arrays to save time
tmpa=zeros(410000,1);
tmpc=tmpa;
tmpka=tmpa;
tmpkc=tmpa;


for m=1:length(jdays)
    fprintf('\r     compositing week %03u of %03u \r',m,length(jdays))
    load([OUT_PATH OUT_HEAD num2str(jdays(m))],var,'id_index','k_index');
	eval(['data = ' var ';'])
	
    ii=sames(uid,id_index);
    if any(ii)
        for pp=1:length(ii)
            if id_index(ii(pp))>=nneg;
                tmpa(laya)   = data(ra,ca,ii(pp));
                tmpka(laya)  = k_index(ii(pp));
                laya=laya+1;
            else
                tmpc(layc) = data(rc,cc,ii(pp));
                tmpkc(layc)  = k_index(ii(pp));
                layc=layc+1;
            end
        end
    end
end

rrr=find(tmpa==0 & tmpka==0);
tmpa(rrr)=[];
tmpka(rrr)=[];
rrr=find(tmpc==0 & tmpkc==0);
tmpc(rrr)=[];
tmpkc(rrr)=[];


%do bin averaging
tbins=1:max(max(tmpka),max(tmpkc))+1;
for i=1:length(tbins)-1
    bin_est = find(tmpka>=tbins(i) & tmpka<tbins(i+1));
    tsa.mean(i)  = pmean(tmpa(bin_est));
    tsa.std(i)    = pstd(tmpa(bin_est));
    tsa.N(i)      = length(bin_est);
    
    bin_est = find(tmpkc>=tbins(i) & tmpkc<tbins(i+1));
    tsc.mean(i)  = pmean(tmpc(bin_est));
    tsc.std(i)    = pstd(tmpc(bin_est));
    tsc.N(i)      = length(bin_est);
end

fprintf('\n')
