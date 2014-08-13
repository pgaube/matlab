function [compcc,compc] = comps_dir_grad(x,y,cyc,id,jdays,L,var,HEAD,METHOD);
%function [compcc,compc] = comps_dir_grad(x,y,cyc,id,jdays,L,var,METHOD);
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
[tcompaN,tcompaS]=deal(single(nan(M,M,ia)));
[tcompcN,tcompcS]=deal(single(nan(M,M,ic)));
rot_index=nan*x;

[zzaN,zzaS,zzcN,zzcS,Na_N,Na_S,Nc_N,Nc_S,N_count_a_cc,N_count_c_cc,N_count_a_c,N_count_c_c,...
    S_count_a_c,S_count_c_c,S_count_a_cc,S_count_c_cc]=deal(1);



%load lat lon matrices
load ~/data/gsm/mean_gchl mean_gchl mean_gcar glon glat
load([HEAD,'2454069'],'lon','lat');
switch HEAD
    case {'~/data/gsm/mat/GSM_9_21_'}
        load([HEAD,'2454069'],'glon','glat');
        lat=glat;
        lon=glon;
end




for m=1:lj
    fprintf('\r  %s          compositing week %03u of %03u \r',var,m,lj)
    %load grad fields if requaired
    switch METHOD
        case {'w'}
            if exist(['~/data/QuickScat/new_mat/QSCAT_30_25km_', num2str(ujd(m)),'.mat'])
                load(['~/data/QuickScat/new_mat/QSCAT_30_25km_', num2str(ujd(m))],'sm_u_week','sm_v_week','lon','lat')
                if exist('sm_u_week') & exist('sm_v_week')
                    grad_lon=glon;
                    grad_lat=glat;
                else
                    continue
                end
            else
                continue
            end
        case {'g','gdd','ag'}
            if exist(['~/data/gsm/mat/GSM_9_21_', num2str(ujd(m)),'.mat'])
                load(['~/data/gsm/mat/GSM_9_21_', num2str(ujd(m))],'sm_gchl_200_day','glon','glat')
                if exist('sm_gchl_200_day')
                    grad_field=flipud(sm_gchl_200_day);
                    grad_lon=glon;
                    grad_lat=flipud(glat);
                else
                    continue
                end
            else
                continue
            end
        case {'c'}
            if exist(['~/data/gsm/mat/GSM_9_21_', num2str(ujd(m)),'.mat'])
                load(['~/data/gsm/mat/GSM_9_21_', num2str(ujd(m))],'sm_gcar_200_day','glon','glat')
                if exist('sm_gcar_200_day')
                    grad_field=flipud(sm_gcar_200_day);
                    grad_lon=glon;
                    grad_lat=flipud(glat);
                else
                    continue
                end
            else
                continue
            end
        case {'t'}
            if exist(['~/data/ReynoldsSST/mat/OI_25_30_', num2str(ujd(m)),'.mat'])
                load(['~/data/ReynoldsSST/mat/OI_25_30_', num2str(ujd(m))],'sst_200_day','lon','lat')
                if exist('sst_200_day')
                    grad_field=sst_200_day;
                    grad_lon=lon;
                    grad_lat=lat;
                else
                    continue
                end
            else
                continue
            end
    end
    
    if exist([HEAD num2str(ujd(m)),'.mat'])
        load([HEAD num2str(ujd(m))],var,'lon','lat');
        switch HEAD
            case {'~/data/gsm/mat/GSM_9_21_'}
                load([HEAD,'2454069'],'glon','glat');
                lat=glat;
                lon=glon;
        end
        
        if exist(var)
            eval(['data = ' var ';'])
            ii=find(jdays==ujd(m));
            if any(ii)
                for pp=1:length(ii)
                    ir = find(y(ii(pp))+.125 >= lat(:,1) & y(ii(pp))-.125 <= lat(:,1));
                    ic = find(x(ii(pp))+.125 >= lon(1,:) & x(ii(pp))-.125 <= lon(1,:));
                    r=ir-20:ir+20;
                    c=ic-20:ic+20;
                    
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
                    
                    %
                    
                    
                    if min(r)>0 & max(r)<length(lat(:,1)) & min(c)>0 & max(c)<length(lon(1,:))
                        scene_lat = lat(r,c);
                        scene_lon = lon(r,c);
                        obs=data(r,c);
                        %now normalize
                        switch METHOD
                            case {'n'}
                                ndata=zgrid(double(scene_lon), ...
                                    double(scene_lat), ...
                                    double(x(ii(pp))), ...
                                    double(y(ii(pp))), ...
                                    double(obs), ...
                                    double(L(ii(pp))));
                                
                            case {'w'}
                                irq = find(y(ii(pp))+.125 >= grad_lat(:,1) & y(ii(pp))-.125 <= grad_lat(:,1));
                                icq = find(x(ii(pp))+.125 >= grad_lon(1,:) & x(ii(pp))-.125 <= grad_lon(1,:));
                                
                                rq=irq-8:irq+8;
                                cq=icq-8:icq+8;
                                %%check to see if on edge
                                %%near 0E
                                bad_c=find(cq<1);
                                if any(bad_c)
                                    %                                 display('on eastern edge of domain, truncating')
                                    cq=cq(bad_c(end)+1):cq(end);
                                end
                                
                                %%Near 360E
                                bad_c=find(cq>length(lon(1,:)));
                                if any(bad_c)
                                    %                                 display('on western edge of domain, truncating')
                                    cq=cq(1):cq(bad_c(1)-1);
                                end
                                
                                ubar=pmean(sm_u_week(rq,cq));
                                vbar=pmean(sm_v_week(rq,cq));
                                thet=rad2deg(cart2pol(ubar,vbar));
                                
                                if ~isnan(pmean(thet(:)))
                                    
                                    ndata=wgrid(double(scene_lon), ...
                                        double(scene_lat), ...
                                        double(x(ii(pp))), ...
                                        double(y(ii(pp))), ...
                                        double(obs), ...
                                        double(-thet), ...
                                        double(L(ii(pp))));
                                    
                                    %                                 ndata=wgrid(double(ttlon), ...
                                    %                                     double(ttlat), ...
                                    %                                     double(25), ...
                                    %                                     double(25), ...
                                    %                                     double(qquad), ...
                                    %                                     double(-thet), ...
                                    %                                     double(100));
                                else
                                    ndata=nan(M,M);
                                end
                                
                            case {'g','c','t'}
                                irq = find(y(ii(pp))+.125 >= grad_lat(:,1) & y(ii(pp))-.125 <= grad_lat(:,1));
                                icq = find(x(ii(pp))+.125 >= grad_lon(1,:) & x(ii(pp))-.125 <= grad_lon(1,:));
                                
                                rq=irq-8:irq+8;
                                cq=icq-8:icq+8;
                                %%check to see if on edge
                                %%near 0E
                                bad_c=find(cq<1);
                                if any(bad_c)
                                    %                                 display('on eastern edge of domain, truncating')
                                    cq=cq(bad_c(end)+1):cq(end);
                                end
                                
                                %%Near 360E
                                bad_c=find(cq>length(lon(1,:)));
                                if any(bad_c)
                                    %                                 display('on western edge of domain, truncating')
                                    cq=cq(1):cq(bad_c(1)-1);
                                end
                                
                                tmp_th=grad_field(rq,cq);
                                dx=1e5*dfdx(grad_lat(rq,cq),tmp_th,.25);
                                dy=1e5*dfdy(tmp_th,.25);
                                thet=single(rad2deg(cart2pol(pmean(dx(:)),pmean(dy(:)))));
                                thet2=thet;
                                
                                %rot index, N=1, S=-1
                                
                                if thet>=0
                                    thet=-(thet-90);
                                    rot_index=1;
                                else
                                    thet=-thet-90;
                                    rot_index=-1;
                                end
                                if ~isnan(nanmean(tmp_th(:)))
                                    ndata=wgrid(double(scene_lon), ...
                                        double(scene_lat), ...
                                        double(x(ii(pp))), ...
                                        double(y(ii(pp))), ...
                                        double(obs), ...
                                        double(thet), ...
                                        double(L(ii(pp))));
                                end
                                
                            case {'gdd'}
                                irq = find(y(ii(pp))+.125 >= grad_lat(:,1) & y(ii(pp))-.125 <= grad_lat(:,1));
                                icq = find(x(ii(pp))+.125 >= grad_lon(1,:) & x(ii(pp))-.125 <= grad_lon(1,:));
                                
                                rq=irq-8:irq+8;
                                cq=icq-8:icq+8;
                                %%check to see if on edge
                                %%near 0E
                                bad_c=find(cq<1);
                                if any(bad_c)
                                    %                                 display('on eastern edge of domain, truncating')
                                    cq=cq(bad_c(end)+1):cq(end);
                                end
                                
                                %%Near 360E
                                bad_c=find(cq>length(lon(1,:)));
                                if any(bad_c)
                                    %                                 display('on western edge of domain, truncating')
                                    cq=cq(1):cq(bad_c(1)-1);
                                end
                                
                                irg = find(y(ii(pp))+.125 >= glat(:,1) & y(ii(pp))-.125 <= glat(:,1));
                                icg = find(x(ii(pp))+.125 >= glon(1,:) & x(ii(pp))-.125 <= glon(1,:));
                                rg=irg-20:irg+20;
                                cg=icg-20:icg+20;
                                %%check to see if on edge
                                %%near 0E
                                bad_c=find(cg<1);
                                if any(bad_c)
                                    %                         display('on eastern edge of domain, truncating')
                                    cg=cg(bad_c(end)+1):cg(end);
                                end
                                
                                %%Near 360E
                                bad_c=find(cg>length(lon(1,:)));
                                if any(bad_c)
                                    %                         display('on western edge of domain, truncating')
                                    cg=cg(1):cg(bad_c(1)-1);
                                end
                                
                                %
                                
                                normer=10.^mean_gchl(rg,cg);
                                tmp_th=grad_field(rq,cq);
                                dx=1e5*dfdx(grad_lat(rq,cq),tmp_th,.25);
                                dy=1e5*dfdy(tmp_th,.25);
                                thet=single(rad2deg(cart2pol(pmean(dx(:)),pmean(dy(:)))));
                                thet2=thet;
                                
                                %rot index, N=1, S=-1
                                
                                if thet>=0
                                    thet=-(thet-90);
                                    rot_index=1;
                                else
                                    thet=-thet-90;
                                    rot_index=-1;
                                end
                                if ~isnan(nanmean(tmp_th(:)))
                                    ndata=wgrid_org(double(scene_lon), ...
                                        double(scene_lat), ...
                                        double(x(ii(pp))), ...
                                        double(y(ii(pp))), ...
                                        double(obs./normer), ...
                                        double(thet), ...
                                        double(L(ii(pp))));
