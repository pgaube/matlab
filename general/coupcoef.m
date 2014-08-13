
clear all
var1='bp26_crlg_sample'
var2='bp26_crl_sample'
EDDY_FILE='/matlab/matlab/air-sea/tracks/midlat_track_ids_V4_16_weeks.mat'
rad=1;


OUT_HEAD   = 'TRANS_W_NOR_';
OUT_PATH   = '/matlab/matlab/global/trans_samp/';
load(EDDY_FILE,'track_jday','id','nneg');
%using old jdays
startjd=2451395;
endjd=2454461;


% subset eddies to dates where we have samples of all our shit
f1=find(track_jday>=startjd & track_jday<=endjd);

id=id(f1);
track_jday=track_jday(f1);
jdays=[min(track_jday):7:max(track_jday)];

% Create indicies
uid=unique(id);
icuid = find(uid<nneg);
iauid = find(uid>=nneg);



% initalize
%[tmp_var1]=single(nan(length(id)*81*81,1));
[tmp_var1]=single(nan(length(id)*41*41,1));
%[tmp_var1]=single(nan(length(id).*length(~isnan(mask))*10,1));
tmp_var2=tmp_var1;

st=1;
%mask=nan(81,81);
mask=nan(41,41);
mask(:,:)=1;
%mask(25:57,25:57)=1;

for m=1:length(jdays)
    fprintf('\r     sampling week %03u of %03u \r',m,length(jdays))
    load([OUT_PATH OUT_HEAD num2str(jdays(m))],var1,var2,'id_index');
    eval(['data1 = ' var1 ';'])
    eval(['data2 = ' var2 ';'])
    %size(data)
    day_id=unique(id(track_jday==jdays(m)));
    ii=sames(day_id,id_index);
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
                        
            tmp_var1(st:st-1+length(obs1(:)),1)=single(obs1(:));
            tmp_var2(st:st-1+length(obs1(:)),1)=single(obs2(:));
            st=st+length(obs1(:));
    end
    end
end     

clearallbut tmp_var1 tmp_var2 tbins var1 var2 EDDY_FILE


fprintf('\n     flaging \r')
tmp_var2(find(isnan(tmp_var1)))=[];
tmp_var1(find(isnan(tmp_var1)))=[];

tmp_var1(find(isnan(tmp_var2)))=[];
tmp_var2(find(isnan(tmp_var2)))=[];

eval(['save -v7.3 ' var1 '_' var2 '_coupcoef tmp_var* var1 var2 EDDY_FILE'])
fprintf('\n')