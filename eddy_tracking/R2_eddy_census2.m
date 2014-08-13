function R2_eddy_census
% Matlab function R2_eddy_census
%
% note: Matlab cannot run a file that begins with a number.  After
% downloading, change the name as follows:
% mv 2012JC008459-text01.m R2_eddy_census.m
%
% This code is an example of the R2 method of eddy detection
% as described in the paper:
% Williams et al., 2011
% IEEE Transactions on Visualization and Computer Graphics, 17 ,
% 2088-2095
%
% This code is meant to be an educational example only, and is not
% capable of a global eddy census due to speed constraints.
%
% The R2 method begins by computing Okubo-Weiss (OW) then computes
% the goodness of linear fit of OW versus volume as one proceeds
% outward from a local OW minimum, accumulating neighboring cells
% in order of minimum OW.
%
% author: Mark Petersen
% date: November 2012
% Los Alamos National Laboratory

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Set parameters.  This may be the only section that needs changing
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('Parameter settings:\n')
tic
% Data file.  Choose among these options for ready-made data:
filename= '/Users/new_gaube/matlab/eddy_tracking/2012JC008459data01.nc' %  Agulhas region NetCDF data file
%filename= '/Users/new_gaube/matlab/eddy_tracking2012JC008459data02.nc' %  Kuroshio current region NetCDF data file
%filename= '/Users/new_gaube/matlab/eddy_tracking2012JC008459data03.nc' %  North Atlantic region NetCDF data file

% Confidence level, usually 90%
R2_criterion=0.9

% OW value at which to begin the evaluation of R2
OW_start=-1.0

% Number of local minima to evaluate using R2 method.
% Set low (like 20) to see a few R2 eddies quickly.
% Set high (like 1e5) to find all eddies in domain.
max_evaluation_points = 20

% Minimum number of cells required to be identified as an eddie.
min_eddie_cells = 30

% z-level to plot.  Usually set to 1 for the surface.
k_plot = 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Load velocity data from netcdf file
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('Load velocity data from netcdf file\n')

ncid = netcdf.open(filename,'nc_nowrite');

% Load longitude and latitude, and depth of grid
lon = netcdf.getVar(ncid,netcdf.inqVarID(ncid,'u_lon'));
lat = netcdf.getVar(ncid,netcdf.inqVarID(ncid,'u_lat'));
depth = netcdf.getVar(ncid,netcdf.inqVarID(ncid,'depth_t'));

% Load zonal and meridional velocity, in cm/s
uvel = netcdf.getVar(ncid,netcdf.inqVarID(ncid,'UVEL'));
vvel = netcdf.getVar(ncid,netcdf.inqVarID(ncid,'VVEL'));

netcdf.close(ncid)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Initialize variables
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('Initialize variables\n')

[nx ny nz] = size(uvel);

% Set land cells to zero velocity
land_indices = find(uvel<-1e33);
uvel(land_indices) = 0.0;
vvel(land_indices) = 0.0;

% Create an ocean mask which has value 1 at ocean cells.
ocean_mask = ones(size(uvel));
ocean_mask(land_indices) = 0.0;
n_ocean_cells = sum(sum(sum(ocean_mask)));

% Compute cartesian distances for derivatives, in cm
R = 6.378e8;  % earth's radius in cm
x = zeros(nx,ny);
y = zeros(nx,ny);
for i=1:nx
  for j=1:ny
    x(i,j) = 2*pi*R*cos(lat(j)*pi/180)*lon(i)/360;
    y(i,j) = 2*pi*R*lat(j)/360;
  end
end

% Gridcell area
grid_area=grid_cell_area(x,y);

