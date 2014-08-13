function varargout = read_schlax_wind(filename,code)

% VARARGOUT = READ_SCHLAX_WIND(FILENAME,CODE)
%
% Subroutine to read the QuikSCAT wind files from Schlax. These can read
% the files associated with the wind components (units of m/s), which has
% the name, for example, 'wnd.199909', and files associated with the 
% wind stress components (units of N/m^2), which has names, for example, of
% 'str.199909'.
%
% More than 1 code can be entered at a time. For example, if you want the U
% and DIV variables, enter: 
% [u,div] = READ_SCHLAX_WIND(FILENAME,[1 8]);
%
% To get all the variables, enter:
% [u,v,s,s2,s3,s4,N,div,crl,Nd] = READ_SCHLAX_WIND(FILENAME,1:10); 
%
% CODE    Variable              Variable Name in File
%   1      U-Wind                         u
%   2      V-Wind                         v
%   3      Magnitude                      s
%   4      Magnitude Squared              s2
%   5      Magnitude Cubed                s3
%   6      Magnitude to the fourth        s4
%   7      # of pts in wind bins          N
%   8      Divergence                     div
%   9      Curl                           crl
%   10     # of pts in wind der bins      Nd
%
% The spatial grid is: 
% lat = -69.875:0.25:69.875;
% lon = 0.125:0.25:359.875;
%
%
% Written 11/19/2007 by Larry O'Neill
%
% Updated 12/17/2007 to fix error in FACTOR for stress curl and divergence
%                    and to update code
%

% Check for correct filename, so that the dsc.* files are not accidently
% used with this routine

iswind = strcmp(filename(end-9:end-6),'wnd.');
isstress = strcmp(filename(end-9:end-6),'str.');
isdsc = strcmp(filename(end-9:end-6),'dcs.');

if iswind,
   factor = [1 1 1 1 1 1 1 1e-5 1e-5 1];
elseif isstress,
   factor = [1 1 1 1 1 1 1 1e-7 1e-7 1];
elseif isdcs,
   error('Doh! The filename is of a ''DSC.*'' file -- use READ_SCHLAX_DCS.M instead.')
else,
   error('Doh! Check for correct filename - corresponds neither to wind nor stress files')
end

amiss = 1e35;
str = {'u','v','s','s2','s3','s4','N','div','crl','Nd'};

%----------------------------------------------------------------------------
% Open file and read contents

fp = fopen(filename,'r');

% Opening salvo of grid parameters

xmin = fscanf(fp,'%f',1);
xmax = fscanf(fp,'%f',1);
ymin = fscanf(fp,'%f',1);
ymax = fscanf(fp,'%f',1);
nx_grid = fscanf(fp,'%f',1);
ny_grid = fscanf(fp,'%f',1);
dx_grid = fscanf(fp,'%f',1);
dy_grid = fscanf(fp,'%f',1);

% Read actual data fields

k = 0;

for i=1:10

   a = fscanf(fp,'%f',[nx_grid ny_grid])';
   
   if any(code==i),

      a(a==amiss) = NaN;
      k = k+1;
      varargout{k} = a*factor(i);

      if k==length(code),
         break
      end
            
%      eval([str{i},' = fscanf(fp,''%f'',[nx_grid ny_grid])'';'])
%      eval([str{i},'(',str{i},'==amiss) = NaN;'])
%      eval(['varargout{i} = ',str{i},';'])
   end

end   

fclose(fp);

return

