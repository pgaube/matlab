function varargout = read_grid_qscat_region(fname,gridx,gridy,code)

%
% VARS = READ_GRID_QSCAT_REGION(FNAME,GRIDX,GRIDY,CODES);
%
% Reads gridded QuikSCAT data written from the function
% "grid_qscat_region" into matlab. The data were written into 
% formatted text files. This function allows only specific data
% to be retrieved from the files, according to code numbers
% listed below.
%
%
% VARIABLES   CODE
% wspd           1
% dwspddx        2
% dwspddy        3
% strm           4
% dstrmdx        5
% dstrmdy        6
% u              7
% dudx           8
% dudy           9
% v             10
% dvdx          11
% dvdy          12
% ustr          13
% dustrdx       14
% dustrdy       15
% vstr          16
% dvstrdx       17
% dvstrdy       18


fp = fopen(fname,'r');

if fp<0,
   error(['READ_GRID_QSCAT_REGION: error opening ',fname])
end

ngood = fscanf( fp, '%6i' ,1);
IX    = fscanf( fp, '%4i' ,ngood);
IY    = fscanf( fp, '%3i' ,ngood);

if any( code>=1 ), tmpwspd    = 1e-2 * fscanf( fp, '%6i' ,ngood); end
if any( code>=2 ), tmpdwspddx = 1e-7 * fscanf( fp, '%6i' ,ngood); end
if any( code>=3 ), tmpdwspddy = 1e-7 * fscanf( fp, '%6i' ,ngood); end
if any( code>=4 ), tmpstrm    = 1e-3 * fscanf( fp, '%6i' ,ngood); end
if any( code>=5 ), tmpdstrmdx = 1e-9 * fscanf( fp, '%6i' ,ngood); end
if any( code>=6 ), tmpdstrmdy = 1e-9 * fscanf( fp, '%6i' ,ngood); end
if any( code>=7 ), tmpu       = 1e-2 * fscanf( fp, '%6i' ,ngood); end
if any( code>=8 ), tmpdudx    = 1e-7 * fscanf( fp, '%6i' ,ngood); end
if any( code>=9 ), tmpdudy    = 1e-7 * fscanf( fp, '%6i' ,ngood); end
if any( code>=10 ),tmpv       = 1e-2 * fscanf( fp, '%6i' ,ngood); end
if any( code>=11 ),tmpdvdx    = 1e-7 * fscanf( fp, '%6i' ,ngood); end
if any( code>=12 ),tmpdvdy    = 1e-7 * fscanf( fp, '%6i' ,ngood); end
if any( code>=13 ),tmpustr    = 1e-3 * fscanf( fp, '%6i' ,ngood); end
if any( code>=14 ),tmpdustrdx = 1e-9 * fscanf( fp, '%6i' ,ngood); end
if any( code>=15 ),tmpdustrdy = 1e-9 * fscanf( fp, '%6i' ,ngood); end
if any( code>=16 ),tmpvstr    = 1e-3 * fscanf( fp, '%6i' ,ngood); end
if any( code>=17 ),tmpdvstrdx = 1e-9 * fscanf( fp, '%6i' ,ngood); end
if any( code==18 ),tmpdvstrdy = 1e-9 * fscanf( fp, '%6i' ,ngood); end

fclose(fp);

nan_array = repmat(NaN,length(gridy),length(gridx));

if any(code==1),   wspd    = nan_array; end
if any(code==2),   dwspddx = nan_array; end
if any(code==3),   dwspddy = nan_array; end
if any(code==4),   strm    = nan_array; end
if any(code==5),   dstrmdx = nan_array; end
if any(code==6),   dstrmdy = nan_array; end
if any(code==7),   u       = nan_array; end
if any(code==8),   dudx    = nan_array; end
if any(code==9),   dudy    = nan_array; end
if any(code==10),  v       = nan_array; end
if any(code==11),  dvdx    = nan_array; end
if any(code==12),  dvdy    = nan_array; end
if any(code==13),  ustr    = nan_array; end
if any(code==14),  dustrdx = nan_array; end
if any(code==15),  dustrdy = nan_array; end
if any(code==16),  vstr    = nan_array; end
if any(code==17),  dvstrdx = nan_array; end
if any(code==18),  dvstrdy = nan_array; end


for i=1:ngood

   if any(code==1), wspd(IY(i),IX(i))     = tmpwspd(i)   ; end
   if any(code==2), dwspddx(IY(i),IX(i))  = tmpdwspddx(i); end 
   if any(code==3), dwspddy(IY(i),IX(i))  = tmpdwspddy(i); end 
   if any(code==4), strm(IY(i),IX(i))     = tmpstrm(i)   ; end 
   if any(code==5), dstrmdx(IY(i),IX(i))  = tmpdstrmdx(i); end
   if any(code==6), dstrmdy(IY(i),IX(i))  = tmpdstrmdy(i); end
   if any(code==7), u(IY(i),IX(i))        = tmpu(i)      ; end
   if any(code==8), dudx(IY(i),IX(i))     = tmpdudx(i)   ; end
   if any(code==9), dudy(IY(i),IX(i))     = tmpdudy(i)   ; end
   if any(code==10), v(IY(i),IX(i))       = tmpv(i)      ; end 
   if any(code==11), dvdx(IY(i),IX(i))    = tmpdvdx(i)   ; end
   if any(code==12), dvdy(IY(i),IX(i))    = tmpdvdy(i)   ; end
   if any(code==13), ustr(IY(i),IX(i))    = tmpustr(i)   ; end 
   if any(code==14), dustrdx(IY(i),IX(i)) = tmpdustrdx(i); end
   if any(code==15), dustrdy(IY(i),IX(i)) = tmpdustrdy(i); end
   if any(code==16), vstr(IY(i),IX(i))    = tmpvstr(i)   ; end
   if any(code==17), dvstrdx(IY(i),IX(i)) = tmpdvstrdx(i); end
   if any(code==18), dvstrdy(IY(i),IX(i)) = tmpdvstrdy(i); end

end

k=0;

if any(code==1),  k=k+1; varargout(k) = {wspd}   ; end
if any(code==2),  k=k+1; varargout(k) = {dwspddx}; end 
if any(code==3),  k=k+1; varargout(k) = {dwspddy}; end 
if any(code==4),  k=k+1; varargout(k) = {strm}   ; end 
if any(code==5),  k=k+1; varargout(k) = {dstrmdx}; end
if any(code==6),  k=k+1; varargout(k) = {dstrmdy}; end
if any(code==7),  k=k+1; varargout(k) = {u}      ; end
if any(code==8),  k=k+1; varargout(k) = {dudx}   ; end
if any(code==9),  k=k+1; varargout(k) = {dudy}   ; end
if any(code==10), k=k+1; varargout(k) = {v}      ; end 
if any(code==11), k=k+1; varargout(k) = {dvdx}   ; end
if any(code==12), k=k+1; varargout(k) = {dvdy}   ; end
if any(code==13), k=k+1; varargout(k) = {ustr}   ; end 
if any(code==14), k=k+1; varargout(k) = {dustrdx}; end
if any(code==15), k=k+1; varargout(k) = {dustrdy}; end
if any(code==16), k=k+1; varargout(k) = {vstr}   ; end
if any(code==17), k=k+1; varargout(k) = {dvstrdx}; end
if any(code==18), k=k+1; varargout(k) = {dvstrdy}; end

return
