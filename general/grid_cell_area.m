%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  function grid_cell_area
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function A=grid_cell_area(x,y)
% Given 2D arrays x and y with grid cell locations, compute the
% area of each cell.

[nx ny] = size(x);

dx = zeros(nx,ny);
dy = zeros(nx,ny);

for j=1:ny
  dx(1,j) = x(2,j)-x(1,j);
  for i=2:nx-1
    dx(i,j) = (x(i+1,j)-x(i-1,j))/2.0;
  end
  dx(nx,j) = x(nx,j)-x(nx-1,j);
end

for i=1:nx
  dy(i,1) = y(i,2)-y(i,1);
  for j=2:ny-1
    dy(i,j) = (y(i,j+1)-y(i,j-1))/2;
  end
  dy(i,ny) = y(i,ny)-y(i,ny-1);
end

A = dx.*dy;  
