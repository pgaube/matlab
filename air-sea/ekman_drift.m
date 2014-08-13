%loads SeaWiFS CHL data
%clear all
%close all


jdays=[2452459:7:2454489];%[2451556:7:2454797];
lj=length(jdays);

asave_path='/matlab/data/eddy/V4/mat/';
asave_head='AVISO_25_W_';
qsave_path='/matlab/data/QuickScat/mat/';
qsave_head='QSCAT_30_25km_';
osave_path='/matlab/data/ReynoldsSST/mat/';
osave_head='OI_25_30_';


load([asave_path asave_head num2str(jdays(1))],'lon','lat')
slat=lat;
slon=lon;
load([osave_path osave_head num2str(jdays(1))],'lon','lat')
olat=lat;
olon=lon;
load([qsave_path qsave_head num2str(jdays(100))],'lon','lat')


[rssh,cssh]=imap(min(lat(:)),max(lat(:)),1,1,slat,slon);
[ro,co]=imap(min(lat(:)),max(lat(:)),1,1,olat,olon);


ff=f_cor(lat);
Az=0.014;
De=pi*sqrt(2*Az./abs(ff));
rho=1024;

[rn,cn]=imap(0,90,0,360,lat,lon);
[rs,cs]=imap(-90,0,0,360,lat,lon);
for m=1:lj
	fprintf('\r    loading %03u of %03u\r',m,lj)
	load([qsave_path qsave_head num2str(jdays(m))],'strm_week','u_week','v_week','bp26_crlstr')
	Vo=(sqrt(2)*pi*strm_week)./(De.*rho.*abs(ff));
	theta=cart2pol(u_week,v_week);
	[u_n,v_n]=pol2cart(theta-(pi/4),Vo);
	[u_s,v_s]=pol2cart(theta+(pi/4),Vo);
	u_e=nan*u_n;
	u_e(rn,:)=u_n(rn,:);
	u_e(rs,:)=u_s(rs,:);
	v_e=nan*v_n;
	v_e(rn,:)=v_n(rn,:);
	v_e(rs,:)=v_s(rs,:);
	bp26_crle=(sqrt(2)*pi*bp26_crlstr)./(De.*rho.*abs(ff));
	
	eval(['save -append ',[qsave_path qsave_head num2str(jdays(m))],' bp26_crle u_e v_e'])
end

%{
theta=cart2pol(u_week,v_week);
[u_n,v_n]=pol2cart(theta-(pi/4),strm_week./denom);
[u_s,v_s]=pol2cart(theta+(pi/4),strm_week./denom);
%}