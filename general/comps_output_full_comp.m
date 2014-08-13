function [compa,compc] = comps_output_full_comp(x,y,cyc,k,id,jdays,L,var,HEAD,METHOD);
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
% compa, compc = full 3D composite



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

load([HEAD,'2454069'],'lon','lat');
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
                load(['~/data/QuickScat/mat/QSCAT_30_25km_', num2str(ujd(m))],'sm_u_week','sm_v_week')
            else
                continue
            end
        case {'cw'}
            if exist(['~/data/QuickScat/mat/QSCAT_30_25km_', num2str(ujd(m)),'.mat'])
                load(['~/data/QuickScat/mat/QSCAT_30_25km_', num2str(ujd(m))],'sm_u_week','sm_v_week')
            else
                continue
            end
        case {'lw'}
            if exist(['~/data/QuickScat/mat/QSCAT_30_25km_', num2str(ujd(m)),'.mat'])
                load(['~/data/QuickScat/mat/QSCAT_30_25km_', num2str(ujd(m))],'sm_u_week','sm_v_week')
            else
                continue
            end
        case {'w'}
            if exist(['~/data/QuickScat/mat/QSCAT_30_25km_', num2str(ujd(m)),'.mat'])
                load(['~/data/QuickScat/mat/QSCAT_30_25km_', num2str(ujd(m))],'sm_u_week','sm_v_week')
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
                                %fprintf('\r  WIND DIRECTION IS %3u \r',round(thet+90))
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

clearallbut tcompa tcompc
compa=tcompa;compc=tcompc;