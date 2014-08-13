
OUT_HEAD   = 'RAND_W_';
OUT_PATH   = '/matlab/data/rand/';

a=-1;
b=1;

%Set range of dates
jdays=2448910:7:2455581

load /matlab/data/eddy/V4/mat/AVISO_25_W_2454776.mat lat lon ssh

land=nan*ssh;
i=find(~isnan(ssh));
land(i)=1;

%{
rlat=-80:.1:80;
rlon=0:.1:360;
ilat=-80:.01:80;
ilon=0:.01:360;
W = a + (b-a).*randn(length(rlat),length(rlon));
r=interp2(rlon,rlat',W,ilon,ilat','linear');
R=interp2(ilon,ilat',r,lon,lat,'linear');
return
%}
for m=1:length(jdays)
	m
	out_file = [OUT_PATH OUT_HEAD num2str(jdays(m))];
	
	%W = a + (b-a).*randn(length(rlat),length(rlon));
	W = a + (b-a).*randn(length(lat(:,1)),length(lon(1,:)));
	nW=(W-pmean(W))./pstd(W);
	R=linx_smooth2d_f(W,1,1);
	%W=W.*land;
	%R=interp2(rlon,rlat,W,lon,lat,'spline');
	nR = (R-pmean(R))./pstd(R);
	%{
	figure(1)
	clf
	pcolor(lon,lat,double(R));shading flat
	caxis([-1.2 1.2])
	drawnow
	%}
	
	eval(['save ' out_file ' lon lat nW nR'])

end