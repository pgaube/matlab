function [bar_est,num_est,std_est]=pbinned(data1,data2,bins);
%function [bar_est,num_est,std_est]=pbinned(data1,data2,bins);

for i=1:length(bins)-1
    bin_est = find(data1>=bins(i) & data1<bins(i+1));
    bar_est(i) = nanmean(data2(bin_est));
    std_est(i) = nanstd(data2(bin_est));
    num_est(i) = length(data2(bin_est));
end
    