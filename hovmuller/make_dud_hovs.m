clear
set_hovs



%{
%map lines

figure(101)
clf
pmap(0:360,-60:60,nan(length(-60:60),length(0:360)))
title('Locations of Hovmoller Transects  ')
hold on

for m=1:17%length(lat)
	m_plot([wlon(m) elon(m)],[lat(m) lat(m)],'k')
	m_text(elon(m)+(wlon(m)-elon(m))/2,lat(m)+2,num2str(m))
end
print -dpng -r300 figs/map_hov_locations
%}

load /matlab/data/eddy/V4/global_tracks_V4 x y id track_jday nneg

for m=[24]%1:length(lat)
	
	ii=find(x>=wlon(m) & x<=elon(m) & y>=lat(m)-1 & y<=lat(m)+1);
	hx=x(ii);
	hy=y(ii);
	hid=id(ii);
	htrack_jday=track_jday(ii);
	
	%[raw_shov,raw_slon,raw_syear_day]=hovmoller('raw_ssh',[wlon(m) elon(m)],lat(m),dy);
	%[shov,slon,syear_day]=hovmoller('ssh',[wlon(m) elon(m)],lat(m),dy);
	%[vhov,vlon,vyear_day]=hovmoller('hp66_crl',[wlon(m) elon(m)],lat(m),dy);
	%[thov,tlon,tyear_day]=hovmoller('filtered_sst_oi',[wlon(m) elon(m)],lat(m),dy);
	%[raw_thov,tlon,tyear_day]=hovmoller('sst_oi',[wlon(m) elon(m)],lat(m),dy);
	%[chov,hp_chov,full_chov,clon,cyear_day,cjdays]=hovmoller([wlon(m) elon(m)],lat(m),'gsm_chl');
	%[phov,full_phov,raw_phov,raw_plon,plon,pyear_day,pjdays]=hovmoller_loess([wlon(m) elon(m)],lat(m),dy,'gsm_day');
	%[ghov,full_ghov,raw_ghov,raw_glon,glon,gyear_day,gjdays]=hovmoller_loess([wlon(m) elon(m)],lat(m),dy,'gsm_day');
	 [shov,hp_shov,full_shov,slon,syear_day,sjdays]=hovmoller([wlon(m) elon(m)],lat(m),'ssh');
	%[lhov,raw_lhov,raw_llon,llon,lyear_day,ljdays]=hovmoller_loess([wlon(m) elon(m)],lat(m),dy,'lp22_chl');

	%{
	if rem(length(clon),2)==0
		fp=phov(:,1:length(clon)-1);
		fc=chov(:,1:length(clon)-1);
		fn_plon=plon(1:length(clon)-1);
		fn_clon=fn_plon;
		fn_poc=filter_fft2d(fillnans(fp),7,.25*111.11*cosd(lat(m)));
		fn_chl=filter_fft2d(fillnans(fc),7,.25*111.11*cosd(lat(m)));
	else
		fn_plon=plon;
		fn_clon=fn_plon;
		fn_poc=filter_fft2d(fillnans(phov),7,.25*111.11*cosd(lat(m)));
		fn_chl=filter_fft2d(fillnans(chov),7,.25*111.11*cosd(lat(m)));
	end	
	
	if rem(length(slon),2)==0
		fs=raw_shov(:,1:length(slon)-1);
		fn_slon=slon(1:length(slon)-1);
		fn_ssh=filter_fft2d(fillnans(fs),7,.25*111.11*cosd(lat(m)));
	else
		fn_slon=slon;
		fn_ssh=filter_fft2d(fillnans(shov),7,.25*111.11*cosd(lat(m)));
	end	
	
	if rem(length(vlon),2)==0
		fv=vhov(:,1:length(vlon)-1);
		fn_vlon=vlon(1:length(vlon)-1);
		fn_vor=filter_fft2d(fillnans(fv),7,.25*111.11*cosd(lat(m)));
	else
		fn_vlon=vlon;
		fn_vor=filter_fft2d(fillnans(vhov),7,.25*111.11*cosd(lat(m)));
	end	
	
	if rem(length(tlon),2)==0
		ft=raw_thov(:,1:length(tlon)-1);
		fn_tlon=vlon(1:length(tlon)-1);
		fn_sst=filter_fft2d(fillnans(ft),7,.25*111.11*cosd(lat(m)));
	else
		fn_tlon=tlon;
		fn_sst=filter_fft2d(fillnans(thov),7,.25*111.11*cosd(lat(m)));
	end	
	%}
	if exist(['gline_',num2str(m),'_hov.mat'])
    eval(['save -append gline_',num2str(m),'_hov'])
    else
    eval(['save gline_',num2str(m),'_hov'])
    end
    

	clearallbut load chelle lat wlon elon dy x y id nneg track_jday dt

end
