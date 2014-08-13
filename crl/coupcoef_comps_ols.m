clear all
var1='nrbp26_crlg_sample'
var2='nrbp26_crl_sample'
EDDY_FILE='/matlab/matlab/eddy-wind/tracks/midlat_tracks'
rad=1;


OUT_HEAD   = 'TRANS_W_NOR_';
%OUT_PATH   = '/Volumes/wombat/data1/pgaube/trans_samp/';
OUT_PATH   = '/matlab/matlab/global/trans_samp/';
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

% Create marix

tmp_var1=single(nan(81,81,length(id)));
tmp_var2=tmp_var1;

sta=1;



for m=1:length(jdays)
    fprintf('\r     sampling week %03u of %03u \r',m,length(jdays))
    load([OUT_PATH OUT_HEAD num2str(jdays(m))],var1,var2,'id_index','y_index');
    eval(['data1 = ' var1 ';'])
    eval(['data2 = ' var2 ';'])
    
    day_id=unique(id(track_jday==jdays(m)));
    ii=sames(day_id,id_index);
    if any(ii)
    for pp=1:length(ii)
		tmp_var1(:,:,sta)=1e5*single(data1(:,:,ii(pp)));
		tmp_var2(:,:,sta)=1e5*single(data2(:,:,ii(pp)));
		sta=sta+1;  
    end
    end
end    

clearallbut tmp_var1 tmp_var2 tbins var1 var2 EDDY_FILE
%whos
[beta_ols,beta_lin]=deal(nan(81,81));


for m=1:81
	for n=1:81
		x=squeeze(tmp_var1(m,n,:));
		y=squeeze(tmp_var2(m,n,:));
		beta_ols(m,n)=ols_pca(-x,y);
		[dd,bb]=reg(-x,y,'lin');
		beta_lin(m,n)=bb(2);
	end
end	


%eval(['save ' var1 '_' var2 '_coupcoef_comps tmp_var* var1 var2 EDDY_FILE a_a a_c b_a b_c -V7.3'])
eval(['save ' var1 '_' var2 '_coupcoef_reg_out beta_*'])
fprintf('\n')