function test_nc_info ( )

fprintf ( 1, 'NC_INFO:  starting test suite...\n' );
run_local_nc3_tests;
run_http_tests;
return


function run_http_tests()
	if getpref('SNCTOOLS','USE_JAVA',false) && getpref('SNCTOOLS','TEST_HTTP',false)
		fprintf ('\trunning http/java tests...\n' );
		test_javaNcid;
	else
		fprintf('\tHTTP testing filtered out where USE_JAVA and TEST_HTTP preferences not both set.\n');
	end
return

function run_local_nc3_tests()
fprintf ('\trunning local netcdf-3 tests...\n' );
test_noInputs;
test_tooManyInputs;
test_fileNotNetcdf;
test_emptyNetcdfFile;
test_dimsButNoVars;
test_smorgasborg;
return


function test_javaNcid ()
	import ucar.nc2.dods.*     
	import ucar.nc2.*          
                           
    url = 'http://coast-enviro.er.usgs.gov/models/share/balop.nc';
	jncid = NetcdfFile.open(url);
    info = nc_info ( jncid );
	close(jncid);
return




function test_noInputs( )
try
	nc = nc_info;
	error ( 'succeeded when it should have failed.\n'  );
end
return





function test_tooManyInputs ( )
ncfile = 'testdata/empty.nc';
try
	nc = nc_info ( ncfile, 'blah' );
	msg = sprintf ( '%s:   succeeded when it should have failed.\n', mfilename  );
	error ( msg );
end
return





function test_fileNotNetcdf()
ncfile = mfilename;
try
	nc = nc_info ( ncfile );
	error ( 'succeeded when it should have failed.' );
end
return







function test_emptyNetcdfFile ( )

ncfile = 'testdata/empty.nc';

nc = nc_info ( ncfile );
if ~strcmp ( nc.Filename, ncfile )
	msg = sprintf ( '%s:  :  Filename was wrong.\n', mfilename  );
	error ( msg );
end
if ( length ( nc.Dimension ) ~= 0 )
	msg = sprintf ( '%s:  :  Dimension was wrong.\n', mfilename  );
	error ( msg );
end
if ( length ( nc.Dataset ) ~= 0 )
	msg = sprintf ( '%s:  :  Dataset was wrong.\n', mfilename  );
	error ( msg );
end
if ( length ( nc.Attribute ) ~= 0 )
	msg = sprintf ( '%s:  :  Attribute was wrong.\n', mfilename  );
	error ( msg );
end
return









function test_dimsButNoVars ( )

ncfile = 'testdata/just_one_dimension.nc';

nc = nc_info ( ncfile );
if ~strcmp ( nc.Filename, ncfile )
	msg = sprintf ( '%s:  :  Filename was wrong.\n', mfilename  );
	error ( msg );
end
if ( length ( nc.Dimension ) ~= 1 )
	msg = sprintf ( '%s:  :  Dimension was wrong.\n', mfilename  );
	error ( msg );
end
if ( length ( nc.Dataset ) ~= 0 )
	msg = sprintf ( '%s:  :  Dataset was wrong.\n', mfilename  );
	error ( msg );
end
if ( length ( nc.Attribute ) ~= 0 )
	msg = sprintf ( '%s:  :  Attribute was wrong.\n', mfilename  );
	error ( msg );
end
return










function test_smorgasborg ( )

ncfile = 'testdata/full.nc';

nc = nc_info ( ncfile );
if ~strcmp ( nc.Filename, ncfile )
	msg = sprintf ( '%s:  :  Filename was wrong.\n', mfilename  );
	error ( msg );
end
if ( length ( nc.Dimension ) ~= 5 )
	msg = sprintf ( '%s:  :  Dimension was wrong.\n', mfilename  );
	error ( msg );
end
if ( length ( nc.Dataset ) ~= 6 )
	msg = sprintf ( '%s:  :  Dataset was wrong.\n', mfilename  );
	error ( msg );
end
if ( length ( nc.Attribute ) ~= 1 )
	msg = sprintf ( '%s:  :  Attribute was wrong.\n', mfilename  );
	error ( msg );
end
return