%                                     pcomps_raw2(ndata,ndata,[-.1 .1],-100,.1,100,[''],1,30)
                                end
                                
                                case {'ag'}
                                irq = find(y(ii(pp))+.125 >= grad_lat(:,1) & y(ii(pp))-.125 <= grad_lat(:,1));
                                icq = find(x(ii(pp))+.125 >= grad_lon(1,:) & x(ii(pp))-.125 <= grad_lon(1,:));
                                
                                rq=irq-8:irq+8;
                                cq=icq-8:icq+8;
                                %%check to see if on edge
                                %%near 0E
                                bad_c=find(cq<1);
                                if any(bad_c)
                                    %                                 display('on eastern edge of domain, truncating')
                                    cq=cq(bad_c(end)+1):cq(end);
                                end
                                
                                %%Near 360E
                                bad_c=find(cq>length(lon(1,:)));
                                if any(bad_c)
                                    %                                 display('on western edge of domain, truncating')
                                    cq=cq(1):cq(bad_c(1)-1);
                                end
                                
                                irg = find(y(ii(pp))+.125 >= glat(:,1) & y(ii(pp))-.125 <= glat(:,1));
                                icg = find(x(ii(pp))+.125 >= glon(1,:) & x(ii(pp))-.125 <= glon(1,:));
                                rg=irg-20:irg+20;
                                cg=icg-20:icg+20;
                                %%check to see if on edge
                                %%near 0E
                                bad_c=find(cg<1);
                                if any(bad_c)
                                    %                         display('on eastern edge of domain, truncating')
                                    cg=cg(bad_c(end)+1):cg(end);
                                end
                                
                                %%Near 360E
                                bad_c=find(cg>length(lon(1,:)));
                                if any(bad_c)
                                    %                         display('on western edge of domain, truncating')
                                    cg=cg(1):cg(bad_c(1)-1);
                                end
                                
                                %
                                
                                tmp_th=grad_field(rq,cq);
                                dx=1e5*dfdx(grad_lat(rq,cq),tmp_th,.25);
                                dy=1e5*dfdy(tmp_th,.25);
                                thet=single(rad2deg(cart2pol(pmean(dx(:)),pmean(dy(:)))));
                                thet2=thet;
                                
                                %rot index, N=1, S=-1
                                
                                if thet>=0
                                    thet=-(thet-90);
                                    rot_index=1;
                                else
                                    thet=-thet-90;
                                    rot_index=-1;
                                end
                                if ~isnan(nanmean(tmp_th(:)))
                                    ndata=wgrid_org(double(scene_lon), ...
                                        double(scene_lat), ...
                                        double(x(ii(pp))), ...
                                        double(y(ii(pp))), ...
                                        double(abs(obs)), ...
                                        double(thet), ...
                                        double(L(ii(pp))));
