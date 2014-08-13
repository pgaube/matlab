%fill in all bad data and then re create the landmask

[m,n,p]=size(tSST);

int_sCHL = nan*ones(m,n,p);
int_tSST = nan*ones(m,n,p);

i = find(mask==0);
mask(i)=nan;

for k = 1:p
	int_sCHL(:,:,k) = interp2nan(sCHL(:,:,k),1,1); 
	int_tSST(:,:,k) = interp2nan(tSST(:,:,k),1,1); 
	int_sCHL(:,:,k)=int_sCHL(:,:,k).*mask;
	int_tSST(:,:,k)=int_tSST(:,:,k).*mask;
end



clear m n p k i 




	