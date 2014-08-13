home_dir='~/data/QuickScat/schlax/';
apath='~/data/eddy/V5/mat/AVISO_25_W_'

cd([home_dir '/mat'])
tmp=dir(['schlax*']);
load bwr.pal
load chelle.pal
wek_th=500
for m=1:length(tmp)
    display(['file ',num2str(m),' of ',num2str(length(tmp))])
    fname=num2str(getfield(tmp,{m},'name'));
    jd=str2num(fname(8:14));
    load(['schlax_',num2str(jd)])
    load([apath num2str(jd)],'crl','ssh','u','v')
    [lon,lat]=meshgrid(lon,lat);
    [ff,bb]=f_cor(lat);
% % 
%     hp_wek_sst_week_fixed=-.01*8640000*dtds_week./1020./(ff+crl);
%     eval(['save -append ',home_dir,'mat/schlax_',num2str(jd),' hp_wek_sst_week_fixed'])
%     
        %%%plot
%     figure(1)
%     clf
%     pmap(lon,lat,hp_wek_sst_week_fixed)
%     caxis([-50 50])
%     colorbar
%     colormap(bwr)

%     u_rel=sm_u_week-u;
% 	v_rel=sm_v_week-v;
% 	[tau_x,tau_y] = wind2stress_comp(u_rel,v_rel);
% 	crl_tau=dfdx(lat,tau_y,.25)-dfdy(tau_x,.25);
% 	
%     dcdx=dfdx(lat,crl,.25);
%     dcdy=dfdy(crl,.25);
%     
%     w_ek_l=(1/1020)*(1./(ff+crl)).*crl_tau.*8640000;
%     w_ek_n=(1/1020)*(1./(ff+crl).^2).*((tau_x.*dcdy)-(tau_y.*dcdx)).*8640000;
%     w_ek_b=(1/1020)*(1./(ff+crl).^2).*(bb.*tau_x).*8640000;
%     
%  	w_ek_total=w_ek_l+w_ek_n+w_ek_b;
%     
%     [lp,flag]=smooth2d_loess(w_ek_total,lon(1,:),lat(:,1),6,6,lon(1,:),lat(:,1));
% 	hp_total_wek_est=w_ek_total-lp;
%     hp_total_wek_est(flag==1)=nan;
%     hp_total_wek_est(find(abs(hp_total_wek_est)>wek_th))=nan;
%     clear lp flag w_ek_* 
%     
%     w_ek_l=(1/1020)*(1./(ff+crl)).*strcrl_week.*8640000;
%     w_ek_n=(1/1020)*(1./(ff+crl).^2).*((taux_week.*dcdy)-(tauy_week.*dcdx)).*8640000;
%     w_ek_b=(1/1020)*(1./(ff+crl).^2).*(bb.*taux_week).*8640000;
%     
%  	w_ek_total=w_ek_l+w_ek_n+w_ek_b;
%     
%     
%     [lp,flag]=smooth2d_loess(w_ek_total,lon(1,:),lat(:,1),6,6,lon(1,:),lat(:,1));
% 	hp_total_wek_qscat=w_ek_total-lp;
%     hp_total_wek_qscat(flag==1)=nan;
%     hp_total_wek_qscat(find(abs(hp_total_wek_qscat)>wek_th))=nan;
%     clear lp flag
%     
%     eval(['save -append ',home_dir,'mat/schlax_',num2str(jd),' hp*'])

%     %%%plot
%     figure(1)
%     clf
%     pmap(lon,lat,hp_total_wek_qscat)
%     caxis([-50 50])
%     colorbar
%     colormap(bwr)
%     print -dpng -r300 w_tot
%     
%     clf
%     pmap(lon,lat,hp_total_wek_est)
%     caxis([-50 50])
%     colorbar
%     colormap(bwr)
%     print -dpng -r300 w_cur
%     return

    
end
cd(home_dir)
    