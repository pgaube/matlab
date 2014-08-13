TYPE='chl_ssh'

load bwr.pal
load chelle.pal
load bwy.pal
load rwp.pal

startjd=2450884%2450849
endjd=2454797%2454832
jdays=[startjd:7:endjd];

load /matlab/data/eddy/V4/mat/AVISO_25_W_2453530 lat lon ssh
slon=lon;
slat=lat;
load /matlab/data/gsm/mat/GSM_9_21_2452459 glat glon bp26_chl
[rchl,cchl]=imap(min(slat(:)),max(slat(:)),1,1,glat,glon);

%{
mask=ones(size(glat));
mask1=ones(size(slat));
mask1(isnan(ssh))=nan;
mask1=buffnan_rad(mask1,4);
mask(rchl,:)=flipud(mask1);
save mask mask
return
%}
load /matlab/data/gsm/mask

for m=1:length(jdays)
load(['/matlab/data/gsm/mat/GSM_9_21_',num2str(jdays(m))],'bp26_chl','sp66_chl','bp21_chl')
m

bp26_chl=buffnan_rad(bp26_chl,2).*mask;
bp21_chl=buffnan_rad(bp21_chl,2).*mask;
sp66_chl=buffnan_rad(sp66_chl,2).*mask;

%save(['/matlab/data/gsm/mat/GSM_9_21_',num2str(jdays(m))],'mask','-append')
save(['/matlab/data/gsm/mat/GSM_9_21_',num2str(jdays(m))],'mask','bp26_chl','hp66_chl','bp21_chl','-append')

end
