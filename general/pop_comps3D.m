function [compa,compc] = pop_comps3D(x,y,cyc,k,id,L,jdays,var);
%function [compa,compc] = pop_comps3D(x,y,cyc,k,id,L,jdays,var);
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
ic = length(find(cyc<0));
ia = length(find(cyc>0));

% Create matrices to save jdays
xi=[-2:.125:2];
M=length(xi);
tcompa=single(nan(M,M,20,ia));
tcompc=single(nan(M,M,20,ic));
[jda,ka,ida]=deal(single(nan(ia,1)));
[jdc,kc,idc]=deal(single(nan(ic,1)));
zza=1;
zzc=1;
Na=0;
Nc=0;


%load lat lon matrices
load ~/matlab/pop/mat/pop_model_domain.mat lat lon z

HEAD='~/matlab/pop/mat/run14_';

for m=1:lj
    fname=[HEAD num2str(ujd(m))];
    display([var,' compositing week ',num2str(m),' of ',num2str(lj)])
    %test to see if we need to filter
    if exist([fname,'.mat'])
        load(fname,var);
        eval(['data=',var,';']);
    else
        continue
    end
    
    ii=find(jdays==ujd(m));
    if any(ii)
        for pp=1:length(ii)
            [ir,ic] = imap(y(ii(pp))-.05,y(ii(pp))+.05,x(ii(pp))-.05,x(ii(pp))+.05,lat,lon);
            r=ir-20:ir+20;
            c=ic-20:ic+20;
            
            if min(r)>0 & max(r)<length(lat(:,1)) & min(c)>0 & max(c)<length(lon(1,:))
                scene_lat = lat(r,c);
                scene_lon = lon(r,c);
                tdata=data(r,c,:);
                ndata=nan(M,M,length(tdata(1,1,:)));
                for rr=1:length(tdata(1,1,:))
                    ndata(:,:,rr)=zgrid(double(scene_lon), ...
                            double(scene_lat), ...
                            double(x(ii(pp))), ...
                            double(y(ii(pp))), ...
                            double(data(r,c,rr)), ...
                            double(L(ii(pp))));
                end
                %                     figure(1)
                %                     clf
                %                     pcolor(lon(r,c),lat(r,c),double(ndata));shading flat;axis image
                %                     hold on
                %                     plot(x(ii(pp)),y(ii(pp)),'k.','markersize',30)
                %                     drawnow
                
                if cyc(ii(pp))>0;
                    tcompa(:,:,:,zza)=single(ndata);
                    jda(zza)=ujd(m);
                    ka(zza)=k(ii(pp));
                    ida(zza)=id(ii(pp));
                    zza=zza+1;
                    Na=Na+1;
                else
                    tcompc(:,:,:,zzc)=single(ndata);
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





clearallbut tcompa tcompc Na Nc id cyc id M xi lj jda jdc ujd ka kc ida idc


if length(tcompa(1,1,:))>1
    compa.n_max_sample		= Na;
    compa.n_eddies		    = length(unique(id(find(cyc>0))));
    for r=1:length(tcompa(:,1,1,1))
        for c=1:length(tcompa(1,:,1,1))
            for p=1:length(tcompa(1,1,:,1))
                compa.mean(r,c,p) = double(pmean(tcompa(r,c,p,:)));
                compa.n(r,c,p)    = length(find(~isnan(tcompa(r,c,p,:))));
                compa.std(r,c,p) = double(pstd(tcompa(r,c,p,:)));
            end
        end
    end
else
    compa.mean=nan;
end
clear tcompa

if length(tcompc(1,1,:))>1
    compc.n_max_sample		= Nc;
    compc.n_eddies		    = length(unique(id(find(cyc<0))));
    for r=1:length(tcompc(:,1,1,1))
        for c=1:length(tcompc(1,:,1,1))
            for p=1:length(tcompc(1,1,:,1))
                compc.mean(r,c,p) = double(pmean(tcompc(r,c,p,:)));
                compc.n(r,c,p)    = length(find(~isnan(tcompc(r,c,p,:))));
                compc.std(r,c,p) = double(pstd(tcompc(r,c,p,:)));
            end
        end
    end
else
    compc.mean=nan;
end
clear tcompa

fprintf('\n')
