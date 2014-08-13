function [compa,compm,compc,compt] = pop_comps(x,y,cyc,k,id,jdays,L,adens,var,HEAD,level,derived,METHOD);
%function [compa,compc] = pop_compspop_comps(x,y,cyc,k,id,jdays,L,adens,var,HEAD,level,derived,METHOD);
%
% Makes composites of the samples 'var'
%
% INPUT:
% x,y,cyc,jdays, = from eddy file
% var = variable name to be loaded from file with path HEAD
% levle = z-level of pop output
% derived =1 if data is derived from pop, =0 if direct from pop
%
% OUTPUT:
% compa, compc = composites, these are structure files with the following
% 				 atributes:
%		mean
%		N
%		var
%		n_times_steps
%		n_max_samples
%		per_cov



ujd=unique(jdays);
lj=length(ujd);

% Create indicies
ic = length(find(cyc<0 & adens>0));
ia = length(find(cyc>0 & adens<0));
it = length(find(cyc<0 & adens<0));
im = length(find(cyc>0 & adens>0));

% Create matrices to save jdays
xi=[-2:.125:2];
rbins=0:.125:2;
M=length(xi);
tcompa=single(nan(M,M,ia));
tcompc=single(nan(M,M,ic));
tcompm=single(nan(M,M,im));
tcompt=single(nan(M,M,it));
[jda,ka,ida]=deal(single(nan(ia,1)));
[jdc,kc,idc]=deal(single(nan(ic,1)));
[jdm,km,idm]=deal(single(nan(im,1)));
[jdt,kt,idt]=deal(single(nan(it,1)));
zza=1;
zzc=1;
Na=0;
Nc=0;
zzm=1;
zzt=1;
Nm=0;
Nt=0;


%load lat lon matrices
load ~/matlab/pop/mat/pop_model_domain.mat lat lon z



