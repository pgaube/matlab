%%%%%%
clear all
fr=1;
load chelle.pal
pm=1;mf=1;
a=-0.3467;
b=3.3220;
%%%%%%

%
load /matlab/matlab/eddy-wind/tracks/EK_lat_lon_tracks_all.mat
load /matlab/matlab/argo/argo_prof_mld.mat


%{
%load tmp jj
jj=sames(id,eddy_id);
ii=find(eddy_id(jj)>=nneg & eddy_dist(jj)<=50);
save tmp ii jj
%}
load tmp jj ii
length(ii)
%}

!toast /matlab/matlab/argo/frames/EK_eddies/*


for m=1:length(ii)
	load(['/matlab/data/eddy/V4/mat/AVISO_25_W_',num2str(eddy_pjday_round(jj(ii(m))))],'lat','lon','ssh','mask')
	load(['/matlab/data/gsm/mat/GSM_9_21_',num2str(eddy_pjday_round(jj(ii(m))))],'glat','glon','gpar_week','bp21_car','raw_bp26_chl','sm_gchl_week','sm_gcar_week')
	tmp=num2str(pfile{jj(ii(m))});
	ff=find(tmp=='/');
	fname=tmp(ff(3)+1:length(tmp));
	if exist(['/data/argo/profiles/', fname]) & ~isnan(eddy_mld(jj(ii(m)))) & pjday(jj(ii(m)))>=2450884 & pjday(jj(ii(m)))<=2454467
		[plat,plon,p,s,t]=read_profiles(fname);
		if max(s)>100;
			s=34*ones(size(t));
		end	
		return
		%t=filter_sigma(3,t);
		%s=filter_sigma(3,s);
		poo=find(id==eddy_id(jj(ii(m))) & track_jday==eddy_pjday_round(jj(ii(m))));
		%calc mld
		st=sw_dens(s,sw_ptmp(s,t,p,0),0)-1000;
		
		[rc,cc]=imap(plat-3,plat+3,plon-3,plon+3,glat,glon);
		tt=gpar_week(rc,cc);
		par=nanmean(tt(:));
		[pr,pc]=imap(plat-.125,plat+.125,plon-.125,plon+.125,glat,glon);
		pchl=10^sm_gchl_week(pr(1),pc(1));
		pcar=10^sm_gcar_week(pr(1),pc(1));
		z=exp(a*log(pchl)+b);
		kd=1./z;
		ig = par* exp(-kd*(eddy_mld(jj(ii(m)))/2));
		ccl = .022+(.045-.022)*exp(-3*ig);
		mu = 2*((pchl/pcar)./ccl)*(1-exp(-3*ig));
		
		figure(191)
		clf
		subplot(221)
		[r,c]=imap(plat-3,plat+3,plon-3,plon+3,lat,lon);
		%{
		pcolor(lon(r,c),lat(r,c),double(ssh(r,c).*mask(r,c)));shading flat;axis image
		colormap(chelle)
		caxis([-30 30])
		hold on
		contour(lon(r,c),lat(r,c),ssh(r,c),[-100:2:100],'k')
		plot(eddy_plon(jj(ii(m))),eddy_plat(jj(ii(m))),'k*')
		%plot(plon,plat,'k.')
		plot(eddy_max_ssh_lon(jj(ii(m))),eddy_max_ssh_lat(jj(ii(m))),'k.')
		[pr,pc]=imap(plat-.125,plat+.125,plon-.125,plon+.125,lat,lon);
		rel_amp=abs(ssh(pr,pc))-eddy_edge_ssh(jj(ii(m)));
		title(['eddy id = ',num2str(eddy_id(jj(ii(m)))),'    amp = ',num2str(eddy_amp(jj(ii(m)))),'   '])
		%}
		set(gca,'xticklabel',[],'yticklabel',[],'xcolor',[1 1 1],'ycolor',[1 1 1])
		text(0,0,['PAR = ',num2str(par),'  E m^{-2} hr^{-1}'])
		text(0,.15,['CHL = ',num2str(pchl),'  mg m^{-3}'])
		text(0,.3,['Z = ',num2str(z),'  m'])
		text(0,.45,['Ig = ',num2str(ig),'  E m^{-2} hr^{-1}'])
		text(0,.6,['C = ',num2str(pcar),'  mg m^{-3}'])
		text(0,.75,['CHL:C = ',num2str(pchl/pcar),' '])
		text(0,.9,['CHL:C_I = ',num2str(ccl),'  '])
		text(0,1.15,['\mu = ',num2str(mu),'  day^{-1}'])
		
		
		subplot(222)
		
		pcolor(glon(rc,cc),glat(rc,cc),double(10.^sm_gchl_week(rc,cc)));shading flat;axis image
		colorbar
		hold on
		t=caxis;
		contour(lon(r,c),lat(r,c),ssh(r,c),[-100:2:100],'k')
		caxis(t)
		colormap(chelle)
		xlabel(['eddy id = ',num2str(eddy_id(jj(ii(m)))),'  '])
		
		hold on
		contour(lon(r,c),lat(r,c),ssh(r,c),[-100:2:100],'k')
		plot(plon,plat,'k*')
		plot(x(poo),y(poo),'k.')
		%plot(plon,plat,'k.')
		%plot(eddy_max_ssh_lon(jj(ii(m))),eddy_max_ssh_lat(jj(ii(m))),'k.')
		[pr,pc]=imap(plat-.125,plat+.125,plon-.125,plon+.125,lat,lon);
		%rel_amp=abs(ssh(pr,pc))-eddy_edge_ssh(jj(ii(m)));
		mc=raw_bp26_chl(rc,cc);
		title('CHL')
		
		
		subplot(223)
		plot(st,-p)
		daspect([1 40 1])
		axis([20 30 -400 0])
		line([20 30],[-eddy_mld(jj(ii(m))) -eddy_mld(jj(ii(m)))],'color','k')
		grid
		xlabel('\sigma_\theta')
		ylabel('z')
		title(['MLD= ',num2str(eddy_mld(jj(ii(m))))])
		
		subplot(224)
		[yea,mon,day]=jd2jdate(pjday(jj(ii(m))));
		pcolor(glon(rc,cc),glat(rc,cc),double(10.^sm_gcar_week(rc,cc)));shading flat;axis image
		colorbar
		hold on
		plot(plon,plat,'k*')
		plot(x(poo),y(poo),'k.')
		t=caxis;
		contour(lon(r,c),lat(r,c),ssh(r,c),[-100:2:100],'k')
		caxis(t)
		colormap(chelle)
		title('C')
		xlabel([num2str(yea),'-',num2str(mon),'-',num2str(day)])
		%{
		plot(st,-p)
		daspect([1 200 1])
		axis([20 30 -2000 0])
		line([20 30],[-eddy_mld(jj(ii(m))) -eddy_mld(jj(ii(m)))],'color','k')
		grid
		xlabel('\sigma_\theta')
		ylabel('z')
		title(['ssh= ',num2str(ssh(pr(1),pc(1))),'  edge ssh=',num2str(eddy_edge_ssh(jj(ii(m)))),'   '])
		%}
		eval(['print -dpng -r300 /matlab/matlab/argo/frames/EK_cores/frame_',num2str(fr),'.png'])
		fr=fr+1;
	end
end	
!ffmpeg -r 5 -sameq -s hd1080 -i frame_%d.png -y out.mp4
!ffmpeg -i frame_%d.png -y out_low.mpg

    	
    	
    	
    	