%                                     pcomps_raw2(ndata,ndata,[-.1 .1],-100,.1,100,[''],1,30)
                                end
                        end
                        
                        if cyc(ii(pp))>0 & y(ii(pp))<0 | cyc(ii(pp))<0 & y(ii(pp))>0;
                            
                            if rot_index==1
                                tcompaN(:,:,zzaN)=single(ndata);
                                zzaN=zzaN+1;
                                Na_N=Na_N+1;
                                if cyc(ii(pp))==1
                                    N_count_a_cc=N_count_a_cc+1;
                                else
                                    N_count_c_cc=N_count_c_cc+1;
                                end
                            elseif rot_index==-1
                                tcompaS(:,:,zzaS)=single(ndata);
                                zzaS=zzaS+1;
                                Na_S=Na_S+1;
                                if cyc(ii(pp))==1
                                    S_count_a_cc=S_count_a_cc+1;
                                else
                                    S_count_c_cc=S_count_c_cc+1;
                                end
                            end
                        else
                            if rot_index==1
                                tcompcN(:,:,zzcN)=single(ndata);
                                zzcN=zzcN+1;
                                Nc_N=Nc_N+1;
                                if cyc(ii(pp))==1
                                    N_count_a_c=N_count_a_c+1;
                                else
                                    N_count_c_c=N_count_c_c+1;
                                end
                            elseif rot_index==-1
                                tcompcS(:,:,zzcS)=single(ndata);
                                zzcS=zzcS+1;
                                Nc_S=Nc_S+1;
                                if cyc(ii(pp))==1
                                    S_count_a_c=S_count_a_c+1;
                                else
                                    S_count_c_c=S_count_c_c+1;
                                end
                            end
                        end
                        %{
                           if(zza>1 &zzc>1)
                           figure(100)
                           clf
                           subplot(121)
                           pcolor(double(tcompc(:,:,zzc-1)));shading flat
                           subplot(122)
                           pcolor(double(tcompa(:,:,zza-1)));shading flat
                           drawnow
                           end
                        %}
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

