
jdays=[2451395:7:2454461];
for m=1:length(jdays)
	load(['/matlab/matlab/global/trans_samp/TRANS_W_NOR_',num2str(jdays(m))],'nrraw_bp26_chl_sample')
	nrraw_bp26_chl_sample(abs(nrraw_bp26_chl_sample)>=2)=nan;
	eval(['save -append /matlab/matlab/global/trans_samp/TRANS_W_NOR_',num2str(jdays(m)),' nrraw_bp26_chl_sample'])
end
