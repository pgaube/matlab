function Dataset = nc_getvarinfo ( arg1, arg2 )
% NC_GETVARINFO:  returns metadata about a specific NetCDF variable
%
% VINFO = NC_GETVARINFO(NCFILE,VARNAME) returns a metadata structure VINFO about
% the variable VARNAME in the netCDF file NCFILE.
%
% VINFO = NC_GETVARINFO(NCID,VARID) returns a metadata structure VINFO about
% the variable whose netCDF variable-id is VARID, and whose parent file-id is 
% NCID.  The netCDF file is assumed to be open, and in this case the file will
% not be closed upon completion.
%
% VINFO will have the following fields:
%
%    Name:  
%       a string containing the name of the variable.
%    Nctype:  
%       a string specifying the NetCDF datatype of this variable.
%    Unlimited:  
%       Flag, either 1 if the variable has an unlimited dimension or 0 if not.
%    Dimensions:  
%       a cell array with the names of the dimensions upon which this variable 
%       depends.
%    Attribute:  
%       An array of structures corresponding to the attributes defined for the 
%       specified variable.
%                         
%    Each "Attribute" element contains the following fields.
%
%       Name:  
%           a string containing the name of the attribute.
%       Nctype:  
%           a string specifying the NetCDF datatype of this attribute.
%       Attnum:  
%           a scalar specifying the attribute id
%       Value: 
%           either a string or a double precision value corresponding to the 
%           value of the attribute
%
% In case of an error, an exception is thrown.
%
%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% $Id: nc_getvarinfo.m 2754 2009-06-29 13:26:18Z johnevans007 $
% $LastChangedDate: 2009-06-29 09:26:18 -0400 (Mon, 29 Jun 2009) $
% $LastChangedRevision: 2754 $
% $LastChangedBy: johnevans007 $
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




% Show usage if too few arguments.
error(nargchk(2,2,nargin,'struct'));
error(nargoutchk(1,1,nargout,'struct'));

backend = snc_read_backend(arg1);
switch(backend)
	case 'hdf5'
		Dataset = nc_getvarinfo_hdf5(arg1,arg2);
	case 'tmw'
		Dataset = nc_getvarinfo_tmw(arg1,arg2);
	case 'java'
		Dataset = nc_getvarinfo_java(arg1,arg2);
	case 'mexnc'
		Dataset = nc_getvarinfo_mexnc(arg1,arg2);
	otherwise
		error('SNCTOOLS:nc_info:unhandledBackend', ...
		      '%s is not a recognized backend.', backend);
end










