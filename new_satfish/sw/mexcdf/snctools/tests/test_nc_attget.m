function test_nc_attget ( )

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% $Id: test_nc_attget_attput.m 2394 2007-11-08 13:27:30Z johnevans007 $
% $LastChangedDate: 2007-11-08 08:27:30 -0500 (Thu, 08 Nov 2007) $
% $LastChangedRevision: 2394 $
% $LastChangedBy: johnevans007 $
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fprintf ( 1, 'NC_ATTGET:  starting test suite...\n' );

run_nc3_tests;
run_nc4_hdf5_tests;
run_nc4_java_tests;
run_http_tests;



function run_nc3_tests()
	fprintf('\tRunning local netcdf-3 tests.\n');
	ncfile = 'testdata/attget.nc';
	run_local_tests(ncfile);
return

function run_nc4_hdf5_tests()
	if release_ne_r2009a
		fprintf('\thdf5 backend testing filtered out on matlab versions less than R2009a.\n');
		return
	end
	if ~getpref('SNCTOOLS','TEST_NC4HDF5',false)
		fprintf('\tnc4hdf5 backend testing filtered out on configurations where SNCTOOLS ''USE_NC4HDF5'' prefererence is false.\n');
		return
	end
	fprintf('\tRunning local netcdf4/hdf5 tests.\n');
	ncfile = 'testdata/attget-4.nc';
	run_local_tests(ncfile);
return


function run_nc4_java_tests()
	if ~release_ne_r2009a
		fprintf('\tjava nc4 backend testing filtered out on matlab versions greater than R2009a.\n');
		return
	end
	if ~getpref('SNCTOOLS','USE_JAVA',false)
		fprintf('\tjava nc4 backend testing filtered out on configurations where SNCTOOLS ''USE_JAVA'' prefererence is false.\n');
		return
	end
	fprintf('\tRunning local netcdf4/java tests.\n');
	ncfile = 'testdata/attget-4.nc';
	run_local_tests(ncfile);
return








function run_local_tests(ncfile)

test_retrieveDoubleAttribute ( ncfile );
test_retrieveFloatAttribute ( ncfile );
test_retrieveIntAttribute ( ncfile );
test_retrieveShortAttribute ( ncfile );
test_retrieveUint8Attribute ( ncfile );
test_retrieveInt8Attribute ( ncfile );
test_retrieveTextAttribute ( ncfile );

test_retrieveGlobalAttribute_empty ( ncfile );
test_writeRetrieveGlobalAttributeMinusOne ( ncfile );
test_writeRetrieveGlobalAttributeNcGlobal ( ncfile );
test_writeRetrieveGlobalAttributeGlobalName ( ncfile );

% Tests expected to fail.
test_retrieveNonExistingAttribute ( ncfile );

return;


function run_http_tests()
	% These tests are regular URLs, not OPeNDAP URLs.
	if ~ ( getpref ( 'SNCTOOLS', 'USE_JAVA', false ) )
		fprintf('=tjava http backend testing filtered out when SNCTOOLS ''USE_JAVA'' preference is false.\n');
		return
	end
	if ~ ( getpref ( 'SNCTOOLS', 'TEST_REMOTE', false ) )
		fprintf('\tjava http backend testing filtered out when SNCTOOLS ''TEST_REMOTE'' preference is false.\n');
		return
	end
	fprintf('\tRunning http/java tests.\n');
	test_retrieveAttribute_HTTP;
	test_retrieveAttribute_http_jncid;
return





return




function test_retrieveAttribute_HTTP ()

url = 'http://rocky.umeoce.maine.edu/GoMPOM/cdfs/gomoos.20070723.cdf';

w = nc_attget ( url, 'w', 'valid_range' );
if ~strcmp(class(w),'single')
	error ( 'Class of retrieve attribute was not single' );
end
if (abs(double(w(2)) - 0.5) > eps)
	error ( 'valid max did not match' );
end
if (abs(double(w(1)) + 0.5) > eps)
	error ( 'valid max did not match' );
end
return


