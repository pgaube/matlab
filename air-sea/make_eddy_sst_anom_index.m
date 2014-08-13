clear
%{
jdays=[2451395:7:2454461];
xi=[-5:.125:5];
[xx,yy]=meshgrid(xi,xi);
dist=sqrt(xx.^2+yy.^2);
ii=find(dist<=1);
mask=nan*xx;
mask(ii)=1;

load /matlab/data/eddy/V4/global_tracks_V4_12_weeks.mat

[sst_amp,sst_y,sst_id,sst_mag]=deal(nan*amp);
lay=1;
for m=1:length(jdays)
	fprintf('\r  Sampling -- file %3u of %3u \r',m,length(jdays))
	load(['/Volumes/wombat/data1/pgaube/trans_samp/TRANS_W_NOR_',num2str(jdays(m))],'amp_index','y_index','id_index','nrbp26_sst_sample');
	for n=1:length(amp_index)
		sst_amp(lay)=amp_index(n);
		y_amp(lay)=y_index(n);
		sst_id(lay)=id_index(n);
		ttt=abs(nrbp26_sst_sample(:,:,n).*mask);
		if id_index(n)>=nneg
			sst_mag(lay)=max(ttt(:));
			sst_amp(lay)=amp_index(n);
		else
			sst_mag(lay)=-max(ttt(:));
			sst_amp(lay)=-amp_index(n);
		end	
		lay=lay+1;
	end
end	

save eddy_sst_anom_index
%}
load eddy_sst_anom_index
pscatter(sst_amp/10,sst_mag,1,1,-2:.25:2,.5,-2,2,-2,2,'amp/10','sst')