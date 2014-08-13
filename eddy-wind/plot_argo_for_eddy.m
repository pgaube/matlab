clear all
want_id=149011

load /matlab/matlab/argo/eddy_argo_prof_index
load /matlab/data/eddy/V4/global_tracks_V4 x y id

ii=find(id==want_id);
jj=find(eddy_id==want_id);


figure(100)
clf
pmap(min(x(ii))-5:max(x(ii))+5,min(y(ii))-5:max(y(ii))+5,[x(ii) y(ii) id(ii)],'tracks')
hold on
for m=1:length(jj)
	m_plot(eddy_plon(jj(m)),eddy_plat(jj(m)),'*')         
	m_text(eddy_plon(jj(m)),eddy_plat(jj(m))+1,num2str(eddy_k(jj(m))))
	m_text(eddy_plon(jj(m)),eddy_plat(jj(m))-1,num2str(m))
end
title('Locations of ARGO profiles within Eddy Interior   ')
%print -dpng -r300 figs/chosen_ac_argo_prof_locs

P=nan(100,length(jj));
T=P;
S=P;
RHO=P;

pm=1;mf=1;
figure(1)
clf
hold on
for m=1:length(jj)
	tmp=num2str(eddy_pfile{jj(m)});
	ff=find(tmp=='/');
	fname=tmp(ff(3)+1:length(tmp));
	if exist(['/data/argo/profiles/', fname])
		[plat(m),plon(m),p,s,t]=read_profiles(fname);
		P(1:length(p),m)=p;
		T(1:length(t),m)=filter_sigma(3,t);
		T(1:length(s),m)=filter_sigma(3,s);
		
		%calc mld
		st=sw_dens(s,sw_ptmp(s,t,p,0),0)-1000;
		RHO(1:length(t),m)=st;
		i10=find(min(p-10));
		imld=find(st-st(i10)>.125);
		if any(imld)
			mld=P(imld(1))
			pm=pm+1;
			mlds(pm,1)=eddy_k(jj(m));
			mlds(pm,2)=mld;
		else
			missing_pfile(mf,:)=tmp;
			mf=mf+1;
		end	
		plot(st,-p)
		daspect([1 40 1])
		axis([20 30 -1500 0])
		grid
		
	else
		%fprintf('\n mising profile \n')
	end
end	
save chosen_mlds mlds