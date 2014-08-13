clear all
load bwr.pal
load EK_new_comps winter_c
x=linspace(-2,2,49);
y=x;
sst=smoothn(double(winter_c.sst_median),3); %deg c
h = smoothn(double(winter_c.ssh_median),3)./100; %m


[lon,lat]=meshgrid(x,y);

alpha=.32;

wind_speed=8; %ms
wind_dir=315;

comp_wek=nan(length(x),length(x),length(wind_dir));

[u_w,v_w]=pol2cart(degtorad(wind_dir),wind_speed);
ff=f_cor(-30);
g = 9.81; %ms^-2


for m=1:length(u_w)
%first do just SST
wind_dir(m)
theta=cart2pol(u_w(m),v_w(m));
[u_sst,v_sst]=pol2cart(theta,alpha*sst);
tau_x_sst=wind2stress(u_w(m)-u_sst);
tau_y_sst=wind2stress(v_w(m)-v_sst);
crl_tau_sst=dfdx_abs(tau_y_sst,.12)-dfdy(tau_x_sst,.12);
w_ek_sst=1./(1020*ff).*crl_tau_sst.*8640000;

%now do just crlg
u = (-g./ff).*dfdy(h,.12);
v = (g./ff).*dfdx_abs(h,.12);
crl=dfdx_abs(v,.12)-dfdy(u,.12);
spd_o=sqrt(u.^2+v.^2);
u_rel=u_w(m)-u;
v_rel=v_w(m)-v;
crl_rel=dfdx_abs(v_rel,.12)-dfdy(u_rel,.12);
tau_x=wind2stress(u_rel);
tau_y=wind2stress(v_rel);
crl_tau=dfdx_abs(tau_y,.12)-dfdy(tau_x,.12);
w_ek=1./(1020*ff).*crl_tau.*8640000;
comp_wek(:,:,m)=w_ek;

%now both
u_rel=u_w(m)-(u+u_sst);
v_rel=v_w(m)-(v+v_sst);
crl_rel_tot=dfdx_abs(v_rel,.12)-dfdy(u_rel,.12);
tau_x=wind2stress(u_rel);
tau_y=wind2stress(v_rel);
crl_tau_tot=dfdx_abs(tau_y,.12)-dfdy(tau_x,.12);
w_ek_tot=1./(1020*ff).*crl_tau_tot.*8640000;


eval(['cplot_comps_cont_2_2_bwr(w_ek_tot,w_ek_tot,-10,10,1,-100,100,',char(39),...
'W_E^ from currents and SST anomaly',char(39),',',char(39),...
'/Users/gaube/Documents/OSU/figures/eddy-wind/scam_03_deg_c/c_wek_dir_scam_tot',num2str(m),char(39),')'])

eval(['cplot_comps_cont_2_2_bwr(w_ek_sst,w_ek_sst,-10,10,1,-100,100,',char(39),...
'W_E^ from SST anomaly',char(39),',',char(39),...
'/Users/gaube/Documents/OSU/figures/eddy-wind/scam_03_deg_c/c_wek_dir_scam_sst',num2str(m),char(39),')'])

eval(['cplot_comps_cont_2_2_bwr(w_ek,w_ek,-10,10,1,-100,100,',char(39),...
'W_E^ from Gaussian eddy currents',char(39),',',char(39),...
'/Users/gaube/Documents/OSU/figures/eddy-wind/scam_03_deg_c/c_wek_dir_scam_cur',num2str(m),char(39),')'])


%
figure(4)
clf
subplot(221)
compass(u_w(m),v_w(m))
title('Wind Direction')
text(-25,10,['amp=',num2str(max(h(:))),'m'])
text(-25,6,['\alpha=',num2str(alpha)])
text(-25,2,['speed=',num2str(wind_speed),'ms^{-1}'])
text(-25,-2,['SST=',num2str(max(abs(sst(:)))),'^\circ C'])
text(-25,-6,['W_{max}=',num2str(max(w_ek_tot(:))),'^\circ C'])


subplot(222)
pcolor(x,y,w_ek_tot);shading flat;colorbar
title('W_E from current and SST')
axis image
caxis([-10 10])
line([0 0],[-2 2],'color','k')
line([-2 2],[0 0],'color','k')

subplot(223)
pcolor(x,y,w_ek);shading flat;colorbar
title('W_E from current')
axis image
hold on
contour(x,y,h,[-1:.01:1],'k')
caxis([-10 10])
line([0 0],[-2 2],'color','k')
line([-2 2],[0 0],'color','k')

subplot(224)
pcolor(x,y,w_ek_sst);shading flat;colorbar
title('W_E from SST')
axis image
hold on
contour(x,y,sst,[2:-.2:.2],'k-')
contour(x,y,sst,[-.2:-.2:-2],'k--')
caxis([-10 10])
colormap(bwr)
line([0 0],[-2 2],'color','k')
line([-2 2],[0 0],'color','k')
drawnow
eval(['print -dpng -r300 frames/eddy_wind_scam/frame_',num2str(m)])
%}
end
cplot_comps_cont_2_2_bwr(nanmean(comp_wek,3),nanmean(comp_wek,3),-10,10,1,-100,100,'W_E^ averaged by 15 deg','/Users/gaube/Documents/OSU/figures/eddy-wind/scam_03_deg_c/c_rotating_wk_scam')


%{
w_ek_sst=interp2(w_ek_sst,3);	
w_ek=interp2(w_ek,3);
w_ek_tot=interp2(w_ek_tot,3);
%}
cplot_comps_cont_2_2(1e5*crl,h,-.8,.8,.02,-2,2,'Gaussian eddy geostrophic vorticity','/Users/gaube/Documents/OSU/figures/eddy-wind/scam_03_deg_c/c_crl_scam')
cplot_comps_cont_2_2(sst,sst,-.5,.5,.1,-2,2,'eddy SST anomaly','/Users/gaube/Documents/OSU/figures/eddy-wind/scam_03_deg_c/c_sst_scam')
cplot_comps_cont_2_2(sst,h,-.5,.5,.02,-1,1,'eddy SST anomaly','/Users/gaube/Documents/OSU/figures/eddy-wind/scam_03_deg_c/c_sst_h_scam')
cplot_comps_cont_2_2_bwr(w_ek_sst,w_ek_sst,-10,10,1,-100,100,'W_E^ from eddy SST anomaly','/Users/gaube/Documents/OSU/figures/eddy-wind/scam_03_deg_c/c_wek_sst_scam')
cplot_comps_cont_2_2_bwr(w_ek,w_ek,-10,10,1,-100,100,'W_E^ from Gaussian eddy currents','/Users/gaube/Documents/OSU/figures/eddy-wind/scam_03_deg_c/c_wek_cur_scam')
cplot_comps_cont_2_2_bwr(w_ek_tot,w_ek_tot,-10,10,1,-100,100,'W_E^ from currents and SST anomaly','/Users/gaube/Documents/OSU/figures/eddy-wind/scam_03_deg_c/c_wek_tot_scam')