function [compcc,compc] = comps_dir(x,y,cyc,id,jdays,L,var,HEAD,METHOD);
%function [compcc,compc] = comps_dir(x,y,cyc,id,jdays,L,var,METHOD);
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
jda=single(nan(ia,1));
jdc=single(nan(ic,1));
zza=1;
zzc=1;
Na=0;
Nc=0;


%load lat lon matrices
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
		if exist(['~/data/QuickScat/mat/QSCAT_30_25km_', num2str(ujd(m)),'.mat'])
			load(['~/data/QuickScat/mat/QSCAT_30_25km_', num2str(ujd(m))],'u_week','v_week')
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
						   ubar=pmean(u_week(r(25:55),c(25:55)));
						   vbar=pmean(v_week(r(25:55),c(25:55)));
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
					   
						   case {'n'}
						   ndata=zgrid(double(scene_lon), ...
									 double(scene_lat), ...
									 double(x(ii(pp))), ...
									 double(y(ii(pp))), ...
									 double(obs), ...
									 double(L(ii(pp))));
					   end	
					   if cyc(ii(pp))>0 & y(ii(pp))<0 | cyc(ii(pp))<0 & y(ii(pp))>0;
						   tcompa(:,:,zza)=single(ndata);
						   jda(zza)=ujd(m);
						   zza=zza+1;
						   Na=Na+1;
					   else
						   tcompc(:,:,zzc)=single(ndata);
						   jdc(zzc)=ujd(m);
						   zzc=zzc+1;
						   Nc=Nc+1;
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

clearallbut tcompa tcompc Na Nc id cyc id M xi lj jda jdc ujd y

% build structure array
mask_1=nan(M,M);
mask_05=mask_1;
[X,Y]=meshgrid(xi,xi);
dist=sqrt(X.^2+Y.^2);
mask_1(dist<=1)=1;
mask_05(dist<=0.5)=1;

compcc.median  			= double(nanmedian(tcompa,3));
%compa.mode	  			= nanmode(tcompa,3);
compcc.n_max_sample		= Na;
compcc.n_eddies		    = length(unique(id(find(cyc>0 & y<0 | cyc<0 & y>0))));
for r=1:length(tcompa(:,1,1))
	for c=1:length(tcompa(1,:,1))
	compcc.mean(r,c) = double(pmean(tcompa(r,c,:)));
	compcc.std(r,c) = double(pstd(tcompa(r,c,:)));
	end
end	
%make time series
for p=1:lj
	ii=find(jda==ujd(p));
	compcc.ts_1(p)=pmean(squeeze(nanmean(tcompa(:,:,ii),3)).*mask_1);
	compcc.ts_05(p)=pmean(squeeze(nanmean(tcompa(:,:,ii),3)).*mask_05);
end	



clear tcompa

compc.median  			= double(nanmedian(tcompc,3));
%compc.mode	  			= nanmode(tcompc,3);
compc.n_max_sample		= Nc;
compc.n_eddies		    = length(unique(id(find(cyc<0 & y>0 | cyc>0 & y<0))));
for r=1:length(tcompc(:,1,1))
	for c=1:length(tcompc(1,:,1))
	compc.mean(r,c) = double(pmean(tcompc(r,c,:)));
	compc.std(r,c) = double(pstd(tcompc(r,c,:)));
	end
end
%make time series
for p=1:lj
	ii=find(jda==ujd(p));
	compc.ts_1(p)=pmean(squeeze(nanmean(tcompc(:,:,ii),3)).*mask_1);
	compc.ts_05(p)=pmean(squeeze(nanmean(tcompc(:,:,ii),3)).*mask_05);
end	
fprintf('\n')
