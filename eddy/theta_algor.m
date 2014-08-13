%calculates the angle of the C vector for each time step of each eddy and flags the eddy based
% off of the number of times the eddy's C exceeds theta_o

theta=nan(size(id));
unid=unique(id);
tflag=nan(size(unid));

for m=1:length(unid)
	ii = find(id==unid(m));
	theta(ii(1))=0;
	for n=2:length(ii)
		theta(ii(n)) = atand(-(y(ii(n))-y(ii(n-1)))/(x(ii(n))-x(ii(n-1))));
	end
	
	tflag(m) = 1/length(theta(ii))*nansum(abs(theta(ii)));
end

