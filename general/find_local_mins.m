
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  function find_local_minss
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function local_mins = find_local_mins(A,A_start,max_evaluation_points);
% Find local minimums of the 3D array A that are less than
% A_start.  The output, local_mins, is a 3xm array of the m
% minimums found, containing the three A indices of each minimum.
% The search evaluates every k level, but not the horizontal edges.

[nx ny nz] = size(A);
local_mins = zeros(3,max_evaluation_points);
imin=0;
for k=1:nz
  for j=2:ny-1
    for i=2:nx-1
      A_min_neighbors = min(min(min(...
	  A(i-1:i+1,j-1:j+1,max(1,k-1):min(nz,k+1)))));
      if A(i,j,k)<A_start & A(i,j,k) == A_min_neighbors
        imin=imin+1;
        local_mins(:,imin) = [i j k];
	if imin==max_evaluation_points
	  return
	end
      end
    end
  end
end

local_mins = local_mins(:,1:imin);