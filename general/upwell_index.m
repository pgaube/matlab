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


mean_dif=single(nan(length(lat(:,1)),length(lon(1,:))));
subset_dif=single(nan(length(rs),length(cs),length(mid_week_jdays)));
dif = nan(720,1440);
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
        dif(:,10:1440) = sst_oi(:,10:1440)-sst_oi(:,1:1440-9);
        subset_dif(rs,cs,m)=dif(r,c);
    end
    nump=length(rs)*length(cs);
    plac=1;
    mean_dif(r,c)=nanmean(subset_dif,3);
           
    fprintf('\n')
	subset_dif=single(nan(length(rs),length(cs),length(mid_week_jdays)));
	
end
