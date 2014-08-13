function [bar_est,num_est]=phist(data,bins);
%function [bar_est,num_est]=phist(data,bins);

for i=1:length(bins)-1
    bin_est = find(data>=bins(i) & data<bins(i+1));
    bar_est(i) = nanmean(data(bin_est));
    std_est(i) = nanstd(data(bin_est));
    num_est(i) = length(data(bin_est));
end
    