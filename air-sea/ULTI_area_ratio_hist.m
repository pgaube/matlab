clear all

load sst_wek_maps_from_mean_coupco_dtdn_only
mask=ones(size(median_hp_ratio));
mask(find(isnan(median_hp_ratio)))=nan;



load sst_wek_maps_from_mean_coupco_dtdn_only lat lon mean_* median_*

mask(abs(lat)<10)=nan;
ff=f_cor(lat);

mean_wek_sst=(.013/.008)*mean_wek_sst;
tt=(mean_wek_sst./mean_wek_crlg).*mask;
sm_tt=smoothn(tt,20).*mask;


omask=ones(size(mean_wek_sst));
omask(isnan(mean_wek_sst))=nan;

dy=111.11*linspace(.25,.25,length(lat(1,:)));
dx=111.11*linspace(.25,.25,length(lat(:,1)))'.*cosd(lat(:,1));
area=dx*dy.*mask;
ocean_area=area.*omask;

[tmp_rat,tmp_rat2]=deal(nan(size(tt)));

inum=find(tt>=1);
tmp_rat(inum)=1;
anum=ocean_area(inum);
ratio_over_1=nansum(anum(:))./nansum(ocean_area(:))

inum=find(tt<1);
tmp_rat2(inum)=-1;

inum=find(sm_tt>=1);
anum=ocean_area(inum);
ratio_over_1_sm=nansum(anum(:))./nansum(ocean_area(:))


tbins=0:.1:2;

for m=1:length(tbins)-1
    ii=find(tt>=tbins(m) & tt<tbins(m+1));
    sum_area_rat(m)=nansum(ocean_area(ii));
end

b=cumsum(100*(sum_area_rat./nansum(ocean_area(:))));



figure(2)
clf
set(gcf,'PaperPosition',[1 1 5 6])

subplot(311)
pcolor(lon,lat,ocean_area);shading flat;axis image
title('Area of 1/4 deg. grid (km^2)')
colorbar

subplot(312)
pcolor(lon,lat,tmp_rat);shading flat;axis image
hold on
contour(lon,lat,sm_tt,[1 1],'color','k','linewidth',.5)
title('Grid locations with |W_{SST}|/|W_{cur}| >= 1')
caxis([-1 1])
colorbar

subplot(313)
pcolor(lon,lat,tmp_rat2);shading flat;axis image
hold on
contour(lon,lat,sm_tt,[1 1],'color','k','linewidth',.5)
title('Grid locations with |W_{SST}|/|W_{cur}| < 1')
caxis([-1 1])
colorbar
print -dpng -r300 figs/test_ratio_calculation
return




figure(1)
clf
stairs(tbins(1:end-1),b);



figure(20)
clf
set(gcf,'PaperPosition',[1 1 8.5 3])
stairs(tbins(1:end-1),b,'k','linewidth',2);
% title('CPDF of W_{SST}/W_{cur}')
ylabel(['% of ocean',char(39),'s surface area'],'fontsize',18)
xlabel('W_{SST}/W_{cur}','fontsize',18)
set(gca,'ytick',[0:10:100])
grid
print -dpng -r300 figs/cpdf_w_sst_to_w_cur



