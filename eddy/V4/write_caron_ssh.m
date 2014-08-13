jdays=2448910:7:2454832;

for m=1:length(jdays)
	load(['/matlab/data/eddy/V4/mat/AVISO_25_W_',num2str(jdays(m))],'ssh','lat','lon','u','v')
	save(['/Volumes/MacintoshHD/petes_ssh_data/ssh_',num2str(jdays(m))],'ssh','lat','lon','u','v')
end
