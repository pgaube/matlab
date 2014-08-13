clear all
% select time period
vv=[1740:2139]; %this is the whole encilada

[i,tm]=size(vv); % tm = number of time levels
load mat/run14_1740 lat lon
% read data
tic
n=0;
[diat_c,diaz_c,small_c]=deal(zeros(length(lat(:,1)),length(lon(1,:))));
[diat_n,diaz_n,small_n]=deal(ones(length(lat(:,1)),length(lon(1,:))));
for nn=vv; % time
    n=n+1;
    flid=num2str(nn)
    if exist(['mat/run14_',num2str(nn),'.mat'])
        load(['mat/run14_',num2str(nn)],'pp_diat','pp_diaz','pp_small')
        diat_c=((diat_c.*diat_n)+pp_diat)./(diat_n+1);
        diaz_c=((diaz_c.*diaz_n)+pp_diaz)./(diaz_n+1);
        small_c=((small_c.*small_n)+pp_small)./(small_n+1);
        clear *biomass
        diat_n=diat_n+1;
        diaz_n=diaz_n+1;
        small_n=small_n+1;        
    end
end

mean_diaz_pp=diaz_c;
mean_diat_pp=diat_c;
mean_small_pp=small_c;
mean_pp=mean_diaz_pp+mean_diat_pp+mean_small_pp;

save ~/matlab/pop/mat/mean_diaz_pp mean_diaz_pp
save ~/matlab/pop/mat/mean_diat_pp mean_diat_pp
save ~/matlab/pop/mat/mean_small_pp mean_small_pp


save pop_pp_means *_pp lat lon

load pop_pp_means
figure(1)
clf
pmap(lon,lat,log10(diat_c))
print -dpng -r300 figs/mean_diat_pp

figure(1)
clf
pmap(lon,lat,log10(diaz_c))
print -dpng -r300 figs/mean_diaz_pp

figure(1)
clf
pmap(lon,lat,log10(small_c))
print -dpng -r300 figs/mean_small_pp

figure(1)
clf
pmap(lon,lat,log10(diat_c+diaz_c+small_c))
print -dpng -r300 figs/mean_pp


