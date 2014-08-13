function [mask]=make_mask(lon,lat,data,dx,dy)


mask=ones(size(data));
nx=length(data(1,:));
ny=length(data(:,1));

%first make base mask from where data==nan
mask(isnan(data))=nan;

%first we do the zonal mask
for m=1:length(lat(:,1))
	fprintf('\r     row %03u of %03u \r',m,length(lat(:,1)))
	ina=find(isnan(mask(m,:)));
	for n=1:length(ina)
		st=ina(n)-(dx*4);
		en=ina(n)+(dx*4);
		if st>1
			if en<length(lat(1,:))
				mask(m,st:en)=nan;
			else
				mask(m,st:end)=nan;
			end
		else
			if en<length(lat(1,:))
				mask(m,1:en)=nan;
			else
				mask(m,1:end)=nan;
			end
		end
	end
end	
fprintf('\n')
%next we do the meridonal mask
for m=1:length(lat(1,:))
	fprintf('\r     column %03u of %03u \r',m,length(lat(1,:)))
	ina=find(isnan(mask(:,m)));
	for n=1:length(ina)
		st=ina(n)-(dy*4);
		en=ina(n)+(dy*4);
		if st>1
			if en<length(lat(:,1))
				mask(st:en,m)=nan;
			else
				mask(st:end,m)=nan;
			end
		else
			if en<length(lat(:,1))
				mask(1:en,m)=nan;
			else
				mask(1:end,m)=nan;
			end
		end
	end
end	



return
%started to try vector version
tmp=mask(:);
ln=length(isnan(tmp));

for m=1:ln
end	




return
%data = data
%num_points = how far from the coast (in grid points) you want
%             the mask to extend.

[m,n,p] = size(data);
mask = ones(m,n);

for ii = 1:m
    loc=find(isnan(data(ii,:)));
    mask(ii,loc(1)-num_points:n)=nan; 
end
