
jdays=[2451556:7:2454797];
for m=142:length(jdays)
	m
	load(['/matlab/data/QuickScat/mat/QSCAT_30_25km_',num2str(jdays(m))],'hp66_crl')
	hp66_crl(1e5*abs(hp66_crl)>=5)=nan;
	eval(['save -append /matlab/data/QuickScat/mat/QSCAT_30_25km_',num2str(jdays(m)),' hp66_crl'])
end
