%function [month]=make_month(data,methode)
function [month]=make_month(data)

week = nan*data(:,:,1);
if rem(length(data(1,1,:)),4)~=0
	warning('Length of the 3rd deminsion not divisable by 4, data will be averaged through the level listed bellow')
	p = length(data(1,1,:)-1);
	if rem(p,4)~=0
		p=p-1;
		if rem(p,4)~=0
			p=p-1;
			if rem(p,4)~=0
				p=p-1;
				if rem(p,4)~=0
					p=p-1;
					if rem(p,4)~=0
						p=p-1;
					end
				end
			end
		end	
	end
	p
else p = length(data(1,1,:))
end
warning('off','all')	

for i = 1:4:p
    x = data(:,:,i:i+3);
   	Fx = ~isnan(x);
	Nx = sum(Fx,3);
	r = find(isnan(x));
	x(r) = 0;
	xbar = sum(x,3)./Nx;
	%p = find(Nx) < num; %Check for min num of good data
    %xbar(p) = NaN;
	week = cat(3,week,xbar);
end

month=week(:,:,2:length(week(1,1,:)));

warning('on','all')