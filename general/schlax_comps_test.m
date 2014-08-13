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
ff=1
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
[lon,lat]=meshgrid(lon,lat);


for m=1:3%lj
    fprintf('\r  %s          compositing week %03u of %03u \r',var,m,lj)
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
            %now normalize
            
            xx=x(ii(pp));
            yy=y(ii(pp));
            ll=L(ii(pp));
            dist_x = (scene_lon-xx).*111.11.*cosd(scene_lat);
            dist_y = (scene_lat-yy).*111.11;
            r=sqrt(dist_x.^2+dist_y.^2);
            h=exp(-.5*(r.^2./ll.^2));
            
            dist_xi=(dist_x(1,:)./ll);
            dist_yi=(dist_y(:,1)./ll);
            

            
            


            if length(dist_xi)<length(xi(1,:)) || length(dist_yi)<length(xi(:,1))
                ndata=nan(size(xi));
                display('length wrong')
            else

                for m=1:length(XXII(1,:))
                    for n=1:length(XXII(1,:))
                        ndata(m,n)=bilin_pnt(YYII(m,n),XXII(m,n),length(XXII(1,:)),length(XXII(1,:)),dist_yi,dist_xi,h,3,3);
                    end
                end
            end




% for m=1:33
%     for n=1:33
%         zi(m,n)=bilin_pnt(grid_bin1(m,n),grid_bin2(m,n),33,33,grid_xs,grid_ys,grid_data,2,2);
%     end
% % end
            ndata = griddata(dist_xi,dist_yi,h,XXII,YYII,'linear');
% %             ndata
%             figure(1)
%             clf
%             subplot(231)
%             pcolor(XXII,YYII,ndata);shading flat;axis image
%             xlabel(['L_2=',num2str(single(ll))])
%             title('bilin interpolated Gaussian')
%             
%             subplot(233)
%             pcolor(XXII,YYII,ndata2);shading flat;axis image
%             xlabel(['L_2=',num2str(ll)])
%             title('matlab interpolated Gaussian')
%             
%             subplot(235)
%             pcolor(dist_xi,dist_yi,h);shading flat;axis image
%             title(['Gaussian'])
%             %                                         pause(2)
%             eval(['print -dpng -r300 test_',num2str(ff)])
%             ff=ff+1;
%             pcomps_raw2(ndata2,ndata2,[-1 1],-100,.1,100,[''],1,30)
            
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

clearallbut tcompa tcompc Na Nc id cyc id M xi lj jda jdc ujd ka kc ida idc

% build structure array
mask_1=nan(M,M);
mask_05=mask_1;
[X,Y]=meshgrid(xi,xi);
dist=sqrt(X.^2+Y.^2);
mask_1(dist<=1)=1;
mask_05(dist<=0.5)=1;

%compa.mode	  			= nanmode(tcompa,3);
compa.n_max_sample		= Na;
compa.n_eddies		    = length(unique(id(find(cyc>0))));
for r=1:length(tcompa(:,1,1))
    for c=1:length(tcompa(1,:,1))
        compa.mean(r,c) = double(pmean(tcompa(r,c,:)));
    end
end
clear tcompa

%compc.mode	  			= nanmode(tcompc,3);
compc.n_max_sample		= Nc;
compc.n_eddies		    = length(unique(id(find(cyc<0))));
for r=1:length(tcompc(:,1,1))
    for c=1:length(tcompc(1,:,1))
        compc.mean(r,c) = double(pmean(tcompc(r,c,:)));
    end
end

fprintf('\n')
