function new_data=buffnan_rad(data,buff)

[ny,nx]=size(data);
[x,y]=meshgrid(1:nx,1:ny);
new_data=data;
ii=find(isnan(data));
%ii=find(isnan(data)&~isnan(land));
for m=1:length(ii)
    px=x(ii(m));py=y(ii(m));
    dist=sqrt((x-px).*(x-px)+(y-py).*(y-py));
%     whos dist
%     clf
%     pcolor(dist);shading flat;axis image
%     return
    new_data(find(dist<=buff))=nan;
end

