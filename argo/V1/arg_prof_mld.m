
%%
%
clear all
load /matlab/matlab/argo/argo_prof_index.mat pfile pjday plat plon

loadpath='/matlab/data/eddy/V4/mat/';
head='AVISO_25_W_';

startjd=2448910; %from mid_week_jdays of eddy files
endjd=2454832%2454804;
jdays=startjd:7:endjd;

tt=find(pjday>=startjd-3 & pjday<=endjd);
pfile=pfile(tt);
pjday=pjday(tt);
plat=plat(tt);
plon=plon(tt);

[eddy_mld,eddy_type,eddy_dist,eddy_scale,eddy_id,eddy_z26,eddy_pjday_round]=deal(nan(length(plat),1));

load /matlab/data/eddy/V4/global_tracks_V4
load([loadpath,head,num2str(jdays(10))],'lon','lat')

pp=1;

fot=1:length(pjday);

lap=length(pjday);

total_number_of_float=lap
n=1;
%}
progressbar('Checking Float')

for m=n:lap
	progressbar(m/lap)
	%interp profile location to 1/4 degree grid
	tx=plon(m);
	ty=plat(m);
	tmp=num2str(pfile{m});
	jj=find(tmp=='/');
	tmpp=tmp(jj(3)+1:length(tmp));
	if strcmp(tmpp(1),'D')
	if ~isnan(tx)
	if ~isnan(ty)
		% interp tx and ty to 1/4 degree grid using min dist
    	tmpxs=floor(tx)-2.125:.25:ceil(tx)+2.125;
    	tmpys=floor(ty)-2.125:.25:ceil(ty)+2.125;
    	disx = abs(tmpxs-tx);
    	disy = abs(tmpys-ty);
    	iminx=find(disx==min(disx));
    	iminy=find(disy==min(disy));
    	cx=tmpxs(iminx(1));
    	cy=tmpys(iminy(1));
    	r=find(lat(:,1)==cy);
    	c=find(lon(1,:)==cx);
    
    	if any(r)
    	if any(c)
    		%interp pjday to closest week
    		tj=round(pjday(m));
    		tmpj=tj-3:tj+3;
    		p=sames(tmpj,jdays);
    	
    		if any(p)
    			%now look to see if float is in eddy
   				load([loadpath,head,num2str(jdays(p))],'idmask','ssh')
    			if ~isnan(idmask(r,c))
    				ii=find(track_jday==jdays(p) & eid==abs(idmask(r,c)));
    				if any(ii)
    					tmp=num2str(pfile{m});
						ff=find(tmp=='/');
						fname=tmp(ff(3)+1:length(tmp));
						if exist(['/data/argo/profiles/', fname])
							[blank,dumb,pres,s,t]=read_profiles(fname);
							st=sw_dens(s,sw_ptmp(s,t,pres,0),0)-1000;
							i10=find(abs(pres-10)==min(abs(pres-10)));
							i26=find(abs(st-26)==min(abs(st-26)));
							if any(i10)
								imld=find(st-st(i10(1))>.125);
								if any(imld)
								%if pres(imld(1))<300
								%pres(imld(1))
								eddy_mld(m)=pres(imld(1));
								%end	
								eddy_dist(m)=sqrt((111.11*(plat(m)-y(ii)))^2+(111.11*cosd(plat(m))*(plon(m)-x(ii)))^2);
								eddy_scale(m)=efold(ii);
								eddy_id(m)=id(ii);
								eddy_pjday_round(m)=jdays(p);
								end	
								if any (i26)
						  			eddy_z26(m)=pres(i26(1));
						  		end
								
								if id(ii)>=nneg
									eddy_type(m)=1;
								else
									eddy_type(m)=-1;
								end	
							end
						end				
    				end
    			else
    				tmp=num2str(pfile{m});
					ff=find(tmp=='/');
					fname=tmp(ff(3)+1:length(tmp));
					if exist(['/data/argo/profiles/', fname])
						[blank,dumb,pres,s,t]=read_profiles(fname);
						st=sw_dens(s,sw_ptmp(s,t,pres,0),0)-1000;
						i10=find(abs(pres-10)==min(abs(pres-10)));
						i26=find(abs(st-26)==min(abs(st-26)));
						if any(i10)
							imld=find(st-st(i10(1))>.125);
							if any(imld)
							%if pres(imld(1))<300
							%pres(imld(1))
							eddy_mld(m)=pres(imld(1));
							%end	
							end	
							if any (i26)
						  		eddy_z26(m)=pres(i26(1));
						  	end
							eddy_type(m)=0;
							eddy_pjday_round(m)=jdays(p);
						end
					end				
    			end
    		pp=pp+1;	
    		end
    	end
    	end
    end
    end
    end
    n=n+1;
end
fprintf('\n')

save argo_prof_mld.mat eddy_* pfile pjday plat plon
    