% Thickness of each layer
dz(1) = 2*depth(1);
dz(2:nz-1) = (depth(3:nz) - depth(1:nz-2))/2;
dz(nz) = depth(nz) - depth(nz-1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Compute Okubo-Weiss
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('')

% velocity derivatives
[du_dx,du_dy]=deriv1_central_diff_3D(uvel,x,y);
[dv_dx,dv_dy]=deriv1_central_diff_3D(vvel,x,y);
whos x y uvel lon lat dv_dx
clf
pmap(lon,lat,dv_dx(:,:,1))
return
% strain and vorticity
normal_strain = du_dx - dv_dy;
shear_strain = du_dy + dv_dx;
vorticity = dv_dx - du_dy;

% Compute OW, straight and then normalized
OW_raw = normal_strain.^2 + shear_strain.^2 - vorticity.^2;
OW_mean = sum(sum(sum(OW_raw)))/n_ocean_cells;
OW_std = sqrt(sum(sum(sum( (ocean_mask.*(OW_raw-OW_mean)).^2)))/n_ocean_cells);
OW = OW_raw/OW_std;
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Find local minimums in Okubo-Weiss field
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('Find local minimums in Okubo-Weiss field\n')

% Efficiency note: Search for local minima can be merged with R2
% algorithm below.

local_mins = find_local_mins(OW,OW_start,max_evaluation_points);
num_mins = size(local_mins,2)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  R2 algorithm
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('Beginning R2 algorithm\n')

% Set a maximum number of cells to search through, for initializing
% arrays.
max_eddy_cells_search = 10000;

% Initialize variables for eddy census
iEddie=0;
eddie_census = zeros(10,num_mins);
all_eddies_mask = zeros(size(uvel));

fprintf('Evaluating eddy at local OW minimum.  Number of minimums = %g\n', num_mins)

% loop over local OW minima
for imin=1:num_mins

  % initialize variables for this local minimum in OW
  ie = local_mins(1,imin);
  je = local_mins(2,imin);
  ke = local_mins(3,imin);
  
  % Efficiency note: Eddie and neighor masks are logical arrays the
  % size of the full 3D domain.  A more efficient implementation is
  % to create a list that records the indices of all eddy and
  % neighbor cells.
  eddie_mask = zeros(size(uvel));
  neighbor_mask = zeros(size(uvel));
  
  eddie_mask(ie,je,ke) = 1;
  minOW = zeros(max_eddy_cells_search,1);
  volume = zeros(max_eddy_cells_search,1);
  R2 = zeros(max_eddy_cells_search,1);
  minOW(1) = OW(ie,je,ke);
  volume(1) = grid_area(ie,je)*dz(ke);
  start_checking=0;
  max_k=0;
  min_k=nz;

  fprintf('imin=%3.0f, lon=%4.1f lat=%4.1f k=%2.0f: ',imin,lon(ie),lat(je),ke)

  % Loop to accumulate cells neighboring local min, in order of min OW.
  for ind = 2:max_eddy_cells_search
    
    % Identify six neighbors to the newest cell.
    % Subtract eddy mask so cells already in eddy are not candidates.
    neighbor_mask(max(ie-1, 1),je,ke) = 1 - eddie_mask(max(ie-1, 1),je,ke);
    neighbor_mask(min(ie+1,nx),je,ke) = 1 - eddie_mask(min(ie+1,nx),je,ke);
    neighbor_mask(ie,max(je-1, 1),ke) = 1 - eddie_mask(ie,max(je-1, 1),ke);
    neighbor_mask(ie,min(je+1,ny),ke) = 1 - eddie_mask(ie,min(je+1,ny),ke);
    neighbor_mask(ie,je,max(ke-1, 1)) = 1 - eddie_mask(ie,je,max(ke-1, 1));
    neighbor_mask(ie,je,min(ke+1,nz)) = 1 - eddie_mask(ie,je,min(ke+1,nz));

    % Find the cell with the minimum OW value amongst all cells
    % neighboring the current eddy cells.
    neighbor_indices = find(neighbor_mask);
    minOW(ind) = min(OW(neighbor_indices));
    minInd = find(OW(neighbor_indices)==minOW(ind),1);
    [ie,je,ke] = ind2sub([nx,ny,nz],neighbor_indices(minInd));
    
    % (ie,je,ke) is the newest cell added to the eddy.  Reset masks
    % at that location.
    eddie_mask(ie,je,ke) = 1;
    neighbor_mask(ie,je,ke) = 0;
    min_k = min(min_k,ke);
    max_k = max(max_k,ke);

    % We are building a data set of minimum OW versus volume
    % accumulated so far in this search.  If the new eddy cell has
    % lower OW, record the previous value of OW.  This is so OW
    % values are always increasing.
    minOW(ind) = max(minOW(ind),minOW(ind-1));
    volume(ind) = volume(ind-1) + grid_area(ie,je)*dz(ke);

    % Reject eddies identified over duplicate cells. Don't check
    % every time for efficiency.

    % Note: This illustrative algorithm uses the first accepted
    % eddy, and all later eddies in identical cells are duplicates.  
    % A better method is to find the bounds of all accepted eddies, 
    % and then choose among duplicates with another criteria, for 
    % example largest volume.
    if mod(ind,20)==0 
      if max(max(max(eddie_mask+all_eddies_mask)))==2
        fprintf('No, duplicate\n')
        break
      end
    end
    
    if start_checking==0

      % When OW value greater than OW_start, check if R2 criterion
      % is met.  
      if minOW(ind)>OW_start
	% Compute R2 value of linear fit of volume versus min OW.
        temp = corrcoef(minOW(1:ind),volume(1:ind));
        R2(ind)=temp(1,2);
        if R2(ind)<R2_criterion
          fprintf('No, R2 criterion not met\n')
	  break
	else
	  % After this iteration, check R2 every time.
	  start_checking=1;
	end
      end
    
    else % start_checking==1

      % Compute R2 value of linear fit of volume versus min OW.
      temp = corrcoef(minOW(1:ind),volume(1:ind));
      R2(ind)=temp(1,2);

      % When the R2 value falls below the critical level, we may
      % have an eddie.
      if R2(ind)<R2_criterion
	
        % Reject eddies identified over duplicate cells. 
        if max(max(max(eddie_mask+all_eddies_mask)))==2
          fprintf('No, duplicate eddie\n')
          break
	end

        % Reject eddies that are too small.
        if ind<=min_eddie_cells
          fprintf('No, too small.  Number of cells = %g\n', ind)
          break
	end
	
        iEddie = iEddie	+ 1;
        fprintf('Yes, eddie confirmed.  iEddie=%g\n',iEddie)

	% find minimum OW value and location with this eddie
	eddie_indices_1D = find(eddie_mask);
	minOW_eddie = min(OW(eddie_indices_1D));
        tempInd = find(OW(eddie_indices_1D)==minOW_eddie,1);
        [iE,jE,kE] = ind2sub([nx,ny,nz],eddie_indices_1D(tempInd));

	% Find diamter of this eddie, using area at depth of max OW
        % value, in cm^2.  Diameter is in km.
	area = sum(sum(grid_area(find(eddie_mask(:,:,kE)))));
	diameter = 2*sqrt(area/pi)/1e5;
	
	% add this eddie to the full eddie mask
	all_eddies_mask = all_eddies_mask + eddie_mask;
	
        % record eddie data
	eddie_census(:,iEddie) = [minOW(1) lon(iE) lat(jE) depth(kE) ...
		    ind diameter depth(max_k)-depth(min_k) volume(ind)/1e6...
		    depth(min_k) depth(max_k)];
	break
      end
      
    end % start_checking

  end % ind
  
end % imin
nEddies = iEddie;

fprintf('\nEddie census data\n')
fprintf(['eddie #   minOW at: lon    lat depth,m  # cells '...
	 'diameter,km thickness,m volume,m^3' ...
	 ' min depth max depth\n'])
for iEddie = 1:nEddies
  fprintf(' %6.0f %8.2f %6.1f %6.1f %7.0f %8.0f %11.0f %11.1f %10.2e %9.1f %9.1f \n',...
	  iEddie,eddie_census(:,iEddie))
end

fprintf(['\nNote: max_evaluation_points set to %g.  \nTo identify eddies' ...
	 ' over the full domain, set max_evaluation_points to a' ...
	  ' high number like 1e4.\n'],max_evaluation_points)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Plot variables
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(1); clf
set(gcf,'Position',[0 0 850 1000],...
	'PaperPositionMode','auto',...
	'color',[.8 1 .8], ...
	'PaperPosition',[0.25 0.25 8.5 11])

subplot(3,2,1)
imagesc(lon,lat,uvel(:,:,k_plot)')
set(gca,'YDir','normal','CLim',[-100 100])
title('zonal velocity, cm/s')

subplot(3,2,2)
imagesc(lon,lat,vvel(:,:,k_plot)')
set(gca,'YDir','normal','CLim',[-100 100])
title('meridonal velocity, cm/s')

subplot(3,2,3)
imagesc(lon,lat,vorticity(:,:,k_plot)')
set(gca,'YDir','normal','CLim',[-3e-5 3e-5])
title('vorticity, 1/s')

subplot(3,2,4)
imagesc(lon,lat,OW(:,:,k_plot)')
set(gca,'YDir','normal','CLim',[-1.5 1.5])
title('normalized Okubo-Weiss')

subplot(3,2,5)
OW_eddies = zeros(size(OW));
OW_eddies(find(OW<-0.2)) = 1.0;
imagesc(lon,lat,OW_eddies(:,:,k_plot)')
set(gca,'YDir','normal')
title('eddies with OW<-0.2')

subplot(3,2,6)
imagesc(lon,lat,all_eddies_mask(:,:,k_plot)')
set(gca,'YDir','normal')
title('eddies identified by R2')
for i=1:nEddies
  h=text(eddie_census(2,i),eddie_census(3,i),num2str(i));
  set(h,'Color','w')
end

cl='kkkkww';
for i=1:6
  subplot(3,2,i)
  colorbar
  ylabel('latitude')
  xlabel('longitude')
  if min(min(ocean_mask))<1;
    hold on
    contour(lon,lat,ocean_mask(:,:,1)',.5,cl(i))
  end
end

subplot('position',[0 .95 1 .05]); axis off
h=text(.55,.4,'The R2 Eddy Identification Method');
set(h,'HorizontalAlignment','center','FontWeight','bold','FontSize',14)
text(.01,.7,date);
text(.01,.3,['data: ' filename]);

subplot('position',[0 0 1 .05]); axis off
text(.01,.7,'M. Petersen, S. Williams, M. Maltrud, M. Hecht, Los Alamos National Laboratory');
text(.01,.4,'B. Hamann, UC Davis');

fprintf(['\nNote: Eddy numbers for all eddies are added to the R2 plot, but\n' ...
	 ' only colors for level k_plot=%g is shown, so some numbers\n' ...
	 ' may not appear with eddies at this level.\n'],k_plot)
 
 toc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  function deriv1_central_diff_3D
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [dadx,dady]=deriv1_central_diff_3D(a,x,y)
% Take the first derivative of a with respect to x and y using
% centered central differences.  The variable a is a 3D field.

[nx ny nz] = size(a)

dadx = zeros(nx,ny,nz);
dady = zeros(nx,ny,nz);

for k=1:nz

  for j=1:ny
    dadx(1,j,k) = (a(2,j,k)-a(1,j,k))/(x(2,j)-x(1,j));
    for i=2:nx-1
      dadx(i,j,k) = (a(i+1,j,k)-a(i-1,j,k))/(x(i+1,j)-x(i-1,j));
    end
    dadx(nx,j,k) = (a(nx,j,k)-a(nx-1,j,k))/(x(nx,j)-x(nx-1,j));
  end

  for i=1:nx
    dady(i,1,k) = (a(i,2,k)-a(i,1,k))/(y(i,2)-y(i,1));
    for j=2:ny-1
      dady(i,j,k) = (a(i,j+1,k)-a(i,j-1,k))/(y(i,j+1)-y(i,j-1));
    end
    dady(i,ny,k) = (a(i,ny,k)-a(i,ny-1,k))/(y(i,ny)-y(i,ny-1));
  end

end

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
