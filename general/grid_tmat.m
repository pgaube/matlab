function grid_ctt= grid_tmat(tmpglon,tmpglat,tmpgctt);


global SPAN2 SPAN2HALF C CR
global NPTS_SPAN_THRESHOLD NPTS_HALFSPAN_THRESHOLD
global NPTS_NORTH NPTS_SOUTH NPTS_EAST NPTS_WEST
global RADIAL_SPAN
global DX_OVERLAP
global GRIDX GRIDY

%----------------------------------------------------------------------------

grid_ctt = nan(length(GRIDY),length(GRIDX));

%----------------------------------------------------------------------------
%This function grids the L2 data using the tri-cubic weighting function
%----------------------------------------------------------------------------


locy = tmpglat(:);
locx = tmpglon(:);
dats = tmpgctt(:);

lats=GRIDY;
lons=GRIDX;

bdat  = nan(length(lats),1);

rows = 1:length(lats);
cols = 1:length(lons);

xdist = CR*cos(C*locy); %Takes care of xdist dependance on latitude

for n = cols
    dx = (locx-lons(n)).*xdist;
    dx2 = dx.^2;
        
    igoodx = dx2<=SPAN2;
    
    if any(igoodx)                   %check to see if any rows in cols(n)
                                     %fall with in range or SPAN2
        dxtmp   =  dx(igoodx);
        dx2tmp  =  dx2(igoodx);
        locytmp  =  locy(igoodx);
        dattmp  =  dats(igoodx);
        
        for m = rows
            dytmp   = CR*(locytmp-lats(m)); % y-distance b/w
                                            % grid pt and obs pts
            dy2tmp  = dytmp.^2;
            
            igoody = dy2tmp<=SPAN2;
            if any(igoody),
                d2      = dx2tmp + dy2tmp;  % Total squared distance between grid
                                            % pt and observation pts
                igoodxy = d2 <= SPAN2;
                ngood   = sum(igoodxy);
        
                if ngood >= NPTS_SPAN_THRESHOLD  %Check to see if there are
                                                 %enought points to make
                                                 %an est at the grid point
            
                    d2sel = d2(igoodxy);
                    iwithinhalfspan = d2sel<=SPAN2HALF;
            
                    if sum(iwithinhalfspan) >= NPTS_HALFSPAN_THRESHOLD,
                
                        dxtmpsel = dxtmp(igoodxy);
                        dytmpsel = dytmp(igoodxy);
                
                        %
                        % Test whether grid point is surrounded by obs points
                        %
                
                        if sum(dxtmpsel>0)>=NPTS_EAST  & ...
                           sum(dxtmpsel<0)>=NPTS_WEST  & ...
                           sum(dytmpsel>0)>=NPTS_NORTH & ...
                           sum(dytmpsel<0)>=NPTS_SOUTH

                            % Select observations within specified distance
                            % to the grid point
                    
                            dx2tmpsel  = dx2tmp(igoodxy);
                            dy2tmpsel  = dy2tmp(igoodxy);
                            dattmpsel  = dattmp(igoodxy);
                            
                            %{
                            inonnan = find(~isnan(dattmpsel));
                            dx2tmpsel  = dx2tmpsel(inonnan);
                            dy2tmpsel  = dy2tmpsel(inonnan);
                            dattmpsel  = dattmpsel(inonnan);
                            d2sel = d2sel(inonnan);
                            dxtmpsel  = dxtmpsel(inonnan);
                            dytmpsel  = dytmpsel(inonnan);
                            %}

                            %grid_ctt(m,n) = nanmean(dattmpsel);
                            % Calculate the std of dattmpsel to check
                            % data after regression
                            
                            tmpstd=pstd(dattmpsel);

                            % Weight observations based on distance from grid
                            % point using the tricubic weighting function
                    
                            %w = ( 1 - (d2sel/SPAN2).^1.5 ).^3; 
                            w = 1 - (d2sel/SPAN2).*sqrt(d2sel/SPAN2);
                            %w = 1 - d2sel.*sqrt(d2sel);
                            w = w.*w.*w;
                    
                            % Build matrix for the loess regression of
                            % observations based on distance (dx,dy)
                            % from the grid point
                    
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
                            % for dat
                    
                            Q = Q';
                    
                            tmpg = R \ ( Q*( w.*dattmpsel) );
                            
                            %{
                            if tmpg(1) < min(dattmpsel)-(2*tmpstd) | ...
                                    tmpg(1) > max(dattmpsel)+(2*tmpstd),
                                grid_ctt(m,n) = nan;
                            else
                                grid_ctt(m,n) = tmpg(1);
                            end
                            %}
                            grid_ctt(m,n) = tmpg(1);
                            clear Q R xin w
                            end
                        end
                     end
                 end
              end      
           end
        end   
     end   
