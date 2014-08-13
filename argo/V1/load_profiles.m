clear all
load /data/argo/eddy_argo_prof_index

plat=nan*eddy_plat;
plon=plat;
pjday=plat;
pP=nan(length(plat),600);
pT=pP;
pS=pP;

missing_profile='tmp';
failed_prof='tmp';
q=1;
qp=1;



for m=1:length(eddy_pdate)
	fprintf('\r load prof %06u of %06u',m,length(eddy_pdate))
	tmp=num2str(eddy_pfile{m});
	jj=find(tmp=='/');
	fname=tmp(jj(3)+1:length(tmp));
	if exist(['/data/argo/profiles/', fname])
		[plat(m),plon(m),P,S,T]=read_profiles(fname);
		pP(m,1:length(P))=P;
		pT(m,1:length(T))=filter_sigma(3,T);
		pS(m,1:length(S))=filter_sigma(3,S);
		pjday(m)=eddy_pjday(m);
		%check that loc is as I think
		%plon(m)-eddy_plon(m)
	else
	fprintf('\n Missing m = %05u \n',m)
	missing_profile(q)=m;
	%fname
	q=q+1;
	end	

end	
	
misprof=eddy_pfile(missing_profile);

save missing_profiles misprof
save eddy_profiles p*
	


