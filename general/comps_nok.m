function [compa,compc] = comps(x,y,cyc,k,id,jdays,L,var,HEAD,METHOD);
%function [compa,compc] = comps(x,y,cyc,k,id,jdays,L,var,METHOD);
%
% Makes composites of the samples 'var'
%
% INPUT:
% x,y,cyc,jdays,L = from eddy file
% var = variable name to be loaded from file with path HEAD
% METHOD = how the varible is sampled, either 'n' or 'w'
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
ic = length(find(cyc<0));
ia = length(find(cyc>0));

% Create matrices to save jdays
xi=[-2:.125:2];
M=length(xi);
tcompa=single(nan(M,M,ia));
tcompc=single(nan(M,M,ic));
[jda,ka,ida]=deal(single(nan(ia,1)));
[jdc,kc,idc]=deal(single(nan(ic,1)));
zza=1;
zzc=1;
Na=0;
Nc=0;


%load lat lon matrices
load ~/data/gsm/mean_gchl mean_gchl mean_gcar glon glat
load ~/data/QuickSCAT/mat/QSCAT_30_25km_2451556.mat lon lat
qlon=lon;
qlat=lat;

load([HEAD,'2453901'],'lon','lat');
switch HEAD
    case {'~/data/gsm/mat/GSM_9_21_'}
        load([HEAD,'2454069'],'glon','glat');
        lat=glat;
        lon=glon;
    case {'~/data/gsm/larry_no_eddy_mat/GSM_9_21_'}
        load([HEAD,'2452025'],'glon','glat');
        lat=glat;
        lon=glon;
    case {'~/data/gsm/no_eddy_mat/GSM_9_21_'}
        load([HEAD,'2452025'],'glon','glat');
        lat=glat;
        lon=glon;    
end


for m=1:lj
    fprintf('\r  %s          compositing week %03u of %03u \r',var,m,lj)
    %load grad fields if requaired
    switch METHOD
        
        case {'ddw'}
            if exist(['~/data/QuickScat/mat/QSCAT_30_25km_', num2str(ujd(m)),'.mat'])
                load(['~/data/QuickScat/new_mat/QSCAT_30_25km_', num2str(ujd(m))],'sm_u_week','sm_v_week')
            else
                continue
            end
        case {'cw'}
            if exist(['~/data/QuickScat/mat/QSCAT_30_25km_', num2str(ujd(m)),'.mat'])
                load(['~/data/QuickScat/new_mat/QSCAT_30_25km_', num2str(ujd(m))],'sm_u_week','sm_v_week')
            else
                continue
            end
        case {'lw'}
            if exist(['~/data/QuickScat/mat/QSCAT_30_25km_', num2str(ujd(m)),'.mat'])
                load(['~/data/QuickScat/new_mat/QSCAT_30_25km_', num2str(ujd(m))],'sm_u_week','sm_v_week')
            else
                continue
            end
        case {'w'}
            if exist(['~/data/QuickScat/mat/QSCAT_30_25km_', num2str(ujd(m)),'.mat'])
                load(['~/data/QuickScat/new_mat/QSCAT_30_25km_', num2str(ujd(m))],'sm_u_week','sm_v_week')
            else
                continue
            end
    end
    if exist([HEAD num2str(ujd(m)),'.mat'])
        load([HEAD num2str(ujd(m))],var);
        if exist(var)
            eval(['data = ' var ';'])
            ii=find(jdays==ujd(m));
            if any(ii)
                for pp=1:length(ii)
                    ir = find(y(ii(pp))+.125 >= lat(:,1) & y(ii(pp))-.125 <= lat(:,1));
                    ic = find(x(ii(pp))+.125 >= lon(1,:) & x(ii(pp))-.125 <= lon(1,:));
                    r=ir-40:ir+40;
                    c=ic-40:ic+40;
                    
                    if min(r)>0 & max(r)<length(lat(:,1)) & min(c)>0 & max(c)<length(lon(1,:))
                        scene_lat = lat(r,c);
                        scene_lon = lon(r,c);
                        obs=data(r,c);
                        %now normalize
                        switch METHOD
                            case {'w'}
                                irq = find(y(ii(pp))+.125 >= qlat(:,1) & y(ii(pp))-.125 <= qlat(:,1));
                                icq = find(x(ii(pp))+.125 >= qlon(1,:) & x(ii(pp))-.125 <= qlon(1,:));
                                rq=irq-40:irq+40;
                                cq=icq-40:icq+40;
                                ubar=pmean(sm_u_week(rq(33:49),cq(33:49)));
                                vbar=pmean(sm_v_week(rq(33:49),cq(33:49)));
                                thet=rad2deg(cart2pol(ubar,vbar))-90; %makes 0 = E
