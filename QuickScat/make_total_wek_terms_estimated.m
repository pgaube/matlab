spath='~/data/QuickScat/new_mat/QSCAT_30_25km_'
apath='~/data/eddy/V5/mat/AVISO_25_W_'
opath='~/data/QuickScat/ULTI_mat5/QSCAT_30_25km_'
%Set range of dates
jdays=[2452466:7:2455126];

% jdays=[2452571:7:2455147]%[2452424:7:2455159];

[year,month,day]=jd2jdate(jdays);
%loess filter
load([apath num2str(jdays(1))],'lat','lon')
slat=lat;
slon=lon;
load([spath num2str(jdays(1))],'lat','lon')
[rs,cs]=imap(min(lat(:)),max(lat(:)),0,360,slat,slon);
wek_th=500
[dum,bb]=f_cor(lat);
ff=f_cor(lat);
for m=1:length(jdays)
	yearday(m) = year(m)*1000+julian(month(m),day(m),year(m));
	calday(m) =  year(m)*10000+month(m)*100+day(m);
	fprintf('\r   filtering %08u \r',calday(m))
	
    load([spath num2str(jdays(m))],'sm_u_week','sm_v_week')
    load([apath num2str(jdays(m))],'crl','ssh','u','v')

	u_rel=sm_u_week-u(rs,:);
	v_rel=sm_v_week-v(rs,:);
	[tau_x,tau_y] = wind2stress_comp(u_rel,v_rel);
	crl_tau=dfdx(lat,tau_y,.25)-dfdy(tau_x,.25);
    ssh=ssh(rs,cs);
	
    dcdx=dfdx(slat(rs,cs),crl(rs,cs),.25);
    dcdy=dfdy(crl(rs,cs),.25);
    
    w_ek_l=(1/1020)*(1./(ff+crl(rs,cs))).*crl_tau.*8640000;
    w_ek_n=(1/1020)*(1./(ff+crl(rs,cs)).^2).*((tau_x.*dcdy)-(tau_y.*dcdx)).*8640000;
%     w_ek_b=(1/1020)*(1./(ff+crl(rs,cs)).^2).*(bb.*tau_x).*8640000;
    
%  	w_ek_total=w_ek_l+w_ek_n+w_ek_b;
 	w_ek_total2=w_ek_l+w_ek_n;
    
%     [lp,flag]=smooth2d_loess(w_ek_n,lon(1,:),lat(:,1),6,6,lon(1,:),lat(:,1));
% 	hp_zeta_wek_est=w_ek_n-lp;
%     hp_zeta_wek_est(flag==1)=nan;
% %     hp_zeta_wek_est(find(abs(rm.*hp_zeta_wek_est)>wek_th))=nan;
%     clear lp flag
%     
%     [lp,flag]=smooth2d_loess(w_ek_l,lon(1,:),lat(:,1),6,6,lon(1,:),lat(:,1));
% 	hp_crl_wek_est=w_ek_l-lp;
%     hp_crl_wek_est(flag==1)=nan;
% %     hp_crl_wek_est(find(abs(rm.*hp_crl_wek_est)>wek_th))=nan;
%     clear lp flag
    
    [lp,flag]=smooth2d_loess(w_ek_total2,lon(1,:),lat(:,1),6,6,lon(1,:),lat(:,1));
	hp_total_wek_est2=w_ek_total2-lp;
    hp_total_wek_est2(flag==1)=nan;
    background_wek_tot_est=lp;
%     hp_total_wek_est(find(abs(rm.*hp_total_wek_est)>wek_th))=nan;
    clear lp flag
% %     
%     [lp,flag]=smooth2d_loess(w_ek_total,lon(1,:),lat(:,1),6,6,lon(1,:),lat(:,1));
% 	hp_total_wek_est=w_ek_total-lp;
%     hp_total_wek_est(flag==1)=nan;
%     hp_total_wek_est(find(abs(hp_total_wek_est)>wek_th))=nan;
% %     clear lp flag
%     [r,c]=imap(-30,-20,80,120,lat,lon);
%     figure(1)
%     clf
%     subplot(311)
%     pmap(lon(r,c),lat(r,c),hp_crl_wek_est(r,c))
%     hold on
%     m_contour(lon(r,c),lat(r,c),ssh(r,c),[-50:5:-5],'k--')
%     m_contour(lon(r,c),lat(r,c),ssh(r,c),[5:5:50],'k')
%     caxis([-20 20])
%     subplot(312)
%     pmap(lon(r,c),lat(r,c),hp_zeta_wek_est(r,c))
%     hold on
%     m_contour(lon(r,c),lat(r,c),ssh(r,c),[-50:5:-5],'k--')
%     m_contour(lon(r,c),lat(r,c),ssh(r,c),[5:5:50],'k')
%     caxis([-20 20])
%     subplot(313)
%     pmap(lon(r,c),lat(r,c),hp_total_wek_est(r,c))
%     hold on
%     m_contour(lon(r,c),lat(r,c),ssh(r,c),[-50:5:-5],'k--')
%     m_contour(lon(r,c),lat(r,c),ssh(r,c),[5:5:50],'k')
%     caxis([-20 20])
%     load bwr.pal
%     colormap(bwr)
    
% 	 if exist([opath num2str(jdays(m)) '.mat'])
        eval(['save -append ' [opath num2str(jdays(m))] ' hp_*_wek_est2 background_wek_tot_est'])	
%     else
%         eval(['save ' [opath num2str(jdays(m))] ' hp_*_wek_est'])	
%     end
	clear hp_*_wek*e hp66_* crl taux_*
end

