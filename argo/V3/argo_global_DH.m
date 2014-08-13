%
clear all
load ~/data/eddy/V5/midlat_lat_lon_tracks.mat
load ~/matlab/argo/v3/eddy_argo_prof_index_v5_fast
uid=unique(id);
same_prof=sames(uid,eddy_id);     
eddy_pfile=eddy_pfile(same_prof);
eddy_pjday=eddy_pjday(same_prof);
eddy_enclosed=eddy_enclosed(same_prof);
eddy_amp=eddy_amp(same_prof);
eddy_eid=eddy_eid(same_prof);
eddy_id=eddy_id(same_prof);
eddy_scale=eddy_scale(same_prof);
eddy_dist_x=eddy_dist_x(same_prof);
eddy_dist_y=eddy_dist_y(same_prof);
eddy_dist_ext_x=eddy_dist_ext_x(same_prof);
eddy_dist_ext_y=eddy_dist_ext_y(same_prof);
eddy_ext_x=eddy_ext_x(same_prof);
eddy_ext_y=eddy_ext_y(same_prof);
eddy_x=eddy_x(same_prof);
eddy_y=eddy_y(same_prof);
eddy_plon=eddy_plon(same_prof);
eddy_ssh=eddy_ssh(same_prof);
eddy_plat=eddy_plat(same_prof);
eddy_axial_speed=eddy_axial_speed(same_prof);
eddy_cyc=eddy_cyc(same_prof);
eddy_pjday_round=eddy_pjday_round(same_prof);
eddy_qual=eddy_qual(same_prof);

[y,eddy_month,d]=jd2jdate(eddy_pjday);
ppres=[0:10:1000]';

eddy_dh=nan*eddy_x;


lap=length(eddy_y);
pp=1;

%ftp missing prfiles
fprintf('\r getting missing floats')
for m=1:lap
    tmp=num2str(eddy_pfile{m});
	ff=find(tmp=='/');
	fname=tmp(ff(3)+1:length(tmp)); 

    if ~exist(['~/data/argo/profiles/', fname]) & fname(1)=='D'
        get_pfile(pp)=eddy_pfile(m);
        pp=pp+1;        
    end 
end    
    
ftp_batch_profile(get_pfile);

fprintf('\r loading floats')
for m=1:lap
    tmp=num2str(eddy_pfile{m});
	ff=find(tmp=='/');
	fname=tmp(ff(3)+1:length(tmp)); 
	if exist(['~/data/argo/profiles/', fname]) & fname(1)=='D'
		clear pres s t
        [blank,dumb,pres,s,t]=read_profiles2(fname);
		if length(s)>2
            is=interp1(pres,s,ppres,'linear');
            is(1)=is(2);
        end
        if length(t)>2
            it=interp1(pres,t,ppres,'linear');
            it(1)=it(2);
            
            dh=sw_dh(is,it,ppres);
            eddy_dh(m)=dh(1);
        end
        clear is it dh
	end		
end



fprintf('\r interpolating WOA to float locations')
[t_woa,s_woa,z_woa]=ACL_profile(eddy_y,eddy_x,ppres,eddy_month);
warning('off','all')

ia=find(eddy_cyc==1);
ic=find(eddy_cyc==-1);

%make dh
woa_dh=nan*eddy_dh;
for m=1:length(eddy_x)
    dh=sw_dh(s_woa(:,m),t_woa(:,m),ppres);
    woa_dh(m)=dh(1);
end    

eddy_dh_anom=eddy_dh-woa_dh;

save argo_global_dh eddy_*
%}
%load argo_global_dh
%
ia=find(eddy_cyc==1);
ic=find(eddy_cyc==-1);



figure(1)
clf
step=2;
ri=0:step:250;
nkm_x=ri;
eddy_dist_km=sqrt(eddy_dist_ext_x.^2+eddy_dist_ext_y.^2).*eddy_scale;

for m=1:length(nkm_x)-1
    ii=find(eddy_dist_km(ia)>=nkm_x(m) & eddy_dist_km(ia)<nkm_x(m+1));
    ssh_ac(m)=pmean(eddy_ssh(ia(ii)));
    dh_ac(m)=100*pmean(eddy_dh_anom(ia(ii)));
    
    ii=find(eddy_dist_km(ic)>=nkm_x(m) & eddy_dist_km(ic)<nkm_x(m+1));
    ssh_cc(m)=pmean(eddy_ssh(ic(ii)));
    dh_cc(m)=100*pmean(eddy_dh_anom(ic(ii)));
end    

nkm_x(end)=[];

figure(13)
set(gcf,'PaperPosition',[1 1 8.5 11])
clf
stairs(nkm_x,ssh_ac,'r','LineWidth',2)
hold on
stairs(nkm_x,dh_ac,'r--','LineWidth',2)
stairs(nkm_x,ssh_cc,'b','LineWidth',2)
stairs(nkm_x,dh_cc,'b--','LineWidth',2)
line([0 200],[0 0],'color','k','LineWidth',2)
title('Dynamic height (dashed) and SSH (solid)','fontsize',25,'fontweight','bold')
ylabel('cm','fontsize',25,'fontweight','bold')
xlabel('km','fontsize',25,'fontweight','bold')
set(gca,'xlim',[0 150],'xtick',[0:50:200],'ytick',[-40:10:40],'ylim',[-20 20],'fontsize',15,'fontweight','bold','LineWidth',2,'TickLength',[.02 .02],'layer','top')
daspect([1 .5 1])
print -dpng -r300 figs/test_az_av_dh_ssh
!open figs/test_az_av_dh_ssh.png
return

pcomps_scatter(eddy_dist_ext_x(ia),eddy_dist_ext_y(ia),100*eddy_dh_anom(ia),[-5 5],['Argo anomaly of DH (anticyclones) N=',num2str(length(find(~isnan(eddy_dh_anom(ia))))),'  '])
print -dpng -r300 figs/test_scat_ac_dh
!open figs/test_scat_ac_dh.png

pcomps_scatter(eddy_dist_ext_x(ia),eddy_dist_ext_y(ia),eddy_ssh(ia),[-5 5],['AVISO SSH at profile locations (anticyclones) N=',num2str(length(find(~isnan(eddy_ssh(ia))))),'  '])
print -dpng -r300 figs/test_scat_ac_ssh
!open figs/test_scat_ac_ssh.png

pcomps_scatter(eddy_dist_ext_x(ic),eddy_dist_ext_y(ic),100*eddy_dh_anom(ic),[-5 5],['Argo anomaly of DH (cyclones) N=',num2str(length(find(~isnan(eddy_dh_anom(ic))))),'  '])
print -dpng -r300 figs/test_scat_cc_dh
!open figs/test_scat_cc_dh.png

pcomps_scatter(eddy_dist_ext_x(ic),eddy_dist_ext_y(ic),eddy_ssh(ic),[-5 5],['AVISO SSH at profile locations (cyclones) N=',num2str(length(find(~isnan(eddy_ssh(ic))))),'  '])
print -dpng -r300 figs/test_scat_cc_ssh
!open figs/test_scat_cc_ssh.png
return
dif=100*eddy_dh_anom-eddy_ssh;

pcomps_scatter(eddy_dist_ext_x,eddy_dist_ext_y,dif,[-5 5],['anomaly of DH minus SSH N=',num2str(length(find(~isnan(eddy_dh_anom)))),'  '])
print -dpng -r300 figs/test_scat_diff
!open figs/test_scat_diff.png
