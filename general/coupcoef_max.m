
clear all
var1='nrhp66_crl_21_sample'
var2='nrhp66_crlg_sample'
EDDY_FILE='/Volumes/matlab/matlab/air-sea/tracks/midlat_track_V4_16_weeks.mat'
rad=1.6;


OUT_HEAD   = 'TRANS_W_NOR_';
OUT_PATH   = '/Volumes/matlab/matlab/global/trans_samp_old/';
load(EDDY_FILE);
startjd=2452459+7;
endjd=2454489-7;

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
	yi=xi'	;
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
[tmp_var1]=single(nan(length(id).*length(~isnan(mask))*10,1));
tmp_var2=tmp_var1;
%[tmp_var1,tmp_var2]=deal(0);

st=1;

for m=1:length(jdays)
    fprintf('\r     sampling week %03u of %03u \r',m,length(jdays))
    load([OUT_PATH OUT_HEAD num2str(jdays(m))],var1,var2,'id_index');
    eval(['data1 = ' var1 ';'])
    eval(['data2 = ' var2 ';'])
    %size(data)
    ii=sames(uid,id_index);
    if any(ii)
    for pp=1:length(ii)
            obs1=mask.*data1(:,:,ii(pp));
            obs2=mask.*data2(:,:,ii(pp));
            obs1=obs1(:);
            obs2=obs2(:);
            tmp_flag=single(find(isnan(obs1)));
            obs1(tmp_flag)=[];
            obs2(tmp_flag)=[];
            tmp_flag=single(find(isnan(obs2)));
            obs1(tmp_flag)=[];
            obs2(tmp_flag)=[];
            tempr=obs1;
            mm=find(abs(obs1)==max(abs(tempr(:))));
            if any(mm)
            tmp_var1(st)=single(obs1(mm(1)));
            tmp_var2(st)=single(obs2(mm(1)));
            st=st+1;
            %tmp_var1=cat(1,tmp_var1,obs1(mm(1)));
            %tmp_var2=cat(1,tmp_var2,obs2(mm(1)));
            end
    end
    end
end     

clearallbut tmp_var1 tmp_var2 tbins var1 var2 EDDY_FILE


fprintf('\n     flaging \r')
flag=find(isnan(tmp_var1));
tmp_var1(flag)=[];
tmp_var2(flag)=[];
flag=find(isnan(tmp_var2));
tmp_var1(flag)=[];
tmp_var2(flag)=[];
clear flag


eval(['save max_' var1 '_' var2 '_coupcoef tmp_var* var1 var2 EDDY_FILE'])
fprintf('\n')