function test_retrieveAttribute_http_jncid ()

import ucar.nc2.dods.*     
import ucar.nc2.*          

url = 'http://rocky.umeoce.maine.edu/GoMPOM/cdfs/gomoos.20070723.cdf';
jncid = NetcdfFile.open(url);
                           

w = nc_attget (jncid, 'w', 'valid_range' );
if ~strcmp(class(w),'single')
	error ( 'Class of retrieve attribute was not single' );
end
if (abs(double(w(2)) - 0.5) > eps)
	error ( 'valid max did not match' );
end
if (abs(double(w(1)) + 0.5) > eps)
	error ( 'valid max did not match' );
end
close(jncid);
return


function test_retrieveIntAttribute ( ncfile )

attvalue = nc_attget ( ncfile, 'x_db', 'test_int_att' );
if ( ~strcmp(class(attvalue), 'int32' ) )
	msg = sprintf ( '%s:  class of retrieved attribute was not int32.\n', mfilename );
	error ( msg );
end
if ( attvalue ~= int32(3) )
	msg = sprintf ( '%s:  retrieved attribute differs from what was written.\n', mfilename);
	error ( msg );
end

return










function test_retrieveShortAttribute ( ncfile )


attvalue = nc_attget ( ncfile, 'x_db', 'test_short_att' );
if ( ~strcmp(class(attvalue), 'int16' ) )
	msg = sprintf ( '%s:  class of retrieved attribute was not int16.\n', mfilename );
	error ( msg );
end
if ( length(attvalue) ~= 2 )
	msg = sprintf ( '%s:  retrieved attribute length differs from what was written.\n', mfilename );
	error ( msg );
end
if ( any(double(attvalue) - [5 7])  )
	msg = sprintf ( '%s:  retrieved attribute differs from what was written.\n', mfilename  );
	error ( msg );
end

return








function test_retrieveUint8Attribute ( ncfile )

attvalue = nc_attget ( ncfile, 'x_db', 'test_uchar_att' );
if ( ~strcmp(class(attvalue), 'int8' ) )
	msg = sprintf ( '%s:  class of retrieved attribute was not int8.\n', mfilename );
	error ( msg );
end
if ( uint8(attvalue) ~= uint8(100) )
	msg = sprintf ( '%s:  retrieved attribute differs from what was written.\n', mfilename );
	error ( msg );
end

return




function test_retrieveInt8Attribute ( ncfile )

attvalue = nc_attget ( ncfile, 'x_db', 'test_schar_att' );
if ( ~strcmp(class(attvalue), 'int8' ) )
	msg = sprintf ( '%s:  class of retrieved attribute was not int8.\n', mfilename );
	error ( msg );
end
if ( attvalue ~= int8(-100) )
	msg = sprintf ( '%s:  %s:  retrieved attribute differs from what was written.\n', mfilename );
	error ( msg );
end

return







function test_retrieveTextAttribute ( ncfile )

attvalue = nc_attget ( ncfile, 'x_db', 'test_text_att' );
if ( ~strcmp(class(attvalue), 'char' ) )
	msg = sprintf ( '%s:  class of retrieved attribute was not char.\n', mfilename );
	error ( msg );
end

if ( ~strcmp(attvalue,'abcdefghijklmnopqrstuvwxyz') )
	msg = sprintf ( '%s:  retrieved attribute differs from what was written.\n', mfilename );
	error ( msg );
end

return







function test_retrieveGlobalAttribute_empty ( ncfile )

warning ( 'off', 'SNCTOOLS:nc_attget:java:doNotUseGlobalString' );
warning ( 'off', 'SNCTOOLS:nc_attget:hdf5:doNotUseEmptyVarname' );
warning ( 'off', 'SNCTOOLS:nc_attget:hdf5:doNotUseGlobalVarname' );

attvalue = nc_attget ( ncfile, '', 'test_double_att' );
if ( ~strcmp(class(attvalue), 'double' ) )
	msg = sprintf ( '%s:  class of retrieved attribute was not double.\n', mfilename );
	error ( msg );
