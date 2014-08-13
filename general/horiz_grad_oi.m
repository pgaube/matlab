clear all
global M
global N

N=2
M=2


load_path = '/Volumes/matlab/data/ReynoldsSST/mat/'
load([load_path,'OI_25_W_2454447.mat']);

split_domain
rs=1:length(r1);
cs=1:length(c1);


mean_horiz_gradt=single(nan(length(lat(:,1)),length(lon(1,:))));
mean_vert_gradt=single(nan(length(lat(:,1)),length(lon(1,:))));
mean_gradt=single(nan(length(lat(:,1)),length(lon(1,:))));
subset_gradt=single(nan(length(rs),length(cs),length(mid_week_jdays)));
subset_horiz_gradt=single(nan(length(rs),length(cs),length(mid_week_jdays)));
subset_vert_gradt=single(nan(length(rs),length(cs),length(mid_week_jdays)));
whos


for pp=1:M*N
    fprintf('\r|  Quadrant # %01u of %01u | \r',pp,M*N)
    fprintf('\n')
    
    eval(['r=r' num2str(pp) ';']);
    eval(['c=c' num2str(pp) ';']);
    for m=1:length(mid_week_jdays)
        fname = [load_path 'OI_25_W_' num2str(mid_week_jdays(m)) '.mat'];
        fprintf('\r     io file %03u of %03u \r',m,length(mid_week_jdays))
        load(fname,'sst_oi');
        %subset_gradt(rs,cs,m)=sqrt((dfdx(lon(r,c),lat(r,c),sst_oi(r,c)).^2)+(dfdy(sst_oi(r,c)).^2)).*1e5;
        %subset_horiz_gradt(rs,cs,m)=sqrt((dfdx(lon(r,c),lat(r,c),sst_oi(r,c)).^2)).*1e5;
        subset_vert_gradt(rs,cs,m)=sqrt((dfdy(sst_oi(r,c)).^2)).*1e5;
    end
    nump=length(rs)*length(cs);
    plac=1;
    %mean_gradt(r,c)=nanmean(subset_gradt,3);
    %mean_horiz_gradt(r,c)=nanmean(subset_horiz_gradt,3);
    mean_vert_gradt(r,c)=nanmean(subset_vert_gradt,3);
       
    fprintf('\n')
	subset_gradt=single(nan(length(rs),length(cs),length(mid_week_jdays)));
	subset_horiz_gradt=single(nan(length(rs),length(cs),length(mid_week_jdays)));
	subset_vert_gradt=subset_gradt;

end
