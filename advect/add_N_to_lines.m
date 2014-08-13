clear
set_advect



for p=1:length(lat)
	load(['line_',num2str(p),'_hov'],'raw_chov')
	for m=1:length(raw_chov(1,:))
		nx(m)=length(find(isnan(raw_chov(:,m))));
	end
	for m=1:length(raw_chov(:,1))
		ny(m)=length(find(isnan(raw_chov(m,:))));
	end	
	eval(['save -append line_',num2str(p),'_hov nx ny'])
	clear nx ny
end
