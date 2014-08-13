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
    if exist(['mat/run33_',num2str(nn),'.mat'])
        load(['mat/run33_',num2str(nn)],'mdt')
        if exist('mdt')
            diat_c=((diat_c.*diat_n)+mdt)./(diat_n+1);
            diat_n=diat_n+1;
            clear mdt
        end
    end
end

mean_mdt=diat_c;

save ~/matlab/pop/mat/mean_mdt_run33 mean_mdt lon lat
