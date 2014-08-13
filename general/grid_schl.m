

load_path = '/home/bettong/data2/data/seawifs/mat/'
load([load_path,'SCHL_4_W_2450822'])
glat=biggrid(lat,9,25);
glon=biggrid(lon,9,25);




%use to grid
%{
for m=1:length(mid_week_jdays)
    fname = [load_path 'SCHL_4_W_' num2str(mid_week_jdays(m)) '.mat'];
    fprintf('\r     io file %03u of %03u \r',m,length(mid_week_jdays))
    load(fname, 'chl_week')
    gchl_week=biggrid(chl_week,9,25);
	eval(['save -append ', fname, ' glat glon gchl_week'])
end


%use to make monthy comps

chl_tmp=nan(length(glat(:,1)),length(glon(1,:)),4);

for m=1:4:length(mid_week_jdays)
    
    fprintf('\r     io file %03u of %03u \r',m,length(mid_week_jdays))
    fname2 = [load_path 'SCHL_25_M_' num2str(mid_week_jdays(m)) '.mat'];
    for p=1:4
    	fname = [load_path 'SCHL_4_W_' num2str(mid_week_jdays(m+p-1)) '.mat'];
    	load(fname, 'gchl_week')
    	chl_tmp(:,:,p)=gchl_week;
    end	
    gchl_month=nanmean(chl_tmp,3);
	eval(['save ', fname2, ' glat glon gchl_month'])
	chl_tmp=nan*chl_tmp;
end
%}
%use to make annual comps

chl_tmp=nan(length(glat(:,1)),length(glon(1,:)),12);
anom_tmp=chl_tmp;

for m=1:52:length(mid_week_jdays)
    
    fprintf('\r     io file %03u of %03u \r',m,length(mid_week_jdays))
    fname3 = [load_path 'SCHL_25_Y_' num2str(mid_week_jdays(m)) '.mat'];
    for p=1:12
    	fname = [load_path 'SCHL_25_M_' num2str(mid_week_jdays(m+(p-1)*4)) '.mat'];
    	load(fname, 'gchl_month', 'chl_anom')
    	chl_tmp(:,:,p)=gchl_month;
    	anom_tmp(:,:,p)=chl_anom;
    end	
    gchl_year=nanmean(chl_tmp,3);
    ganom_year=nanmean(anom_tmp,3);
	eval(['save ', fname3, ' glat glon gchl_year ganom_year'])
	chl_tmp=nan*chl_tmp;
	anom_tmp=nan*anom_tmp;
end