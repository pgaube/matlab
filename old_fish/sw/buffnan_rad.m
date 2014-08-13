function new_data=buffnan(data,buff)

[ny,nx]=size(data);
[x,y]=meshgrid(1:nx,1:ny);

new_data=data;
for m=1:length(data(:,1))
	for n=1:length(data(1,:))
		if isnan(data(m,n))
		   dist=sqrt((x-n).^2+(y-m).^2);
		   ii=find(dist<=buff);
		   new_data(ii)=nan;
		end
	end
end

