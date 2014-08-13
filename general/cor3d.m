%Copyright Peter Gaube 1.17.2006
%must use equal size and dim matrices
%function [cor,Xbar,Ybar,sdX,sdY]=cor3d(data1,data2)

%function [cor,Xbar,Ybar,sdX,sdY,XX,YY]=cor3d(data1,data2)
function [cor,Xbar,Ybar,sdX,sdY,XX,YY]=cor3d(data1,data2)


[M,N,P] = size(data1);

Xbar=nan*ones(M,N);
sdX=nan*ones(M,N);
XX=nan*ones(M,N,P);
Ybar=nan*ones(M,N);
sdY=nan*ones(M,N);
YY=nan*ones(M,N,P);
covar=nan*ones(M,N);
cor=nan*ones(M,N);

    for m = 1:length(data1(:,1,1))
        for n = 1:length(data1(1,:,1))            
            i = find(~isnan(data1(m,n,:)) & ~isnan(data2(m,n,:)));
            N(m,n) = length(i);
            if length(i)>0
            %assign x variables to data1
            Xbar(m,n) = mean(data1(m,n,i));
            sdX(m,n) = std(data1(m,n,i));
            XX(m,n,i)=data1(m,n,i)-Xbar(m,n);

            %assign y variables to data2
            Ybar(m,n) = mean(data2(m,n,i));
            sdY(m,n) = std(data2(m,n,i));
            YY(m,n,i)=data2(m,n,i)-Ybar(m,n);
    
            %Calculate covarance of X and Y
            covar(m,n) = mean(XX(m,n,i).*YY(m,n,i));
            
            %calculate correlation of X and Y
            cor(m,n) = covar(m,n)./(sdX(m,n).*sdY(m,n));
            end
        end
    end
    

                                            
                                            