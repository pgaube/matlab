clear all
load ~/matlab/pop/mat/run14_1830 *chl* lat lon
figure(1)
clf
load tmp_filter
subplot(221)
pmap(lon,lat,hp66_chl)
caxis([-.1 .1])

for m=1:length(lat(:,1))
    for n=1:length(lon(1,:))
        [r,c]=imap(lat(m,n)-2,lat(m,n)+2,lon(m,n)-2,lon(m,n)+2,lat,lon);
        lp(m,n)=pmean(total_chl(r,c));
    end
end

% lp2=smooth2d_loess(total_chl,lon(1,:),lat(:,1),6,6,lon(1,:),lat(:,1));

subplot(222)
pmap(lon,lat,total_chl-lp)
caxis([-.1 .1])

subplot(224)
pmap(lon,lat,lp)
caxis([0 1])

subplot(223)
pmap(lon,lat,lp2)
caxis([0 1])

figure(2)
pmap(lon,lat,lp2-lp)
caxis([-.1 .1])
colorbar

figure(3)
pmap(lon,lat,hp66_chl-(total_chl-lp))
caxis([-.1 .1])
colorbar