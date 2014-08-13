
clear all
var1='nrhp66_crlg_sample'
var2='nrhp66_crl_21_sample'
EDDY_PATH='/Volumes/matlab/matlab/air-sea/tracks/'
EDDY_NAME='south_tracks_V4_16_weeks'
EDDY_FILE=[EDDY_PATH EDDY_NAME '.mat'];
rad=1.6;


OUT_HEAD   = 'TRANS_W_NOR_';
OUT_PATH   = '/Volumes/matlab/matlab/global/trans_samp/';
load(EDDY_FILE);
tmp_id=id;
tmp_track_jday=track_jday;


startjd=2451395;
endjd=2454811;

% subset eddies to dates where we have samples of all our shit
f1=find(track_jday>=startjd & track_jday<=endjd);

id=id(f1);
track_jday=track_jday(f1);
jdays=[min(track_jday):7:max(track_jday)];

% Create indicies
uid=unique(id);
icuid = find(uid<nneg);
iauid = find(uid>=nneg);

% Create mask
load([OUT_PATH OUT_HEAD num2str(jdays(1))],var1);
eval(['mask = nan*' var1 '(:,:,1);'])
if length(mask(:,1))==225
	xi=[-7:.25/4:7];
	xi=ones(length(xi),1)*xi;
	yi=xi';
	dist=sqrt(xi.^2+yi.^2);
	ii=find(dist<=rad);
	mask(ii)=1;
elseif 	length(mask(:,1))==81
	xi=[-5:.125:5];
	xi=ones(length(xi),1)*xi;
	yi=xi';
	dist=sqrt(xi.^2+yi.^2);
	ii=find(dist<=rad);
	mask(ii)=1;
else
	mask=ones(size(mask));
end


% initalize
%[tmp_var1]=single(nan(100000.*(41*41),1));
[tmp_var1_a]=single(nan(length(id),1));
tmp_var2_a=tmp_var1_a;
tmp_var1_c=tmp_var1_a;
tmp_var2_c=tmp_var1_a;


sta=1;
stc=1;


for m=1:length(jdays)
    fprintf('\r     sampling week %03u of %03u \r',m,length(jdays))
    load([OUT_PATH OUT_HEAD num2str(jdays(m))],var1,var2,'id_index');
    eval(['data1 = ' var1 ';'])
    eval(['data2 = ' var2 ';'])
    %size(data)
    ii=sames(uid,id_index);
    if any(ii)
    for pp=1:length(ii)
            obs1=data1(41,41,ii(pp));
            obs2=data2(41,41,ii(pp));
                        
            if id_index(ii(pp))>=nneg
            tmp_var1_a(sta,1)=single(obs1);
            tmp_var2_a(sta,1)=single(obs2);
            sta=sta+1;
            else
            tmp_var1_c(stc,1)=single(obs1);
            tmp_var2_c(stc,1)=single(obs2);
            stc=stc+1;
            end
            
    end
    end
end     

clearallbut tmp_var1_c tmp_var2_c tmp_var1_a tmp_var2_a tbins var1 var2 EDDY_NAME


fprintf('\n     flaging \r')
flag=find(isnan(tmp_var1_a));
tmp_var1_a(flag)=[];
tmp_var2_a(flag)=[];
clear flag
flag=find(isnan(tmp_var2_a));
tmp_var1_a(flag)=[];
tmp_var2_a(flag)=[];
clear flag

flag=find(isnan(tmp_var1_c));
tmp_var1_c(flag)=[];
tmp_var2_c(flag)=[];
clear flag
flag=find(isnan(tmp_var2_c));
tmp_var1_c(flag)=[];
tmp_var2_c(flag)=[];
clear flag


eval(['save ' var1 '_' var2 '_' EDDY_NAME '_coupcoef_eddy_cent tmp_var* var1 var2'])
fprintf('\n')