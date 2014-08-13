function [comp] = comps_slope(x,y,jdays,L,var1,HEAD1,var2,HEAD2);
%function [comp] = comps_slope(x,y,jdays,L,var1,HEAD1,var2,HEAD2);
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


% Create matrices to save jdays
xi=[-2:.125:2];
M=length(xi);
tcomp1=single(nan(M,M,length(x)));
tcomp2=single(nan(M,M,length(x)));
zza=1;



%load lat lon matrices
load([HEAD1,'2454069'],'lon','lat');
lat1=lat;
lon1=lon;

load([HEAD2,'2454069'],'lon','lat');
lat2=lat;
lon2=lon;

switch HEAD1
	case {'/matlab/data/gsm/mat/GSM_9_21_'}
		load([HEAD1,'2454069'],'glon','glat');
		lat1=glat;
		lon1=glon;
	end	

switch HEAD2
	case {'/matlab/data/gsm/mat/GSM_9_21_'}
		load([HEAD2,'2454069'],'glon','glat');
		lat2=glat;
		lon2=glon;
	end	

		
for m=1:lj
    fprintf('\r  %s and %s          compositing week %03u of %03u \r',var1,var2,m,lj)
	if exist([HEAD1 num2str(ujd(m)),'.mat'])
	if exist([HEAD2 num2str(ujd(m)),'.mat'])
		load([HEAD1 num2str(ujd(m))],var1);
		load([HEAD2 num2str(ujd(m))],var2);
		if exist(var1)
		if exist(var2)
		   eval(['data1 = ' var1 ';'])
		   eval(['data2 = ' var2 ';'])
		   ii=find(jdays==ujd(m));
		   if any(ii)
			   for pp=1:length(ii)
				   ir = find(y(ii(pp))+.125 >= lat1(:,1) & y(ii(pp))-.125 <= lat1(:,1));
				   ic = find(x(ii(pp))+.125 >= lon1(1,:) & x(ii(pp))-.125 <= lon1(1,:));
				   r1=ir-40:ir+40;
				   c1=ic-40:ic+40;
				   clear ir ic
				   ir = find(y(ii(pp))+.125 >= lat2(:,1) & y(ii(pp))-.125 <= lat2(:,1));
				   ic = find(x(ii(pp))+.125 >= lon2(1,:) & x(ii(pp))-.125 <= lon2(1,:));
				   r2=ir-40:ir+40;
				   c2=ic-40:ic+40;
			   
				   if min(r1)>0 & max(r1)<length(lat1(:,1)) & min(c1)>0 & max(c1)<length(lon1(1,:)) & min(r2)>0 & max(r2)<length(lat2(:,1)) & min(c2)>0 & max(c2)<length(lon2(1,:))
					   scene_lat2 = lat2(r2,c2); 
					   scene_lon2 = lon2(r2,c2);
					   obs2=data2(r2,c2);
					   scene_lat1 = lat1(r1,c1); 
					   scene_lon1 = lon1(r1,c1);
					   obs1=data1(r1,c1);
					   
					
					 
					 
					   ndata1=zgrid(double(scene_lon1), ...
								 double(scene_lat1), ...
								 double(x(ii(pp))), ...
								 double(y(ii(pp))), ...
								 double(obs1), ...
								 double(L(ii(pp))));
					   
					   ndata2=zgrid(double(scene_lon2), ...
								 double(scene_lat2), ...
								 double(x(ii(pp))), ...
								 double(y(ii(pp))), ...
								 double(obs2), ...
								 double(L(ii(pp))));		 
								 
						%{
						figure(99)
						clf
						subplot(121)
						pcolor(xi,xi,double(ndata1));shading flat;axis image
						subplot(122)
						pcolor(xi,xi,double(ndata2));shading flat;axis image
						drawnow
						%}
					   	tcomp1(:,:,zza)=single(ndata1);
					   	tcomp2(:,:,zza)=single(ndata2);
					   	zza=zza+1;
				   end
			   end
		   end
		   eval(['clear ',var1])
		   eval(['clear ',var2])
		 else
		 	continue
		 end
		 end
	else
		continue
	end  
	end
end

clearallbut tcomp1 tcomp2 M

warning('off','all')
[comp.beta_ols,comp.beta_lin]=deal(nan(M,M));
%now make slopes
for m=1:M
	for n=1:M
		x=squeeze(tcomp1(m,n,:));
		y=squeeze(tcomp2(m,n,:));
		comp.beta_ols(m,n)=ols_pca(x,y);
		[dd,bb]=reg(x,y,'lin');
		comp.beta_lin(m,n)=bb(2);
	end
end	

comp.mean_1=nanmean(abs(tcomp1),3);
comp.mean_2=nanmean(abs(tcomp2),3);
warning('on','all')
fprintf('\n')
