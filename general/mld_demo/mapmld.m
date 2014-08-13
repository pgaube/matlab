% This subroutine plots the output of get_mld.m. It generates a map of the 
% selected output variable, with value corresponding to color. It requires
% the M_MAP toolbox.  It is called by get_mld.m.

clear

% Load the MLD data
load('mldinfo.mat')
mixedlayer = mldinfo;
clear mldinfo

% Remove the rejected profiles 
k = find(mixedlayer(:,5)<2000);
mixedlayer = mixedlayer(k,:);
[m,n] = size(mixedlayer);

% Calculate the dimensions of the map 
minlat = min(min(mixedlayer(:,3)));
maxlat = max(max(mixedlayer(:,3)));
minlon = min(min(mixedlayer(:,4)));    
maxlon = max(max(mixedlayer(:,4)));
dim = [minlat-1 maxlat+1; minlon-1 maxlon+1];

% Initialize the figure, set the projection, and draw the coast and borders
figure
hold on
m_proj('miller','long',[dim(2,1) dim(2,2)],'lat',[dim(1,1) dim(1,2)]);
m_coast('patch',.75*[1 1 1]);
m_grid('box','fancy','tickdir','in');
title(['Mixed layer depth (dbar)'],'fontsize',14)

% Select the output variable to map.  
mldcolumn = 10; % 10 will map the density algorithm MLDs
% Sort the data to highlight the deepest MLDs
mixedlayer = sortrows(mixedlayer,mldcolumn);
var = mixedlayer(:,mldcolumn);

% Set up the colormap
maxdepth = max(max(var));
mindepth = min(min(var));
cmin = mindepth;
cmax = maxdepth;
caxis([cmin cmax]);
cmap = colormap;

% Cycle through all of the output
for i = 1:m
    % Calculate the color that corresponds to the current output variable
    profcolor(i) = ceil((var(i)-cmin)/(cmax-cmin)*64);    
    if profcolor(i) < 1
        profcolor(i) = 1; 
    end
    if profcolor(i)>64
       profcolor(i) = 64; 
    end
    if profcolor(i) == NaN
        profcolor(i) = 1; 
        mixedlayer(i,3) = -90;
    end
    m_plot(mixedlayer(i,4),mixedlayer(i,3),'marker','o','markersize',4,'markerfacecolor',cmap(profcolor(i),:),'markeredgecolor',cmap(profcolor(i),:))
end
colorbar
hold off 
