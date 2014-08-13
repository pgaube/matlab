%this script mean and STD of data containing NaNs
%function [bar,sd]=disdaily(data)

function [bar,sd]=descriptive(data)
for m = 1:length(data(:,1,1))
	for n = 1:length(data(1,:,1))            
        i = find(~isnan(data(m,n,:)));
        bar(m,n) = mean(data(m,n,i));
        sd(m,n) = std(data(m,n,i));
	end
end	

