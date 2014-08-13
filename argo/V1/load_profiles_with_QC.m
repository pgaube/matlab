clear all
load /home/bettong/data2/data/argo/eddy_argo_prof_index

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
	if exist(['/home/bettong/data2/data/argo/profiles/', fname])
		[plat(m),plon(m),P,S,T]=read_profiles(fname);
		%prefore QC
		if max(P)<1499 & min(P)<=0
		fprintf('\n Failed QC P MAX = %05u, MIN = %05u, m = %05u \n',max(P),min(P),m)
		failed_prof(qp)=m;
		qp=qp+1;
		continue
		if max(T)>50   & min(T)<=0
		fprintf('\n Failed QC T MAX = %05u, MIN = %05u, m = %05u \n',max(T),min(T),m)
		failed_prof(qp)=m;
		qp=qp+1;
		continue
		if max(S)>40   & min(S)<=20
		fprintf('\n Failed QC S MAX = %05u, MIN = %05u, m = %05u \n',max(S),min(S),m)
		failed_prof(qp)=m;
		qp=qp+1;
		continue
		else
		pP(m,1:length(P))=P;
		pT(m,1:length(T))=T;
		pS(m,1:length(S))=S;
		pjday(m)=eddy_pjday(m);		
		end
		end
		end
	else
	fprintf('\n Missing m = %05u \n',m)
	missing_profile(q)=m;
	%fname
	q=q+1;
	end	

end	
	
misprof=eddy_pfile(missing_profile);
failprof=eddy_pfile(failed_prof);

save missing_profiles misprof failprof
	


