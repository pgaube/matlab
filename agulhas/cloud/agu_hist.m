%make hsitograms of daily CTT and CTP

t_bins=[150:5:350];
ctt_vec=ctt_day(:);


for i=1:length(t_bins)-1
    bin_ctt = find(ctt_vec>=t_bins(i) & ctt_vec<t_bins(i+1));
    bar_ctt(i) = nanmean(ctt_vec(bin_ctt));
    std_ctt(i) = nanstd(ctt_vec(bin_ctt));
    num_ctt(i) = length(ctt_vec(bin_ctt));
end
 
h = num_ctt./sum(num_ctt);
%pdf = h/.5;
pdf = h*100;

figure(1)
hax=subplot(211)
plot(pdf,'k')
set(hax,'xticklabel',{int2str(t_bins(1:5:41)')})
set(hax,'xtick',0:5:40)
set(hax,'xlim',[10 32])
title('Histogram of Pooled CTT Measurments')
ylabel('% of Obs in Each Bin')
xlabel('K')

p_bins=[1:20:1100];
ctp_vec=ctp_day(:);


for i=1:length(p_bins)-1
    bin_ctp = find(ctp_vec>=p_bins(i) & ctp_vec<p_bins(i+1));
    bar_ctp(i) = nanmean(ctp_vec(bin_ctp));
    std_ctp(i) = nanstd(ctp_vec(bin_ctp));
    num_ctp(i) = length(ctp_vec(bin_ctp));
end
 
h = num_ctp./sum(num_ctp);
%pdf = h/.5;
pdf = h*100;


hax=subplot(212)
plot(pdf,'k')
set(hax,'xticklabel',{int2str(p_bins(1:5:55)')})
set(hax,'xtick',0:5:54)
set(hax,'xlim',[5 54])
title('Histogram of Pooled CTP Measurments')
ylabel('% of Obs in Each Bin')
xlabel('hPa')