end
if ( attvalue ~= 3.14159 )
	msg = sprintf ( '%s:  retrieved attribute differs from what was written.\n', mfilename );
	error ( msg );
end

warning ( 'on', 'SNCTOOLS:nc_attget:java:doNotUseGlobalString' );
warning ( 'off', 'SNCTOOLS:nc_attget:hdf5:doNotUseEmptyVarname' );
warning ( 'off', 'SNCTOOLS:nc_attget:hdf5:doNotUseGlobalVarname' );

return





function test_writeRetrieveGlobalAttributeMinusOne ( ncfile )

attvalue = nc_attget ( ncfile, -1, 'test_double_att' );
if ( ~strcmp(class(attvalue), 'double' ) )
	msg = sprintf ( '%s:  class of retrieved attribute was not double.\n', mfilename );
	error ( msg );
end
if ( attvalue ~= 3.14159 )
	msg = sprintf ( '%s:  retrieved attribute differs from what was written.\n', mfilename );
	error ( msg );
end

return





function test_writeRetrieveGlobalAttributeNcGlobal ( ncfile )

attvalue = nc_attget ( ncfile, nc_global, 'test_double_att' );
if ( ~strcmp(class(attvalue), 'double' ) )
	msg = sprintf ( '%s:  class of retrieved attribute was not double.\n', mfilename );
	error ( msg );
end
if ( attvalue ~= 3.14159 )
	msg = sprintf ( '%s:  retrieved attribute differs from what was written.\n', mfilename  );
	error ( msg );
end

return 






function test_writeRetrieveGlobalAttributeGlobalName ( ncfile )

warning ( 'off', 'SNCTOOLS:nc_attget:doNotUseGlobalString' );
warning ( 'off', 'SNCTOOLS:nc_attget:java:doNotUseGlobalString' );

attvalue = nc_attget ( ncfile, 'GLOBAL', 'test_double_att' );
if ( ~strcmp(class(attvalue), 'double' ) )
	msg = sprintf ( '%s:  class of retrieved attribute was not double.\n', mfilename );
	error ( msg );
end
if ( attvalue ~= 3.14159 )
	msg = sprintf ( '%s:  retrieved attribute differs from what was written.\n', mfilename  );
	error ( msg );
end

warning ( 'on', 'SNCTOOLS:nc_attget:java:doNotUseGlobalString' );
warning ( 'on', 'SNCTOOLS:nc_attget:doNotUseGlobalString' );

return





function test_retrieveNonExistingAttribute ( ncfile )

try
	attvalue = nc_attget ( ncfile, 'z_double', 'test_double_att' );
	msg = sprintf ( '%s:  %s:  nc_attget succeeded when it should have failed.\n', mfilename  );
	error ( msg );
end

return





















function test_retrieveDoubleAttribute ( ncfile )

attvalue = nc_attget ( ncfile, 'x_db', 'test_double_att' );
if ( ~strcmp(class(attvalue), 'double' ) )
	msg = sprintf ( '%s:  class of retrieved attribute was not double.\n', mfilename );
	error ( msg );
end
if ( attvalue ~= 3.14159 )
	msg = sprintf ( '%s:  retrieved attribute differs from what was written.\n', mfilename );
	error ( msg );
end

return







function test_retrieveFloatAttribute ( ncfile )

attvalue = nc_attget ( ncfile, 'x_db', 'test_float_att' );
if ( ~strcmp(class(attvalue), 'single' ) )
	msg = sprintf ( '%s:  class of retrieved attribute was not single.\n', mfilename );
	error ( msg );
end
if ( abs(double(attvalue) - 3.14159) > 1e-6 )
	msg = sprintf ( '%s:  retrieved attribute differs from what was written.\n', mfilename );
	error ( msg );
end

return

function tf = release_ne_r2009a
v = version('-release');
switch ( v ) 
	case { '11', '12', '13', '14', '2006a', '2006b', '2007a', ...
	       '2007b', '2008a', '2008b' }
		   tf = true;
	otherwise
		   tf= false;
end
return
