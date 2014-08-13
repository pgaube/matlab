
OUT_HEAD   = 'RAND_W_';
OUT_PATH   = '/matlab/data/rand/';
SSH_HEAD   = 'AVISO_25_W_';
SSH_PATH   = '/matlab/data/eddy/V4/mat/';

a=-1;
b=1;

%Set range of dates
START_YR = 2002;
START_MO = 07;
START_DY = 03;
END_YR= 2008;
END_MO = 01;
END_DY = 23;


%construct date variables
START_JD=date2jd(START_YR,START_MO,START_DY)+.5;
END_JD=date2jd(END_YR,END_MO,END_DY)+.5;
jdays = START_JD:7:END_JD;

load /matlab/data/eddy/V4/mat/AVISO_25_W_2454776.mat lat lon ssh

[r,c]=imap(10,30,260,290,lat,lon);

land=nan*ssh;
i=find(~isnan(ssh));
land(i)=1;


for m=1:length(jdays)
	out_file = [OUT_PATH OUT_HEAD num2str(jdays(m))];
	ssh_file = [SSH_PATH SSH_HEAD num2str(jdays(m))];
	
	
	load(out_file,'nR')
	load(ssh_file,'hp66_crlg')
	
	sd=pstd(hp66_crlg);
	y=hp66_crlg+(.3*sd*nR);
	na2_crlg=linx_smooth2d_f(y,2,2);
	return
	
	%{
	figure(1)
	clf
	subplot(121)
	pcolor(lon(r,c),lat(r,c),double(na_crlg(r,c)));shading flat
	title('na-crlg')
	ran=caxis;
	axis image
	subplot(122)
	pcolor(lon(r,c),lat(r,c),double(bp26_crlg(r,c)));shading flat
	title('crlg')
	caxis(ran)
	axis image
	drawnow
	%}
	clear hp66_crlg
	eval(['save -append ' out_file ' na2_crlg'])

end