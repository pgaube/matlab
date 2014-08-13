function [tcompa,tcompc] = pop_comps_z(x,y,cyc,k,id,jdays,L,var,rad)
%function [tcompa,tcompc] = pop_comps_z(x,y,cyc,k,id,jdays,L,var,rad)

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
tcompa=single(nan(20,ia));
tcompc=single(nan(20,ic));

[jda,ka,ida]=deal(single(nan(ia,1)));
[jdc,kc,idc]=deal(single(nan(ic,1)));

zza=1;
zzc=1;
Na=0;
Nc=0;

zgrid_grid
mdist=sqrt(xi.^2+yi.^2);
rmask=nan(size(mdist));
rmask(mdist<=rad)=1;

%load lat lon matrices
load ~/matlab/pop/mat/pop_model_domain.mat lat lon z
HEAD='~/matlab/pop/mat/run14_';

for m=1:lj
    fname=[HEAD num2str(ujd(m))];
    %test to see if we need to filter
    if exist([fname,'.mat'])
        display([var,' compositing week ',num2str(m),' of ',num2str(lj)])
        load(fname,var);
        eval(['data=',var,';']);
        
    else
        continue
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
                
                ndata=nan(length(xi(:,1)),length(xi(:,1)),20);
                for ndep=1:20
                    ndata(:,:,ndep)=rmask.*zgrid(double(scene_lon), ...
                        double(scene_lat), ...
                        double(x(ii(pp))), ...
                        double(y(ii(pp))), ...
                        double(data(r,c,ndep)), ...
                        double(L(ii(pp))));
                end
                npnt_data=squeeze(nanmean(nanmean(ndata,1),2));
                
                
                
                if cyc(ii(pp))>0
                    tcompa(:,zza)=npnt_data;
                    jda(zza)=ujd(m);
                    ka(zza)=k(ii(pp));
                    ida(zza)=id(ii(pp));
                    zza=zza+1;
                    Na=Na+1;

                else
                    tcompc(:,zzc)=npnt_data;
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



fprintf('\n')
