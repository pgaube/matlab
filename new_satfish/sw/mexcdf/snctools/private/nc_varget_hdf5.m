function vardata = nc_varget_hdf5(ncfile,varname,start,count,stride)

vardata = h5varget(ncfile,varname,start,count,stride);

if (ndims(vardata) < 3) && ((size(vardata,1) == 1) || size(vardata,2) == 1)
	% force to be a column
	if size(vardata,1) == 1
    	vardata = reshape(vardata,size(vardata,2),1);
	end
else
	preserve_fvd = getpref('SNCTOOLS','PRESERVE_FVD',false);
    if ~preserve_fvd
        pv = fliplr ( 1:ndims(vardata) );
        vardata = permute(vardata,pv);
    end
end                                                                                   

return



