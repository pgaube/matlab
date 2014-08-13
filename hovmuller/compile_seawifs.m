%Stack seawifs and average

startjd=2450703;
endjd=2454352;


startjd_50=2450753;
endjd_50=2454353;

jdays_50=startjd_50:50:endjd_50;
njdays_50=length(jdays_50)
jdays_50(njdays_50)=jdays_50(njdays_50)-1; %fix last day

jdays=startjd:jdays_50(njdays_50);
njdays=length(jdays);

p=1;

chl_strip=nan(3650,4320);

load /Volumes/matlab/data/SeaWiFS/mat/strip/chl_strip_S2450753_50D.mat lat
i=find(lat(:,1)>-31&lat(:,1)<-29);
for m=1:njdays_50
	m
	fname = ['/Volumes/matlab/data/SeaWiFS/mat/strip/chl_strip_S' num2str(jdays_50(m)) '_50D.mat'];
	load(fname,'chl_50d')
	r=1;
	for e=p:p+49
		chl_strip(e,:)=squeeze(nanmean(chl_50d(i,:,r),1))';
		r=r+1;
                p=p+1;
	end
	clear chl_50d
end		
	
	
	
	
	
