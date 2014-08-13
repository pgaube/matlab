clear all
var1='nrhp66_crlg_sample'
var2='nrhp66_crl_sample'
EDDY_FILE='/matlab/matlab/eddy-wind/tracks/midlat_tracks'
rad=1;


OUT_HEAD   = 'TRANS_W_NOR_';
OUT_PATH   = '/home/wombat/data1/pgaube/trans_samp/';
load(EDDY_FILE);
%using old jdays
startjd=2451395;
endjd=2454461;


% subset eddies to dates where we have samples of all our shit
f1=find(track_jday>=startjd & track_jday<=endjd);

id=id(f1);
track_jday=track_jday(f1);
y=y(f1);
jdays=[min(track_jday):7:max(track_jday)];

% Create indicies
uid=unique(id);
icid = find(id<nneg);
iaid = find(id>=nneg);

% Create marix

tmp_var1_a=single(nan(81,81,length(iaid)));
tmp_var2_a=tmp_var1_a;

tmp_var1_c=single(nan(81,81,length(icid)));
tmp_var2_c=tmp_var1_c;

sta=1;
stc=1;


for m=1:length(jdays)
    fprintf('\r     sampling week %03u of %03u \r',m,length(jdays))
    load([OUT_PATH OUT_HEAD num2str(jdays(m))],var1,var2,'id_index','y_index');
    eval(['data1 = ' var1 ';'])
    eval(['data2 = ' var2 ';'])
    
    day_id=unique(id(track_jday==jdays(m)));
    ii=sames(day_id,id_index);
    if any(ii)
    for pp=1:length(ii)
    	if (id_index(ii(pp))>=nneg & y_index(ii(pp))<0) | (id_index(ii(pp))<nneg & y_index(ii(pp))>0)
            tmp_var1_a(:,:,sta)=1e5*single(data1(:,:,ii(pp)));
            tmp_var2_a(:,:,sta)=1e5*single(data2(:,:,ii(pp)));
            sta=sta+1;
        else
        	tmp_var1_c(:,:,stc)=1e5*single(data1(:,:,ii(pp)));
            tmp_var2_c(:,:,stc)=1e5*single(data2(:,:,ii(pp)));
            stc=stc+1;
        end    
    end
    end
end    
%whos
%
ibad=find(isnan(tmp_var1_a(41,41,:)));
tmp_var1_a(:,:,ibad)=[];
tmp_var2_a(:,:,ibad)=[];

ibad=find(isnan(tmp_var1_c(41,41,:)));
tmp_var1_c(:,:,ibad)=[];
tmp_var2_c(:,:,ibad)=[];
%

clearallbut tmp_var1_a tmp_var2_a tmp_var1_c tmp_var2_c tbins var1 var2 EDDY_FILE
%whos
beta_ols_a=nan(81,81);
%int_ols_a=beta_ols_a;
beta_ols_c=beta_ols_a;
%int_ols_c=beta_ols_a;

for m=1:81
	for n=1:81
		%[blah,gu]=reg(squeeze(tmp_var1_a(m,n,:)),squeeze(tmp_var2_a(m,n,:)),'lin');
		%[t1,t2]=ols_line(squeeze(tmp_var1_a(m,n,:)),squeeze(tmp_var2_a(m,n,:)),double(gu(2)));
		beta_ols_a(m,n)=ols_pca(-squeeze(tmp_var1_a(m,n,:)),squeeze(tmp_var2_a(m,n,:)));
		%int_ols_a(m,n)=t1;
		%clear t1 t2
		%[blah,gu]=reg(squeeze(tmp_var1_c(m,n,:)),squeeze(tmp_var2_c(m,n,:)),'lin');
		%[t1,t2]=ols_line(squeeze(tmp_var1_c(m,n,:)),squeeze(tmp_var2_c(m,n,:)),double(gu(2)));
		beta_ols_c(m,n)=ols_pca(-squeeze(tmp_var1_c(m,n,:)),squeeze(tmp_var2_c(m,n,:)));
		%beta_ols_c(m,n)=t2;
		%int_ols_c(m,n)=t1;
		%clear t1 t2
	end
end	

%save tmp beta_ols_a beta_ols_c


mean_crlg_a=double(nanmean(tmp_var1_a,3));
mean_crlg_c=double(nanmean(tmp_var1_c,3));
mean_crl_a=double(nanmean(tmp_var2_a,3));
mean_crl_c=double(nanmean(tmp_var2_c,3))

%eval(['save ' var1 '_' var2 '_coupcoef_comps tmp_var* var1 var2 EDDY_FILE a_a a_c b_a b_c -V7.3'])
eval(['save ' var1 '_' var2 '_coupcoef_reg_out a_a b_a a_c b_c mean_*'])
fprintf('\n')