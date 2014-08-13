%loads SeaWiFS CHL data
clear all
close all


%Set range of dates
startyear = 1998;
startmonth = 01;
startday = 07;
endyear= 2008;
endmonth = 12;
endday = 31;

%construct date vector
startjd=date2jd(startyear,startmonth,startday)+.5;
endjd=date2jd(endyear,endmonth,endday)+.5;
%jdays=[startjd:7:endjd];
jdays=[2451395:7:2454811];
lj=length(jdays);


save_path='/Volumes/matlab/data/SeaWiFS/mat/';
save_head='SCHL_9_21_';
%asave_path='/Volumes/matlab/data/eddy/V4/mat/';
%asave_head='AVISO_25_W_';
asave_path='/Volumes/matlab/data/QuickScat/new_mat/';
asave_head='QSCAT_21_25km_';

load([save_path save_head num2str(jdays(1))],'glon','glat')
load([asave_path asave_head num2str(jdays(1))],'lon','lat')

[r,c]=imap(min(lat(:)),max(lat(:)),1,1,glat,glon);

%CHL=nan(640,1440,lj);
CHL=nan(560,1440,lj);
SSH=CHL;
r0=SSH(:,:,1:9);
N=r0;
Sig=r0;

for m=1:lj
	fprintf('\r    loading %03u of %03u\r',m,lj)
	load([save_path save_head num2str(jdays(m))],'bp21_chl')
	load([asave_path asave_head num2str(jdays(m))],'w_ek')
	CHL(:,:,m)=flipud(bp21_chl(r,:));
	SSH(:,:,m)=w_ek;
end

%save -v7.3 tmp lat lon CHL SSH
%now do correlation


%for m=1:640
for m=1:560
	for n=1:1440
	[r0(m,n,:),dum,N(m,n,:),Sig(m,n,:)]=pcor(SSH(m,n,:),CHL(m,n,:),[-4:4]);
	end
end	

save cor_out_wek r0 N Sig lat lon
return

