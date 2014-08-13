%loads SeaWiFS CHL data
%clear all
%close all


jdays=[2452459:7:2454489];%[2451556:7:2454797];
lj=length(jdays);


save_path='/matlab/data/gsm/mat/';
save_head='GSM_9_21_';
asave_path='/matlab/data/eddy/V4/mat/';
asave_head='AVISO_25_W_';
qsave_path='/matlab/data/QuickScat/mat/';
qsave_head='QSCAT_30_25km_';
osave_path='/matlab/data/ReynoldsSST/mat/';
osave_head='OI_25_30_';


load([save_path save_head num2str(jdays(1))],'glon','glat')
load([asave_path asave_head num2str(jdays(1))],'lon','lat')
slat=lat;
slon=lon;
load([osave_path osave_head num2str(jdays(1))],'lon','lat')
olat=lat;
olon=lon;
load([qsave_path qsave_head num2str(jdays(100))],'lon','lat')


[rs,cs]=imap(min(lat(:)),max(lat(:)),1,1,slat,slon);
[r,c]=imap(min(lat(:)),max(lat(:)),1,1,glat,glon);
[ro,co]=imap(min(lat(:)),max(lat(:)),1,1,olat,olon);

sst=nan(length(lat(:,1)),1440,lj);
fsst=sst;
chl=sst;
fchl=sst;
%sm_wek=full_wek;
%bp_wek=full_wek;
%gwek=full_wek;
%sst=full_wek;
%u=full_wek;
%v=full_wek;
%gx=u;
%gy=u;
%spd=u;
ff=f_cor(lat);
ff=(8640000./(1020.*ff));

for m=1:lj
	fprintf('\r    loading %03u of %03u\r',m,lj)
	%load([qsave_path qsave_head num2str(jdays(m))],'wspd_week','u_week','v_week','wspd_week','crlstr_week','sm_crlstr_week','w_ek')
	%load([qsave_path qsave_head num2str(jdays(m))],'u_week','v_week')
	%load([asave_path asave_head num2str(jdays(m))],'bp26_crlg')
	load([osave_path osave_head num2str(jdays(m))],'sst_week','bp26_sst')
	load([save_path  save_head num2str(jdays(m))],'bp26_chl','gchl_week')
	%full_wek(:,:,m)=ff.*crlstr_week;
	%sm_wek(:,:,m)=ff.*sm_crlstr_week;
	%bp_wek(:,:,m)=w_ek;
	%gwek(:,:,m)=-ff.*bp26_crlg(rs,:);
	sst(:,:,m)=sst_week(ro,:);
	fsst(:,:,m)=bp26_sst(ro,:);
	chl(:,:,m)=flipud(gchl_week(r,:));
	fchl(:,:,m)=flipud(bp26_chl(r,:));
	%u(:,:,m)=u_week;
	%v(:,:,m)=v_week;
	%spd(:,:,m)=wspd_week;
	%gx(:,:,m)=dfdx(lat,sst_week(ro,:),.25);
	%gy(:,:,m)=dfdy(sst_week(ro,:),.25);
end

%save -v7.3 tmp lat lon CHL SSH
%now do correlation

%mean_sm_wek=nanmean(sm_wek,3);
%mean_full_wek=nanmean(full_wek,3);
%mean_bp_wek=nanmean(bp_wek,3);
%mean_gwek=nanmean(gwek,3);

var_fsst=nanvar(fsst,1,3);
mag_fsst=nanmean(abs(fsst),3);
var_fchl=nanvar(fchl,1,3);
mag_fchl=nanmean(abs(fchl),3);
var_chl=nanvar(chl,1,3);

save -append var_sst var_* mag_*
return
st=nanmean(sst,3);
sst_bar=ones(size(sst));
for m=1:length(sst(1,1,:))
	sst_bar(:,:,m)=sst_bar(:,:,m).*st;
end

rms_sst=sqrt(nanmean((sst-sst_bar).^2,3));
u2=u.^2;
v2=v.^2;
va=nanmean(sqrt(u2+v2),3);
sa=sqrt(nanmean(u2,3)+nanmean(v2,3));
dir_steady=va./sa;
u2=gx.^2;
v2=gy.^2;
va=nanmean(sqrt(u2+v2),3);
sa=sqrt(nanmean(u2,3)+nanmean(v2,3));
grad_steady=va./sa;

save -append mean_wek_maps *steady rms* 
