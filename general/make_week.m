function [week]=make_week(data)

week = nan*data(:,:,1);
if rem(length(data(1,1,:)),7)~=0
	warning('Length of the 3rd deminsion not divisable by 7, data will be averaged through the level listed bellow')
	p = length(data(1,1,:)-1);
	if rem(p,7)~=0
		p=p-1;
		if rem(p,7)~=0
			p=p-1;
			if rem(p,7)~=0
				p=p-1;
				if rem(p,7)~=0
					p=p-1;
					if rem(p,7)~=0
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


for i = 1:7:p
    x = data(:,:,i:i+6);
   	Fx = ~isnan(x);
	Nx = sum(Fx,3);
	r = find(isnan(x));
	x(r) = 0;
	xbar = sum(x,3)./Nx;
	%p = find(Nx) < num; %Check for min num of good data
      %xbar(p) = NaN;
	week = cat(3,week,xbar);
end
week=week(:,:,2:length(week(1,1,:)));
warning('on','all')

