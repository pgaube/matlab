%%%%%
%{
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
%}

!toast /matlab/matlab/argo/frames/EK_eddies_mld_season_mchl/*
cd /matlab/matlab/argo/frames/EK_eddies_mld_season_mchl/
want_id=[169127 134787 147314 147800 153341 154636 156660 156745 158475 159071 159457 163503]
load('/data/modisa/mat/CHL_4_W_2452459','lon','lat','chl_week')
mlon=lon;
mlat=lat;

for m=1:length(want_id)
	ii=find(eddy_id==want_id(m));
	jj=find(id==want_id(m));
	for n=1:length(ii)
		tmp=num2str(pfile{ii(n)});
		ff=find(tmp=='/');
		fname=tmp(ff(3)+1:length(tmp));
		if exist(['/data/argo/profiles/', fname]) & ...
		~isnan(eddy_mld(ii(n))) & ...
		pjday(ii(n))>=2452459 & ...
		pjday(ii(n))<=2454467
			load(['/matlab/data/eddy/V4/mat/AVISO_25_W_',num2str(eddy_pjday_round(ii(n)))],'lat','lon','ssh','mask')
			load(['/matlab/data/gsm/mat/GSM_9_21_',num2str(eddy_pjday_round(ii(n)))],'glat','glon','raw_bp26_chl','gpar_week','sm_gcar_week','sm_gchl_week')
			load(['/data/modisa/mat/CHL_4_W_',num2str(eddy_pjday_round(ii(n)))],'chl_week')

			[plat,plon,p,s,t]=read_profiles(fname);
			if max(s)>100;
				s=34*ones(size(t));
			end	
			t=filter_sigma(3,t);
			s=filter_sigma(3,s);
			poo=find(id==eddy_id(ii(n)) & track_jday==eddy_pjday_round(ii(n)));
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
			ig = par* exp(-kd*(eddy_mld(ii(n))/2));
			ccl = .022+(.045-.022)*exp(-3*ig);
			mu = 2*((pchl/pcar)./ccl)*(1-exp(-3*ig));
		
			figure(191)
			clf
			subplot(221)
			[r,c]=imap(plat-3,plat+3,plon-3,plon+3,lat,lon);
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
			contour(lon(r,c),lat(r,c),ssh(r,c),[-100:4:-2 2:4:100],'k')
			caxis(t)
			colormap(chelle)
			xlabel(['eddy id = ',num2str(eddy_id(ii(n))),'  '])
		
			hold on
			plot(plon,plat,'k*')
			plot(x(poo),y(poo),'k.')
			%plot(plon,plat,'k.')
			[pr,pc]=imap(plat-.125,plat+.125,plon-.125,plon+.125,lat,lon);
			mc=raw_bp26_chl(rc,cc);
			title('CHL')
		
		
			subplot(223)
			plot(st,-p)
			daspect([1 40 1])
			axis([20 30 -400 0])
			line([20 30],[-eddy_mld(ii(n)) -eddy_mld(ii(n))],'color','k')
			grid
			xlabel('\sigma_\theta')
			ylabel('z')
			title(['MLD= ',num2str(eddy_mld(ii(n)))])
		
			subplot(224)
			[yea,mon,day]=jd2jdate(pjday(ii(n)));
			[ctr,ctc]=imap_4km(min(lat(r,1)),max(lat(r,1)),min(lon(1,c)),max(lon(1,c)),mlat,mlon);
			pcolor(mlon(ctr,ctc),mlat(ctr,ctc),double(chl_week(ctr,ctc)));
			shading flat
			ran=caxis;
			hold on
			contour(lon(r,c),lat(r,c),ssh(r,c),[-100:4:-2 2:4:100],'k')
			set(gca,'xticklabel',[],'yticklabel',[],'LineWidth',2)
			axis image
			colorbar
			caxis(t)
			title('Instantaneous 4km CHL  ')
			xlabel([num2str(yea),'-',num2str(mon),'-',num2str(day)])
			
			%{
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
			%}
				
			eval(['print -dpng -r300 frame_',num2str(fr),'.png'])
			fr=fr+1;
		end	
	end
end	
!ffmpeg -i frame_%d.png -y out_low.mpg

    	
    	
    	
    	