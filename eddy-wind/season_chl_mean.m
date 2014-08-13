
interp_jdays=[2450884:7:2454500];


load_path = '/matlab/data/gsm/mat/'
load([load_path,'GSM_9_21_2450821'],'glon','glat')

data=single(nan(length(glat(:,1)),length(glat(1,:)),length(interp_jdays)));
months=nan(length(interp_jdays),1);

for m=1:length(interp_jdays)
    fname = [load_path 'GSM_9_21_' num2str(interp_jdays(m)) '.mat'];
    fprintf('\r     loading and calc grad of file %03u of %03u \r',m,length(interp_jdays))
	eval(['load ' fname ' gchl_week'])
	data(:,:,m)=gchl_week;
	[y,mm,dd]=jd2jdate(interp_jdays(m));
	months(m)=mm;
end

ii=find(months>=5&months<=10);
mean_winter=nanmean(data(:,:,ii),3);
ii=find(months>=11 | months<=4);
mean_summer=nanmean(data(:,:,ii),3);
   	
save -append /matlab/data/gsm/mean_gchl mean_*   	
	