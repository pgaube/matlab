jdays=[2448910:7:2454832];
lj=length(jdays);

asave_path='/matlab/data/eddy/V4/mat/';
asave_head='AVISO_25_W_';
qsave_path='/matlab/data/QuickScat/mat/';
qsave_head='QSCAT_30_25km_';
osave_path='/matlab/data/ReynoldsSST/mat/';
osave_head='OI_25_30_';
OUT_HEAD   = 'SSTWIND_25_W_';
OUT_PATH   = '/matlab/data/SSTWIND/mat/';

load([asave_path asave_head num2str(jdays(300))],'lon','lat')
slat=lat;
slon=lon;


[rs,cs]=imap(min(lat(:)),max(lat(:)),1,1,slat,slon);

[r,c]=imap(-60,60,0,360,slat,slon);

load([asave_path asave_head num2str(jdays(5))],'ssh')

land=nan*ssh(r,c);
land(~isnan(ssh(r,c)))=1;

nland=length(find(~isnan(land)));
nocean=length(find(isnan(land)));
neddy=nan(length(slat(r,1)),lj);

dx=111.11*.25;
dy=111.11*.25*cosd(slat(r,c));
area=dx*dy;


area_ocean=area.*land;

figure(1)
clf
pcolor(slon(r,c),slat(r,c),double(area_ocean));shading flat;


for m=203%1:lj
	fprintf('\r    loading %03u of %03u\r',m,lj)
	load([asave_path asave_head num2str(jdays(m))],'a_mask','c_mask')
	tt=cat(3,a_mask(r,c),c_mask(r,c));
	tt=nanmean(tt,3);
	mask=nan*tt;
	mask(~isnan(tt))=1;
	eddy_field=area_ocean.*mask;
	neddy(m)=nansum(eddy_field(:))./nansum(area_ocean(:));
	percent=100*neddy(m)
	%{
	figure(1)
	clf
	pcolor(slon,slat,double(eddy_field));shading flat;
	drawnow
	%}
end


percent_eddy_average=pmean(neddy).*100