%                                 fprintf('\r  WIND DIRECTION IS %3u \r',round(thet+90))
                                %wind_index(lay) = thet+90;
                                if ~isnan(pmean(thet(:)))
                                    if thet>=0
                                        thet=-(thet-90);
                                    else
                                        thet=-thet-90;
                                    end
                                    ndata=wgrid(double(scene_lon), ...
                                        double(scene_lat), ...
                                        double(x(ii(pp))), ...
                                        double(y(ii(pp))), ...
                                        double(obs), ...
                                        double(thet), ...
                                        double(L(ii(pp))));
                                else
                                    ndata=nan(M,M);
                                end
                            case {'ddw'}
                                irq = find(y(ii(pp))+.125 >= qlat(:,1) & y(ii(pp))-.125 <= qlat(:,1));
                                icq = find(x(ii(pp))+.125 >= qlon(1,:) & x(ii(pp))-.125 <= qlon(1,:));
                                rq=irq-40:irq+40;
                                cq=icq-40:icq+40;
                                
                                irg = find(y(ii(pp))+.125 >= glat(:,1) & y(ii(pp))-.125 <= glat(:,1));
                                icg = find(x(ii(pp))+.125 >= glon(1,:) & x(ii(pp))-.125 <= glon(1,:));
                                rg=irg-40:irg+40;
                                cg=icg-40:icg+40;
                                
                                
                                 ubar=pmean(sm_u_week(rq(33:49),cq(33:49)));
                                vbar=pmean(sm_v_week(rq(33:49),cq(33:49)));;
                                thet=rad2deg(cart2pol(ubar,vbar))-90; %makes 0 = E
                                %fprintf('\r  WIND DIRECTION IS %3u \r',round(thet+90))
                                %wind_index(lay) = thet+90;
                                if ~isnan(pmean(thet(:)))
                                    if thet>=0
                                        thet=-(thet-90);
                                    else
                                        thet=-thet-90;
                                    end
                                    normer=10.^mean_gchl(rg,cg);
                                    
                                    ndata=wgrid(double(scene_lon), ...
                                        double(scene_lat), ...
                                        double(x(ii(pp))), ...
                                        double(y(ii(pp))), ...
                                        double(obs./normer), ...
                                        double(thet), ...
                                        double(L(ii(pp))));
                                else
                                    ndata=nan(M,M);
                                end
                                
                            case {'lw'}
                                irq = find(y(ii(pp))+.125 >= qlat(:,1) & y(ii(pp))-.125 <= qlat(:,1));
                                icq = find(x(ii(pp))+.125 >= qlon(1,:) & x(ii(pp))-.125 <= qlon(1,:));
                                rq=irq-40:irq+40;
                                cq=icq-40:icq+40;
                                
                                irg = find(y(ii(pp))+.125 >= glat(:,1) & y(ii(pp))-.125 <= glat(:,1));
                                icg = find(x(ii(pp))+.125 >= glon(1,:) & x(ii(pp))-.125 <= glon(1,:));
                                rg=irg-40:irg+40;
                                cg=icg-40:icg+40;
                                
                                
                                ubar=pmean(sm_u_week(rq(33:49),cq(33:49)));
                                vbar=pmean(sm_v_week(rq(33:49),cq(33:49)));
                                thet=rad2deg(cart2pol(ubar,vbar))-90; %makes 0 = E
                                %fprintf('\r  WIND DIRECTION IS %3u \r',round(thet+90))
                                %wind_index(lay) = thet+90;
                                if ~isnan(pmean(thet(:)))
                                    if thet>=0
                                        thet=-(thet-90);
                                    else
                                        thet=-thet-90;
                                    end
                                    normer=mean_gchl(rg,cg);
                                    
                                    ndata=wgrid(double(scene_lon), ...
                                        double(scene_lat), ...
                                        double(x(ii(pp))), ...
                                        double(y(ii(pp))), ...
                                        double(obs./normer), ...
                                        double(thet), ...
                                        double(L(ii(pp))));
                                else
                                    ndata=nan(M,M);
                                end
                                
                            case {'cw'}
                                irq = find(y(ii(pp))+.125 >= qlat(:,1) & y(ii(pp))-.125 <= qlat(:,1));
                                icq = find(x(ii(pp))+.125 >= qlon(1,:) & x(ii(pp))-.125 <= qlon(1,:));
                                rq=irq-40:irq+40;
                                cq=icq-40:icq+40;
                                
                                irg = find(y(ii(pp))+.125 >= glat(:,1) & y(ii(pp))-.125 <= glat(:,1));
                                icg = find(x(ii(pp))+.125 >= glon(1,:) & x(ii(pp))-.125 <= glon(1,:));
                                rg=irg-40:irg+40;
                                cg=icg-40:icg+40;
                                
                                
                                ubar=pmean(sm_u_week(rq(33:49),cq(33:49)));
                                vbar=pmean(sm_v_week(rq(33:49),cq(33:49)));
                                thet=rad2deg(cart2pol(ubar,vbar))-90; %makes 0 = E
                                %fprintf('\r  WIND DIRECTION IS %3u \r',round(thet+90))
                                %wind_index(lay) = thet+90;
                                if ~isnan(pmean(thet(:)))
                                    if thet>=0
                                        thet=-(thet-90);
                                    else
                                        thet=-thet-90;
                                    end
                                    normer=10.^mean_gcar(rg,cg);
                                    
                                    ndata=wgrid(double(scene_lon), ...
                                        double(scene_lat), ...
                                        double(x(ii(pp))), ...
                                        double(y(ii(pp))), ...
                                        double(obs./normer), ...
                                        double(thet), ...
                                        double(L(ii(pp))));
                                else
                                    ndata=nan(M,M);
                                end
                                
                            case {'n'}
                                ndata=zgrid(double(scene_lon), ...
                                    double(scene_lat), ...
                                    double(x(ii(pp))), ...
                                    double(y(ii(pp))), ...
                                    double(obs), ...
                                    double(L(ii(pp))));
                                
                            case {'nlog'}
                                ndata=zgrid(double(scene_lon), ...
                                    double(scene_lat), ...
                                    double(x(ii(pp))), ...
                                    double(y(ii(pp))), ...
                                    double(log10(obs)), ...
                                    double(L(ii(pp))));    
                            case {'raw'}
                                ndata=grid_2_degree(double(obs));    
                                
                            case {'nn'}
                                rr=1:length(r);
                                cc=1:length(c);
                                
                                crr=rr(round(length(r)/2));
                                ccc=cc(round(length(c)/2));
                                ttp=obs(crr-3:crr+3,ccc-3:ccc+3);
                                
                                ndata=zgrid(double(scene_lon), ...
                                    double(scene_lat), ...
                                    double(x(ii(pp))), ...
                                    double(y(ii(pp))), ...
                                    double(obs./max(abs(ttp(:)))), ...
                                    double(L(ii(pp))));
                                
                            case {'dd'}
                                irg = find(y(ii(pp))+.125 >= glat(:,1) & y(ii(pp))-.125 <= glat(:,1));
                                icg = find(x(ii(pp))+.125 >= glon(1,:) & x(ii(pp))-.125 <= glon(1,:));
                                rg=irg-40:irg+40;
                                cg=icg-40:icg+40;
                                
                                normer=10.^mean_gchl(rg,cg);
                                
                                ndata=zgrid(double(scene_lon), ...
                                    double(scene_lat), ...
                                    double(x(ii(pp))), ...
                                    double(y(ii(pp))), ...
                                    double(obs./normer), ...
                                    double(L(ii(pp))));
                                
                        end
                        if cyc(ii(pp))>0;
                            tcompa(:,:,zza)=single(ndata);
                            jda(zza)=ujd(m);
                            ka(zza)=k(ii(pp));
                            ida(zza)=id(ii(pp));
                            zza=zza+1;
                            Na=Na+1;
                        else
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
            eval(['clear ',var])
        else
            continue
        end
    else
        continue
    end
