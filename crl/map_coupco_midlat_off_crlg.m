%
%loads SeaWiFS CHL data
clear all
close all


jdays=[2452459:7:2454489];%[2451556:7:2454797];
lj=length(jdays);
%lj=58

asave_path='/matlab/data/eddy/V4/mat/';
asave_head='AVISO_25_W_';
osave_head   = 'RAND_W_';
osave_path   = '/matlab/data/rand/';

[year,month,day]=jd2jdate(jdays(1:lj));
%
load([asave_path asave_head num2str(jdays(1))],'lon','lat')

CRLG=single(nan(640,1440,lj));
OFF=CRLG;


for m=1:lj
	fprintf('\r    loading %03u of %03u\r',m,lj)
	load([osave_path osave_head num2str(jdays(m))],'off_crlg')
	load([asave_path asave_head num2str(jdays(m))],'hp66_crlg','ls_mask')
	mask=ls_mask;
	OFF(:,:,m)=single(off_crlg.*mask);
	CRLG(:,:,m)=single(hp66_crlg.*mask);
	clear bp26* hp66* *mask* off*
end

save -v7.3 all_ls_off_crls OFF CRLG year month day jdays lat lon
return
