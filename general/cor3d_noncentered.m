%Copyright Peter Gaube 1.17.2006
%must use equal size and dim matrices
%function [cor,Xbar,Ybar,sdX,sdY]=cor3d(data1,data2)

%function [cor,msv1,msv2]=cor3d_noncentered(data1,data2)
function [cor,msv1,msv2]=cor3d_noncentered(data1,data2)


[M,N,P] = size(data1);

XS=nan*ones(M,N);
XX=nan*ones(M,N,P);
YS=nan*ones(M,N);
YY=nan*ones(M,N,P);
covar=nan*ones(M,N);
cor=nan*ones(M,N);

    for m = 1:length(data1(:,1,1))
        for n = 1:length(data1(1,:,1))            
            i = find(~isnan(data1(m,n,:)) & ~isnan(data2(m,n,:)));
            N(m,n) = length(i);
            if length(i)>0
            
            %calculate correlation of X and Y
            cor(m,n) = mean(data1(m,n,i).*data2(m,n,i))./((sqrt(mean(data1(m,n,i).^2))).*(sqrt(mean(data2(m,n,i).^2))));
            msv1(m,n) = sqrt(mean(data1(m,n,i).^2));
            msv2(m,n) = sqrt(mean(data2(m,n,i).^2));
            end
        end
    end
    

                                            
                                            