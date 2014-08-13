function [ grid_wspd, grid_dwspddx, grid_dwspddy, ...
           grid_strm, grid_dstrmdx, grid_dstrmdy, ...
	       grid_u, grid_dudx, grid_dudy, ...
	       grid_v, grid_dvdx, grid_dvdy, ...
	       grid_ustr, grid_dustrdx, grid_dustrdy, ...
	       grid_vstr, grid_dvstrdx, grid_dvstrdy ] = ...
	                               INT_QSCAT_SWATH( tmpglon, ...
				                        tmpglat, ...
				                        tmpgwspd, ...
				                        tmpgstrm, ...
				                        tmpgu, ...
				                        tmpgv, ...
				                        tmpgustr, ...
				                        tmpgvstr);

global grid_wspd grid_dwspddx grid_dwspddy ... 
       grid_strm grid_dstrmdx grid_dstrmdy ...
       grid_u grid_dudx grid_dudy ...
       grid_v grid_dvdx grid_dvdy ...
       grid_ustr grid_dustrdx grid_dustrdy ...
       grid_vstr grid_dvstrdx grid_dvstrdy

global RADIAL_SPAN
global DX_OVERLAP
global NX_GRID NY_GRID
global NAN_MATRIX
global ICLASS

%----------------------------------------------------------------------------

[grid_wspd,grid_dwspddx,grid_dwspddy,grid_strm,grid_dstrmdx,grid_dstrmdy, ...
 grid_u,grid_dudx,grid_dudy,grid_v,grid_dvdx,grid_dvdy,grid_ustr, ...
 grid_dustrdx,grid_dustrdy,grid_vstr,grid_dvstrdx,grid_dvstrdy] = deal(NAN_MATRIX);

%--------------------------------------------------------------------------
% Routine that finally performs the fitting of the quadratic surfaces to
% each field
%--------------------------------------------------------------------------

grid_loop(31:NX_GRID-31,tmpglon,tmpglat,tmpgwspd,tmpgstrm,tmpgu,tmpgv,tmpgustr,tmpgvstr);

%
% Work around the 0-360 seam. All this does is take the swath values
% within +/- 5 deg of the seam, separately adding and subtracting +/-
% 360deg, then goes through the rest of the processing as normal.
%

j1 = tmpglon<=DX_OVERLAP;
j2 = tmpglon>=(360-DX_OVERLAP);

if ~isempty(j1),
%keyboard
    tmpglon2  = [tmpglon(j1)+360;tmpglon;tmpglon(j2)-360];
    tmpglat2  = [tmpglat(j1);tmpglat;tmpglat(j2)];
    tmpgwspd2 = [tmpgwspd(j1);tmpgwspd;tmpgwspd(j2)];
    tmpgstrm2 = [tmpgstrm(j1);tmpgstrm;tmpgstrm(j2)];
    tmpgu2    = [tmpgu(j1);tmpgu;tmpgu(j2)];
    tmpgv2    = [tmpgv(j1);tmpgv;tmpgv(j2)];
    tmpgustr2 = [tmpgustr(j1);tmpgustr;tmpgustr(j2)];
    tmpgvstr2 = [tmpgvstr(j1);tmpgvstr;tmpgvstr(j2)];
    ICLASS    = [ICLASS(j1);ICLASS;ICLASS(j2)];

    grid_loop([1:30 NX_GRID-30:NX_GRID], ...
              tmpglon2,tmpglat2,tmpgwspd2,tmpgstrm2,tmpgu2,tmpgv2,tmpgustr2,tmpgvstr2);

end

if 0,
j1 = tmpglon<=DX_OVERLAP | tmpglon>=(360-DX_OVERLAP);

if ~isempty(j1),
keyboard
    tmpglon2  = [tmpglon(j1)-360;tmpglon(j1);tmpglon(j1)+360];
    tmpglat2  = repmat(tmpglat(j1),[3 1]);
    tmpgwspd2 = repmat(tmpgwspd(j1),[3 1]);
    tmpgstrm2 = repmat(tmpgstrm(j1),[3 1]);
    tmpgu2    = repmat(tmpgu(j1),[3 1]);
    tmpgv2    = repmat(tmpgv(j1),[3 1]);
    tmpgustr2 = repmat(tmpgustr(j1),[3 1]);
    tmpgvstr2 = repmat(tmpgvstr(j1),[3 1]);

    grid_loop([1:30 NX_GRID-30:NX_GRID], ...
              tmpglon2,tmpglat2,tmpgwspd2,tmpgstrm2,tmpgu2,tmpgv2,tmpgustr2,tmpgvstr2);

end
end

return

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function grid_loop(cols,tmpglon,tmpglat,tmpgwspd,tmpgstrm,tmpgu,tmpgv,tmpgustr,tmpgvstr);

