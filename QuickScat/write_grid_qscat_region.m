function write_grid_qscat_region(grid_wspd, grid_dwspddx, grid_dwspddy, ...
                                 grid_strm, grid_dstrmdx, grid_dstrmdy, ...
	                             grid_u, grid_dudx, grid_dudy, ...
	                             grid_v, grid_dvdx, grid_dvdy, ...
	                             grid_ustr, grid_dustrdx, grid_dustrdy, ...
	                             grid_vstr, grid_dvstrdx, grid_dvstrdy, ...
				                 woutfile)

global IX IY

%nx = length(gridx);
%ny = length(gridy);

%[IX,IY] = meshgrid(1:nx,1:ny);

igood = ~isnan(grid_wspd+grid_dwspddx+grid_dwspddy+grid_strm+grid_dstrmdx+...
               grid_dstrmdy+grid_u+grid_dudx+grid_dudy+grid_v+grid_dvdx+ ...
	           grid_dvdy+grid_ustr+grid_dustrdx+grid_dustrdy+grid_vstr+ ...
	           grid_dvstrdx+grid_dvstrdy);


[fp,msg] = fopen(woutfile,'w');
if fp==-1,
   error(['WRITE_GRID_QSCAT_REGION: Error writing gridded file. \n',msg])
end

fprintf( fp, '%6i\n' , sum(sum(igood)) );
fprintf( fp, '%1i\n' , IX(igood) );
fprintf( fp, '%1i\n' , IY(igood) );
fprintf( fp, '%1i\n' , round( 1e2 * grid_wspd(igood)));
fprintf( fp, '%1i\n' , round( 1e7 * grid_dwspddx(igood)));
fprintf( fp, '%1i\n' , round( 1e7 * grid_dwspddy(igood)));
fprintf( fp, '%1i\n' , round( 1e3 * grid_strm(igood)));
fprintf( fp, '%1i\n' , round( 1e9 * grid_dstrmdx(igood)));
fprintf( fp, '%1i\n' , round( 1e9 * grid_dstrmdy(igood)));
fprintf( fp, '%1i\n' , round( 1e2 * grid_u(igood)));
fprintf( fp, '%1i\n' , round( 1e7 * grid_dudx(igood)));
fprintf( fp, '%1i\n' , round( 1e7 * grid_dudy(igood)));
fprintf( fp, '%1i\n' , round( 1e2 * grid_v(igood)));
fprintf( fp, '%1i\n' , round( 1e7 * grid_dvdx(igood)));
fprintf( fp, '%1i\n' , round( 1e7 * grid_dvdy(igood)));
fprintf( fp, '%1i\n' , round( 1e3 * grid_ustr(igood)));
fprintf( fp, '%1i\n' , round( 1e9 * grid_dustrdx(igood)));
fprintf( fp, '%1i\n' , round( 1e9 * grid_dustrdy(igood)));
fprintf( fp, '%1i\n' , round( 1e3 * grid_vstr(igood)));
fprintf( fp, '%1i\n' , round( 1e9 * grid_dvstrdx(igood)));
fprintf( fp, '%1i\n' , round( 1e9 * grid_dvstrdy(igood)));

fclose(fp);

return



















%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if 0,
fprintf( fp,'%-6.0f',sum(sum(igood)) );
fprintf( fp,'%-3.0f',IX(igood) );
fprintf( fp,'%-3.0f',IY(igood) );
fprintf( fp,'%-6.0f',round( 1e2 * grid_wspd(igood)));
fprintf( fp,'%-6.0f',round( 1e7 * grid_dwspddx(igood)));
fprintf( fp,'%-6.0f',round( 1e7 * grid_dwspddy(igood)));
fprintf( fp,'%-6.0f',round( 1e3 * grid_strm(igood)));
fprintf( fp,'%-6.0f',round( 1e9 * grid_dstrmdx(igood)));
fprintf( fp,'%-6.0f',round( 1e9 * grid_dstrmdy(igood)));
fprintf( fp,'%-6.0f',round( 1e2 * grid_u(igood)));
fprintf( fp,'%-6.0f',round( 1e7 * grid_dudx(igood)));
fprintf( fp,'%-6.0f',round( 1e7 * grid_dudy(igood)));
fprintf( fp,'%-6.0f',round( 1e2 * grid_v(igood)));
fprintf( fp,'%-6.0f',round( 1e7 * grid_dvdx(igood)));
fprintf( fp,'%-6.0f',round( 1e7 * grid_dvdy(igood)));
fprintf( fp,'%-6.0f',round( 1e3 * grid_ustr(igood)));
fprintf( fp,'%-6.0f',round( 1e9 * grid_dustrdx(igood)));
fprintf( fp,'%-6.0f',round( 1e9 * grid_dustrdy(igood)));
fprintf( fp,'%-6.0f',round( 1e3 * grid_vstr(igood)));
fprintf( fp,'%-6.0f',round( 1e9 * grid_dvstrdx(igood)));
fprintf( fp,'%-6.0f',round( 1e9 * grid_dvstrdy(igood)));
end

if 0,

   fprintf(fp,'%-6.0f',sum(sum(igood)));
   fprintf(fp,'%-3.0f',IX(igood));
   fprintf(fp,'%-3.0f',IY(igood));
   fprintf(fp,'%-4.0f',round(1e2*grid_wspd(igood)));
   fprintf(fp,'%-4.0f',round(1e7*grid_dwspddx(igood)));
   fprintf(fp,'%-4.0f',round(1e7*grid_dwspddy(igood)));
   fprintf(fp,'%-4.0f',round(1e3*grid_strm(igood)));
   fprintf(fp,'%-4.0f',round(1e10*grid_dstrmdx(igood)));
   fprintf(fp,'%-4.0f',round(1e10*grid_dstrmdy(igood)));
   fprintf(fp,'%-4.0f',round(1e2*grid_u(igood)));
   fprintf(fp,'%-4.0f',round(1e7*grid_dudx(igood)));
   fprintf(fp,'%-4.0f',round(1e7*grid_dudy(igood)));
   fprintf(fp,'%-4.0f',round(1e2*grid_v(igood)));
   fprintf(fp,'%-4.0f',round(1e7*grid_dvdx(igood)));
   fprintf(fp,'%-4.0f',round(1e7*grid_dvdy(igood)));
   fprintf(fp,'%-4.0f',round(1e3*grid_ustr(igood)));
   fprintf(fp,'%-4.0f',round(1e10*grid_dustrdx(igood)));
   fprintf(fp,'%-4.0f',round(1e10*grid_dustrdy(igood)));
   fprintf(fp,'%-4.0f',round(1e3*grid_vstr(igood)));
   fprintf(fp,'%-4.0f',round(1e10*grid_dvstrdx(igood)));
   fprintf(fp,'%-4.0f',round(1e10*grid_dvstrdy(igood)));

end