end

clearallbut tcompa tcompc Na Nc id cyc id M xi lj jda jdc ujd ka kc ida idc

% build structure array
mask_1=nan(M,M);
mask_05=mask_1;
[X,Y]=meshgrid(xi,xi);
dist=sqrt(X.^2+Y.^2);
mask_1(dist<=1)=1;
mask_05(dist<=0.5)=1;

compa.median  			= double(nanmedian(tcompa,3));
%compa.mode	  			= nanmode(tcompa,3);
compa.n_max_sample		= Na;
compa.n_eddies		    = length(unique(id(find(cyc>0))));
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
        compa.ks_std_1(p)=pstd(tmp1);
        compa.ks_std_05(p)=pstd(tmp05);
        compa.ks_1(p)=pmean(tmp1);
        compa.ks_05(p)=pmean(tmp05);
        compa.ks_n(p)=length(ii);
    end
end

uaid=unique(ida);



%{
for p=1:12
	%ii=find(ka>=p-1 & ka<=p+1);
	ii=find(ka==p);
	if any(ii)
		compa.evol_median(:,:,p)=double(nanmedian(tcompa(:,:,ii),3));
	else
		compa.evol_median(:,:,p)=nan;
	end
end
%}
%Make Hists
mean_tcompa=nan(length(tcompa(1,1,:)),1);
for jfd=1:length(tcompa(1,1,:))
    tcompa(:,:,jfd)=tcompa(:,:,jfd).*mask_1;
    mean_tcompa(jfd)=pmean(tcompa(:,:,jfd));
