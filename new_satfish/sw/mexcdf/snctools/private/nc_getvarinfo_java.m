function Dataset = nc_getvarinfo_java ( ncfile, varname )
%
% This function handles the java case.

import ucar.nc2.dods.*     % import opendap reader classes
import ucar.nc2.*          % have to import this (NetcdfFile) as well for local reads
                           

close_it = true;

%
% Try it as a local file.  If not a local file, try as
% via HTTP, then as dods
if isa(ncfile,'ucar.nc2.NetcdfFile')
	jncid = ncfile;
	close_it = false;
elseif isa(ncfile,'ucar.nc2.dods.DODSNetcdfFile')
	jncid = ncfile;
	close_it = false;
elseif exist(ncfile,'file')
	jncid = NetcdfFile.open(ncfile);
else
	try 
		jncid = NetcdfFile.open ( ncfile );
	catch %#ok<CTCH>
		try
			jncid = DODSNetcdfFile(ncfile);
		catch %#ok<CTCH>
			error ( 'SNCTOOLS:nc_varget_java:fileOpenFailure', ...
				'Could not open ''%s'' with java backend.' , ncfile);
		end
	end
end


jvarid = jncid.findVariable(varname);
if isempty(jvarid)
	close(jncid);
	msg = sprintf ('Could not locate variable %s', varname );
	error ( 'SNCTOOLS:NC_GETVARINFO:badVariableName', msg );
end


%
% All the details are hidden here because we need the exact same
% functionality in nc_info.
Dataset = snc_java_varid_info ( jvarid );


% If we were passed a java file id, don't close it upon exit.
if close_it
	close ( jncid );
end

return



