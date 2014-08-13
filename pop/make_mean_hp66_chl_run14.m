clear all
% select time period
vv=[1740:2139]; %this is the whole encilada

[i,tm]=size(vv); % tm = number of time levels
load mat/run14_1740 lat lon
% read data
tic
n=0;
[diat_c]=deal(zeros(length(lat(:,1)),length(lon(1,:))));
[diat_n]=deal(ones(length(lat(:,1)),length(lon(1,:))));
for nn=vv; % time
    n=n+1;
    flid=num2str(nn)
    %first run14
    if exist(['mat/run14_',num2str(nn),'.mat'])
        load(['mat/run14_',num2str(nn)],'hp66_chl')
        if exist('hp66_chl')
            diat_c=((diat_c.*diat_n)+abs(hp66_chl))./(diat_n+1);
            diat_n=diat_n+1;
            clear hp66_chl
        end
    end
end

mean_hp66_chl=diat_c;

save -append ~/matlab/pop/mat/mean_chl mean_hp66_chl
