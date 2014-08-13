function test_read_fusion()

% this function calls the routine which reads Microwave OI SST products from RSS
% questions should be addressed to RSS support:
% http://www.remss.com/support
%
% PLEASE CHANGE YOUR DIRECTORY in read_fusion.m


%[sst]=read_fusion('tmi_amsre',2004,140);
[sst]=read_fusion('tmi_amsre',2004,05,19);

sst(770:775,474:478)'

% draw image to screen

figure(9);

% here we transpose and vertically flip the map for display in Matlab
imagesc([.125:.25:359.875],[-89.875:.25:89.875],flipud(sst'));

colorbar;

