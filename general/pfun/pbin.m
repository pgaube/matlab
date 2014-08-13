function [bar_xi,num_xi,max_xi,min_xi,std_xi,bar_x,num_x,max_x,min_x,std_x]=pbin(x,xi,bins)

%Bin xi by bins of x.  bins must be in the units of x.  x and xi must be same size




bar_x=nan(size(bins));
num_x=nan(size(bins));
min_x=nan(size(bins));
max_x=nan(size(bins));
std_x=nan(size(bins));

bar_xi=nan(size(bins));
num_xi=nan(size(bins));
min_xi=nan(size(bins));
max_xi=nan(size(bins));
std_xi=nan(size(bins));


    for i=1:length(bins)-1
        
        bin_est = find(x>=bins(i) & x<bins(i+1));
        if any(x(bin_est)) & any(xi(bin_est))
        bar_x(i) = nanmean(x(bin_est));
    	num_x(i) = length(x(bin_est));
    	min_x(i) = min(x(bin_est));
    	max_x(i) = max(x(bin_est));
    	std_x(i) = pstd(x(bin_est));
    	bar_xi(i) = nanmean(xi(bin_est));
    	num_xi(i) = length(xi(bin_est));
    	min_xi(i) = min(xi(bin_est));
    	max_xi(i) = max(xi(bin_est));
    	std_xi(i) = pstd(xi(bin_est));
    	else
    	bar_x(i) = nan;
    	num_x(i) = nan;
    	min_x(i) = nan;
    	max_x(i) = nan;
    	std_x(i) = nan;
    	bar_xi(i) = nan;
    	num_xi(i) = nan;
    	min_xi(i) = nan;
    	max_xi(i) = nan;
    	std_xi(i) = nan;
    	end
   end 	
    