for m=1:lj
    fname=[HEAD num2str(ujd(m)) '.' var];
    display([fname,' compositing week ',num2str(m),' of ',num2str(lj)])
    %test to see if we need to filter
    if derived==1
        switch var
            case('diaz_gr')
                fname=[HEAD num2str(ujd(m)) '.photoc_diaz_vint104'];
                if exist(fname)
                    pp=read_pop(HEAD,num2str(ujd(m)),'photoc_diaz_vint104',level);
                    bm=read_pop(HEAD,num2str(ujd(m)),'diazc_vint104',level);
                    data=pp./bm;
                    %                     chl=pp./bm;
                    %                     smchl=smoothn(chl,11000);
                    %                     smchl(smchl<0)=0;
                    %                     data=chl-smchl;
                end
            case('diat_gr')
                fname=[HEAD num2str(ujd(m)) '.photoc_diat_vint104'];
                if exist(fname)
                    pp=read_pop(HEAD,num2str(ujd(m)),'photoc_diat_vint104',level);
                    bm=read_pop(HEAD,num2str(ujd(m)),'diatc_vint104',level);
                    data=pp./bm;
                    %                     chl=pp./bm;
                    %                     smchl=smoothn(chl,11000);
                    %                     smchl(smchl<0)=0;
                    %                     data=chl-smchl;
                end
            case('small_gr')
                fname=[HEAD num2str(ujd(m)) '.photoc_sp_vint104'];
                if exist(fname)
                    pp=read_pop(HEAD,num2str(ujd(m)),'photoc_sp_vint104',level);
                    bm=read_pop(HEAD,num2str(ujd(m)),'spc_vint104',level);
                    data=pp./bm;
                    %                     chl=pp./bm;
                    %                     smchl=smoothn(chl,11000);
                    %                     smchl(smchl<0)=0;
                    %                     data=chl-smchl;
                end
            case('spc_anom')
                fname=[HEAD num2str(ujd(m)) '.spc_1to20'];
                if exist(fname)
                    chl=read_pop(HEAD,num2str(ujd(m)),'spc_1to20',level);
                    %                     c2=read_pop(HEAD,num2str(ujd(m)),'spc_vint104sm',level);
                    %                     data=c1-c2;
                    smchl=smoothn(chl,11000);
                    smchl(smchl<0)=0;
                    data=chl-smchl;
                    
                end
            case('diatc_anom')
                fname=[HEAD num2str(ujd(m)) '.ssh'];
                if exist(fname)
                    chl=read_pop(HEAD,num2str(ujd(m)),'diatc_1to20',level);
                    %                     c2=read_pop(HEAD,num2str(ujd(m)),'spc_vint104sm',level);
                    %                     data=c1-c2;
                    smchl=smoothn(chl,11000);
                    smchl(smchl<0)=0;
                    data=chl-smchl;
                    
                end
            case('diazc_anom')
                fname=[HEAD num2str(ujd(m)) '.ssh'];
                if exist(fname)
                    chl=read_pop(HEAD,num2str(ujd(m)),'diazc_1to20',level);
                    %                     c2=read_pop(HEAD,num2str(ujd(m)),'spc_vint104sm',level);
                    %                     data=c1-c2;
                    smchl=smoothn(chl,11000);
                    smchl(smchl<0)=0;
                    data=chl-smchl;
                    
                end
            case('spc_vint_anom')
                fname=[HEAD num2str(ujd(m)) '.ssh'];
                if exist(fname)
                    chl=read_pop(HEAD,num2str(ujd(m)),'spc_vint104',level);
                    %                     c2=read_pop(HEAD,num2str(ujd(m)),'spc_vint104sm',level);
                    %                     data=c1-c2;
                    smchl=smoothn(chl,11000);
                    smchl(smchl<0)=0;
                    data=chl-smchl;
                    
                end
            case('diatc_vint_anom')
                fname=[HEAD num2str(ujd(m)) '.ssh'];
                if exist(fname)
                    chl=read_pop(HEAD,num2str(ujd(m)),'diatc_vint104',level);
                    
                    %                     c2=read_pop(HEAD,num2str(ujd(m)),'diatc_vint104sm',level);
                    %                     data=c1-c2;
                    smchl=smoothn(chl,11000);
                    smchl(smchl<0)=0;
                    data=chl-smchl;
                end
            case('diazc_vint_anom')
                fname=[HEAD num2str(ujd(m)) '.ssh'];
                if exist(fname)
                    chl=read_pop(HEAD,num2str(ujd(m)),'diazc_vint104',level);
                    %                     c2=read_pop(HEAD,num2str(ujd(m)),'diazc_vint104sm',level);
                    %                     data=c1-c2;
                    smchl=smoothn(chl,11000);
                    smchl(smchl<0)=0;
                    data=chl-smchl;
                end
            case('hp66_chl')
                fname=[HEAD num2str(ujd(m)) '.spchl_1'];
                if exist(fname)
                    c1=read_pop(HEAD,num2str(ujd(m)),'spchl_1',level);
                    c2=read_pop(HEAD,num2str(ujd(m)),'diatchl_1',level);
                    c3=read_pop(HEAD,num2str(ujd(m)),'diazchl_1',level);
                    chl=c1+c2+c3;
                    smchl=smoothn(chl,11000);
                    smchl(smchl<0)=0;
                    data=chl-smchl;
                end
            case('hp66_car')
                fname=[HEAD num2str(ujd(m)) '.spchl_1'];
                if exist(fname)
                    c1=read_pop(HEAD,num2str(ujd(m)),'diazc_vint104',level);
                    c2=read_pop(HEAD,num2str(ujd(m)),'diatc_vint104',level);
                    c3=read_pop(HEAD,num2str(ujd(m)),'spc_vint104',level);
                    chl=c1+c2+c3;
                    smchl=smoothn(chl,11000);
                    smchl(smchl<0)=0;
                    data=chl-smchl;
                end
            case('hp66_small_chl')
                fname=[HEAD num2str(ujd(m)) '.spchl_1'];
                if exist(fname)
                    chl=read_pop(HEAD,num2str(ujd(m)),'spchl_1',level);
                    smchl=smoothn(chl,11000);
                    smchl(smchl<0)=0;
                    data=chl-smchl;
                end
            case('hp66_diat_chl')
                fname=[HEAD num2str(ujd(m)) '.diatchl_1'];
                if exist(fname)
                    chl=read_pop(HEAD,num2str(ujd(m)),'diatchl_1',level);
                    smchl=smoothn(chl,11000);
                    smchl(smchl<0)=0;
                    data=chl-smchl;
                end
            case('hp66_diaz_chl')
                fname=[HEAD num2str(ujd(m)) '.diazchl_1'];
                if exist(fname)
                    chl=read_pop(HEAD,num2str(ujd(m)),'diazchl_1',level);
                    smchl=smoothn(chl,11000);
                    smchl(smchl<0)=0;
                    data=chl-smchl;
                end
            case('sla')
                fname=[HEAD num2str(ujd(m)) '.ssh'];
                if exist(fname)
                    c1=read_pop(HEAD,num2str(ujd(m)),'ssh',level);
                    c2=read_pop(HEAD,num2str(ujd(m)),'ssh_sm',level);
                    data=c1-c2;
                end
            case('pdensa')
                fname=[HEAD num2str(ujd(m)) '.temp_1to20'];
                if exist(fname)
                    c1=read_pop(HEAD,num2str(ujd(m)),'temp_1to20',level);
                    c2=read_pop(HEAD,num2str(ujd(m)),'salt_1to20',level);
                    den=pop2_state(c1,c2,z(level))-1000;
                    smdens=smoothn(den,11000);
                    data=den-smdens;
                end
                
            case('crl')
                fname=[HEAD num2str(ujd(m)) '.uvel_1to20'];
                if exist(fname)
                    c1=read_pop(HEAD,num2str(ujd(m)),'uvel_1to20',level);
                    c2=read_pop(HEAD,num2str(ujd(m)),'vvel_1to20',level);
                    data=dfdx(lat,c2,.1)-dfdy(c1,.1);
                end
        end
    elseif derived==0
        if exist(fname)
            data=read_pop(HEAD,num2str(ujd(m)),var,level);
        else
            continue
        end
    end
    ii=find(jdays==ujd(m));
    if any(ii)
        for pp=1:length(ii)
            [ir,ic] = imap(y(ii(pp))-.05,y(ii(pp))+.05,x(ii(pp))-.05,x(ii(pp))+.05,lat,lon);
            r=ir-100:ir+100;
            c=ic-100:ic+100;
            %%check to see if on edge
            %%near 0E
            bad_c=find(c<1);
            if any(bad_c)
                %                         display('on eastern edge of domain, truncating')
                c=c(bad_c(end)+1):c(end);
            end
            
            %%Near 360E
            bad_c=find(c>length(lon(1,:)));
            if any(bad_c)
                %                         display('on western edge of domain, truncating')
                c=c(1):c(bad_c(1)-1);
            end
            if min(r)>0 & max(r)<length(lat(:,1)) & min(c)>0 & max(c)<length(lon(1,:))
                scene_lat = lat(r,c);
                scene_lon = lon(r,c);
                ndata=zgrid(double(scene_lon), ...
                    double(scene_lat), ...
                    double(x(ii(pp))), ...
                    double(y(ii(pp))), ...
                    double(data(r,c)), ...
                    double(L(ii(pp))));
                %                     figure(1)
                %                     clf
                %                     pcolor(lon(r,c),lat(r,c),double(ndata));shading flat;axis image
                %                     hold on
                %                     plot(x(ii(pp)),y(ii(pp)),'k.','markersize',30)
                %                     drawnow
                
                if cyc(ii(pp))>0 & adens(ii(pp))<0;
                    tcompa(:,:,zza)=single(ndata);
                    jda(zza)=ujd(m);
                    ka(zza)=k(ii(pp));
                    ida(zza)=id(ii(pp));
                    zza=zza+1;
                    Na=Na+1;
                elseif cyc(ii(pp))>0 & adens(ii(pp))>0;
                    tcompm(:,:,zzm)=single(ndata);
                    jdm(zzm)=ujd(m);
                    km(zzm)=k(ii(pp));
                    idm(zzm)=id(ii(pp));
                    zzm=zzm+1;
                    Nm=Nm+1;
                elseif cyc(ii(pp))<0 & adens(ii(pp))<0;
                    tcompt(:,:,zzt)=single(ndata);
                    jdt(zzt)=ujd(m);
                    kt(zzt)=k(ii(pp));
                    idt(zzt)=id(ii(pp));
                    zzt=zzt+1;
                    Nt=Nt+1;
                elseif cyc(ii(pp))<0 & adens(ii(pp))>0;
                    tcompc(:,:,zzc)=single(ndata);
                    jdc(zzc)=ujd(m);
                    kc(zzc)=k(ii(pp));
                    idc(zzc)=id(ii(pp));
                    zzc=zzc+1;
                    Nc=Nc+1;
                end
            end
        end
    end
