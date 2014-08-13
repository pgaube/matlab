function [compa,compc] = comps(EDDY_FILE,var);
%function [compa,compc] = comps(EDDY_FILE,var);
%
%amsre_sample         41x41x991            6663484  single              
%famsre_sample        41x41x991            6663484  single              
%foi_sample           41x41x991            6663484  single              
%lat_sample           41x41x991            6663484  single              
%lon_sample           41x41x991            6663484  single              
%nfamsre_sample       41x41x991            6663484  single              
%nfoi_sample          41x41x991            6663484  single              
%nssh_sample          41x41x991            6663484  single              
%oi_sample            41x41x991            6663484  single              
%ssh_sample           41x41x991    
%

OUT_HEAD   = 'TRANS_W_';
OUT_PATH   = '/Volumes/matlab/matlab/global/trans_samp/';

% First load the tracks you want to composite
load(EDDY_FILE);
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

% Create indicies
uid=unique(id);
icuid = find(uid<nneg);
iauid = find(uid>=nneg);
% next we need to loop through each uid to find max(k)

for m=1:length(uid)
    max_k(m)=max(k(id==uid(m)));
    max_day(m)=track_jday(find(k==max_k(m) & id==uid(m)));
end

% create a matrix of ids that end on each jday

jdays=[min(track_jday):7:max(track_jday)];
jdays=cat(1,jdays,nan(100,length(jdays)));

for m=1:length(jdays)
    tmpid = find(max_day==jdays(1,m));
    jdays(2:length(uid(tmpid))+1,m)=uid(tmpid);
end



% Create matrices to save jdays
load([OUT_PATH OUT_HEAD num2str(jdays(1,1))],var);
eval(['data = ' var ';']);
[M]=length(data(:,1));
N=single(nan(M,M,length(uid)));
%N=single(nan(M,M,length(uid)));
comp=N;

samps=single(nan(M,M,10000));


for m=1:length(jdays(1,:))
    fprintf('\r     compositing week %03u of %03u \r',m,length(jdays))
    load([OUT_PATH OUT_HEAD num2str(jdays(1,m))],var);
    eval(['data = ' var ';'])
    %size(data)
    load([OUT_PATH OUT_HEAD num2str(jdays(1,m))],'*_index')
    
ii=sames(uid,id_index);
    if any(ii)
        for n=1:length(ii)
            samps(:,:,b)=data(:,:,ii(n));
            comp_ids(b)=id_index(ii(n));
            b=b+1;
        end
    end

    stack_ids = jdays(~isnan(jdays(:,m)),m);
    stack_ids(1)=[];
    
    if any(stack_ids)
        for p=1:length(stack_ids)
            qq=find(comp_ids==stack_ids(p));
            dd=find(uid==stack_ids(p));
            if any(qq & dd)
                N(:,:,dd) = nansum(~isnan(samps(:,:,qq)),3);
                comp(:,:,dd) = nanmean(samps(:,:,qq),3);
                samps(:,:,qq)=[];
                comp_ids(qq)=[];
                b=b-length(qq);
            end 
        end
    end
end


compc = double((1./nansum(N(:,:,icuid),3)).* nansum(comp(:,:,icuid).*N(:,:,icuid),3));
compa = double((1./nansum(N(:,:,iauid),3)).* nansum(comp(:,:,iauid).*N(:,:,iauid),3));
fprintf('\n')