end
compa.prctile_1=prctile(tcompa(:),[2.5 25 50 75 97.5 95]);
[compa.na_1,compa.bins]=hist(tcompa(:),18);
tcompa(tcompa<compa.prctile_1(1) | tcompa>compa.prctile_1(end))=nan;
[compa.na_1_thresh,compa.bins_thresh]=hist(tcompa(:),18);
[compa.na_mean_1,compa.bins_mean]=hist(mean_tcompa(:),12);

mean_tcompa=nan(length(tcompa(1,1,:)),1);
for jfd=1:length(tcompa(1,1,:))
    tcompa(:,:,jfd)=tcompa(:,:,jfd).*mask_05;
    mean_tcompa(jfd)=pmean(tcompa(:,:,jfd));
end
% compa.prctile_0563=prctile(tcompa(:),[2.5 25 50 75 97.5]);
% tcompa(tcompa<compa.prctile_1(1) | tcompa>compa.prctile_1(end))=nan;
% [compa.na_1,compa.bins]=hist(tcompa(:),40);
[compa.na_mean_05,compa.bins_mean]=hist(mean_tcompa(:),12);
[compa.na_abs_mean_05,compa.bins_abs_mean]=hist(abs(mean_tcompa(:)),12);
[compa.na_cent,compa.bins_cent]=hist(squeeze(tcompa(17,17,:)),18);
[compa.na_abs_cent,compa.bins_abs_cent]=hist(squeeze(abs(tcompa(17,17,:))),12);
[compa.na_1,compa.bins_na_1]=hist(squeeze(abs(tcompa(17,17,:))),12);
clear tcompa

compc.median  			= double(nanmedian(tcompc,3));
%compc.mode	  			= nanmode(tcompc,3);
compc.n_max_sample		= Nc;
compc.n_eddies		    = length(unique(id(find(cyc<0))));
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
            compc.ks_n(p)=length(ii);
        end
end
uaid=unique(idc);



%{
for p=1:12
	ii=find(kc==p);
	if any(ii)
		compc.evol_median(:,:,p)=double(nanmedian(tcompc(:,:,ii),3));
	else
		compc.evol_median(:,:,p)=nan;
	end
end
%}
%Make Hists
mean_tcompc=nan(length(tcompc(1,1,:)),1);
for jfd=1:length(tcompc(1,1,:))
    tcompc(:,:,jfd)=tcompc(:,:,jfd).*mask_1;
    mean_tcompc(jfd)=pmean(tcompc(:,:,jfd));
end
compc.prctile_1=prctile(tcompc(:),[2.5 25 50 75 97.5 95]);
[compc.nc_1,compc.bins]=hist(tcompc(:),18);
tcompc(tcompc<compc.prctile_1(1) | tcompc>compc.prctile_1(end))=nan;
[compc.nc_1_thresh,compc.bins_thresh]=hist(tcompc(:),18);
[compc.nc_mean_1,compc.bins_mean]=hist(mean_tcompc(:),12);

mean_tcompc=nan(length(tcompc(1,1,:)),1);
for jfd=1:length(tcompc(1,1,:))
    tcompc(:,:,jfd)=tcompc(:,:,jfd).*mask_05;
    mean_tcompc(jfd)=pmean(tcompc(:,:,jfd));
end
% compc.prctile_0563=prctile(tcompc(:),[2.5 25 50 75 97.5]);
% tcompc(tcompc<compc.prctile_1(1) | tcompc>compc.prctile_1(end))=nan;
% [compc.nc_1,compc.bins]=hist(tcompc(:),40);
[compc.nc_mean_05,compc.bins_mean]=hist(mean_tcompc(:),12);
[compc.nc_abs_mean_05,compc.bins_abs_mean]=hist(abs(mean_tcompc(:)),12);
[compc.nc_cent,compc.bins_cent]=hist(squeeze(tcompc(17,17,:)),12);
[compc.nc_abs_cent,compc.bins_abs_cent]=hist(squeeze(abs(tcompc(17,17,:))),12);
fprintf('\n')
