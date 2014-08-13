clear all
[glon,glat]=meshgrid([0:360],[-80:80]);
[mean_anom_a,mean_anom_c,num_anom_a,num_anom_c,std_anom_a,std_anom_c]=deal(nan(size(glat)));

anom_path='/Volumes/matlab/matlab/global/old_trans_9km/TRANS_W_4km_';
load /Volumes/matlab/data/eddy/V4/global_tracks_v4
startjd=2450821;
endjd=2454489;

% subset eddies to dates where we have samples of all our shit
f1=find(track_jday>=startjd & track_jday<=endjd);

id=id(f1);
eid=eid(f1);
x=x(f1);
y=y(f1);
amp=amp(f1);
axial_speed=axial_speed(f1);
efold=efold(f1);
radius=radius(f1);
track_jday=track_jday(f1);
prop_speed=prop_speed(f1);
k=k(f1);
b=1;
jdays=[min(track_jday):7:max(track_jday)];

for n=1:length(glon(1,:))
	for m=1:length(glat(:,1))
	
	ied=find(x>= glon(m,n)-.5 & x<= glon(m,n)+.5 & ...
			 y>= glat(m,n)-.5 & y<= glat(m,n)+.5);
	uload_jdays=unique(track_jday(ied));		 
	
	aied=find(id(ied)>=nneg);
	cied=find(id(ied)<nneg);
	
	tmp_anom_a=single(nan(73,73,length(aied)));
	tmp_anom_c=single(nan(73,73,length(cied)));
	[sta,stc]=deal(1);
	
	for p=1:length(uload_jdays)
		load([anom_path, num2str(uload_jdays(p))],'anom_sample','id_index')
		ted = sames(id(ied),id_index);
		for q=1:length(ted)
			if id_index(ted(q))>=nneg
				tmp_anom_a(:,:,sta)=anom_sample(:,:,ted(q));
				sta=sta+1;
			else
				tmp_anom_c(:,:,stc)=anom_sample(:,:,ted(q));
				stc=stc+1;
			end
		end
	end	
	mean_anom_a(m,n) = pmean(tmp_anom_a(:));
	mean_anom_c(m,n) = pmean(tmp_anom_c(:));
	num_anom_a(m,n) = length(aied);
	num_anom_c(m,n) = length(cied);
	std_anom_a(m,n) = pstd(tmp_anom_a(:));
	std_anom_c(m,n) = pstd(tmp_anom_c(:));	
	end
end

			
		
	
