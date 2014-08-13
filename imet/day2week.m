%temporaly block averages the IMET moring data into 7day weeks
%fentered on the same days as the TMI SST and merged SSH data.

temp=nan(93,312);
mld01_7d = nan(1,312);
mld05_7d = nan(1,312);
mld10_7d = nan(1,312);


for j = 1:length(jday_7d)
    i = find(jday_1d==jday_7d(j));
    if j == 1 
        temp(:,j) = mean(temp_1d(:,i:i+3),2);
        mld01_7d(j) = mean(mld01(i:i+3));
        mld05_7d(j) = mean(mld05(i:i+3));
        mld10_7d(j) = mean(mld10(i:i+3));
    elseif j == length(jday_7d)
        temp(:,j) = mean(temp_1d(:,i-3:i),2);
        mld01_7d(j) = mean(mld01(i-3:i));
        mld05_7d(j) = mean(mld05(i-3:i));
        mld10_7d(j) = mean(mld10(i-3:i));
    else
        temp(:,j) = mean(temp_1d(:,i-3:i+3),2);
        mld01_7d(j) = mean(mld01(i-3:i+3));
        mld05_7d(j) = mean(mld05(i-3:i+3));
        mld10_7d(j) = mean(mld10(i-3:i+3));
    end
end

clear i j 