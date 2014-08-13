
OUT_HEAD   = 'RAND_W_';
OUT_PATH   = '/matlab/data/rand/';
SSH_HEAD   = 'AVISO_25_W_';
SSH_PATH   = '/matlab/data/eddy/V5/mat/';
Q_HEAD   = 'QSCAT_30_25km_';
Q_PATH   = '/matlab/data/QuickScat/mat/';



jdays=2448910:7:2455581
load /matlab/matlab/domains/air-sea_eio_lat_lon
llat=lat;
llon=lon;
load /matlab/data/eddy/V5/mat/AVISO_25_W_2454776.mat lat lon ssh

[r,c]=imap(min(llat),max(llat),min(llon),max(llon),lat,lon);

land=nan*ssh;
i=find(~isnan(ssh));
land(i)=1;
save_w=nan(length(jdays),2);
for m=866:length(jdays)
	m
	out_file = [OUT_PATH OUT_HEAD num2str(jdays(m))];
	ssh_file = [SSH_PATH SSH_HEAD num2str(jdays(m))];
	q_file   = [Q_PATH Q_HEAD  num2str(jdays(m))];
	
	load(ssh_file,'hp66_crlg')
	load(out_file,'nR')
	%load(q_file,'bp26_crl_sst')
	g=hp66_crlg;
	%t=cat(1,nan(40,1440),bp26_crl_sst,nan(40,1440));
	a=-2.4;
   	b=2.4;
   	w= round(sum(a + (b-a).*rand(3,2)));
	y=nan*g;
	sd=pstd(g);
	if w(1)>0 & w(2)>0
		y(w(1):end,w(2):end)=g(1:end-w(1)+1,1:end-w(2)+1);
	elseif w(1)>0 & w(2)<0	
		y(w(1):end,1:end+w(2))=g(1:end-w(1)+1,-w(2)+1:end);
	elseif w(1)<0 & w(2)<0
		y(1:end+w(1),1:end+w(2))=g(-w(1)+1:end,-w(2)+1:end);
	elseif w(1)<0 & w(2)>0
		y(1:end+w(1),w(2):end)=g(-w(1)+1:end,1:end-w(2)+1);
	elseif w(1)==0 & w(2)>0
		y(1:end,w(2):end)=g(1:end,1:end-w(2)+1);
	elseif w(1)==0 & w(2)<0
		y(1:end,1:end+w(2))=g(1:end,-w(2)+1:end);	
	elseif w(1)<0 & w(2)==0
		y(1:end+w(1),1:end)=g(-w(1)+1:end,1:end);
	elseif w(1)>0 & w(2)==0
		y(w(1):end,1:end)=g(1:end-w(1)+1,1:end);	
	else
		y=g;
	end	
	
	y=y+(.1*sd*nR);
	off_crlg=y;
	
	%{
	figure(1)
	clf
	subplot(121)
	pcolor(lon(r,c),lat(r,c),double(off_crlg(r,c)));shading flat
	title('offset-crlg')
	ran=caxis;
	axis image
	subplot(122)
	pcolor(lon(r,c),lat(r,c),double(g(r,c)));shading flat
	title('crlg')
	caxis(ran)
	axis image
	drawnow
	%}
	eval(['save -append ' out_file ' off_crlg'])
		clear hp66_crlg g off_crlg y 

end