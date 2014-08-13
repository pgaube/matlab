clear all

!toast for_mike/*
save_path='/Volumes/matlab/data/SeaWiFS/mat/';
save_head='SCHL_9_21_';
jdays=[2450821:7:2454832];
load([save_path 'SCHL_9_21_2450905'],'glat','glon')

for n=[166]
	load([save_path save_head num2str(jdays(n))],'gchl_week','nbp26_chl')
	glat=double(glat);
	glon=double(glon);
	gchl_week=double(gchl_week);
	nbp26_chl=double(nbp26_chl);
	gchl_week(isnan(gchl_week))=1e35;
	nbp26_chl(isnan(nbp26_chl))=1e35;
	
	tt=[min(glon(:)) max(glon(:)) min(glat(:)) max(glat(:))];
	eval(['save -ascii for_mike/chl_',num2str(jdays(n)),'.dat tt'])
	tt=[length(glon(1,:)) length(glon(:,1)) .25 .25];
	eval(['save -ascii -append for_mike/chl_',num2str(jdays(n)),'.dat tt'])
	tt=flipud(gchl_week)';
	eval(['save -ascii -append for_mike/chl_',num2str(jdays(n)),'.dat tt'])
	
	tt=[min(glon(:)) max(glon(:)) min(glat(:)) max(glat(:))];
	eval(['save -ascii for_mike/hp_chl_',num2str(jdays(n)),'.dat tt'])
	tt=[length(glon(1,:)) length(glon(:,1)) .25 .25];
	eval(['save -ascii -append for_mike/hp_chl_',num2str(jdays(n)),'.dat tt'])
	tt=flipud(nbp26_chl)';
	eval(['save -ascii -append for_mike/hp_chl_',num2str(jdays(n)),'.dat tt'])
end