end





clearallbut rbins adens tcompa tcompm tcompt tcompc Na Nc Nm Nt id cyc id M xi lj jda jdc jdm jdt ujd ka kc km kt idm idt ida idc

% build structure array
mask_1=nan(M,M);
mask_05=mask_1;
[X,Y]=meshgrid(xi,xi);
dist=sqrt(X.^2+Y.^2);
mask_1(dist<=1)=1;
mask_05(dist<=.5)=1;

compa.rbins=rbins(1:end-1);
compm.rbins=rbins(1:end-1);
compc.rbins=rbins(1:end-1);
compt.rbins=rbins(1:end-1);

%%anticyclones
if length(tcompa(1,1,:))>1
    compa.median  			= double(nanmedian(tcompa,3));
    %compa.mode	  			= nanmode(tcompa,3);
    compa.n_max_sample		= Na;
    compa.n_eddies		    = length(unique(id(find(cyc>0 & adens<0))));
    for r=1:length(tcompa(:,1,1))
        for c=1:length(tcompa(1,:,1))
            compa.mean(r,c) = double(pmean(tcompa(r,c,:)));
            compa.n(r,c)    = length(find(~isnan(tcompa(r,c,:))));
            compa.std(r,c) = double(pstd(tcompa(r,c,:)));
        end
    end
    %make time series
    for p=1:lj
        ii=find(jda==ujd(p));
        compa.ts_1(p)=pmean(squeeze(nanmean(tcompa(:,:,ii),3)).*mask_1);
        compa.ts_05(p)=pmean(squeeze(nanmean(tcompa(:,:,ii),3)).*mask_05);
        compa.ts_n(p)=length(ii);
    end
    
    for p=1:40
        ii=find(ka==p);
        if any(ii)
            tmp1=nan*tcompa(:,:,ii);
            tmp05=tmp1;
            for fr=1:length(ii)
                tmp1(:,:,fr)=tcompa(:,:,ii(fr)).*mask_1;
                tmp05(:,:,fr)=tcompa(:,:,ii(fr)).*mask_05;
            end
            compa.ks_std_1(p)=pstd(squeeze(nanmean(nanmean(tmp1,1),2)));
            compa.ks_std_05(p)=pstd(squeeze(nanmean(nanmean(tmp05,1),2)));
            compa.ks_1(p)=pmean(tmp1);
            compa.ks_05(p)=pmean(tmp05);
            compa.ks_c(p)=pmean(tcompa(17,17,ii));
            compa.ks_n(p)=length(ii);

        end
    end
    
    %Integrate values from means for each k
    compa.k_means=nan(M,M,40);
    for p=1:40
        ii=find(ka==p);
        if any(ii)
            compa.k_medians(:,:,p)=double(nanmedian(tcompa(:,:,ii),3));
            compa.k_means(:,:,p)=double(nanmean(tcompa(:,:,ii),3));
        end
        compa.integrated_means=nansum(compa.k_means,3);
        compa.integrated_medians=nansum(compa.k_medians,3);
    end
    
    %Make azimuthal average
    for rb=1:length(rbins)-1
        ir=find(dist>=rbins(rb) & dist<rbins(rb+1));
        mask=nan*dist;
        mask(ir)=1;
        tmp_az=nan*tcompa;
            for fr=1:length(tmp_az(1,1,:))
                tmp_az(:,:,fr)=tcompa(:,:,fr).*mask;
            end
        compa.az_av(rb)=pmean(tmp_az);
        compa.az_av_std(rb)=pstd(tmp_az);
        compa.ax_av_n(rb)=Na;
    end
    
    %Make Hists
    mean_tcompa=nan(length(tcompa(1,1,:)),1);
    for jfd=1:length(tcompa(1,1,:))
        tcompa(:,:,jfd)=tcompa(:,:,jfd).*mask_1;
        mean_tcompa(jfd)=pmean(tcompa(:,:,jfd));
    end
    compa.prctile_1=prctile(tcompa(:),[2.5 25 50 75 97.5 95]);
    tcompa(tcompa<compa.prctile_1(1) | tcompa>compa.prctile_1(end))=nan;
    [compa.na_1,compa.bins]=hist(tcompa(:),40);
    [compa.na_mean_1,compa.bins_mean]=hist(mean_tcompa(:),40);
    
    mean_tcompa=nan(length(tcompa(1,1,:)),1);
    for jfd=1:length(tcompa(1,1,:))
        tcompa(:,:,jfd)=tcompa(:,:,jfd).*mask_05;
        mean_tcompa(jfd)=pmean(tcompa(:,:,jfd));
    end
    [compa.na_mean_05,compa.bins_mean]=hist(mean_tcompa(:),40);
    [compa.na_abs_mean_05,compa.bins_abs_mean]=hist(abs(mean_tcompa(:)),40);
    [compa.na_cent,compa.bins_cent]=hist(squeeze(tcompa(17,17,:)),40);
    [compa.na_abs_cent,compa.bins_abs_cent]=hist(squeeze(abs(tcompa(17,17,:))),40);
