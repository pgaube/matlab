
cd /matlab/matlab/regions
set_regions
cd /matlab/matlab/masks

for m=15
	mask=double(imread([curs{m},'_mask.png']));
	mask(mask==128)=nan;
	mask(mask==123)=nan;
	mask(~isnan(mask))=1;
	save(['/matlab/matlab/masks/mask_cor_',curs{m}])
end	
cd /matlab/matlab/regions