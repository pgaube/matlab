%Removes the seaonal harmonic from sCHL data.

[M,N,P] = size(sCHL);

fit=nan(M,N,P);
amp=nan(M,N);
phase=nan(M,N);
rsq=nan(M,N);


for m = 1:length(sCHL(:,1,1))
    for n = 1:length(sCHL(1,:,1))
        x=sCHL(m,n,:);
        x=x(:);
        i = find(isnan(x));
        if length(i)<500
                    x= interpnan(x,1);
                    [fit(m,n,:),amp(m,n),phase(m,n),rsq(m,n)] = harmonic(x,1:509,52.1429);
        end
    end
end


