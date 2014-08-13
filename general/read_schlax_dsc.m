function varargout = read_schlax_dcs(filename,code)

% VARARGOUT = READ_SCHLAX_DCS(FILENAME,CODE)
%
% Subroutine to read the crosswind and downwind SST gradient files from Schlax. 
% The files have the name, for example, 'dsc.199909'.
%
% More than 1 code can be entered at a time. For example, if you want the SST
% and DWNTGRAD variables, enter: 
% [sst,dwntgrad] = READ_SCHLAX_DCS(FILENAME,[1 3]);
%
% To get all the variables, enter:
% [sst,N,dwntgrad,cwntgrad,Nd] = READ_SCHLAX_DCS(FILENAME,1:5); 
%
% CODE    Variable              Variable Name in File
%   1      SST                            sst
%   2      N                              N
%   3      Downwind SST Gradient          dwntgrad
%   4      Crosswind SST Gradient         cwntgrad
%   5      Nd                             Nd
%
% The spatial grid is: 
% lat = -69.875:0.25:69.875;
% lon = 0.125:0.25:359.875;
%
%
% Written 11/19/2007 by Larry O'Neill
%

amiss = 1e35;
str = {'sst','N','dwntgrad','cwntgrad','Nd'};
factor = [1 1 1e-5 1e-5 1];

fp = fopen(filename,'r');

xmin = fscanf(fp,'%f',1);
xmax = fscanf(fp,'%f',1);
ymin = fscanf(fp,'%f',1);
ymax = fscanf(fp,'%f',1);
nx_grid = fscanf(fp,'%f',1);
ny_grid = fscanf(fp,'%f',1);
dx_grid = fscanf(fp,'%f',1);
dy_grid = fscanf(fp,'%f',1);

k = 0;

for i=1:5

   a = fscanf(fp,'%f',[nx_grid ny_grid])';
   
   if any(code==i),

      a(a==amiss) = NaN;
      k = k+1;
      varargout{k} = a*factor(i);

      if k==length(code),
         break
      end
            
   end

end   

fclose(fp);

return

