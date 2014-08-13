function [compa,compc] = comps(x,y,cyc,jdays,L,var,HEAD,METHOD);
%function [compa,compc] = comps(x,y,cyc,jdays,L,var,METHOD);
%
% Makes composites of the samples 'var'
%
% INPUT:
% x,y,cyc,jdays,L = from eddy file
% var = variable name to be loaded from file with path HEAD
% METHOD = how the varible is sampled
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
uid=unique(id);
ic = length(find(cyc<0));
ia = length(find(cyc>0));

% Create matrices to save jdays
xi=[-2:.125:2];
M=length(xi);
tcompa=double(nan(M,M,ia));
tcompc=double(nan(M,M,ic));
zza=1;
zzc=1;


%load lat lon matrices
load([HEAD,'2454069'],'lon','lat','glon','glat');
if exist(glon)
	lat=glat;
	lon=glon;
end	

		
for m=1:lj
    fprintf('\r                 compositing week %03u of %03u \r',m,length(jdays))
    %load grad fields if requaired
	switch METHOD
	case {'w'}
		if exist(['/matlab/data/QuickScat/mat/QSCAT_30_25km_', num2str(ujd(m)),'.mat'])
			load(['/matlab/data/QuickScat/mat/QSCAT_30_25km_', num2str(ujd(m))],'u_week','v_week')
		else
			continue
		end	
	case {'t'}
		if exist(['/matlab/data/ReynoldsSST/mat/OI_25_30_', num2str(ujd(m)),'.mat'])
			load(['/matlab/data/ReynoldsSST/mat/OI_25_30_', num2str(ujd(m)),],'sst_200_day')
			grad_field = sst_200_day;
		else
			continue
		end	
	case {'g'}
		if exist(['/matlab/data/gsm/mat/GSM_9_21_', num2str(ujd(m)),'.mat'])
			load(['/matlab/data/gsm/mat/GSM_9_21_', num2str(ujd(m)),],'sm_gchl_200_day')
			grad_field = sm_gchl_200_day;
		else
			continue
		end	
	case {'c'}
		if exist(['/matlab/data/gsm/mat/GSM_9_21_', num2str(ujd(m)),'.mat'])
			load(['/matlab/data/gsm/mat/GSM_9_21_', num2str(ujd(m)),],'sm_gcar_200_day')
			grad_field = sm_gcar_200_day;
		else
			continue
		end		
	end
	
	load([HEAD num2str(ujd(m))],var);
    eval(['data = ' var ';'])
    ii=find(jdays==ujd(m));
    if any(ii)
        for pp=1:length(ii)
        	ir = find(sam_gy(tmp(ed))+eps >= lat(:,1) & sam_gy(tmp(ed))-eps <= lat(:,1));
       		ic = find(sam_gx(tmp(ed))+eps >= lon(1,:) & sam_gx(tmp(ed))-eps <= lon(1,:));
        	r=ir-40:ir+40;
       		c=ic-40:ic+40;
		
			if min(r)>0 & max(r)<length(lat(:,1)) & min(c)>0 & max(c)<length(lon(1,:))
        		scene_lat = lat(r,c); 
        		scene_lon = lon(r,c);
           	 	obs=data(r,c);
           	 	%now normalize
           	 	switch METHOD
					case {'t','g','c'}
					tmp_th=grad_field(r,c);
					dx=1e5*dfdx(scene_lat,tmp_th,.25);
					dy=1e5*dfdy(tmp_th,.25);
					thet=single(rad2deg(cart2pol(pmean(dx(:)),pmean(dy(:)))));
					thet2=thet;
					if thet>=0
						thet=-(thet-90);
						rot_index(lay)='N';
				else
					thet=-thet-90;
					rot_index(lay)='S';
				end	
				if ~isnan(nanmean(tmp_th(:)))
				ndata=wgrid(double(scene_lon), ...
				 		double(scene_lat), ...
				 		double(sam_x(tmp(ed))), ...
				 		double(sam_y(tmp(ed))), ...
				 		double(scene_data), ...
				 		double(thet), ...
				 		double(sam_scale(tmp(ed))));
				else
				ndata=nan(161,161);
				end 
				 		
           
           
           
           n=~isnan(data(r_comp,c_comp,ii(pp)));
            if id_index(ii(pp))>=nneg;
                tcompa(:,:,zza)=obs;
                zza=zza+1;
                Na=Na+n;
                %fprintf('\n   %05u of %05u %05u of %05u \r',zza,ia,zzc,ic)
                %figure(1)
                %clf
                %pcolor(double(obs));shading flat
                %caxis([-.1 .1])
                %drawnow
            else
                tcompc(:,:,zzc)=obs;
                zzc=zzc+1;
                Nc=Nc+n;
                %fprintf('\n   %05u of %05u %05u of %05u \r',zza,ia,zzc,ic)
                %figure(2)
                %clf
                %pcolor(double(obs));shading flat
                %caxis([-.1 .1])
                %drawnow
            end
        end
    end
    clear id_index
end

clearallbut tcompa tcompc Na Nc id 

fbad=nan(length(tcompa(1,1,:)),1);
for m=1:length(fbad)
	tmp=tcompa(:,:,m);
	fbad(m)=nansum(tmp(:));
end
ibad=find(fbad==0);
tcompa(:,:,ibad)=[];

fbad=nan(length(tcompc(1,1,:)),1);
for m=1:length(fbad)
	tmp=tcompc(:,:,m);
	fbad(m)=nansum(tmp(:));
end
ibad=find(fbad==0);
tcompc(:,:,ibad)=[];



% build structure array
compa.median  			= nanmedian(tcompa,3);
%compa.mode	  			= nanmode(tcompa,3);
compa.N 				= Na-1;
compa.n_max_sample		= max(Na(:));
compa.n_eddies		    = length(id);
compa.per_cov			= 100*(Na./max(Na(:)));
%compa.mean				= nanmean(tcompa,3);
%compa.std	 			= nanstd(tcompa,0,3);
for r=1:length(tcompa(:,1,1))
	for c=1:length(tcompa(1,:,1))
	compa.mean(r,c) = pmean(tcompa(r,c,:));
	compa.std(r,c) = pstd(tcompa(r,c,:));
	end
end	
%}

clear tcompa

compc.median  			= nanmedian(tcompc,3);
%compc.mode	  			= nanmode(tcompc,3);
compc.N 				= Nc-1;
compc.n_max_sample		= max(Nc(:));
compc.n_eddies		    = length(id);
compc.per_cov			= 100*(Nc./max(Nc(:)));
%compc.mean				= nanmean(tcompc,3);
%compc.std	 			= nanstd(tcompc,0,3);
for r=1:length(tcompc(:,1,1))
	for c=1:length(tcompc(1,:,1))
	compc.mean(r,c) = pmean(tcompc(r,c,:));
	compc.std(r,c) = pstd(tcompc(r,c,:));
	end
end	
%}
fprintf('\n')