global grid_wspd grid_dwspddx grid_dwspddy ... 
       grid_strm grid_dstrmdx grid_dstrmdy ...
       grid_u grid_dudx grid_dudy ...
       grid_v grid_dvdx grid_dvdy ...
       grid_ustr grid_dustrdx grid_dustrdy ...
       grid_vstr grid_dvstrdx grid_dvstrdy

global RADIAL_SPAN
global NPTS_SPAN_THRESHOLD NPTS_HALFSPAN_THRESHOLD
global NPTS_NORTH NPTS_SOUTH NPTS_EAST NPTS_WEST
global MAX_WSPD MAX_STRM
global SPAN2 SPAN2HALF C CR
global NY_GRID
global GRIDX GRIDY
global ICLASS
global ICLASS_INT_THRESHOLD

xdist = CR*cos(C*tmpglat);

for i=cols
   
%   fprintf('\ri=%u j=%u',i,j)

%   dx = CR*(tmpglon-GRIDX(i)).*cos(C*tmpglat);
   dx = (tmpglon-GRIDX(i)).*xdist;
   dx2 = dx.^2;
   
   igoodx = dx2<=SPAN2;   
   
   if any(igoodx),

      dxtmp   =  dx(igoodx);
      dx2tmp  =  dx2(igoodx);
      lattmp  =  tmpglat(igoodx);     
      wspdtmp =  tmpgwspd(igoodx);
      strmtmp =  tmpgstrm(igoodx);
      utmp    =  tmpgu(igoodx);
      vtmp    =  tmpgv(igoodx);
      ustrtmp =  tmpgustr(igoodx);
      vstrtmp =  tmpgvstr(igoodx);

      iclasstmp = ICLASS(igoodx);

      for j=1:NY_GRID
	 
	     dytmp   = CR*(lattmp-GRIDY(j)); % y-distance b/w grid pt and obs pts
	     dy2tmp  = dytmp.^2;

         if any(dy2tmp<=SPAN2),

             d2      = dx2tmp + dy2tmp;  % Total squared distance between grid pt and observation pts
             igoodxy = d2 <= SPAN2;        	 
             ngood   = sum(igoodxy);           % # of points within squared span        
             
             if ngood >= NPTS_SPAN_THRESHOLD,

                d2sel = d2(igoodxy);
                iwithinhalfspan = d2sel<=SPAN2HALF;

                if sum(iwithinhalfspan) >= NPTS_HALFSPAN_THRESHOLD,

                    dxtmpsel = dxtmp(igoodxy);
                    dytmpsel = dytmp(igoodxy);

                    %
                    % Test whether grid point is surrounded by obs points
                    %

                    if sum(dxtmpsel>0)>=NPTS_EAST  & sum(dxtmpsel<0)>=NPTS_WEST & ...
                       sum(dytmpsel>0)>=NPTS_NORTH & sum(dytmpsel<0)>=NPTS_SOUTH,


                       % Select wind observations within specified distance
                       % to the grid point

                       dx2tmpsel  = dx2tmp(igoodxy);
                       dy2tmpsel  = dy2tmp(igoodxy);
                       wspdtmpsel = wspdtmp(igoodxy);
                       strmtmpsel = strmtmp(igoodxy);
                       utmpsel    = utmp(igoodxy);
                       vtmpsel    = vtmp(igoodxy);
                       ustrtmpsel = ustrtmp(igoodxy);
                       vstrtmpsel = vstrtmp(igoodxy);

                       iclasstmpsel = iclasstmp(igoodxy);

                       tmp_iclass = mean(iclasstmpsel(iwithinhalfspan));

                       if tmp_iclass >= ICLASS_INT_THRESHOLD,

                          % Weight observations based on distance from grid point
                          % using the tricubic weighting function

                          %w = ( 1 - (d2sel/SPAN2).^1.5 ).^3; 
                          w = 1 - (d2sel/SPAN2).*sqrt(d2sel/SPAN2);
                          %w = 1 - d2sel.*sqrt(d2sel);
                          w = w.*w.*w;

                          % Build matrix for the loess regression of wind observations
                          % based on distance (dx,dy) from the grid point

                          xin(:,1) = w;
                          xin(:,2) = w.*dxtmpsel;
                          xin(:,3) = w.*dytmpsel;
                          xin(:,4) = w.*dx2tmpsel;
                          xin(:,5) = w.*dy2tmpsel;
                          xin(:,6) = xin(:,2).*xin(:,3)./w;

                          % Decompose xin using QR decomposition to use for 
                          % least-squares regression.  

                          [Q, R] = qr( xin, 0 );

                          % Use the Q and R matrices to perform inversions
                          % for each wind data type
                          
                          Q = Q';

                          bwspd = R \ ( Q*( w.*wspdtmpsel ) );
                          bstrm = R \ ( Q*( w.*strmtmpsel ) );
                          bu    = R \ ( Q*( w.*utmpsel ) );
                          bv    = R \ ( Q*( w.*vtmpsel ) );
                          bustr = R \ ( Q*( w.*ustrtmpsel ) );
                          bvstr = R \ ( Q*( w.*vstrtmpsel ) );

                          % Remove gridded estimates that are outside the max/min range
                          % of the points used in the estimation. Use this criteria
                          % for the derivatives as well since this is the only way
                          % to check them.

                          if bwspd(1) >= min(wspdtmpsel)-1.3 & ...
                             bwspd(1) <= max(wspdtmpsel)+1.3,

                             grid_wspd(j,i)    = max(0,bwspd(1));
                             grid_dwspddx(j,i) = bwspd(2);
                             grid_dwspddy(j,i) = bwspd(3);

                          end

                          if bstrm(1) >= min(strmtmpsel)-0.03 & ...
                             bstrm(1) <= max(strmtmpsel)+0.03,

                             grid_strm(j,i)    = max(0,bstrm(1));
                             grid_dstrmdx(j,i) = bstrm(2);
                             grid_dstrmdy(j,i) = bstrm(3);

                          end

                          if bu(1) >= min(utmpsel)-1.3 & ...
                             bu(1) <= max(utmpsel)+1.3,

                             grid_u(j,i)       = bu(1);
                             grid_dudx(j,i)    = bu(2);
                             grid_dudy(j,i)    = bu(3);

                          end

                          if bv(1) >= min(vtmpsel)-1.3 & ...
                             bv(1) <= max(vtmpsel)+1.3,

                             grid_v(j,i)       = bv(1);
                             grid_dvdx(j,i)    = bv(2);
                             grid_dvdy(j,i)    = bv(3);

                          end

                          if bustr(1) >= min(ustrtmpsel)-0.03 & ...
                             bustr(1) <= max(ustrtmpsel)+0.03,

                             grid_ustr(j,i)    = bustr(1);
                             grid_dustrdx(j,i) = bustr(2);
                             grid_dustrdy(j,i) = bustr(3);

                          end

                          if bvstr(1) >= min(vstrtmpsel)-0.03 & ...
                             bvstr(1) <= max(vstrtmpsel)+0.03,

                             grid_vstr(j,i)    = bvstr(1);
                             grid_dvstrdx(j,i) = bvstr(2);
                             grid_dvstrdy(j,i) = bvstr(3);

                          end

                          clear xin

                     end
                  end
               end
	        end           
         end
      end
   end  