else
    compa.mean=nan;
end

clear tcompa

%%MWE
if length(tcompm(1,1,:))>1
    compm.median  			= double(nanmedian(tcompm,3));
    %compm.mode	  			= nanmode(tcompm,3);
    compm.n_max_sample		= Nm;
    compm.n_eddies		    = length(unique(id(find(cyc>0 & adens>0))));
    for r=1:length(tcompm(:,1,1))
        for c=1:length(tcompm(1,:,1))
            compm.mean(r,c) = double(pmean(tcompm(r,c,:)));
            compm.n(r,c)    = length(find(~isnan(tcompm(r,c,:))));
            compm.std(r,c) = double(pstd(tcompm(r,c,:)));
        end
    end
    %make time series
    for p=1:lj
        ii=find(jdm==ujd(p));
        compm.ts_1(p)=pmean(squeeze(nanmean(tcompm(:,:,ii),3)).*mask_1);
        compm.ts_05(p)=pmean(squeeze(nanmean(tcompm(:,:,ii),3)).*mask_05);
        compm.ts_n(p)=length(ii);
    end
    
    for p=1:40
        ii=find(km==p);
        if any(ii)
            tmp1=nan*tcompm(:,:,ii);
            tmp05=tmp1;
            for fr=1:length(ii)
                tmp1(:,:,fr)=tcompm(:,:,ii(fr)).*mask_1;
                tmp05(:,:,fr)=tcompm(:,:,ii(fr)).*mask_05;
            end
            compm.ks_std_1(p)=pstd(squeeze(nanmean(nanmean(tmp1,1),2)));
            compm.ks_std_05(p)=pstd(squeeze(nanmean(nanmean(tmp05,1),2)));
            compm.ks_1(p)=pmean(tmp1);
            compm.ks_05(p)=pmean(tmp05);
            compm.ks_c(p)=pmean(tcompm(17,17,ii));
            compm.ks_n(p)=length(ii);
        end
    end
    
    %Integrate values from means for each k
    compm.k_means=nan(M,M,40);
    for p=1:40
        ii=find(km==p);
        if any(ii)
            compm.k_medians(:,:,p)=double(nanmedian(tcompm(:,:,ii),3));
            compm.k_means(:,:,p)=double(nanmean(tcompm(:,:,ii),3));
        end
        compm.integrated_means=nansum(compm.k_means,3);
        compm.integrated_medians=nansum(compm.k_medians,3);
    end
    %Make azimuthal average
    for rb=1:length(rbins)-1
        ir=find(dist>=rbins(rb) & dist<rbins(rb+1));
        mask=nan*dist;
        mask(ir)=1;
        tmp_az=nan*tcompm;
            for fr=1:length(tmp_az(1,1,:))
                tmp_az(:,:,fr)=tcompm(:,:,fr).*mask;
            end
        compm.az_av(rb)=pmean(tmp_az);
        compm.az_av_std(rb)=pstd(tmp_az);
        compm.ax_av_n(rb)=Nm;
    end
    
    %Make Hists
    mean_tcompm=nan(length(tcompm(1,1,:)),1);
    for jfd=1:length(tcompm(1,1,:))
        tcompm(:,:,jfd)=tcompm(:,:,jfd).*mask_1;
        mean_tcompm(jfd)=pmean(tcompm(:,:,jfd));
    end
    compm.prctile_1=prctile(tcompm(:),[2.5 25 50 75 97.5 95]);
    tcompm(tcompm<compm.prctile_1(1) | tcompm>compm.prctile_1(end))=nan;
    [compm.na_1,compm.bins]=hist(tcompm(:),40);
    [compm.na_mean_1,compm.bins_mean]=hist(mean_tcompm(:),40);
    
    mean_tcompm=nan(length(tcompm(1,1,:)),1);
    for jfd=1:length(tcompm(1,1,:))
        tcompm(:,:,jfd)=tcompm(:,:,jfd).*mask_05;
        mean_tcompm(jfd)=pmean(tcompm(:,:,jfd));
    end
    % compm.prctile_0563=prctile(tcompm(:),[2.5 25 50 75 97.5]);
    % tcompm(tcompm<compm.prctile_1(1) | tcompm>compm.prctile_1(end))=nan;
    % [compm.na_1,compm.bins]=hist(tcompm(:),40);
    [compm.na_mean_05,compm.bins_mean]=hist(mean_tcompm(:),40);
    [compm.na_abs_mean_05,compm.bins_abs_mean]=hist(abs(mean_tcompm(:)),40);
    [compm.na_cent,compm.bins_cent]=hist(squeeze(tcompm(17,17,:)),40);
    [compm.na_abs_cent,compm.bins_abs_cent]=hist(squeeze(abs(tcompm(17,17,:))),40);
