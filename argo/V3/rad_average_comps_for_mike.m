warning('off','all')
step=10;
ri=0:step:250;
km_x=ri;
ff=f_cor(pmean(eddy_y));
eddy_dist_km=sqrt(eddy_dist_ext_x.^2+eddy_dist_ext_y.^2).*eddy_scale;
ppp=ppres*ones(1,length(km_x(1:end-1)));
eddy_dist=sqrt(eddy_dist_ext_x.^2+eddy_dist_ext_y.^2);
eddy_in_comp=nan*eddy_y;

ia=find(eddy_cyc==1);
ic=find(eddy_cyc==-1);

%make dh
eddy_dh=nan*eddy_it;
dh_woa=eddy_dh;
for m=1:length(eddy_x)
    eddy_dh(:,m)=sw_dh(eddy_is(:,m),eddy_it(:,m),ppres);
    dh_woa(:,m)=sw_dh(s_woa(:,m),t_woa(:,m),ppres);
    sigma_woa(:,m)=sw_dens(s_woa(:,m),t_woa(:,m),ppres)-1000;
end    

for m=1:length(km_x)-1
    ii=find(eddy_dist_km(ia)>=km_x(m) & eddy_dist_km(ia)<km_x(m+1) & eddy_enclosed(ia)~=10 & eddy_dist(ia)<=2);
    nda(m)=length(ii);
    eddy_in_comp(ii)=1;
    for n=1:length(ppres)
            ac_sigma(n,m)=pmean(eddy_ist(n,ia(ii)));
            ac_t(n,m)=pmean(eddy_it_anom(n,ia(ii)));
            ac_s(n,m)=pmean(eddy_is_anom(n,ia(ii)));
            ac_dh(n,m)=pmean(eddy_dh(n,ia(ii)));
            ac_std_dh(n,m)=pstd(eddy_dh(n,ia(ii)));
    end  
    ii=find(eddy_dist_km(ic)>=km_x(m) & eddy_dist_km(ic)<km_x(m+1) & eddy_enclosed(ic)~=10 & eddy_dist(ic)<=2);
    eddy_in_comp(ii)=-1;
    ndc(m)=length(ii);
    for n=1:length(ppres)
            cc_sigma(n,m)=pmean(eddy_ist(n,ic(ii)));
            cc_t(n,m)=pmean(eddy_it_anom(n,ic(ii)));
            cc_s(n,m)=pmean(eddy_is_anom(n,ic(ii)));
            cc_dh(n,m)=pmean(eddy_dh(n,ic(ii)));
            cc_std_dh(n,m)=pstd(eddy_dh(n,ic(ii)));
    end 
end 

%now WOA
for m=1:length(km_x)-1
    ii=find(eddy_dist_km>=km_x(m) & eddy_dist_km<km_x(m+1) & eddy_enclosed~=10 & eddy_dist<=2);
    for n=1:length(ppres)
        comp_t_woa(n,m)=pmean(t_woa(n,(ii)));
        comp_s_woa(n,m)=pmean(s_woa(n,(ii)));
        comp_dh_woa(n,m)=pmean(dh_woa(n,(ii)));
    end
end

ac_dh_anom=ac_dh-comp_dh_woa;
cc_dh_anom=cc_dh-comp_dh_woa;

ac_sigma_anom=ac_dh-comp_dh_woa;
cc_sigma_anom=cc_dh-comp_dh_woa;
        
        
km_x(end)=[];
tt=cat(2,-fliplr(km_x(2:end)),km_x);


fprintf('\r interpolating anticyclones')
ac_sigma=cat(2,fliplr(ac_sigma(:,2:end)),ac_sigma);
ac_sigma_anom=cat(2,fliplr(ac_sigma_anom(:,2:end)),ac_sigma_anom);
ac_dh_anom=cat(2,fliplr(ac_dh_anom(:,2:end)),ac_dh_anom);
ac_dh=cat(2,fliplr(ac_dh(:,2:end)),ac_dh);

ac_sigma=smooth2d_loess(ac_sigma,tt,ppres,150,150,tt,ppres);
ac_sigma_anom=smooth2d_loess(ac_sigma_anom,tt,ppres,150,150,tt,ppres);
ac_dh_anom=smooth2d_loess(ac_dh_anom,tt,ppres,120,150,tt,ppres);
ac_dh=smooth2d_loess(ac_dh,tt,ppres,150,150,tt,ppres);
ac_t=smooth2d_loess(ac_t,km_x,ppres,150,150,km_x,ppres);
ac_s=smooth2d_loess(ac_s,km_x,ppres,150,150,km_x,ppres);

[ac_v]=geostro_2d(ac_sigma,tt,ppres,ff);
[ac_v_dh]=geostro_2d_dh(ac_dh_anom,tt,ppres,ff);

ac_v_dh=ac_v_dh(:,length(km_x):end);
ac_v=ac_v(:,length(km_x):end);
ac_sigma=ac_sigma(:,length(km_x):end);
ac_dh_anom=ac_dh_anom(:,length(km_x):end);
ac_dh=ac_dh(:,length(km_x):end);


fprintf('\r interpolating cyclones')
cc_sigma=cat(2,fliplr(cc_sigma(:,2:end)),cc_sigma);
cc_sigma_anom=cat(2,fliplr(cc_sigma_anom(:,2:end)),cc_sigma_anom);
cc_dh_anom=cat(2,fliplr(cc_dh_anom(:,2:end)),cc_dh_anom);
cc_dh=cat(2,fliplr(cc_dh(:,2:end)),cc_dh);

cc_sigma=smooth2d_loess(cc_sigma,tt,ppres,150,150,tt,ppres);
cc_sigma_anom=smooth2d_loess(cc_sigma_anom,tt,ppres,150,150,tt,ppres);
cc_dh_anom=smooth2d_loess(cc_dh_anom,tt,ppres,150,150,tt,ppres);
cc_dh=smooth2d_loess(cc_dh,tt,ppres,150,150,tt,ppres);
cc_t=smooth2d_loess(cc_t,km_x,ppres,150,150,km_x,ppres);
cc_s=smooth2d_loess(cc_s,km_x,ppres,150,150,km_x,ppres);

[cc_v]=geostro_2d(cc_sigma,tt,ppres,ff);
[cc_v_dh]=geostro_2d_dh(cc_dh_anom,tt,ppres,ff);

cc_v=cc_v(:,length(km_x):end);
cc_v_dh=cc_v_dh(:,length(km_x):end);
cc_sigma=cc_sigma(:,length(km_x):end);
cc_dh_anom=cc_dh_anom(:,length(km_x):end);
cc_dh=cc_dh(:,length(km_x):end);


%cc_v_dh=cc_v_dh-.01;
fprintf('\n')
