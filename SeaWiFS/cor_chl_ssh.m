%loads SeaWiFS CHL data
clear all
close all

lags=-8:8;

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
jdays=[startjd:7:endjd];
lj=length(jdays);


save_path='/Volumes/matlab/data/SeaWiFS/mat/';
save_head='SCHL_9_21_';
asave_path='/Volumes/matlab/data/eddy/V4/mat/';
asave_head='AVISO_25_W_';


load([save_path save_head num2str(jdays(1))],'glon','glat')
load([asave_path asave_head num2str(jdays(1))],'lon','lat')

[r,c]=imap(min(lat(:)),max(lat(:)),1,1,glat,glon);

CHL=nan(640,1440,lj);
SSH=CHL;
r0=nan(640,1440,length(lags));
N=r0;
Sig=r0;

for m=1:lj
	fprintf('\r    loading %03u of %03u\r',m,lj)
	load([save_path save_head num2str(jdays(m))],'bp26_chl')
	load([asave_path asave_head num2str(jdays(m))],'ssh','mask')
	CHL(:,:,m)=flipud(bp26_chl(r,:)).*mask;
	SSH(:,:,m)=ssh.*mask;
end

%save -v7.3 tmp lat lon CHL SSH
%now do correlation


for m=1:640
	for n=1:1440
	[r0(m,n,:),dum,N(m,n,:),Sig(m,n,:)]=pcor(CHL(m,n,:),SSH(m,n,:),lags);
	end
end	



for n=1:1440
	for m=1:640 
	i=find(abs(r0(m,n,:))==max(abs(r0(m,n,:))));
		if any(i)
		r_max(m,n)=squeeze(r0(m,n,i(1)));
		i_max(m,n)=i(1);
		end
	end
end

save cor_out r0 N Sig lat lon r_max i_max