clearallbut tcompaN tcompcN Na_N Nc_N tcompaS tcompcS Na_S Nc_S id cyc id M xi lj jda jdc ujd y rot_index N_count_a_c N_count_c_c N_count_a_cc N_count_c_cc S_count_a_c S_count_c_c S_count_a_cc S_count_c_cc
whos
% build structure array
mask_1=nan(M,M);
mask_05=mask_1;
[X,Y]=meshgrid(xi,xi);
dist=sqrt(X.^2+Y.^2);
mask_1(dist<=1)=1;
mask_05(dist<=0.5)=1;

compcc.N_count_a			= N_count_a_cc;
compcc.N_count_c			= N_count_c_cc;
compcc.S_count_a			= S_count_a_cc;
compcc.S_count_c			= S_count_c_cc;
compcc.N_median  			= double(nanmedian(tcompaN,3));
compcc.N_n_max_sample		= Na_N;
compcc.N_n_eddies		    = length(unique(id(find(cyc>0 & y<0 | cyc<0 & y>0 & rot_index>0))));
for r=1:length(tcompaS(:,1,1))
    for c=1:length(tcompaS(1,:,1))
        compcc.N_mean(r,c) = double(pmean(tcompaN(r,c,:)));
        compcc.N_std(r,c) = double(pstd(tcompaN(r,c,:)));
    end
end
compcc.S_median  			= double(nanmedian(tcompaS,3));
compcc.S_n_max_sample		= Na_S;
compcc.S_n_eddies		    = length(unique(id(find(cyc>0 & y<0 | cyc<0 & y>0 & rot_index<0))));
for r=1:length(tcompaS(:,1,1))
    for c=1:length(tcompaS(1,:,1))
        compcc.S_mean(r,c) = double(pmean(tcompaS(r,c,:)));
        compcc.S_std(r,c) = double(pstd(tcompaS(r,c,:)));
    end
end


compc.N_count_a			= N_count_a_c;
compc.N_count_c			= N_count_c_c;
compc.S_count_a			= S_count_a_c;
compc.S_count_c			= S_count_c_c;
compc.N_median  			= double(nanmedian(tcompcN,3));
compc.N_n_max_sample		= Nc_N;
compc.N_n_eddies		    = length(unique(id(find(cyc<0 & y<0 | cyc>0 & y>0 & rot_index>0))));
for r=1:length(tcompcN(:,1,1))
    for c=1:length(tcompcN(1,:,1))
        compc.N_mean(r,c) = double(pmean(tcompcN(r,c,:)));
        compc.N_std(r,c) = double(pstd(tcompaN(r,c,:)));
    end
end
compc.S_median  			= double(nanmedian(tcompcS,3));
compc.S_n_max_sample		= Nc_S;
compc.S_n_eddies		    = length(unique(id(find(cyc<0 & y<0 | cyc>0 & y>0 & rot_index<0))));
for r=1:length(tcompcS(:,1,1))
    for c=1:length(tcompcS(1,:,1))
        compc.S_mean(r,c) = double(pmean(tcompcS(r,c,:)));
        compc.S_std(r,c) = double(pstd(tcompcS(r,c,:)));
    end
end
fprintf('\n')
