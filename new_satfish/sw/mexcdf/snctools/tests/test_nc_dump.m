function test_nc_dump ( )
% TEST_NC_DUMP:  runs series of tests for nc_dump.m
%
% Relies upon nc_add_dimension, nc_addvar, nc_attput
%
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% $Id: test_nc_dump.m 2783 2009-08-01 15:39:13Z johnevans007 $
% $LastChangedDate: 2009-08-01 11:39:13 -0400 (Sat, 01 Aug 2009) $
% $LastChangedRevision: 2783 $
% $LastChangedBy: johnevans007 $
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



negative_no_arguments;
negative_too_many_input_arguments ( 'testdata/empty.nc' );

empty_file              ( 'testdata/empty.nc' );
file_with_one_dimension ( 'testdata/just_one_dimension.nc' );
file_with_one_fixed_size_variable ( 'testdata/just_one_fixed_size_variable.nc' );
variable_attributes     ( 'testdata/full.nc' );
unlimited_variable      ( 'testdata/full.nc' );
singleton_variable      ( 'testdata/full.nc' );
nc4file                 ( 'testdata/tst_pres_temp_4D_netcdf4.nc' );

test_opendap_url;
test_http_non_dods;

fprintf ( 1, 'NC_DUMP:  all tests succeeded\n' );
return









function test_opendap_url ( ncfile )
if getpref ( 'SNCTOOLS', 'TEST_OPENDAP', false ) 
	url = 'http://motherlode.ucar.edu:8080/thredds/dodsC/satellite/CTP/SUPER-NATIONAL_1km/20090730/SUPER-NATIONAL_1km_CTP_20090730_2000.gini';
	fprintf ( 1, 'Testing remote DODS access %s...\n', url );
	nc_dump ( url );
else
	fprintf(1,'Not testing NC_DUMP on OPeNDAP URLs.  Read the README for details.\n');	
end
return

function test_http_non_dods ( ncfile )
if (getpref ( 'SNCTOOLS', 'USE_JAVA', false)  && ...
    getpref ( 'SNCTOOLS', 'TEST_REMOTE', false)  )
	url = 'http://coast-enviro.er.usgs.gov/models/share/balop.nc';
	fprintf ( 1, 'Testing remote URL access %s...\n', url );
	nc_dump ( url );
end




function negative_no_arguments ( )
% should fail if no input arguments are given.

fail = false;
try
	nc_dump;
	fail = true;
end
if fail
	error ( '%s:  nc_dump succeeded when it should have failed.\n', mfilename );
end
return





function negative_too_many_input_arguments ( ncfile )

failure = false;
try
	nc_dump ( ncfile, 'a', 'b' );
	failure = true;
end
if failure
	error ( '%s:  nc_dump succeeded when it should have failed.\n', mfilename );
end
return







function empty_file ( ncfile )

nc_dump ( ncfile );

return








function file_with_one_dimension ( ncfile )

nc_dump ( ncfile );
return





function file_with_one_fixed_size_variable ( ncfile )

nc_dump ( ncfile );
return




function variable_attributes ( ncfile )

nc_dump ( ncfile );
return




function unlimited_variable ( ncfile )

nc_dump ( ncfile );
return










function singleton_variable ( ncfile )

nc_dump ( ncfile );
return






function nc4file ( ncfile )

try
	nc_dump ( ncfile );
catch
	[msg,eid] = lasterr;
	switch ( eid )
		case 'SNCTOOLS:nc_info:javaRetrievalMethodNotAvailable'
			return
		case 'MATLAB:netcdf:open:notANetcdfFile'
			return
	end
end

return