else
    compm.mean=nan;
end
clear tcompm

%%cyclones
if length(tcompc(1,1,:))>1
    compc.median  			= double(nanmedian(tcompc,3));
    %compc.mode	  			= nanmode(tcompc,3);
    compc.n_max_sample		= Nc;
    compc.n_eddies		    = length(unique(id(find(cyc<0 & adens>0))));
    for r=1:length(tcompc(:,1,1))
        for c=1:length(tcompc(1,:,1))
            compc.mean(r,c) = double(pmean(tcompc(r,c,:)));
            compc.n(r,c)    = length(find(~isnan(tcompc(r,c,:))));
            compc.std(r,c) = double(pstd(tcompc(r,c,:)));
        end
    end
    %make time series
    for p=1:lj
        ii=find(jdc==ujd(p));
        compc.ts_1(p)=pmean(squeeze(nanmean(tcompc(:,:,ii),3)).*mask_1);
        compc.ts_05(p)=pmean(squeeze(nanmean(tcompc(:,:,ii),3)).*mask_05);
        compc.ts_n(p)=length(ii);
    end
    
    for p=1:40
        ii=find(kc==p);
        if any(ii)
            tmp1=nan*tcompc(:,:,ii);
            tmp05=tmp1;
            for fr=1:length(ii)
                tmp1(:,:,fr)=tcompc(:,:,ii(fr)).*mask_1;
                tmp05(:,:,fr)=tcompc(:,:,ii(fr)).*mask_05;
            end
            compc.ks_std_1(p)=pstd(tmp1);
            compc.ks_std_05(p)=pstd(tmp05);
            compc.ks_1(p)=pmean(tmp1);
            compc.ks_05(p)=pmean(tmp05);
            compc.ks_c(p)=pmean(tcompc(17,17,ii));
            compc.ks_n(p)=length(ii);
        end
    end
    
    %Integrate values from means for each k
    compc.k_means=nan(M,M,40);
    for p=1:40
        ii=find(kc==p);
        if any(ii)
            compc.k_medians(:,:,p)=double(nanmedian(tcompc(:,:,ii),3));
            compc.k_means(:,:,p)=double(nanmean(tcompc(:,:,ii),3));
        end
        compc.integrated_means=nansum(compc.k_means,3);
        compc.integrated_medians=nansum(compc.k_medians,3);
    end
    
    %Make azimuthal average
    for rb=1:length(rbins)-1
        ir=find(dist>=rbins(rb) & dist<rbins(rb+1));
        mask=nan*dist;
        mask(ir)=1;
        tmp_az=nan*tcompc;
            for fr=1:length(tmp_az(1,1,:))
                tmp_az(:,:,fr)=tcompc(:,:,fr).*mask;
            end
        compc.az_av(rb)=pmean(tmp_az);
        compc.az_av_std(rb)=pstd(tmp_az);
        compc.ax_av_n(rb)=Nc;
    end
    
    %Make Hists
    mean_tcompc=nan(length(tcompc(1,1,:)),1);
    for jfd=1:length(tcompc(1,1,:))
        tcompc(:,:,jfd)=tcompc(:,:,jfd).*mask_1;
        mean_tcompc(jfd)=pmean(tcompc(:,:,jfd));
    end
    compc.prctile_1=prctile(tcompc(:),[2.5 25 50 75 97.5 95]);
    tcompc(tcompc<compc.prctile_1(1) | tcompc>compc.prctile_1(end))=nan;
    [compc.na_1,compc.bins]=hist(tcompc(:),40);
    [compc.na_mean_1,compc.bins_mean]=hist(mean_tcompc(:),40);
    
    mean_tcompc=nan(length(tcompc(1,1,:)),1);
    for jfd=1:length(tcompc(1,1,:))
        tcompc(:,:,jfd)=tcompc(:,:,jfd).*mask_05;
        mean_tcompc(jfd)=pmean(tcompc(:,:,jfd));
    end
    [compc.na_mean_05,compc.bins_mean]=hist(mean_tcompc(:),40);
    [compc.na_abs_mean_05,compc.bins_abs_mean]=hist(abs(mean_tcompc(:)),40);
    [compc.na_cent,compc.bins_cent]=hist(squeeze(tcompc(17,17,:)),40);
    [compc.na_abs_cent,compc.bins_abs_cent]=hist(squeeze(abs(tcompc(17,17,:))),40);
