clear all
load /home/bettong/data2/data/argo/eddy_profiles plat plon pjday pT pP pS
load /Volumes/matlab/matlab/woa/iwoa05 iT iS lat lon

z_prime=[0:10:1500]';
aT=nan(length(pP(:,1)),length(z_prime));
aS=aT;
ipS=aT;
ipT=aT;
sT=aT;
sS=aT;
wT=aT;
wS=aT;

[year,month]=jd2jdate(pjday);

for m=1:12
	m
	fl=find(month==m);
	for p=1:length(fl)
		tx=plon(fl(p));
		ty=plat(fl(p));
		tmpxs=floor(tx)-1.5:ceil(tx)+1.5;
		tmpys=floor(ty)-1.5:ceil(ty)+1.5;
    	disx = abs(tmpxs-tx);
    	disy = abs(tmpys-ty);
    	iminx=find(disx==min(disx));
   		iminy=find(disy==min(disy));
    	cx=tmpxs(iminx(1));
    	cy=tmpys(iminy(1));
    	r=find(lat>=cy-.09 & lat<=cy+.09);
    	c=find(lon>=cx-.09 & lon<=cx+.09);
    	iigood=find((pP(fl(p),:))>0);
    	difp=pP(fl(p),iigood(1:length(iigood)-1))-pP(fl(p),iigood(2:length(iigood)));
    	igood=find(difp~=0);
    	%if ~isnan(pT(fl(p),iigood(igood))) & ~isnan(pS(fl(p),iigood(igood))) & length(pT(fl(p),iigood(igood)))>=5
    	rr=find(isnan(pP(fl(p),iigood(igood))));
    	if any(rr)
    		tmpppp=pP(fl(p),iigood(igood));
    		tmpppp(rr)=tmpppp(rr-1)+(tmpppp(rr+1)-tmpppp(rr-1))/2;
    		tmp_P=tmpppp;
		else
		tmp_P=pP(fl(p),iigood(igood));
		end
    	
    	if length(find(~isnan(pT(fl(p),iigood(igood)))))>=10
    		ipT(fl(p),:)=interp1(tmp_P,pT(fl(p),iigood(igood)),z_prime,'spline');
    		cut=find(z_prime<min(tmp_P));
    		ipT(fl(p),cut)=nan;
    	end
    	if length(find(~isnan(pS(fl(p),iigood(igood)))))>=10
    		ipS(fl(p),:)=interp1(tmp_P,pS(fl(p),iigood(igood)),z_prime,'spline');
    		cut=find(z_prime<min(tmp_P));
    		ipS(fl(p),cut)=nan;
    	end
    
    	%end
    	aS(fl(p),:)=ipS(fl(p),:)-iS(m,:,r,c);
    	aT(fl(p),:)=ipT(fl(p),:)-iT(m,:,r,c);
    	wS(fl(p),:)=iS(m,:,r,c);
    	wT(fl(p),:)=iT(m,:,r,c);
    	
    	
	end
end	

for m=1:length(aT(:,1))
	sT(m,:)=smooth1d_loess(aT(m,:),z_prime',100,z_prime');
	sS(m,:)=smooth1d_loess(aS(m,:),z_prime',100,z_prime');
end	

save anom_profiles a* p* s* i* w* z_prime
