clear
load EK_time_chl_wek
zgrid_grid
ii=find(dist<=2);
mask_up=nan(81,81);
mask_up(ii)=1;
mask_dn=mask_up;

ac_sm_r_chl_wek=nan*ac_r_chl_wek;
ac_sm_N_r_chl_wek=nan*ac_N_r_chl_wek;


uid=unique(ac_id);

for m=1:length(uid)
	ii=find(ac_id==uid(m));
	chl=nan(81,81,length(ii));
	wek=chl;
	
	for n=1:length(ii)
		load(['/matlab/matlab/global/trans_samp/TRANS_W_NOR_',num2str(ac_jday(ii(n)))],...
		'id_index','k_index','nrw_ek_sample','nrraw_bp26_chl_sample')
		lev=find(id_index==uid(m));
		chl(:,:,n)=nrraw_bp26_chl_sample(:,:,lev).*mask_up;
		wek(:,:,n)=nrw_ek_sample(:,:,lev).*mask_up;
	end
	
	for n=1:length(ii)
		if length(ii)>1
		if n==1
			ttc=chl(:,:,1:2);
			ttw=wek(:,:,1:2);
		elseif n==length(ii)
			ttc=chl(:,:,n-1:n);
			ttw=wek(:,:,n-1:n);
		else
			ttc=chl(:,:,n-1:n+1);
			ttw=wek(:,:,n-1:n+1);
		end
		ittc=find(~isnan(ttc(:)));
		[ac_sm_r_chl_wek(ii(n)),Covar,ac_sm_N_r_chl_wek(ii(n))]=pcor(ttc(ittc),ttw(ittc));
		end
	end
end

save -append EK_time_chl_wek ac_sm_*