else
    compc.mean=nan;
end
clear tcompc

%%thinnies
if length(tcompt(1,1,:))>1
    compt.median  			= double(nanmedian(tcompt,3));
    %compt.mode	  			= nanmode(tcompt,3);
    compt.n_max_sample		= Nc;
    compt.n_eddies		    = length(unique(id(find(cyc<0 & adens<0))));
    for r=1:length(tcompt(:,1,1))
        for c=1:length(tcompt(1,:,1))
            compt.mean(r,c) = double(pmean(tcompt(r,c,:)));
            compt.n(r,c)    = length(find(~isnan(tcompt(r,c,:))));
            compt.std(r,c) = double(pstd(tcompt(r,c,:)));
        end
    end
    %make time series
    for p=1:lj
        ii=find(jdt==ujd(p));
        compt.ts_1(p)=pmean(squeeze(nanmean(tcompt(:,:,ii),3)).*mask_1);
        compt.ts_05(p)=pmean(squeeze(nanmean(tcompt(:,:,ii),3)).*mask_05);
        compt.ts_n(p)=length(ii);
    end
    
    %Integrate values from means for each k
    compt.k_means=nan(M,M,40);
    for p=1:40
        ii=find(kt==p);
        if any(ii)
            compt.k_medians(:,:,p)=double(nanmedian(tcompt(:,:,ii),3));
            compt.k_means(:,:,p)=double(nanmean(tcompt(:,:,ii),3));
        end
        compt.integrated_means=nansum(compt.k_means,3);
        compt.integrated_medians=nansum(compt.k_medians,3);
    end
    
    for p=1:40
        ii=find(kt==p);
        if any(ii)
            tmp1=nan*tcompt(:,:,ii);
            tmp05=tmp1;
            for fr=1:length(ii)
                tmp1(:,:,fr)=tcompt(:,:,ii(fr)).*mask_1;
                tmp05(:,:,fr)=tcompt(:,:,ii(fr)).*mask_05;
            end
            compt.ks_std_1(p)=pstd(tmp1);
            compt.ks_std_05(p)=pstd(tmp05);
            compt.ks_1(p)=pmean(tmp1);
            compt.ks_05(p)=pmean(tmp05);
            compt.ks_c(p)=pmean(tcompt(17,17,ii));
            compt.ks_n(p)=length(ii);
        end
    end
    
    %Make azimuthal average
    for rb=1:length(rbins)-1
        ir=find(dist>=rbins(rb) & dist<rbins(rb+1));
        mask=nan*dist;
        mask(ir)=1;
        tmp_az=nan*tcompt;
            for fr=1:length(tmp_az(1,1,:))
                tmp_az(:,:,fr)=tcompt(:,:,fr).*mask;
            end
        compt.az_av(rb)=pmean(tmp_az);
        compt.az_av_std(rb)=pstd(tmp_az);
        compt.ax_av_n(rb)=Nt;
    end
    
    %Make Hists
    mean_tcompt=nan(length(tcompt(1,1,:)),1);
    for jfd=1:length(tcompt(1,1,:))
        tcompt(:,:,jfd)=tcompt(:,:,jfd).*mask_1;
        mean_tcompt(jfd)=pmean(tcompt(:,:,jfd));
    end
    compt.prctile_1=prctile(tcompt(:),[2.5 25 50 75 97.5 95]);
    tcompt(tcompt<compt.prctile_1(1) | tcompt>compt.prctile_1(end))=nan;
    [compt.na_1,compt.bins]=hist(tcompt(:),40);
    [compt.na_mean_1,compt.bins_mean]=hist(mean_tcompt(:),40);
    
    mean_tcompt=nan(length(tcompt(1,1,:)),1);
    for jfd=1:length(tcompt(1,1,:))
        tcompt(:,:,jfd)=tcompt(:,:,jfd).*mask_05;
        mean_tcompt(jfd)=pmean(tcompt(:,:,jfd));
    end
    [compt.na_mean_05,compt.bins_mean]=hist(mean_tcompt(:),40);
    [compt.na_abs_mean_05,compt.bins_abs_mean]=hist(abs(mean_tcompt(:)),40);
    [compt.na_cent,compt.bins_cent]=hist(squeeze(tcompt(17,17,:)),40);
    [compt.na_abs_cent,compt.bins_abs_cent]=hist(squeeze(abs(tcompt(17,17,:))),40);
else
    compt.mean=nan;
end
clear tcompt
fprintf('\n')
