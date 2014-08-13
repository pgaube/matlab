function [compa,compc] = pop_comps_rel_orgin(x,y,cyc,k,id,jdays,rad,var);
%function [compa,compc] = pop_comps_mat(x,y,cyc,k,id,jdaysrad,var);

%
% Makes composites of the samples 'var'
%
% INPUT:
% x,y,cyc,jdays, = from eddy file
% rad=radius to mask data, in km
% var = variable name to be loaded from file with path HEAD
%
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

M=21;
tcompa=single(nan(M,M,ia));
tcompc=single(nan(M,M,ic));

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
    %test to see if we need to filter
    if exist([fname,'.mat'])
        display([var,' compositing week ',num2str(m),' of ',num2str(lj)])
        load(fname,var);
        eval(['data=',var,';']);
%         figure(1)
%         clf
%         subplot(211)
%         pmap(lon,lat,hp66_chl)
%         caxis([-.1 .1])
%         subplot(212)
%         pmap(lon,lat,hp66_chl./mean_field)
%         caxis([-.1 .1])
%         drawnow
%         return
    else
        continue
    end
    ii=find(jdays==ujd(m));
    if any(ii)
        for pp=1:length(ii)
            [ir,ic] = imap(y(ii(pp))-.05,y(ii(pp))+.05,x(ii(pp))-.05,x(ii(pp))+.05,lat,lon);
            r=ir-10:ir+10;
            c=ic-10:ic+10;
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
                scene_data = data(r,c);
                dist=sqrt((111.11*(scene_lon-x(ii(pp))).*cosd(y(ii(pp)))).^2+(111.11*(scene_lat-y(ii(pp)))).^2);
                mask=nan.*scene_data;
                mask(dist<=rad)=1;
                
                if cyc(ii(pp))>0
                    tcompa(:,:,zza)=single(scene_data.*mask);
                    jda(zza)=ujd(m);
                    ka(zza)=k(ii(pp));
                    ida(zza)=id(ii(pp));
                    zza=zza+1;
                    Na=Na+1;
                else
                    tcompc(:,:,zzc)=single(scene_data.*mask);
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



clearallbut tcompa tcompc Na Nc id cyc id M lj jda jdc ujd ka kc ida idc
% build structure array

%%anticyclones
if length(tcompa(1,1,:))>1
    %make k time series relitive to eddy first identification
    uaid=unique(ida);
    for fdr=1:length(uaid)
        iua=find(ida==uaid(fdr));
        iuao=find(ka(iua)==1);
        if any(iuao)
            tcmp_o=tcompa(:,:,iua(iuao));
            for p=1:40
                ii=find(ka(iua)==p);
                if any(ii)
                    tcompa(:,:,iua(ii))=tcompa(:,:,iua(ii))-tcmp_o;
                end
            end
        else
            tcompa(:,:,iua)=nan*tcompa(:,:,iua);
        end
    end
    for p=1:40
        ii=find(ka==p);
        if any(ii)
            compa.ks_orgin_std(p)=pstd(tcompa(:,:,ii));
            compa.ks_orgin(p)=pmean(tcompa(:,:,ii));
            compa.ks_orgin_n(p)=length(ii);
        end
    end
else
    compa.mean=nan;
end
clear tcompa

%%cyclones
if length(tcompc(1,1,:))>1
    %make k time series relitive to eddy first identification
    ucid=unique(id(cyc==-1));
    for fdr=1:length(ucid)
        iuc=find(idc==ucid(fdr));
        iuco=find(kc(iuc)==1);
        if any(iuco)
            tcmp_o=tcompc(:,:,iuc(iuco));
            for p=1:40
                ii=find(kc(iuc)==p);
                if any(ii)
                    tcompc(:,:,iuc(ii))=tcompc(:,:,iuc(ii))-tcmp_o;
                end
            end
        else
            tcompc(:,:,iuc)=nan*tcompc(:,:,iuc);
        end
    end
    for p=1:40
        ii=find(kc==p);
        if any(ii)
            compc.ks_orgin_std(p)=pstd(tcompc(:,:,ii));
            compc.ks_orgin(p)=pmean(tcompc(:,:,ii));
            compc.ks_orgin_n(p)=length(ii);
        end
    end
else
    compc.mean=nan;
end
clear tcompc

fprintf('\n')
