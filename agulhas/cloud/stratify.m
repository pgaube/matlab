%stratify CTT by CTP

[M,N,P]=size(sst);
ihicloud=zeros(M,N,P);
ilocloud=zeros(M,N,P);
ctt_hi = nan(M,N,P);
ctt_lo = nan(M,N,P);
ctt_hi_hp = nan(M,N,P);
ctt_lo_hp = nan(M,N,P);
sst_hi = nan(M,N,P);
sst_lo = nan(M,N,P);
wnd_hi = nan(M,N,P);
wnd_lo = nan(M,N,P);
div_hi = nan(M,N,P);
div_lo = nan(M,N,P);


for m=1:M
	for n=1:N
		for p=1:P
		if ctp(m,n,p)<701.08 %~3km
			iheight(m,n,p) =  1;
		else if ctp(m,n,p)>794.95 %650, 794.95 ~2km
			iheight(m,n,p) = -1;
		end
		end
		end
	end	
end



ctt_hi(iheight==1) = ctt(iheight==1);
ctt_lo(iheight==-1) = ctt(iheight==-1);
ctt_hi_hp(iheight==1) = ctt_hp(iheight==1);
ctt_lo_hp(iheight==-1) = ctt_hp(iheight==-1);
sst_hi(iheight==1) = sst(iheight==1);
sst_lo(iheight==-1) = sst(iheight==-1);
wnd_hi(iheight==1) = wind_spd(iheight==1);
wnd_lo(iheight==-1) = wind_spd(iheight==-1);
div_hi(iheight==1) = tau_div(iheight==1);
div_lo(iheight==-1) = tau_div(iheight==-1);
Yctt_hi_hp=nanmean(ctt_hi,3)-smooth2d_loess(nanmean(ctt_hi,3),GRIDX,GRIDY,10,2,GRIDX,GRIDY);
Yctt_lo_hp=nanmean(ctt_lo,3)-smooth2d_loess(nanmean(ctt_lo,3),GRIDX,GRIDY,10,2,GRIDX,GRIDY);
Ysst_hi_hp=nanmean(sst_hi,3)-smooth2d_loess(nanmean(sst_hi,3),GRIDX,GRIDY,10,2,GRIDX,GRIDY);
Ysst_lo_hp=nanmean(sst_lo,3)-smooth2d_loess(nanmean(sst_lo,3),GRIDX,GRIDY,10,2,GRIDX,GRIDY);
Ywnd_hi_hp=nanmean(wnd_hi,3)-smooth2d_loess(nanmean(wnd_hi,3),GRIDX,GRIDY,10,2,GRIDX,GRIDY);
Ywnd_lo_hp=nanmean(wnd_lo,3)-smooth2d_loess(nanmean(wnd_lo,3),GRIDX,GRIDY,10,2,GRIDX,GRIDY);
Ydiv_hi_hp=nanmean(div_hi,3)-smooth2d_loess(nanmean(div_hi,3),GRIDX,GRIDY,10,2,GRIDX,GRIDY);
Ydiv_lo_hp=nanmean(div_lo,3)-smooth2d_loess(nanmean(div_lo,3),GRIDX,GRIDY,10,2,GRIDX,GRIDY);
