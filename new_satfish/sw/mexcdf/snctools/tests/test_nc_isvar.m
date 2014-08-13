function test_nc_isvar ( )

fprintf ( 1, 'NC_ISVAR:  starting test suite...\n' );
run_local_tests;
run_java_tests;

return


function run_local_tests()
	fprintf('\tRunning local tests...\n' );
	test_noArgs             ( 'testdata/empty.nc' );
	test_oneArg             ( 'testdata/empty.nc' );
	test_tooManyArgs        ( 'testdata/empty.nc' );
	test_varnameNotChar ;
	test_notNetcdfFile      ( 'testdata/empty.nc' );
	test_emptyFile          ( 'testdata/empty.nc' );
	test_dimsButNoVars      ( 'testdata/empty.nc' );
	test_variableNotPresent ( 'testdata/full.nc' );
	test_variablePresent    ( 'testdata/full.nc' );
return


function run_java_tests()
	if ~getpref('SNCTOOLS','USE_JAVA',false)
		fprintf ( '\tjava backend testing filtered out on configurations where SNCTOOLS ''USE_JAVA'' prefererence is false.\n' );
		return
	end
	fprintf('\tRunning java tests...\n' );
	test_javaNcid ;
return



function test_noArgs ( ncfile )

try
	nc = nc_isvar;
	msg = sprintf ( '%s:  succeeded when it should have failed.\n', mfilename );
	error ( msg );
end
return









function test_oneArg ( ncfile )

try
	nc = nc_isvar ( ncfile );
	msg = sprintf ( '%s:  succeeded when it should have failed.\n', mfilename );
	error ( msg );
end
return










function test_tooManyArgs ( ncfile )

try
	nc = nc_isvar ( ncfile, 'blah', 'blah2' );
	msg = sprintf ( '%s:  succeeded when it should have failed.\n', mfilename );
	error ( msg );
end
return









function test_varnameNotChar( )

ncfile = 'testdata/empty.nc';
try
	nc = nc_isvar ( ncfile, 5 );
	msg = sprintf ( '%s:  succeeded when it should have failed.\n', mfilename );
	error ( msg );
end
return













function test_notNetcdfFile ( ncfile )

% test 5:  not a netcdf file
try
	nc = nc_isvar ( mfilename, 't' );
	msg = sprintf ( '%s:  %s succeeded when it should have failed.\n', mfilename, testid );
	error ( msg );
end
return










function test_emptyFile ( ncfile )

yn = nc_isvar ( ncfile, 't' );
if ( yn == 1 )
	msg = sprintf ( '%s:  incorrectly classified.\n', mfilename );
	error ( msg );
end
return











function test_dimsButNoVars ( ncfile )

yn = nc_isvar ( ncfile, 't' );
if ( yn == 1 )
	msg = sprintf ( '%s:  incorrectly classified.\n', mfilename );
	error ( msg );
end
return













function test_variableNotPresent ( ncfile )


b = nc_isvar ( ncfile, 'y' );
if ( b ~= 0 )
	msg = sprintf ( '%s:  incorrect result.\n', mfilename );
	error ( msg );
end
return











function test_variablePresent ( ncfile )



b = nc_isvar ( ncfile, 't' );
if ( b ~= 1 )
	msg = sprintf ( '%s:   incorrect result.\n', mfilename );
	error ( msg );
end
return


function test_javaNcid ( )
% Ensure that NC_ISVAR works on an opened java file.

import ucar.nc2.dods.*     
import ucar.nc2.*          
                           
url = 'http://coast-enviro.er.usgs.gov/models/share/balop.nc';
jncid = NetcdfFile.open(url);

b = nc_isvar ( jncid, 'zeta' );
if ( b ~= 1 )
	msg = sprintf ( '%s:   incorrect result.\n', mfilename );
	error ( msg );
end
close(jncid);
return
