%loads SeaWiFS CHL data
clear all
close all


jdays=[2448910:7:2454832];
lj=length(jdays);



asave_path='/matlab/data/eddy/V4/mat/';
asave_head='AVISO_25_W_';



load([asave_path asave_head num2str(jdays(1))],'lon','lat')

ff=f_cor(lat);
ff=(8640000./(1020.*ff));

for m=1:lj
	fprintf('\r    loading %03u of %03u\r',m,lj)
	load([asave_path asave_head num2str(jdays(m))],'bp26_crlg')
	gwek=-ff.*bp26_crlg;
	clear bp26_crlg
	save([asave_path asave_head num2str(jdays(m))],'gwek','-append')
end

