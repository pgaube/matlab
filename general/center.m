%Copyright Peter Gaube 1.17.2006
%must use equal size and dim matrices.  can use NaN data
%function [V,Z,Xbar,sdX,sd_data]=center(data)

function [V,Z,Xbar,sdX,sd_data]=center(data)

[M,N,P] = size(data);

Xbar=nan(M,N);
sdX=nan(M,N);
Z=nan(M,N,P);


    for m = 1:M
        for n = 1:N            
            i = find(~isnan(data(m,n,:)));
            if length(i)>0
           		
           		%assign x variables to data
           		Xbar(m,n) = mean(data(m,n,i));
           		sdX(m,n) = std(data(m,n,i));
           		Z(m,n,i)=data(m,n,i)-Xbar(m,n);
            
            end
        end
    end
    
vec = Z(:);
i = find(~isnan(vec));
sd_data = std(vec(i));
V = Z ./ sd_data;
