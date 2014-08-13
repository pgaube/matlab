function sst = get_sst ( day )

v = datevec( datestr( day ) );
name = [ 'sst4-navy-eot.' num2str(v(1),4) num2str(v(2),'%02u') ...
	num2str(v(3),'%02u') '.nc' ];

eval(['!makecopy.csh ' name])

Reynolds = netcdf( ['scratch/' name], 'nowrite' );

time = Reynolds{'time'}(:); %Days since Jan 1, 1978 00:00

n_sst = Reynolds{'sst'};
sst = n_sst(:,:);

sst_att = att(n_sst);
fill = sst_att{3}(:);
offset = sst_att{4}(:);
scale = sst_att{5}(:);

sst(find(sst==fill)) = NaN;
sst = sst*scale;

eval([ '!rm scratch/' name ]);