end

%keyboard

return




if 0,
if 0,
tmpglon = orbit_lon(:);
tmpglat = orbit_lat(:);
tmpgwspd = orbit_wspd(:);
tmpgstrm = orbit_strm(:);
tmpgu = orbit_u(:);
tmpgv = orbit_v(:);
tmpgustr = orbit_ustr(:);
tmpgvstr = orbit_vstr(:);

inotbad = ~isnan(tmpgwspd+tmpglon+tmpglat+tmpgstrm+tmpgu+tmpgv);
tmpglon = tmpglon(inotbad);
tmpglat = tmpglat(inotbad);
tmpgwspd = tmpgwspd(inotbad);
tmpgstrm = tmpgstrm(inotbad);
tmpgu = tmpgu(inotbad);
tmpgv = tmpgv(inotbad);
tmpgustr = tmpgustr(inotbad);
tmpgvstr = tmpgvstr(inotbad);
% Moved this step to GRID_QSCAT_REGION with the ice removal

if 0,
inotbad = ~isnan(orbit_lon+orbit_lat+orbit_wspd+orbit_strm+ ...
                 orbit_u+orbit_v+orbit_ustr+orbit_vstr);

tmpglon = orbit_lon(inotbad);
tmpglat = orbit_lat(inotbad);
tmpgwspd = orbit_wspd(inotbad);
tmpgstrm = orbit_strm(inotbad);
tmpgu = orbit_u(inotbad);
tmpgv = orbit_v(inotbad);
tmpgustr = orbit_ustr(inotbad);
tmpgvstr = orbit_vstr(inotbad);
end
end

grid_wspd = NAN_MATRIX;
grid_dwspddx = NAN_MATRIX;
grid_dwspddy = NAN_MATRIX;

grid_strm = NAN_MATRIX;
grid_dstrmdx = NAN_MATRIX;
grid_dstrmdy = NAN_MATRIX;

grid_u = NAN_MATRIX;
grid_dudx = NAN_MATRIX;
grid_dudy = NAN_MATRIX;

grid_v = NAN_MATRIX;
grid_dvdx = NAN_MATRIX;
grid_dvdy = NAN_MATRIX;

grid_ustr = NAN_MATRIX;
grid_dustrdx = NAN_MATRIX;
grid_dustrdy = NAN_MATRIX;

grid_vstr = NAN_MATRIX;
grid_dvstrdx = NAN_MATRIX;
grid_dvstrdy = NAN_MATRIX;
end