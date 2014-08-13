clear all
% select time period
vv=[1740:2139]; %this is the whole encilada

[i,tm]=size(vv); % tm = number of time levels
load mat/run33_1740 lat lon
% read data
tic
n=0;
[diat_c]=deal(zeros(length(lat(:,1)),length(lon(1,:))));
[diat_n]=deal(ones(length(lat(:,1)),length(lon(1,:))));
for nn=vv; % time
    n=n+1;
    flid=num2str(nn)
    %first run14
    if exist(['mat/run33_',num2str(nn),'.mat'])
        load(['mat/run33_',num2str(nn)],'total_chl')
        diat_c=((diat_c.*diat_n)+total_chl)./(diat_n+1);
        diat_n=diat_n+1;
        clear total_chl
    end
end

mean_chl=diat_c;

save ~/matlab/pop/mat/mean_chl_run33 mean_chl lat lon

figure(1)
clf
pmap(lon,lat,log10(mean_chl))

print -dpng -r300 figs/mean_chl_run33
