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

load chelle.pal
ujd=unique(jdays);
lj=length(ujd);
% Create indicies
ic = length(find(cyc<0));
ia = length(find(cyc>0));

% Create matrices to save jdays
xi=[-2:.125:2];
[XXII,YYII]=meshgrid(xi,xi);
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
load ~/data/QuickScat/schlax/mat/schlax_2452466.mat lon lat
[qlon,qlat]=meshgrid(lon,lat);
[lon,lat]=meshgrid(lon,lat);


for m=1:lj
    fprintf('\r  %s          compositing week %03u of %03u \r',var,m,lj)
    %load grad fields if requaired
    load(['~/data/QuickScat/schlax/mat/schlax_', num2str(ujd(m))],'sm_u_week','sm_v_week')
    
    load([HEAD num2str(ujd(m))],var);
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
            
            %                     if min(r)>0 & max(r)<length(lat(:,1)) & min(c)>0 & max(c)<length(lon(1,:))
            
            scene_lat = lat(r,c);
            scene_lon = lon(r,c);
            obs=data(r,c);
            %now normalize
            switch METHOD
                case {'w'}
                    irq = find(y(ii(pp))+.125 >= qlat(:,1) & y(ii(pp))-.125 <= qlat(:,1));
                    icq = find(x(ii(pp))+.125 >= qlon(1,:) & x(ii(pp))-.125 <= qlon(1,:));
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
                    
                    ndata=wgrid(double(scene_lon), ...
                        double(scene_lat), ...
                        double(x(ii(pp))), ...
                        double(y(ii(pp))), ...
                        double(obs), ...
                        double(-thet), ...
                        double(L(ii(pp))));
                    
                case {'n'}
                    ndata=zgrid2(double(scene_lon), ...
                        double(scene_lat), ...
                        double(x(ii(pp))), ...
                        double(y(ii(pp))), ...
                        double(obs), ...
                        double(L(ii(pp))));
                    
                    
%                     figure(1)
%                     clf
%                     subplot(211)
%                     pcolor(scene_lon,scene_lat,double(obs));shading flat;axis image;drawnow
%                     subplot(212)
%                     pcolor(XXII,YYII,ndata);shading flat;axis image;drawnow
%                     
%                     ll=L(ii(pp))
%                     xx=x(ii(pp))
%                     yy=y(ii(pp))
%                     save test_ndata scene_* obs ndata  ll xx yy
%                     return
%                     
            end
            
            
            if cyc(ii(pp))>0 && length(find(~isnan(ndata)))>0
                tcompa(:,:,zza)=single(ndata);
                jda(zza)=ujd(m);
                ka(zza)=k(ii(pp));
                ida(zza)=id(ii(pp));
                zza=zza+1;
                Na=Na+1;
            elseif cyc(ii(pp))<0 && length(find(~isnan(ndata)))>0
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

fprintf('\n')
